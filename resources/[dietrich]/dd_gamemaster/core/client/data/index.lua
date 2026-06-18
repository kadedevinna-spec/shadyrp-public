-- Data loader for game-specific model lists (Peds, Objects, Scenarios, Weapons)
-- Place RedM data under client/data/rdr3/*.lua and FiveM data under client/data/gta5/*.lua
-- Each file can define globals like Peds, Objects, Scenarios, Weapons used by the GM.

local function loadLua(path)
  local res = (GetCurrentResourceName and GetCurrentResourceName()) or 'dd_gamemaster'
  if LoadResourceFile then
    local src = LoadResourceFile(res, path)
    if src and #src > 0 then
      local chunk, lerr = load(src, ('@@%s/%s'):format(res, path))
      if not chunk then
        print(('^3[GM Data] Compile error %s: %s^7'):format(path, tostring(lerr)))
        return false
      end
      local ok, perr = pcall(chunk)
      if not ok then
        print(('^3[GM Data] Exec error %s: %s^7'):format(path, tostring(perr)))
        return false
      end
      return true
    end
  end
  -- Fallback: dev environment where filesystem is accessible
  local ok, err = pcall(function() dofile(path) end)
  if not ok then
    if type(err) == 'string' and err:find('No such file', 1, true) then
      return false
    end
    print(('^3[GM Data] Error loading %s: %s^7'):format(path, tostring(err)))
    return false
  end
  return true
end

-- Decide game
local isFiveM = (Runtime and Runtime.isFiveM) and true or false
local base = isFiveM and 'core/client/data/gta5/' or 'core/client/data/rdr3/'

-- Preferred per-game files
local perGameFiles = {
  base .. 'peds.lua',
  base .. 'objects.lua',
  base .. 'scenarios.lua',
  base .. 'weapons.lua',
}

local function tryLoad(perGamePath, legacyPath)
  if not loadLua(perGamePath) and legacyPath then
    loadLua(legacyPath)
  end
end

tryLoad(base .. 'peds.lua')
tryLoad(base .. 'objects.lua')
tryLoad(base .. 'scenarios.lua')
tryLoad(base .. 'weapons.lua')
tryLoad(base .. 'vehicles.lua')
