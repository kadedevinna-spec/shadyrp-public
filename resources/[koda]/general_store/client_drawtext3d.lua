--- Animated DrawText3D (entity + world anchor) — port of user reference module.

local textAnimations = {}
local lastFrameTime = 0
local animationCache = {}

local function EaseOutCubic(x)
    return 1 - math.pow(1 - x, 3)
end

function GS_ManageTextAnimations()
    local currentTime = GetGameTimer()
    lastFrameTime = lastFrameTime or currentTime

    for id, animation in pairs(textAnimations) do
        if animation and currentTime - animation.lastUsed > 30000 then
            textAnimations[id] = nil
            animationCache[id] = nil
        end
    end

    lastFrameTime = currentTime
end

local function EnsureAnimation(id, forceReset)
    local currentTime = GetGameTimer()
    if not textAnimations[id] or forceReset then
        textAnimations[id] = {
            startTime = currentTime,
            lineWidth = 0.0,
            textOffset = 0.0,
            textAlpha = 0,
            lineAlpha = 0,
            lastUsed = currentTime,
            isActive = true,
            isComplete = false,
            isFadingOut = false,
            finalLineWidth = 0.12,
            finalTextOffset = 0.02,
            finalAlpha = 255,
            frameCount = 0,
        }
        return textAnimations[id]
    end
    textAnimations[id].lastUsed = currentTime
    return textAnimations[id]
end

local function UpdateAnimationState(animation)
    if not animation.isActive then return animation end

    local currentTime = GetGameTimer()
    local elapsedTime = currentTime - animation.startTime

    if animation.isComplete and not animation.isFadingOut then
        return animation
    end

    if animation.isFadingOut then
        local fadeOutDuration = 700
        local fadeOutElapsed = currentTime - animation.fadeOutStartTime
        local fadeOutPhase = math.min(1.0, fadeOutElapsed / fadeOutDuration)
        local easedPhase = EaseOutCubic(fadeOutPhase)
        local reversedPhase = 1.0 - easedPhase

        animation.lineWidth = animation.finalLineWidth * reversedPhase
        animation.textOffset = animation.finalTextOffset * reversedPhase
        animation.textAlpha = math.floor(animation.finalAlpha * reversedPhase)
        animation.lineAlpha = math.floor(200 * reversedPhase)

        if fadeOutPhase >= 1.0 then
            animation.isActive = false
            animation.isComplete = false
            animation.isFadingOut = false
        end

        return animation
    end

    if elapsedTime <= 200 then
        local linePhase = math.min(1.0, elapsedTime / 200)
        local easedPhase = EaseOutCubic(linePhase)
        animation.lineWidth = animation.finalLineWidth * easedPhase
        animation.lineAlpha = math.min(200, math.floor(easedPhase * 200))
        animation.textAlpha = 0
        animation.textOffset = 0
    elseif elapsedTime <= 400 then
        animation.lineWidth = animation.finalLineWidth
        animation.lineAlpha = 200

        local textPhase = (elapsedTime - 200) / 200
        local easedPhase = EaseOutCubic(textPhase)
        animation.textOffset = animation.finalTextOffset * easedPhase
        animation.textAlpha = math.min(animation.finalAlpha, math.floor(easedPhase * animation.finalAlpha))
    else
        animation.lineWidth = animation.finalLineWidth
        animation.lineAlpha = 200
        animation.textOffset = animation.finalTextOffset
        animation.textAlpha = animation.finalAlpha
        animation.isComplete = true
    end

    return animation
end

function GS_StartDrawTextExit(id)
    local anim = textAnimations[id]
    if anim and anim.isActive then
        anim.isFadingOut = true
        anim.fadeOutStartTime = GetGameTimer()
    end
end

function GS_EnsureDrawTextEnter(id)
    EnsureAnimation(id, true)
end

