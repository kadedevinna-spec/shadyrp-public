Config = {}

-- Global
Config.InteractDistance = 2.00
Config.DrawDistance = 5.0
--- Same-model clerks inside this sphere at shop spawn are nuked before spawn + on resource stop sweep.
Config.NpcRestartPurgeRadius = 3.25

Config.OpenKey = 0x760A9C6F
Config.DefaultMoneyType = 'cash'

--- In-world shelf pickup (story-mode style). Set EnableShelfPickups = false to disable entirely.
Config.EnableShelfPickups = true
--- World prop models on shelf coords — keep false; use DrawText + [G] buy only (props use store mesh).
Config.EnableShelfProps = false
Config.ShelfDrawTextDistance = 1.20  --- DrawText3D only this close (meters)
Config.ShelfBuyDistance = 1.20       --- [G] buy radius
Config.ShelfPropDrawDistance = 6.0   --- only when EnableShelfProps = true
Config.ShelfStoreRadius = 28.0
Config.ShelfBuyKey = 0x760A9C6F -- G — same as open; closest interact wins (clerk vs shelf)
--- Hold [G] this long on a shelf before purchase fires (ms).
Config.ShelfHoldDurationMs = 1400
--- Instant shelf buy (server first). Cosmetic pickup anim runs async when true.
Config.ShelfInstantBuy = true
Config.ShelfPickupAnim = true
--- Height thresholds (shelf Z minus player foot Z).
--- diff <= low → 'low' tier | low < diff <= high → 'mid' tier | diff > high → 'top' tier
Config.ShelfAnimThresholds = { low = 0.35, high = 0.80 }
--- Lateral thresholds (metres along the player right-vector toward the item).
--- lateral < farLeft → variant 1 | farLeft–0 → 2 | 0–farRight → 3 | > farRight → 4
Config.ShelfAnimLateralThresholds = { farLeft = -0.20, farRight = 0.20 }
--- Duration (ms) for every shelf pickup animation clip.
Config.ShelfAnimDuration = 1700
--- How many ms into the animation before the item prop appears in the hand.
--- nil = auto (40 % of ShelfAnimDuration). Tune if the prop appears too early/late.
Config.ShelfPropAttachDelay = nil
--- When multiple shelves are in range, only the one you look at shows DrawText (gameplay cam).
Config.ShelfLookAtPick = true
Config.ShelfLookDotMin = 0.78      --- 0.0–1.0 — higher = narrower cone (more precise aim)
--- Extra Z added to the shelf DrawText anchor (positive = higher, negative = lower).
--- Tune if the callout appears above or below the actual shelf coord.
Config.ShelfTextZOffset = 0.18

-- ─── Clerk Robbery ──────────────────────────────────────────────────────────
Config.Robbery = {
    enabled         = true,
    -- How long the player must keep weapon aimed at the clerk before the heist fires (ms).
    aimHoldDuration = 4000,
    -- Max distance allowed between player and clerk while aiming.
    maxAimDistance  = 6.0,
    -- Player must walk this far away before the clerk stops the surrender anim.
    surrenderReleaseDistance = 10.0,
    -- After the player stops aiming, clerk stays surrendered this long before standing back up (ms).
    surrenderAimReleaseDelay = 3000,
    -- View-cone tightness for aim detection (0–1). Higher = must point more precisely.
    aimConeDot      = 0.93,
    -- Reward range (random between).
    rewardMin       = 80,
    rewardMax       = 250,
    -- Cooldown per store (ms). Server-side enforced.
    cooldown        = 30 * 60 * 1000, -- 30 min
    moneyType       = 'cash',
    -- Prop the NPC pulls from his pocket and tosses on the counter.
    moneyProp       = 'p_worm_moneystack01x',
    moneyPropAttach = {
        bone = 'SKEL_R_Finger00',
        -- Pinch grip (mirrored from canned-food finger attach in this resource)
        x = 0.08, y = -0.02, z = 0.015,
        rx = 100.0, ry = 72.0, rz = 22.0,
    },
    -- Animations.
    surrenderAnim   = {
        dict = 'script_mp@bounty@legendary@lbc@ig@lbc_ig1_surrender',
        clip = "cecil_ig1_don't_kill_me",
        flag = 1, -- looped
    },
    handoverAnim    = {
        dict        = 'script_re@pick_pocket@surrender',
        clip        = 'surrender',
        flag        = 0,
        -- Fallback duration if the game can't report the real clip length.
        duration    = 4500,
        -- Toss point as a fraction of the clip (0.0–1.0). Scales to real anim length.
        dropAtPct   = 0.74,
        -- How long before the toss the cash appears in the hand (ms).
        spawnLeadMs = 1200,
        -- Forward / upward throw speed (m/s) when the stack is released.
        tossSpeed   = 3.2,
        tossUp      = 1.4,
    },
    -- Police alert (%s = Config.Stores[id].label). LEO = job.type 'leo' (vallaw, rholaw, …).
    alertText       = 'Robbery in progress — %s',
    -- false = any LEO receives alert even off duty (handy for testing).
    alertLeoMustBeOnDuty = true,
    -- Chance (0.0–1.0) the clerk fights back instead of surrendering.
    clerkFightChance = 0.50,
    clerkFightWeapon = 'WEAPON_SHOTGUN_DOUBLEBARREL',
    clerkFightAmmo   = 8,
    clerkFightAccuracy = 55,
    -- Delay before the clerk opens fire after drawing (ms).
    clerkFightDrawDelayMs = 700,
    clerkFightRetaskMs = 350,
    clerkFightEngageDistance = 2.8,
    clerkFightMoveSpeed = 3.0,
    -- Clerk calms down and returns to shop idle after the robber runs this far (meters).
    clerkFightResetDistance = 25.0,
    clerkFightAlertText = 'Clerk fighting back — %s',
    clerkFightToast = 'The clerk pulled a double-barrel shotgun!',
    -- Respawn clerk after death (ms). nil = same as robbery cooldown.
    clerkRespawnMs = nil,
    -- Cash register loot after killing a fighting clerk.
    registerDrawDistance     = 1.35,
    registerInteractDistance = 1.20,
    registerRobKey           = Config.OpenKey, -- G
    registerHoldDurationMs   = 1400,
    registerRewardMin        = 120,
    registerRewardMax        = 350,
    registerAnim = {
        dict         = 'mech_pickup@loot@cash_register@open',
        clip         = 'rifle_grab_open_base',
        flag         = 0,
        duration     = 3200,
        propSpawnPct = 0.70,  -- when money prop attaches (0.0–1.0 of clip length)
    },
    -- Offsets for money prop attached to left thumb during register loot anim.
    registerPropAttach = {
        x = 0.0, y = 0.0, z = 0.0,
        rx = 0.0, ry = 0.0, rz = 0.0,
    },
}

-- ─── Clerk Idle Animations ──────────────────────────────────────────────────
Config.ClerkIdleAnims = {
    enabled = true,
    dict    = 'script_amb@stores@store_arms_crossed_stoic',
    clips   = {
        'idle_a', 'idle_b', 'idle_c',
        'impatient_a', 'impatient_b',
        'neg_a', 'neg_b',
        'neutral_a', 'neutral_b',
    },
    -- How long each animation loops before transitioning (ms).
    minHoldDuration = 5 * 60 * 1000,   -- 5 min
    maxHoldDuration = 10 * 60 * 1000,  -- 10 min
    -- Pause between animations — clerk returns to default stance (ms).
    minPauseBetween = 3000,
    maxPauseBetween = 8000,
    -- Blend speed: higher = snappier in/out, lower = smoother.
    blendIn  = 2.0,
    blendOut = 2.0,
    -- Initial delay after clerk spawns before first anim plays (ms).
    startDelay = 2500,
}

--- PNGs live in `html/images/` only — never rsg-inventory.
Config.StoreImageBase = nil
Config.BlipSprite = 249721687

