*** Settings ***
Documentation    Example Test with Trello API Cards
Library           RequestsLibrary
Resource          resources/Card.resource
Suite Setup       Create Trello Session
Suite Teardown    Delete All Sessions

*** Test Cases ***
Verify A Card Is Created
    [Tags]             smoke
    ${response}=       Create A Card    name    RFCard2
    ${CARD_ID}=        Get Information From Response    ${response}    id
    ${response}=       Get A Card       ${CARD_ID}
    ${CARD_NAME}=      Get Information From Response    ${response}    name
    Should Be Equal    ${CARD_NAME}     RFCard2
    [Teardown]         Delete A Card      ${CARD_ID}

Verify A Card Can Be Closed
    [Tags]             regression
    ${response}=       Create A Card
    ${CARD_ID}=        Get Information From Response    ${response}    id
    Archive A Card     ${CARD_ID}
    ${response}=       Get A Card    ${CARD_ID}
    ${CARD_CLOSED}=    Get Information From Response    ${response}    closed
    Should Be True     ${CARD_CLOSED}
    [Teardown]         Delete A Card    ${CARD_ID}
