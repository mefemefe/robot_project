*** Settings ***
Documentation    Example Test with Trello API Cards
Resource         resources/Label.resource
Resource         resources/Board.resource
Suite Setup       Run Keywords
...               Create Trello Session
...               Setup Board And List
Suite Teardown    Run Keywords
...               Teardown Board
...               Delete All Sessions


*** Test Cases ***
Create and get label on board
    [Documentation]    Verify that a label can be created through API
    [Tags]             smoke    api    label.create    label.get
    ${response}=       Create A Label    name    label2    color   yellow
    Validate Response Schema     ${response}   label
    ${LABEL_ID}=       Get Information From Response    ${response}    id
    ${response}=    Get A Label    ${LABEL_ID}
    ${LABEL_COLOR}=       Get Information From Response    ${response}    color
    ${LABEL_NAME}=       Get Information From Response    ${response}    name
    Should Be Equal    ${LABEL_COLOR}     yellow
    Should Be Equal    ${LABEL_NAME}     label2
    [Teardown]    Wait Until Keyword Succeeds    10    2.5         Delete A Label     ${LABEL_ID}


Update label on board
    [Documentation]    Verify that a label's name and color can be updated through API
    [Tags]             smoke    api    label.update
    ${response}=       Create A Label    name    label2    color   yellow
    Validate Response Schema     ${response}   label
    ${LABEL_ID}=       Get Information From Response    ${response}    id
    ${new_response}=       Update A Label   ${LABEL_ID}    name    label3    color    orange
    ${NEW_LABEL_COLOR}=       Get Information From Response    ${new_response}    color
    ${NEW_LABEL_NAME}=       Get Information From Response    ${new_response}    name
    Should Be Equal    ${NEW_LABEL_COLOR}     orange
    Should Be Equal    ${NEW_LABEL_NAME}     label3
    [Teardown]    Wait Until Keyword Succeeds    10    2.5        Delete A Label     ${LABEL_ID}

Delete label on board
    [Documentation]    Verify that a label can be deleted through API
    [Tags]             smoke    api    label.delete
    ${response}=       Create A Label    name    label2    color   yellow
    ${LABEL_ID}=       Get Information From Response    ${response}    id
    Wait Until Keyword Succeeds    10    2.5          Delete A Label     ${LABEL_ID}
    Get A Label  ${LABEL_ID}    status_code=404

*** Keywords ***
Setup Board And List
    [Documentation]    Create a board and save its ID and its first list's ID
    ${BOARD}=    Create A Board    TestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]
    ${LISTS}=    GET On Session    boards/${TEST_SUITE_BOARD_ID}/lists
    Set Suite Variable    \${TEST_SUITE_LIST_ID}    ${LISTS.json()}[0][id]

Teardown Board
    [Documentation]    Delete the board created for this session.
    Wait Until Keyword Succeeds    10    2.5              Delete A Board    ${TEST_SUITE_BOARD_ID}

