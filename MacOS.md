## MacOS

#### Package manager
brew
brew install tor
brew info tor
brew services list
brew services start tor
brew services restart tor

Process management
ps axu | grep "/bin/tor"

#### Service Management
sudo launchctl list
sudo launchctl list | grep service
sudo launchctl list | grep tor
