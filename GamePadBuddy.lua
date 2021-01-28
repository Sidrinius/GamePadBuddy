------------------
--LOAD LIBRARIES--
------------------


----------------------
--INITIATE VARIABLES--
----------------------

--create Addon UI table
GamePadBuddyData = {};
--define name of addon
GamePadBuddyData.name = "GamePadBuddy";
--define addon version number
GamePadBuddyData.version = 1.08;


-- Constant maps for trait researching
GamePadBuddy = {}


-- Original code by prasoc, edited by ScotteYx. Thanks for the improvement :)
local function AddInventoryPreInfo(tooltip, bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex)      
    local itemType, specializedItemType = GetItemLinkItemType(itemLink)
    
	if GamePadBuddy.curSavedVars.recipes and itemType == ITEMTYPE_RECIPE then
		if(IsItemLinkRecipeKnown(itemLink)) then
			tooltip:AddLine(GetString(SI_RECIPE_ALREADY_KNOWN))
		else
			tooltip:AddLine(GetString(SI_USE_TO_LEARN_RECIPE))
		end
	end


    if GamePadBuddy.curSavedVars.ttc and TamrielTradeCentre ~= nil then
		tooltip:AddLine(zo_strformat("|cf23d8eTTC:|r"))
		local itemInfo = TamrielTradeCentre_ItemInfo:New(itemLink)
		local priceInfo = TamrielTradeCentrePrice:GetPriceInfo(itemInfo)
    
        if (priceInfo == nil) then
			tooltip:AddLine(zo_strformat("|cf23d8e<<1>>|r", GetString(TTC_PRICE_NOLISTINGDATA)))
        else
          if (priceInfo.SuggestedPrice ~= nil) then
			tooltip:AddLine(zo_strformat("|cf23d8e<<1>>|r", string.format(GetString(TTC_PRICE_SUGGESTEDXTOY), 
              TamrielTradeCentre:FormatNumber(priceInfo.SuggestedPrice, 0), TamrielTradeCentre:FormatNumber(priceInfo.SuggestedPrice * 1.25, 0))))
          end

          if (true) then 
			tooltip:AddLine(zo_strformat("|cf23d8e<<1>>|r", string.format(GetString(TTC_PRICE_AGGREGATEPRICESXYZ), TamrielTradeCentre:FormatNumber(priceInfo.Avg), 
              TamrielTradeCentre:FormatNumber(priceInfo.Min), TamrielTradeCentre:FormatNumber(priceInfo.Max)))) 
          end

          if (true) then
            if (priceInfo.EntryCount ~= priceInfo.AmountCount) then 
				tooltip:AddLine(zo_strformat("|cf23d8e<<1>>|r", string.format(GetString(TTC_PRICE_XLISTINGSYITEMS), TamrielTradeCentre:FormatNumber(priceInfo.EntryCount), TamrielTradeCentre:FormatNumber(priceInfo.AmountCount)))) 
              tooltip:AddLine()
            else
				tooltip:AddLine(zo_strformat("|cf23d8e<<1>>|r", string.format(GetString(TTC_PRICE_XLISTINGS), TamrielTradeCentre:FormatNumber(priceInfo.EntryCount)))) 
            end
          end
        end
 
		--[[
        if GamePadBuddy.curSavedVars.recipes and itemType == ITEMTYPE_RECIPE then
		
			local resultItemLink = GetItemLinkRecipeResultItemLink(itemLink)
			local priceInfo = TamrielTradeCentrePrice:GetPriceInfo(resultItemLink)
		
		    if (priceInfo == nil) then
				tooltip:AddLine(zo_strformat("|cf23d8eProduct <<1>>|r", GetString(TTC_PRICE_NOLISTINGDATA)))
			else
			  if (priceInfo.SuggestedPrice ~= nil) then
				tooltip:AddLine(zo_strformat("|cf23d8eProduct <<1>>|r", string.format(GetString(TTC_PRICE_SUGGESTEDXTOY), 
				  TamrielTradeCentre:FormatNumber(priceInfo.SuggestedPrice, 0), TamrielTradeCentre:FormatNumber(priceInfo.SuggestedPrice * 1.25, 0))))
			  end

			  if (true) then 
				tooltip:AddLine(zo_strformat("|cf23d8eProduct <<1>>|r", string.format(GetString(TTC_PRICE_AGGREGATEPRICESXYZ), TamrielTradeCentre:FormatNumber(priceInfo.Avg), 
				  TamrielTradeCentre:FormatNumber(priceInfo.Min), TamrielTradeCentre:FormatNumber(priceInfo.Max)))) 
			  end

			  if (true) then
				if (priceInfo.EntryCount ~= priceInfo.AmountCount) then 
					tooltip:AddLine(zo_strformat("|cf23d8eProduct <<1>>|r", string.format(GetString(TTC_PRICE_XLISTINGSYITEMS), TamrielTradeCentre:FormatNumber(priceInfo.EntryCount), TamrielTradeCentre:FormatNumber(priceInfo.AmountCount)))) 
				  tooltip:AddLine()
				else
					tooltip:AddLine(zo_strformat("|cf23d8eProduct <<1>>|r", string.format(GetString(TTC_PRICE_XLISTINGS), TamrielTradeCentre:FormatNumber(priceInfo.EntryCount)))) 
				end
			  end
			end
	 
		end
		]]--
    end 
	
	if GamePadBuddy.curSavedVars.mm and MasterMerchant ~= nil then 
		--tooltip:AddLine(zo_strformat("|r"))
		tooltip:AddLine(zo_strformat("|c7171d1MM:|r"))
		local tipLine, avePrice, graphInfo = MasterMerchant:itemPriceTip(itemLink, false, false)
		if(tipLine ~= nil) then
			tooltip:AddLine(zo_strformat("|c7171d1<<1>>|r", tipLine))
		else
			tooltip:AddLine(zo_strformat("|c7171d1No listing data|r"))
		end

		local craftInfo = MasterMerchant:itemCraftPriceTip(itemLink)
		if craftInfo ~= nil then
			tooltip:AddLine(zo_strformat("|c7171d1<<1>>|r", craftInfo)) 
		end
				
		--[[
        if GamePadBuddy.curSavedVars.recipes and itemType == ITEMTYPE_RECIPE then
			local resultItemLink = GetItemLinkRecipeResultItemLink(itemLink)
			
			local tipLine, avePrice, graphInfo = MasterMerchant:itemPriceTip(resultItemLink, false, false)
			if(tipLine ~= nil) then
				tooltip:AddLine(zo_strformat("|c7171d1Product <<1>>|r", tipLine))  
			else
				tooltip:AddLine(zo_strformat("|c7171d1Product MM price (0 sales, 0 days): UNKNOWN|r")) 
			end
		end
		]]--
	end

	if GamePadBuddy.curSavedVars.att and ArkadiusTradeTools ~= nil then
		--tooltip:AddLine(zo_strformat("|r"))
		tooltip:AddLine(zo_strformat("|cf58585ATT:|r"))
		tooltip:AddLine(zo_strformat("|cf58585No listing data|r"))
		--tooltip:AddLine(zo_strformat("|r"))
	end

	--[[
	if GamePadBuddy.curSavedVars.att and ArkadiusTradeTools then 
		local priceLine, statusLine = GetATTPriceAndStatus(itemLink)
		tooltip:AddLine(zo_strformat("|cf58585ATT:|r"))
		tooltip:AddLine(zo_strformat("|cf58585<<1>>|r", priceLine))
		tooltip:AddLine(zo_strformat("|cf58585<<1>>|r", statusLine))
	end
	]]--
