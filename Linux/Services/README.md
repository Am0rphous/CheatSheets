# Services

- [**Services**](#Services)
  - [Network Share](#network-share)

## Apache2
- Increase file uppload size limit. Change the file `/etc/php/7.0/apache2/php.ini`.
````powershell
post_max_size = 100M
upload_max_filesize = 100M
````
Restart service
````powershell
sudo service apache2 restart
````

