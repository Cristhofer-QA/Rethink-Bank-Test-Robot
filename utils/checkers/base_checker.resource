*** Settings ***
Library    RequestsLibrary
Library    Collections



*** Keywords ***
Check status
    [Arguments]    ${response}    ${expect_status}

    ${is_expected_status}=    Run Keyword And Return Status    Status Should Be    ${expect_status}    ${response}
    IF  ${is_expected_status}
        ${msg_return}=    Set Variable    Status corresponde!
    ELSE
        ${msg_return}=    Set Variable    Status não corresponde!${\n} -> Esperado:${expect_status}${\n} -> Obtido: ${response.status_code}
    END

    &{dict_response}=    Create Dictionary    is_expected_status=${is_expected_status}    msg=${msg_return}

    RETURN    ${dict_response}


Check fields
    [Arguments]    ${response}    @{expect_fields}

    @{keys_response_body}=     Get Dictionary Keys    ${response.json()}
    ${is_expected_fields}=     Run Keyword And Return Status    Lists Should Be Equal    list1=@{expect_fields}    
    ...                                                                                 list2=@{keys_response_body}
    ...                                                                                 ignore_order=${True}
    ...                                                                                 ignore_case=${True}

    IF  ${is_expected_fields}
        ${msg_return}=    Set Variable    Fields correspondem!
    ELSE
        ${msg_return}=    Set Variable    Fields não correspondem!\n -> Esperado:${expect_fields}${\n} -> Obtido: ${keys_response_body}
    END

    &{dict_response}=    Create Dictionary    is_expected_fields=${is_expected_fields}    msg=${msg_return}
    
    RETURN    ${dict_response}


Return message logs
    [Arguments]    @{logs}

    ${msg}=    Set Variable    Logs:

    FOR    ${log}    IN    @{logs}
        ${msg}=    Set Variable    ${msg} \n ${log}
    END

    RETURN    ${msg}