*** Settings ***
Documentation    Keywords for using board with the Trello API
Resource         TrelloAPI.resource


*** Keywords ***
Create A List
    [Documentation]    Creates a new List
    ...                board id
    ...                name the list will have
    ...                optional_args:  idListSource, pos, etc.
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        ${name}    ${idBoard}=${TEST_SUITE_BOARD_ID}    @{optional_args}
    ${response}=       Create An Element    list    name    ${name}    idBoard    ${idBoard}    @{optional_args}
    RETURN             ${response}

Get A List
    [Documentation]    Gets the List with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Get An Element    list    ${id}    status_code=${status_code}
    RETURN             ${response}

Archive A List
    [Documentation]    Deletes the list with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Update An Element    archive_list    ${id}    value    true    status_code=${status_code}
    RETURN             ${response}

Update A List
    [Documentation]    Updates the board with the given ID
    ...                optional_args: name, idListSource, pos, etc.
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        ${id}    @{optional_args}
    ${response}=       Update An Element    list    ${id}    @{optional_args}
    RETURN             ${response}
