** Settings ***
Documentation    Keywords for using board with the Trello API
Resource         TrelloAPI.resource


*** Keywords ***
Create A Board
    [Documentation]    Creates a new Board 
    ...                optional_args: name, desc, etc.
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        @{optional_args}    
    ${response}=       Create An Element    board    @{optional_args}    
    RETURN             ${response}

Get A Board
    [Documentation]    Gets the Board with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Get An Element    board    ${id}    status_code=${status_code}
    RETURN             ${response}

Delete A Board
    [Documentation]    Deletes the board with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Delete An Element    board    ${id}    status_code=${status_code}
    RETURN             ${response}

Update A Board
    [Documentation]    Updates the board with the given ID
    ...                optional_args: name, desc, etc.
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        ${id}    @{optional_args}
    ${response}=       Update An Element    board    ${id}    @{optional_args}
    RETURN             ${response}
