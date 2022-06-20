*** Settings ***
Documentation    Keywords and Variables for using Trello through GUI
Variables        tests/common/variables/env_manager.py    TRELLO_EMAIL    TRELLO_PASSWORD
Resource         tests/common/gui/resources/CommonGUI.resource

*** Variables ***
${GUI_BASE_URL}             https://trello.com/
${DEFAULT_EMAIL}        ${TRELLO_EMAIL}
${DEFAULT_PASSWORD}     ${TRELLO_PASSWORD}