-- ─── Stock System ─────────────────────────────────────────────────────────────
Config.Stock = {
    enabled  = true,

    -- Default maximum stock for items that don't declare their own `stock` field.
    defaultMax = 50,

    -- When stock drops to or below this number the card shows "X left".
    -- Set to 0 to never show the low-stock label.
    lowStockThreshold = 10,

    -- Automatic restock timer.
    restock = {
        enabled         = true,
        intervalMinutes = 60,       -- how often to refill
        amount          = 'full',   -- 'full' = refill to max | number = units added per cycle
    },
}

-- Player-owned stores. Dynamic stores live in SQL and feed into the same
-- customer shopping UI without modifying the fixed Config.Stores entries.
Config.OwnedStores = {
    enabled = true,
    adminPermission = 'admin',
    defaultPed = 'u_m_m_valgenstoreowner_01',
    defaultMoneyType = Config.DefaultMoneyType,
    defaultBlip = {
        enabled = true,
        name = 'Player Store',
        sprite = Config.BlipSprite,
        scale = 0.2,
        style = 1664425300,
    },
    commands = {
        create = 'gscreateowned', -- /gscreateowned <playerId> <store_id> <store name>
        addStock = 'gsaddstock',  -- /gsaddstock <store_id> <item> <qty> <price>
        withdraw = 'gswithdraw',  -- /gswithdraw <store_id>
        info = 'gsstoreinfo',     -- /gsstoreinfo <store_id>
        setOwner = 'gssetowner',  -- /gssetowner <store_id> <playerId>
    },
}
--[[
  Per-item stock override — add a `stock` field inside any item row:
    { item = 'bread', price = 0.35, stock = 50, ... }
  If omitted, Config.Stock.defaultMax is used.
  Set stock = 0 in the row to mark an item as permanently sold-out (no restock).
]]

