*** Settings ***
Documentation    Variables and Keywords for handling lists 

Resource         TrelloGUI.resource

*** Variables ***
### LOCATORS
${BOARD_BUTTON}     xpath://a[@class='board-tile' and contains(., "Behave")]
${ADD_LIST_BUTTON}    xpath://a[@class='open-add-list js-open-add-list']
${LIST_NAME_INPUT}    xpath://input[@class="list-name-input"]
${LIST_TEXT_AREA_NAME}    xpath://div[@class='js-list list-wrapper'][last()]//textarea

${NEW_LIST_HEADER}    //div[@class='js-list list-wrapper'][last()]//div[@class='list-header js-list-header u-clearfix is-menu-shown']
${PRE_TEXT_AREA_BUTTON}    xpath://div[@class="list-header-target js-editing-target"]
${TO_CHECK_LIST_HEADER}    //div[@class='list-header js-list-header u-clearfix is-menu-shown']/h2[contains(.,'MODIFIED_LIST')]

${CLOSE_LIST_BUTTON}    xpath://li//a[@class='js-close-list']
${SHOW_SIDEBAR_BUTTON}    xpath://a[@class='board-header-btn mod-show-menu js-show-sidebar']
${ARCHIVED_ITEMS_BUTTON}    xpath://a[@class='board-menu-navigation-item-link js-open-archive']
${SWITCH_TO_LIST_BUTTON}    xpath://div[@class='archive-controls']/a[contains(.,'Switch to lists')]
${MORE_OPTIONS_SIDEBAR}     xpath://a[@class='board-menu-navigation-item-link js-open-more']
${LIST_NAME_FIELD}    xpath://div[@class='item-name']/span[.='TO_ARCHIVE']
${CLOSE_ARCHIVE_X}    xpath://a[@title='Close the board menu.']

*** Keywords ***
Create new list with the name
    [Documentation]    Create  a new list with the given name
    [Arguments]    ${LIST_NAME}
    Wait Until Page Contains Element      ${ADD_LIST_BUTTON}        timeout=10s
    Click Link     ${ADD_LIST_BUTTON}
    Wait Until Page Contains Element       ${LIST_NAME_INPUT}    timeout=10s
    Sleep    5s
    Input text    ${LIST_NAME_INPUT}    ${LIST_NAME}
    Press Keys     ${LIST_NAME_INPUT}    RETURN

Modify the name of a list with
    [Documentation]    Modify the name of an existent list
    [Arguments]    ${OLD_NAME}    ${NEW_NAME}
    Click Element    xpath://div[@class='list-header js-list-header u-clearfix is-menu-shown' and contains(.,${OLD_NAME})]
    Sleep    5s
    Press Keys     ${LIST_NAME_INPUT}    BACKSPACE
    Sleep    3s
    Input Text    ${LIST_TEXT_AREA_NAME}    ${NEW_NAME}
    Press Keys    None    RETURN

Close a list
    [Documentation]    archives a list
    [Arguments]    ${LIST_TO_CLOSE}
    Sleep    5s
    Click Link     xpath://div[@class='js-list list-wrapper'][last()]//a[@aria-label="List actions"]
    Sleep    5s
    Click Link    ${CLOSE_LIST_BUTTON}

Enter to the list archive
    [Documentation]    accesing to the archive menu in the sidebar
    Click Link    ${SHOW_SIDEBAR_BUTTON}
    Wait Until Page Contains Element    ${MORE_OPTIONS_SIDEBAR}    timeout=10s
    Click Link    ${MORE_OPTIONS_SIDEBAR}
    Wait Until Page Contains Element   ${ARCHIVED_ITEMS_BUTTON}            timeout=10s
    Sleep    5s
    Click Link    ${ARCHIVED_ITEMS_BUTTON}
    Wait Until Page Contains Element    ${SWITCH_TO_LIST_BUTTON}        timeout=10s
    Sleep    5s
    Click Link   ${SWITCH_TO_LIST_BUTTON}
    Wait Until Page Contains Element    ${LIST_NAME_FIELD}        timeout=10s

Close archive tab
    Sleep    5s
    Wait Until Page Contains Element   ${CLOSE_ARCHIVE_X}            timeout=10s
    Click Link    ${CLOSE_ARCHIVE_X}
