*** Settings ***
Documentation    Variables and Keywords for Trello's Board Page Top menu bar
...              (default page after logging in, the top bar, where the title of the board is located)
*** Variables ***
### Locators ###
${NAME_OF_BOARD}             xpath://h1[contains(@class, 'js-board-editing-target')]
${NAME_OF_BOARD_INPUT}             xpath://input[contains(@class, 'board-name-input')]
${SHOW_MENU_BUTTON}             xpath://div[contains(@class, 'board-header')]//a[contains(., 'Show menu')]
${FILTER_BUTTON}                      xpath://button[@data-test-id='filter-popover-button']

*** Keywords ***
Verify Name of Board
    [Documentation]    Verifies the name of a board
    ...                name the board should have
    [Arguments]        ${name}  
    Wait Until Element Is Visible           ${NAME_OF_BOARD}    10   
    Element Text Should Be           ${NAME_OF_BOARD}    ${name}

Open Show Menu
    [Documentation]    Deletes the current board
    Wait Until Element Is Visible           ${SHOW_MENU_BUTTON}
    Click Element           ${SHOW_MENU_BUTTON}
    
Update Name of Board
    [Documentation]    Updates the name of a board
    ...                 it takes the Length of the boards's name in order to press the delete key 
    ...                 as many times as the name's length
    [Arguments]        ${name} 
    Wait Until Element Is Visible           ${NAME_OF_BOARD}
    ${response}=       Get Text    ${NAME_OF_BOARD}
    ${names_lenght}=       Get Length    ${response}    
    Click Element           ${NAME_OF_BOARD}
    Press Keys           ${NAME_OF_BOARD_INPUT}         \ue011
    Repeat Keyword           ${names_lenght}         Press Keys   ${NAME_OF_BOARD_INPUT}         \ue017      
    Press Keys   ${NAME_OF_BOARD_INPUT}         ${name}
    Press Keys   ${NAME_OF_BOARD_INPUT}         \ue007
    
Enter to the side menu
    [Documentation]    accesing to the archive menu in the sidebar
    Wait Until Element Is Enabled    ${SHOW_MENU_BUTTON}    timeout=10s
    Click Link    ${SHOW_MENU_BUTTON}

Enter To Filter Menu
    [Documentation]    accesing to the filter menu
    Click Element    ${FILTER_BUTTON}
