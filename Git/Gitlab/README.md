# Gitlab

### API
- Extract user info to json: `curl  -s -X GET -H "PRIVATE-TOKEN: blabla" "https://gitlab.com/api/v4/users?username=USERNAMEHERE" | jq
`

### Commands
````powershell
sudo gitlab-rake gitlab:check > gitlab-rake.log
````

### Important commands
````powershell
ssh git@gitlab.com 2fa_recovery_codes   #create new recovery codes. This implies you've configured your account with a ssh key
wget -qO - https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt install -y gitlab-ce
sudo gitlab-ctl reconfigure
sudo gitlab-ctl status
sudo gitlab-rake gitlab:check
````
#### Add user as admin
- Start rails console with `sudo gitlab-rails console`
````powershell
 user = User.find_by(username: 'my_username')
 user.admin = true
 user.save!
````
#### Logs
````powershell
docker logs <container ID>
docker logs --follow <container ID>
docker logs --tail 100 <container ID>
docker logs --follow --until=3s
docker logs --follow --until=30m
docker logs --since 2019-03-02 <container ID>
````

### List biggest repos
First run `sudo gitlab-rails console` and then:
````powershell
include ActionView::Helpers::NumberHelper
ProjectStatistics.order(build_artifacts_size: :desc).limit(20).each do |s|
  puts "#{number_to_human_size(s.build_artifacts_size)} \t #{s.project.full_path}"
end
````

### Version
````powershell
grep gitlab /opt/gitlab/version-manifest.txt
````
