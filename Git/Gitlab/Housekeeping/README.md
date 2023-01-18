# Housekeeping
- [Clean up Rake tasks](https://docs.gitlab.com/ee/raketasks/cleanup.html)
- [Jobs artifacts administration](https://docs.gitlab.com/ee/administration/job_artifacts.html?tab=Linux+package+%28Omnibus%29)

- [Clean up](https://docs.gitlab.com/ee/raketasks/cleanup.html#remove-orphan-artifact-files)
- Commands
````powershell
sudo gitlab-rake gitlab:cleanup:orphan_lfs_files                 # executes
sudo gitlab-rake gitlab:cleanup:orphan_job_artifact_files        # deletes orphan job artefacts
sudo gitlab-rake gitlab:cleanup:project_uploads                  # DRY_RUN=false
````

#### List projects by total size of job artifacts stored 
- Run sudo gitlab-rails console`
````
include ActionView::Helpers::NumberHelper
ProjectStatistics.order(build_artifacts_size: :desc).limit(20).each do |s|
  puts "#{number_to_human_size(s.build_artifacts_size)} \t #{s.project.full_path}"
end

````


````

````
