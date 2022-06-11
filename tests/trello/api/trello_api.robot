*** Settings ***

Library    RequestsLibrary
Resource    keywords/trello_api_keywords.robot

*** Test Cases ***
Create A Card
    Create Trello Session
    Create A Card    62917e1a8f60474c0f22da86    RFCard2
    Delete A Card    ${CARD_ID}
