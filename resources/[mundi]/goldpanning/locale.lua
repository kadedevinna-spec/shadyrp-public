-- ===============================================
-- LOCALE CONFIGURATION
-- ===============================================
-- Language is set in config.lua via Config.Locale
-- Available languages: "en" (English), "sr" (Serbian)
-- Add your own translations below and set Config.Locale to your language code

-- ===============================================
-- LOCALES
-- ===============================================
Locales = {}

-- English
Locales["en"] = {
    -- Water Collection
    noWater = "You must be near water to collect.",
    collectingWater = "Collecting Water",
    needNearWater = "You need to be near water to collect water!",
    waterCollected = "You filled your watering can with water!",
    noEmptyWaterCan = "You don't have an empty watering can!",
    noEmptyWateringCan = "You don't have an empty watering can!",
    
    -- Sediment Collection
    collectingSediment = "Collecting river sediment...",
    needNearWaterSediment = "You need to be near water to collect sediment!",
    sedimentCollected = "You collected %s river sediment!",
    noMudBucket = "You don't have a mud bucket!",
    notEnoughInventorySpace = "You don't have enough inventory space!",
    
    -- Cradle Placement
    alreadyPlacingCradle = "You are already placing a cradle!",
    cradlePlaceNearWater = "You must be near water to place a cradle!",
    cradlePlaceNearRiver = "You must be near a river or lake to pan for gold!",
    buildingCradle = "Building cradle...",
    cradlePlaced = "Cradle placed successfully!",
    placementCancelled = "Placement cancelled.",
    noCradleNearby = "No cradle found nearby!",
    cannotCarryCradle = "You cannot carry the cradle!",
    cradleLabel = "Gold Wash Cradle",
    
    -- Pouring Water
    pouringWater = "Pouring water...",
    cradleHasWater = "The cradle already has water!",
    needFullBucket = "You need a full bucket to pour water!",
    noFullBucketToPour = "You don't have a full bucket to pour!",
    
    -- Pouring Sediment
    pouringSediment = "Pouring sediment...",
    cradleHasSediment = "The cradle already has sediment!",
    needMoreSediment = "You need more river sediment",
    noSedimentToPour = "You don't have river sediment to pour!",
    sedimentPoured = "You poured 5 river sediment!",
    need5Sediment = "You need 5 river sediment to pour!",
    
    -- Gold Panning
    noGoldPan = "You don't have a gold pan!",
    dontHaveGoldPan = "You don't have a gold pan!",
    goldPanBroke = "Your gold pan broke from wear and tear!",
    cradleBroke = "Your cradle is too worn out to use again.",
    cradleWornOut = "Your cradle is worn out. Pick it up when you're done.",
    wateringBucketBroke = "Your watering bucket broke from wear and tear!",
    mudBucketBroke = "Your mud bucket broke from wear and tear!",
    areaDepleted = "This area seems depleted. Best to try elsewhere.",
    actionFailed = "Action failed.",
    
    -- Collection Results
    collectedResults = "You collected: ",
    goldFlakes = " gold flake(s)",
    goldNuggets = " gold nugget(s)",
    andText = " and ",
    noGoldCollected = "You didn't collect any gold this time.",
    foundGoldFlake = "You found a gold flake!",
    foundGoldNugget = "You found a gold nugget!",
    
    -- Inventory
    notEnoughSpace = "Not enough inventory space!",
    notEnoughSpaceFlakes = "Not enough inventory space for the flakes!",
    notEnoughSpaceNuggets = "Not enough inventory space for the nuggets!",
    notEnoughSpaceNugget = "Not enough space for the nugget!",
    
    -- Cradle Pickup
    pickingUpCradle = "Picking up cradle...",
    cradlePickedUp = "Cradle picked up.",
    
    -- Cooldown Messages
    waitPourWater = "You must wait before pouring water again.",
    waitPourSediment = "You must wait before pouring sediment again.",
    waitPickupCradle = "You must wait before picking up the cradle again.",
    waitCollectWater = "You must wait before collecting water again.",
    waitCollectSediment = "You must wait before collecting sediment again.",
    
    -- UI Labels (for ox_target)
    labelPourWater = "Pour Water",
    labelPourSediment = "Pour Sediment",
    labelPanGold = "Pan for Gold",
    labelPickupCradle = "Pick Up Cradle",
    labelPlace = "Place",
    labelCancel = "Cancel",
    
    -- Placement UI (on-screen text)
    placementInstructions = "[G] %s | [E] %s | SCROLL Rotate | UP/DOWN Height",
    
    -- Progress Bar Labels
    progressCollectingWater = "Collecting Water",
    progressCollectingSediment = "Collecting river sediment...",
    progressBuildingCradle = "Building cradle...",
    progressPouringWater = "Pouring water...",
    progressPouringSediment = "Pouring sediment...",
    progressPickingUpCradle = "Picking up cradle...",
    
    -- Gold Rush (optional - if showing notifications)
    goldRushLocation = "You've found a gold rush location!",
    
    -- Restricted Zone
    restrictedZone = "Gold panning is not allowed in this water. Try a river in the frontier!",
    
    -- Weather Effects (optional - if showing notifications)
    weatherAffecting = "The weather is affecting gold yields.",
    
    -- Minigame UI
    goldCounter = "Gold: ",
    timerSeconds = "s",
    soundToggleTitle = "Toggle Sound Effects",
}

