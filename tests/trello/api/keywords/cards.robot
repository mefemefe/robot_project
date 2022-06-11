*** Settings ***
Documentation    Keywords for using card with the Trello API
Resource         trello_api.robot

*** Keywords ***
Create A Card
    [Documentation]    Creates a new card in the given list using the given name.
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