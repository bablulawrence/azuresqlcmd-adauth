# From Microsoft PowerShell image
FROM mcr.microsoft.com/powershell

# Install MSAL.PS for getting Azure AD access token and Invoke-Sqlcmd2 for executing SQL DB query.
RUN pwsh -c "Install-Module -Name MSAL.PS -RequiredVersion 4.16.0.4 -Scope AllUsers -Force  -AcceptLicense;" \
    "Install-Module -Name Invoke-Sqlcmd2 -RequiredVersion 1.6.4 -Scope AllUsers -Force  -AcceptLicense"

COPY Invoke-AzureSqlCmd.ps1 /Invoke-AzureSqlCmd.ps1
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]