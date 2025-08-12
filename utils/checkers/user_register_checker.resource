*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   base_checker.resource



*** Variables ***
@{fields_user_not_registered}=             error
@{fields_user_registered_successfully}=    message    confirmToken

&{status_endpoint}=        success=201
...                        data_error=400
...                        server_error=500
&{messages_response}=      success=Cadastro realizado com sucesso.
...                        weak_password=Senha fraca
...                        invalid_cpf=CPF inválido



*** Keywords ***
Check user registered successfully
    [Arguments]    ${response}    ${skip_test_to_failure}=${False}

    ${status_success}=          Set Variable    ${status_endpoint.success}  
    ${expect_message}=          Set Variable    ${messages_response.success}
    ${field_expect_message}=    Set Variable    ${fields_user_registered_successfully[0]}

    Check response user register    ${response}    
    ...                             ${status_success}    
    ...                             ${field_expect_message}    
    ...                             ${expect_message}
    ...                             ${skip_test_to_failure}    
    ...                             @{fields_user_registered_successfully}


Check user not registered by password weak
    [Arguments]    ${response}    ${skip_test_to_failure}=${False}

    ${expect_message}=    Set Variable    ${messages_response.weak_password}

    Check user not registered by data error    ${response}    
    ...                                        ${expect_message}    
    ...                                        ${skip_test_to_failure}


Check user not registered by invalid cpf
    [Arguments]    ${response}    ${skip_test_to_failure}=${False}

    ${expect_message}=    Set Variable    ${messages_response.invalid_cpf}

    Check user not registered by data error    ${response}    
    ...                                        ${expect_message}    
    ...                                        ${skip_test_to_failure}


Check user not registered by data error
    [Arguments]    ${response}    ${expect_message}    ${skip_test_to_failure}
    
    ${status_error}=            Set Variable    ${status_endpoint.data_error}  
    ${field_expect_message}=    Set Variable    ${fields_user_not_registered[0]}

    Check response user register    ${response}    
    ...                             ${status_error}    
    ...                             ${field_expect_message}    
    ...                             ${expect_message}    
    ...                             ${skip_test_to_failure}    
    ...                             @{fields_user_not_registered}


Check response user register
    [Arguments]    ${response}    ${status_expect}    ${field_expect_message}    ${expect_message}    ${skip_test_to_failure}    @{fields_expect}    

    &{status}=    Check status    ${response}    ${status_expect}
    &{fields}=    Check fields    ${response}    @{fields_expect}
    
    ${test_is_correct}=    Set Variable    ${True}
    @{logs}=               Set Variable    ${null}

    IF  ${status.is_expected_status} != ${True}
        ${test_is_correct}=    Set Variable    ${False}
        Append To List         ${logs}    ${status.msg}
    END

    IF  ${fields.is_expected_fields} != ${True}
        ${test_is_correct}=    Set Variable    ${False}
        Append To List         ${logs}    ${fields.msg}
    END

    &{check_message}    Check message user register    ${response}    ${field_expect_message}    ${expect_message}
    
    IF  ${check_message.is_expected_message} != ${True}
        ${test_is_correct}=    Set Variable    ${False}
        Append To List    ${logs}    ${check_message.msg}
    END

    IF  ${test_is_correct} != ${True}
        ${msg_erros}=    Return message logs    @{logs}
        IF  ${skip_test_to_failure}
            Skip    msg=[Teste ignorado] ${msg_erros}
        ELSE
            Fail    msg=[Teste falhou] ${msg_erros}
        END
    END


Check message user register
    [Arguments]    ${response}    ${field_expect_message}    ${expect_message}

    ${has_field_expect}=    Run Keyword And Return Status    Get From Dictionary    ${response.json()}    ${field_expect_message}
    IF    ${has_field_expect}
          ${message_response}=        Get From Dictionary    ${response.json()}    ${field_expect_message}
          ${is_expected_message}=     Run Keyword And Return Status    Should Be Equal    ${message_response}    ${expect_message}
          ${msg_return}=              Set Variable    Mensagem verificada. Ok!

          IF  ${is_expected_message} != ${True}
              ${msg_return}=    Set Variable    A mensagem de confirmação/erro não corresponde com a esperada.\n -> Esperado: ${expect_message}${\n} -> Obtido: ${message_response}
          END

    ELSE
        ${is_expected_message}=    Set Variable    ${False}
        ${msg_return}=             Set Variable    A mensagem de confirmação não pode ser validada, pois o campo "${field_expect_message}" não foi encontrado no response.json: ${response.json()}
    END

    
    &{dict_response}=    Create Dictionary    is_expected_message=${is_expected_message}    msg=${msg_return}
    
    RETURN    ${dict_response}