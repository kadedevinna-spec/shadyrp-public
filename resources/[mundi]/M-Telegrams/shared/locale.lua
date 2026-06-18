-- ═══════════════════════════════════════════════════════════════
-- M-TELEGRAMS — LOCALE FILE
-- ═══════════════════════════════════════════════════════════════
--
-- Edit or duplicate this file to translate all in-game strings.
-- To add a new language:
--   1. Copy the Locales["en"] block below
--   2. Rename it (e.g. Locales["fr"], Locales["de"])
--   3. Translate each value (keep the keys the same)
--   4. Set Config.Locale = "fr" in config.lua
-- ═══════════════════════════════════════════════════════════════

Locales = {}

Locales["en"] = {
    -- General
    telegramOffice = "Telegram Office",
    pressToOpen = "Press to open",
    
    -- Registration
    notRegistered = "You are not registered at a Telegram Office. Registration costs $%s.",
    registrationSuccess = "Welcome! You have been registered successfully. Your Telegram ID is: %s",
    notEnoughMoneyRegister = "You don't have enough money to complete the registration.",
    alreadyRegistered = "You are already registered. Your Telegram ID is: %s",
    
    -- Sending
    telegramSent = "Your telegram has been sent successfully!",
    telegramSentCost = "Your telegram has been sent. Postage cost: $%s.",
    notEnoughMoneySend = "You don't have enough money to send this telegram.",
    recipientNotFound = "The recipient Telegram ID does not exist. Please check the number and try again.",
    invalidRecipient = "Invalid recipient Telegram ID. Please enter a valid number.",
    invalidSubject = "Please enter a subject for your telegram.",
    invalidMessage = "Please write a message before sending.",
    cannotSendToSelf = "You cannot send a telegram to yourself.",
    noStampSelected = "Please select a stamp before sending.",
    
    -- Receiving
    newTelegram = "A new telegram has arrived for you!",
    unreadTelegrams = "You have %s unread telegram(s) waiting at the office.",
    telegramDeleted = "Telegram has been deleted.",
    
    -- Contacts
    contactAdded = "Contact has been added to your address book.",
    contactRemoved = "Contact has been removed from your address book.",
    contactExists = "This contact is already in your address book.",
    invalidContactInfo = "Invalid contact information. Please check and try again.",
    
    -- Items
    telegramPaperReceived = "You received a telegram paper.",
    telegramTorn = "You tore the telegram.",
    
    -- Bulk
    bulkSent = "Bulk telegram has been sent to all registered users.",
    bulkNotPermitted = "You don't have permission to send bulk telegrams.",
    
    -- Company
    companySent = "Telegram sent from %s.",
    noCompanyAccess = "You don't have access to this company's telegrams.",
    
    -- Checker
    checkerNoPermission = "You don't have permission to use the checker station.",
    checkerResults = "Showing telegrams for ID: %s",
    
    -- Admin
    adminUsage = "Usage: /%s <player_id>",
    adminNumberUsage = "Usage: /%s <player_id> <new_number>",
    adminNumberChanged = "Telegram number changed to %s for player %s.",
    playerNotFound = "Player not found.",
    noPermission = "You don't have permission to do this.",
    
    -- Station
    stationClosed = "This station is currently closed.",
    jobLocked = "This station is restricted to authorized personnel.",
    
    -- Anonymous
    anonymousSender = "Unknown",
    anonymousTelegramId = "XXXXXX",
    
    -- NUI Labels
    nui_inbox = "INBOX",
    nui_sent = "SENT",
    nui_compose = "COMPOSE",
    nui_contacts = "CONTACTS",
    nui_company = "COMPANY",
    nui_register = "REGISTER",
    nui_close = "CLOSE",
    nui_send = "SEND",
    nui_reply = "REPLY",
    nui_delete = "DELETE",
    nui_back = "BACK",
    nui_stampSelect = "SELECT STAMP",
    nui_recipient = "RECIPIENT",
    nui_subject = "SUBJECT",
    nui_message = "MESSAGE",
    nui_anonymous = "Send anonymously?",
    nui_addContact = "ADD CONTACT",
    nui_contactName = "CONTACT NAME",
    nui_telegramId = "TELEGRAM ID",
    nui_yourId = "Your ID",
    nui_from = "FROM",
    nui_to = "TO",
    nui_date = "DATE",
    nui_city = "CITY",
    nui_unread = "UNREAD",
    nui_read = "READ",
    nui_all = "ALL",
    nui_noTelegrams = "No telegrams to display.",
    nui_noContacts = "No contacts in your address book.",
    nui_checker = "CHECKER",
    nui_checkerLookup = "LOOKUP ID",
    nui_drawMode = "Draw",
    nui_textMode = "Text",
    nui_addImage = "Add Image",
    nui_imageUrl = "Image URL",
    nui_cancel = "CANCEL",
    nui_confirm = "CONFIRM",
    nui_page = "Page",
    nui_of = "of",
    nui_registrationTitle = "TELEGRAM OFFICE REGISTRATION",
    nui_registrationText = "By signing, I agree to the terms set forth by the United States Postal Service. I acknowledge that suspicious transmissions may be subject to investigation by state authorities.",
    nui_registrationCost = "Registration Cost: $%s",
    nui_acceptPay = "ACCEPT & PAY",
    nui_stampCost = "Stamp: $%s",
    nui_sendCost = "Sending: $%s",
    nui_totalCost = "Total: $%s",

    -- Custom Telegram ID
    customIdPrompt = "Choose your Telegram ID (3-5 characters, letters/numbers):",
    customIdTaken = "That Telegram ID is already taken. Try another.",
    customIdInvalid = "Invalid ID. Use only letters and numbers, %s-%s characters.",
    customIdBlocked = "That ID contains a blocked word.",
    customIdCost = "Custom ID costs an additional $%s.",
    vipIdAssigned = "Your reserved VIP Telegram ID has been assigned: %s",

    -- Archive
    telegramArchived = "Telegram archived.",
    telegramUnarchived = "Telegram restored to inbox.",
    nui_archive = "ARCHIVE",
    nui_archived = "ARCHIVED",
    nui_unarchive = "RESTORE",

    -- Telegram Book
    bookEntrySaved = "Saved to your telegram book.",
    bookEntryRemoved = "Removed from your telegram book.",
    bookFull = "Your telegram book is full (%s entries max).",
    bookEntryExists = "That telegram ID is already in your book.",
    nui_book = "BOOK",
    nui_addBookEntry = "SAVE TO BOOK",
    nui_bookName = "NAME",
    nui_bookTelegramId = "TELEGRAM ID",
    nui_noBookEntries = "Your telegram book is empty.",

    -- Public Directory
    directoryListed = "Your telegram has been listed in the public directory.",
    directoryUnlisted = "Your telegram has been removed from the public directory.",
    directoryAlreadyListed = "You are already listed in the directory.",
    directoryNotListed = "You are not listed in the directory.",
    nui_directory = "DIRECTORY",
    nui_directoryList = "LIST MY TELEGRAM",
    nui_directoryRemove = "REMOVE LISTING",
    nui_directorySearch = "Search directory...",
    nui_directoryCategory = "CATEGORY",

    -- Extract Telegram as Item
    telegramExtracted = "Telegram saved to your pocket.",
    telegramCopied = "Copy of telegram saved to your pocket.",
    extractNotEnabled = "Extracting telegrams is not enabled.",
    nui_extractTelegram = "TAKE OUT",
    nui_copyTelegram = "COPY",

    -- Inbox Cap
    inboxCapWarning = "Your inbox has %s telegrams. The limit is %s — oldest messages will be removed.",
    inboxCapReached = "Inbox limit reached. Your oldest telegrams have been removed to make space.",

    -- Company Members
    companyMemberAdded = "Added %s to company telegram access.",
    companyMemberRemoved = "Removed %s from company telegram access.",
    companyMemberExists = "That person already has access.",
    companyNotOwner = "You must be an owner/boss to manage company members.",
    nui_companyMembers = "MEMBERS",
    nui_addMember = "ADD MEMBER",
    nui_removeMember = "REMOVE",

    -- Sent Tab
    nui_sentTab = "SENT",
    nui_noSentTelegrams = "No sent telegrams to display.",

    -- ─── Notification Titles ───
    notifTitleError    = "Telegram Office",
    notifTitleSuccess  = "Telegram Office",
    notifTitleWarning  = "Telegram Office",
    notifTitleDefault  = "Telegram Office",

    -- ─── Notification Messages ───
    -- Receive / Login
    notifNewTelegramTitle     = "New Telegram Received",
    notifNewTelegramMessage   = "You received a telegram from %s",
    notifNewTelegramFallback  = "A new telegram has arrived for you.",
    notifUnreadTitle          = "Unread Telegrams",
    notifUnreadMessage        = "You have %d unread telegram(s) waiting at the office.",
    notifTelegramOfficeSender = "Telegram Office",

    -- Announcements
    announcementFallback = "Announcement",

    -- Unregister
    unregisterSuccess = "Your telegram service has been cancelled. Your number %s is now available.",

    -- ─── Parcel System ───
    parcelSent              = "Parcel sent! The recipient will be notified when they visit the office.",
    parcelSentFee           = "Parcel sent. Postage fee: $%s.",
    parcelCollected         = "You have collected your parcel.",
    parcelRejected          = "Parcel rejected — items returned to sender.",
    parcelReturned          = "A parcel was returned to you because it was not collected.",
    parcelsReturnedOnLogin  = "%s returned parcel(s) have been added back to your inventory.",
    parcelNotFound          = "Parcel not found or already collected.",
    parcelNotAllowed        = "You are not authorised to use the parcel system.",
    parcelNoMoney           = "You do not have enough money to send this parcel.",
    parcelInboxFull         = "The recipient's parcel inbox is full. Try again later.",
    parcelBlockedItem       = "One or more items in your parcel are not allowed.",
    parcelNoItems           = "You have not selected any items to include in the parcel.",
    parcelTooHeavy          = "Your parcel exceeds the maximum allowed weight of %s.",
    parcelTooManyItems      = "You can only include up to %s items per parcel.",
    parcelNewArrived        = "A parcel has arrived for you at the Telegram Office.",
    parcelsPendingOnLogin   = "You have %s uncollected parcel(s) waiting at the Telegram Office.",
    parcelWrongStation      = "This parcel must be collected at the %s Telegram Office.",
    nui_parcels             = "PARCELS",
    nui_parcelSend          = "SEND PARCEL",
    nui_parcelInbox         = "INCOMING",
    nui_parcelSent          = "SENT",
    nui_parcelStatus        = "STATUS",
    nui_parcelItems         = "ITEMS",
    nui_parcelWeight        = "WEIGHT",
    nui_parcelCost          = "COST",
    nui_parcelCollect       = "COLLECT",
    nui_parcelReturn        = "RETURN",
    nui_parcelPending       = "Awaiting Collection",
    nui_parcelCollectedLbl  = "Collected",
    nui_parcelReturnedLbl   = "Returned",
    nui_noParcels           = "No parcels to display.",
    nui_parcelNote          = "Include a note with the parcel (optional)",
    nui_parcelItems_header  = "Items to send:",
    nui_parcelRecipient     = "Recipient Telegram ID",

    -- ─── Carrier Bird System ───
    birdPurchased           = "You purchased a new bird: %s! Name it wisely.",
    birdNamed               = "Your bird has been named '%s'.",
    birdFed                 = "You fed your bird. Hunger restored by %s.",
    birdHealed              = "Your bird's health has been restored by %s.",
    birdTrained             = "Training session complete! Your bird gained %s XP.",
    birdLevelUp             = "Your bird '%s' levelled up to level %s!",
    birdDied                = "Your bird '%s' has died from neglect.",
    birdAlreadyFlying       = "Your bird is currently in flight and cannot be used.",
    birdResting             = "Your bird is resting and will be ready in %s minutes.",
    birdNoHealth            = "Your bird is too ill to fly. Use medicine to restore its health.",
    birdDead                = "Your bird is dead. You will need to purchase a new one.",
    birdTelegramSent        = "Your telegram has been entrusted to your bird. Estimated arrival: %s minutes.",
    birdDelivered           = "Your bird '%s' has delivered a telegram to %s station.",
    birdRecipientNotified   = "A telegram arrived via carrier bird from %s.",
    birdMaxOwned            = "You already own the maximum number of birds (%s).",
    birdNoMoney             = "You don't have enough money to purchase this bird.",
    birdNameTooLong         = "Bird name is too long (max 20 characters).",
    birdNotFound            = "Bird not found.",
    birdItemNotFound        = "You don't have the required item: %s.",
    birdTrainCooldown       = "This training item was recently used. Try again in %s minutes.",
    birdsDisabled           = "The carrier bird system is not available here.",
    birdReleased            = "You have released your bird. It flies away into the wild.",
    nui_birds               = "BIRDS",
    nui_myBirds             = "MY BIRDS",
    nui_buyBird             = "BUY A BIRD",
    nui_birdName            = "Name Your Bird",
    nui_birdBreed           = "Breed",
    nui_birdLevel           = "Level",
    nui_birdHealth          = "Health",
    nui_birdHunger          = "Hunger",
    nui_birdLoyalty         = "Loyalty",
    nui_birdSpeed           = "Speed",
    nui_birdStamina         = "Stamina",
    nui_birdStatus          = "Status",
    nui_birdXP              = "XP",
    nui_birdDeliveries      = "Deliveries",
    nui_birdFeed            = "Feed",
    nui_birdHeal            = "Heal",
    nui_birdTrain           = "Train",
    nui_birdRelease         = "Release",
    nui_birdSendTelegram    = "Send via Bird",
    nui_birdFlightEta       = "Flight ETA",
    nui_birdRestingUntil    = "Resting until",
    nui_birdPurchaseCost    = "Cost: $%s",
    nui_birdSelectTrain     = "Select training item:",
    nui_birdSelectCare      = "Select care item:",
    nui_birdConfirmRelease  = "Release this bird? This cannot be undone.",
    nui_birdNoBirds         = "You don't own any birds yet. Visit the office to buy one.",
    nui_birdFlightInfo      = "Nearest station: %s — ETA: %s sec",

    -- ─── Carrier Bird Training ───
    birdTraining            = "Your bird is in training. Ready in %s minutes.",
    nui_birdTraining        = "In Training",
    nui_birdTrainingBanner  = "Training — ready in ~%s",
    nui_birdInFlight        = "In flight — arrives in ~%s",
    nui_birdResting         = "Resting — ready in ~%s",
    nui_birdSendBtn         = "Send",
    nui_birdCareBtn         = "Care",
    nui_birdTrainBtn        = "Train",
    nui_birdRenameBtn       = "Rename",
    nui_birdReleaseBtn      = "Release",
    nui_birdDeliveriesLabel = "Deliveries:",
    nui_birdLevelLabel      = "Lvl %s",
    nui_birdBuyTitle        = "Purchase Carrier Bird",
    nui_birdBuyDesc         = "You are purchasing a %s. Enter a name for your new bird.",
    nui_birdBuyConfirm      = "Purchase",
    nui_birdCareTitle       = "Care for Bird",
    nui_birdCareDesc        = "Use an item to restore your bird's health or hunger.",
    nui_birdTrainTitle      = "Train Bird",
    nui_birdTrainDesc       = "Use an item to improve your bird's stats. The bird will enter training for a period.",
    nui_birdReleaseTitle    = "Release Bird?",
    nui_birdReleaseDesc     = "Are you sure you want to release %s? This cannot be undone.",
    nui_birdReleaseAsk      = "Are you sure you want to release",
    nui_birdCannotUndo      = "This cannot be undone.",
    nui_birdSendTitle       = "Send via Carrier Bird",
    nui_birdSendDesc        = "Select which bird to dispatch with your telegram.",
    nui_birdSendConfirm     = "Dispatch Bird",
    nui_birdNoEligible      = "No birds available. Bird must be healthy and not busy.",
    nui_birdShopMaxNote     = "You already own the maximum number of birds (%s).",
    nui_birdShopEmpty       = "No breeds available.",
    nui_birdNoCooldownItems = "No eligible items in inventory.",

    -- Paper item
    telegramPaperBlank = "This telegram paper is blank.",

    -- NUI reset
    nuiReset = "Telegram interface has been reset.",

    -- ─── Admin Notifications ───
    adminPlayerNotRegistered  = "Player %s %s is not registered at a Telegram Office.",
    adminInvalidPlayerId      = "Invalid player ID. Please provide a valid number.",
    adminPlayerNotFoundOnline = "Player not found or is not currently online.",
    adminIdAlreadyInUse       = "Telegram ID %s is already in use. Choose another.",
    adminNumberChangedTarget  = "Your Telegram ID has been changed to: %s",
    adminForceUnregistered    = "Unregistered %s %s (Telegram ID: %s). Their number is now available.",
    adminCancelledService     = "Your telegram service has been cancelled by an administrator.",
    adminUnregisterUsage      = "Usage: /%s <player_id>",
    yourTelegramId            = "Your Telegram ID: %s",
    notRegisteredSimple       = "You are not registered at a Telegram Office.",
    mustRegisterAtOffice      = "You must register at a Telegram Office before sending telegrams.",

    -- Cooldowns & Fees
    cooldownRegister          = "You must wait %s minute(s) before re-registering.",
    cooldownUnregister        = "You must wait %s minute(s) before unregistering again.",
    outstandingFeesPaid       = "Outstanding fees of $%.2f have been paid.",

    -- Client errors
    birdModelFailed           = "Failed to load bird model.",
    birdTimedOut              = "Timed out — the bird flew away.",
    birdTestComplete          = "Test complete! Bird flying away.",
    closeNuiFirst             = "Close the telegram NUI first.",
    failedLoadStation         = "Failed to load station data.",

    -- ═══════════════════════════════════════════════════════════════
    -- NUI STRINGS — All text shown inside the NUI interface
    -- These are sent to the browser and used by JavaScript.
    -- Translate these so your players see the UI in their language.
    -- ═══════════════════════════════════════════════════════════════

    -- ─── NUI: Tab Labels ───
    nui_tabClose              = "Close",
    nui_tabInbox              = "Inbox",
    nui_tabSent               = "Sent",
    nui_tabCompose            = "Compose",
    nui_tabContacts           = "Contacts",
    nui_tabArchive            = "Archive",
    nui_tabDirectory          = "Directory",
    nui_tabCompany            = "Company",
    nui_tabBusiness           = "Business",
    nui_tabChecker            = "Checker",
    nui_tabParcels            = "Parcels",
    nui_tabBirds              = "Birds",

    -- ─── NUI: Reader Overlay ───
    nui_readerTo              = "TO",
    nui_readerFrom            = "FROM",
    nui_readerUnknown         = "Unknown",
    nui_readerBanner          = "TELEGRAM",
    nui_readerSubject         = "Subject",
    nui_readerBackToList      = "Back to list",
    nui_readerAnonymous       = "Anonymous",
    nui_readerNoSubject       = "No Subject",

    -- ─── NUI: Reader Action Buttons ───
    nui_btnReply              = "Reply",
    nui_btnArchive            = "Archive",
    nui_btnRestore            = "Restore",
    nui_btnTakeOut            = "Take Out",
    nui_btnSaveToPaper        = "Save to Paper",
    nui_btnDelete             = "Delete",

    -- ─── NUI: Inbox / Sent ───
    nui_inboxHeader           = "Inbox",
    nui_sentHeader            = "Sent",
    nui_inboxEmpty            = "No dispatches on record.",
    nui_sentEmpty             = "No telegrams transmitted.",
    nui_colTitle              = "Title",
    nui_colSender             = "Sender",
    nui_colRecipient          = "Recipient",
    nui_colTimestamp           = "Timestamp",
    nui_selectAll             = "Select all",
    nui_personal              = "Personal",

    -- ─── NUI: Compose ───
    nui_composeHeader         = "Compose Telegram",
    nui_sendingAs             = "Sending as:",
    nui_sendAsLabel           = "Send As",
    nui_myPersonalTelegram    = "My Personal Telegram",
    nui_recipientLabel        = "Recipient ID",
    nui_recipientPlaceholder  = "e.g. CN-4829",
    nui_recipientPlaceholderBulk = "e.g. CN-4829 or -1 for all",
    nui_pickContact           = "Pick from contacts",
    nui_subjectLabel          = "Subject",
    nui_subjectPlaceholder    = "Subject of your telegram...",
    nui_stampLabel             = "Stamp",
    nui_stampNone             = "None",
    nui_stampSignature        = "My Signature",
    nui_toolText              = "Text",
    nui_toolDraw              = "Draw",
    nui_toolEraser            = "Eraser",
    nui_fontLabel             = "Font",
    nui_addImageBtn           = "Add Image",
    nui_sendTelegram          = "Send Telegram",
    nui_attachToBird          = "Attach to Bird",
    nui_anonymousLabel        = "Anonymous",
    nui_signLabel             = "Sign",
    nui_costPrefix            = "Cost: $%s",

    -- ─── NUI: Compose — Outstanding Fees ───
    nui_outstandingFeesBanner = "You have outstanding postal fees of",
    nui_payNow                = "Pay Now",

    -- ─── NUI: Contacts ───
    nui_addressBook           = "Address Book",
    nui_contactNamePh         = "Contact Name",
    nui_contactIdPh           = "Telegram ID",
    nui_contactNotesPh        = "Notes (optional)",
    nui_contactRecord         = "Record",
    nui_contactsEmpty         = "Your address book lies empty.",
    nui_contactCompose        = "Compose",
    nui_contactEdit           = "Edit",
    nui_contactRemove         = "Remove",
    nui_contactDisplayNamePh  = "Display name",
    nui_contactEditNotesPh    = "Notes (optional)",
    nui_contactNameEmpty      = "Name cannot be empty.",
    nui_contactAddValidation  = "Please enter both a name and telegram ID.",
    nui_contactPickerNoSaved  = "No contacts saved",
    nui_contactPickerNoMatch  = "No matches",
    nui_contactSearchPh       = "Search contacts...",
    nui_contactPickerEmpty    = "No contacts found",

    -- ─── NUI: Company ───
    nui_companyHeader         = "Company Telegrams",
    nui_selectCompany         = "-- Select Company --",
    nui_membersBtn            = "Members",
    nui_companyMembersHeader  = "Company Members",
    nui_memberIdPh            = "Telegram ID",
    nui_memberAdd             = "Add",
    nui_companyEmpty          = "No company dispatches on record.",

    -- ─── NUI: Business ───
    nui_businessHeader        = "My Businesses",
    nui_businessCreate        = "Create",
    nui_businessNameLabel     = "Business Name",
    nui_businessNamePh        = "e.g. Valentine General Store",
    nui_businessDescLabel     = "Description",
    nui_businessDescPh        = "Brief description (optional)",
    nui_businessCostLabel     = "Cost: $%s",
    nui_businessConfirm       = "Confirm",
    nui_businessCancelBtn     = "Cancel",
    nui_selectBusiness        = "-- Select Business --",
    nui_employeesBtn          = "Employees",
    nui_businessComposeBtn    = "Compose",
    nui_employeesHeader       = "Employees",
    nui_permRead              = "Read",
    nui_permSend              = "Send",
    nui_bizMemberOwner        = "Owner",
    nui_bizMemberEmployee     = "Employee",

    -- ─── NUI: Archive ───
    nui_archiveHeader         = "Archived Telegrams",
    nui_archiveInbox          = "Inbox",
    nui_archiveSent           = "Sent",
    nui_archiveEmpty          = "The archive holds nothing.",

    -- ─── NUI: Directory ───
    nui_directoryHeader       = "Public Directory",
    nui_allCategories         = "All Categories",
    nui_directorySearchPh     = "Search by name or ID...",
    nui_directoryEmpty        = "No public listings have been filed.",
    nui_directoryNoListings   = "No listings in the directory.",
    nui_directoryCompose      = "Compose telegram",
    nui_directoryAddContact   = "Add to contacts",
    nui_directoryListed       = "You are listed in the directory",
    nui_directoryUnlistBtn    = "Unlist",
    nui_directoryNotListed    = "Not listed",
    nui_directoryDiscoverable = "Make yourself discoverable",
    nui_directoryListBtn      = "List Yourself",
    nui_directoryBizListed    = "Business — listed in directory",
    nui_directoryBizNotListed = "Business — not listed",
    nui_directoryListBizBtn   = "List Business",
    nui_directoryEnterName    = "Enter a display name",
    nui_directoryListTitle    = "List in Public Directory",
    nui_directoryListModalTitle = "List in Public Directory",
    nui_directoryListModalDesc = "Make your telegram ID visible to others.",
    nui_directoryDisplayNamePh = "Your display name",
    nui_directoryDescPh       = "Brief description...",
    nui_directoryCategoryLabel = "Category",
    nui_directoryCategoryPh   = "Select category...",
    nui_directoryListConfirm  = "List",

    -- ─── NUI: Checker ───
    nui_checkerHeader         = "Telegram Checker",
    nui_checkerIdPh           = "Enter Telegram ID to look up",
    nui_checkerLookUpBtn      = "Look Up",
    nui_checkerEmpty          = "Enter an identification number to search for dispatches.",

    -- ─── NUI: Registration ───
    nui_regTelegramOffice     = "TELEGRAM OFFICE",
    nui_regFormTitle          = "Registration Form",
    nui_regLegalText          = "By signing below, I agree to the terms set forth by the United States Postal Service. I acknowledge that suspicious transmissions may be subject to investigation by state authorities.",
    nui_regFirstName          = "First Name",
    nui_regLastName           = "Last Name",
    nui_regFirstNamePh        = "Your first name",
    nui_regLastNamePh         = "Your last name",
    nui_regYourNumber         = "Your Telegram Number",
    nui_regAssignedNumber     = "Your Assigned Telegram Number",
    nui_regCustomLabel        = "Custom",
    nui_regCustomExtraCost    = "(+$%s)",
    nui_regCustomIdPh         = "Enter %s-%s %s",
    nui_regAlphanumeric       = "alphanumeric characters",
    nui_regLettersOnly        = "letters only (A-Z)",
    nui_regNumbersOnly        = "numbers only (0-9)",
    nui_regChecking           = "Checking...",
    nui_regAvailable          = "✓ Available",
    nui_regTaken              = "✗ Already taken",
    nui_regBlocked            = "✗ Blocked word",
    nui_regNotAllowed         = "✗ Not allowed",
    nui_regVipReserved        = "VIP reserved:",
    nui_regProfilePicLabel    = "Profile Picture",
    nui_regProfilePicPh       = "https://example.com/photo.jpg",
    nui_regProfilePicHint     = "Optional — provide a portrait of yourself",
    nui_regFee                = "Registration fee: $%s",
    nui_regSignature          = "Signature",
    nui_regAcceptPay          = "ACCEPT & PAY",

    -- ─── NUI: Bulk Actions ───
    nui_bulkSelected          = "selected",
    nui_bulkDelete            = "Delete",
    nui_bulkArchive           = "Archive",
    nui_bulkRestore           = "Restore",
    nui_bulkDeleteTip         = "Delete selected",
    nui_bulkArchiveTip        = "Archive selected",
    nui_bulkRestoreTip        = "Restore selected",
    nui_bulkDeselectTip       = "Deselect all",

    -- ─── NUI: Image Modal ───
    nui_imageModalTitle       = "Add Image",
    nui_imageModalDesc        = "Paste an image URL to embed in your telegram.\nDrag to move, scroll to rotate, Shift+scroll to resize.",
    nui_imageModalPh          = "https://example.com/image.png",
    nui_imageModalAdd         = "Add",
    nui_imageModalCancel      = "Cancel",

    -- ─── NUI: Profile Picture Modal ───
    nui_ppTitle               = "Portrait Photograph",
    nui_ppDesc                = "Furnish an image address for your personal portrait.\nThis photograph shall accompany your telegram identification.",
    nui_ppLabel               = "Image Address",
    nui_ppPlaceholder         = "https://example.com/portrait.jpg",
    nui_ppConfirm             = "Confirm",
    nui_ppDismiss             = "Dismiss",

    -- ─── NUI: Signature & Seal Modal ───
    nui_sigTitle              = "Signature & Seal",
    nui_sigDesc               = "Update your personal signature or custom stamp seal.",
    nui_sigYourSig            = "Your Signature",
    nui_sigHint               = "Draw your signature above — used as a personal stamp on telegrams",
    nui_sigCustomStamp        = "Custom Stamp Image",
    nui_sigStampPh            = "https://example.com/my-seal.png",
    nui_sigStampHint          = "Optional — provide your own seal or emblem image URL",
    nui_sigSave               = "Save",

    -- ─── NUI: Unregister Modal ───
    nui_unregTitle            = "Cancel Telegram Service",
    nui_unregDesc             = "This action will permanently cancel your telegram service and free your assigned number. You will lose access to your inbox and contacts.",
    nui_unregYourNumber       = "Your Number:",
    nui_unregRefund           = "Refund:",
    nui_unregWarning          = "This cannot be undone.",
    nui_unregConfirm          = "Confirm Cancellation",
    nui_unregKeep             = "Keep Service",
    nui_sigSettingsTitle      = "Signature & Seal",
    nui_cancelService         = "Cancel Service",

    -- ─── NUI: Bird Side Panel (compose from item) ───
    nui_birdSelectBird        = "Select Bird",
    nui_birdSidePanelEmpty    = "No birds available. You need a healthy bird to send.",
    nui_birdUnnamed           = "Unnamed Bird",
    nui_birdStatusHealthy     = "Healthy",
    nui_birdStatusHungry      = "Hungry",
    nui_birdStatusSick        = "Sick",
    nui_birdStatusResting     = "Resting",
    nui_birdStatusInFlight    = "In Flight",
    nui_birdStatusInTraining  = "In Training",
    nui_birdStatusDeceased    = "Deceased",

    -- ─── NUI: Bird Activity Text ───
    nui_birdActArriving       = "Arriving at destination...",
    nui_birdActDelivering     = "Delivering — ETA %s",
    nui_birdActWaking         = "Waking up...",
    nui_birdActRestingTime    = "Resting — %s left",
    nui_birdActFinishTrain    = "Finishing training...",
    nui_birdActTrainingTime   = "Training — %s left",
    nui_birdActSick           = "Needs medical attention",
    nui_birdActStarving       = "Starving — feed immediately!",
    nui_birdActHungry         = "Getting hungry…",
    nui_birdActDead           = "This bird has passed away",
    nui_birdActDeadReason     = "Passed away — %s",
    nui_birdActContentReady   = "Content and ready",
    nui_birdActSlightlyPeckish = "Ready, slightly peckish",
    nui_birdActAvailable      = "Available for duty",

    -- ─── NUI: Bird Card Labels ───
    nui_birdStatHealth        = "Health",
    nui_birdStatHunger        = "Hunger",
    nui_birdStatSpeed         = "Speed",
    nui_birdStatStamina       = "Stamina",
    nui_birdStatXP            = "XP",
    nui_birdStatLoyalty       = "Loyalty",
    nui_birdLvl               = "Lvl",
    nui_birdLevel             = "Level",
    nui_birdDispose           = "Dispose",
    nui_birdSellDisabledTip   = "Bird is too weak to sell (health too low)",
    nui_birdEmptyState        = "You don't own any carrier birds yet.",
    nui_birdAllBirds          = "All Birds",
    nui_birdBackToBird        = "Back to Bird",

    -- ─── NUI: Bird Action Panel Labels ───
    nui_birdCarePanelTitle    = "Care for Bird",
    nui_birdTrainPanelTitle   = "Train Bird",
    nui_birdRenamePanelTitle  = "Rename Bird",
    nui_birdRenamePh          = "New name...",
    nui_birdRenameConfirm     = "Rename",
    nui_birdReleasePanelTitle = "Release Bird?",
    nui_birdReleaseDesc       = "Are you sure you want to release %s? This cannot be undone.",
    nui_birdReleaseAsk        = "Are you sure you want to release",
    nui_birdCannotUndo        = "This cannot be undone.",
    nui_birdReleaseConfirm    = "Release",
    nui_birdKeep              = "Keep Bird",
    nui_birdSellPanelTitle    = "Sell Bird?",
    nui_birdSellDesc          = "Sell %s back to the shop?",
    nui_birdSellConfirm       = "Sell",
    nui_birdDisposePanelTitle = "Dispose of Bird",
    nui_birdDisposeDesc       = "This bird has passed away. Would you like to dispose of the remains?",
    nui_birdDisposeConfirm    = "Dispose",
    nui_birdRefund            = "Refund: $%s",

    -- ─── NUI: Bird Buy Panel ───
    nui_birdShopRefreshing    = "Refreshing soon...",
    nui_birdShopNextBirds     = "Next birds available in",
    nui_birdShopNoStock       = "No birds available right now. Check back soon!",
    nui_birdShopBuyBtn        = "Buy",
    nui_birdBuyBillOfSale     = "Bill of Sale",
    nui_birdBuyConfirmDesc    = "Confirm your purchase below.",
    nui_birdBuyTotalDue       = "Total Due: $%s",
    nui_birdBuyConfirmBtn     = "Confirm Purchase",
    nui_birdBuyDecline        = "Decline",

    -- ─── NUI: Bird Name Modal ───
    nui_birdNameTitle         = "Name Your Bird",
    nui_birdNameDesc          = "What will you call your new companion?",
    nui_birdNamePh            = "e.g. Dusty, Quickwing...",
    nui_birdNameSave          = "Save Name",
    nui_birdNameSkip          = "Skip",

    -- ─── NUI: Bird Care/Train Modal ───
    nui_birdCareModalTitle    = "Bird Care",
    nui_birdCareModalDesc     = "Choose an item to use on your bird.",

    -- ─── NUI: Bird Rename Modal ───
    nui_birdRenameModalTitle  = "Rename Bird",

    -- ─── NUI: Bird Release Modal ───
    nui_birdReleaseModalTitle = "Release Bird?",

    -- ─── NUI: Bird Sell Modal ───
    nui_birdSellModalTitle    = "Sell Bird?",
    nui_birdSellModalKeep     = "Keep Bird",

    -- ─── NUI: Bird Dispose Modal ───
    nui_birdDisposeModalTitle = "Lay to Rest",
    nui_birdDisposeModalDesc  = "Dispose of %s's remains? This cannot be undone.",

    -- ─── NUI: Bird Send Modal ───
    nui_birdSendHeader        = "Carrier Bird Dispatch",
    nui_birdSendDesc2         = "Choose a bird to deliver your telegram.",
    nui_birdSendFlightInfo    = "Nearest station: %s — ETA: %s sec",
    nui_birdSendDispatch      = "Dispatch Bird",
    nui_birdSendNoEligible    = "No available birds. Ensure your bird is healthy and not busy.",

    -- ─── NUI: Bird Banner Text ───
    nui_birdBannerFlight      = "In flight — arrives in ~%s",
    nui_birdBannerRest        = "Resting — ready in ~%s",
    nui_birdBannerTrain       = "Training — ready in ~%s",
    nui_birdBannerMoments     = "moments",

    -- ─── NUI: Parcels ───
    nui_parcelsHeader         = "Parcels",
    nui_parcelIncoming        = "Incoming",
    nui_parcelSentSub         = "Sent",
    nui_parcelSendSub         = "Send Parcel",
    nui_parcelInboxEmpty      = "No parcels await your claim.",
    nui_parcelSentEmpty       = "No parcels have been dispatched.",
    nui_parcelRecipientLabel  = "Recipient Telegram ID",
    nui_parcelRecipientPh     = "e.g. VAL-4829",
    nui_parcelNoteLabel       = "Note",
    nui_parcelOptional        = "(optional)",
    nui_parcelNotePh          = "Attach a short note to your parcel...",
    nui_parcelItemsLabel      = "Items to Send",
    nui_parcelOpenSaddlebag   = "Open Saddlebag",
    nui_parcelSelectItems     = "Select goods from your saddlebag above.",
    nui_parcelDispatch        = "Dispatch Parcel",
    nui_parcelSearchPh        = "Search items...",
    nui_parcelAvailable       = "Available:",
    nui_parcelFrom            = "From:",
    nui_parcelTo              = "To:",
    nui_parcelFeePaid         = "Fee paid:",
    nui_parcelCollectBtn      = "Collect",
    nui_parcelRejectBtn       = "Reject",
    nui_parcelNoItems         = "No items",
    nui_parcelUnknownItems    = "Unknown items",

    -- ─── NUI: Parcel Summary ───
    nui_parcelWeight          = "Weight: %s / %s",
    nui_parcelItems2          = "Items: %s",
    nui_parcelTypes           = "Types: %s / %s",
    nui_parcelFee             = "Fee: $%s",
    nui_parcelCollectAt       = "Collect at: %s",
    nui_parcelDispatchFrom    = "Dispatching from %s",
    nui_parcelArrives         = "Arrives: %s",

    -- ─── NUI: Notification Title Defaults ───
    nui_notifyTitle           = "Telegram Office",

    -- ─── NUI: Date / Month Abbreviations ───
    nui_monthJan = "Jan", nui_monthFeb = "Feb", nui_monthMar = "Mar",
    nui_monthApr = "Apr", nui_monthMay = "May", nui_monthJun = "Jun",
    nui_monthJul = "Jul", nui_monthAug = "Aug", nui_monthSep = "Sep",
    nui_monthOct = "Oct", nui_monthNov = "Nov", nui_monthDec = "Dec",

    -- ═══════════════════════════════════════════════════════════════
    -- NUI ERROR MESSAGES
    -- These map to server error codes shown in the UI.
    -- Prefix: nui_err_
    -- ═══════════════════════════════════════════════════════════════
    nui_err_generic             = "Something went wrong. Please try again.",
    nui_err_noMoney             = "You don't have enough money to complete this.",
    nui_err_notRegistered       = "You are not registered at a Telegram Office.",
    nui_err_alreadyRegistered   = "You are already registered.",
    nui_err_customIdTaken       = "That Telegram ID is already taken. Try another.",
    nui_err_customIdBlocked     = "That ID contains a blocked word.",
    nui_err_customIdInvalid     = "Invalid ID. Use only letters and numbers.",
    nui_err_recipientNotFound   = "The recipient Telegram ID does not exist.",
    nui_err_invalidRecipient    = "Invalid recipient Telegram ID.",
    nui_err_invalidSubject      = "Please enter a subject for your telegram.",
    nui_err_invalidMessage      = "Please write a message before sending.",
    nui_err_cannotSendToSelf    = "You cannot send a telegram to yourself.",
    nui_err_noStampSelected     = "Please select a stamp before sending.",
    nui_err_bulkNotPermitted    = "You don't have permission to send bulk telegrams.",
    nui_err_contactExists       = "This contact is already in your address book.",
    nui_err_contactsFull        = "Your address book is full. Remove some contacts to add more.",
    nui_err_invalidContactInfo  = "Invalid contact information.",
    nui_err_companyNotOwner     = "You must be an owner/boss to manage company members.",
    nui_err_companyMemberExists = "That person already has access.",
    nui_err_noCompanyAccess     = "You don't have access to this company's telegrams.",
    nui_err_noBusinessAccess    = "You don't have access to this business.",
    nui_err_noSendAccess        = "You don't have permission to send from this business.",
    nui_err_noReadAccess        = "You don't have permission to read this business's telegrams.",
    nui_err_cantModifyOwner     = "Owner permissions cannot be changed.",
    nui_err_maxBusinesses       = "You already own the maximum number of businesses.",
    nui_err_membershipsFull     = "That player is already in the maximum number of businesses.",
    nui_err_notPermitted        = "You are not permitted to create businesses.",
    nui_err_cantRemoveOwner     = "You cannot remove the business owner.",
    nui_err_directoryAlreadyListed = "You are already listed in the directory.",
    nui_err_directoryNotListed  = "You are not listed in the directory.",
    nui_err_bookFull            = "Your telegram book is full.",
    nui_err_bookEntryExists     = "That telegram ID is already in your book.",
    nui_err_notAllowed          = "You are not permitted to do this.",
    nui_err_notEnabled          = "This feature is not enabled.",
    nui_err_notEditable         = "This cannot be edited.",
    nui_err_signatureTooLarge   = "Signature data is too large. Please simplify it.",
    nui_err_disabled            = "This feature is currently disabled.",
    nui_err_cooldown            = "You must wait before doing this again.",
    nui_err_stampRequired       = "A stamp is required to send telegrams from the office.",
    nui_err_outstandingFees     = "You have outstanding postal fees. Please pay them before sending.",

    -- ═══════════════════════════════════════════════════════════════
    -- NUI BIRD ERROR MESSAGES
    -- Period-appropriate RP-friendly text for bird-related errors.
    -- Prefix: nui_birdErr_
    -- ═══════════════════════════════════════════════════════════════
    nui_birdErr_generic         = "Something went awry. Please try again.",
    nui_birdErr_noMoney         = "You haven't the funds for this transaction, I'm afraid.",
    nui_birdErr_notRegistered   = "You must register at a Telegram Office before acquiring a bird.",
    nui_birdErr_notAllowed      = "You are not permitted to deal in carrier birds.",
    nui_birdErr_disabled        = "The carrier bird service is not currently available.",
    nui_birdErr_shopExpired     = "That bird is no longer available — the stock has changed.",
    nui_birdErr_invalidBreed    = "That breed of bird is not recognized.",
    nui_birdErr_nameTooLong     = "That name is far too long. Keep it short and memorable.",
    nui_birdErr_maxOwned        = "You already own the maximum number of birds allowed.",
    nui_birdErr_invalidName     = "Please choose a proper name for your bird.",
    nui_birdErr_notYours        = "That bird does not belong to you.",
    nui_birdErr_inFlight        = "Your bird is currently carrying a delivery and cannot be disturbed.",
    nui_birdErr_inTraining      = "Your bird is still in training. Patience is a virtue.",
    nui_birdErr_birdDead        = "I'm sorry, but that bird has passed on. It is no more.",
    nui_birdErr_unknownItem     = "That item is not recognized as bird provisions.",
    nui_birdErr_noItem          = "You don't have the required supplies in your possession.",
    nui_birdErr_cooldown        = "You must wait a spell before doing that again.",
    nui_birdErr_birdResting     = "Your bird is resting after its last journey. Let it recover.",
    nui_birdErr_noStation       = "There is no Telegram station nearby to dispatch from.",
    nui_birdErr_outOfRange      = "The nearest station is too far for your bird to reach.",
    nui_birdErr_recipientNotFound = "No telegraph registration found for that recipient.",
    nui_birdErr_noBusinessAccess = "You do not have access to send on behalf of that business.",
    nui_birdErr_noSendAccess    = "You lack the send permission for that business telegram.",

    -- ═══════════════════════════════════════════════════════════════
    -- NUI TOAST MESSAGES
    -- Titles and messages shown in toast notifications within the UI.
    -- Prefix: nui_toast_
    -- ═══════════════════════════════════════════════════════════════

    -- Profile / Settings
    nui_toast_profileSaved        = "Profile picture saved.",
    nui_toast_profileSaveFail     = "Failed to save profile picture.",
    nui_toast_signatureSaved      = "Signature saved.",
    nui_toast_signatureSaveFail   = "Failed to save signature.",
    nui_toast_stampSaved          = "Custom stamp saved.",
    nui_toast_stampSaveFail       = "Failed to save stamp.",
    nui_toast_settingsSaved       = "Settings Saved",
    nui_toast_settingsSavedBody   = "Your signature & seal preferences have been updated.",

    -- Send
    nui_toast_telegramSent        = "Telegram Sent",
    nui_toast_telegramSentBody    = "Your telegram has been delivered.",
    nui_toast_telegramSentCost    = "Your telegram has been sent. Cost: $%s",
    nui_toast_sendFailed          = "Send Failed",
    nui_toast_sendServerError     = "Failed to contact the server.",
    nui_toast_unregisterFail      = "Failed to cancel service. Try again later.",

    -- Delete
    nui_toast_deleted             = "Deleted",
    nui_toast_telegramDeleted     = "Telegram has been deleted.",
    nui_toast_deleteFailed        = "Delete Failed",
    nui_toast_bulkDeleted         = "%s telegram(s) deleted.",
    nui_toast_bulkDeleteFail      = "Failed to delete selected telegrams.",

    -- Archive
    nui_toast_archived            = "Archived",
    nui_toast_telegramArchived    = "Telegram moved to archive.",
    nui_toast_archiveFailed       = "Archive Failed",
    nui_toast_restored            = "Restored",
    nui_toast_telegramRestored    = "Telegram restored to inbox.",
    nui_toast_restoreFailed       = "Restore Failed",
    nui_toast_bulkArchived        = "%s telegram(s) archived.",
    nui_toast_bulkArchiveFail     = "Failed to archive selected telegrams.",
    nui_toast_bulkRestored        = "%s telegram(s) restored.",
    nui_toast_bulkRestoreFail     = "Failed to restore selected telegrams.",

    -- Extract
    nui_toast_extracted           = "Extracted",
    nui_toast_copied              = "Copied",
    nui_toast_extractedBody       = "Telegram saved to your pocket.",
    nui_toast_copiedBody          = "Copy saved to your pocket.",
    nui_toast_extractFailed       = "Extract Failed",

    -- Contacts
    nui_toast_contactAdded        = "Contact Added",
    nui_toast_contactAddedBody    = "Saved to your address book.",
    nui_toast_contactAddFail      = "Add Failed",
    nui_toast_contactRemoved      = "Contact Removed",
    nui_toast_contactRemovedBody  = "Removed from your address book.",
    nui_toast_contactRemoveFail   = "Remove Failed",
    nui_toast_contactUpdated      = "Contact Updated",
    nui_toast_contactUpdatedBody  = "Contact details saved.",
    nui_toast_contactUpdateFail   = "Update Failed",

    -- Company
    nui_toast_memberAdded         = "Member Added",
    nui_toast_memberAddedBody     = "Added to company telegram access.",
    nui_toast_memberAddFail       = "Add Failed",
    nui_toast_memberRemoved       = "Member Removed",
    nui_toast_memberRemovedBody   = "Removed from company access.",
    nui_toast_memberRemoveFail    = "Remove Failed",

    -- Business
    nui_toast_bizCreated          = "Business Created",
    nui_toast_bizCreatedBody      = "Your new business is ready.",
    nui_toast_bizCreateFail       = "Creation Failed",
    nui_toast_bizDeleted          = "Business Deleted",
    nui_toast_bizDeletedBody      = "The business has been removed.",
    nui_toast_bizDeleteFail       = "Delete Failed",
    nui_toast_bizEmployeeAdded    = "Employee Added",
    nui_toast_bizEmployeeAddedBody = "Employee now has access.",
    nui_toast_bizEmployeeAddFail  = "Add Failed",
    nui_toast_bizEmployeeRemoved  = "Removed",
    nui_toast_bizEmployeeRemovedBody = "Employee removed from business.",
    nui_toast_bizEmployeeRemoveFail = "Remove Failed",
    nui_toast_bizPermUpdated      = "Permissions Updated",
    nui_toast_bizPermUpdatedBody  = "Employee permissions saved.",
    nui_toast_bizPermUpdateFail   = "Update Failed",

    -- Business creation errors
    nui_toast_bizErrDisabled      = "Business telegrams are disabled.",
    nui_toast_bizErrNoName        = "Enter a business name.",
    nui_toast_bizErrMaxBiz        = "You already own the maximum number of businesses.",
    nui_toast_bizErrNoMoney       = "You don't have enough money.",
    nui_toast_bizErrIdFail        = "Failed to generate a unique ID. Try again.",
    nui_toast_bizErrNotPermitted  = "You are not permitted to create businesses.",
    nui_toast_bizErrGeneric       = "Failed to create business.",

    -- Business member errors
    nui_toast_bizMemErrNotOwner   = "Only the business owner can add employees.",
    nui_toast_bizMemErrFull       = "Employee limit reached.",
    nui_toast_bizMemErrMemberFull = "That player is already in the maximum number of businesses.",
    nui_toast_bizMemErrExists     = "Already an employee of this business.",
    nui_toast_bizMemErrNotFound   = "That telegram ID doesn't exist.",
    nui_toast_bizMemErrGeneric    = "Failed to add employee.",

    -- Directory
    nui_toast_directoryListed     = "Listed",
    nui_toast_directoryListedBody = "You are now in the public directory.",
    nui_toast_directoryListFail   = "Listing Failed",
    nui_toast_directoryUnlisted   = "Unlisted",
    nui_toast_directoryUnlistedBody = "Removed from the public directory.",
    nui_toast_directoryUnlistFail = "Unlist Failed",
    nui_toast_directoryAdded      = "Added",
    nui_toast_directoryAddedBody  = "Added to your contacts",

    -- Fees
    nui_toast_feesPaid            = "Fees Paid",
    nui_toast_feesPaidBody        = "Outstanding fees have been settled.",
    nui_toast_feesPayFail         = "Payment Failed",

    -- ─── NUI: Parcel Toast Messages ───
    nui_toast_parcelFull          = "Parcel Full",
    nui_toast_parcelFullBody      = "Max %s different item types per parcel.",
    nui_toast_parcelTooHeavy      = "Too Heavy",
    nui_toast_parcelTooHeavyBody  = "Exceeds max parcel weight of %s.",
    nui_toast_parcelNoMore        = "No More",
    nui_toast_parcelNoMoreBody    = "You only have %s of this item.",
    nui_toast_parcelMissing       = "Missing",
    nui_toast_parcelNoRecipient   = "Please enter a recipient Telegram ID.",
    nui_toast_parcelEmptyTitle    = "Empty",
    nui_toast_parcelNoItemsSel    = "Select at least one item to send.",
    nui_toast_parcelError         = "Error",
    nui_toast_parcelServerFail    = "Failed to contact server.",
    nui_toast_parcelSent          = "Parcel Sent",
    nui_toast_parcelSentBody      = "Parcel dispatched to #%s.",
    nui_toast_parcelSendFailed    = "Send Failed",
    nui_toast_parcelCollected     = "Collected",
    nui_toast_parcelCollectedBody = "Parcel collected — items added to your inventory.",
    nui_toast_parcelCollectFail   = "Collection Failed",
    nui_toast_parcelTooHeavyCol   = "You don't have enough carrying capacity for this parcel.",
    nui_toast_parcelWeaponLimit   = "You already have a %s — can't carry another.",
    nui_toast_parcelItemLimit     = "You can't carry any more %s.",
    nui_toast_parcelRejected      = "Rejected",
    nui_toast_parcelRejectedBody  = "Parcel rejected — items returned to sender.",
    nui_toast_parcelRejectFail    = "Rejection Failed",
    nui_toast_parcelNoInbox       = "No parcels awaiting collection.",
    nui_toast_parcelNoSent        = "No sent parcels.",
    nui_toast_parcelNoSearch      = "No items match your search.",
    nui_toast_parcelNoInventory   = "No eligible items in your inventory.",
    nui_toast_parcelWrongStation  = "Collect this parcel at the %s Office.",
    nui_toast_parcelSelectHint    = "Select items from your inventory above.",

    -- ─── NUI: Bird Toast Messages ───
    nui_toast_birdPurchaseDec     = "Purchase Declined",
    nui_toast_birdError           = "Error",
    nui_toast_birdServerFail      = "Failed to contact server.",
    nui_toast_birdNameRequired    = "Name Required",
    nui_toast_birdEnterName       = "Please enter a name.",
    nui_toast_birdRenamed         = "Renamed",
    nui_toast_birdRenamedBody     = "Bird renamed to %s.",
    nui_toast_birdRenameFailed    = "Rename Failed",
    nui_toast_birdWelcome         = "%s is now in your care.",
    nui_toast_birdJoinsFlock      = "%s joins your flock!",
    nui_toast_birdPurchased       = "Bird Purchased",
    nui_toast_birdPurchasedBody   = "Your new bird is in your care.",
    nui_toast_birdNoItems         = "No eligible items in inventory.",
    nui_toast_birdCaredFor        = "Cared For",
    nui_toast_birdTrained         = "Trained",
    nui_toast_birdDone            = "Done!",
    nui_toast_birdActionFailed    = "Action Failed",
    nui_toast_birdReadyIn         = "Ready in %s",
    nui_toast_birdUseBtn          = "Use",
    nui_toast_birdReleased        = "Released",
    nui_toast_birdReleasedBody    = "Your bird has been released.",
    nui_toast_birdReleaseFailed   = "Release Failed",
    nui_toast_birdSold            = "Sold",
    nui_toast_birdSoldBody        = "Bird sold%s.",
    nui_toast_birdSaleFailed      = "Sale Failed",
    nui_toast_birdDisposed        = "Disposed",
    nui_toast_birdDisposedBody    = "The bird has been laid to rest.",
    nui_toast_birdDisposeFailed   = "Disposal Failed",
    nui_toast_birdDispatched      = "Bird Dispatched",
    nui_toast_birdDispatchedBody  = "Your bird is on the way to %s. ETA: %s.",
    nui_toast_birdDispatchFailed  = "Dispatch Failed",
    nui_toast_birdNoData          = "No bird or telegram data selected.",
    nui_toast_birdSendEmpty       = "No available birds. Ensure your bird is healthy and not busy.",

    -- ═══════════════════════════════════════════════════════════════
    -- ADDITIONAL NUI KEYS (referenced by JS L() / pbL() calls)
    -- ═══════════════════════════════════════════════════════════════

    -- ─── Month Abbreviations (underscore format used by JS) ───
    nui_month_jan = "Jan", nui_month_feb = "Feb", nui_month_mar = "Mar",
    nui_month_apr = "Apr", nui_month_may = "May", nui_month_jun = "Jun",
    nui_month_jul = "Jul", nui_month_aug = "Aug", nui_month_sep = "Sep",
    nui_month_oct = "Oct", nui_month_nov = "Nov", nui_month_dec = "Dec",

    -- ─── Date Locale ───
    nui_dateLocale                = "en-US",

    -- ─── General UI Fallbacks ───
    nui_unknown                   = "Unknown",
    nui_noSubject                 = "(No Subject)",
    nui_saveToPaper               = "Save to Paper",
    nui_takeOut                   = "Take Out",
    nui_composeCost               = "Cost: $%s",
    nui_bizCost                   = "Cost: $%s",
    nui_deselectAll               = "Deselect all",

    -- ─── Registration (additional) ───
    nui_regAlreadyTaken           = "✗ Already taken",
    nui_regBlockedWord            = "✗ Blocked word",

    -- ─── Empty States ───
    nui_emptyStateInbox           = "No dispatches on record.",
    nui_emptyStateSent            = "No telegrams transmitted.",
    nui_emptyStateCompany         = "No company telegrams to display.",
    nui_emptyStateContacts        = "Your address book lies empty.",
    nui_emptyStateCompanyTele     = "No company dispatches on record.",
    nui_emptyStateEmployees       = "No employees on the payroll.",
    nui_emptyStateChecker         = "Enter an identification number to search for dispatches.",
    nui_emptyStateDir             = "No public listings have been filed.",
    nui_emptyStateMembers         = "No members have been added.",

    -- ─── Directory (additional) ───
    nui_dirCompose                = "Compose telegram",
    nui_dirAddContact             = "Add to contacts",
    nui_dirAllCategories          = "All Categories",
    nui_dirListTitle              = "List in Public Directory",

    -- ─── Parcel Rendering (additional) ───
    nui_parcelEmptyInbox          = "No parcels awaiting collection.",
    nui_parcelEmptySent           = "No sent parcels.",
    nui_parcelReject              = "Reject",
    nui_parcelSearchItems         = "Search items...",
    nui_parcelNoMatch             = "No items match your search.",
    nui_parcelNoItemsShort        = "No items",
    nui_parcelMore                = "more",
    nui_parcelSelectItems         = "Select items from your inventory above.",

    -- ─── Bird System (additional) ───
    nui_birdSend                  = "Send",
    nui_birdCare                  = "Care",
    nui_birdSell                  = "Sell",
    nui_birdDispose               = "Dispose",
    nui_birdBuyBtn                = "Buy",
    nui_birdBuyTitle              = "Purchase Carrier Bird",
    nui_birdBuyDesc               = "You are purchasing a %s.",
    nui_birdConfirmPurchase       = "Confirm Purchase",
    nui_birdTotalDue              = "Total Due:",
    nui_birdMoments               = "moments",
    nui_birdThisBird              = "this bird",
    nui_birdTooWeakSell           = "Bird is too weak to sell (health too low)",
    nui_birdNoItems               = "No eligible items in inventory.",
    nui_birdUse                   = "Use",
    nui_birdReadyIn               = "Ready in %s",
    nui_birdNoEligible            = "No available birds. Ensure your bird is healthy and not busy.",
    nui_birdEmptyState            = "You don't own any carrier birds yet.",
    nui_birdLvl                   = "Lvl",

    -- ─── Bird Status Labels (additional) ───
    nui_birdStatusDead            = "Deceased",
    nui_birdStatusTraining        = "In Training",

    -- ─── Bird Activity Text (additional) ───
    nui_birdActContent            = "Content and ready",
    nui_birdActPeckish            = "Ready, slightly peckish",
    nui_birdActReady              = "Available for duty",
    nui_birdActFinishing          = "Finishing training...",
    nui_birdActPassedAway         = "This bird has passed away",
    nui_birdActDied               = "Passed away — %s",
    nui_birdActResting            = "Resting — %s left",
    nui_birdActTraining           = "Training — %s left",

    -- ─── Bird Shop (additional) ───
    nui_birdShopRefreshing        = "Refreshing soon...",
    nui_birdShopNextIn            = "Next birds available in %s",
    nui_birdShopEmpty             = "No birds available right now. Check back soon!",
    nui_birdShopMaxNote           = "You already own the maximum number of birds (%s).",

    -- ─── Bird Care/Train (additional) ───
    nui_birdCareTitle             = "Care for Bird",
    nui_birdCareDesc              = "Use an item to restore your bird's health or hunger.",
    nui_birdTrainTitle            = "Train Bird",
    nui_birdTrainDesc             = "Use a training item. The bird will enter training for a period.",

    -- ─── Toast: Profile / Settings ───
    nui_toast_ppUpdated           = "Profile picture updated.",
    nui_toast_ppFailed            = "Failed to save profile picture.",
    nui_toast_sigSaveFail         = "Failed to save signature.",
    nui_toast_sigUpdated          = "Your signature & seal preferences have been updated.",
    nui_toast_noChanges           = "No changes to save.",

    -- ─── Toast: Registration ───
    nui_toast_enterCustomId       = "Please enter a custom Telegram ID.",
    nui_toast_signFirst           = "Please sign the registration form.",
    nui_toast_regFailed           = "Registration failed. Please try again.",

    -- ─── Toast: Compose / Send ───
    nui_toast_enterRecipient      = "Please enter a recipient Telegram ID.",
    nui_toast_enterSubject        = "Please enter a subject.",
    nui_toast_emptyMessage        = "Please write a message before sending.",
    nui_toast_messageTooLong      = "Message is too long (max %s characters).",
    nui_toast_stampRequired       = "A stamp is required to send telegrams.",
    nui_toast_selectBird          = "Please select a bird first.",
    nui_toast_birdAttachFail      = "Failed to attach telegram to bird.",
    nui_toast_sendFail            = "Failed to send telegram.",

    -- ─── Toast: Delete / Archive ───
    nui_toast_deleteFail          = "Failed to delete telegram.",
    nui_toast_archiveFail         = "Failed to archive telegram.",
    nui_toast_restoreFail         = "Failed to restore telegram.",
    nui_toast_extractFail         = "Failed to extract telegram.",
    nui_toast_bookRemoved         = "Entry removed from telegram book.",

    -- ─── Toast: Contacts ───
    nui_toast_nameEmpty           = "Contact name cannot be empty.",
    nui_toast_enterBothNameId     = "Please enter both a name and telegram ID.",

    -- ─── Toast: Business ───
    nui_toast_enterBizName        = "Please enter a business name.",
    nui_toast_bizIdGenFail        = "Failed to generate a unique ID. Try again.",
    nui_toast_enterTelegramId     = "Please enter a Telegram ID.",
    nui_toast_employeeLimitReached = "Employee limit reached.",
    nui_toast_alreadyEmployee     = "Already an employee of this business.",
    nui_toast_employeeAdded       = "%s has been added as an employee.",
    nui_toast_employeeAddFail     = "Failed to add employee.",
    nui_toast_employeeRemoved     = "%s has been removed from the business.",
    nui_toast_employeeRemoveFail  = "Failed to remove employee.",
    nui_toast_permsUpdated        = "Permissions updated for %s.",
    nui_toast_permsUpdateFail     = "Failed to update permissions.",
    nui_toast_outstandingFees     = "You have outstanding postal fees of %s. Please pay before sending.",
    nui_toast_customIdLen         = "Custom ID must be between %s and %s characters.",
    nui_toast_enterLookupId       = "Please enter a Telegram ID to look up.",

    -- ─── Toast: Directory ───
    nui_toast_addedContacts       = "Added to your contacts.",
    nui_toast_addToContactsFail   = "Failed to add to contacts.",
    nui_toast_enterDisplayName    = "Please enter a display name.",
    nui_toast_dirListedSelf       = "You are now listed in the public directory.",
    nui_toast_dirListed           = "%s is now listed in the public directory.",
    nui_toast_dirListFail         = "Failed to list in directory.",
    nui_toast_dirUnlisted         = "Removed from the public directory.",
    nui_toast_dirUnlistedSelf     = "You have been removed from the directory.",
    nui_toast_dirUnlistFail       = "Failed to remove from directory.",

    -- ─── Toast: Company Members ───
    nui_toast_compMemberAdded     = "%s has been added to company access.",
    nui_toast_compMemberAddFail   = "Failed to add company member.",
    nui_toast_compMemberRemoved   = "Member removed from company access.",
    nui_toast_compMemberRemoveFail = "Failed to remove company member.",

    -- ─── Toast: Bird (additional) ───
    nui_toast_birdBuyFail         = "Failed to purchase bird.",
    nui_toast_birdRenameFail      = "Failed to rename bird.",
    nui_toast_birdActionFail      = "Something went wrong. Try again.",
    nui_toast_birdReleaseFail     = "Failed to release bird.",
    nui_toast_birdSellFail        = "Failed to sell bird.",
    nui_toast_birdRefunded        = "refunded",
    nui_toast_birdDisposeFail     = "Failed to dispose of bird.",
    nui_toast_birdNoSelection     = "No bird or telegram data selected.",
    nui_toast_serverFail          = "Failed to contact server.",
    nui_toast_birdDestination     = "destination",
    nui_toast_birdDispatched      = "Your bird is on the way to %s. ETA: %s.",
    nui_toast_birdDispatchFail    = "Could not dispatch the bird.",

    -- ─── Toast: Parcels (additional) ───
    nui_toast_parcelEmpty         = "Select at least one item to send.",
    nui_toast_parcelSendFail      = "Failed to send parcel.",
    nui_toast_parcelTooHeavyCollect = "You don't have enough carrying capacity for this parcel.",

    -- ─── Bird system ───
    birdsDisabled                 = "The carrier bird service is not available at this time.",

    -- ─── Public Board / Bulletin ───
    nui_tabBulletin               = "Public",
    nui_bulletinHeader            = "Public Board",
    nui_bulletinPost              = "Post",
    nui_bulletinPostBtn           = "Post to Public",
    nui_bulletinEmpty             = "No public telegrams yet.",
    nui_toast_bulletinPosted      = "Your post has been made public.",
    nui_toast_bulletinPostFail    = "Failed to post publicly.",
    nui_err_maxPostsReached       = "You have reached the maximum number of public posts.",
    nui_err_bulletinDisabled      = "Public posting is not available at this time.",
    nui_err_notPermitted          = "You are not permitted to post publicly.",
}

function _U(str, ...)
    local locale = (Config and Config.Locale) or "en"
    local text = Locales[locale] and Locales[locale][str] or Locales["en"] and Locales["en"][str] or str
    if ... then
        return string.format(text, ...)
    end
    return text
end
