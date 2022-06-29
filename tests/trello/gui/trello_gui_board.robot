*** Settings ***
Documentation    Board Tests
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource         resources/BoardPage.resource


*** Test Cases ***
create a board
    [Documentation]    Verify that a board can be created through GUI
    [Tags]    smoke    gui    board.create
    Open Browser From Environment    ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Click New Board Button
    Set Name to Board                     NewName
    Verify Name of Board                     NewName
    [Teardown]        Run Keywords
    ...               Open Show Menu
    ...               Delete Current Board
    ...               Close Browser

delete a board
    [Documentation]    Verify that a board can be deleted through GUI
    [Tags]    smoke    gui    board.delete
    Open Browser From Environment    ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Click New Board Button
    Set Name to Board                     NewName
    Verify Name of Board                     NewName
    [Teardown]        Run Keywords
    ...               Open Show Menu
    ...               Delete Current Board
    ...               Close Browser

Update a board's description
    [Documentation]    Verify that a board's description can be updated through GUI
    [Tags]    smoke    gui    board.update.description
    Open Browser From Environment    ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Click New Board Button
    Set Name to Board                     NewName
    Verify Name of Board                     NewName
    Open Show Menu
    Update Description of Board                     UpdatedDescription
    [Teardown]        Run Keywords
    ...               Open Show Menu
    ...               Delete Current Board
    ...               Close Browser


Update a board's name
    [Documentation]    Verify that a board's name can be updated through GUI
    [Tags]    smoke    gui    board.update.description
    Open Browser From Environment    ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Click New Board Button
    Set Name to Board                     NewName
    Verify Name of Board                     NewName
    Update Name of Board                     UpdatedName
    Verify Name of Board                     UpdatedName
    [Teardown]        Run Keywords
    ...               Open Show Menu
    ...               Delete Current Board
    ...               Close Browser

