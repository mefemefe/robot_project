*** Settings ***
Documentation    Keywords for using card with the Trello API
Library          Collections
Resource         TrelloAPI.resource

*** Keywords ***
Create A Card
    [Documentation]    Creates a new card in the given list using the given name.
    ...                optional_args: name, desc, pos, idCardSource, idLabels, due
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]    @{optional_args}    ${idList}=${DEFAULT_LIST_ID}
    &{json}=    Default Key Token Payload
    Set To Dictionary    ${json}    @{optional_args}    idList=${idList}
    ${response}=    POST On Session    alias=${DEFAULT_SESSION_ALIAS}    url=${CARD_PATH}    json=&{json}
    Request Should Be Successful    ${response}
    RETURN    ${response}

Get A Card
    [Documentation]    Gets the card with the given ID
    [Arguments]    ${id}
    &{json}=    Default Key Token Payload
    ${response}=    GET On Session    alias=${DEFAULT_SESSION_ALIAS}    url=${CARD_PATH}${id}    json=&{json}
    Request Should Be Successful    ${response}
    RETURN    ${response}

Delete A Card
    [Documentation]    Deletes the card with the given ID
    [Arguments]    ${id}
    &{json}=    Default Key Token Payload
    ${response}=    DELETE On Session    alias=${DEFAULT_SESSION_ALIAS}    url=${CARD_PATH}${id}    json=&{json}
    Request Should Be Successful    ${response}
    RETURN    ${response}
