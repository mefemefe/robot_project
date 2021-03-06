*** Settings ***
Documentation    Example Test with Trello API Boards
Resource         resources/Board.resource
Suite Setup       Create Trello Session
Suite Teardown    Delete All Sessions


*** Test Cases ***
CREATE a board
    [Documentation]    Verify that a board can be create through API
    [Tags]             smoke    api    board.create
    ${response}=       Create A Board    NewBoard
    Validate Response Schema       ${response}    board
    [Teardown]    Wait Until Keyword Succeeds    10    2.5           Delete A Board       ${response.json()}[id]

UPDATE a Board's name
    [Documentation]    Verify that a board's name can be updated through API
    [Tags]             smoke    api    board.update
    ${response}=       Create A Board    NewBoard
    Validate Response Schema       ${response}    board
    Update A Board       ${response.json()}[id]    name    NewName
    ${new_response}=       Get A Board    ${response.json()}[id]
    Validate Response Schema       ${new_response}    board
    Should Be Equal    ${new_response.json()}[name]     NewName
    [Teardown]    Wait Until Keyword Succeeds    10    2.5           Delete A Board       ${response.json()}[id]

DELETE A Board
    [Documentation]    Verify that a board can be deleted through API
    [Tags]             smoke    api    board.delete
    ${response}=       Create A Board    NewBoard
    Delete A Board       ${response.json()}[id]
    Get A Board       ${response.json()}[id]    status_code=404

GET Information of A Board
    [Documentation]    Verify that a board's information can be accesed through API
    [Tags]             smoke    api    board.get
    ${response}=       Create A Board    BoardTest
    Validate Response Schema       ${response}    board
    ${response2}=       Get A Board       ${response.json()}[id]
    Validate Response Schema       ${response2}    board
    Should Be Equal    ${response2.json()}[name]     BoardTest
    [Teardown]    Wait Until Keyword Succeeds    10    2.5           Delete A Board       ${response.json()}[id]


UPDATE a Board's description
    [Documentation]    Verify that a board's description can be updated through API
    [Tags]             smoke    api    board.update
    ${response}=       Create A Board    NewBoardForTest
    Validate Response Schema       ${response}    board
    Update A Board       ${response.json()}[id]    desc    sampleDescription
    ${new_response}=       Get A Board    ${response.json()}[id]
    Should Be Equal    ${new_response.json()}[desc]     sampleDescription
    Update A Board       ${response.json()}[id]    desc    updatedDescription
    ${new_response2}=       Get A Board    ${response.json()}[id]
    Should Be Equal    ${new_response2.json()}[desc]     updatedDescription
    [Teardown]    Wait Until Keyword Succeeds    10    2.5           Delete A Board       ${response.json()}[id]
