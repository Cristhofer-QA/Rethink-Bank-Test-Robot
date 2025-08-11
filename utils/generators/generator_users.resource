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
    ${password}=    Generate password shortest digit    
    &{user}=        Generate valid user

    Set To Dictionary    ${user}    password=${password}    
    ...                             confirmPassword=${password}

    RETURN               &{user}


Generate user without password
    ${password}=    Set Variable    
    &{user}=        Generate valid user

    Set To Dictionary    ${user}    password=${password}    
    ...                             confirmPassword=${password}

    RETURN               &{user}


Generate user with password null
    ${password}=    Set Variable    ${null}
    &{user}=        Generate valid user

    Set To Dictionary    ${user}    password=${password}    
    ...                             confirmPassword=${password}

    RETURN               &{user}