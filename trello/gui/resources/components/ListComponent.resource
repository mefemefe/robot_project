*** Settings ***
Documentation    Variables and Keywords for the List Element in Trello's Board Page.
Library          String
Resource         ../TrelloGUI.resource

*** Variables ***
${LIST_DIV}                //h2[text()='{list_name}']//ancestor::div[contains(@class, 'list-content')]
${LIST_ADD_CARD}           ${LIST_DIV}//a[contains(.,'Add a card')]
${LIST_CARD_NAME}          ${LIST_DIV}//a[contains(.,'{card_name}')]
${CARD_ANCHORS}            ${LIST_DIV}//a[contains(@class, 'list-card')]
${CARD_TITLE_INPUT}        ${LIST_DIV}//textarea[contains(@class, 'list-card-composer-textarea')]
${CONFIRM_ADD_CARD}        ${LIST_DIV}//input[@value='Add card']
${PENCIL_ICON}             ${LIST_CARD_NAME}//span[contains(@class, 'icon-edit')]
${CARD_EDIT_TITLE}         css:textarea.list-card-edit-title
${CARD_EDIT_TITLE_SAVE}    //input[@value='Save']
${ADD_LIST_BUTTON}          xpath://a[contains(@Class, 'open-add-list')]
${LIST_NAME_INPUT}          xpath://input[@class="list-name-input"]
${LIST_TEXT_AREA_NAME}      xpath://div[@class='js-list list-wrapper'][last()]//textarea
${LIST_ACTIONS_BUTTON}       xpath://div[@class='js-list list-wrapper'][last()]//a[@aria-label="List actions"]
${LIST_NAME_HEADER}         xpath://div[@class='list-header js-list-header u-clearfix is-menu-shown' and contains(.,'{old_name}')]
${CLOSE_LIST_BUTTON}        xpath://li//a[@class='js-close-list']

*** Keywords ***
Create Card In List
    [Documentation]                  Create a new card in the given list
    ...                              Required args: list_name, card_name
    [Arguments]                      ${list_name}    ${card_name}
    ${add_card_locator}=             Format String    ${LIST_ADD_CARD}    list_name=${list_name}
    Wait Until Element Is Visible    ${add_card_locator}
    Click Element                    ${add_card_locator}
    ${textarea_locator}=             Format String    ${CARD_TITLE_INPUT}    list_name=${list_name}
    Wait Until Element Is Visible    ${textarea_locator}
    Click Element                    ${textarea_locator}
    Clear Element Text               ${textarea_locator}
    Input Text                       ${textarea_locator}    ${card_name}
    ${confirm_locator}=              Format String    ${CONFIRM_ADD_CARD}    list_name=${list_name}
    Click Button                     ${confirm_locator}

Verify Card Exists
    [Documentation]              Verify that the card with card_name exists in the given list.
    [Arguments]                  ${list_name}    ${card_name}
    ${card_name_locator}=        Format String    ${LIST_CARD_NAME}    list_name=${list_name}    card_name=${card_name}
    Element Should Be Visible    ${card_name_locator}

Go To Card Modal
    [Documentation]                  It opens the modal for card_name in list_name
    [Arguments]                      ${list_name}     ${card_name}
    ${card_name_locator}=            Format String    ${LIST_CARD_NAME}    list_name=${list_name}    card_name=${card_name}
    Wait Until Element Is Visible    ${card_name_locator}
    Click Element                    ${card_name_locator}

Edit Card Title Using Pencil Icon
    [Documentation]        Modifies the title of the given card, using the pencil icon
    ...                    required: list_name, card_name, new_title
    [Arguments]            ${list_name}     ${card_name}    ${new_title}
    ${card_element}=       Format String    ${LIST_CARD_NAME}    list_name=${list_name}    card_name=${card_name}
    ${pencil_locator}=     Format String    ${PENCIL_ICON}    list_name=${list_name}    card_name=${card_name}
    Wait Until Element Is Visible    ${card_element}
    Mouse Over             ${card_element}
    Wait Until Page Contains Element    ${pencil_locator}
    Click Element          ${pencil_locator}
    Wait Until Element Is Visible    ${CARD_EDIT_TITLE}
    Click Element          ${CARD_EDIT_TITLE}
    Clear Element Text     ${CARD_EDIT_TITLE}
    Input Text             ${CARD_EDIT_TITLE}    ${new_title}
    Click Element          ${CARD_EDIT_TITLE_SAVE}

