*** Settings ***
Documentation    Variables and Keywords for Trello's Upper menu
...              (can be seen from all over the web app)


*** Variables ***
### Locators ###
${TRELO_ICON}             xpath://a[@aria-label='Back to home']

*** Keywords ***
Go Home
     Click Element           ${TRELO_ICON}