Config = {}

--[[
  Notifications (dodi_notifys): escrow buyers edit strings here only.
  Set Config.Locale to a key of Config.Languages (e.g. 'en', 'pt').
  Copy a language table to add e.g. 'de'. Optional placeholders: %d, %s (string.format).
]]
Config.Locale = 'en'

Config.Languages = {
    en = {
        flagModelInvalid = 'Invalid flag model or failed to load.',
        gatePlacedPassCenter = 'Gate placed — pass through the centre to complete.',
        singleFlagSpawnCollision = 'Only one flag spawned — check collision / ground.',
        flagCreateFailed = 'Failed to create flags.',
        aiOpponentsAtStart = '%d AI opponent(s) at the start.',
        aiNoneSpawned = 'Derby AI: no opponents spawned (CreatePed / models). Check Config.DerbyAI.',
        nextGateAhead = 'Next gate ahead.',
        rivalsOnLineCountdown = '%d rival(s) on the line (countdown).',
        previewControls = 'Preview: ↑↓ width | Space confirm | Esc cancel',
        placementCancelledEditor = 'Placement cancelled — still in editor.',
        previewCancelled = 'Preview cancelled.',
        gatesRemoved = 'Gates removed.',
        firstPlaceFinish = '1st place crossed the line! %ds to finish.',
        startLineWaitingOthers = 'Start line reached! Waiting for other riders...',
        startGatePlacedRideThrough = 'Start gate placed - ride through when ready.',
        goPassGates = 'GO! Pass through the gates!',
        lobbyCreatedRide = 'Lobby created! Ride to the start line.',
        onCardFollowGps = "You're on the card! Ride to the start line.",
        lobbyError = 'Lobby error.',
        leftLobby = 'You left the lobby.',
        finishBeforeJoin = 'Finish or leave your current race session before joining another.',
        finishBeforeCreateLobby = 'Finish or wait for the current race to end before creating another lobby.',
        finishBeforeStartAnother = 'Finish or wait for the current race to end before starting another.',
        routeNoValidCheckpoints = 'This route has no valid checkpoints.',
        notEnoughCheckpoints = 'Not enough checkpoints to race.',
        creatingLobbyGps = 'Creating lobby... Follow GPS to the start line.',
        routeRemoved = 'Route removed.',
        editorOpenHint = 'Editor open — E or PgDn to place checkpoints, TAB to edit fields.',
        checkpointConfirmed = 'Checkpoint #%d confirmed.',
        backWorldPlaceCps = 'Back in world — E or PgDn to place checkpoints.',
        routeEditorTitle = 'Route Editor',
        routeSavedSubtitle = 'Route saved to database!',
        editingFields = 'Editing fields - type in the panel. ESC to go back.',
        saveInvalidData = 'Invalid data.',
        saveRouteSaved = 'Route saved.',
        saveRouteFailed = 'Failed to save route.',
        deleteOwnOnly = 'You can only delete your own routes.',
        deleteNotFound = 'Route not found.',
        deleteInvalid = 'Invalid route.',
        errAlreadyInRaceSession = 'You are already in a race session.',
        errJoinedExistingRide = 'Joined existing lobby! Ride to the start line.',
        errRaceActiveOnRoute = 'A race is already active on this route. Wait for it to finish.',
        errRouteNeedsTwoCps = 'Route needs at least 2 checkpoints.',
        errLobbyTimeout = 'Lobby timed out - not enough riders.',
        errLobbyNotFound = 'Lobby not found.',
        errRaceAlreadyStarted = 'Race already started.',
        errLobbyFull = 'Lobby is full.',
    },
    pt = {
        flagModelInvalid = 'Modelo de bandeira inválido ou não carregou.',
        gatePlacedPassCenter = 'Portão colocado — passa pelo centro para completar.',
        singleFlagSpawnCollision = 'Só uma bandeira spawnou — verifica colisão/chão.',
        flagCreateFailed = 'Falha ao criar bandeiras.',
        aiOpponentsAtStart = '%d adversário(s) IA na largada.',
        aiNoneSpawned = 'Derby IA: nenhum adversário spawnou (CreatePed/modelos). Confirma nomes em Config.DerbyAI.',
        nextGateAhead = 'Próximo portão à frente.',
        rivalsOnLineCountdown = '%d rival(is) na linha (contagem).',
        previewControls = 'Preview: ↑↓ largura | Espaço confirmar | Esc cancelar',
        placementCancelledEditor = 'Colocação cancelada — ainda no editor.',
        previewCancelled = 'Preview cancelado.',
        gatesRemoved = 'Portões removidos.',
        firstPlaceFinish = '1º lugar cruzou a linha! %ds para terminar.',
        startLineWaitingOthers = 'Linha de largada! À espera dos outros cavaleiros...',
        startGatePlacedRideThrough = 'Portão de largada colocado — atravessa quando estiveres pronto.',
        goPassGates = 'VAI! Passa pelos portões!',
        lobbyCreatedRide = 'Lobby criado! Segue o GPS até à largada.',
        onCardFollowGps = 'Estás na lista! Segue o GPS até à largada.',
        lobbyError = 'Erro no lobby.',
        leftLobby = 'Saíste do lobby.',
        finishBeforeJoin = 'Termina ou sai da sessão de corrida antes de entrares noutra.',
        finishBeforeCreateLobby = 'Termina ou espera que a corrida acabe antes de criares outro lobby.',
        finishBeforeStartAnother = 'Termina ou espera que a corrida acabe antes de iniciares outra.',
        routeNoValidCheckpoints = 'Esta rota não tem checkpoints válidos.',
        notEnoughCheckpoints = 'Checkpoints insuficientes para correr.',
        creatingLobbyGps = 'A criar lobby... Segue o GPS até à largada.',
        routeRemoved = 'Rota removida.',
        editorOpenHint = 'Editor aberto — E ou PgDn para colocar checkpoints, TAB para editar campos.',
        checkpointConfirmed = 'Checkpoint #%d confirmado.',
        backWorldPlaceCps = 'De volta ao mundo — E ou PgDn para colocar checkpoints.',
        routeEditorTitle = 'Editor de rotas',
        routeSavedSubtitle = 'Rota guardada na base de dados!',
        editingFields = 'A editar campos — escreve no painel. ESC para voltar.',
        saveInvalidData = 'Dados inválidos.',
        saveRouteSaved = 'Rota guardada.',
        saveRouteFailed = 'Falha ao guardar a rota.',
        deleteOwnOnly = 'Só podes apagar as tuas rotas.',
        deleteNotFound = 'Rota não encontrada.',
        deleteInvalid = 'Rota inválida.',
        errAlreadyInRaceSession = 'Já estás numa sessão de corrida.',
        errJoinedExistingRide = 'Entraste num lobby existente! Segue o GPS até à largada.',
        errRaceActiveOnRoute = 'Já há uma corrida ativa nesta rota. Espera que termine.',
        errRouteNeedsTwoCps = 'A rota precisa de pelo menos 2 checkpoints.',
        errLobbyTimeout = 'Lobby expirou — poucos cavaleiros.',
        errLobbyNotFound = 'Lobby não encontrado.',
        errRaceAlreadyStarted = 'A corrida já começou.',
        errLobbyFull = 'Lobby cheio.',
    },
}



