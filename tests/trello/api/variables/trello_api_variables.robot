*** Settings ***

Documentation        Default variables used for the Trello API

*** Variables ***

&{HEADERS}             Accept=application/json    Content-Type=application/json    Authorization=OAuth oauth_consumer_key=%{TRELLO_APIKEY}, oauth_token=%{TRELLO_TOKEN}
${DEFAULT_BOARD_ID}    62917e1a8f60474c0f22da85
${DEFAULT_LIST_ID}     62917e1a8f60474c0f22da86