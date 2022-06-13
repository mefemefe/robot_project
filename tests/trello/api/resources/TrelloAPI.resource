*** Settings ***
Documentation    Keywords and Variables for using the Trello API
Library          RequestsLibrary
Library          Collections
Resource         tests/common/api/resources/CommonAPI.resource

*** Variables ***
${DEFAULT_KEY}         %{TRELLO_APIKEY}
${DEFAULT_TOKEN}       %{TRELLO_TOKEN}
${BASE_URL}            https://api.trello.com/1/
&{HEADERS}             Accept=application/json    Content-Type=application/json    Authorization=OAuth oauth_consumer_key="${DEFAULT_KEY}", oauth_token="${DEFAULT_TOKEN}"
${DEFAULT_SESSION_ALIAS}    TestSession
&{PATHS}               card=cards/    board=boards/    label=labels/

*** Keywords ***
Create Trello Session
    Create Session    ${DEFAULT_SESSION_ALIAS}    ${BASE_URL}    disable_warnings=1    headers=&{HEADERS}

Create An Element
    [Documentation]      Creates a new element using the Trello API
    ...                  Elements: card, board, label
    [Arguments]          ${element}    @{args}
    &{json}=             Create Dictionary
    Set To Dictionary    ${json}    @{args}
    ${response}=         POST On Session    alias=${DEFAULT_SESSION_ALIAS}    url=${PATHS}[${element}]    json=&{json}
    RETURN               ${response}

Get An Element
    [Documentation]    Gets an element with the given id using the trello API
    ...                Elements: card, board, label
    [Arguments]        ${element}    ${id}
    ${response}=       GET On Session    alias=${DEFAULT_SESSION_ALIAS}    url=${PATHS}[${element}]${id}
    RETURN             ${response}

Delete An Element
    [Documentation]    Deletes the element with the given id
    ...                Elements: card, board, label
    [Arguments]        ${element}    ${id}
    ${response}=       DELETE On Session    alias=${DEFAULT_SESSION_ALIAS}    url=${PATHS}[${element}]${id}
    RETURN             ${response}

Update An Element
    [Documentation]      Updates the element with the given id
    ...                  Eelements: card, board, label
    [Arguments]          ${element}    ${id}    @{args}
    &{json}=             Create Dictionary
    Set To Dictionary    ${json}    @{args}
    ${response}=         PUT On Session    alias=${DEFAULT_SESSION_ALIAS}    url=${PATHS}[${element}]${id}    json=&{json}
    RETURN               ${response}
