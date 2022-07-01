*** Settings ***
Documentation     Example Test with Trello API Checklists
Resource          resources/Card.resource
Resource          resources/Board.resource
Resource          resources/Checklist.resource
Suite Setup       Run Keywords
...               Create Trello Session
...               Setup Board, List And Card
Suite Teardown    Run Keywords
...               Teardown Board
...               Delete All Sessions

*** Test Cases ***
Verify A Checklist Can Be Created
    [Documentation]       Verify that a checklist can be created through API
    [Tags]                api    smoke    checklist.create
    ${response}=          Create A Checklist    name    TestChecklist     idCard=${TEST_SUITE_CARD_ID}
    ${checklist_id}=      Get Information From Response    ${response}    id
    ${response}=          Get A Checklist    ${checklist_id}
    ${checklist_name}=    Get Information From Response    ${response}    name
    Should Be Equal       ${checklist_name}    TestChecklist
    [Teardown]            Delete A Checklist    ${checklist_id}

Verify A Checklist Can Be Deleted
    [Documentation]             Verify that a checklist can be deleted through API
    [Tags]                      api    smoke    checklist.delete
    ${response}=                Create A Checklist    name    TestChecklist    idCard=${TEST_SUITE_CARD_ID}
    ${checklist_id}=            Get Information From Response    ${response}    id
    ${response}=                Delete A Checklist      ${checklist_id}
    Validate Response Schema    ${response}    delete
    Get A Checklist             ${checklist_id}    status_code=404

Verify A Checklist Can Be Updated
    [Documentation]       Verify that a checklist's name can be updated through API
    [Tags]                api    regression    checklist.update
    ${response}=          Create A Checklist    name    TestChecklist    idCard=${TEST_SUITE_CARD_ID}
    ${checklist_id}=      Get Information From Response    ${response}    id
    ${response}=          Update A Checklist      ${checklist_id}    name    TestChecklist2
    ${response}=          Get A Checklist    ${checklist_id}
    ${checklist_name}=    Get Information From Response    ${response}    name
    Should Be Equal       ${checklist_name}    TestChecklist2
    [Teardown]            Delete A Checklist    ${checklist_id}

*** Keywords ***
Setup Board, List And Card
    [Documentation]    Create a board and save its ID and its first list's ID
    ${BOARD}=    Create A Board    TestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]
    ${LISTS}=    Get Lists On A Board    ${TEST_SUITE_BOARD_ID}
    Set Suite Variable    \${TEST_SUITE_LIST_ID}     ${LISTS.json()}[0][id]
    ${CARD}=     Create A Card    name    TestCard
    Set Suite Variable    \${TEST_SUITE_CARD_ID}     ${CARD.json()}[id]

Teardown Board
    [Documentation]    Delete the board created for this suite
    Delete A Board    ${TEST_SUITE_BOARD_ID}