*** Settings ***
Documentation    Variables and Keywords for Trello's Boards Page
...              (default page after logging in)
Resource         TrelloGUI.resource
Library          String

*** Variables ***
${BOARDS_PATH}          boards
### Locators ###
${YOUR_WORKSPACES}             css:h3.boards-page-section-header-name
${CREATE_NEW_BOARD_BUTTON}             xpath://div[@class="boards-page-board-section mod-no-sidebar"]//div[@class="board-tile mod-add"]
${BOARD_NAME_INPUT}             xpath://div[@title='Create board']/ancestor::section//input[@type="text"]
${CREATE_BUTTON}             xpath://div[@title='Create board']/ancestor::section//button[text()='Create']
${BOARD_BUTTON}                //div[@title="{}"]

*** Keywords ***
Verify Current Page Is Boards Page
    [Documentation]    Assert that the browser is showing the boards page.
    Wait Until Location Contains     ${BOARDS_PATH}
    Wait Until Element Is Visible    ${YOUR_WORKSPACES}
    Element Text Should Be           ${YOUR_WORKSPACES}    YOUR WORKSPACES

Click New Board Button
    [Documentation]    Clicks the button that creates a new board.
    Wait Until Location Contains     ${BOARDS_PATH}
    Wait Until Keyword Succeeds        10        2.5            Click Element           ${CREATE_NEW_BOARD_BUTTON}

Set Name to Board
    [Documentation]    Set the name of the board and press the create button
    [Arguments]        ${name}
    Wait Until Element Is Visible           ${BOARD_NAME_INPUT}
    Input Text           ${BOARD_NAME_INPUT}    ${name}
    Wait Until Element Is Enabled           ${CREATE_BUTTON}
    Click Element           ${CREATE_BUTTON}

Go To Board
    [Documentation]    Receives the board name and goes to that board's page.
    [Arguments]        ${board_name}
    ${locator}=        Format String    ${BOARD_BUTTON}    ${board_name}
    Wait Until Element Is Visible    ${locator}
    Click Element      ${locator}

