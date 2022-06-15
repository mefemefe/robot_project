*** Settings ***
Documentation    Example Trello Login Test
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource

*** Test Cases ***
Login With A Valid User and Password
    [Tags]    smoke    gui    login
    Open Browser                     ${LOGIN_URL}    ${BROWSER}
    Enter Username                   ${DEFAULT_USER}
    Wait Until Element Is Not Visible    ${PASS_INPUT}
    Click Login Button
    Wait Until Location Is Atlassian's Login
    Enter Password                   ${DEFAULT_PASSWORD}
    Click Login Button
    Verify Current Page Is Boards Page
    [Teardown]    Close Browser
