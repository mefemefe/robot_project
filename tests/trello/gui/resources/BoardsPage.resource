*** Settings ***
Documentation    Variables and Keywords for Trello's Boards Page 
...              (default page after logging in)
Resource         TrelloGUI.resource
Library          String

*** Variables ***
${BOARDS_PATH}          boards
### Locators ###
${YOUR_WORKSPACES}             css:h3.boards-page-section-header-name
${BOARD_BUTTON}                //div[@title="{}"]

*** Keywords ***
Verify Current Page Is Boards Page
    Wait Until Location Contains     ${BOARDS_PATH}
    Wait Until Element Is Visible    ${YOUR_WORKSPACES}
    Element Text Should Be           ${YOUR_WORKSPACES}    YOUR WORKSPACES

Go To Board
    [Documentation]    Receives the board name and goes to that board's page.
    [Arguments]        ${board_name}
    ${locator}=        Format String    ${BOARD_BUTTON}    ${board_name}
    Wait Until Element Is Visible    ${locator}
    Click Element      ${locator}
