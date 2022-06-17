*** Settings ***
Documentation    Keywords and Variables for using Trello through GUI
Resource         tests/common/gui/resources/CommonGUI.resource

*** Variables ***
${BASE_URL}             https://trello.com/
${DEFAULT_EMAIL}        %{TRELLO_EMAIL}
${DEFAULT_PASSWORD}     %{TRELLO_PASSWORD}
