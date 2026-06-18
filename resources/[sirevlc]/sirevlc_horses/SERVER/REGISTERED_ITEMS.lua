
-----------------
-- REDEMRP -- 
-----------------
-------------------------------
	 -- REGISTER ITEM EXPORTS--
-------------------------------

-- SIREVLC HORSES   

-- RegisterServerEvent("kit_horse_brush"            AddEventHandler("RegisterUsableItem:kit_horse_brush"           , function(source) local _source = source TriggerEvent('redemrp:getPlayerFromId', _source, function(user)   TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "BRUSHING", "kit_horse_brush")			   	end) end) end)
-- RegisterServerEvent("consumable_carrot" 	     AddEventHandler("RegisterUsableItem:consumable_carrot" 	    , function(source) local _source = source TriggerEvent('redemrp:getPlayerFromId', _source, function(user)   TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_haycube")   	   		end) end) end)
-- RegisterServerEvent("consumable_sugarcube" 	 	 AddEventHandler("RegisterUsableItem:consumable_sugarcube" 	    , function(source) local _source = source TriggerEvent('redemrp:getPlayerFromId', _source, function(user)   TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_sugarcube")   	    end) end) end)
-- RegisterServerEvent("consumable_haycube" 	     AddEventHandler("RegisterUsableItem:consumable_haycube" 	    , function(source) local _source = source TriggerEvent('redemrp:getPlayerFromId', _source, function(user)   TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_haycube")   	   		end) end) end)
-- RegisterServerEvent("consumable_apple" 	    	 AddEventHandler("RegisterUsableItem:consumable_apple" 	        , function(source) local _source = source TriggerEvent('redemrp:getPlayerFromId', _source, function(user)   TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_apple")   		   	end) end) end)
-- RegisterServerEvent("consumable_horse_ointment"  AddEventHandler("RegisterUsableItem:consumable_horse_ointment" , function(source) local _source = source TriggerEvent('redemrp:getPlayerFromId', _source, function(user)   TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "OINTMENT", "consumable_horse_ointment")  	end) end) end)
-- RegisterServerEvent("kit_hoof_knife" 			 AddEventHandler("RegisterUsableItem:kit_hoof_knife" , function(source) local _source = source TriggerEvent('redemrp:getPlayerFromId', _source, function(user)   TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "SHOE_CLEANING", "kit_hoof_knife")  					end) end) end)
-- RegisterServerEvent("kit_lunging_rope" 			 AddEventHandler("RegisterUsableItem:kit_lunging_rope" , function(source) local _source = source TriggerEvent('redemrp:getPlayerFromId', _source, function(user)    TriggerClientEvent("SIREVLC_LUNGING_MINIGAME_START", _source, "soft") 					end) end) end)
 
-----------------
-- VORP -- 
-----------------

--local VorpCore = nil
--local VorpInv  = nil
--
--TriggerEvent("getCore", function(core)
--	VorpCore = core
--end)
--
--VorpInv = exports.vorp_inventory:vorp_inventoryApi()
-- 
---------------------------------
--	 -- REGISTER ITEM EXPORTS --
---------------------------------
--
---- SIREVLC HORSES   
-- 
--   VorpInv.RegisterUsableItem("kit_horse_brush", function(data)
--      local _source = data.source   
--      TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "BRUSHING", "kit_horse_brush")
--      VorpInv.CloseInv(data.source)
--   end)
--   
--  -- 
--    VorpInv.RegisterUsableItem("consumable_haycube", function(data)
--       local _source = data.source   
--      TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_haycube")
--       VorpInv.CloseInv(data.source)
--   end)
--   
--   --
--  VorpInv.RegisterUsableItem("consumable_sugarcube", function(data)
--       local _source = data.source   
--      TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_sugarcube")
--       VorpInv.CloseInv(data.source)
--   end)
--   
--  --
--   VorpInv.RegisterUsableItem("consumable_carrot", function(data)
--       local _source = data.source   
--      TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_carrot")
--       VorpInv.CloseInv(data.source)
--   end)
--  
--  --
--   VorpInv.RegisterUsableItem("consumable_hay", function(data)
--       local _source = data.source   
--      TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_hay")
--       VorpInv.CloseInv(data.source)
--   end)
--   
--   --
--   VorpInv.RegisterUsableItem("kit_hoof_knife", function(data)
--       local _source = data.source   
--      TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "SHOE_CLEANING", "kit_hoof_knife")
--       VorpInv.CloseInv(data.source)
--   end)  
--      --
--   VorpInv.RegisterUsableItem("consumable_horse_ointment", function(data)
--       local _source = data.source   
--      TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "OINTMENT", "consumable_horse_ointment")
--       VorpInv.CloseInv(data.source)
--   end)  
--   
--    VorpInv.RegisterUsableItem("kit_lunging_rope", function(data)
--       local _source = data.source   
--       TriggerClientEvent("SIREVLC_LUNGING_MINIGAME_START", _source, "soft")
--       VorpInv.CloseInv(data.source)
--    end) 
	
	
	
	
-----------------
-- RSG -- 
-----------------
  local prefix      		= "rsg-core"
  local RSGCore 			= exports[prefix]:GetCoreObject()
  local _source 	        = source
  local User              = RSGCore.Functions.GetPlayer(_source)
  -------------------------------
  -- REGISTER ITEM EXPORTS --
  -------------------------------
  
  -- SIREVLC HORSES   
  RSGCore.Functions.CreateUseableItem("kit_horse_brush"           , function(source, item) local _source = source local User = RSGCore.Functions.GetPlayer(_source)  TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "BRUSHING", "kit_horse_brush")			end)
  RSGCore.Functions.CreateUseableItem("consumable_carrot" 	    , function(source, item) local _source = source local User = RSGCore.Functions.GetPlayer(_source)  TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_carrot")   	    end)
  RSGCore.Functions.CreateUseableItem("consumable_sugarcube" 	 	, function(source, item) local _source = source local User = RSGCore.Functions.GetPlayer(_source)  TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_sugarcube")       end)
  RSGCore.Functions.CreateUseableItem("consumable_haycube" 	    , function(source, item) local _source = source local User = RSGCore.Functions.GetPlayer(_source)  TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_haycube")   	    end)
  RSGCore.Functions.CreateUseableItem("consumable_apple" 	    	, function(source, item) local _source = source local User = RSGCore.Functions.GetPlayer(_source)  TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", "consumable_apple")   		end)
  RSGCore.Functions.CreateUseableItem("consumable_horse_ointment" , function(source, item) local _source = source local User = RSGCore.Functions.GetPlayer(_source)  TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "OINTMENT", "consumable_horse_ointment") end)
  RSGCore.Functions.CreateUseableItem("kit_hoof_knife", 			  function(source, item) local _source = source local User = RSGCore.Functions.GetPlayer(_source)  TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "SHOE_CLEANING", "kit_hoof_knife") end)
  RSGCore.Functions.CreateUseableItem("kit_lunging_rope", 		  function(source, item) local _source = source local User = RSGCore.Functions.GetPlayer(_source)  TriggerClientEvent("SIREVLC_LUNGING_MINIGAME_START", _source, "soft") end)
 