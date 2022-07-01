*** Settings ***
Documentation    Example Test with Trello API lists
Resource          resources/List.resource
Resource          resources/Board.resource
Suite Setup       Run Keywords
...               Create Trello Session
...               Setup Board
Suite Teardown    Run Keywords
...               Teardown Board
...               Delete All Sessions

*** Test Cases ***
CREATE a list
    [Documentation]    Verify that a list can be created through API
    [Tags]             smoke    api    list.create
    ${response}=       Create A List    NewList
    Validate Response Schema       ${response}    list

UPDATE a list
    [Documentation]    Verify that a lists name can be updated through API
    [Tags]             regression    api    list.update
    ${response}=       Create A List    NewList
    Validate Response Schema       ${response}    list
    Update A List       ${response.json()}[id]    name    NewName
    ${new_response}=       Get A List    ${response.json()}[id]
    Validate Response Schema       ${new_response}    list
    Should Be Equal    ${new_response.json()}[name]     NewName

ARCHIVE A list
    [Documentation]    Verify that a list can be archived through API
    [Tags]             regression    api    list.archive
    ${response}=       Create A List    NewList
    Archive A List       ${response.json()}[id]
    ${new_response}=       Get A List    ${response.json()}[id]
    Should Be True    ${new_response.json()}[closed]

*** Keywords ***
Setup Board
    [Documentation]    Create a board and save it's id for the suite
    ${BOARD}=    Create A Board    TestBoard
    Wait Until Keyword Succeeds    10    2.5        Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]

Teardown Board
    [Documentation]    Delete the board created for this suite.
    Wait Until Keyword Succeeds    10    2.5        Delete A Board    ${TEST_SUITE_BOARD_ID}