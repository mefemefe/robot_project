*** Settings ***

Documentation    Keywords for using the Trello API
Library          RequestsLibrary

*** Keywords ***

Create Trello Session
    Create Session    TestSession    https://api.trello.com/1/

Create A Card
    [Arguments]    ${idList}    ${name}
    &{json}=    Create Dictionary    idList=${idList}     name=${name}    key=%{TRELLO_APIKEY}    token=%{TRELLO_TOKEN}        
    ${response}=    POST On Session    alias=TestSession    url=cards/    json=&{json}
    Request Should Be Successful    ${response}
    Set Test Variable    ${CARD_ID}    ${response.json()}[id]

Delete A Card
    [Arguments]    ${id}
    &{json}=    Create Dictionary    key=%{TRELLO_APIKEY}    token=%{TRELLO_TOKEN}
    ${response}=    DELETE On Session    alias=TestSession    url=cards/${id}    json=&{json}
    Request Should Be Successful    ${response}