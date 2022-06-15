*** Settings ***
Documentation    Keywords for using card with the Trello API
Resource         TrelloAPI.resource

*** Keywords ***
Create A Card
    [Documentation]    Creates a new card in the given list.
    ...                required_args: listId
    ...                optional_args: name, desc, pos, idCardSource, idLabels, due
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        @{optional_args}    ${idList}=${TEST_SUITE_LIST_ID}    ${status_code}=200
    ${response}=       Create An Element    card    @{optional_args}    idList    ${idList}    status_code=${status_code}
    RETURN             ${response}

Get A Card
    [Documentation]    Gets the card with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Get An Element    card    ${id}    status_code=${status_code}
    RETURN             ${response}

Delete A Card
    [Documentation]    Deletes the card with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Delete An Element    card    ${id}    status_code=${status_code}
    RETURN             ${response}

Update A Card
    [Documentation]    Updates the card with the given ID
    ...                optional_args: name, desc, closed, due
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        ${id}    @{optional_args}    ${status_code}=200
    ${response}=       Update An Element    card    ${id}    @{optional_args}    status_code=${status_code}
    RETURN             ${response}

Archive A Card
    [Documentation]    Modifies the card status to closed.
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Update A Card    ${id}    closed    true    status_code=${status_code}
    RETURN             ${response}