local function formatDrawTextMultiline(text)
    if not string.find(text, '\n') then return text end
    local lines = {}
    for line in string.gmatch(text, '[^\n]+') do
        lines[#lines + 1] = line
    end
    if #lines >= 3 then
        return lines[1] .. '\n« ' .. lines[2] .. ' »\n' .. lines[3]
    elseif #lines == 2 then
        return lines[1] .. '\n« ' .. lines[2] .. ' »'
    end
    return text
end

local function drawAnimatedCallout(id, text, startCoords, lineCoords, textCoords, opts)
    opts = opts or {}
    local finalTextOffset = opts.finalTextOffset or 0.02
    local textChanged = false
    if animationCache[id] ~= text then
        animationCache[id] = text
        textChanged = true
    end

    local animation = EnsureAnimation(id, textChanged)
    animation.finalTextOffset = finalTextOffset
    animation = UpdateAnimationState(animation)

    local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(textCoords.x, textCoords.y, textCoords.z)
    local onScreenLine, lineScreenX, lineScreenY = GetScreenCoordFromWorldCoord(lineCoords.x, lineCoords.y, lineCoords.z)
    if not onScreen then return end

    local formattedText = formatDrawTextMultiline(text)

    if onScreenLine and animation.lineWidth > 0 then
        local lineWidth = animation.lineWidth
        local lineHeight = 0.004
        if animation.lineAlpha > 50 then
            DrawRect(lineScreenX, lineScreenY + 0.001, lineWidth * 1.2, lineHeight * 3, 180, 180, 180, math.floor(animation.lineAlpha * 0.3))
        end
        DrawRect(lineScreenX, lineScreenY, lineWidth, lineHeight, 180, 180, 180, animation.lineAlpha)
    end

    if animation.textAlpha > 0 then
        SetTextScale(0.35, 0.35)
        SetTextColor(220, 220, 220, animation.textAlpha)
        SetTextCentre(true)
        SetTextDropshadow(1, 0, 0, 0, animation.textAlpha)
        Citizen.InvokeNative(0xADA9255D, 1)
        local displayText = CreateVarString(10, 'LITERAL_STRING', formattedText)
        DisplayText(displayText, screenX, screenY - animation.textOffset)
    end

    if opts.holdProgress ~= nil and onScreen then
        local barAlpha = math.max(animation.textAlpha, math.floor(animation.lineAlpha * 0.55))
        if barAlpha > 8 then
            local progress = math.max(0.0, math.min(1.0, opts.holdProgress + 0.0))
            local barW = 0.072
            local barH = 0.007
            local barY = (screenY - animation.textOffset) + 0.062

            DrawRect(screenX, barY, barW + 0.002, barH + 0.003, 120, 120, 128, math.floor(barAlpha * 0.35))
            DrawRect(screenX, barY, barW, barH, 28, 28, 32, math.floor(barAlpha * 0.88))

            if progress > 0.002 then
                local fillW = math.max(barH - 0.001, barW * progress)
                local fillX = screenX - (barW * 0.5) + (fillW * 0.5)
                DrawRect(fillX, barY, fillW, barH - 0.001, 235, 235, 240, barAlpha)
            end

            local tickW = 0.0012
            for i = 1, 3 do
                local tx = screenX - (barW * 0.5) + (barW * (i / 4))
                DrawRect(tx, barY, tickW, barH + 0.001, 90, 90, 98, math.floor(barAlpha * 0.45))
            end
        end
    end

    local segments = 6
    for i = 0, segments - 1 do
        local t1 = i / segments
        local t2 = (i + 1) / segments
        local curveAmount = 0.05
        local curve1 = curveAmount * math.sin(t1 * math.pi)
        local curve2 = curveAmount * math.sin(t2 * math.pi)

        local x1 = startCoords.x + (lineCoords.x - startCoords.x) * t1
        local y1 = startCoords.y + (lineCoords.y - startCoords.y) * t1
        local z1 = startCoords.z + (lineCoords.z - startCoords.z) * t1
        local x2 = startCoords.x + (lineCoords.x - startCoords.x) * t2
        local y2 = startCoords.y + (lineCoords.y - startCoords.y) * t2
        local z2 = startCoords.z + (lineCoords.z - startCoords.z) * t2

        local perpX = -(lineCoords.y - startCoords.y)
        local perpY = (lineCoords.x - startCoords.x)
        local perpLength = math.sqrt(perpX * perpX + perpY * perpY)
        if perpLength > 0 then
            perpX = perpX / perpLength
            perpY = perpY / perpLength
            x1 = x1 + perpX * curve1
            y1 = y1 + perpY * curve1
            x2 = x2 + perpX * curve2
            y2 = y2 + perpY * curve2
        end

        local alpha1 = 80 + (180 - 80) * t1
        local alpha2 = 80 + (180 - 80) * t2
        local lineConnectorAlpha = math.min(animation.lineAlpha, math.floor((alpha1 + alpha2) / 2))

        Citizen.InvokeNative(
            GetHashKey('DRAW_LINE') & 0xFFFFFFFF,
            x1, y1, z1,
            x2, y2, z2,
            180, 180, 180, lineConnectorAlpha
        )
    end
end

function GS_DrawText3D(entity, text)
    if not entity or not DoesEntityExist(entity) then return end

    local entityId = 'entity_' .. tostring(entity)

    local chestBoneIndex = GetEntityBoneIndexByName(entity, 'SKEL_Spine3')
    if chestBoneIndex == -1 then
        chestBoneIndex = GetEntityBoneIndexByName(entity, 'SKEL_Spine2')
    end

    local headBoneIndex = GetEntityBoneIndexByName(entity, 'SKEL_Head')
    local ec = GetEntityCoords(entity)

    local startCoords = chestBoneIndex ~= -1
        and GetWorldPositionOfEntityBone(entity, chestBoneIndex)
        or ec

    local headCoords = headBoneIndex ~= -1
        and GetWorldPositionOfEntityBone(entity, headBoneIndex)
        or vector3(ec.x, ec.y, ec.z + 1.0)

    local entityHeading = GetEntityHeading(entity)
    local offsetX = math.sin(math.rad(entityHeading + 90)) * 0.7
    local offsetY = math.cos(math.rad(entityHeading + 90)) * 0.7

    local textCoords = vector3(headCoords.x + offsetX, headCoords.y + offsetY, headCoords.z + 0.2)
    local lineCoords = vector3(headCoords.x + offsetX, headCoords.y + offsetY, headCoords.z - 0.1)

    local dirX = lineCoords.x - startCoords.x
    local dirY = lineCoords.y - startCoords.y
    local dirZ = lineCoords.z - startCoords.z
    local length = math.sqrt(dirX * dirX + dirY * dirY + dirZ * dirZ)
    if length > 0 then
        dirX = dirX / length
        dirY = dirY / length
        dirZ = dirZ / length
        local offsetDistance = 0.3
        startCoords = vector3(
            startCoords.x + dirX * offsetDistance,
            startCoords.y + dirY * offsetDistance,
            startCoords.z + dirZ * offsetDistance
        )
    end

    drawAnimatedCallout(entityId, text, startCoords, lineCoords, textCoords)
end

--- World shelf / coord anchor (no entity bones). Optional holdProgress 0.0–1.0 draws a fill bar.
function GS_DrawText3DAtCoords(anchorId, coords, heading, text, holdProgress)
    if type(coords) ~= 'vector3' or not anchorId then return end
    heading = heading or 0.0

    local lateral = 0.32
    local offsetX = math.sin(math.rad(heading + 90)) * lateral
    local offsetY = math.cos(math.rad(heading + 90)) * lateral

    local zBias = (Config and Config.ShelfTextZOffset) or 0.0
    local anchor = vector3(coords.x, coords.y, coords.z + zBias)
    local barX = anchor.x + offsetX
    local barY = anchor.y + offsetY
    local barZ = anchor.z + 0.13

    local startCoords = vector3(anchor.x, anchor.y, anchor.z - 0.12)
    local lineCoords = vector3(barX, barY, barZ)
    local textCoords = vector3(barX, barY, barZ + 0.045)

    drawAnimatedCallout(anchorId, text, startCoords, lineCoords, textCoords, {
        finalTextOffset = 0.004,
        holdProgress = holdProgress,
    })
end

function GS_IsDrawTextActive(id)
    local anim = textAnimations[id]
    return anim and anim.isActive
end

CreateThread(function()
    while true do
        GS_ManageTextAnimations()
        Wait(1000)
    end
end)
