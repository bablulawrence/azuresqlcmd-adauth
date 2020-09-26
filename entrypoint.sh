#! /bin/bash

if  [ -n "$INPUT_TENANT_ID" ] && \
    [ -n "$INPUT_SERVICE_PRINCIPAL_ID" ] && \
    [ -n "$INPUT_SERVICE_PRINCIPAL_SECRET" ] && \
    [ -n "$INPUT_SQL_SERVER_NAME" ] && \
    [ -n "$INPUT_SQL_DB_NAME" ] && \
    [ -n "$INPUT_QUERY_STRING" ] && \
    [ -n "$INPUT_RETURN_RESULT_FLAG" ]
then 
    ./Invoke-AzureSqlCmd.ps1 \
        -TenantId "$INPUT_TENANT_ID" \
        -ServicePrincipalId  "$INPUT_SERVICE_PRINCIPAL_ID" \
        -ServicePrincipalSecret "$INPUT_SERVICE_PRINCIPAL_SECRET" \
        -SqlServerName "$INPUT_SQL_SERVER_NAME" \
        -SqlDbName "$INPUT_SQL_DB_NAME" \
        -Query "$INPUT_QUERY_STRING" \
        -ReturnResult "$INPUT_RETURN_RESULT_FLAG"
elif 
    [ -n "$INPUT_TENANT_ID" ] && \
    [ -n "$INPUT_SERVICE_PRINCIPAL_ID" ] && \
    [ -n "$INPUT_SERVICE_PRINCIPAL_SECRET" ] && \
    [ -n "$INPUT_SQL_SERVER_NAME" ] && \
    [ -n "$INPUT_SQL_DB_NAME" ] && \
    [ -n "$INPUT_QUERY_FILE" ] && \
    [ -n "$INPUT_RETURN_RESULT_FLAG" ]
then 
    ./Invoke-AzureSqlCmd.ps1 \
        -TenantId "$INPUT_TENANT_ID" \
        -ServicePrincipalId  "$INPUT_SERVICE_PRINCIPAL_ID" \
        -ServicePrincipalSecret "$INPUT_SERVICE_PRINCIPAL_SECRET" \
        -SqlServerName "$INPUT_SQL_SERVER_NAME" \
        -SqlDbName "$INPUT_SQL_DB_NAME" \
        -QueryFile "$GITHUB_WORKSPACE/$INPUT_QUERY_FILE" \
        -ReturnResult "$INPUT_RETURN_RESULT_FLAG"
else
    echo "Missing arguments value(s): "  
    if  [ -z "$INPUT_TENANT_ID" ] 
        then echo "Tenant Id" 
    fi
    if  [ -z "$INPUT_SERVICE_PRINCIPAL_ID" ] 
        then echo "Service Principal" 
    fi
    if  [ -z "$INPUT_SERVICE_PRINCIPAL_SECRET" ] 
        then echo "Service Principal Secret" 
    fi
    if  [ -z "$INPUT_SQL_SERVER_NAME" ]
        then echo "Sql Server Name" 
    fi
    if  [ -z "$INPUT_SQL_DB_NAME" ] 
        then echo "Sql Database Name" 
    fi
    if  [ -z "$INPUT_QUERY_STRING" ] && [ -z "$INPUT_QUERY_FILE" ] 
        then
        if  [ -z "$INPUT_QUERY_STRING" ] 
            then  echo "Sql Query String" 
        fi
        if  [ -z "$INPUT_QUERY_FILE" ] 
            then  echo "Sql Query File" 
        fi
    fi
    if  [ -z "$INPUT_RETURN_RESULT_FLAG" ] 
        then echo "Return result flag" 
    fi
    exit 1    
fi