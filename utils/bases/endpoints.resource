*** Settings ***
Library     RequestsLibrary
Resource    requests_on_session.resource



*** Keywords ***
Create new user
    [Arguments]    &{body}

    &{parameters}=    Create Dictionary    body=&{body}    header=${null}
    ${response}=      Custom post on session    /cadastro    &{parameters}
    
    RETURN    ${response}