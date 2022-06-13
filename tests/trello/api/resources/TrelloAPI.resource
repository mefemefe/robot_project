*** Settings ***
Documentation    Keywords and Variables for using the Trello API
Library          RequestsLibrary
Resource         ../../../common/api/resources/CommonAPI.resource

*** Variables ***
${DEFAULT_KEY}         %{TRELLO_APIKEY}
${DEFAULT_TOKEN}       %{TRELLO_TOKEN}
${BASE_URL}            https://api.trello.com/1/
&{HEADERS}             Accept=application/json    Content-Type=application/json    Authorization=OAuth oauth_consumer_key=${DEFAULT_KEY}, oauth_token=${DEFAULT_TOKEN}
${DEFAULT_BOARD_ID}    62917e1a8f60474c0f22da85
${DEFAULT_LIST_ID}     62917e1a8f60474c0f22da86
${DEFAULT_SESSION_ALIAS}    TestSession
${CARD_PATH}           cards/

*** Keywords ***
Create Trello Session
    Create Session    ${DEFAULT_SESSION_ALIAS}    ${BASE_URL}    disable_warnings=1

Default Key Token Payload
    [Documentation]    A default dictionary for Trello requests that don't need a payload
    &{dictionary}=    Create Dictionary    key=${DEFAULT_KEY}    token=${DEFAULT_TOKEN}
    RETURN    &{dictionary}