--[[
Each store is self-contained:

  cameras.catalog — world cam (pest-style):
    coords  = vector3(...)   REQUIRED — lens position (/coords in game)
    heading = degrees        REQUIRED — yaw the camera aims (where it looks +Z)
    pitch   = degrees        usually negative (~ -5 … -15)
    fov, easeIn, easeOut     RenderScriptCams blend

  displayCase.weapon | .object — world vitrine spots for THIS shop:
    coords = vector3(...)    REQUIRED — where the prop sits
    rotation = { x,y,z }     euler degs in world frame (drag adds on top)

  items[] fields:
    image      = 'bread.png'       — REQUIRED — filename inside html/images/ (your PNGs)
    prop       = 'p_bread01x'      — world vitrine prop
    propType   = 'object'|'weapon' — optional, default 'object'
    propRotation = { x, y, z }     — optional euler override on spawn

    shelf = { ... }                — OPTIONAL — omit entire field = catalog/NUI only, no shelf pickup
    buyNotify  = 'You grab some bread.'  — OPTIONAL — custom success message on shelf buy
                                           omit = shows item label | false = silent
]]
Config.Stores = {
    ['valentine_general'] = {
        label = 'General Store — Valentine',
        moneyType = Config.DefaultMoneyType,
        blip = {
            enabled = true,
            name = 'General Store',
            sprite = Config.BlipSprite,
            scale = 0.2,
            style = 1664425300,
        },
        npc = {
            model = 'u_m_m_valgenstoreowner_01',
            coords = vector4(-324.0032043457031, 803.3884887695312, 117.8817138671875, -79.188232421875),
        },
        -- Till loot spot after clerk dies during fightback (vector4 = x,y,z,heading).
        cashRegister = vector4(-323.3852844238281, 804.3350219726562, 117.9317398071289, -80.00006866455078),
        cameras = {
            catalog = {
                coords = vector3(-322.56, 804.33, 118.75),
                heading = 123.91,
                pitch = -40.85,
                fov = 42.5,
                easeIn = 950,
                easeOut = 700,
            },
        },
        displayCase = {
            weapon = {
                coords = vector3(-323.20928955078125, 803.5733642578125, 117.95999908447266),
                rotation = { x = 90.0, y = 0.0, z = 25.0 },
            },
            object = {
                coords = vector3(-323.20928955078125, 803.5733642578125, 117.95999908447266),
                rotation = { x = 0.0, y = 0.0, z = 18.5 },
            },
        },
        categories = {
            { id = 'provisions', label = 'Provisions' },
            { id = 'drinks', label = 'Drinks' },
            { id = 'gear', label = 'Gear' },
            { id = 'medical', label = 'Medical' },
        },
        items = {
            { item = 'bread',             stock = 30,  price = 0.35, category = 'provisions', image = 'bread.png',           prop = 'p_bread01x',             shelf = { coords = vector3(-319.8424987792969,  801.3035278320312,  117.6867446899414),  heading = 100.0 } },
            { item = 'stew',              stock = 20,  price = 1.20, category = 'provisions', image = 'stew.png',            prop = 'p_bowl03x_stew'                                                                                                                     },
            { item = 'biscuits',          stock = 25,  price = 0.45, category = 'provisions', image = 'biscuits.png',        prop = 's_biscuits01x',          shelf = { coords = vector3(-319.8459167480469, 801.9720458984375, 118.25347137451172), heading = 100.0 }   },
            { item = 'oatcakes',          stock = 20,  price = 0.55, category = 'provisions', image = 'oatcakes.png',        prop = 's_oatcakes01x',          shelf = { coords = vector3(-325.24560546875,    799.8867797851562,  117.94365692138672), heading = 100.0 } },
            { item = 'chocolatebar',      stock = 15,  price = 0.50, category = 'provisions', image = 'chocolatebar.png',    prop = 's_chocolatebar01x',      shelf = { coords = vector3(-322.62164306640625, 800.1096801757812,  117.92462158203125), heading = 100.0 } },
            { item = 'cheesewedge',       stock = 15,  price = 0.75, category = 'provisions', image = 'cheesewedge.png',     prop = 's_cheesewedge1x',        shelf = { coords = vector3(-324.1097412109375,  802.2269287109375,  117.9543685913086),  heading = 100.0 } },
            { item = 'salted_beef',       stock = 20,  price = 0.95, category = 'provisions', image = 'salted_beef.png',     prop = 's_saltedbeef01x',        shelf = { coords = vector3(-325.24481201171875, 801.9877319335938,  117.95695495605469), heading = 100.0 } },
            { item = 'salted_venison',    stock = 18,  price = 1.00, category = 'provisions', image = 'salted_venison.png',  prop = 's_wrappedvenison01x',    shelf = { coords = vector3(-324.8326721191406,  802.046142578125,   117.95777893066406), heading = 100.0 } },
            { item = 'canstrawberries',   stock = 22,  price = 0.85, category = 'provisions', image = 'canstrawberries.png', prop = 's_canstrawberries01x'                                                                                                               },
            { item = 'canpineapple',      stock = 22,  price = 0.85, category = 'provisions', image = 'canpineapple.png',    prop = 's_canpineapple01x'                                                                                                                  },
            { item = 'cornedbeef',        stock = 18,  price = 1.10, category = 'provisions', image = 'cornedbeef.png',      prop = 's_cornedbeef01x'                                                                                                                    },
            { item = 'canpeas',           stock = 25,  price = 0.55, category = 'provisions', image = 'canpeas.png',         prop = 's_canpeas01x'                                                                                                                       },
            { item = 'cancorn',           stock = 25,  price = 0.55, category = 'provisions', image = 'cancorn.png',         prop = 's_cancorn01x',           shelf = { coords = vector3(-319.7229309082031, 801.2686767578125, 118.3081283569336), heading = 100.0 }    },
            { item = 'canpeaches',        stock = 22,  price = 0.80, category = 'provisions', image = 'canpeaches.png',      prop = 's_canpeaches01x',        shelf = { coords = vector3(-319.6702575683594, 801.0518798828125, 118.81207275390625), heading = 100.0 }   },
            { item = 'canbeans',          stock = 22,  price = 0.65, category = 'provisions', image = 'canbeans.png',        prop = 's_canbeans01x',          shelf = { coords = vector3(-319.82611083984375, 801.9403686523438, 118.8149185180664), heading = 100.0 }   },
            { item = 'tobacco',           stock = 20,  price = 0.40, category = 'provisions', image = 'tobacco.png',         prop = 's_inv_tabacco01x',       shelf = { coords = vector3(-319.6125183105469, 799.902587890625, 117.67500305175781), heading = 100.0 }    },
            { item = 'cigarette',         stock = 25,  price = 0.35, category = 'provisions', image = 'cigarette.png',       prop = 'p_cigarettebox01x',      shelf = { coords = vector3(-319.49273681640625, 800.0764770507812, 118.40703582763672), heading = 100.0 }  },
            { item = 'cigar',             stock = 10,  price = 0.75, category = 'provisions', image = 'cigar.png',           prop = 'p_cigar02x',             shelf = { coords = vector3(-319.4552001953125, 799.1085205078125, 117.7334213256836), heading = 100.0 }    },
            { item = 'water',             stock = 40,  price = 0.25, category = 'drinks',     image = 'water.png',           prop = 'p_water01x'                                                                                                                         },
            { item = 'coffee',            stock = 20,  price = 0.60, category = 'drinks',     image = 'coffee.png',          prop = 's_coffeetin01x',         shelf = { coords = vector3(-320.0247802734375, 803.1658325195312, 118.30998992919922), heading = 100.0 }   },
            { item = 'brandy',            stock = 8,   price = 2.50, category = 'drinks',     image = 'brandy.png',          prop = 's_brandy01x'                                                                                                                        },
            { item = 'rum',               stock = 8,   price = 2.50, category = 'drinks',     image = 'rum.png',             prop = 's_inv_rum01x',           shelf = { coords = vector3(-319.3027038574219,  799.068359375,      118.36113739013672), heading = 100.0 } },
            { item = 'whiskey',           stock = 6,   price = 2.75, category = 'drinks',     image = 'whiskey.png',         prop = 's_inv_whiskey01x',       shelf = { coords = vector3(-319.47113037109375, 799.7779541015625, 118.70556640625), heading = 100.0}      },
            { item = 'gin',               stock = 6,   price = 3.00, category = 'drinks',     image = 'gin.png',             prop = 's_inv_gin01x',            shelf = { coords = vector3(-319.35687255859375, 799.08056640625, 118.70745849609375), heading = 100.0}    },
            { item = 'horse_brush',       stock = 5,   price = 2.50, category = 'gear',       image = 'horse_brush.png',     prop = 'p_brushhorse01x'                                                                                                                    },
            { item = 'horse_lantern',     stock = 4,   price = 4.00, category = 'gear',       image = 'horse_lantern.png',   prop = 'mp005_p_horselantern01'                                                                                                             },
            { item = 'bandage',           stock = 15,  price = 1.80, category = 'medical',    image = 'bandage.png',         prop = 'p_cs_bandage01x'                                                                                                                    },
            { item = 'fieldbandage',      stock = 20,  price = 0.90, category = 'medical',    image = 'fieldbandage.png',    prop = 'p_cs_bandage01x'                                                                                                                    },
        },
    },

    ['strawberry_general'] = {
        label = 'General Store — Strawberry',
        moneyType = Config.DefaultMoneyType,
        blip = {
            enabled = true,
            name = 'General Store',
            sprite = Config.BlipSprite,
            scale = 0.2,
            style = 1664425300,
        },
        npc = {
            model = 'u_m_m_strgenstoreowner_01',
            coords = vector4(-1789.57568359375, -387.9025573730469, 160.3285369873047, 59.33208847045898),
        },
        cashRegister = vector4(-785.3272094726562, -1323.0341796875, 43.93404388427734, 180),
        cameras = {
            catalog = {
                coords = vector3(-1791.45, -387.85, 161.24),
                heading = -99.37,
                pitch   = -40.85,
                fov     = 42.5,
                easeIn  = 950,
                easeOut = 700,
            },
        },
        displayCase = {
            weapon = {
                coords   = vector3(-1790.5537109375, -387.669189453125, 160.44),
                rotation = { x = 90.0, y = 0.0, z = 125.0 },
            },
            object = {
                coords   = vector3(-1790.5537109375, -387.669189453125, 160.44),
                rotation = { x = 0.0, y = 0.0, z = 125.0 },
            },
        },
        categories = {
            { id = 'provisions', label = 'Provisions' },
            { id = 'drinks',     label = 'Drinks'     },
            { id = 'gear',       label = 'Gear'       },
            { id = 'medical',    label = 'Medical'    },
        },
        items = {
            { item = 'bread',             stock = 30, price = 0.40, category = 'provisions', image = 'bread.png',           prop = 'p_bread01x',                                                                                                                       },
            { item = 'biscuits',          stock = 25, price = 0.50, category = 'provisions', image = 'biscuits.png',        prop = 's_biscuits01x',          shelf = { coords = vector3(-1791.6900634765625, -382.8997497558594, 160.38075256347656), heading = 59.0 } },
            { item = 'oatcakes',          stock = 20, price = 0.60, category = 'provisions', image = 'oatcakes.png',        prop = 's_oatcakes01x',          shelf = { coords = vector3(-1792.14501953125, -382.7163391113281, 159.9291534423828), heading = 59.0 }    },
            { item = 'chocolatebar',      stock = 15, price = 0.55, category = 'provisions', image = 'chocolatebar.png',    prop = 's_chocolatebar01x',                                                                                                                },
            { item = 'cheesewedge',       stock = 15, price = 0.80, category = 'provisions', image = 'cheesewedge.png',     prop = 's_cheesewedge1x',                                                                                                                  },
            { item = 'salted_beef',       stock = 20, price = 1.00, category = 'provisions', image = 'salted_beef.png',     prop = 's_saltedbeef01x',        shelf = { coords = vector3(-1791.6004638671875, -388.7918395996094, 160.38864135742188), heading = 59.0 } },
            { item = 'salted_venison',    stock = 18, price = 1.05, category = 'provisions', image = 'salted_venison.png',  prop = 's_wrappedvenison01x',    shelf = { coords = vector3(-1791.8017578125, -388.9416809082031, 160.3892822265625), heading = 59.0 }     },
            { item = 'canstrawberries',   stock = 22, price = 0.90, category = 'provisions', image = 'canstrawberries.png', prop = 's_canstrawberries01x',                                                                                                             },
            { item = 'canpineapple',      stock = 22, price = 0.90, category = 'provisions', image = 'canpineapple.png',    prop = 's_canpineapple01x',                                                                                                                },
            { item = 'cornedbeef',        stock = 18, price = 1.15, category = 'provisions', image = 'cornedbeef.png',      prop = 's_cornedbeef01x',                                                                                                                  },
            { item = 'canpeas',           stock = 25, price = 0.60, category = 'provisions', image = 'canpeas.png',         prop = 's_canpeas01x',           shelf = { coords = vector3(-1796.040283203125, -386.11822509765625, 160.82630920410156), heading = 59.0 } },
            { item = 'cancorn',           stock = 25, price = 0.60, category = 'provisions', image = 'cancorn.png',         prop = 's_cancorn01x',           shelf = { coords = vector3(-1795.9537353515625, -385.9068603515625, 159.9327850341797), heading = 59.0 }  },
            { item = 'canpeaches',        stock = 22, price = 0.85, category = 'provisions', image = 'canpeaches.png',      prop = 's_canpeaches01x',        shelf = { coords = vector3(-1796.300537109375, -385.8606872558594, 160.37716674804688), heading = 59.0 }  },
            { item = 'canbeans',          stock = 22, price = 0.70, category = 'provisions', image = 'canbeans.png',        prop = 's_canbeans01x',          shelf = { coords = vector3(-1795.65283203125, -386.31732177734375, 160.37815856933594), heading = 59.0 }  },
            { item = 'tobacco',           stock = 20, price = 0.45, category = 'provisions', image = 'tobacco.png',         prop = 's_inv_tabacco01x',       shelf = { coords = vector3(-1789.456298828125, -384.4435729980469, 159.90884399414062), heading = 59.0 }  },
            { item = 'cigarette',         stock = 25, price = 0.35, category = 'provisions', image = 'cigarette.png',       prop = 'p_cigarettebox01x',      shelf = { coords = vector3(-1789.736572265625, -384.2523193359375, 160.37600708007812), heading = 100.0}  },
            { item = 'cigar',             stock = 10, price = 0.75, category = 'provisions', image = 'cigar.png',           prop = 'p_cigar02x',             shelf = { coords = vector3(-1789.179443359375, -384.5888366699219, 160.44493103027344), heading = 100.0 } },
            { item = 'water',             stock = 40, price = 0.30, category = 'drinks',     image = 'water.png',           prop = 'p_water01x',                                                                                                                       },
            { item = 'coffee',            stock = 20, price = 0.65, category = 'drinks',     image = 'coffee.png',          prop = 's_coffeetin01x',         shelf = { coords = vector3(-1791.114501953125, -383.2523498535156, 160.82928466796875), heading = 59.0 }  },
            { item = 'brandy',            stock = 8,  price = 2.75, category = 'drinks',     image = 'brandy.png',          prop = 's_brandy01x'                                                                                                                       },
            { item = 'rum',               stock = 8,  price = 2.75, category = 'drinks',     image = 'rum.png',             prop = 's_inv_rum01x',                                                                                                                     },
            { item = 'whiskey',           stock = 6,  price = 2.75, category = 'drinks',     image = 'whiskey.png',         prop = 's_inv_whiskey01x',       shelf = { coords = vector3(-1790.707275390625, -383.647705078125, 160.11520385742188), heading = 100.0}   },
            { item = 'gin',               stock = 6,  price = 3.00, category = 'drinks',     image = 'gin.png',             prop = 's_inv_gin01x',           shelf = { coords = vector3(-1790.2027587890625, -383.9989318847656, 160.11895751953125), heading = 100.0} },
            { item = 'horse_brush',       stock = 5,  price = 2.50, category = 'gear',       image = 'horse_brush.png',     prop = 'p_brushhorse01x'                                                                                                                   },
            { item = 'horse_lantern',     stock = 4,  price = 4.00, category = 'gear',       image = 'horse_lantern.png',   prop = 'mp005_p_horselantern01'                                                                                                            },
            { item = 'bandage',           stock = 15, price = 1.80, category = 'medical',    image = 'bandage.png',         prop = 'p_cs_bandage01x',                                                                                                                  },
            { item = 'fieldbandage',      stock = 20, price = 0.90, category = 'medical',    image = 'fieldbandage.png',    prop = 'p_cs_bandage01x',                                                                                                                  },
        }, 
    },

    ['blackwater_general'] = {
        label = 'General Store — Blackwater',
        moneyType = Config.DefaultMoneyType,
        blip = {
            enabled = true,
            name = 'General Store',
            sprite = Config.BlipSprite,
            scale = 0.2,
            style = 1664425300,
        },
        npc = {
            model = 'u_m_o_blwgeneralstoreowner_01',
            coords = vector4(-784.8836059570312, -1322.133544921875, 43.88413619995117,-165.7797393798828),
        },
        cashRegister = vector4(-785.3272094726562, -1323.0341796875, 43.93404388427734, 180),
        cameras = {
            catalog = {
                coords  = vector3(-783.98, -1323.64, 45.16),
                heading = 24.56,
                pitch   = -40.85,
                fov     = 42.5,
                easeIn  = 950,
                easeOut = 700,
            },
        },
        displayCase = {
            weapon = {
                coords   = vector3(-784.7109985351562, -1322.9580078125, 43.97000122070312),
                rotation = { x = 90.0, y = 0.0, z = 20.0 },
            },
            object = {
                coords   = vector3(-784.7109985351562, -1322.9580078125, 43.97000122070312),
                rotation = { x = 0.0, y = 0.0, z = 20.0 },
            },
        },
        categories = {
            { id = 'provisions', label = 'Provisions' },
            { id = 'drinks',     label = 'Drinks'     },
            { id = 'gear',       label = 'Gear'       },
            { id = 'medical',    label = 'Medical'    },
        },
        items = {
            { item = 'bread',             stock = 30, price = 0.40, category = 'provisions', image = 'bread.png',           prop = 'p_bread01x'                                                                                                                         },
            { item = 'biscuits',          stock = 25, price = 0.50, category = 'provisions', image = 'biscuits.png',        prop = 's_biscuits01x',       shelf = { coords = vector3(-780.4291381835938, -1320.859130859375, 44.8392448425293), heading = 59.0 }        },
            { item = 'oatcakes',          stock = 20, price = 0.60, category = 'provisions', image = 'oatcakes.png',        prop = 's_oatcakes01x',       shelf = { coords = vector3(-784.2987060546875, -1324.8084716796875, 43.53114318847656), heading = 59.0 }      },
            { item = 'chocolatebar',      stock = 15, price = 0.55, category = 'provisions', image = 'chocolatebar.png',    prop = 's_chocolatebar01x',   shelf = { coords = vector3(-789.6068115234375, -1321.26611328125, 43.69255828857422), heading = 59.0 }        },
            { item = 'cheesewedge',       stock = 15, price = 0.80, category = 'provisions', image = 'cheesewedge.png',     prop = 's_cheesewedge1x',     shelf = { coords = vector3(-781.8251342773438, -1323.1756591796875, 43.95021057128906), heading = 59.0 }      },
            { item = 'salted_beef',       stock = 20, price = 1.00, category = 'provisions', image = 'salted_beef.png',     prop = 's_saltedbeef01x',     shelf = { coords = vector3(-782.93212890625, -1323.1781005859375, 43.94779205322265), heading = 59.0 }        },
            { item = 'salted_venison',    stock = 18, price = 1.05, category = 'provisions', image = 'salted_venison.png',  prop = 's_wrappedvenison01x', shelf = { coords = vector3(-782.5777587890625, -1323.193115234375, 43.95000839233398), heading = 59.0 }       },
            { item = 'canstrawberries',   stock = 22, price = 0.90, category = 'provisions', image = 'canstrawberries.png', prop = 's_canstrawberries01x'                                                                                                               },
            { item = 'canpineapple',      stock = 22, price = 0.90, category = 'provisions', image = 'canpineapple.png',    prop = 's_canpineapple01x'                                                                                                                  },
            { item = 'cornedbeef',        stock = 18, price = 1.15, category = 'provisions', image = 'cornedbeef.png',      prop = 's_cornedbeef01x',     shelf = { coords = vector3(-780.4402465820312, -1320.85302734375, 44.39045333862305), heading = 59.0 }        },
            { item = 'canpeas',           stock = 25, price = 0.60, category = 'provisions', image = 'canpeas.png',         prop = 's_canpeas01x',        shelf = { coords = vector3(-778.6030883789062, -1320.856201171875, 44.39001846313476), heading = 59.0 }       },
            { item = 'cancorn',           stock = 25, price = 0.60, category = 'provisions', image = 'cancorn.png',         prop = 's_cancorn01x'                                                                                                                       },
            { item = 'canpeaches',        stock = 22, price = 0.85, category = 'provisions', image = 'canpeaches.png',      prop = 's_canpeaches01x',     shelf = { coords = vector3(-779.6205444335938, -1320.859375, 44.38985061645508), heading = 59.0 }             },
            { item = 'canbeans',          stock = 22, price = 0.70, category = 'provisions', image = 'canbeans.png',        prop = 's_canbeans01x'                                                                                                                      },
            { item = 'tobacco',           stock = 20, price = 0.45, category = 'provisions', image = 'tobacco.png',         prop = 's_inv_tabacco01x',    shelf = { coords = vector3(-779.8704833984375, -1320.987548828125, 43.94317626953125), heading = 59.0 }       },
            { item = 'cigarette',         stock = 25, price = 0.35, category = 'provisions', image = 'cigarette.png',       prop = 'p_cigarettebox01x',   shelf = { coords = vector3(-780.7514038085938, -1321.024658203125, 43.94252395629883), heading = 59.0 }       },
            { item = 'cigar',             stock = 10, price = 0.75, category = 'provisions', image = 'cigar.png',           prop = 'p_cigar02x',          shelf = { coords = vector3(-781.3885498046875, -1320.8988037109375, 43.99760437011719), heading = 59.0 }      },
            { item = 'water',             stock = 40, price = 0.30, category = 'drinks',     image = 'water.png',           prop = 'p_water01x'                                                                                                                         },
            { item = 'coffee',            stock = 20, price = 0.65, category = 'drinks',     image = 'coffee.png',          prop = 's_coffeetin01x',      shelf = { coords = vector3(-779.0169067382812, -1320.998291015625, 43.94161224365234), heading = 59.0 }       },
            { item = 'brandy',            stock = 8,  price = 2.75, category = 'drinks',     image = 'brandy.png',          prop = 's_brandy01x',         shelf = { coords = vector3(-788.5007934570312, -1327.4725341796875, 44.38610076904297), heading = 59.0 }      },
            { item = 'rum',               stock = 8,  price = 2.75, category = 'drinks',     image = 'rum.png',             prop = 's_inv_rum01x',        shelf = { coords = vector3(-787.8048706054688, -1327.4857177734375, 44.38802337646484), heading = 59.0 }      },
            { item = 'whiskey',           stock = 6,  price = 2.75, category = 'drinks',     image = 'whiskey.png',         prop = 's_inv_whiskey01x',    shelf = { coords = vector3(-788.0582275390625, -1327.35888671875, 43.93468856811523), heading = 100.0 }       },
            { item = 'gin',               stock = 6,  price = 3.00, category = 'drinks',     image = 'gin.png',             prop = 's_inv_gin01x',        shelf = { coords = vector3(-788.6304321289062, -1327.3475341796875, 43.93499755859375), heading = 100.0}      },
            { item = 'horse_brush',       stock = 5,  price = 2.50, category = 'gear',       image = 'horse_brush.png',     prop = 'p_brushhorse01x'                                                                                                                    },
            { item = 'horse_lantern',     stock = 4,  price = 4.00, category = 'gear',       image = 'horse_lantern.png',   prop = 'mp005_p_horselantern01'                                                                                                             },
            { item = 'bandage',           stock = 15, price = 1.90, category = 'medical',    image = 'bandage.png',         prop = 'p_cs_bandage01x'                                                                                                                    },
            { item = 'fieldbandage',      stock = 20, price = 1.00, category = 'medical',    image = 'fieldbandage.png',    prop = 'p_cs_bandage01x'                                                                                                                    },
        },
    },

    ['rhodes_general'] = {
        label = 'General Store — Rhodes',
        moneyType = Config.DefaultMoneyType,
        blip = {
            enabled = true,
            name = 'General Store',
            sprite = Config.BlipSprite,
            scale = 0.2,
            style = 1664425300,
        },
        npc = {
            model = 'u_m_m_rhdgenstoreowner_01',
            coords = vector4(1330.282470703125, -1293.1434326171875, 77.02111053466797, 67.589111328125),
        },
        cashRegister = vector4(1329.35, -1292.95, 77.10, 67.0),
        cameras = {
            catalog = {
                coords = vector3(1328.92, -1292.72, 77.76),
                heading = -84.73,
                pitch = -40.85,
                fov = 42.5,
                easeIn = 950,
                easeOut = 700,
            },
        },
        displayCase = {
            weapon = {
                coords = vector3(1329.66845703125, -1292.5191650390625, 77.15),
                rotation = { x = 88.5, y = 0.0, z = 342.5 },
            },
            object = {
                coords = vector3(1329.66845703125, -1292.5191650390625, 77.1),
                rotation = { x = 0.0, y = 0.0, z = 345.25 },
            },
        },
        categories = {
            { id = 'provisions', label = 'Provisions' },
            { id = 'drinks', label = 'Drinks' },
            { id = 'medical', label = 'Medical' },
        },
        items = {
            { item = 'bread',             stock = 30, price = 0.40, category = 'provisions', image = 'bread.png',           prop = 'p_bread01x',             shelf = { coords = vector3(1324.7742919921875,  -1290.16845703125,   77.05799865722656), heading = 345.0 } },
            { item = 'biscuits',          stock = 25, price = 0.50, category = 'provisions', image = 'biscuits.png',        prop = 's_biscuits01x',          shelf = { coords = vector3(1325.254638671875,   -1289.191650390625,  77.05968475341797), heading = 345.0 } },
            { item = 'oatcakes',          stock = 20, price = 0.60, category = 'provisions', image = 'oatcakes.png',        prop = 's_oatcakes01x',          shelf = { coords = vector3(1323.353271484375,   -1292.90185546875,   76.46376037597656), heading = 345.0 } },
            { item = 'chocolatebar',      stock = 15, price = 0.55, category = 'provisions', image = 'chocolatebar.png',    prop = 's_chocolatebar01x',      shelf = { coords = vector3(1326.55419921875,    -1291.0914306640625, 76.8112564086914),  heading = 345.0 } },
            { item = 'cheesewedge',       stock = 15, price = 0.80, category = 'provisions', image = 'cheesewedge.png',     prop = 's_cheesewedge1x',        shelf = { coords = vector3(1330.8369140625,     -1290.5244140625,    77.06348419189453), heading = 345.0 } },
            { item = 'salted_beef',       stock = 20, price = 1.00, category = 'provisions', image = 'salted_beef.png',     prop = 's_saltedbeef01x',        shelf = { coords = vector3(1328.313232421875,   -1294.728271484375,  77.076416015625),   heading = 345.0 } },
            { item = 'salted_venison',    stock = 18, price = 1.05, category = 'provisions', image = 'salted_venison.png',  prop = 's_wrappedvenison01x',    shelf = { coords = vector3(1328.087646484375,   -1295.10302734375,   77.07843780517578), heading = 345.0 } },
            { item = 'canstrawberries',   stock = 22, price = 0.90, category = 'provisions', image = 'canstrawberries.png', prop = 's_canstrawberries01x',   shelf = { coords = vector3(1325.1292724609375,  -1289.0111083984375, 77.50662231445312), heading = 345.0 } },
            { item = 'canpineapple',      stock = 22, price = 0.90, category = 'provisions', image = 'canpineapple.png',    prop = 's_canpineapple01x',      shelf = { coords = vector3(1324.682373046875,   -1289.9864501953125, 77.50483703613281), heading = 345.0 } },
            { item = 'cornedbeef',        stock = 18, price = 1.15, category = 'provisions', image = 'cornedbeef.png',      prop = 's_cornedbeef01x',        shelf = { coords = vector3(1324.3551025390625,  -1290.6973876953125, 77.50630950927734), heading = 345.0 } },
            { item = 'canpeas',           stock = 25, price = 0.60, category = 'provisions', image = 'canpeas.png',         prop = 's_canpeas01x',           shelf = { coords = vector3(1324.3187255859375,  -1290.797607421875,  77.96521759033203), heading = 345.0 } },
            { item = 'cancorn',           stock = 25, price = 0.60, category = 'provisions', image = 'cancorn.png',         prop = 's_cancorn01x'                                                                                                                       },
            { item = 'canpeaches',        stock = 22, price = 0.85, category = 'provisions', image = 'canpeaches.png',      prop = 's_canpeaches01x'                                                                                                                    },
            { item = 'canbeans',          stock = 22, price = 0.70, category = 'provisions', image = 'canbeans.png',        prop = 's_canbeans01x'                                                                                                                      },
            { item = 'tobacco',           stock = 20, price = 0.45, category = 'provisions', image = 'tobacco.png',         prop = 's_inv_tabacco01x',       shelf = { coords = vector3(1325.0716552734375,  -1293.75927734375,   77.5125732421875),  heading = 345.0 } },
            { item = 'cigarette',         stock = 25, price = 0.35, category = 'provisions', image = 'cigarette.png',       prop = 'p_cigarettebox01x',      shelf = { coords = vector3(1325.0203857421875, -1293.6214599609375, 76.82591247558594),  heading = 345.0 } },
            { item = 'cigar',             stock = 10, price = 0.75, category = 'provisions', image = 'cigar.png',           prop = 'p_cigar02x',             shelf = { coords = vector3(1324.30322265625, -1293.3209228515625, 76.88102722167969),  heading = 345.0 }   },
            { item = 'water',             stock = 40, price = 0.30, category = 'drinks',     image = 'water.png',           prop = 'p_water01x'                                                                                                                         },
            { item = 'coffee',            stock = 20, price = 0.65, category = 'drinks',     image = 'coffee.png',          prop = 's_coffeetin01x',         shelf = { coords = vector3(1324.340087890625,   -1290.74365234375,   77.05729675292969), heading = 345.0 } },
            { item = 'brandy',            stock = 8,  price = 2.75, category = 'drinks',     image = 'brandy.png',          prop = 's_brandy01x',            shelf = { coords = vector3(1324.2796630859375,  -1293.3629150390625, 77.51220703125),    heading = 345.0 } },
            { item = 'rum',               stock = 8,  price = 2.75, category = 'drinks',     image = 'rum.png',             prop = 's_inv_rum01x',           shelf = { coords = vector3(1324.998291015625,   -1293.707763671875,  77.93729400634766), heading = 345.0 } },
            { item = 'whiskey',           stock = 6,  price = 2.75, category = 'drinks',     image = 'whiskey.png',         prop = 's_inv_whiskey01x',        shelf = { coords = vector3(1324.296630859375, -1293.375, 77.93898010253906), heading = 100.0}             },
            { item = 'gin',               stock = 6,  price = 3.00, category = 'drinks',     image = 'gin.png',             prop = 's_inv_gin01x'                                                                                                                       },
            { item = 'bandage',           stock = 15, price = 2.00, category = 'medical',    image = 'bandage.png',         prop = 'p_cs_bandage01x'                                                                                                                    },
        },
    },

    ['saintdenis_general'] = {
        label = 'General Store — Saint Denis',
        moneyType = Config.DefaultMoneyType,
        blip = {
            enabled = true,
            name = 'General Store',
            sprite = Config.BlipSprite,
            scale = 0.2,
            style = 1664425300,
        },
        npc = {
            model = 'U_M_M_NbxGeneralStoreOwner_01',
            coords = vector4(2824.862548828125, -1319.614501953125, 46.75565719604492, -37.09269332885742),
        },
        cashRegister = vector4(2825.684814453125, -1319.3792724609375, 46.81347274780273, -40.31563568115234),
        cameras = {
            catalog = {
                coords  = vector3(2825.09, -1317.75, 47.88),
                heading = 159.47,
                pitch   = -40.85,
                fov     = 42.5,
                easeIn  = 950,
                easeOut = 700,
            },
        },
        displayCase = {
            weapon = {
                coords   = vector3(2825.173828125, -1318.9588623046875, 46.84999847412109),
                rotation = { x = 90.0, y = 0.0, z = 180.0 },
            },
            object = {
                coords   = vector3(2825.173828125, -1318.9588623046875, 46.84999847412109),
                rotation = { x = 0.0, y = 0.0, z = 180.0 },
            },
        },
        categories = {
            { id = 'provisions', label = 'Provisions' },
            { id = 'drinks',     label = 'Drinks'     },
            { id = 'gear',       label = 'Gear'       },
            { id = 'medical',    label = 'Medical'    },
        },
        items = {
            { item = 'bread',             stock = 30, price = 0.45, category = 'provisions', image = 'bread.png',           prop = 'p_bread01x',           shelf = { coords = vector3(2826.0107421875, -1312.846923828125, 46.82209014892578), heading = 100.0}           },
            { item = 'biscuits',          stock = 25, price = 0.55, category = 'provisions', image = 'biscuits.png',        prop = 's_biscuits01x',        shelf = { coords = vector3(2827.9189453125, -1310.2745361328125, 47.24943923950195), heading = 100.0}          },
            { item = 'oatcakes',          stock = 20, price = 0.65, category = 'provisions', image = 'oatcakes.png',        prop = 's_oatcakes01x'                                                                                                                        },
            { item = 'chocolatebar',      stock = 15, price = 0.60, category = 'provisions', image = 'chocolatebar.png',    prop = 's_chocolatebar01x',    shelf = { coords = vector3(2828.600830078125, -1314.5772705078125, 46.80757522583008), heading = 100.0}        },
            { item = 'cheesewedge',       stock = 15, price = 0.85, category = 'provisions', image = 'cheesewedge.png',     prop = 's_cheesewedge1x',      shelf = { coords = vector3(2830.445068359375, -1317.277099609375, 46.81829833984375), heading = 100.0}         },
            { item = 'salted_beef',       stock = 20, price = 1.10, category = 'provisions', image = 'salted_beef.png',     prop = 's_saltedbeef01x'                                                                                                                      },
            { item = 'salted_venison',    stock = 18, price = 1.15, category = 'provisions', image = 'salted_venison.png',  prop = 's_wrappedvenison01x'                                                                                                                  },
            { item = 'canstrawberries',   stock = 22, price = 0.95, category = 'provisions', image = 'canstrawberries.png', prop = 's_canstrawberries01x'                                                                                                                 },
            { item = 'canpineapple',      stock = 22, price = 0.95, category = 'provisions', image = 'canpineapple.png',    prop = 's_canpineapple01x'                                                                                                                    },
            { item = 'cornedbeef',        stock = 18, price = 1.20, category = 'provisions', image = 'cornedbeef.png',      prop = 's_cornedbeef01x'                                                                                                                      },
            { item = 'canpeas',           stock = 25, price = 0.65, category = 'provisions', image = 'canpeas.png',         prop = 's_canpeas01x'                                                                                                                         },
            { item = 'cancorn',           stock = 25, price = 0.65, category = 'provisions', image = 'cancorn.png',         prop = 's_cancorn01x'                                                                                                                         },
            { item = 'canpeaches',        stock = 22, price = 0.90, category = 'provisions', image = 'canpeaches.png',      prop = 's_canpeaches01x'                                                                                                                      },
            { item = 'canbeans',          stock = 22, price = 0.75, category = 'provisions', image = 'canbeans.png',        prop = 's_canbeans01x'                                                                                                                        },
            { item = 'tobacco',           stock = 20, price = 0.50, category = 'provisions', image = 'tobacco.png',         prop = 's_inv_tabacco01x',      shelf = { coords = vector3(2834.101318359375, -1313.1461181640625, 47.27802658081055), heading = 100.0}       },
            { item = 'cigarette',         stock = 25, price = 0.40, category = 'provisions', image = 'cigarette.png',       prop = 'p_cigarettebox01x',     shelf = { coords = vector3(2832.481201171875, -1310.6209716796875, 46.805904388427735), heading = 100.0}      },
            { item = 'cigar',             stock = 10, price = 0.80, category = 'provisions', image = 'cigar.png',           prop = 'p_cigar02x',            shelf = { coords = vector3(2833.131591796875, -1311.1143798828125, 46.86280822753906), heading = 100.0}       },
            { item = 'water',             stock = 40, price = 0.35, category = 'drinks',     image = 'water.png',           prop = 'p_water01x'                                                                                                                           },
            { item = 'coffee',            stock = 20, price = 0.70, category = 'drinks',     image = 'coffee.png',          prop = 's_coffeetin01x',         shelf = { coords = vector3(2832.974365234375, -1314.5098876953125, 47.2630386352539), heading = 100.0}       }, 
            { item = 'brandy',            stock = 8,  price = 3.00, category = 'drinks',     image = 'brandy.png',          prop = 's_brandy01x',            shelf = { coords = vector3(2828.000244140625, -1320.3056640625, 47.25522232055664), heading = 100.0}         }, 
            { item = 'rum',               stock = 8,  price = 3.00, category = 'drinks',     image = 'rum.png',             prop = 's_inv_rum01x',           shelf = { coords = vector3(2827.69140625, -1320.6961669921875, 47.2577018737793), heading = 100.0}           }, 
            { item = 'whiskey',           stock = 6,  price = 3.00, category = 'drinks',     image = 'whiskey.png',         prop = 's_inv_whiskey01x',       shelf = { coords = vector3(2827.82666015625, -1320.5277099609375, 47.64651870727539), heading = 100.0}       }, 
            { item = 'gin',               stock = 6,  price = 3.25, category = 'drinks',     image = 'gin.png',             prop = 's_inv_gin01x',           shelf = { coords = vector3(2827.87890625, -1320.3447265625, 46.80566024780273), heading = 100.0}             }, 
            { item = 'horse_brush',       stock = 5,  price = 2.75, category = 'gear',       image = 'horse_brush.png',     prop = 'p_brushhorse01x'                                                                                                                      },
            { item = 'horse_lantern',     stock = 4,  price = 4.50, category = 'gear',       image = 'horse_lantern.png',   prop = 'mp005_p_horselantern01'                                                                                                               },
            { item = 'bandage',           stock = 15, price = 2.00, category = 'medical',    image = 'bandage.png',         prop = 'p_cs_bandage01x'                                                                                                                      },
            { item = 'fieldbandage',      stock = 20, price = 1.10, category = 'medical',    image = 'fieldbandage.png',    prop = 'p_cs_bandage01x'                                                                                                                      },
        },
    },

    ['armadillo_general'] = {
        label = 'General Store — Armadillo',
        moneyType = Config.DefaultMoneyType,
        blip = {
            enabled = true,
            name = 'General Store',
            sprite = Config.BlipSprite,
            scale = 0.2,
            style = 1664425300,
        },
        npc = {
            model = 'u_m_m_armgeneralstoreowner_01',
            coords = vector4(-3687.3564453125, -2623.32861328125, -13.43114852905273, -94.35264587402344),
        },
        cashRegister = vector4(-3686.52685546875, -2622.69873046875, -13.38117790222168, -90.00000762939453),
        cameras = {
            catalog = {
                coords  = vector3(-3685.57, -2622.87, -12.14),
                heading = 109.81,
                pitch   = -40.85,
                fov     = 42.5,
                easeIn  = 950,
                easeOut = 700,
            },
        },
        displayCase = {
            weapon = {
                coords   = vector3(-3686.430419921875, -2623.607421875, -13.34),
                rotation = { x = 90.0, y = 0.0, z = 184.0 },
            },
            object = {
                coords   = vector3(-3686.430419921875, -2623.607421875, -13.34),
                rotation = { x = 0.0, y = 0.0, z = 184.0 },
            },
        },
        categories = {
            { id = 'provisions', label = 'Provisions' },
            { id = 'drinks',     label = 'Drinks'     },
            { id = 'gear',       label = 'Gear'       },
            { id = 'medical',    label = 'Medical'    },
        },
        items = {
            { item = 'bread',             stock = 30, price = 0.40, category = 'provisions', image = 'bread.png',           prop = 'p_bread01x'                                                                                                                          },
            { item = 'biscuits',          stock = 25, price = 0.50, category = 'provisions', image = 'biscuits.png',        prop = 's_biscuits01x',        shelf = { coords = vector3(-3683.808349609375, -2629.64111328125, -12.9240493774414), heading = 100.0}        },
            { item = 'oatcakes',          stock = 20, price = 0.60, category = 'provisions', image = 'oatcakes.png',        prop = 's_oatcakes01x'                                                                                                                       },
            { item = 'chocolatebar',      stock = 15, price = 0.55, category = 'provisions', image = 'chocolatebar.png',    prop = 's_chocolatebar01x'                                                                                                                   },
            { item = 'cheesewedge',       stock = 15, price = 0.80, category = 'provisions', image = 'cheesewedge.png',     prop = 's_cheesewedge1x'                                                                                                                     },
            { item = 'salted_beef',       stock = 20, price = 1.00, category = 'provisions', image = 'salted_beef.png',     prop = 's_saltedbeef01x'                                                                                                                     },
            { item = 'salted_venison',    stock = 18, price = 1.05, category = 'provisions', image = 'salted_venison.png',  prop = 's_wrappedvenison01x'                                                                                                                 },
            { item = 'canstrawberries',   stock = 22, price = 0.90, category = 'provisions', image = 'canstrawberries.png', prop = 's_canstrawberries01x'                                                                                                                },
            { item = 'canpineapple',      stock = 22, price = 0.90, category = 'provisions', image = 'canpineapple.png',    prop = 's_canpineapple01x'                                                                                                                   },
            { item = 'cornedbeef',        stock = 18, price = 1.15, category = 'provisions', image = 'cornedbeef.png',      prop = 's_cornedbeef01x'                                                                                                                     },
            { item = 'canpeas',           stock = 25, price = 0.60, category = 'provisions', image = 'canpeas.png',         prop = 's_canpeas01x'                                                                                                                        },
            { item = 'cancorn',           stock = 25, price = 0.60, category = 'provisions', image = 'cancorn.png',         prop = 's_cancorn01x'                                                                                                                        },
            { item = 'canpeaches',        stock = 22, price = 0.85, category = 'provisions', image = 'canpeaches.png',      prop = 's_canpeaches01x'                                                                                                                     },
            { item = 'canbeans',          stock = 22, price = 0.70, category = 'provisions', image = 'canbeans.png',        prop = 's_canbeans01x'                                                                                                                       },
            { item = 'tobacco',           stock = 20, price = 0.45, category = 'provisions', image = 'tobacco.png',         prop = 's_inv_tabacco01x',      shelf = { coords = vector3(-3685.45068359375, -2629.648681640625, -12.92799949645996), heading = 100.0}      },
            { item = 'cigarette',         stock = 25, price = 0.35, category = 'provisions', image = 'cigarette.png',       prop = 'p_cigarettebox01x'                                                                                                                   },
            { item = 'cigar',             stock = 10, price = 0.75, category = 'provisions', image = 'cigar.png',           prop = 'p_cigar02x',            shelf = { coords = vector3(-3686.2568359375, -2629.634521484375, -12.92875480651855), heading = 100.0}       },
            { item = 'water',             stock = 40, price = 0.30, category = 'drinks',     image = 'water.png',           prop = 'p_water01x'                                                                                                                          },
            { item = 'coffee',            stock = 20, price = 0.65, category = 'drinks',     image = 'coffee.png',          prop = 's_coffeetin01x'                                                                                                                      },
            { item = 'brandy',            stock = 8,  price = 2.75, category = 'drinks',     image = 'brandy.png',          prop = 's_brandy01x'                                                                                                                         },
            { item = 'rum',               stock = 8,  price = 2.75, category = 'drinks',     image = 'rum.png',             prop = 's_inv_rum01x'                                                                                                                        },
            { item = 'whiskey',           stock = 6,  price = 2.75, category = 'drinks',     image = 'whiskey.png',         prop = 's_inv_whiskey01x',      shelf = { coords = vector3(-3684.202392578125, -2629.623291015625, -13.62776279449462), heading = 100.0}     },
            { item = 'gin',               stock = 6,  price = 3.00, category = 'drinks',     image = 'gin.png',             prop = 's_inv_gin01x'                                                                                                                        },
            { item = 'horse_brush',       stock = 5,  price = 2.50, category = 'gear',       image = 'horse_brush.png',     prop = 'p_brushhorse01x'                                                                                                                     },
            { item = 'horse_lantern',     stock = 4,  price = 4.00, category = 'gear',       image = 'horse_lantern.png',   prop = 'mp005_p_horselantern01'                                                                                                              },
            { item = 'bandage',           stock = 15, price = 1.90, category = 'medical',    image = 'bandage.png',         prop = 'p_cs_bandage01x'                                                                                                                     },
            { item = 'fieldbandage',      stock = 20, price = 1.00, category = 'medical',    image = 'fieldbandage.png',    prop = 'p_cs_bandage01x'                                                                                                                     },
        },
    },

    ['tumbleweed_general'] = {
        label = 'General Store — Tumbleweed',
        moneyType = Config.DefaultMoneyType,
        blip = {
            enabled = true,
            name = 'General Store',
            sprite = Config.BlipSprite,
            scale = 0.2,
            style = 1664425300,
        },
        npc = {
            model = 'u_f_m_tumgeneralstoreowner_01',
            coords = vector4(-5486.162109375, -2937.66650390625, -0.39977997541427, 135.66673278808594),
        },
        cashRegister = vector4(-5486.97119140625, -2937.977294921875, -0.36331415176391, 127.00000762939453),
        cameras = {
            catalog = {
                coords  = vector3(-5486.70, -2939.50, 0.74),
                heading = -33.60,
                pitch   = -40.85,
                fov     = 42.5,
                easeIn  = 950,
                easeOut = 700,
            },
        },
        displayCase = {
            weapon = {
                coords   = vector3(-5486.58203125, -2938.521484375, -0.31999999284744),
                rotation = { x = 90.0, y = 0.0, z = 0.0 },
            },
            object = {
                coords   = vector3(-5486.58203125, -2938.521484375, -0.31999999284744),
                rotation = { x = 0.0, y = 0.0, z = 0.0 },
            },
        },
        categories = {
            { id = 'provisions', label = 'Provisions' },
            { id = 'drinks',     label = 'Drinks'     },
            { id = 'gear',       label = 'Gear'       },
            { id = 'medical',    label = 'Medical'    },
        },
        items = {
            { item = 'bread',             stock = 30, price = 0.40, category = 'provisions', image = 'bread.png',           prop = 'p_bread01x'                                                                                                                          },
            { item = 'biscuits',          stock = 25, price = 0.50, category = 'provisions', image = 'biscuits.png',        prop = 's_biscuits01x'                                                                                                                       },
            { item = 'oatcakes',          stock = 20, price = 0.60, category = 'provisions', image = 'oatcakes.png',        prop = 's_oatcakes01x',        shelf = { coords = vector3(-5480.99853515625, -2935.79443359375, 0.08149981498718), heading = 100.0}          },
            { item = 'chocolatebar',      stock = 15, price = 0.55, category = 'provisions', image = 'chocolatebar.png',    prop = 's_chocolatebar01x'                                                                                                                   },
            { item = 'cheesewedge',       stock = 15, price = 0.80, category = 'provisions', image = 'cheesewedge.png',     prop = 's_cheesewedge1x'                                                                                                                     },
            { item = 'salted_beef',       stock = 20, price = 1.00, category = 'provisions', image = 'salted_beef.png',     prop = 's_saltedbeef01x',      shelf = { coords = vector3(-5486.453125, -2939.81591796875, -0.59886312484741), heading = 100.0}              },
            { item = 'salted_venison',    stock = 18, price = 1.05, category = 'provisions', image = 'salted_venison.png',  prop = 's_wrappedvenison01x',  shelf = { coords = vector3(-5486.48193359375, -2940.0869140625, -0.59886312484741), heading = 100.0}          },
            { item = 'canstrawberries',   stock = 22, price = 0.90, category = 'provisions', image = 'canstrawberries.png', prop = 's_canstrawberries01x', shelf = { coords = vector3(-5490.87939453125, -2936.804443359375, -0.34961605072021), heading = 100.0}        },
            { item = 'canpineapple',      stock = 22, price = 0.90, category = 'provisions', image = 'canpineapple.png',    prop = 's_canpineapple01x'                                                                                                                   },
            { item = 'cornedbeef',        stock = 18, price = 1.15, category = 'provisions', image = 'cornedbeef.png',      prop = 's_cornedbeef01x'                                                                                                                     },
            { item = 'canpeas',           stock = 25, price = 0.60, category = 'provisions', image = 'canpeas.png',         prop = 's_canpeas01x',         shelf = { coords = vector3(-5491.67431640625, -2937.414794921875, -0.34880709648132), heading = 100.0}        },
            { item = 'cancorn',           stock = 25, price = 0.60, category = 'provisions', image = 'cancorn.png',         prop = 's_cancorn01x',         shelf = { coords = vector3(-5491.25634765625, -2936.87353515625, 0.09905385971069), heading = 100.0}          },
            { item = 'canpeaches',        stock = 22, price = 0.85, category = 'provisions', image = 'canpeaches.png',      prop = 's_canpeaches01x'                                                                                                                     },
            { item = 'canbeans',          stock = 22, price = 0.70, category = 'provisions', image = 'canbeans.png',        prop = 's_canbeans01x'                                                                                                                       },
            { item = 'tobacco',           stock = 20, price = 0.45, category = 'provisions', image = 'tobacco.png',         prop = 's_inv_tabacco01x',      shelf = { coords = vector3(-5489.09912109375, -2935.499755859375, -0.34691905975341), heading = 100.0}       },
            { item = 'cigarette',         stock = 25, price = 0.35, category = 'provisions', image = 'cigarette.png',       prop = 'p_cigarettebox01x',     shelf = { coords = vector3(-5488.3330078125, -2934.9111328125, -0.34949803352355), heading = 100.0}          },
            { item = 'cigar',             stock = 10, price = 0.75, category = 'provisions', image = 'cigar.png',           prop = 'p_cigar02x'                                                                                                                          },
            { item = 'water',             stock = 40, price = 0.30, category = 'drinks',     image = 'water.png',           prop = 'p_water01x'                                                                                                                          },
            { item = 'coffee',            stock = 20, price = 0.65, category = 'drinks',     image = 'coffee.png',          prop = 's_coffeetin01x',         shelf = { coords = vector3(-5487.6494140625, -2934.182861328125, 0.09847092628479), heading = 100.0}        },
            { item = 'brandy',            stock = 8,  price = 2.75, category = 'drinks',     image = 'brandy.png',          prop = 's_brandy01x'                                                                                                                         },
            { item = 'rum',               stock = 8,  price = 2.75, category = 'drinks',     image = 'rum.png',             prop = 's_inv_rum01x'                                                                                                                        },
            { item = 'whiskey',           stock = 6,  price = 2.75, category = 'drinks',     image = 'whiskey.png',         prop = 's_inv_whiskey01x',      shelf = { coords = vector3(-5490.34716796875, -2936.40966796875, -0.34930109977722), heading = 100.0}        },
            { item = 'gin',               stock = 6,  price = 3.00, category = 'drinks',     image = 'gin.png',             prop = 's_inv_gin01x',          shelf = { coords = vector3(-5489.81005859375, -2936.030517578125, -0.34875607490539), heading = 100.0}       },
            { item = 'horse_brush',       stock = 5,  price = 2.50, category = 'gear',       image = 'horse_brush.png',     prop = 'p_brushhorse01x'                                                                                                                     },
            { item = 'horse_lantern',     stock = 4,  price = 4.00, category = 'gear',       image = 'horse_lantern.png',   prop = 'mp005_p_horselantern01'                                                                                                              },
            { item = 'bandage',           stock = 15, price = 1.90, category = 'medical',    image = 'bandage.png',         prop = 'p_cs_bandage01x'                                                                                                                     },
            { item = 'fieldbandage',      stock = 20, price = 1.00, category = 'medical',    image = 'fieldbandage.png',    prop = 'p_cs_bandage01x'                                                                                                                     },
        },
    },
}

Config.Locale = {
    interact_title = 'General store',
    interact_hint = '[G] Open catalog',
    shelf_buy_title = 'On the shelf',
    shelf_buy_hint = 'Hold [G] — %s ($%.2f)',
    register_rob_title = 'Cash register',
    register_rob_hint = 'Hold [G] — Rob the till',

    -- Shelf purchase notifications (all optional — defaults shown below).
    shelf_success_title   = 'Item purchased',    -- toast title on success
    shelf_fail_title      = 'Purchase failed',   -- toast title on failure
    shelf_no_money        = 'Insufficient funds.',
    shelf_inventory_full  = 'Not enough inventory space or weight.',
    shelf_not_for_sale    = 'Item not sold here.',
    shelf_unknown_item    = 'Unknown item.',
    shelf_unavailable     = 'Store unavailable.',
    shelf_pay_failed      = 'Payment failed.',
    shelf_give_failed     = 'Could not grant item — refunded.',
    shelf_fail_generic    = 'Purchase failed.',
}

Config.DisplayDragSensitivity = { yaw = 0.72, pitch = 0.72 }
--[[ w_* pickup string → WEAPON_* name for CREATE_WEAPON_OBJECT ]]
Config.WeaponModels = {}
