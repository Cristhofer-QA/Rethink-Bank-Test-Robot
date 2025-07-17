*** Settings ***
Resource    ../resources/bases/session_custom.resource
Resource    ../resources/steps/user_register.resource
Suite Setup       Create new session
Suite Teardown    Delete custom session


*** Test Cases ***
Scenario 01: Criar um novo usuário válido
    Given que possua os dados de cadastro de um usuário válido
    When realizar a requisição de cadastro de usuário
    # Then usuário deve ser cadastrado com sucesso