-- Serbian (Српски)
Locales["sr"] = {
    -- Water Collection
    noWater = "Morate biti blizu vode da biste sakupili.",
    collectingWater = "Sakupljanje Vode",
    needNearWater = "Morate biti blizu vode da biste sakupili vodu!",
    waterCollected = "Napunili ste kantu sa vodom!",
    noEmptyWaterCan = "Nemate praznu kantu za vodu!",
    noEmptyWateringCan = "Nemate praznu kantu za vodu!",
    
    -- Sediment Collection
    collectingSediment = "Sakupljanje rečnog sedimenta...",
    needNearWaterSediment = "Morate biti blizu vode da biste sakupili sediment!",
    sedimentCollected = "Sakupili ste %s rečnog sedimenta!",
    noMudBucket = "Nemate kantu za blato!",
    notEnoughInventorySpace = "Nemate dovoljno mesta u inventaru!",
    
    -- Cradle Placement
    alreadyPlacingCradle = "Već postavljate kolevku!",
    cradlePlaceNearWater = "Morate biti blizu vode da biste postavili kolevku!",
    buildingCradle = "Gradnja kolevke...",
    cradlePlaced = "Kolevka uspešno postavljena!",
    placementCancelled = "Postavljanje otkazano.",
    noCradleNearby = "Nema kolevke u blizini!",
    cannotCarryCradle = "Ne možete poneti kolevku!",
    cradleLabel = "Kolevka za Pranje Zlata",
    
    -- Pouring Water
    pouringWater = "Sipanje vode...",
    cradleHasWater = "Kolevka već ima vodu!",
    needFullBucket = "Potrebna vam je puna kanta za sipanje vode!",
    noFullBucketToPour = "Nemate punu kantu za sipanje!",
    
    -- Pouring Sediment
    pouringSediment = "Sipanje sedimenta...",
    cradleHasSediment = "Kolevka već ima sediment!",
    needMoreSediment = "Potrebno vam je više rečnog sedimenta",
    noSedimentToPour = "Nemate rečni sediment za sipanje!",
    sedimentPoured = "Sipali ste 5 rečnog sedimenta!",
    need5Sediment = "Potrebno vam je 5 rečnog sedimenta za sipanje!",
    
    -- Gold Panning
    noGoldPan = "Nemate posudu za pranje zlata!",
    dontHaveGoldPan = "Nemate posudu za pranje zlata!",
    goldPanBroke = "Vaša posuda za pranje zlata se pokvarila od habanja!",
    cradleBroke = "Vaša kolevka je previše istrošena da bi se ponovo koristila.",
    cradleWornOut = "Vaša kolevka je istrošena. Pokupite je kada završite.",
    wateringBucketBroke = "Vaša kanta za vodu se pokvarila od habanja!",
    mudBucketBroke = "Vaša kanta za blato se pokvarila od habanja!",
    areaDepleted = "Ovo područje izgleda iscrpljeno. Najbolje je pokušati negde drugde.",
    actionFailed = "Akcija neuspešna.",
    
    -- Collection Results
    collectedResults = "Sakupili ste: ",
    goldFlakes = " pahuljica zlata",
    goldNuggets = " grumena zlata",
    andText = " i ",
    noGoldCollected = "Ovog puta niste sakupili zlato.",
    foundGoldFlake = "Pronašli ste pahuljicu zlata!",
    foundGoldNugget = "Pronašli ste grumen zlata!",
    
    -- Inventory
    notEnoughSpace = "Nema dovoljno mesta u inventaru!",
    notEnoughSpaceFlakes = "Nema dovoljno mesta u inventaru za pahuljice!",
    notEnoughSpaceNuggets = "Nema dovoljno mesta u inventaru za grumene!",
    notEnoughSpaceNugget = "Nema dovoljno mesta za grumen!",
    
    -- Cradle Pickup
    pickingUpCradle = "Podizanje kolevke...",
    cradlePickedUp = "Kolevka pokupljena.",
    
    -- Cooldown Messages
    waitPourWater = "Morate sačekati pre nego što ponovo sipate vodu.",
    waitPourSediment = "Morate sačekati pre nego što ponovo sipate sediment.",
    waitPickupCradle = "Morate sačekati pre nego što ponovo pokupite kolevku.",
    waitCollectWater = "Morate sačekati pre nego što ponovo sakupite vodu.",
    waitCollectSediment = "Morate sačekati pre nego što ponovo sakupite sediment.",
    
    -- UI Labels (for ox_target)
    labelPourWater = "Sipaj Vodu",
    labelPourSediment = "Sipaj Sediment",
    labelPanGold = "Peri Zlato",
    labelPickupCradle = "Podigni Kolevku",
    labelPlace = "Postavi",
    labelCancel = "Otkaži",
    
    -- Placement UI (on-screen text)
    placementInstructions = "[G] %s | [E] %s | SCROLL Rotiraj | GORE/DOLE Visina", -- Format: [G] Postavi | [E] Otkaži
    
    -- Progress Bar Labels
    progressCollectingWater = "Sakupljanje Vode",
    progressCollectingSediment = "Sakupljanje rečnog sedimenta...",
    progressBuildingCradle = "Gradnja kolevke...",
    progressPouringWater = "Sipanje vode...",
    progressPouringSediment = "Sipanje sedimenta...",
    progressPickingUpCradle = "Podizanje kolevke...",
    
    -- Gold Rush (optional - if showing notifications)
    goldRushLocation = "Pronašli ste lokaciju zlatne groznice!",
    
    -- Restricted Zone
    restrictedZone = "Pranje zlata nije dozvoljeno u ovoj vodi. Pokušajte na reci u divljini!",
    
    -- Weather Effects (optional - if showing notifications)
    weatherAffecting = "Vreme utiče na prinos zlata.",
    
    -- Minigame UI
    goldCounter = "Zlato: ",
    timerSeconds = "s",
    soundToggleTitle = "Uključi/Isključi Zvučne Efekte",
}

