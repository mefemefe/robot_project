*** Settings ***
Documentation    Keywords for using the Trello API
Library          RequestsLibrary
Resource         ../../../common/api/keywords/api_keywords.robot

*** Keywords ***
Create Trello Session
    Create Session    TestSession    https://api.trello.com/1/    disable_warnings=1

Default Key Token Payload
    [Documentation]    A default dictionary for Trello requests that don't need a payload
    &{dictionary}=    Create Dictionary    key=%{TRELLO_APIKEY}    token=%{TRELLO_TOKEN}
    RETURN    &{dictionary}

Create A Card
    [Documentation]    Creates a new card in the given list using the given name, then sets the CARD_ID & CARD_NAME test variables.
    [Arguments]    ${idList}    ${name}
    &{json}=    Create Dictionary    idList=${idList}     name=${name}    key=%{TRELLO_APIKEY}    token=%{TRELLO_TOKEN}        
    ${response}=    POST On Session    alias=TestSession    url=cards/    json=&{json}
    Request Should Be Successful    ${response}
    RETURN    ${response}

Get A Card
    [Documentation]    Gets the card with the given ID
    [Arguments]    ${id}
    &{json}=    Default Key Token Payload
    ${response}=    GET On Session    alias=TestSession    url=cards/${id}    json=&{json}
    Request Should Be Successful    ${response}
    RETURN    ${response}

Delete A Card
    [Documentation]    Deletes the card with the given ID
    [Arguments]    ${id}
    &{json}=    Default Key Token Payload
    ${response}=    DELETE On Session    alias=TestSession    url=cards/${id}    json=&{json}
    Request Should Be Successful    ${response}
    RETURN    ${response}
