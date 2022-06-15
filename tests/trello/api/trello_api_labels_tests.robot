*** Settings ***
Documentation    Example Test with Trello API Cards
Library          RequestsLibrary
Resource         ../tests/trello/api/resources/Label.resource



*** Test Cases ***
Create and get label on board
    [Tags]             smoke    api    label.create    label.get
    Create Trello Session
    ${response}=       Create A Label    name    label2    color   yellow
    ${LABEL_ID}=       Get Information From Response    ${response}    id
    ${response}=    Get A Label    ${LABEL_ID}
    ${LABEL_COLOR}=       Get Information From Response    ${response}    color
    ${LABEL_NAME}=       Get Information From Response    ${response}    name
    Should Be Equal    ${LABEL_COLOR}     yellow
    Should Be Equal    ${LABEL_NAME}     label2
    [Teardown]    Delete A Label     ${LABEL_ID}


Update label on board
    [Tags]             smoke    api    label.update
    Create Trello Session
    ${response}=       Create A Label    name    label2    color   yellow
    ${LABEL_ID}=       Get Information From Response    ${response}    id
    ${response}=       Update A Label   ${LABEL_ID}    name    label3    color    orange
    ${NEW_LABEL_COLOR}=       Get Information From Response    ${response}    color
    ${NEW_LABEL_NAME}=       Get Information From Response    ${response}    name
    Should Be Equal    ${NEW_LABEL_COLOR}     orange
    Should Be Equal    ${NEW_LABEL_NAME}     label3
    [Teardown]    Delete A Label     ${LABEL_ID}

Delete label on board
    [Tags]             smoke    api    label.delete
    Create Trello Session
    ${response}=       Create A Label    name    label2    color   yellow
    ${LABEL_ID}=       Get Information From Response    ${response}    id
    Delete A Label     ${LABEL_ID}
    Verify if Label is deleted    ${LABEL_ID}

Verify label schema
    [Tags]             smoke    api    label.schema
    Create Trello Session
    ${response}=    Get labels from board
    Validate Response Schema     ${response}   labels_on_board








