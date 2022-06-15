*** Settings ***
Documentation    Variables and Keywords for Trello's Boards Page 
...              (default page after logging in)
Resource         TrelloGUI.resource

*** Variables ***
${BOARDS_PATH}          boards
### Locators ###
${YOUR_WORKSPACES}             css:h3.boards-page-section-header-name

*** Keywords ***
Verify Current Page Is Boards Page
    Wait Until Location Contains     ${BOARDS_PATH}
    Wait Until Element Is Visible    ${YOUR_WORKSPACES}
    Element Text Should Be           ${YOUR_WORKSPACES}    YOUR WORKSPACES
