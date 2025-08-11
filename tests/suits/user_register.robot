*** Settings ***
Resource    ../../utils/bases/session_custom.resource
Resource    ../steps/user_register.resource
Suite Setup       Create new session
Suite Teardown    Delete custom session



*** Test Cases ***
Scenario 01: Criar um novo usuário válido
    Given que possua os dados de cadastro de um usuário válido
    When realizar a requisição de cadastro de usuário
    Then usuário deve ser cadastrado com sucesso

Scenario 02: Criar um usuário com senha menor de 8 dígitos
    Given que possua os dados de cadastro de um usuário com senha menor de 8 dígitos
    When realizar a requisição de cadastro de usuário
    Then usuário não deve ser cadastrado e deve retornar uma mensagens informando que a senha é fraca

Scenario 03: Criar um usuário sem senha
    Given que possua os dados de cadastro de um usuário, mas sem a senha
    When realizar a requisição de cadastro de usuário
    Then usuário não deve ser cadastrado e deve retornar uma mensagens informando que a senha é fraca

Scenario 04: Criar um usuário com senha nula
    Given que possua os dados de cadastro de um usuário, mas com a senha nula
    When realizar a requisição de cadastro de usuário
    Then usuário não deve ser cadastrado e deve retornar uma mensagens informando que a senha é fraca