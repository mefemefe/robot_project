*** Settings ***
Documentation    Example Trello Login Test
Resource         TrelloGUI.resource

*** Variables ***
${DEFAULT_USER}        %{TRELLO_USER}
${DEFAULT_PASSWORD}    %{TRELLO_PASSWORD}
${LOGIN_PATH}          login
### Locators ###
${USER_INPUT}          css:input#user
${PASS_INPUT}          css:input#password
${LOGIN_BUTTON_TRELLO}      css:input#login
${LOGIN_BUTTON_ATLASSIAN}      css:button#login-submit

*** Keywords ***
Go To Trello's Login Page
    Go To    ${BASE_URL}${LOGIN_PATH}
    Wait Until Location Is    ${BASE_URL}${LOGIN_PATH}

Enter Username
    [Arguments]    ${username}=${DEFAULT_USER}
    Input Text    ${USER_INPUT}    ${username}

Enter Password
    [Arguments]    ${password}=${DEFAULT_PASSWORD}
    Input Password    ${PASS_INPUT}    ${password}

Click Login Button
    Click Button    ${LOGIN_BUTTON_TRELLO}

Click Atlassian Login Button
    Click Button    ${LOGIN_BUTTON_ATLASSIAN}
