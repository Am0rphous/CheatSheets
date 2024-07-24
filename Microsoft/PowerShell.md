
## PowerShell

#### Modules
````
Find-Module -Name "Module Name"
Install-Module 
````
#### PowerCLI MacOS
````
brew cask install powershell
pwsh
Install-Module -Name VMware.PowerCLI -Scope CurrentUser
Connect-VIServer -Server 192.168.1.10
````

#### Repo
````
Get-PSRepository
Set-PSRepository -Name "Repository Name" -InstallationPolicy Trusted   #Add a trusted repository
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted         #Add a trusted repository
Unregister-PSRepository -Name "Repository Name"
Unregister-PSRepository -Name "PSGallery"                              #Remove Trusted Repository
````