-- French (Français)
Locales["fr"] = {
    -- Water Collection
    noWater = "Vous devez être près de l'eau pour collecter.",
    collectingWater = "Collecte d'eau",
    needNearWater = "Vous devez être près de l'eau pour collecter de l'eau!",
    waterCollected = "Vous avez rempli votre seau d'eau!",
    noEmptyWaterCan = "Vous n'avez pas de seau vide!",
    noEmptyWateringCan = "Vous n'avez pas de seau vide!",
    
    -- Sediment Collection
    collectingSediment = "Collecte de sédiments de rivière...",
    needNearWaterSediment = "Vous devez être près de l'eau pour collecter des sédiments!",
    sedimentCollected = "Vous avez collecté %s sédiments de rivière!",
    noMudBucket = "Vous n'avez pas de seau à boue!",
    notEnoughInventorySpace = "Vous n'avez pas assez d'espace dans l'inventaire!",
    
    -- Cradle Placement
    alreadyPlacingCradle = "Vous placez déjà un berceau!",
    cradlePlaceNearWater = "Vous devez être près de l'eau pour placer un berceau!",
    buildingCradle = "Construction du berceau...",
    cradlePlaced = "Berceau placé avec succès!",
    placementCancelled = "Placement annulé.",
    noCradleNearby = "Aucun berceau trouvé à proximité!",
    cannotCarryCradle = "Vous ne pouvez pas porter le berceau!",
    cradleLabel = "Berceau de Lavage d'Or",
    
    -- Pouring Water
    pouringWater = "Verser de l'eau...",
    cradleHasWater = "Le berceau a déjà de l'eau!",
    needFullBucket = "Vous avez besoin d'un seau plein pour verser de l'eau!",
    noFullBucketToPour = "Vous n'avez pas de seau plein à verser!",
    
    -- Pouring Sediment
    pouringSediment = "Verser des sédiments...",
    cradleHasSediment = "Le berceau a déjà des sédiments!",
    needMoreSediment = "Vous avez besoin de plus de sédiments de rivière",
    noSedimentToPour = "Vous n'avez pas de sédiments de rivière à verser!",
    sedimentPoured = "Vous avez versé 5 sédiments de rivière!",
    need5Sediment = "Vous avez besoin de 5 sédiments de rivière pour verser!",
    
    -- Gold Panning
    noGoldPan = "Vous n'avez pas de batée!",
    dontHaveGoldPan = "Vous n'avez pas de batée!",
    goldPanBroke = "Votre batée s'est cassée à cause de l'usure!",
    cradleBroke = "Votre berceau est trop usé pour être réutilisé.",
    cradleWornOut = "Votre berceau est usé. Ramassez-le quand vous avez terminé.",
    wateringBucketBroke = "Votre seau d'eau s'est cassé à cause de l'usure!",
    mudBucketBroke = "Votre seau à boue s'est cassé à cause de l'usure!",
    areaDepleted = "Cette zone semble épuisée. Mieux vaut essayer ailleurs.",
    actionFailed = "Action échouée.",
    
    -- Collection Results
    collectedResults = "Vous avez collecté: ",
    goldFlakes = " paillette(s) d'or",
    goldNuggets = " pépite(s) d'or",
    andText = " et ",
    noGoldCollected = "Vous n'avez pas collecté d'or cette fois.",
    foundGoldFlake = "Vous avez trouvé une paillette d'or!",
    foundGoldNugget = "Vous avez trouvé une pépite d'or!",
    
    -- Inventory
    notEnoughSpace = "Pas assez d'espace dans l'inventaire!",
    notEnoughSpaceFlakes = "Pas assez d'espace dans l'inventaire pour les paillettes!",
    notEnoughSpaceNuggets = "Pas assez d'espace dans l'inventaire pour les pépites!",
    notEnoughSpaceNugget = "Pas assez d'espace pour la pépite!",
    
    -- Cradle Pickup
    pickingUpCradle = "Ramasser le berceau...",
    cradlePickedUp = "Berceau ramassé.",
    
    -- Cooldown Messages
    waitPourWater = "Vous devez attendre avant de verser à nouveau de l'eau.",
    waitPourSediment = "Vous devez attendre avant de verser à nouveau des sédiments.",
    waitPickupCradle = "Vous devez attendre avant de ramasser à nouveau le berceau.",
    waitCollectWater = "Vous devez attendre avant de collecter à nouveau de l'eau.",
    waitCollectSediment = "Vous devez attendre avant de collecter à nouveau des sédiments.",
    
    -- UI Labels (for ox_target)
    labelPourWater = "Verser de l'Eau",
    labelPourSediment = "Verser des Sédiments",
    labelPanGold = "Chercher de l'Or",
    labelPickupCradle = "Ramasser le Berceau",
    labelPlace = "Placer",
    labelCancel = "Annuler",
    
    -- Placement UI (on-screen text)
    placementInstructions = "[G] %s | [E] %s | SCROLL Rotation | HAUT/BAS Hauteur",
    
    -- Progress Bar Labels
    progressCollectingWater = "Collecte d'eau",
    progressCollectingSediment = "Collecte de sédiments de rivière...",
    progressBuildingCradle = "Construction du berceau...",
    progressPouringWater = "Verser de l'eau...",
    progressPouringSediment = "Verser des sédiments...",
    progressPickingUpCradle = "Ramasser le berceau...",
    
    -- Gold Rush
    goldRushLocation = "Vous avez trouvé un emplacement de ruée vers l'or!",
    
    -- Restricted Zone
    restrictedZone = "L'orpaillage n'est pas autorisé dans cette eau. Essayez une rivière dans la frontière!",
    
    -- Weather Effects
    weatherAffecting = "Le temps affecte le rendement en or.",
    
    -- Minigame UI
    goldCounter = "Or: ",
    timerSeconds = "s",
    soundToggleTitle = "Activer/Désactiver les Effets Sonores",
}

