# Azure

- "Enabling multi-factor authentication can block more than 99.9 percent of identity attacks that attempt to compromise your account.​​"
- Ensure you have put up a default startup directory. If not, you will be redirected to the last tenant you logged into. This is problematic if settings require you to use whitelisted IPs or compliant devices (VDI).
- To fix it click your username -> Switch directory -> and change the "Startup directory" setting. (CTRL+F and search for it if you cant see it)

- Quick commands
  ````powershell
  Install-Module -Name Az -Force -Repository PSGallery
  Update-Module  -Name Az -Force
  Connect-AzAccount

  az login --service-principal -u <Application (client) ID> -p <Client Secret Value> --tenant <Directory (tenant) ID>
  ````

### Detection rules
- [L4J/ Log4Shell & Hermeticwiper](https://github.com/stripesoc/detections)

## [Tenant](https://learn.microsoft.com/en-us/microsoft-365/enterprise/subscriptions-licenses-accounts-and-tenants-for-microsoft-cloud-offerings?view=o365-worldwide#tenants)
- SaaS: the tenant is the regional location that houses the servers providing cloud services.
- PaaS: and virtual machine-based workloads hosted in Azure IaaS can have tenancy in any Azure datacenter across the world.
- Entra tenant is a specific instance of Microsoft Entra ID containing accounts and groups.
````
https://portal.azure.com/{your tenant}
https://portal.azure.com/{your tenant}.onmicrosoft.com
https://portal.azure.com/bigcompany.onmicrosoft.com
````
