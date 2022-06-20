*** Settings ***
Documentation    Variables and Keywords for the 
...              Card modal in Trello.
Resource         TrelloGUI.resource

*** Variables ***
### Locators ###
${MODAL_CLOSE_BUTTON}    //a[contains(@class,'dialog-close-button')]
${ARCHIVE_BUTTON}        //span[@title='Archive']
${DELETE_BUTTON}         //a[@title='Delete']
${DELETE_CONFIRM}        //input[@value='Delete']

*** Keywords ***
Archive Current Card
    [Documentation]    Archives the current card from inside the modal.
    Wait Until Element Is Visible    ${ARCHIVE_BUTTON}
    Click Element                    ${ARCHIVE_BUTTON}

Delete Current Card
    [Documentation]     The Keyword will first check if the card is archived,
    ...                 if it's not, it will archive it to be able to delete it.
    ${not_archived}=    Run Keyword And Return Status    Element Should Not Be Visible    ${DELETE_BUTTON}
    Run Keyword If      ${not_archived}    Archive Current Card
    Click Element       ${DELETE_BUTTON}
    Click Element       ${DELETE_CONFIRM}

Close Card Modal
    Click Element    ${MODAL_CLOSE_BUTTON}
