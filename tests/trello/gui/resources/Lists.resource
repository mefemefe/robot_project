*** Settings ***
Documentation    Variables and Keywords for handling lists 

Resource         TrelloGUI.resource

*** Variables ***
### LOCATORS
${ADD_LIST_BUTTON}          xpath://a[@class='open-add-list js-open-add-list']
${LIST_NAME_INPUT}          xpath://input[@class="list-name-input"]
${LIST_TEXT_AREA_NAME}      xpath://div[@class='js-list list-wrapper'][last()]//textarea

${NEW_LIST_HEADER}          xpath://div[@class='js-list list-wrapper'][last()]//div[@class='list-header js-list-header u-clearfix is-menu-shown']
${PRE_TEXT_AREA_BUTTON}     xpath://div[@class="list-header-target js-editing-target"]
${TO_CHECK_LIST_HEADER}     xpath://div[@class='list-header js-list-header u-clearfix is-menu-shown']/h2[contains(.,'MODIFIED_LIST')]

${CLOSE_LIST_BUTTON}        xpath://li//a[@class='js-close-list']
${SHOW_SIDEBAR_BUTTON}      xpath://a[@class='board-header-btn mod-show-menu js-show-sidebar']
${ARCHIVED_ITEMS_BUTTON}    xpath://a[@class='board-menu-navigation-item-link js-open-archive']
${SWITCH_TO_LIST_BUTTON}    xpath://div[@class='archive-controls']/a[contains(.,'Switch to lists')]
${MORE_OPTIONS_SIDEBAR}     xpath://a[@class='board-menu-navigation-item-link js-open-more']
${LIST_NAME_FIELD}          xpath://div[@class='item-name']/span[.='TO_ARCHIVE']
${CLOSE_ARCHIVE_X}          xpath://a[@title='Close the board menu.']
${WATCH_LIST_BUTTON}        xpath://a[@class='highlight-icon js-list-subscribe']
${LIST_WATCHED_HEADER}      xpath://span[@class='list-header-extras-subscribe js-list-subscribed']

*** Keywords ***
Create new list with the name
    [Documentation]    Create  a new list with the given name
    [Arguments]    ${list_name}
    Wait Until Page Contains Element      ${ADD_LIST_BUTTON}        timeout=10s
    Click Link     ${ADD_LIST_BUTTON}
    Wait Until Element Is Enabled       ${LIST_NAME_INPUT}    timeout=10s
    Input text    ${LIST_NAME_INPUT}    ${list_name}
    Press Keys     ${LIST_NAME_INPUT}    RETURN

Modify the name of a list with
    [Documentation]    Modify the name of an existent list
    [Arguments]    ${old_name}    ${new_name}
    Click Element    xpath://div[@class='list-header js-list-header u-clearfix is-menu-shown' and contains(.,${old_name})]
    Press Keys     ${LIST_NAME_INPUT}    BACKSPACE
    Input Text    ${LIST_TEXT_AREA_NAME}    ${new_name}
    Press Keys    None    RETURN

Close a list
    [Documentation]    archives a list
    Click Link     xpath://div[@class='js-list list-wrapper'][last()]//a[@aria-label="List actions"]
    Click Link    ${CLOSE_LIST_BUTTON}

Enter to the list archive
    [Documentation]    accesing to the archive menu in the sidebar
    Wait Until Page Contains Element    ${SHOW_SIDEBAR_BUTTON}    timeout=10s
    Click Link    ${SHOW_SIDEBAR_BUTTON}
    Wait Until Page Contains Element    ${MORE_OPTIONS_SIDEBAR}    timeout=10s
    Click Link    ${MORE_OPTIONS_SIDEBAR}
    Wait Until Element Is Enabled    ${ARCHIVED_ITEMS_BUTTON}            timeout=10s
    Click Link    ${ARCHIVED_ITEMS_BUTTON}
    Wait Until Element Is Enabled    ${SWITCH_TO_LIST_BUTTON}        timeout=10s
    Click Link   ${SWITCH_TO_LIST_BUTTON}
    Wait Until Element Is Enabled    ${LIST_NAME_FIELD}        timeout=10s

Close archive tab
    [Documentation]   close sidebar tab
    Wait Until Page Contains Element   ${CLOSE_ARCHIVE_X}            timeout=10s
    Click Link    ${CLOSE_ARCHIVE_X}

Click watch/unwatch button
    [Documentation]    click to watch/unwatch the last list on ui
    Click Link     xpath://div[@class='js-list list-wrapper'][last()]//a[@aria-label="List actions"]
    Click Link    ${WATCH_LIST_BUTTON}


