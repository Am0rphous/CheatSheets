# Git

- [30-seconds-of-git](https://github.com/30-seconds/30-seconds-of-git) - Short git snippets for all your development needs.
- [Git Cheat Sheets](https://training.github.com/)
- [Gthub - Basic Writing and Formatting Syntax](https://docs.github.com/en/enterprise-server@2.20/github/writing-on-github/basic-writing-and-formatting-syntax)
- [GitLive.net](https://gitlive.net)
- [Pro Git book](https://git-scm.com/book/en/v2)
- [The Ultimate Guide to GitHub REST API](https://hevodata.com/learn/github-rest-apis/#benefitsgithub)

## Install and setup
````
sudo apt install git       #Linux
brew install git           #MacOS
git init
````
### Important on macOS - remove .DS_Store file
- Delete the hidden file .DS_Store as this can expose metadata about folders, view settings and file positions.
- [DS_Store viewer](https://ademkouki.site/DS_Store-Viewer/) - [Source code](https://github.com/Ademking/DS_Store-Viewer)
- Find and remove files
````
cd myGithubRepoName
find . -type f -iname "*.DS_Store*"   #lists files
find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch   #find and deletes every .DS_store file
````

## Git Large File Storage (LFS)
- [An open source Git extension for versioning large files](https://git-lfs.github.com/)
- [How to push large files to GitHub](https://ayunascode.medium.com/how-to-push-large-files-to-github-253d05cc6a09)
- [Configuring Git Large File Storage](https://docs.github.com/en/github/managing-large-files/configuring-git-large-file-storage)
````
brew install git-lfs       #MacOS
git lfs install
git lfs track "*.iso"
git add .gitattributes
git add file.iso
git commit -m "added file.iso"
git push origin main
````

## Various commands

| Key/Command | Description |
| ----------- | ----------- |
| git clone https://github.com/Am0rphous/Cheat-Sheets | Clones the repo to your current folder |
| git config --global credential.helper manager-core | |
| git config --global user.name "Am0rphous" | |
| git config user.email " ... @users.noreply.github.com" | |
| | git config --global credential.helper store - [source](https://stackoverflow.com/questions/46645843/where-to-store-my-git-personal-access-token) |
| git add . | Stages all the modified files at once.|
| | git add -A . |
| git add fil1 fil2 fil3 | add files to Change |
| git commit -m "Describing the suff i did" | Commits a comment to all the files |
| git status |
| git mv cybersec temp && git mv tmp CyberSec | Renames folder. Don't use only the `mv` command. [source](https://stackoverflow.com/questions/11183788/in-a-git-repository-how-to-properly-rename-a-directory)
| git push | Pushes everything up to Github |
| git push origin master |
| git log | Show commit logs

