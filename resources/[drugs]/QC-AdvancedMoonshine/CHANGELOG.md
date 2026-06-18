# Development Changelog

## v2.0.2 - 2025-12-08
- Fixed all 5 shack interiors with correct interior_id values and entity_prefix support
- Added universal entity set prefix translation system (mp006/mp007)
- Added admin debug commands: `/ms_detectinterior`, `/ms_testentityset`, `/ms_interiorinfo`
- Switched build system from Babel to SWC with Terser minification
- Fixed shop menu UI to expand dynamically for long item titles

## V2.0.1 - 2025-12-06
- Addition of locale network for easy translation system

## v2.0.0 - 2025-12-03

### Added
- Server-synced brewing sound system using xsound with 3D positional audio
- Sound fade-out effect (5-second fade when approaching completion)
- Brewing sound persistence on player reconnect via `GetActiveBrewingSounds` callback
- Shack access control system with "Give Keys" functionality in Boss Actions
- Blip system: owners see "My Moonshine Shack", authorized players see "{Name} (Access)" with color modifier
- `RefreshOwnedShackBlips()` function to update blips when access changes
- Auto-completion system for brews via `ActiveBrews` tracking thread (1-second intervals)
- `readyToCollect` flag for finished brews
- Hover-based shop UI with gold-colored pricing in `descriptionFooter`
- Debug logging for brew collection, ActiveBrews state, and sound lifecycle
- Sound stop events on explosion, collection, and resource stop
- Forward declaration for `SaveShack` function to fix scope issues

### Changed
- **Brewing timer system**: Reset `brew_start` after minigame completes instead of before
- **Timer synchronization**: `ActiveBrews.startTime` now updates when `brew_start` resets
- **Sound management**: All brewing sounds now use server-side xsound exports (`-1` for all clients)
- **Vendor shop UI**: Price removed from buttons, now shows in footer on hover (no `showPrices`)
- **Shop items unlocked**: Moonshine barrel, distillery pot, and nails now available at level 1 (no trust required)
- **Empty jug removed**: Removed from Coot's shop, moved barrel/pot to Equipment category
- **UI timer updates**: `useEffect` now depends on `timeRemaining` value, not just `special` object reference
- **Database queries**: Fixed column names (`citizenid` vs `owner_citizenid`, removed non-existent `brew_end` column)
- **Shack access checks**: Use in-memory `Shacks[shackId]` instead of non-existent `GetShackData()` function
- **Blip creation**: Use existing `CreateShackBlip()` function with modifier for authorized players

### Fixed
- **Brewing collection bug**: Brews now properly set `readyToCollect` when timer completes
- **UI timer desync**: Timer now shows correct server value when menu reopens during brewing
- **Sound not stopping**: Fixed xsound export syntax and added proper destroy calls
- **Timing issues**: `brew_start` now resets after minigame, preventing 20-second desync
- **Database errors**: Removed `brew_end` column references, fixed `owner_citizenid` → `citizenid`
- **SaveShack error**: Added forward declaration and guard check to prevent nil call
- **Blip visibility**: Fixed blip creation for shack owners and authorized players
- **Portable still audio**: Lowered distance from 30m to 15m for better balance
- **Sound cleanup**: All brewing sounds now properly stop on resource restart

### Removed
- Client-side sound management functions (replaced with server-side)
- `QC-AdvancedMoonshine:client:StopBrewSound` event (now server-managed)
- Price display from shop buttons (moved to `descriptionFooter`)

---

## v1.0.0 - Previous Release

### Features
- Portable still upgrade system (Barrel → Basic → Advanced → Master)
- Batch brewing (scales with still tier)
- Explosion effects for overheating/damage

---

## Template

```
## vX.X.X - YYYY-MM-DD

### Added
- Feature/file/config added

### Changed
- What was modified and how

### Removed
- What was deleted and why

### Fixed
- Bug fixes with description
```
