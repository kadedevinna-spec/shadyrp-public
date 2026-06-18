--
--  FX-Accessories | config_items.lua
--  Define all attachable props here.
--
--  ACCADMIN PANEL
--  ─────────────────────────────────────────────────────────
--  The calibration panel allows you to position and rotate props visually
--  in real-time without editing any files manually.
--
--  ACCESS
--    • Server admins  — always have access via the in-game radial menu.
--    • Any player     — admins can open the panel for them once using: /giveadminpanel [serverid]
--    • Editors        — grant permanent self-access by giving the ACE permission defined in Config.AllowedAccAdmin (default: "acceditor"). Editors can then open the panel themselves from the radial menu and calibrate items independently, then send you the output.
--
--  OUTPUT
--    • A ready-to-paste Config.Items entry for this file.
--    • A framework-compatible item registration block (VORP / RSG).

--
--  REQUIRED FIELDS
--  ─────────────────────────────────────────────────────────
--  Label    (string)  Display name shown in the menu.
--  Gender   (string)  "male" | "female" | "all"
--  Category (string)  "Head" | "Neck"   | "Hand" | "Torso" | "Leg" | "Arm" | "Belt"
--  Model    (hash)    Prop model hash.  Example: `p_hat_band_003`
--  Anim     (string)  Animation key played on equip.
--  Attach   (table)   Per-gender bone offsets (see format below).
--
--  ATTACH FORMAT
--  ─────────────────────────────────────────────────────────
--  Male / Female = {
--      BoneID              Skeleton bone the prop attaches to.
--      PX, PY, PZ          Position offset in metres.
--      Pitch, Roll, Yaw    Rotation offset in degrees.
--      fixedRot            true = world-fixed rotation | false = bone-relative.
--  }
--
--  OPTIONAL FIELDS
--  ─────────────────────────────────────────────────────────
--  AttachDelay   (number)  Seconds before prop appears after equip animation starts.
--  AnimCut       (number)  Stops the equip animation at this timestamp (seconds). Prop stays attached.
--  AnimBlacklist (table)   Hides prop locally while listed animations are playing.
--                         Example: { {"mp_ped_arrest", "idle"} }
--



-- ATTACHMENT SETTINGS
-- Per-category attach limits. nil / missing key = no category cap.
-- Example: Head = 1 prevents equipping 2 hats at the same time.

Config.MaxAttachedLimit = 10
Config.CategoryLimits = {
    -- Head  = 6,
    -- Neck  = 6,
    -- Hand  = 1,
    -- Belt  = 6,
    -- Torso = 6,
    -- Leg   = 6,
    -- Arm   = 6,
}

Config.BoneCheck   = true  -- true: two items cannot share the same bone | false: disable bone check (not recommended — may cause visual glitches on attach)
Config.RequireItem = false -- true: item must be in inventory to attach  | false: attach without inventory requirement

