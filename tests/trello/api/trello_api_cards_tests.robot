*** Settings ***
Documentation    Example Test with Trello API Cards
Library          RequestsLibrary
Resource         keywords/cards_keywords.robot

*** Test Cases ***
Verify A Card Is Created
    Create Trello Session
    ${response}=       Create A Card    ${DEFAULT_LIST_ID}    name    RFCard2
    ${CARD_ID}=        Get Information From Response    ${response}    id
    ${response}=       Get A Card       ${CARD_ID}
    ${CARD_NAME}=      Get Information From Response    ${response}    name
    Should Be Equal    ${CARD_NAME}     RFCard2
    Delete A Card      ${CARD_ID}
