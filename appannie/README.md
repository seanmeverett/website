# App Annie Status Board

This is a script that generates a downloads graph for Panic's Status Board using the App Annie API. It is based on Tim Brückmann's [AppAnnieStatusBoard](https://github.com/rheinfabrik/AppAnnieStatusBoard). I'll keep his installation steps (just adapted to the needs of my version) in here to make the installation easier. If you like it thank [Tim](https://twitter.com/tibr), not me. I just adapted a few lines. ;-)

### Installation

1. Open `app_annie_status_board_downloads.rb` and adjust the values inside the configuration block to match you're respective install. 
2. Open `app_annie_status_board_downloads.sh` and update its path to the `app_annie_status_board_downloads.rb` script to match where you've installed it
3. Open `de.flohei.appanniestatusboard.downloads.plist` and update its `ProgramArguments` value to match where you are storing the salesboard.sh file you just updated in step 3.
4. Copy de.flohei.appanniestatusboard.downloads.plist to `~/Library/LaunchAgents` 
5. Open Termimal and run `launchctl load ~/Library/LaunchAgents/de.flohei.appanniestatusboard.downloads.plist`. This should generate the first version of your json file.
6. Go to Dropbox and get a shareable link for the JSON file that is output and add it to Status Board on your iPad.

### Support

Run into an issue? Throw an issue up on GitHub. Better yet, throw up a pull request with a fix.
