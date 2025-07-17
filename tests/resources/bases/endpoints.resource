*** Settings ***
Library     RequestsLibrary
Resource    requests_on_session.resource


*** Keywords ***
Create new user
    [Arguments]    &{body}
    ${response}    Custom post on session    /cadastro    &{body}
    Log To Console    >>> Requisição enviada: ${body}
    Log To Console    >>> Resposta status: ${response.status_code}
    Log To Console    >>> Resposta body: ${response.text}

    RETURN    ${response}