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
    [Teardown]         Delete A Board       ${response.json()}[id]

UPDATE a Board
    [Documentation]    Verify that a board's name can be updated through API
    [Tags]             smoke    api    board.update
    ${response}=       Create A Board    NewBoard
    Validate Response Schema       ${response}    board
    Update A Board       ${response.json()}[id]    name    NewName
    ${new_response}=       Get A Board    ${response.json()}[id]
    Validate Response Schema       ${new_response}    board
    Should Be Equal    ${new_response.json()}[name]     NewName
    [Teardown]         Delete A Board       ${response.json()}[id]

DELETE A Board
    [Documentation]    Verify that a board can be deleted through API
    [Tags]             smoke    api    board.delete
    ${response}=       Create A Board    NewBoard
    Delete A Board       ${response.json()}[id]
    Get A Board       ${response.json()}[id]    status_code=404
