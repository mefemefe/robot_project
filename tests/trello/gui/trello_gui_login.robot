*** Settings ***
Documentation    Example Trello Login Test
Resource         resources/Login.resource

*** Test Cases ***
Login With A Valid User and Password
    [Tags]    smoke    gui    login
    Open Browser                    ${LOGIN_URL}    ${BROWSER}
    Enter Username
    Click Login Button
    Wait Until Location Contains    atlassian.com
    Enter Password
    Click Login Button
    Wait Until Location Is          ${DEFAULT_USER_HOME}
    [Teardown]    Close Browser
