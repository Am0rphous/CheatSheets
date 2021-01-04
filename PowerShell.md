
## PowerShell

#### Modules
````
Find-Module -Name "Module Name"
Install-Module 
````

#### Repo
````
Get-PSRepository
Set-PSRepository -Name "Repository Name" -InstallationPolicy Trusted   #Add a trusted repository
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted         #Add a trusted repository
Unregister-PSRepository -Name "Repository Name"
Unregister-PSRepository -Name "PSGallery"                              #Remove Trusted Repository
````
