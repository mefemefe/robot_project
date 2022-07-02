*** Settings ***
Documentation    Board Tests
Resource         resources/LoginPage.resource
Resource         resources/BoardsPage.resource
Resource         resources/BoardPage.resource
Resource         trello/api/resources/Board.resource
Suite Setup      Boards Suite Setup
Suite Teardown   Boards Suite Teardown


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
    ${BOARD}=    Create A Board    NewName
    Open Browser From Environment    ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Go To Board                     NewName
    Verify Name of Board                     NewName
    Open Show Menu
    Delete Current Board
    [Teardown]      Run Keywords
    ...             Close Browser
    ...             AND  Run Keyword If Test Failed      Wait Until Keyword Succeeds        10        2.5        Delete A Board        ${BOARD.json()}[id]

Update a board's description
    [Documentation]    Verify that a board's description can be updated through GUI
    [Tags]    smoke    gui    board.update.description
    ${BOARD}=    Create A Board    BoardNew
    Open Browser From Environment    ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Go To Board                     BoardNew
    Verify Name of Board            BoardNew
    Open Show Menu
    Update Description of Board                     UpdatedDescription
    [Teardown]      Run Keywords
    ...             Close Browser
    ...             AND  Wait Until Keyword Succeeds        10        2.5        Delete A Board        ${BOARD.json()}[id]

Update a board's name
    [Documentation]    Verify that a board's name can be updated through GUI
    [Tags]    smoke    gui    board.update.name
    ${BOARD}=    Create A Board    NewBoard
    Open Browser From Environment    ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello                     ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Go To Board                     NewBoard
    Verify Name of Board            NewBoard
    Update Name of Board                     UpdatedName
    Verify Name of Board                     UpdatedName
    [Teardown]      Run Keywords
    ...             Close Browser
    ...             AND  Wait Until Keyword Succeeds        10        2.5        Delete A Board        ${BOARD.json()}[id]
*** Keywords ***
Boards Suite Setup
    [Documentation]    Creates a Trello Sesion in order to use api's keywords.
    Create Trello Session

Boards Suite Teardown
    [Documentation]    Deletes the Trello sesion that had been created
    Delete All Sessions 

