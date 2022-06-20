*** Settings ***
Documentation    Test Cases for Cards Feature
Resource         resources/LoginPage.resource
Resource         tests/trello/api/resources/Board.resource
Resource         resources/BoardsPage.resource
Suite Setup      Cards Suite Setup

*** Test Cases ***
Test
    [Tags]    gui    card
    Log    Did this work?

*** Keywords ***
Cards Suite Setup
    Create Trello Session
    ${BOARD}=    Create A Board    CardTestBoard
    Set Suite Variable    \${TEST_SUITE_BOARD_ID}    ${BOARD.json()}[id]

Cards Suite Teardown
    Delete A Board    ${TEST_SUITE_BOARD_ID}
    Delete All Sessions