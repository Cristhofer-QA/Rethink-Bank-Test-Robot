*** Settings ***
Library    RequestsLibrary

*** Variables ***
${alias_session}    rethinkBank


*** Keywords ***
Custom post on session
    [Arguments]    ${url}    &{body}
    ${response}    Post on session    alias=${alias_session}    url=${url}    json=${body}    expected_status=any
    RETURN    ${response}