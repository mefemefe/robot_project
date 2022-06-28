*** Settings ***
Library          SeleniumLibrary
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource          tests/trello/api/resources/Board.resource
Resource          resources/components/ListComponent.resource
Resource         resources/components/ShownMenu.resource
Resource         resources/components/TopBar.resource
Resource         resources/components/CardModal.resource
Resource         resources/components/FilterModal.resource

Suite Setup       Run Keywords
...               Create Trello Session
...               Setup Board
Suite Teardown    Run Keywords
...               Teardown Board
...               Delete All Sessions

*** Test Cases ***
filter label
    [Tags]    smoke    gui    list.create
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Go To Board    TestBoard
    Create Card In List    To Do     card1
    Click pencil menu    To Do    card1
    Add Color Label In Card    yellow
    Create Card In List    Doing     card2
    Create Card In List    Done     card3
    Enter To Filter Menu
    Click no labels filter
    Card Should Not Be In List     card1    To Do
    Click no labels filter
    Card Should Be In List     card1    To Do

    [Teardown]    Run Keywords
...               Close Browser

*** Keywords ***
Setup Board
    ${BOARD}=    Create A Board    TestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]

Teardown Board
    Delete A Board    ${TEST_SUITE_BOARD_ID}