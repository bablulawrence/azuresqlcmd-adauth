# Run Azure SQL commands using AD authentication

This action executes sql commands or scripts in Azure SQL Database using Active Directory Authentication.

# Usage

Following examples runs a query in your Azure SQL Database.

## Example workflows

### 1. With query string

```yaml
azuresqlcmd-job:
  runs-on: ubuntu-latest
  name: Run Azure SQL Command
  steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: Run Azure SQL Command
      id: azuresqlcmd
      uses: bablulawrence/azuresqlcmd-adauth@v0.1.0
      with:
        tenant_id: "a6f12c4b-XXXX-4ce0-XXXX-038420b2bb7d"
        service_principal_id: "f7fc43e4-XXXX-42b8-XXXX-756ec472ae54"
        service_principal_secret: ${{ secrets.SERVICE_PRINCIPAL_SECRET }}
        sql_server_name: "myazure-sql-server"
        sql_db_name: "myazure-sql-db"
        query_string: "SELECT 1"
        return_result_flag: "Yes"
```

### 2. With script file

```yaml
azuresqlcmd-job:
  runs-on: ubuntu-latest
  name: Run Azure SQL Command
  steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: Run Azure SQL Command
      id: azuresqlcmd
      uses: bablulawrence/azuresqlcmd-adauth@v0.1.0
      with:
        tenant_id: "a6f12c4b-XXXX-4ce0-XXXX-038420b2bb7d"
        service_principal_id: "f7fc43e4-XXXX-42b8-XXXX-756ec472ae54"
        service_principal_secret: ${{ secrets.SERVICE_PRINCIPAL_SECRET }}
        sql_server_name: "myazure-sql-server"
        sql_db_name: "myazure-sql-db"
        query_string: "query.sql"
        return_result_flag: "Yes"
```

## Inputs

| #   | Input                    | Description                                                            |
| --- | ------------------------ | ---------------------------------------------------------------------- |
| 1   | tenant_id                | Azure AD Tenant Id                                                     |
| 2   | service_principal_id     | Azure AD Service Principal Id                                          |
| 3   | service_principal_secret | Azure AD Service Principal Secret                                      |
| 4   | sql_server_name          | SQL Server Name                                                        |
| 5   | sql_db_server            | SQL Server Database Name                                               |
| 6   | query_string/query_file  | Query string or path of file containing query                          |
| 7   | return_result_flag       | Return result flag. Set this to "Yes"for command output in JSON format |

## Outputs

| #   | Output | Description                          |
| --- | ------ | ------------------------------------ |
| 1   | count  | Count of result set                  |
| 2   | result | Serialized result set in JSON format |
