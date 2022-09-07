# Gitlab

### Commands
````powershell
sudo gitlab-rake gitlab:check > gitlab-rake.log
````

### Clean up
- [Clean up](https://docs.gitlab.com/ee/raketasks/cleanup.html#remove-orphan-artifact-files)
````powershell
sudo gitlab-rake gitlab:cleanup:orphan_job_artifact_files DRY_RUN=false              # deletes orphan job artefacts
````

### Important commands
````powershell
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
