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
Enter Username
    [Documentation]    Take a username as argument and
    ...                enters it in the user_input
    [Arguments]    ${username}
    Input Text    ${USER_INPUT}    ${username}

Enter Password
    [Documentation]    Take a password as argument and
    ...                enters it in the password_input
    [Arguments]    ${password}
    Input Password    ${PASS_INPUT}    ${password}

Click Login Button
    [Documentation]    Clicks Trello's login button if in Trello's
    ...                login page, else it clicks Atlassian's
    ${url}=    Get Location
    IF    '${url}' == '${LOGIN_URL}'
        Click Button    ${LOGIN_BUTTON_TRELLO}
    ELSE 
        Click Button    ${LOGIN_BUTTON_ATLASSIAN}
    END
