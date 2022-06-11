*** Settings ***
Documentation    Keywords for using the Trello API
Library          RequestsLibrary
Resource         ../../../common/api/keywords/api.robot

*** Keywords ***
Create Trello Session
    Create Session    TestSession    https://api.trello.com/1/    disable_warnings=1

Default Key Token Payload
    [Documentation]    A default dictionary for Trello requests that don't need a payload
    &{dictionary}=    Create Dictionary    key=%{TRELLO_APIKEY}    token=%{TRELLO_TOKEN}
    RETURN    &{dictionary}
