*** Settings ***
Documentation    Variables and Keywords for Trello's Upper menu
...              (can be seen from all over the web app)


*** Variables ***
### Locators ###
${TRELLO_ICON}             xpath://a[@aria-label='Back to home']

*** Keywords ***
Go Home
     [Documentation]    it goes to the gome page
     Wait Until Element Is Enabled    ${TRELLO_ICON}
     Click Element           ${TRELLO_ICON}