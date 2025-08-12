*** Settings ***
Resource    base_generators.resource
Library    Collections



*** Keywords ***
Generate valid user
    ${cpf}=           Generate cpf
    ${first_name}=    Generate first name
    ${last_name}=     Generate last name
    ${full_name}=     Generate full name    ${first_name}    ${last_name} 
    ${email}=         Generate email        ${first_name}    ${last_name}
    ${password}=      Generate password

    &{user}=   Create Dictionary    cpf=${cpf}
    ...                             full_name=${full_name}
    ...                             email=${email}
    ...                             password=${password}
    ...                             confirmPassword=${password}
    
    RETURN    &{user}


Generate user password shorter than eight digits
    &{user}=        Generate valid user
    ${password}=    Generate password shortest digit    

    Set To Dictionary    ${user}    password=${password}    
    ...                             confirmPassword=${password}

    RETURN               &{user}


Generate user without password
    &{user}=        Generate valid user
    ${password}=    Set Variable    

    Set To Dictionary    ${user}    password=${password}    
    ...                             confirmPassword=${password}

    RETURN               &{user}


Generate user with password null
    &{user}=        Generate valid user
    ${password}=    Set Variable    ${null}

    Set To Dictionary    ${user}    password=${password}    
    ...                             confirmPassword=${password}

    RETURN               &{user}


Generate user with cpf with fewer digits
    ${cpf}=     Generate cpf    len=9
    &{user}=    Generate valid user

    Set To Dictionary    ${user}    cpf=${cpf}    

    RETURN               &{user}    