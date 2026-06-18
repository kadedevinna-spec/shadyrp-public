
RegisterCommand('scene', function()
    serverRequest('checkEditorPermission', {}, function(result)
      if type(result) == 'table' and result.allowed == true then
        OpenUI(true)
        return
      end
      RuntimeNotify((type(result) == 'table' and result.message) or 'Bu menuyu kullanmak icin yetkin yok.')
    end)
end, false)

local function requestRuntimeBootstrap()
    serverRequest('loadAllScenes', {}, function(scenes)
      if type(scenes) == 'table' then
        ApplyAllScenesRuntime(scenes)
      end
    end)
    if Config and Config.Editor == true and GetResourceState and GetResourceState('v-editor') == 'started' then
      TriggerServerEvent('v-editor:getCompositions')
    else
      SetEditorScenesCache({})
    end
end

AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    requestRuntimeBootstrap()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    requestRuntimeBootstrap()
end)

RegisterNetEvent('vorp:SelectedCharacter')
AddEventHandler('vorp:SelectedCharacter', function()
    requestRuntimeBootstrap()
end)

RegisterCommand('importscene', function(_, args)
    local code = args and args[1]
    if not code or code == '' then return end
    TriggerServerEvent('v-scene:importScene', code)
end, false)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
      runtimeTextThread = false
      runtimeKeyPromptThread = false
      runtimeSoundAttachThread = false
      StopSceneRuntime()
      stopCoordsPick(true)
      clearPreviewGizmo()
      clearPreviewProps()
    end
end)