Config.Items = {

    --  ALL GENDER ITEMS  (Gender = "all")
    

    -- • HEAD |
    ----------
    ["skullmaskred"] = {
        Label    = "Skull Mask Red",
        Gender   = "all",
        Category = "Head",
        Model    = `mp005_p_mp_predhunt_skull02x`,
        AttachDelay = 3.14,
        Attach   = {
            Female = { BoneID = 21030, BoneName = "skel_head", PX = 0.0700, PY = 0.0350, PZ = 0.0050, Pitch = -145.0000, Roll = -87.5000, Yaw = -26.0000, fixedRot = true, Anim = "equip_neck" },
            Male   = { BoneID = 21030, BoneName = "skel_head", PX = 0.0700, PY = 0.0350, PZ = 0.0050, Pitch = -145.0000, Roll = -87.5000, Yaw = -26.0000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    ["skullmaskmarked"] = {
        Label    = "Skull Mask Marked",
        Gender   = "all",
        Category = "Head",
        Model    = `mp005_p_mp_predhunt_skull03x`,
        AttachDelay = 3.18,
        Attach   = {
            Female = { BoneID = 21030, BoneName = "skel_head", PX = 0.0800, PY = 0.0350, PZ = 0.0050, Pitch = -145.0000, Roll = -89.0000, Yaw = -24.0000, fixedRot = true, Anim = "equip_neck" },
            Male   = { BoneID = 21030, BoneName = "skel_head", PX = 0.0800, PY = 0.0350, PZ = 0.0050, Pitch = -145.0000, Roll = -89.0000, Yaw = -24.0000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    ["skullmaskgreen"] = {
        Label    = "Skull Mask Green",
        Gender   = "all",
        Category = "Head",
        Model    = `mp005_p_mp_predhunt_skull09x`,
        AttachDelay = 3.25,
        Attach   = {
            Female = { BoneID = 21030, BoneName = "skel_head", PX = 0.1000, PY = 0.0050, PZ = 0.0000, Pitch = -158.5000, Roll = -95.0000, Yaw = -30.5000, fixedRot = true, Anim = "equip_neck" },
            Male   = { BoneID = 21030, BoneName = "skel_head", PX = 0.1000, PY = 0.0350, PZ = 0.0000, Pitch = -158.5000, Roll = -95.0000, Yaw = -30.5000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    -- • ARM |
    ----------
    ["largebraidedbag"] = {
        Label    = "Large Braided Bag",
        Gender   = "all",
        Category = "Arm",
        Model    = `s_hoseahuntingbag01x`,
        Attach   = {
            Female = { BoneID = 14284, BoneName = "SKEL_Neck1", PX = -0.7850, PY = 0.3900, PZ = 0.0950, Pitch = -76.5000, Roll = -22.5000, Yaw = -116.0000, fixedRot = true, Anim = "shoulder_carry" },
            Male   = { BoneID = 14284, BoneName = "SKEL_Neck1", PX = -0.7300, PY = 0.3050, PZ = 0.0900, Pitch = -76.5000, Roll = 1.0000, Yaw = -116.0000, fixedRot = true, Anim = "shoulder_carry" },
        }
    },
    ["brownsmallbag"] = {
        Label    = "Brown Small Bag",
        Gender   = "all",
        Category = "Arm",
        Model    = `p_cs_baglevin01x`,
        Attach   = {
            Male   = { BoneID = 30226, BoneName = "SKEL_L_Clavicle", PX = 0.1500, PY = 0.0100, PZ = -0.0900, Pitch = 173.5000, Roll = 6.5000, Yaw = -68.5000, fixedRot = true, Anim = "forearm_carry" },
            Female = { BoneID = 30226, BoneName = "SKEL_L_Clavicle", PX = 0.1250, PY = 0.0150, PZ = -0.0600, Pitch = 173.5000, Roll = 6.5000, Yaw = -77.0000, fixedRot = true, Anim = "forearm_carry" },
        }
    },
    -- • TORSO |
    ----------
    ["babystroller"] = {
        Label    = "Baby Stroller",
        Gender   = "all",
        Category = "Torso",
        Model    = `p_babystroller`,
        Attach   = {
            Male   = { BoneID = 14413, BoneName = "SKEL_Spine3", PX = -0.6250, PY = 0.7050, PZ = 0.0050, Pitch = 6.0000, Roll = 448.5000, Yaw = 21.5000, fixedRot = true, Anim = "flag_raise_hold" },
            Female = { BoneID = 14413, BoneName = "SKEL_Spine3", PX = -0.5450, PY = 0.7800, PZ = 0.0100, Pitch = 3.0000, Roll = 451.0000, Yaw = 13.5000, fixedRot = true, Anim = "flag_raise_hold" },
        }
    },
    ["babydoll"] = {
        Label    = "Baby Doll",
        Gender   = "all",
        Category = "Torso",
        Model    = `prop_stuntdoll_01`,
        Attach   = {
            Female = { BoneID = 14413, BoneName = "SKEL_Spine3", PX = 0.0050, PY = 0.1500, PZ = -0.0100, Pitch = -16.0000, Roll = -2.5000, Yaw = -65.0000, fixedRot = true, Anim = "baby_hold_cradle" },
            Male   = { BoneID = 14413, BoneName = "SKEL_Spine3", PX = 0.0000, PY = 0.1500, PZ = 0.0800, Pitch = -13.0000, Roll = -4.5000, Yaw = -68.5000, fixedRot = true, Anim = "baby_hold_cradle" },
        }
    },
    -- • HAND |
    ----------
    ["marriageproposal"] = {
        Label    = "Marriage Proposal Ring",
        Gender   = "all",
        Category = "Hand",
        Model    = `s_inv_ring_box`,
        AttachDelay = 2.62,
        Attach   = {
            Female = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0400, PY = -0.0100, PZ = 0.0250, Pitch = -2.0000, Roll = 82.0000, Yaw = 96.5000, fixedRot = true, Anim = "proposal_step" },
            Male   = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0550, PY = -0.0100, PZ = 0.0250, Pitch = -2.0000, Roll = 82.0000, Yaw = 96.5000, fixedRot = true, Anim = "proposal_step" },
        }
    },
    ["valentineitem"] = {
        Label    = "Valentine's Day Ring",
        Gender   = "all",
        Category = "Hand",
        Model    = `s_maryrubyring01x`,
        AttachDelay = 2.62,
        Attach   = {
            Female = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0400, PY = -0.0100, PZ = 0.0250, Pitch = -2.0000, Roll = 82.0000, Yaw = 96.5000, fixedRot = true, Anim = "proposal_step" },
            Male   = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0550, PY = -0.0100, PZ = 0.0250, Pitch = -2.0000, Roll = 82.0000, Yaw = 96.5000, fixedRot = true, Anim = "proposal_step" },
        }
    },
    ["goldenring"] = {
        Label    = "Golden Ring (R)",
        Gender   = "all",
        Category = "Hand",
        Model    = `s_inv_ring02x`,
        AttachDelay = 1.68,
        AnimCut     = 3.81,
        Attach   = {
            Male   = { BoneID = 16780, BoneName = "SKEL_R_Finger31", PX = 0.0200, PY = 0.0050, PZ = 0.0000, Pitch = 0.0000, Roll = 90.0000, Yaw = 0.0000, fixedRot = true, Anim = "card_rotate" },
            Female = { BoneID = 16780, BoneName = "SKEL_R_Finger31", PX = 0.0200, PY = 0.0000, PZ = 0.0000, Pitch = 0.0000, Roll = 90.0000, Yaw = 0.0000, fixedRot = true, Anim = "card_rotate" },
        }
    },
    ["redstonering"] = {
        Label    = "Red Stone Ring (L)",
        Gender   = "all",
        Category = "Hand",
        Model    = `s_inv_ring04x`,
        AttachDelay = 1.20,
        AnimCut     = 2.57,
        Attach   = {
            Male   = { BoneID = 41356, BoneName = "SKEL_L_Finger31", PX = 0.0200, PY = 0.0000, PZ = 0.0090, Pitch = 0.0000, Roll = 90.0000, Yaw = 0.0000, fixedRot = true, Anim = "card_rotate" },
            Female = { BoneID = 41356, BoneName = "SKEL_L_Finger31", PX = 0.0200, PY = 0.0000, PZ = 0.0090, Pitch = 0.0000, Roll = 90.0000, Yaw = 0.0000, fixedRot = true, Anim = "card_rotate" },
        }
    },
    ["whiteflag"] = {
        Label    = "White Flag",
        Gender   = "all",
        Category = "Hand",
        Model    = `mp006_s_surrender_emote01x`,
        Attach   = {
            Male   = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0300, PY = -0.0300, PZ = -0.0250, Pitch = 9.5000, Roll = -40.5000, Yaw = -159.5000, fixedRot = true, Anim = "cat_carry_hand" },
            Female = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0500, PY = -0.1150, PZ = 0.0000, Pitch = -112.5000, Roll = 101.5000, Yaw = 85.0000, fixedRot = true, Anim = "cat_carry_hand" },
        }
    },
    ["redwineglass"] = {
        Label    = "Red Wine Glass",
        Gender   = "all",
        Category = "Hand",
        Model    = `s_wineglass01x_red`,
        Attach   = {
            Male   = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0250, PY = -0.0450, PZ = -0.0250, Pitch = -96.5000, Roll = 6.0000, Yaw = 14.5000, fixedRot = true, Anim = "cat_carry_hand" },
            Female = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0150, PY = -0.0400, PZ = 0.0200, Pitch = -146.5000, Roll = 9.0000, Yaw = -8.5000, fixedRot = true, Anim = "forearm_carry" },
        }
    },
    ["photomachine"] = {
        Label    = "Photo Machine",
        Gender   = "all",
        Category = "Hand",
        Model    = `mp007_p_advancedcamera01x`,
        Attach   = {
            Female = { BoneID = 16828, BoneName = "SKEL_R_Finger01", PX = 0.0050, PY = 0.0050, PZ = 0.0100, Pitch = -17.0000, Roll = 23.5000, Yaw = 70.0000, fixedRot = true, Anim = "flag_raise" },
            Male   = { BoneID = 16828, BoneName = "SKEL_R_Finger01", PX = 0.0050, PY = 0.0050, PZ = 0.0000, Pitch = -12.5000, Roll = 27.0000, Yaw = 68.5000, fixedRot = true, Anim = "flag_raise_hold" },
        }
    },
    ["leatherhandbag"] = {
        Label    = "Leather Handbag",
        Gender   = "all",
        Category = "Hand",
        Model    = `p_cs_baganders01x`,
        Attach   = {
            Male   = { BoneID = 34606, BoneName = "skel_l_hand", PX = 0.2500, PY = -0.0600, PZ = 0.3000, Pitch = -31.0000, Roll = 190.0000, Yaw = 50.0000, fixedRot = true, Anim = "bag_carry" },
            Female = { BoneID = 34606, BoneName = "skel_l_hand", PX = 0.2500, PY = -0.0600, PZ = 0.3000, Pitch = -31.0000, Roll = 190.0000, Yaw = 50.0000, fixedRot = true, Anim = "bag_carry" },
        }
    },
    ["moneybag"] = {
        Label    = "Money Bag",
        Gender   = "all",
        Category = "Hand",
        Model    = `p_depositbag01x`,
        Attach   = {
            Male   = { BoneID = 34606, BoneName = "skel_l_hand", PX = 0.3300, PY = 0.0000, PZ = 0.4300, Pitch = -32.0000, Roll = 189.0000, Yaw = 70.0000, fixedRot = true, Anim = "bag_carry" },
            Female = { BoneID = 34606, BoneName = "skel_l_hand", PX = 0.3300, PY = -0.0800, PZ = 0.4400, Pitch = -31.5000, Roll = 184.5000, Yaw = 70.0000, fixedRot = true, Anim = "bag_carry" },
        }
    },
    ["goldenbracelett"] = {
        Label    = "Golden Bracelet",
        Gender   = "all",
        Category = "Hand",
        Model    = `s_tal_goldbracelet01x`,
        AttachDelay = 5.88,
        AnimCut     = 6.43,
        Attach   = {
            Female = { BoneID = 34606, BoneName = "skel_l_hand", PX = -0.0050, PY = 0.0000, PZ = 0.0000, Pitch = 92.0000, Roll = -5.5000, Yaw = -80.5000, fixedRot = true, Anim = "wrist_idle" },
            Male   = { BoneID = 34606, BoneName = "skel_l_hand", PX = -0.0050, PY = 0.0000, PZ = 0.0000, Pitch = 92.0000, Roll = -5.5000, Yaw = -80.5000, fixedRot = true, Anim = "wrist_idle" },
        }
    },
    ["brose"] = {
        Label    = "Red Rose",
        Gender   = "all",
        Category = "Hand",
        Model    = `p_cs_flowers01x`,
        Anim     = "hold_pose",
        Attach   = {
            Male   = { BoneID = 34606, PX = 0.1, PY = 0.02, PZ = 0.05, Pitch = -100.0, Roll = -5.0, Yaw = -20.0, fixedRot = true },
            Female = { BoneID = 34606, PX = 0.1, PY = 0.02, PZ = 0.05, Pitch = -100.0, Roll = -5.0, Yaw = -20.0, fixedRot = true },
        }
    },
    ["candelabrum"] = {
        Label    = "Candelabrum",
        Gender   = "all",
        Category = "Hand",
        Model    = `p_candlebot01x`,
        Attach   = {
            Female = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0200, PY = -0.1750, PZ = 0.0050, Pitch = -107.5000, Roll = 0.0000, Yaw = 0.0000, fixedRot = true, Anim = "hawk_bottle_hold" },
            Male   = { BoneID = 41404, BoneName = "SKEL_L_Finger01", PX = 0.0200, PY = -0.1750, PZ = 0.0050, Pitch = -107.5000, Roll = 0.0000, Yaw = 0.0000, fixedRot = true, Anim = "hawk_bottle_hold" },
        }
    },
    -- • BELT |
    ----------
    ["hornaccessorybelt"] = {
        Label    = "Horn Belt Accessory",
        Gender   = "all",
        Category = "Belt",
        Model    = `p_cs_baglevin01x`,
        Attach   = {
            Male   = { BoneID = 14410, BoneName = "SKEL_Spine0", PX = 0.0350, PY = -0.0150, PZ = -0.1800, Pitch = -100.5000, Roll = 175.5000, Yaw = -106.0000, fixedRot = true, Anim = "belt_draw" },
            Female = { BoneID = 14410, BoneName = "SKEL_Spine0", PX = 0.0350, PY = 0.0600, PZ = -0.1650, Pitch = 80.5000, Roll = -10.0000, Yaw = 94.0000, fixedRot = true, Anim = "belt_draw" },
        }
    },


    --  FEMALE ITEMS
    

    -- • NECK |
    ----------
    ["bluebrooch"] = {
        Label    = "Blue Brooch",
        Gender   = "female",
        Category = "Neck",
        Model    = `p_corpsenecklace01x`,
        AttachDelay = 3.25,
        Attach   = {
            Female  = { BoneID = 14285, BoneName = "SKEL_Neck2", PX = -0.0550, PY = 0.0800, PZ = 0.0000, Pitch = 20.0000, Roll = 90.5000, Yaw = 4.5000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    ["jewelaryneck"] = {
        Label    = "Silver Necklace",
        Gender   = "female",
        Category = "Neck",
        Model    = `s_inv_necklace01x`,
        AttachDelay = 3.38,
        Attach   = {
            Female = { BoneID = 14284, BoneName = "SKEL_Neck1", PX = -0.0400, PY = 0.1200, PZ = 0.0000, Pitch = 136.0000, Roll = -90.0000, Yaw = 20.0000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    ["redstonenecklace"] = {
        Label    = "Red Stone Necklace",
        Gender   = "female",
        Category = "Neck",
        Model    = `s_inv_necklace02x`,
        AttachDelay = 3.13,
        Attach   = {
            Female = { BoneID = 14285, BoneName = "SKEL_Neck2", PX = -0.1000, PY = 0.1100, PZ = 0.0000, Pitch = 140.0000, Roll = -90.0000, Yaw = 25.0000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    ["pearlnecklace"] = {
        Label    = "Pearl Necklace",
        Gender   = "female",
        Category = "Neck",
        Model    = `s_inv_necklace03x`,
        AttachDelay = 3.18,
        Attach   = {
            Female = { BoneID = 14285, BoneName = "SKEL_Neck2", PX = -0.1200, PY = 0.1300, PZ = 0.0000, Pitch = 79.0000, Roll = -90.0000, Yaw = 85.0000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    -- • HEAD |
    ----------
    ["pearlcrowns"] = {
        Label    = "Pearl Crown",
        Gender   = "female",
        Category = "Head",
        Model    = `s_inv_necklace03x`,
        AttachDelay = 2.77,
        Attach   = {
            Female = { BoneID = 53174, PX = -0.0100, PY = -0.0200, PZ = 0.0000, Pitch = 3.5000, Roll = 178.0000, Yaw = 0.0000, fixedRot = true, Anim = "hat_equip" },
        }
    },
    ["pearlearring"] = {
        Label    = "Pearl Earring (L)",
        Gender   = "female",
        Category = "Head",
        Model    = `s_inv_earring01x`,
        AttachDelay = 1.05,
        Attach   = {
            Female = { BoneID = 21030, BoneName = "skel_head", PX = 0.0100, PY = 0.0000, PZ = 0.0600, Pitch = -10.0000, Roll = 0.0000, Yaw = 75.0000, fixedRot = true, Anim = "neck_both_hands" },
        }
    },
    ["greenarring"] = {
        Label    = "Green Earring (R)",
        Gender   = "female",
        Category = "Head",
        Model    = `s_inv_earring02x`,
        AttachDelay = 1.64,
        Attach   = {
            Female = { BoneID = 21030, BoneName = "skel_head", PX = 0.0000, PY = -0.0100, PZ = -0.0700, Pitch = 0.0000, Roll = 0.0000, Yaw = 77.0000, fixedRot = true, Anim = "neck_both_hands" },
        }
    },
    -- • HAND |
    ----------
    ["weddingringf"] = {
        Label    = "Wedding Ring (R)",
        Gender   = "female",
        Category = "Hand",
        Model    = `s_inv_ring01x`,
        AttachDelay = 1.53,
        AnimCut     = 4.16,
        Attach   = {
            Female = { BoneID = 16780, BoneName = "SKEL_R_Finger31", PX = 0.0100, PY = 0.0000, PZ = 0.0100, Pitch = 270.0000, Roll = 77.0000, Yaw = -80.0000, fixedRot = true, Anim = "card_rotate" },
        }
    },
    ["yellowparasol"] = {
        Label    = "Yellow Parasol",
        Gender   = "female",
        Category = "Hand",
        Model    = `mp004_p_parasol04x`,
        Attach   = {
            Female = { BoneID = 22798, BoneName = "skel_r_hand", PX = 0.0700, PY = -0.0150, PZ = -0.0350, Pitch = 280.0000, Roll = 38.0000, Yaw = 4.0000, fixedRot = true, Anim = "parasol_hold" },
        }
    },
    ["featherbracelet"] = {
        Label    = "Feather Bracelet",
        Gender   = "female",
        Category = "Hand",
        Model    = `p_cs_owlfeathertrinket`,
        AttachDelay = 3.30,
        AnimCut     = 5.03,
        Attach   = {
            Female = { BoneID = 34606, BoneName = "skel_l_hand", PX = 0.0000, PY = 0.0000, PZ = -0.0200, Pitch = 55.0000, Roll = 0.0000, Yaw = 90.0000, fixedRot = true, Anim = "bracelet_touch" },
        }
    },
    ["mirrorhand"] = {
        Label    = "Pocket Mirror",
        Gender   = "female",
        Category = "Hand",
        Model    = `p_handheldmirror01x`,
        Attach   = {
            Female = { BoneID = 22798, BoneName = "skel_r_hand", PX = 0.0600, PY = -0.0050, PZ = -0.0400, Pitch = 249.0000, Roll = -141.0000, Yaw = -15.0000, fixedRot = true, Anim = "hold_right_hand" },
        }
    },
    ["smallredstonering"] = {
        Label    = "Small Red Stone Ring (F)",
        Gender   = "female",
        Category = "Hand",
        Model    = `s_maryrubyring01x`,
        AttachDelay = 1.58,
        AnimCut     = 4.61,
        Attach   = {
            Female = { BoneID = 41356, BoneName = "SKEL_L_Finger31", PX = 0.0100, PY = 0.0000, PZ = 0.0000, Pitch = 204.0000, Roll = 94.0000, Yaw = -50.0000, fixedRot = true, Anim = "card_rotate" },
        }
    },
    ["floweredsuitcase"] = {
        Label    = "Flowered Suitcase (L)",
        Gender   = "female",
        Category = "Hand",
        Model    = `p_cs_bagstrauss01x`,
        Attach   = {
            Female = { BoneID = 34606, BoneName = "skel_l_hand", PX = 0.2500, PY = -0.0500, PZ = 0.3300, Pitch = -142.0000, Roll = 9.0000, Yaw = 50.0000, fixedRot = true, Anim = "carry_hold" },
        }
    },
    ["gemstonebracelet"] = {
        Label    = "Gemstone Bracelet (R)",
        Gender   = "female",
        Category = "Hand",
        Model    = `s_penelopebracelet01x`,
        AttachDelay = 1.24,
        AnimCut     = 1.71,
        Attach   = {
            Female = { BoneID = 22798, BoneName = "skel_r_hand", PX = 0.0000, PY = 0.0000, PZ = 0.0000, Pitch = 102.0000, Roll = 0.0000, Yaw = 10.0000, fixedRot = true, Anim = "bracelet_touch" },
        }
    },
    ["smallhandbag"] = {
        Label    = "Small Handbag (L)",
        Gender   = "female",
        Category = "Hand",
        Model    = `mp004_p_cs_jessicapurse01x`,
        Attach   = {
            Female = { BoneID = 53675, BoneName = "skel_l_forearm", PX = 0.0500, PY = -0.3400, PZ = 0.0500, Pitch = -97.0000, Roll = 37.0000, Yaw = -24.0000, fixedRot = true, Anim = "carry_hold_arm" },
        }
    },
    ["goldenbracelettr"] = {
        Label    = "Golden Bracelett (R)",
        Gender   = "female",
        Category = "Hand",
        Model    = `p_si_bracelet01x`,
        AttachDelay = 1.41,
        AnimCut     = 1.58,
        Attach   = {
            Female = { BoneID = 16747, BoneName = "SKEL_R_Finger10", PX = -0.0200, PY = 0.0000, PZ = 0.0200, Pitch = 90.0000, Roll = 76.0000, Yaw = -100.0000, fixedRot = true, Anim = "bracelet_touch" },
        }
    },

    --  MALE ITEMS 
    

    -- • NECK |
    ----------
    ["bearclawnecklace"] = {
        Label    = "Bear Claw Necklace (Male)",
        Gender   = "male",
        Category = "Neck",
        Model    = `s_necklacebearclaw`,
        AttachDelay = 2.94,
        Attach   = {
            Male = { BoneID = 14283, BoneName = "SKEL_Neck0", PX = 0.0700, PY = -0.0830, PZ = 0.0000, Pitch = 177.0000, Roll = -95.0000, Yaw = 13.5000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    -- • HEAD |
    ----------
    ["skullmask"] = {
        Label    = "Skull Mask",
        Gender   = "male",
        Category = "Head",
        Model    = `mp005_p_mp_predhunt_skull01x`,
        AttachDelay = 3.16,
        Attach   = {
            Male = { BoneID = 21030, BoneName = "skel_head", PX = 0.0750, PY = 0.0150, PZ = 0.0050, Pitch = -126.5000, Roll = -90.0000, Yaw = -47.5000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    ["pigmask"] = {
        Label    = "Pig Mask",
        Gender   = "male",
        Category = "Head",
        Model    = `s_mask_pig01x`,
        AttachDelay = 3.05,
        Attach   = {
            Male = { BoneID = 21030, BoneName = "skel_head", PX = 0.0750, PY = 0.0550, PZ = 0.0000, Pitch = 75.0000, Roll = -90.0000, Yaw = 45.0000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    ["ropeheadband"] = {
        Label    = "Rope Head Band",
        Gender   = "male",
        Category = "Head",
        Model    = `p_hat_band_002`,
        AttachDelay = 3.02,
        Attach   = {
            Male = { BoneID = 21030, BoneName = "skel_head", PX = 0.1100, PY = 0.0900, PZ = 0.0100, Pitch = 4.5000, Roll = 83.0000, Yaw = 85.0000, fixedRot = true, Anim = "equip_neck" },
        }
    },
    -- • BELT |
    ----------
    ["saddlebag"] = {
        Label    = "Saddle Bag",
        Gender   = "male",
        Category = "Belt",
        Model    = `p_cs_saddle_bag01x`,
        AttachDelay = 1.72,
        Attach   = {
            Male = { BoneID = 56200, BoneName = "skel_pelvis", PX = -0.0500, PY = -0.0800, PZ = -0.1300, Pitch = 70.0000, Roll = -25.0000, Yaw = -85.0000, fixedRot = true, Anim = "belt_draw" },
        }
    },
    -- • HAND |
    ----------
    ["silverring"] = {
        Label    = "Silver Ring (Male)",
        Gender   = "male",
        Category = "Hand",
        Model    = `s_inv_ring03x`,
        AttachDelay = 2.03,
        AnimCut     = 5.30,
        Attach   = {
            Male = { BoneID = 41339, BoneName = "SKEL_L_Finger40", PX = 0.0800, PY = -0.0050, PZ = 0.0100, Pitch = -6.5000, Roll = -95.0000, Yaw = 5.0000, fixedRot = true, Anim = "card_rotate" },
        }
    },
    ["brownhandbag"] = {
        Label    = "Brown Handbag",
        Gender   = "male",
        Category = "Hand",
        Model    = `p_bag01x`,
        Attach   = {
            Male = { BoneID = 34606, BoneName = "skel_l_hand", PX = 0.2150, PY = -0.0450, PZ = 0.3300, Pitch = -148.0000, Roll = 2.5000, Yaw = 58.5000, fixedRot = true, Anim = "bag_carry" },
        }
    },
    ["weddingringsilver"] = {
        Label    = "Silver Wedding Ring (Male)",
        Gender   = "male",
        Category = "Hand",
        Model    = `s_inv_ring05x`,
        AttachDelay = 1.92,
        AnimCut     = 2.81,
        Attach   = {
            Male = { BoneID = 41356, BoneName = "SKEL_L_Finger31", PX = 0.0200, PY = 0.0030, PZ = 0.0030, Pitch = 0.0000, Roll = 0.0000, Yaw = 90.0000, fixedRot = true, Anim = "card_rotate" },
        }
    },

}