end

function InventoryHook(tooltip, method)
  local origMethod = tooltip[method]
  tooltip[method] = function(control, bagId, slotIndex, ...) 
    AddInventoryPreInfo(control, bagId, slotIndex, ...)
    origMethod(control, bagId, slotIndex, ...)            
  end
end

function InventoryMenuHook(tooltip, method) 
  local origMethod = tooltip[method]
  tooltip[method] = function(selectedData, ...) 
    origMethod(selectedData, ...)  
	if GamePadBuddy.curSavedVars.invtooltip and tooltip.selectedEquipSlot then
		GAMEPAD_TOOLTIPS:LayoutBagItem(GAMEPAD_LEFT_TOOLTIP, BAG_WORN, tooltip.selectedEquipSlot)
	end
	  
  end
end

local function LoadModules() 
  if(not _initialized) then
    InventoryHook(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_LEFT_TOOLTIP), "LayoutBagItem")
	InventoryMenuHook(GAMEPAD_INVENTORY, "UpdateCategoryLeftTooltip")
	
    InventoryHook(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_RIGHT_TOOLTIP), "LayoutBagItem")
    InventoryHook(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_MOVABLE_TOOLTIP), "LayoutBagItem")
  
    _initialized = true

  end
end

GamePadBuddy.defaultSettings = {
	invtooltip = true,
	att = false,
	mm = false,
	ttc = false,
	recipes = true, 
}

GamePadBuddy.defaultAcctSettings = {
	accountWideSetting = true,
	invtooltip = true,
	att = false,
	mm = false,
	ttc = false,
	recipes = true,
}

function GamePadBuddy.UpdateCurrentSavedVars()
	if not GamePadBuddy.acctSavedVariables.accountWideSetting  then
		GamePadBuddy.curSavedVars = GamePadBuddy.charSavedVariables
		--d("Use Character setting")
	else 
		GamePadBuddy.curSavedVars = GamePadBuddy.acctSavedVariables
		--d("Use Accountwide Setting")
	end
end

local function triggerAddonLoaded(eventCode, addonName)
  if  (addonName == GamePadBuddyData.name) then
    EVENT_MANAGER:UnregisterForEvent(GamePadBuddyData.name, EVENT_ADD_ON_LOADED);

  	-- load our saved variables
  	GamePadBuddy.charSavedVariables = ZO_SavedVars:New('GamePadBuddySavedVars', 1.0, nil, GamePadBuddy.defaultSettings)
  	GamePadBuddy.acctSavedVariables = ZO_SavedVars:NewAccountWide('GamePadBuddySavedVars', 1.0, nil, GamePadBuddy.defaultAcctSettings)

  	GamePadBuddy.AddonMenu.Init()
    --initExtensions()

    if(IsInGamepadPreferredMode()) then
      LoadModules()
    else
      _initialized = false
    end
  end
end

EVENT_MANAGER:RegisterForEvent(GamePadBuddyData.name, EVENT_ADD_ON_LOADED, triggerAddonLoaded);  
EVENT_MANAGER:RegisterForEvent(GamePadBuddyData.name, EVENT_GAMEPAD_PREFERRED_MODE_CHANGED, function(code, inGamepad)  LoadModules() end)