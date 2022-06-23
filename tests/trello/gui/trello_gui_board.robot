*** Settings ***
Documentation    Board Tests
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource         resources/components/TopBar.resource
Resource         resources/components/ShownMenu.resource

*** Test Cases ***
create a board
    [Tags]    smoke    gui    board.create
    Open Browser                     ${LOGIN_URL}    ${BROWSER}    remote_url=http://selenium-hub:4444
    Maximize Browser Window    
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Click New Board Button
    Set Name to Board                     NewName
    Verify Name of Board                     NewName
    [Teardown]    Close Browser

delete a board
    [Tags]    smoke    gui    board.delete
    Open Browser                     ${LOGIN_URL}    ${BROWSER}    remote_url=http://selenium-hub:4444
    Maximize Browser Window    
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Click New Board Button
    Set Name to Board                     NewName
    Verify Name of Board                     NewName
    Open Show Menu
    Delete Current Board
    Verify Current Page Is Boards Page
    [Teardown]    Close Browser

Update a board's description
    [Tags]    smoke    gui    board.update.description
    Open Browser                     ${LOGIN_URL}    ${BROWSER}    remote_url=http://selenium-hub:4444 
    Maximize Browser Window      
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Click New Board Button
    Set Name to Board                     NewName
    Verify Name of Board                     NewName
    Open Show Menu
    Update Description of Board                     UpdatedDescription
    Open Show Menu
    Delete Current Board
    Verify Current Page Is Boards Page
    [Teardown]    Close Browser


Update a board's name
    [Tags]    smoke    gui    board.update.description
    Open Browser                     ${LOGIN_URL}    ${BROWSER}    remote_url=http://selenium-hub:4444
    Maximize Browser Window    
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Click New Board Button
    Set Name to Board                     NewName
    Verify Name of Board                     NewName
    Update Name of Board                     UpdatedName
    Verify Name of Board                     UpdatedName
    Open Show Menu
    Delete Current Board
    Verify Current Page Is Boards Page
    [Teardown]    Close Browser
