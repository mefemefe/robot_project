*** Settings ***
Library          SeleniumLibrary
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource         resources/Lists.resource

*** Test Cases ***
# create list
#     [Tags]    smoke    gui    lists
#     Open Browser                     ${LOGIN_URL}    ${BROWSER}
#     Maximize Browser Window
#     Login To Trello    ${DEFAULT_USER}     ${DEFAULT_PASSWORD}
#     Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
#     Click Link    ${BOARD_BUTTON}
#     Create new list with the name    NEW_TEST_LIST
#     Element Text Should Be    ${NEW_LIST_HEADER}    NEW_TEST_LIST

# modify name of a list
#     [Tags]    smoke    gui    lists
#     Open Browser                     ${LOGIN_URL}    ${BROWSER}
#     Maximize Browser Window
#     Login To Trello    ${DEFAULT_USER}     ${DEFAULT_PASSWORD}
#     Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
#     Click Link    ${BOARD_BUTTON}
#     Create new list with the name    NEW_TEST_LIST
#     Modify the name of a list with    MODIFIED_LIST
#     Element Text Should Be    ${MODIFIED_LIST_HEADER}    MODIFIED_LIST

archive a list
    [Tags]    smoke    gui    lists
    Open Browser                     ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_USER}     ${DEFAULT_PASSWORD}
    Wait Until Page Contains Element     ${BOARD_BUTTON}    timeout=10s
    Click Link    ${BOARD_BUTTON}
    Create new list with the name    NEW_TEST_LIST
    Archive a list
    Element Text Should Not Be    ${LIST_HEADER}    MODIFIED_LIST
    Enter to the list archive
    Element Text Should Be    ${LIST_NAME_FIELD}    MODIFIED_LIST