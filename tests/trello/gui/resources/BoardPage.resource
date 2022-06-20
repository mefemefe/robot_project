*** Settings ***
Documentation    Variables and Keywords for a 
...              Board page in Trello.
Resource         TrelloGUI.resource
Resource         CardModal.resource
Library          String

*** Variables ***

### Locators ###
## List Object
${LIST_DIV}            //h2[text()='{list_name}']//ancestor::div[contains(@class, 'list-content')]
${LIST_ADD_CARD}       ${LIST_DIV}//a[contains(.,'Add a card')]
${LIST_CARD_NAME}      ${LIST_DIV}//a[contains(.,'{card_name}')]
${CARD_TITLE_INPUT}    ${LIST_DIV}//textarea[contains(@class, 'list-card-composer-textarea')]
${CONFIRM_ADD_CARD}    ${LIST_DIV}//input[@value='Add card']


*** Keywords ***
Create Card In List
    [Documentation]    Create a new card in the given list
    ...                Required args: list_name, card_name
    [Arguments]    ${list_name}    ${card_name}
    ${add_card_locator}=    Format String    ${LIST_ADD_CARD}    list_name=${list_name}
    Wait Until Element Is Visible    ${add_card_locator}
    Click Element    ${add_card_locator}
    ${textarea_locator}=    Format String    ${CARD_TITLE_INPUT}    list_name=${list_name}
    Wait Until Element Is Visible    ${textarea_locator}
    Click Element     ${textarea_locator}
    Clear Element Text    ${textarea_locator}
    Input Text    ${textarea_locator}    ${card_name}
    ${confirm_locator}=    Format String    ${CONFIRM_ADD_CARD}    list_name=${list_name}
    Click Button    ${confirm_locator}

Verify Card Was Created
    [Documentation]         Verify that the card with card_name exists in the given list.
    [Arguments]             ${list_name}    ${card_name}
    ${card_name_locator}=    Format String    ${LIST_CARD_NAME}    list_name=${list_name}    card_name=${card_name}
    Element Should Be Visible    ${card_name_locator}

Go To Card Modal
    [Documentation]        It opens the modal for card_name in list_name
    [Arguments]    ${list_name}    ${card_name}
    ${card_name_locator}=    Format String    ${LIST_CARD_NAME}    list_name=${list_name}    card_name=${card_name}
    Wait Until Element Is Visible    ${card_name_locator}
    Click Element    ${card_name_locator}
