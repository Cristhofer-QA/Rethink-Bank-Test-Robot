*** Settings ***
Resource    ../generators/generator_users.resource
Resource    ../bases/endpoints.resource

*** Keywords ***
que possua os dados de cadastro de um usuário válido
    &{user}    Generate valid user
    Set Test Variable    &{user}  

realizar a requisição de cadastro de usuário
    ${response}    Create new user    &{user}
    Set Test Variable    ${response}