*** Settings ***
Documentation    Keywords and Variables for using Trello through GUI
Resource         tests/common/gui/resources/CommonGUI.resource

*** Variables ***
${BASE_URL}             https://trello.com/
${DEFAULT_USER}         %{TRELLO_USER}
${DEFAULT_PASSWORD}     %{TRELLO_PASSWORD}
${DEFAULT_USER_HOME}    ${BASE_URL}pablotest4/boards
