
*** Settings ***
Documentation    Variables and Keywords for the
...              Filter modal in Trello.
Resource         ../TrelloGUI.resource

*** Variables ***

${NO_LABELS_FILTER}    //span[@aria-label='LabelIcon']

*** Keywords ***
Click no labels filter
    [Documentation]    filters all cards with labes
    Wait Until Element Is Visible    ${NO_LABELS_FILTER}
    Click Element                    ${NO_LABELS_FILTER}
