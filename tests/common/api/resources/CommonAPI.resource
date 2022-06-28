*** Settings ***
Documentation    Keywords for general API usage.
Library          RequestsLibrary
Library          JSONSchemaLibrary    schemas/

*** Keywords ***
Get Information From Response
    [Documentation]    Get a specific key from a response dictionary
    [Arguments]    ${response}    ${key}
    RETURN    ${response.json()}[${key}]

Validate Response Schema
    [Documentation]    Validate the response against the corresponding schema
    ...                required_args: response object, element name
    ...                current available element schemas: attachment, board, card,
    ...                comment_on_card, delete, get_attachments, list, labels_on_board
    [Arguments]    ${response}    ${element}
    Validate Json    ${element}.json    ${response.json()}
