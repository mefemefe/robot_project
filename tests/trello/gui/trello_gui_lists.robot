*** Settings ***
Library          SeleniumLibrary
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
<<<<<<< HEAD
Resource          tests/trello/api/resources/Board.resource

Resource          resources/components/ListComponent.resource
Resource         resources/components/ShownMenu.resource
Resource         resources/components/TopBar.resource
=======
Resource         resources/Lists.resource
Resource          tests/trello/api/resources/Board.resource
Resource          tests/trello/api/resources/TrelloAPI.resource
>>>>>>> aca9adfb0cc234ac03238b4d46ee7c5e78825ce3
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
<<<<<<< HEAD
    Go To Board    TestBoard
    Create new list with the name    NEW_TEST_LIST
    Verify That The List Exists    NEW_TEST_LIST
    [Teardown]    Run Keywords
...               Close a list
...               Close Browser
=======
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    NEW_TEST_LIST
    Element Text Should Be    ${NEW_LIST_HEADER}    NEW_TEST_LIST
    Close a list
    [Teardown]    Close Browser
>>>>>>> aca9adfb0cc234ac03238b4d46ee7c5e78825ce3

modify name of a list
    [Tags]    smoke    gui    list.update
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
<<<<<<< HEAD
    Go To Board    TestBoard
    Create new list with the name    TO_MODIFY
    Modify the name of a list with    TO_MODIFY    MODIFIED_LIST
    Verify That The List Exists    MODIFIED_LIST
    [Teardown]    Run Keywords
...               Close a list
...               Close Browser
=======
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    TO_MODIFY
    Modify the name of a list with    TO_MODIFY    MODIFIED_LIST
    Page Should Contain Element    ${TO_CHECK_LIST_HEADER}
    Close a list
    [Teardown]    Close Browser
>>>>>>> aca9adfb0cc234ac03238b4d46ee7c5e78825ce3

archive a list
    [Tags]    smoke    gui    list.archive
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
<<<<<<< HEAD
    Go To Board    TestBoard
    Create new list with the name    TO_ARCHIVE
    Close a list
    Enter to the side menu
    Enter to the list archive
    Verify That A List Is In The Archive    TO_ARCHIVE
    Close archive tab
    [Teardown]    Close Browser

=======
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
>>>>>>> aca9adfb0cc234ac03238b4d46ee7c5e78825ce3

*** Keywords ***
Setup Board
    ${BOARD}=    Create A Board    TestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]

Teardown Board
    Delete A Board    ${TEST_SUITE_BOARD_ID}