*** Settings ***
Documentation     Example Test with Trello API Cards
Resource          resources/Card.resource
Resource          resources/Board.resource
Suite Setup       Run Keywords
...               Create Trello Session
...               Setup Board And List
Suite Teardown    Run Keywords
...               Teardown Board
...               Delete All Sessions

*** Test Cases ***
Verify A Card Can Be Created
    [Tags]             api    smoke    card.create
    ${response}=       Create A Card    name    RFCard2
    Validate Response Schema    ${response}    card
    ${CARD_ID}=        Get Information From Response    ${response}    id
    ${response}=       Get A Card       ${CARD_ID}
    ${CARD_NAME}=      Get Information From Response    ${response}    name
    Should Be Equal    ${CARD_NAME}     RFCard2
    [Teardown]         Delete A Card      ${CARD_ID}

Verify A Card Can Be Closed
    [Tags]             api    regression    card.close
    ${response}=       Create A Card
    ${CARD_ID}=        Get Information From Response    ${response}    id
    Archive A Card     ${CARD_ID}
    ${response}=       Get A Card    ${CARD_ID}
    ${CARD_CLOSED}=    Get Information From Response    ${response}    closed
    Should Be True     ${CARD_CLOSED}
    [Teardown]         Delete A Card    ${CARD_ID}

Verify A Card Can Be Deleted
    [Tags]             api    smoke    card.delete
    ${response}=       Create A Card
    ${CARD_ID}=        Get Information From Response    ${response}    id
    ${response}=       Delete A Card      ${CARD_ID}
    Validate Response Schema    ${response}    delete
    Get A Card         ${CARD_ID}    status_code=404

Verify A Card Can Be Updated
    [Tags]             api    regression    card.update
    ${response}=       Create A Card    name    RFCard4
    ${CARD_ID}=        Get Information From Response    ${response}    id
    ${response}=       Update A Card      ${CARD_ID}    name    RFCard5    desc    Description
    Validate Response Schema    ${response}    card
    ${response}=       Get A Card    ${CARD_ID}
    ${CARD_NAME}=      Get Information From Response    ${response}    name
    ${CARD_DESC}=      Get Information From Response    ${response}    desc
    Should Be Equal    ${CARD_NAME}    RFCard5
    Should Be Equal    ${CARD_DESC}    Description
    [Teardown]         Delete A Card    ${CARD_ID}

*** Keywords ***
Setup Board And List
    ${BOARD}=    Create A Board    TestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]
    ${LISTS}=    Get Lists On A Board    ${TEST_SUITE_BOARD_ID}
    Set Suite Variable    \${TEST_SUITE_LIST_ID}    ${LISTS.json()}[0][id]

Teardown Board
    Delete A Board    ${TEST_SUITE_BOARD_ID}