--- Main NUI: career, events (fixtures + route previews), player races, guide.
Config.UI = {
    openCommand = 'derby',
    openDescription = 'Open Derby Horse racing menu (career, events, player races)',
}

--- Route editor: `/derbyedit` opens the side panel to create/edit races (saved to DB).
Config.Editor = {
    openCommand = 'derbyedit',
    openDescription = 'Open Derby Horse race route editor',
}


--[[
  Example routes for UI course preview (world X/Y/Z).
]]
Config.CatalogRoutes = {
    {
        id = 'saint_denis_sprint_mansions',
        name = 'Saint Denis Sprint - Mansion',
        region = 'Saint Denis',
        surface = 'Firm ground',
        minPlayers = 2,
        maxPlayers = 8,
        aiEnabled = true,
        aiCount = 7,
        checkpoints = {
            { x = 2573.8373800563897, y = -1263.1772361294332, z = 51.07536315917969 },
            { x = 2549.631850060475, y = -1262.6778959012689, z = 48.69091033935547 },
            { x = 2533.326189501567, y = -1262.5812523942905, z = 48.13862228393555 },
            { x = 2515.881108685522, y = -1262.5055601773698, z = 48.111083984375 },
            { x = 2502.9293009720574, y = -1262.9500311037912, z = 48.18978118896484 },
            { x = 2479.966769921261, y = -1260.435875255222, z = 47.55955505371094 },
            { x = 2463.360990870245, y = -1255.8065765240534, z = 46.09420394897461 },
            { x = 2446.228488181053, y = -1250.985959636109, z = 45.34934997558594 },
            { x = 2426.746253298631, y = -1245.1867415522139, z = 44.67013549804687 },
            { x = 2412.029841846187, y = -1239.7599611903716, z = 44.58846664428711 },
            { x = 2410.335860938093, y = -1225.3426242991484, z = 44.89287185668945 },
            { x = 2410.228111471985, y = -1204.8125998002814, z = 44.59804534912109 },
            { x = 2409.679634243406, y = -1183.5031248726603, z = 44.7696304321289 },
            { x = 2410.1608273888398, y = -1161.7378664591498, z = 45.36848449707031 },
            { x = 2409.7565988808025, y = -1147.8821621894104, z = 45.85339736938476 },
            { x = 2407.163825520476, y = -1134.945780584842, z = 45.76911926269531 },
            { x = 2396.7262783423777, y = -1131.8656703735956, z = 45.77276229858398 },
            { x = 2385.9756557994849, y = -1131.6428541961282, z = 45.59652328491211 },
            { x = 2372.479032036757, y = -1129.1677973029437, z = 45.40516662597656 },
            { x = 2365.8743402763068, y = -1122.865196394261, z = 45.3256950378418 },
            { x = 2354.4184272622867, y = -1117.5277461506433, z = 45.33584976196289 },
            { x = 2347.5901108195087, y = -1123.4984155539208, z = 45.33264923095703 },
            { x = 2352.6192110581134, y = -1133.5036958972665, z = 45.33617401123047 },
            { x = 2361.1038215447208, y = -1135.6481068803728, z = 45.33581924438476 },
            { x = 2369.222540082591, y = -1137.9901816714808, z = 45.37287139892578 },
            { x = 2378.7934397213787, y = -1140.5975062116218, z = 45.49073791503906 },
            { x = 2394.406812771683, y = -1142.5648991989199, z = 45.80022048950195 },
            { x = 2435.468989959717, y = -1143.9340139762992, z = 46.68834686279297 },
            { x = 2462.2929615868799, y = -1144.0911051591739, z = 47.10626220703125 },
            { x = 2483.8442315945369, y = -1144.1526481810857, z = 48.01399612426758 },
        },
        closedLoop = false,
    },
    {
        id = 'saint_denis_sprint',
        name = 'Saint Denis Sprint',
        region = 'Saint Denis',
        surface = 'Firm ground',
        minPlayers = 2,
        maxPlayers = 6,
        aiEnabled = true,
        aiCount = 7,
        checkpoints = {
            { x = 2708.559573520066, y = -1207.4325690057977, z = 50.81536102294922 },
            { x = 2708.7328095462896, y = -1229.3696014936448, z = 49.25262069702148 },
            { x = 2713.3366595170839, y = -1243.3901913440284, z = 49.04899978637695 },
            { x = 2735.6652681740777, y = -1241.5470396349795, z = 49.01545715332031 },
            { x = 2749.4362963147225, y = -1217.5205611304703, z = 48.51288604736328 },
            { x = 2770.1633466512287, y = -1178.6363019794877, z = 47.44426727294922 },
            { x = 2768.9141798840626, y = -1168.5801572899407, z = 47.47415924072265 },
            { x = 2750.3959860579027, y = -1156.651459958267, z = 48.24147415161133 },
            { x = 2731.124813408026, y = -1145.337072689669, z = 48.96139526367187 },
            { x = 2715.03956341683, y = -1141.116075991582, z = 49.35013961791992 },
            { x = 2709.2985099555187, y = -1147.80384291378, z = 49.48202133178711 },
            { x = 2708.6462996509364, y = -1205.5925116012937, z = 50.81673812866211 },




        },
        closedLoop = false,
    },
    
    {
        id = 'dakota_river_sprint',
        name = 'Dakota River Sprint',
        region = 'Dakota River',
        surface = 'Mixed terrain',
        minPlayers = 2,
        maxPlayers = 8,
        aiEnabled = true,
        aiCount = 7,
        checkpoints = {
               { x = -781.8105692702017, y = -146.876182155, z = 78.78619384765625 },
               { x = -812.5377159883558, y = -156.04939915687457, z = 74.87268829345703 },
               { x = -855.3773223222139, y = -149.4671600728364, z = 69.98204040527344 },
               { x = -881.5191318968563, y = -123.96237769967182, z = 64.3426513671875 },
               { x = -913.5413965827545, y = -111.28702439391505, z = 57.41836929321289 },
               { x = -942.7659152788717, y = -108.31994571568007, z = 50.5339126586914 },
               { x = -979.4204821515849, y = -110.54502364490041, z = 44.68770599365234 },
               { x = -1022.5026587148885, y = -101.09796639199215, z = 44.09802627563476 },
               { x = -1042.289778777416, y = -103.16132865084411, z = 44.35872268676758 },
               { x = -1070.1665651818776, y = -110.99100775441207, z = 44.24033737182617 },
               { x = -1103.6878837721263, y = -110.58900107458463, z = 43.58394241333008 },
               { x = -1139.5289489549166, y = -91.85117705772888, z = 42.60071563720703 },
               { x = -1158.565534049779, y = -59.51070712685919, z = 41.64979934692383 },
               { x = -1179.3916405642572, y = -35.23901775616791, z = 41.97117614746094 },
               { x = -1197.3175598033095, y = -29.0209520581538, z = 44.2193374633789 },
               { x = -1218.1819287116235, y = -14.03902135474538, z = 46.33442687988281 },
               { x = -1225.5206328078935, y = 3.18534387030406, z = 44.80331039428711 },
               { x = -1246.7898477373026, y = 12.2127881306539, z = 47.41349792480469 },
            },
            closedLoop = false,
    },
}

