# Midnight Code Loading Screen

Loading screen to use with vorp framework

### Instalation

- add to server.cfg `ensure midnightcode_loadingscreen` at the top
- in vorp core disable UseInitialLoadingScreen and LoadingScreen
- go to spawnmanager script in [managers]/spawnmanager/spawnmanager.lua and look for ShuttingDownLoadingScreen native and remove it
- update `vorp_core` and `vorp_character` they have new stuff that helps with this script its a must even if it says its up to date `UPDATE AGAIN`

### Configuration

- go to `config_main.js` for main configurations
- go to `config_staff.js` to edit teams developers rules etc, you can remove what you dont want
- some stuff might need translation in html file


### Notes

- if you want to add your own video and images MAKE SURE TO REMOVE THE OLD ONES the more you have in there the more time will take users to download them. only leave there what you  are using the same goes for music if you dont use it remvoe them from the folder if you dont use video remove it from the folder