*** Settings ***
Documentation    Keywords for using card with the Trello API
Library          Collections
Resource         TrelloAPI.resource

*** Variables ***
${DEFAULT_BOARD_ID}    62917e1a8f60474c0f22da85
${DEFAULT_LIST_ID}     62917e1a8f60474c0f22da86

*** Keywords ***
Create A Card
    [Documentation]    Creates a new card in the given list.
    ...                required_args: listId
    ...                optional_args: name, desc, pos, idCardSource, idLabels, due
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        @{optional_args}    ${idList}=${DEFAULT_LIST_ID}
    ${response}=       Create An Element    card    @{optional_args}    idList    ${idList}
    RETURN             ${response}

Get A Card
    [Documentation]    Gets the card with the given ID
    [Arguments]        ${id}
    ${response}=       Get An Element    card    ${id}
    RETURN             ${response}

Delete A Card
    [Documentation]    Deletes the card with the given ID
    [Arguments]        ${id}
    ${response}=       Delete An Element    card    ${id}
    RETURN             ${response}

Update A Card
    [Documentation]    Updates the card with the given ID
    ...                optional_args: name, desc, closed, due
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        ${id}    @{optional_args}
    ${response}=       Update An Element    card    ${id}    @{optional_args}
    RETURN             ${response}

Archive A Card
    [Documentation]    Modifies the card status to closed.
    [Arguments]        ${id}
    ${response}=       Update A Card    ${id}    closed    true
    RETURN             ${response}
