*** Settings ***
Resource    ../../utils/generators/generator_users.resource
Resource    ../../../utils/bases/endpoints.resource

*** Keywords ***
que possua os dados de cadastro de um usuário válido
    &{user}    Generate valid user
    Set Test Variable    &{user}  

que possua os dados de cadastro de um usuário com senha menor de 8 dígitos
    &{user}    Generate user password shorter than eight digits
    Set Test Variable    &{user}  

realizar a requisição de cadastro de usuário
    ${response}    Create new user    &{user}
    Set Test Variable    ${response}
