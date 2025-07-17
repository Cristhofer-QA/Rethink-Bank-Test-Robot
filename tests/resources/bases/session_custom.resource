*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem


*** Keywords ***
Create new session
    ${URL_BASE}     Get Environment Variable    BASE_URL_API
    &{header}    Create Dictionary
    ...          accept=application/json
    ...          Content-Type=application/json
    
    Create Session    alias=rethinkBank    url=${URL_BASE}    headers=${header}


Delete custom session
    Delete All Sessions