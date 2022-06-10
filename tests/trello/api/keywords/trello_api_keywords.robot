*** Settings ***

Library    RequestsLibrary

*** Variables ***


&{HEADERS}    Accept=application/json    Content-Type=application/json    Authorization=OAuth oauth_consumer_key=%{APIKEY}, oauth_token=%{TOKEN}

*** Keywords ***

Create Headers
    ${HEADERS}=    Create Dictionary

Create Trello Session
    Create Session    TestSession    https://api.trello.com    headers=${HEADERS}