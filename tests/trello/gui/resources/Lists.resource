*** Settings ***
Documentation    Variables and Keywords for handling lists 

Resource         TrelloGUI.resource

*** Variables ***
### LOCATORS
${BOARD_BUTTON}     xpath://a[@class='board-tile' and contains(., "Behave")]
${ADD_LIST_BUTTON}    xpath://a[@class='open-add-list js-open-add-list']
${LIST_NAME_INPUT}    xpath://input[@class="list-name-input"]
${LIST_TEXT_AREA_NAME}    xpath://textarea[@class='list-header-name mod-list-name js-list-name-input' and @aria-label='NEW_TEST_LIST']

${NEW_LIST_HEADER}    xpath://div[@class='list-header js-list-header u-clearfix is-menu-shown' and contains(.,'NEW_TEST_LIST')]
${PRE_TEXT_AREA_BUTTON}    xpath://div[@class="list-header-target js-editing-target"]
${MODIFIED_LIST_HEADER}    //h2[@class="list-header-name-assist js-list-name-assist" and .="MODIFIED_LIST"]
${LIST_HEADER}    xpath://div[@class='list-header js-list-header u-clearfix is-menu-shown']

${MORE_OPTIONS_BUTTON_LISTS}    xpath://div[@class='list-header js-list-header u-clearfix is-menu-shown' and contains(.,'MODIFIED_LIST') ]//a
${CLOSE_LIST_BUTTON}    xpath://li//a[@class='js-close-list']
${SHOW_SIDEBAR_BUTTON}    xpath://a[@class='board-header-btn mod-show-menu js-show-sidebar']
${ARCHIVED_ITEMS_BUTTON}    xpath://a[@class='board-menu-navigation-item-link js-open-archive']
${SWITCH_TO_LIST_BUTTON}    xpath://div[@class='archive-controls']/a[contains(.,'Switch to lists')]
${MORE_OPTIONS_SIDEBAR}     xpath://a[@class='board-menu-navigation-item-link js-open-more']
${LIST_NAME_FIELD}    //div[@class='item-name']/span[.='MODIFIED_LIST']

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
    [Documentation]    Modify the name of an existent list named NEW_TEST_LIST
    [Arguments]    ${NEW_NAME}
    Click Element    ${NEW_LIST_HEADER}
    Sleep    5s
    Press Keys     ${LIST_NAME_INPUT}    BACKSPACE
    Sleep    3s
    Input Text    ${LIST_TEXT_AREA_NAME}    ${NEW_NAME}
    Press Keys    None    RETURN

Archive a list
    [Documentation]    archives a list
    Wait Until Page Contains Element    ${NEW_LIST_HEADER}    timeout=10s
    Sleep    5s
    Click Link     ${MORE_OPTIONS_BUTTON_LISTS}
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