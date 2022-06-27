*** Settings ***
Library          SeleniumLibrary
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource         resources/Lists.resource

*** Test Cases ***
create list
    [Tags]    smoke    gui    lists
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    NEW_TEST_LIST
    Element Text Should Be    ${NEW_LIST_HEADER}    NEW_TEST_LIST
    Close a list    NEW_TEST_LIST
    [Teardown]    Close Browser

modify name of a list
    [Tags]    smoke    gui    lists
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    TO_MODIFY
    Modify the name of a list with    TO_MODIFY    MODIFIED_LIST
    Sleep    3s
    Page Should Contain Element    ${TO_CHECK_LIST_HEADER}    MODIFIED_LIST
    Close a list    MODIFIED_LIST
    [Teardown]    Close Browser

archive a list
    [Tags]    smoke    gui    lists
    Open Browser From Environment        ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}     ${DEFAULT_PASSWORD}
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    TO_ARCHIVE
    Close a list    TO_ARCHIVE
    Element Text Should Not Be    ${NEW_LIST_HEADER}    TO_ARCHIVE
    Enter to the list archive
    Page Should Contain Element    ${LIST_NAME_FIELD}    TO_ARCHIVE
    Close archive tab
    [Teardown]    Close Browser
