# Azure
- Microsoft Digital Defense Report 2024
  - 2023 - 65 trillion security signals
  - 2024 - 78 trillion security signals
  - over 600 million identity attacks per day - https://www.microsoft.com/en-us/security/blog/2024/12/05/8-years-as-a-leader-in-the-gartner-magic-quadrant-for-access-management/

###### Protecting users
- https://learn.microsoft.com/en-us/microsoft-365/admin/setup/priority-accounts?view=o365-worldwide
- https://learn.microsoft.com/en-us/defender-office-365/priority-accounts-security-recommendations


- "Enabling multi-factor authentication can block more than 99.9 percent of identity attacks that attempt to compromise your account.​​"
- Ensure you have put up a default startup directory. If not, you will be redirected to the last tenant you logged into. This is problematic if settings require you to use whitelisted IPs or compliant devices (VDI).
- To fix it click your username -> Switch directory -> and change the "Startup directory" setting. (CTRL+F and search for it if you cant see it)

- Quick commands Windows
  ````powershell
  Install-Module -Name Az -Force -Repository PSGallery
  Update-Module  -Name Az -Force
  Connect-AzAccount

  az login --service-principal -u <Application (client) ID> -p <Client Secret> --tenant <Directory (tenant) ID>
  ````
- Linux
  ````shell
  sudo apt-get install azure-cli
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
