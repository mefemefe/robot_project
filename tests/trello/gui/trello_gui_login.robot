*** Settings ***
Documentation    Example Trello Login Test
Resource         resources/Login.resource

*** Test Cases ***
Login With A Valid User and Password
    [Tags]                smoke    gui    login
    Open Browser          browser=${BROWSER}
    Go To Trello's Login Page
    Enter Username
    Click Login Button
    Wait Until Location Contains    atlassian
    Enter Password
    Click Atlassian Login Button
    Wait Until Location Is    https://trello.com/pablotest4/boards
    [Teardown]            Close Browser