--- Join flow: GPS only to CP1. Inside radius → clear GPS, mark CP2, then countdown + freeze + gate.
Config.DerbyRace = {
    countdownSec = 5,
    --- If false: GPS + flags only at the end (no freeze / countdown numbers).
    lockMountDuringCountdown = true,
    --- Horizontal distance (m) to CP1 to count as “on the start line”.
    arriveStartRadiusM = 22.0,
    --- Z tolerance (m) so steep ground does not fail the check.
    arriveStartZTol = 40.0,
    --- On countdown start: teleport horse/ped behind CP1 (start side), facing CP2.
    snapToStartLine = true,
    --- Meters back from CP1 along the CP1→CP2 line (“behind the line”).
    startLineupBackM = 7.5,
    --- false = you always on the reference row, AI behind (legacy). true = randomize depth for you + AI (who sits closer to CP1 is random).
    randomizeStartGridDepth = true,
    --- With randomizeStartGridDepth: server orders players + AI in one list by reputation (humans = DB; AI = stable virtual rep — see DerbyAI.startGridVirtualRep*). false = legacy client-only shuffle.
    reputationOrderedStartGrid = true,
    --- true = start grid in rows: fill gate width (flags) with side-by-side slots; full row → next row behind. Needs randomizeStartGridDepth or server grid.
    startGridCompactRows = true,
    startGridSlotWidthM = 1.12,
    startGridGateInsetM = 0.55,
    --- nil = use DerbyAI.depthStaggerM between rows.
    startGridRowStaggerM = nil,
    --- After each race gate passed (NUI): BOOST_PLAYER_HORSE_SPEED_FOR_TIME. false or mult ≤ 0 = off.
    checkpointHorseBoostEnabled = true,
    --- Multiplier (try lower values if animation/physics glitch).
    checkpointHorseBoostMultiplier = 150.0,
    checkpointHorseBoostDurationMs = 22000,
    --- Side leaderboard: server + NUI sync (ms). Lower = tighter, more traffic; 50–200 is reasonable.
    leaderboardIntervalMs = 100,
}

