*** Settings ***
Documentation    Variables and Keywords for Trello's Board Page Menu that is Show when clicking
...              show menu in the top bar 
Resource         ../TrelloGUI.resource
*** Variables ***
### Locators ###
${MORE_BUTTON}             xpath://div[contains(@class, 'board-menu-content')]//a[contains(text(), 'More')]
${CLOSE_BOARD_BUTTON}             xpath://div[@class= 'board-menu-content-frame']//a[contains(text(), 'Close board')]
${CLOSE_BUTTON}             xpath://div[@class= 'no-back']//input
${PERMANENTLY_DELETE_BUTTON}             xpath://button[text()= 'Permanently delete board']
${CONFIRM_DELETE_BUTTON}             xpath://section//button[text()= 'Delete']
${CHANGE_NAME_OF_BOARD_FIELD}             xpath://input[contains(@class, 'board-name-input')]
${ABOUT_THIS_BOARD}             xpath://div[contains(@class, 'board-menu-content')]//a[contains(text(), 'About')]
${DESCRIPTION}             xpath://a[contains(@class, 'description-fake-text-area')]
${DESC_TEXT_AREA}             xpath://div[contains(@class, 'board-menu-content')]//textarea
${SAVE_DESC_BUTTON}             xpath://div[contains(@class, 'board-menu-content')]//input[@value="Save"]
${GO_BACK_BUTTON}             xpath://a[@title="Go back."]
${CLOSE_SHOW_MENU}             xpath://a[@title="Close the board menu."]

*** Keywords ***
Delete Current Board
    [Documentation]    Deletes the current board
    Wait Until Element Is Visible           ${MORE_BUTTON}
    Click Element           ${MORE_BUTTON}
    Wait Until Element Is Visible           ${CLOSE_BOARD_BUTTON}
    Click Element           ${CLOSE_BOARD_BUTTON} 
    Wait Until Element Is Visible           ${CLOSE_BUTTON}
    Click Element          ${CLOSE_BUTTON}
    Wait Until Element Is Visible           ${PERMANENTLY_DELETE_BUTTON}
    Click Element           ${PERMANENTLY_DELETE_BUTTON}
    Wait Until Element Is Visible           ${CONFIRM_DELETE_BUTTON}
    Click Element           ${CONFIRM_DELETE_BUTTON}   

Update Description of Board
    [Documentation]    Updates the description of a board
    [Arguments]        ${desc} 
    Wait Until Element Is Visible           ${ABOUT_THIS_BOARD}
    Click Element           ${ABOUT_THIS_BOARD}
    Wait Until Element Is Visible           ${DESCRIPTION}
    Click Element           ${DESCRIPTION}
    Input Text           ${DESC_TEXT_AREA}    ${desc}
    Wait Until Element Is Visible           ${SAVE_DESC_BUTTON}
    Click Element           ${SAVE_DESC_BUTTON}
    Click Element           ${GO_BACK_BUTTON}
    Click Element           ${CLOSE_SHOW_MENU}