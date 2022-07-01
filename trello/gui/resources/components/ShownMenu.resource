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
${CLOSE_LIST_BUTTON}        xpath://li//a[@class='js-close-list']
${ARCHIVED_ITEMS_BUTTON}    xpath://a[contains(@class, 'js-open-archive')]
${SWITCH_TO_LIST_BUTTON}    xpath://div[@class='archive-controls']/a[contains(.,'Switch to lists')]
${MORE_OPTIONS_SIDEBAR}     xpath://a[contains(@class,'board-menu-navigation-item-link') and contains(.,'More')]
${ARCHIVED_LIST_NAME_FIELD}    xpath://div[@class='item-name']/span[.='{archived_list_title}']

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
Enter to the list archive
    [Documentation]    accesing to the archive menu in the sidebar
    Wait Until Element Is Enabled    ${MORE_OPTIONS_SIDEBAR}    timeout=10s
    Click Link    ${MORE_OPTIONS_SIDEBAR}
    Wait Until Element Is Enabled    ${ARCHIVED_ITEMS_BUTTON}            timeout=10s
    Click Link    ${ARCHIVED_ITEMS_BUTTON}
    Wait Until Element Is Enabled    ${SWITCH_TO_LIST_BUTTON}        timeout=10s
    Click Link   ${SWITCH_TO_LIST_BUTTON}

Close archive tab
    [Documentation]   close sidebar tab
    Wait Until Element Is Enabled   ${CLOSE_SHOW_MENU}            timeout=10s
    Click Link    ${CLOSE_SHOW_MENU}

Verify That A List Is In The Archive
    [Documentation]          Verify that a given header of a list matches
    [Arguments]              ${archived_list_title}
    ${list_name_locator_archive}=    Format String   ${ARCHIVED_LIST_NAME_FIELD}    archived_list_title=${archived_list_title}
    Wait Until Element Is Enabled    ${list_name_locator_archive}        timeout=10s
    Page Should Contain Element    ${list_name_locator_archive}
    