-- Spanish (Español)
Locales["es"] = {
    -- Water Collection
    noWater = "Debes estar cerca del agua para recolectar.",
    collectingWater = "Recolectando Agua",
    needNearWater = "¡Necesitas estar cerca del agua para recolectar agua!",
    waterCollected = "¡Has llenado tu cubo con agua!",
    noEmptyWaterCan = "¡No tienes un cubo vacío!",
    noEmptyWateringCan = "¡No tienes un cubo vacío!",
    
    -- Sediment Collection
    collectingSediment = "Recolectando sedimento del río...",
    needNearWaterSediment = "¡Necesitas estar cerca del agua para recolectar sedimento!",
    sedimentCollected = "¡Has recolectado %s sedimento del río!",
    noMudBucket = "¡No tienes un cubo de barro!",
    notEnoughInventorySpace = "¡No tienes suficiente espacio en el inventario!",
    
    -- Cradle Placement
    alreadyPlacingCradle = "¡Ya estás colocando una cuna!",
    cradlePlaceNearWater = "¡Debes estar cerca del agua para colocar una cuna!",
    buildingCradle = "Construyendo cuna...",
    cradlePlaced = "¡Cuna colocada exitosamente!",
    placementCancelled = "Colocación cancelada.",
    noCradleNearby = "¡No se encontró ninguna cuna cerca!",
    cannotCarryCradle = "¡No puedes cargar la cuna!",
    cradleLabel = "Cuna de Lavado de Oro",
    
    -- Pouring Water
    pouringWater = "Vertiendo agua...",
    cradleHasWater = "¡La cuna ya tiene agua!",
    needFullBucket = "¡Necesitas un cubo lleno para verter agua!",
    noFullBucketToPour = "¡No tienes un cubo lleno para verter!",
    
    -- Pouring Sediment
    pouringSediment = "Vertiendo sedimento...",
    cradleHasSediment = "¡La cuna ya tiene sedimento!",
    needMoreSediment = "Necesitas más sedimento del río",
    noSedimentToPour = "¡No tienes sedimento del río para verter!",
    sedimentPoured = "¡Has vertido 5 sedimentos del río!",
    need5Sediment = "¡Necesitas 5 sedimentos del río para verter!",
    
    -- Gold Panning
    noGoldPan = "¡No tienes una batea!",
    dontHaveGoldPan = "¡No tienes una batea!",
    goldPanBroke = "¡Tu batea se rompió por el desgaste!",
    cradleBroke = "Tu cuna está demasiado desgastada para volver a usarla.",
    cradleWornOut = "Tu cuna está desgastada. Recógela cuando termines.",
    wateringBucketBroke = "¡Tu cubo de agua se rompió por el desgaste!",
    mudBucketBroke = "¡Tu cubo de barro se rompió por el desgaste!",
    areaDepleted = "Esta área parece agotada. Mejor intenta en otro lugar.",
    actionFailed = "Acción fallida.",
    
    -- Collection Results
    collectedResults = "Has recolectado: ",
    goldFlakes = " escama(s) de oro",
    goldNuggets = " pepita(s) de oro",
    andText = " y ",
    noGoldCollected = "No recolectaste oro esta vez.",
    foundGoldFlake = "¡Encontraste una escama de oro!",
    foundGoldNugget = "¡Encontraste una pepita de oro!",
    
    -- Inventory
    notEnoughSpace = "¡No hay suficiente espacio en el inventario!",
    notEnoughSpaceFlakes = "¡No hay suficiente espacio en el inventario para las escamas!",
    notEnoughSpaceNuggets = "¡No hay suficiente espacio en el inventario para las pepitas!",
    notEnoughSpaceNugget = "¡No hay suficiente espacio para la pepita!",
    
    -- Cradle Pickup
    pickingUpCradle = "Recogiendo cuna...",
    cradlePickedUp = "Cuna recogida.",
    
    -- Cooldown Messages
    waitPourWater = "Debes esperar antes de verter agua nuevamente.",
    waitPourSediment = "Debes esperar antes de verter sedimento nuevamente.",
    waitPickupCradle = "Debes esperar antes de recoger la cuna nuevamente.",
    waitCollectWater = "Debes esperar antes de recolectar agua nuevamente.",
    waitCollectSediment = "Debes esperar antes de recolectar sedimento nuevamente.",
    
    -- UI Labels (for ox_target)
    labelPourWater = "Verter Agua",
    labelPourSediment = "Verter Sedimento",
    labelPanGold = "Buscar Oro",
    labelPickupCradle = "Recoger Cuna",
    labelPlace = "Colocar",
    labelCancel = "Cancelar",
    
    -- Placement UI (on-screen text)
    placementInstructions = "[G] %s | [E] %s | SCROLL Rotar | ARRIBA/ABAJO Altura",
    
    -- Progress Bar Labels
    progressCollectingWater = "Recolectando Agua",
    progressCollectingSediment = "Recolectando sedimento del río...",
    progressBuildingCradle = "Construyendo cuna...",
    progressPouringWater = "Vertiendo agua...",
    progressPouringSediment = "Vertiendo sedimento...",
    progressPickingUpCradle = "Recogiendo cuna...",
    
    -- Gold Rush
    goldRushLocation = "¡Has encontrado una ubicación de fiebre del oro!",
    
    -- Restricted Zone
    restrictedZone = "¡La búsqueda de oro no está permitida en esta agua. ¡Prueba un río en la frontera!",
    
    -- Weather Effects
    weatherAffecting = "El clima está afectando el rendimiento del oro.",
    
    -- Minigame UI
    goldCounter = "Oro: ",
    timerSeconds = "s",
    soundToggleTitle = "Activar/Desactivar Efectos de Sonido",
}

