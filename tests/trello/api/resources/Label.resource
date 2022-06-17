*** Settings ***
Documentation    Keywords for using card with the Trello API
Resource         TrelloAPI.resource



*** Keywords ***
Create A Label
    [Documentation]    Creates a new label in the given board.
    ...                required_args: idBoard
    ...                optional_args: name, color
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        @{optional_args}    ${idBoard}=${TEST_SUITE_BOARD_ID}
    ${response}=       Create An Element    label     idBoard    ${idBoard}    @{optional_args}
    RETURN             ${response}

Delete A Label
    [Documentation]    Deletes the label with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Delete An Element    label    ${id}    status_code=${status_code}
    RETURN             ${response}

Get A Label
    [Documentation]    Gets the label with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Get An Element    label    ${id}    status_code=${status_code}
    RETURN             ${response}

Update A Label
    [Documentation]    Updates the label with the given ID
    ...                optional_args: name, color
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        ${id}    @{optional_args}
    ${response}=       Update An Element    label    ${id}    @{optional_args}
    RETURN             ${response}

Verify if Label is deleted
    [Documentation]    verifies that the get element will return a 404 response
    [Arguments]        ${id}
    ${response}=       Get An Element    label    ${id}     status_code=404
    RETURN             ${response}



