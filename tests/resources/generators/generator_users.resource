*** Settings ***
Resource    base_generators.resource


*** Keywords ***
Generate valid user
    ${cpf}                 Generate cpf
    ${first_name}          Generate first name
    ${last_name}           Generate last name
    ${full_name}           Generate full name    ${first_name}    ${last_name} 
    ${email}               Generate email        ${first_name}    ${last_name}
    ${password}            Generate password
    ${conf}                Set Variable           ${password}

    &{user}    Create Dictionary
    ...        cpf=${cpf}
    ...        full_name=${full_name}
    ...        email=${email}
    ...        password=${password}
    ...        confirmPassword=${conf}
    
    RETURN    &{user}