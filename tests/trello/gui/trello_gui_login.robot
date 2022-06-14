*** Settings ***
Documentation    Example Trello Login Test
Resource         resources/Login.resource

*** Test Cases ***
Login With A Valid User and Password
    [Tags]    smoke    gui    login
    Open Browser                     ${LOGIN_URL}    ${BROWSER}
    Enter Username                   ${DEFAULT_USER}
    Wait Until Element Is Not Visible    ${PASS_INPUT}
    Click Login Button
    Wait Until Location Contains     atlassian.com
    Enter Password                   ${DEFAULT_PASSWORD}
    Click Login Button
    Wait Until Location Contains     boards
    Wait Until Element Is Visible    ${YOUR_WORKSPACES}
    Element Text Should Be           ${YOUR_WORKSPACES}    YOUR WORKSPACES
    [Teardown]    Close Browser
