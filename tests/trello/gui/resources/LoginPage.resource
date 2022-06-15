*** Settings ***
Documentation    Variables and Keywords for Trello's Login Page
Resource         TrelloGUI.resource

*** Variables ***
${LOGIN_PATH}          login
${LOGIN_URL}           ${BASE_URL}${LOGIN_PATH}
### Locators ###
${USER_INPUT}                  css:input#user
${PASS_INPUT}                  css:input#password
${LOGIN_BUTTON_TRELLO}         css:input#login
${LOGIN_BUTTON_ATLASSIAN}      css:button#login-submit

*** Keywords ***
Login To Trello
    [Documentation]    High-level keyword for logging in to Trello
    [Arguments]    ${username}    ${password}
    ${url}=    Get Location
    IF    '${url}' != '${LOGIN_URL}'
        Go To    ${LOGIN_URL}
    END
    Enter Username                   ${username}
    Wait Until Element Is Not Visible    ${PASS_INPUT}
    Click Login Button
    Wait Until Location Is Atlassian's Login
    Enter Password                   ${password}
    Click Login Button

Enter Username
    [Documentation]    Take a username as argument and
    ...                enters it in the user_input
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${USER_INPUT}
    Input Text    ${USER_INPUT}    ${username}

Enter Password
    [Documentation]    Take a password as argument and
    ...                enters it in the password_input
    [Arguments]    ${password}
    Wait Until Element Is Visible    ${PASS_INPUT}    timeout=10
    Input Password    ${PASS_INPUT}    ${password}

Click Login Button
    [Documentation]    Clicks Trello's login button if in Trello's
    ...                login page, else it clicks Atlassian's
    ${url}=    Get Location
    IF    '${url}' == '${LOGIN_URL}'
        Wait Until Element Is Enabled    ${LOGIN_BUTTON_TRELLO}
        Click Button    ${LOGIN_BUTTON_TRELLO}
    ELSE 
        Wait Until Element Is Enabled    ${LOGIN_BUTTON_ATLASSIAN}
        Click Button    ${LOGIN_BUTTON_ATLASSIAN}
    END

Wait Until Location Is Atlassian's Login
    Wait Until Location Contains     atlassian.com 