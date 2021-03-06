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

### List biggest repos
First run `sudo gitlab-rails console` and then:
````powershell
include ActionView::Helpers::NumberHelper
ProjectStatistics.order(build_artifacts_size: :desc).limit(20).each do |s|
  puts "#{number_to_human_size(s.build_artifacts_size)} \t #{s.project.full_path}"
end
````