--- AI opponents at the start (NUI race: join / player route / startPreRace). Client-local only.
Config.DerbyAI = {
    enabled = true,
    --- Spawn on the line when 5-4-3… starts (with player freeze). false = only after GO (legacy).
    spawnDuringCountdown = true,
    --- With spawnDuringCountdown: freeze AI horses during countdown.
    freezeDuringCountdown = true,
    --- How many extra riders (max 8).
    count = 8,
    --- Reputation grid: each AI gets virtual rep in this range (lobby+slot hash) to mix with players on the grid.
    startGridVirtualRepMin = 0,
    startGridVirtualRepMax = 1500,
    --- Lateral spacing (m) between slots in the same “row” (lower = less spread).
    lateralSpacingM = 1.25,
    --- Per lateral step (|slot|), extra back along the line (m). 0 = same depth as axis (avoids looking always ahead in the centre). >0 = wings further back (narrow paths).
    spawnExtraBackPerLateralStepM = 0.0,
    --- Each next opponent sits this much further back in depth (~2.2m+ reduces horse pile-ups).
    depthStaggerM = 2.6,
    --- Extra meters behind your row: uses DerbyRace.startLineupBackM + this when backOffsetM is not set.
    behindPlayerExtraM = 0.85,
    --- Optional: fixed back offset (m) from CP1. If nil / omitted, uses startLineupBackM + behindPlayerExtraM.
    -- backOffsetM = 10.0,
    --- Wait (ms) before spawning after the gate appears (only if spawnDuringCountdown = false).
    spawnDelayMs = 400,
    --- Re-issue / refresh task every X ms (lower = recovers from obstacles faster).
    retaskMs = 900,
    --- Requested speed in tasks (nav mesh or straight). Raise if AI looks like walking. Typical 0.5–15.0
    approachSpeed = 15.0,
    --- Lateral offset meters per start slot step (±1, ±2…). Lower = closer to centre line.
    routeLaneOffsetPerSlotM = 1.15,
    --- Extra scale on lane offset (1 = per slot only; 0.6 = pull everyone toward centre). Used at start + matches pursuit.
    routeLaneOffsetScale = 0.68,
    --- On straight or gentle curve (not “sharp”): laneEff *= (1 - this). 0 = off; ~0.35–0.5 = tighter pack toward centre.
    routeLaneStraightPullToCenter = 0.4,
    --- Max |lateral offset| (m). nil = half gate width (DerbyRace.halfW or DerbyGate.defaultHalfWidth) minus routeLaneGateInsetM.
    routeLaneMaxAbsM = nil,
    --- Margin (m) between max offset and flag half-width — stay inside the gate “track”.
    routeLaneGateInsetM = 0.55,
    --- Near a tight turn (same rule as routeSharpTurnDeg): within this radius (m) of target CP, lateral offset goes to 0 — back to axis, avoids walls.
    routeLaneCenterNearTurnM = 15.0,
    --- Vary lookahead by AI index (narrow band = less path spread).
    routeLookaheadSpreadMin = 0.97,
    routeLookaheadSpreadMax = 1.03,
    --- SetPedMaxMoveBlendRatio on rider (1–10). High = very “hard” gallop; 4–6 often looks more natural.
    aiMoveBlendMax = 4.5,
    --- Follow route midline (between checkpoints), not navmesh edges.
    followRouteCenter = true,
    --- Last CP (open route): target is X m **past** the line along penultimate→last (avoids hard brake on the flag).
    finishApproachPastM = 28.0,
    --- After counting finished (CP passed): keep retasking up to X m past the flag until despawn.
    finishRunThroughM = 38.0,
    --- Multiplier on `approachSpeed` only in post-finish run-through phase.
    finishSprintSpeedMult = 1.18,
    --- On final straight (still `ti == n`, before counting finished): optional. nil = use `finishSprintSpeedMult`.
    finishApproachSpeedMult = nil,
    --- Base meters “ahead” on segment. With multi-seg, total lookahead can spill into following segments.
    routeLookaheadM = 22.0,
    --- Minimum lookahead after caps (avoids target on top of rider).
    routeLookaheadMinM = 4.0,
    --- Max fraction of segment **still ahead** (1-t0) usable as lookahead (within segment).
    routeLookaheadSegmentRemainFrac = 0.85,
    --- Lookahead cannot exceed this fraction of straight-line rider→CP distance (within segment).
    routeLookaheadDistToCpFrac = 0.60,
    --- true = when baseLook passes current CP, continue on next segment (up to 3 segs; stops on tight bend).
    routeMultiSegLookahead = true,
    --- If next segment turns more than this angle (deg), reduce extra lookahead.
    routeSharpTurnDeg = 30.0,
    routeSharpTurnLookScale = 0.28,
    --- Distance (m) to bend where fade starts; far = no reduction, near = full reduction.
    routeSharpTurnFadeM = 18.0,
    --- Within this distance (m) of a sharp bend, aim straight at CP (avoids cutting walls). Higher = less “everyone on the pin” in the bend.
    routeSharpTurnSnapM = 22.0,
    --- true = navmesh (often hugs road edges). With followRouteCenter, straights stay on CP axis.
    useNavMeshTask = false,
    --- Distance to CP to count “arrived” on nav task (m).
    navMeshStopRange = 0.75,
    --- Buff AI horse stats (false = leave vanilla).
    buffHorseAttributes = true,
    --- Base rank 0–10 (10 = max).
    horseSpeedRank = 10,
    horseAccelRank = 10,
    --- Attribute overpower — pushes real gallop feel.
    useHorseOverpower = true,
    horseOverpowerSpeed = 150.0,
    horseOverpowerAccel = 150.0,
    --- If horse speed < ~0.2 m/s for this long (ms), ClearPedTasks and retask.
    stuckClearAfterMs = 4200,
    --- If stuck for ≥ this ms, snap horse+rider to route axis (nearest CP). 0 = off.
    stuckRecenterAfterMs = 3000,
    --- Min time between recenters on same opponent (avoids spam if still stuck).
    stuckRecenterCooldownMs = 10000,
    --- Advance to next CP when rider is within this horizontal distance squared (20m = 400).
    advanceCheckpointDistSq = 400.0,
    --- Advance even outside radius if almost done prev CP → current CP segment.
    advanceAlongSegmentT = 0.985,
    --- Alternative to radius: capture CP inside this “tube” around the route line.
    advanceTubeMinT = 0.90,
    advanceTubePerpM = 14.0,
    --- Tighter distance squared to advance CP on sharp bends (8m = 64). Forces AI close before turning.
    advanceTurnDistSq = 64.0,
    horseModels = {
        'a_c_horse_appaloosa_fewspotted_pc',
        'a_c_horse_criollo_marblesabino',
        'a_c_horse_arabian_white',
    },
    riderModels = {
        'a_m_m_ranchertravelers_cool_01',
        'a_m_m_ranchertravelers_warm_01',
        'g_m_m_uniranchers_01',
    },
}

