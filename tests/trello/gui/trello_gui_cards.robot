*** Settings ***
Documentation     Test Cases for Cards Feature
Resource          resources/LoginPage.resource
Resource          tests/trello/api/resources/Board.resource
Resource          resources/BoardsPage.resource
Resource          resources/BoardPage.resource
Resource          resources/components/TrelloUpperMenu.resource
Suite Setup       Cards Suite Setup
Suite Teardown    Cards Suite Teardown

*** Test Cases ***
Verify A Card Can Be Created
    [Documentation]    Verify that it is possible to create a new
    ...                card through Trello's GUI.
    [Tags]    smoke    gui    card.create
    Set Test Variable     \${list}     To Do
    Set Test Variable     \${card}     Test Card
    Create Card In List    ${list}     ${card}
    Verify Card Exists     ${list}     ${card}
    [Teardown]    Run Keywords
    ...           Go To Card Modal    list_name=${list}    card_name=${card}
    ...           AND    Delete Current Card

Modify A Card's Name From The Board Page
    [Documentation]    Verify that it is possible to edit a card's Name
    ...                using the pencil icon in the board page.
    [Tags]    regression    gui    card.title_board
    Set Test Variable     \${list}    To Do
    Set Test Variable     \${card}    Test Card
    Create Card In List    ${list}    ${card}
    Set Test Variable     \${new_name}    New Name
    Edit Card Title Using Pencil Icon     ${list}    ${card}    ${new_name}
    Verify Card Exists     ${list}    ${new_name}
    [Teardown]    Run Keywords
    ...           Go To Card Modal    list_name=${list}    card_name=${new_name}
    ...           AND    Delete Current Card

Leave A Comment On A Card
    [Documentation]    Verify that it is possible to write a comment
    ...                on a card, through the card modal.
    [Tags]    regression    gui    card.comment
    Set Test Variable     \${list}    To Do
    Set Test Variable     \${card}    Test Card
    Create Card In List    ${list}    ${card}
    Go To Card Modal       ${list}    ${card}
    ${comments_before}=    Get Number Of Comments
    Send A Comment         This is a test comment
    ${comments_after}=     Get Number Of Comments
    Should Be True         ${comments_after} == ${comments_before}+${1}
    [Teardown]             Delete Current Card

Verify A Card Can Be Deleted
    [Documentation]    Verify that it is possible to delete a card
    ...                from inside the card modal.
    [Tags]    smoke    gui    card.delete
    Set Test Variable     \${list}    To Do
    Set Test Variable     \${card}    Test Card
    ${cards_before}=       Get Number Of Cards In List    ${list}
    Create Card In List    ${list}    ${card}
    Go To Card Modal       ${list}    ${card}
    Delete Current Card
    ${cards_after}=        Get Number Of Cards In List    ${list}
    Should Be True         ${cards_before} == ${cards_after}

Card Can Be Dragged To Another List
    [Documentation]    Verify that a card can be dragged from one list to another.
    [Tags]    regression    gui    card.drag
    Set Test Variable         \${list}    To Do
    Set Test Variable         \${card}    Test Card
    Create Card In List        ${list}    ${card}
    Set Test Variable         \${list2}    Doing
    Drag Card From One List To Another    ${card}    ${list}    ${list2}
    Card Should Be In List     ${card}    ${list2}
    [Teardown]        Run Keywords
    ...               Go To Card Modal    ${list2}    ${card}
    ...               AND    Delete Current Card


Card Can Be Moved To Another Board
    [Tags]    regression    gui    card.move
    ${board2}=         Create A Board    CardTestBoard2
    Go Home
    Go To Board       CardTestBoard2
    Set Test Variable         \${list}    To Do
    Set Test Variable         \${card}    Test Card2
    Create Card In List        ${list}    ${card}
    Go To Card Modal           ${list}    ${card}
    Move Card To Another Board              CardTestBoard
    ${Cards_On_list}=       Get Number Of Cards In List       To Do
    ${0}=	                 Convert To Integer	             0
    Should Be Equal             ${Cards_On_list}        ${0}   
   [Teardown]      Run Keywords
    ...             Close Browser
    ...             AND  Delete A Board            ${board2.json()}[id]               

*** Keywords ***
Cards Suite Setup
    [Documentation]    Creates a new board through API, then Opens a Browser
    ...                Login to Trello, and Go to the created board's page.
    Create Trello Session
    ${BOARD}=    Create A Board    CardTestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]
    Open Browser From Environment    ${LOGIN_URL}
    Maximize Browser Window
    Login To Trello        ${DEFAULT_EMAIL}    ${DEFAULT_PASSWORD}
    Go To Board            CardTestBoard
    

Cards Suite Teardown
    [Documentation]    Deletes the created board through API and closes all browsers.
    Wait Until Keyword Succeeds    10    2.5    Delete A Board    ${TEST_SUITE_BOARD_ID}
    Delete All Sessions
    Close All Browsers