Get Number Of Cards In List
    [Documentation]                Return the number of cards present in a given list.
    ...                            required: list_name
    [Arguments]                    ${list_name}
    ${card_anchor_locator}=        Format String    ${CARD_ANCHORS}    list_name=${list_name}
    ${n}=     Get Element Count    ${card_anchor_locator}
    RETURN    ${n}

Card Should Be In List
    [Documentation]              Check that a card is visible and in the given list
    ...                          required: card_name, list_name
    [Arguments]                  ${card_name}    ${list_name}
    ${card_locator}=             Format String    ${LIST_CARD_NAME}    list_name=${list_name}    card_name=${card_name}
    Element Should Be Visible    ${card_locator}

Drag Card From One List To Another
    [Documentation]                  required: card_name, source_list_name, target_list_name
    [Arguments]                      ${card_name}    ${list1_name}    ${list2_name}
    ${card_locator}=                 Format String    ${LIST_CARD_NAME}    list_name=${list1_name}    card_name=${card_name}
    ${list2_locator}=                Format String    ${LIST_DIV}    list_name=${list2_name}
    Wait Until Element Is Visible    ${card_locator}
    Drag And Drop                    ${card_locator}    ${list2_locator}

Create new list with the name
    [Documentation]    Create  a new list with the given name
    [Arguments]    ${list_name}
    Wait Until Page Contains Element      ${ADD_LIST_BUTTON}        timeout=10s
    Click Link     ${ADD_LIST_BUTTON}
    Wait Until Element Is Enabled       ${LIST_NAME_INPUT}    timeout=10s
    Input text    ${LIST_NAME_INPUT}    ${list_name}
    Press Keys     ${LIST_NAME_INPUT}    RETURN

Verify That The List Exists
    [Documentation]          Verify that a given header of a list matches
    [Arguments]              ${list_name}
    ${list_name_locator}=    Format String   ${LIST_DIV}    list_name=${list_name}
    Wait Until Element Is Visible    ${list_name_locator}
    Page Should Contain Element    ${list_name_locator}

Modify the name of a list with
    [Documentation]    Modify the name of an existent list
    [Arguments]    ${old_name}    ${new_name}
    ${name_header_instance}=    Format String   ${LIST_NAME_HEADER}    old_name=${old_name}
    Wait Until Element Is Enabled       ${name_header_instance}    timeout=10s
    Click Element    ${name_header_instance}
    Wait Until Element Is Enabled       ${LIST_NAME_INPUT}    timeout=10s
    Press Keys     ${LIST_NAME_INPUT}    BACKSPACE
    Input Text    ${LIST_TEXT_AREA_NAME}    ${new_name}
    Press Keys    None    RETURN

Close a list
    [Documentation]    archives a list
    Wait Until Element Is Enabled       ${LIST_ACTIONS_BUTTON}    timeout=10s
    Wait Until Keyword Succeeds        10        2.5            Click Link    ${LIST_ACTIONS_BUTTON}
    Wait Until Element Is Enabled       ${CLOSE_LIST_BUTTON}    timeout=10s
    Wait Until Keyword Succeeds        10        2.5            Click Link    ${CLOSE_LIST_BUTTON}

Click pencil menu
    [Documentation]        Adds a label to an specific card
    [Arguments]            ${list_name}     ${card_name}
    ${card_element}=       Format String    ${LIST_CARD_NAME}    list_name=${list_name}    card_name=${card_name}
    ${pencil_locator}=     Format String    ${PENCIL_ICON}    list_name=${list_name}    card_name=${card_name}
    Wait Until Element Is Visible    ${card_element}
    Sleep   5s
    Mouse Over             ${card_element}
    Sleep    5s
    Wait Until Page Contains Element    ${pencil_locator}
    Click Element          ${pencil_locator}

Card Should Not Be In List
    [Documentation]              Check that a card is visible and in the given list
    ...                          required: card_name, list_name
    [Arguments]                  ${card_name}    ${list_name}
    ${card_locator}=             Format String    ${LIST_CARD_NAME}    list_name=${list_name}    card_name=${card_name}
    Element Should Not Be Visible    ${card_locator}


