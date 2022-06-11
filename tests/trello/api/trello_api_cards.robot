*** Settings ***
Documentation    Example Test with Trello API Cards
Library          RequestsLibrary
Resource         keywords/cards.robot

*** Test Cases ***
Create A Card
    Create Trello Session
    ${response}=       Create A Card    62917e1a8f60474c0f22da86    RFCard2
    ${CARD_ID}=        Get Information From Response    ${response}    id
    ${response}=       Get A Card       ${CARD_ID}
    ${CARD_NAME}=      Get Information From Response    ${response}    name
    Should Be Equal    ${CARD_NAME}     RFCard2
    Delete A Card      ${CARD_ID}
