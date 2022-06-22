*** Settings ***
Documentation     Test Cases for Cards Feature
Resource          resources/LoginPage.resource
Resource          tests/trello/api/resources/Board.resource
Resource          resources/BoardsPage.resource
Resource          resources/BoardPage.resource
Suite Setup       Cards Suite Setup
Suite Teardown    Cards Suite Teardown

*** Test Cases ***
Verify A Card Can Be Created
    [Tags]    smoke    gui    card.create
    Set Test Variable    \${list}    To Do
    Set Test Variable    \${card}    Test Card
    Create Card In List    ${list}    ${card}
    Verify Card Exists    ${list}    ${card}
    [Teardown]    Run Keywords    
    ...           Go To Card Modal    list_name=${list}    card_name=${card}
    ...           AND    Delete Current Card

Modify A Card's Name From The Board Page
    [Tags]    regression    gui    card.title_board
    Set Test Variable    \${list}    To Do
    Set Test Variable    \${card}    Test Card
    Create Card In List    ${list}    ${card}
    Set Test Variable    \${new_name}    New Name
    Edit Card Title Using Pencil Icon    ${list}    ${card}    ${new_name}
    Verify Card Exists    ${list}    ${new_name}
    [Teardown]    Run Keywords
    ...           Go To Card Modal    list_name=${list}    card_name=${new_name}
    ...           AND    Delete Current Card

*** Keywords ***
Cards Suite Setup
    Create Trello Session
    ${BOARD}=    Create A Board    CardTestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Login To Trello    ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Go To Board    CardTestBoard

Cards Suite Teardown
    Wait Until Keyword Succeeds    10    2.5    Delete A Board    ${TEST_SUITE_BOARD_ID}
    Delete All Sessions
    Close All Browsers
