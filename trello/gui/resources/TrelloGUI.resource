*** Settings ***
Documentation    Keywords and Variables for using Trello through GUI
Variables        core/variables/env_manager.py    TRELLO_EMAIL    TRELLO_PASSWORD
Resource         core/gui/resources/CommonGUI.resource

*** Variables ***
${GUI_BASE_URL}         https://trello.com/
${DEFAULT_EMAIL}        ${TRELLO_EMAIL}
${DEFAULT_PASSWORD}     ${TRELLO_PASSWORD}
