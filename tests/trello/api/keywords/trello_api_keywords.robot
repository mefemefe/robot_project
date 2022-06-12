*** Settings ***
Documentation    Keywords for using the Trello API
Library          RequestsLibrary
Resource         ../../../common/api/keywords/api_keywords.robot
Resource         ../variables/trello_api_variables.robot

*** Keywords ***
Create Trello Session
    Create Session    ${DEFAULT_SESSION_ALIAS}    ${BASE_URL}    disable_warnings=1

Default Key Token Payload
    [Documentation]    A default dictionary for Trello requests that don't need a payload
    &{dictionary}=    Create Dictionary    key=${DEFAULT_KEY}    token=${DEFAULT_TOKEN}
    RETURN    &{dictionary}
