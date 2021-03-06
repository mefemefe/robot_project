*** Settings ***
Documentation    List Tests
Library          SeleniumLibrary
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource          trello/api/resources/Board.resource
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
    [Documentation]    verify that a list can be created in GUI
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Go To Board    TestBoard
    Create new list with the name    NEW_TEST_LIST
    Verify That The List Exists    NEW_TEST_LIST
    [Teardown]        Run Keywords
    ...               Wait Until Keyword Succeeds        ${DEFAULT_REPEAT}        ${DEFAULT_INTERVAL} seconds        Close a list
    ...               AND    Close Browser

modify name of a list
    [Documentation]    verify that a list name can be modified in GUI
    [Tags]    smoke    gui    list.update
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Go To Board    TestBoard
    Create new list with the name    TO_MODIFY
    Modify the name of a list with    TO_MODIFY    MODIFIED_LIST
    Verify That The List Exists    MODIFIED_LIST
    [Teardown]        Run Keywords
    ...               Wait Until Keyword Succeeds        ${DEFAULT_REPEAT}        ${DEFAULT_INTERVAL} seconds        Close a list
    ...               AND    Close Browser

archive a list
    [Documentation]    verify that a list can be archived in GUI
    [Tags]    smoke    gui    list.archive
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Go To Board    TestBoard
    Create new list with the name    TO_ARCHIVE
    Wait Until Keyword Succeeds        ${DEFAULT_REPEAT}        ${DEFAULT_INTERVAL} seconds       Close a list
    Enter to the side menu
    Enter to the list archive
    Verify That A List Is In The Archive    TO_ARCHIVE
    Close archive tab
    [Teardown]    Close Browser


*** Keywords ***
Setup Board
    [Documentation]    Creates a board and saves its ID
    ${BOARD}=    Create A Board    TestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]

Teardown Board
    [Documentation]    Deletes used board for teardown
    Wait Until Keyword Succeeds        ${DEFAULT_TIMEOUT}        ${DEFAULT_INTERVAL}        Delete A Board        ${TEST_SUITE_BOARD_ID}
