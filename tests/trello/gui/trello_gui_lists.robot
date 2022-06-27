*** Settings ***
Library          SeleniumLibrary
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource          tests/trello/api/resources/Board.resource

Resource          resources/components/ListComponent.resource
Resource         resources/components/ShownMenu.resource
Resource         resources/components/TopBar.resource
Suite Setup       Run Keywords
...               Create Trello Session
...               Setup Board
Suite Teardown    Run Keywords
...               Teardown Board
...               Delete All Sessions

*** Test Cases ***
create list
    [Tags]    smoke    gui    list.create
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Go To Board    TestBoard
    Create new list with the name    NEW_TEST_LIST
    Verify That The List Exists    NEW_TEST_LIST
    [Teardown]    Run Keywords
...               Close a list
...               Close Browser

modify name of a list
    [Tags]    smoke    gui    list.update
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Go To Board    TestBoard
    Create new list with the name    TO_MODIFY
    Modify the name of a list with    TO_MODIFY    MODIFIED_LIST
    Verify That The List Exists    MODIFIED_LIST
    [Teardown]    Run Keywords
...               Close a list
...               Close Browser

archive a list
    [Tags]    smoke    gui    list.archive
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Go To Board    TestBoard
    Create new list with the name    TO_ARCHIVE
    Close a list
    Enter to the side menu
    Enter to the list archive
    Verify That A List Is In The Archive    TO_ARCHIVE
    Close archive tab
    [Teardown]    Close Browser


*** Keywords ***
Setup Board
    ${BOARD}=    Create A Board    TestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]

Teardown Board
    Delete A Board    ${TEST_SUITE_BOARD_ID}