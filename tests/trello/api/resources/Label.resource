*** Settings ***
Documentation    Keywords for using card with the Trello API
Library          Collections
Resource         /tests/trello/api/resources/TrelloAPI.resource


*** Variables ***
${DEFAULT_BOARD_ID}    629160b34fb79620003ba4b8



*** Keywords ***
Create A Label
    [Documentation]    Creates a new label in the given board.
    ...                required_args: idBoard
    ...                optional_args: name, color
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        @{optional_args}    ${idBoard}=${DEFAULT_BOARD_ID}
    ${response}=       Create An Element    label     idBoard    ${idBoard}    @{optional_args}
    RETURN             ${response}

Delete A Label
    [Documentation]    Deletes the label with the given ID
    [Arguments]        ${id}
    ${response}=       Delete An Element    label    ${id}
    RETURN             ${response}

Get A Label
    [Documentation]    Gets the label with the given ID
    [Arguments]        ${id}
    ${response}=       Get An Element    label    ${id}
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

Get labels from board
    [Documentation]    Get all labels from the default board
    ${response}=    Get on session    ${DEFAULT_SESSION_ALIAS}    url=https://api.trello.com/1/boards/${DEFAULT_BOARD_ID}/labels?key=${DEFAULT_KEY}&token=${DEFAULT_TOKEN}
     RETURN             ${response}