--- `/derbyflags` gates: radius (m) to count “passed checkpoint” (removes arrow + burst).
Config.DerbyGate = {
    --- “Strict” radius (/derbyflags only: must leave before counting again).
    checkpointRadius = 5.0,
    --- Meters added to radius for pass detection (count passing at flag edges).
    checkpointPassExtraM = 2.75,
    --- true = X/Y distance only (tall horse / gate Z does not block count).
    checkpointHorizontal2D = true,
    defaultHalfWidth = 3.5,
    minHalfWidth = 1.0,
    maxHalfWidth = 14.0,
    widthStep = 0.35,
    previewFlagAlpha = 110,
    previewArrowAlpha = 0.42,
}

--- Career / reputation (MySQL `derby_player_career`, keyed by RSG `citizenid`).
--- `catalog` = Config.CatalogRoutes meets. `custom` = player-made routes (`pr-*`) or ad-hoc checkpoints.
Config.DerbyCareer = {
    -- default routes from the catalog
    catalog = {
        --- XP (reputation) by finishing place: 1st, 2nd, 3rd, … extra places use last value.
        xpByPlace = { 50, 36, 28, 22, 16, 12, 8, 5 },
        --- Added on top of xpByPlace[1] for the winner only.
        winBonusXp = 20,
        --- Did not finish (timer / disconnect before line).
        dnfXp = 6,
    },
    -- custom routes created by the players
    custom = {
        xpByPlace = { 38, 28, 20, 14, 10, 7, 5, 3 },
        winBonusXp = 12,
        dnfXp = 4,
    },
    --- Sorted by minRep ascending; highest tier where reputation >= minRep wins.
    handicapTitles = {
        { minRep = 0, title = 'Rookie' },
        { minRep = 150, title = 'Novice Rider' },
        { minRep = 400, title = 'Handicapper' },
        { minRep = 800, title = 'Stakes Rider' },
        { minRep = 1500, title = 'Derby Veteran' },
        { minRep = 3000, title = 'Turf Champion' },
    },
    --- If false: 1 human + AI only — no +starts, wins, rep, or DNF XP. Two+ humans always count.
    --- Solo (1 human, 0 AI) never gives career progress regardless of this flag.
    awardCareerXpHumanVsAi = true,
}

