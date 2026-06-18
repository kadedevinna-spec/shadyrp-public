# Images Directory

This folder contains images for the Bank Lobby system.

## Notification Images

Custom PNG images for the notification system. Each image should be a transparent PNG, ideally 24x24 pixels, to fit well within the notification icon circle.

The system will automatically apply a `filter: brightness(0) invert(1)` CSS rule to these images, making them appear white, regardless of their original color. This ensures a consistent look with the Western theme.

**Required notification files:**
- `invite.png` (for lobby invitations)
- `success.png` (for success messages, e.g., player joined)
- `error.png` (for error messages, e.g., lobby full, player not found)
- `info.png` (for informational messages, e.g., player left)
- `lobby.png` (general lobby icon, if needed)
- `kick.png` (for kick-related notifications)
- `player_join.png` (specific for player joining)
- `player_leave.png` (specific for player leaving)
- `lobby_create.png` (specific for lobby creation)
- `lobby_disband.png` (specific for lobby disbandment)

## Profile Images

**Preset Profile Images (Configurable in config.lua):**
- `default_profile.png` - Default profile image
- `profile_1.png` - Profile option 1
- `profile_2.png` - Profile option 2
- `profile_3.png` - Profile option 3
- `profile_4.png` - Profile option 4
- `profile_5.png` - Profile option 5
- `profile_6.png` - Profile option 6
- `profile_7.png` - Profile option 7
- `profile_8.png` - Profile option 8
- `profile_9.png` - Profile option 9

**Recommended size:** 120x120px (will be displayed in circles)

**Configuration:**
All profile images are configured in `config.lua` under `Config.Profile.images`. You can:
1. Change the file paths for any preset
2. Add or remove preset options
3. Customize the naming convention

**Setup Process:**
1. Place your preset images (profile_1.png through profile_9.png) in this directory
2. Players can select from available presets only
3. System references files in the database

**Easy Management:**
- Want to change profile option 3? Just replace `profile_3.png` with your new image
- Want different preset options? Update the paths in `Config.Profile.images`
- All changes are automatic - no code modifications needed!

You can customize any of these images by replacing the files with your own, ensuring they have the same filenames as configured in config.lua.