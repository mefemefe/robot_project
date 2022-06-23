*** Settings ***
Documentation    Variables and Keywords for Trello's Boards Page 
...              (default page after logging in)
Resource         TrelloGUI.resource

*** Variables ***
${BOARDS_PATH}          boards
### Locators ###
${YOUR_WORKSPACES}             css:h3.boards-page-section-header-name
${CREATE_NEW_BOARD_BUTTON}             xpath://div[@class="boards-page-board-section mod-no-sidebar"]//div[@class="board-tile mod-add"]
${BOARD_NAME_INPUT}             xpath://div[@title='Create board']/ancestor::section//input[@type="text"]
${CREATE_BUTTON}             xpath://div[@title='Create board']/ancestor::section//button[text()='Create']

*** Keywords ***
Verify Current Page Is Boards Page
    Wait Until Location Contains     ${BOARDS_PATH}   
    Wait Until Element Is Visible    ${YOUR_WORKSPACES}
    Element Text Should Be           ${YOUR_WORKSPACES}    YOUR WORKSPACES

Click New Board Button
    Wait Until Location Contains     ${BOARDS_PATH}
    Wait Until Element Is Visible    ${CREATE_NEW_BOARD_BUTTON} 
    Click Element           ${CREATE_NEW_BOARD_BUTTON}
      

Set Name to Board
    [Documentation]    Creates a new Board
    ...                name the board will have 
    [Arguments]        ${name}  
    Wait Until Element Is Visible           ${BOARD_NAME_INPUT} 
    Input Text           ${BOARD_NAME_INPUT}    ${name} 
    Wait Until Element Is Enabled           ${CREATE_BUTTON} 
    Click Element           ${CREATE_BUTTON}


