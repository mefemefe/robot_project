*** Settings ***
Documentation    Keywords and Variables for using the Trello API
Library          Collections
Library          String
Variables        tests/common/variables/env_manager.py    TRELLO_APIKEY    TRELLO_TOKEN
Resource         tests/common/api/resources/CommonAPI.resource

*** Variables ***
${DEFAULT_KEY}         ${TRELLO_APIKEY}
${DEFAULT_TOKEN}       ${TRELLO_TOKEN}
${API_BASE_URL}        https://api.trello.com/1/
&{HEADERS}             Accept=application/json    Content-Type=application/json    Authorization=OAuth oauth_consumer_key="${DEFAULT_KEY}", oauth_token="${DEFAULT_TOKEN}"
${DEFAULT_SESSION_ALIAS}    TestSession
&{PATHS}               card=cards/{}    board=boards/{}    label=labels/{}    list=lists/{}    lists_on_board=boards/{}/lists/    archive_list=lists/{}/closed

*** Keywords ***
Create Trello Session
    [Documentation]    Creates a Trello Session
    Create Session    ${API_BASE_URL}    headers=&{HEADERS}


Get An Element
    [Documentation]    Gets an element with the given id using the trello API
    ...                Elements: card, board, label
    [Arguments]        ${element}    ${id}    ${status_code}=200
    ${url}=            Format String      ${PATHS}[${element}]    ${id}
    ${response}=       GET On Session    ${url}    ${status_code}
    RETURN             ${response}

Create An Element
    [Documentation]      Creates a new element using the Trello API
    ...                  Elements: card, board, label
    [Arguments]          ${element}    @{args}    ${status_code}=200
    &{json}=             Create Dictionary
    Set To Dictionary    ${json}    @{args}
    ${url}=              Format String      ${PATHS}[${element}]    ${EMPTY}
    ${response}=         POST On Session    ${url}    ${status_code}   &{json}
    RETURN               ${response}

Delete An Element
    [Documentation]    Deletes the element with the given id
    ...                Elements: card, board, label
    [Arguments]        ${element}    ${id}    ${status_code}=200
    ${url}=            Format String      ${PATHS}[${element}]    ${id}
    ${response}=       DELETE On Session    ${url}    ${status_code}
    RETURN             ${response}

Update An Element
    [Documentation]      Updates the element with the given id
    ...                  Eelements: card, board, label
    [Arguments]          ${element}    ${id}    @{args}    ${status_code}=200
    &{json}=             Create Dictionary
    Set To Dictionary    ${json}    @{args}
    ${url}=              Format String      ${PATHS}[${element}]    ${id}
    ${response}=         PUT On Session    ${url}    ${status_code}   &{json}
    RETURN               ${response}
