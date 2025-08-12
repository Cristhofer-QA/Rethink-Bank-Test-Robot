*** Settings ***
Resource    ../../utils/generators/generator_users.resource
Resource    ../../utils/bases/endpoints.resource
Resource    ../../utils/checkers/user_register_checker.resource



*** Keywords ***
que possua os dados de cadastro de um usuário válido
    &{user}    Generate valid user
    Set Test Variable    &{user}  

que possua os dados de cadastro de um usuário com senha menor de 8 dígitos
    &{user}    Generate user password shorter than eight digits
    Set Test Variable    &{user} 

que possua os dados de cadastro de um usuário, mas sem a senha 
    &{user}    Generate user without password
    Set Test Variable    &{user} 

que possua os dados de cadastro de um usuário, mas com a senha nula
    &{user}    Generate user with password null
    Set Test Variable    &{user} 

que possua os dados de cadastro de um usuário, mas com cpf com menos dígitos
    &{user}    Generate user with cpf with fewer digits
    Set Test Variable    &{user} 

realizar a requisição de cadastro de usuário
    ${response}    Create new user    &{user}
    Set Test Variable    ${response}

usuário deve ser cadastrado com sucesso
    Check user registered successfully    ${response}

usuário não deve ser cadastrado e deve retornar uma mensagens informando que a senha é fraca
    Check user not registered by password weak    ${response}

usuário não deve ser cadastrado e deve retornar uma mensagens informando que a senha é obrigatória
    Check user not registered by password weak    ${response}

usuário não deve ser cadastrado e deve retornar uma mensagens informando que o cpf é inválido
    Check user not registered by invalid cpf    ${response}