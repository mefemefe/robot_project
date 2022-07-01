*** Settings ***
Documentation    Keywords for using checklists with the Trello API
Resource         TrelloAPI.resource

*** Keywords ***
Create A Checklist
    [Documentation]    Creates a new checklist in the given card.
    ...                required_args: idCard
    ...                optional_args: name, pos, idChecklistSource
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        @{optional_args}    ${idCard}    ${status_code}=200
    ${response}=       Create An Element    checklist    @{optional_args}    idCard    ${idCard}    status_code=${status_code}
    RETURN             ${response}

Get A Checklist
    [Documentation]    Gets the checklist with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Get An Element    checklist    ${id}    status_code=${status_code}
    RETURN             ${response}

Delete A Checklist
    [Documentation]    Deletes the checklist with the given ID
    [Arguments]        ${id}    ${status_code}=200
    ${response}=       Delete An Element    checklist    ${id}    status_code=${status_code}
    RETURN             ${response}

Update A Checklist
    [Documentation]    Updates the checklist with the given ID
    ...                optional_args: name, pos
    ...                keys and values should be separated, eg:    name    desired_name
    [Arguments]        ${id}    @{optional_args}    ${status_code}=200
    ${response}=       Update An Element    checklist    ${id}    @{optional_args}    status_code=${status_code}
    RETURN             ${response}
