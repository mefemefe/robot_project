*** Settings ***
Documentation    Example Test with Trello API Cards
Library          RequestsLibrary
Resource         resources/Card.resource

*** Test Cases ***
Verify A Card Is Created
    [Tags]             smoke
    Create Trello Session
    ${response}=       Create A Card    name    RFCard2
    ${CARD_ID}=        Get Information From Response    ${response}    id
    ${response}=       Update A Card        ${CARD_ID}    name    RFCard7
    ${CARD_NAME}=      Get Information From Response    ${response}    name
    Should Be Equal    ${CARD_NAME}     RFCard7
    [Teardown]         Delete A Card      ${CARD_ID}

Verify A Card Is Created 2
    [Tags]             smoke
    Pass Execution     Not Implemented
    Create Trello Session
    Create A Card      name    RFCard3
    Get id From Response
    Get The Card
    Get name From Response
    Should Be Equal    ${response_name}    RFCard3
    Delete The Card