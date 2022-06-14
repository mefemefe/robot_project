*** Settings ***
Documentation    Example Test with Trello API Boards
Resource         resources/Board.resource

*** Test Cases ***
CREATE a board
    [Tags]             smoke    api    board.create
    Create Trello Session
    ${response}=       Create A Board    name    NewBoard
    Validate Response Schema       ${response}    board       
    [Teardown]         Delete A Board       ${response.json()}[id]
      
UPDATE a Board
    [Tags]             smoke    api    board.update
    Create Trello Session
    ${response}=       Create A Board    name    NewBoard
    Validate Response Schema       ${response}    board
    Update A Board       ${response.json()}[id]    name    NewName
    ${new_response}=       Get A Board    ${response.json()}[id]
    Validate Response Schema       ${new_response}    board
    Should Be Equal    ${new_response.json()}[name]     NewName 
    [Teardown]         Delete A Board       ${response.json()}[id]

DELETE A Board
    [Tags]             smoke    api    board.delete
    Create Trello Session
    ${response}=       Create A Board    name    NewBoard     
    Delete A Board       ${response.json()}[id]
    Get A Board       ${response.json()}[id]    status_code=404
