*** Settings ***
Documentation    Variables and Keywords for the
...              Card modal in Trello.
Resource         ../TrelloGUI.resource

*** Variables ***
${MODAL_CLOSE_BUTTON}    //a[contains(@class,'dialog-close-button')]
${ARCHIVE_BUTTON}        //span[@title='Archive']
${DELETE_BUTTON}         //a[@title='Delete']
${IS_ARCHIVED_MSG}       //p[text()='This card is archived.']
${DELETE_CONFIRM}        //input[@value='Delete']
${MOVE_BUTTON}           //a[@title='Move']
${SELECT_DESTINATION}    //select[@data-test-id='move-board-select']
${ACCEPT_MOVE_BUTTON}     //input[@value="Move"]
${COMMENT_BOX_INPUT}     //div[@class='comment-box']/textarea
${SAVE_COMMENT}          //div[contains(@class, 'comment-controls')]//input[@value='Save']
${COMMENT_DIV}           //div[@class='comment-container']
${EDIT_LABEL}           //a[contains(@class,'js-edit-labels')]
${LABEL_COLOR_MENU}     //span[contains(@data-color,'{color}')]
${CREATE_A_NEW_LABEL}    //button[contains(.,'Create a new label')]
${LABEL_INPUT}           //input[contains(@class,"js-autofocus")]

*** Keywords ***
Archive Current Card
    [Documentation]    Archives the current card from inside the modal.
    Wait Until Element Is Visible    ${ARCHIVE_BUTTON}
    Click Element                    ${ARCHIVE_BUTTON}

Delete Current Card
    [Documentation]     The Keyword will first check if the card is archived,
    ...                 if it's not, it will archive it to be able to delete it.
    ${not_archived}=    Run Keyword And Return Status    Element Should Not Be Visible    ${IS_ARCHIVED_MSG}
    Run Keyword If      ${not_archived}    Archive Current Card
    Wait Until Keyword Succeeds    ${DEFAULT_TIMEOUT}    ${DEFAULT_INTERVAL}    Click Element    ${DELETE_BUTTON}
    Click Element       ${DELETE_CONFIRM}

Close Card Modal
    [Documentation]    Closes the modal using the upper-right 'X'
    Wait Until Element Is Visible    ${MODAL_CLOSE_BUTTON}
    Click Element    ${MODAL_CLOSE_BUTTON}

Send A Comment
    [Documentation]    Sends a comment under the "activity" section of the modal
    ...                required: comment
    [Arguments]        ${comment}
    Wait Until Element Is Visible    ${COMMENT_BOX_INPUT}
    Click Element      ${COMMENT_BOX_INPUT}
    Clear Element Text    ${COMMENT_BOX_INPUT}
    Input Text         ${COMMENT_BOX_INPUT}    ${comment}
    Click Element      ${SAVE_COMMENT}

Get Number Of Comments
    [Documentation]    Return the number of comments present in the modal.
    ${n}=     Get Element Count    ${COMMENT_DIV}
    RETURN    ${n}


Add Color Label In Card
    [Documentation]              add label of a given color to a list
    [Arguments]                  ${color}
    Wait Until Element Is Enabled       ${EDIT_LABEL}    timeout=${DEFAULT_TIMEOUT}s
    Click Element    ${EDIT_LABEL}
    Wait Until Element Is Enabled      ${LABEL_INPUT}    timeout=${DEFAULT_TIMEOUT}s
    Click Element    ${LABEL_INPUT}
    Input Text                     ${LABEL_INPUT}     ${color}
    Wait Until Element Is Enabled      ${LABEL_INPUT}    timeout=${DEFAULT_TIMEOUT}s
    Press Keys                       ${LABEL_INPUT}    RETURN
    Press Keys    None    ESCAPE
    Press Keys    None    ESCAPE

Move Card To Another Board
    [Documentation]    Moves the card using the "name of destination board"
    ...                required: name (name of the destination board)
    [Arguments]        ${name_of_destination_board}
    Wait Until Element Is Visible    ${MOVE_BUTTON}
    Click Element    ${MOVE_BUTTON}
    Select From List By Label           ${SELECT_DESTINATION}           ${name_of_destination_board}
    Wait Until Element Is Enabled       ${ACCEPT_MOVE_BUTTON}
    Click Element    ${ACCEPT_MOVE_BUTTON}
    Wait Until Element Is Not Visible       ${ARCHIVE_BUTTON}

