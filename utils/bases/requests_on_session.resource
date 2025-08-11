*** Settings ***
Library    RequestsLibrary



*** Variables ***
${alias_session}    rethinkBank



*** Keywords ***
Custom post on session
    [Arguments]    ${url}    &{parameters}

    ${response}    Post on session    alias=${alias_session}    url=${url}    headers=${parameters.header}    json=${parameters.body}    expected_status=any
    
    RETURN    ${response}