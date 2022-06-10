*** Settings ***

Library    RequestsLibrary

*** Test Cases ***
Example Test
    ${response}=    GET  https://www.google.com
    Log    ${response}

Create A Card
    Log    TODO

Delete A Card
    Log    TODO