-- ===============================================
-- TEMPLATE FOR YOUR OWN LANGUAGE
-- ===============================================
-- Copy the section below and replace "xx" with your language code (e.g., "fr", "de", "es")
-- Then translate all the text strings to your language
-- Don't forget to set Config.Locale = "xx" at the top of this file!

--[[
Locales["xx"] = {
    -- Water Collection
    noWater = "You must be near water to collect.",
    collectingWater = "Collecting Water",
    needNearWater = "You need to be near water to collect water!",
    waterCollected = "You filled your watering can with water!",
    noEmptyWaterCan = "You don't have an empty watering can!",
    noEmptyWateringCan = "You don't have an empty watering can!",
    
    -- Sediment Collection
    collectingSediment = "Collecting river sediment...",
    needNearWaterSediment = "You need to be near water to collect sediment!",
    sedimentCollected = "You collected %s river sediment!",
    noMudBucket = "You don't have a mud bucket!",
    notEnoughInventorySpace = "You don't have enough inventory space!",
    
    -- Cradle Placement
    alreadyPlacingCradle = "You are already placing a cradle!",
    cradlePlaceNearWater = "You must be near water to place a cradle!",
    buildingCradle = "Building cradle...",
    cradlePlaced = "Cradle placed successfully!",
    placementCancelled = "Placement cancelled.",
    noCradleNearby = "No cradle found nearby!",
    cannotCarryCradle = "You cannot carry the cradle!",
    cradleLabel = "Gold Wash Cradle",
    
    -- Pouring Water
    pouringWater = "Pouring water...",
    cradleHasWater = "The cradle already has water!",
    needFullBucket = "You need a full bucket to pour water!",
    noFullBucketToPour = "You don't have a full bucket to pour!",
    
    -- Pouring Sediment
    pouringSediment = "Pouring sediment...",
    cradleHasSediment = "The cradle already has sediment!",
    needMoreSediment = "You need more river sediment",
    noSedimentToPour = "You don't have river sediment to pour!",
    sedimentPoured = "You poured 5 river sediment!",
    need5Sediment = "You need 5 river sediment to pour!",
    
    -- Gold Panning
    noGoldPan = "You don't have a gold pan!",
    dontHaveGoldPan = "You don't have a gold pan!",
    goldPanBroke = "Your gold pan broke from wear and tear!",
    cradleBroke = "Your cradle is too worn out to use again.",
    cradleWornOut = "Your cradle is worn out. Pick it up when you're done.",
    wateringBucketBroke = "Your watering bucket broke from wear and tear!",
    mudBucketBroke = "Your mud bucket broke from wear and tear!",
    areaDepleted = "This area seems depleted. Best to try elsewhere.",
    actionFailed = "Action failed.",
    
    -- Collection Results
    collectedResults = "You collected: ",
    goldFlakes = " gold flake(s)",
    goldNuggets = " gold nugget(s)",
    andText = " and ",
    noGoldCollected = "You didn't collect any gold this time.",
    foundGoldFlake = "You found a gold flake!",
    foundGoldNugget = "You found a gold nugget!",
    
    -- Inventory
    notEnoughSpace = "Not enough inventory space!",
    notEnoughSpaceFlakes = "Not enough inventory space for the flakes!",
    notEnoughSpaceNuggets = "Not enough inventory space for the nuggets!",
    notEnoughSpaceNugget = "Not enough space for the nugget!",
    
    -- Cradle Pickup
    pickingUpCradle = "Picking up cradle...",
    cradlePickedUp = "Cradle picked up.",
    
    -- Cooldown Messages
    waitPourWater = "You must wait before pouring water again.",
    waitPourSediment = "You must wait before pouring sediment again.",
    waitPickupCradle = "You must wait before picking up the cradle again.",
    waitCollectWater = "You must wait before collecting water again.",
    waitCollectSediment = "You must wait before collecting sediment again.",
    
    -- UI Labels (for ox_target)
    labelPourWater = "Pour Water",
    labelPourSediment = "Pour Sediment",
    labelPanGold = "Pan for Gold",
    labelPickupCradle = "Pick Up Cradle",
    labelPlace = "Place",
    labelCancel = "Cancel",
    
    -- Placement UI (on-screen text)
    placementInstructions = "[G] %s | [E] %s | SCROLL Rotate | UP/DOWN Height",

    -- Progress Bar Labels
    progressCollectingWater = "Collecting Water",
    progressCollectingSediment = "Collecting river sediment...",
    progressBuildingCradle = "Building cradle...",
    progressPouringWater = "Pouring water...",
    progressPouringSediment = "Pouring sediment...",
    progressPickingUpCradle = "Picking up cradle...",
    
    -- Gold Rush
    goldRushLocation = "You've found a gold rush location!",
    
    -- Weather Effects
    weatherAffecting = "The weather is affecting gold yields.",
    
    -- Minigame UI
    goldCounter = "Gold: ",
    timerSeconds = "s",
    soundToggleTitle = "Toggle Sound Effects",
}
]]--

-- ===============================================
-- TRANSLATION FUNCTION
-- ===============================================
function _U(str, ...)
    local locale = Config.Locale or "en"
    local text = Locales[locale] and Locales[locale][str] or Locales["en"][str] or str
    if ... then
        return string.format(text, ...)
    end
    return text
end
