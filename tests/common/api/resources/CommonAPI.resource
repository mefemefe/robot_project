*** Settings ***
Documentation    Keywords for general API usage.

*** Keywords ***
Get Information From Response
    [Documentation]    Get a specific key from a response dictionary
    [Arguments]    ${response}    ${key}
    RETURN    ${response.json()}[${key}]
