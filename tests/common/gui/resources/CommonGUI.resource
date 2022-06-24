*** Settings ***
Documentation    Keywords and Variables for general GUI interaction
Library          SeleniumLibrary

*** Variables ***
# Set browser in cli: "-v BROWSER:<browser_name>"
${BROWSER}    Chrome
${REMOTE}     ${FALSE}

*** Keywords ***
Open Browser From Environment
    [Documentation]        This keywords takes REMOTE and BROWSER variables
    ...                    from the environment automatically and only needs a url
    [Arguments]    ${url}    ${is_remote}=${REMOTE}
    IF    ${is_remote}
        Open Browser    ${url}    ${BROWSER}    remote_url=http://selenium-hub:4444
    ELSE
        Open Browser    ${url}    ${BROWSER}
    END
