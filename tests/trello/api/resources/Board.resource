** Settings ***
Documentation    Keywords for using board with the Trello API
Resource         TrelloAPI.resource


*** Keywords ***
Create A Board
    [Documentation]    Creates a new Board
    ...                name the board will have
    ...                optional_args:  desc, defaultLists, etc.
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        ${name}    @{optional_args}
    ${response}=       Create An Element    board    @{optional_args}    name    ${name}
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

Get Lists On A Board
    [Documentation]    Get all the lists in a board
    [Arguments]        ${id}    ${status_code}=200
    ${response}        Get An Element    lists_on_board    ${id}
    RETURN             ${response}
