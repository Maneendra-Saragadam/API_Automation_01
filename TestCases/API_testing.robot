*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Resource    ../config/configuration.robot

*** Test Cases ***
TC_001 - Validate URL with the parameters of valid SIMIP address & valid SIMPort number
        Create Session    mysession    ${base_url}
        ${response}=    GET On Session    mysession     ${obis_code}   params=ip=${ip_address}&port=${port}
        Should Be Equal As Strings   ${response.status_code}   200
        Log To Console    ${response.content}


TC_002 - Validate the invalid OBIS code
        Create Session    mysession    ${base_url}
        ${response}=    GET On Session    mysession     ${invalid_obis}   params=ip=${ip_address}&port=${port}
        Should Be Equal As Strings   ${response.status_code}   404
        Log To Console    ${response.content}   


TC_003 - Validate URL with the parameters of invalid SIMIP address & valid SIMPort number
        Create Session    mysession    ${base_url}
        ${response}=    GET On Session    mysession     ${obis_code}   params=ip=${invalid_ip}&port=${port}
        Should Be Equal As Strings   ${response.status_code}   404
        Log To Console    ${response.content}


TC_004 - Validate URL with the parameters of invalid SIMIP address & invalid SIMPort number
        Create Session    mysession    ${base_url}
        ${response}=    GET On Session    mysession     ${obis_code}   params=ip=${invalid_ip}&port=${invalid_port}
        Should Be Equal As Strings   ${response.status_code}   404
        Log To Console    ${response.content}


TC_005 - Validate URL with the parameters of valid SIMIP address & invalid SIMPort number
        Create Session    mysession    ${base_url}
        ${response}=    GET On Session    mysession     ${obis_code}   params=ip=${ip_address}&port=${invalid_port}
        Should Be Equal As Strings   ${response.status_code}   400
        Log To Console    ${response.content}


TC_006 - Validate URL with the parameters of invalid SIMIP address & invalid SIMPort number with null values
        Create Session    mysession    ${base_url}
        ${response}=    GET On Session    mysession     ${obis_code}   params=ip= &port=  
        Should Be Equal As Strings   ${response.status_code}    400
        Log To Console    ${response.content}


TC_007 - Validate the URL with extra parameters
        Create Session    mysession    ${base_url}
        ${response}=    GET On Session    mysession     ${obis_code}   params=ip=${ip_address}&port=${port}&${extra_params} 
        Should Be Equal As Strings   ${response.status_code}    400
        Log To Console    ${response.content}


TC_008 - Validate the URL with Invalid parameter names
        Create Session    mysession    ${base_url}
        ${response}=    GET On Session    mysession     ${obis_code}   params=${invalid_ipname}=${ip_address}&${invalid_portname}=${port} 
        Should Be Equal As Strings   ${response.status_code}   400
        Log To Console    ${response.content}


TC_009 - Validate the URL with invalid method
        Create Session    mysession    ${base_url}
        ${response}=    POST On Session    mysession     ${obis_code}   params=ip=${ip_address}&port=${port} 
        Should Be Equal As Strings   ${response.status_code}    405
        Log To Console    ${response.content}
