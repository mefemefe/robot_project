*** Settings ***
Library          SeleniumLibrary
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource         resources/Lists.resource
Resource          tests/trello/api/resources/Board.resource
Resource          tests/trello/api/resources/TrelloAPI.resource
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
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    NEW_TEST_LIST
    Element Text Should Be    ${NEW_LIST_HEADER}    NEW_TEST_LIST
    Close a list
    [Teardown]    Close Browser

modify name of a list
    [Tags]    smoke    gui    list.update
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    TO_MODIFY
    Modify the name of a list with    TO_MODIFY    MODIFIED_LIST
    Page Should Contain Element    ${TO_CHECK_LIST_HEADER}
    Close a list
    [Teardown]    Close Browser

archive a list
    [Tags]    smoke    gui    list.archive
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    TO_ARCHIVE
    Close a list
    Element Text Should Not Be    ${NEW_LIST_HEADER}    TO_ARCHIVE
    Enter to the list archive
    Page Should Contain Element    ${LIST_NAME_FIELD}
    Close archive tab
    [Teardown]    Close Browser

#move a list
#copy list
watch list
    [Tags]    smoke    gui    list.watch
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name       NEW_LIST
    Page Should Not Contain Element    ${LIST_WATCHED_HEADER}
    Click watch/unwatch button
    Page Should Contain Element        ${LIST_WATCHED_HEADER}
    # Click watch/unwatch button
    # Page Should Not Contain Element    ${LIST_WATCHED_HEADER}
    [Teardown]    Close Browser

*** Keywords ***
Setup Board
    ${BOARD}=    Create A Board    TestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]

Teardown Board
    Delete A Board    ${TEST_SUITE_BOARD_ID}