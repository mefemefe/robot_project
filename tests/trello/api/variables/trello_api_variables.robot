*** Settings ***
Documentation        Default variables used for the Trello API

*** Variables ***
${DEFAULT_KEY}         %{TRELLO_APIKEY}
${DEFAULT_TOKEN}       %{TRELLO_TOKEN}
${BASE_URL}            https://api.trello.com/1/
&{HEADERS}             Accept=application/json    Content-Type=application/json    Authorization=OAuth oauth_consumer_key=${DEFAULT_KEY}, oauth_token=${DEFAULT_TOKEN}
${DEFAULT_BOARD_ID}    62917e1a8f60474c0f22da85
${DEFAULT_LIST_ID}     62917e1a8f60474c0f22da86
${DEFAULT_SESSION_ALIAS}    TestSession
${CARD_PATH}    cards/