--- Hall of Fame tab (NUI): top riders from `derby_player_career` by reputation.
Config.DerbyHallOfFame = {
    topCount = 25,
}

--- Lobby multiplayer: min/max players, timeout, host controls.
Config.DerbyLobby = {
    defaultMinPlayers = 2,
    defaultMaxPlayers = 8,
    readyTimeoutSec = 300,
    hostCanForceStart = true,
    showWaitingHud = true,
    finishTimerSec = 30,
    --- If an AI rival finishes before any player: name shown in notice (`finishTimerSec` still applies).
    aiFirstFinishWinnerName = 'A rival',
    --- Force Start (host) while mounted: F4 — EnableControlAction in ui.lua.
    forceStartControlHashes = { 0x1F6D95E5 },
    leaveLobbyControlHashes = { 0x156F7119, 0x4AF4D473 },
}

--- Resolve a notification string for the active Config.Locale (fallback: en, then key).
function DerbyLang(key, ...)
    local loc = Config.Locale or 'en'
    local langs = Config.Languages
    local pack = (langs and langs[loc]) or (langs and langs.en) or {}
    local fmt = pack[key]
    if type(fmt) ~= 'string' or fmt == '' then
        pack = (langs and langs.en) or {}
        fmt = pack[key]
    end
    if type(fmt) ~= 'string' then
        return tostring(key)
    end
    local n = select('#', ...)
    if n > 0 then
        local ok, out = pcall(string.format, fmt, ...)
        if ok then
            return out
        end
    end
    return fmt
end