local _
local LAM2 = LibAddonMenu2

GamePadBuddy.AddonMenu = {}
local changed = false
function GamePadBuddy.AddonMenu.Init()
	GamePadBuddy.UpdateCurrentSavedVars()
	local panelData =  {
		type = "panel",
		name = "GamePadBuddy",
		displayName = "GamePadBuddy",
		author = "RockingDice",
		version = "1.08",
		slashCommand = "/gb",
		registerForRefresh = true,
		registerForDefaults = false
	}
	
	local optionsTable = {
		{
			type = "header",
			name = "|c0066FFAccount Settings|r",
			width = "full"
		},
		{
			type = "checkbox",
			name = "Account Wide Setting",
			tooltip = "Use account-wide settings instead of this character.",
			getFunc = function() return GamePadBuddy.acctSavedVariables.accountWideSetting end,
			setFunc = function(value) GamePadBuddy.acctSavedVariables.accountWideSetting = value
				GamePadBuddy.UpdateCurrentSavedVars()
				if value then
				else
				end
			end,
		},
		{
			type = "header",
			name = "|c0066FF[General Enhancement]|r",
			width = "full",
		},
		{
			type = "checkbox",
			name = "Show Wearing Gears In Inventory Menu",
			tooltip = "Add a tooltip for showing current wearing gears, in orginal gamepad ui.",
			getFunc = function() return GamePadBuddy.curSavedVars.invtooltip end,
			setFunc = function(value) GamePadBuddy.curSavedVars.invtooltip = value
			end,
		},
		{
			type = "header",
			name = "|c0066FF[Tooltips Enhancement]|r",
			width = "full",
		},
		{
			type = "checkbox",
			name = "Master Merchant",
			tooltip = "Add a tooltip for showing item info from add-on 'Master Merchant'.",
			getFunc = function() return GamePadBuddy.curSavedVars.mm end,
			setFunc = function(value) GamePadBuddy.curSavedVars.mm = value
			end,
		},
		{
			type = "checkbox",
			name = "Tamriel Trade Centre",
			tooltip = "Add a tooltip for showing item info from add-on 'Tamriel Trade Centre'.",
			getFunc = function() return GamePadBuddy.curSavedVars.ttc end,
			setFunc = function(value) GamePadBuddy.curSavedVars.ttc = value
			end,
		},
		{
			type = "checkbox",
			name = "Arkadius Trade Tools",
			tooltip = "Add a tooltip for showing item info from add-on 'Arkadius Trade Tools'.",
			getFunc = function() return GamePadBuddy.curSavedVars.att end,
			setFunc = function(value) GamePadBuddy.curSavedVars.att = value
			end,
		},
		{
			type = "checkbox",
			name = "Recipes Info",
			tooltip = "Add a tooltip for showing recipes status and related prices(need ttc or mm).",
			getFunc = function() return GamePadBuddy.curSavedVars.recipes end,
			setFunc = function(value) GamePadBuddy.curSavedVars.recipes = value
			end,
		}, 
	}
	LAM2:RegisterAddonPanel("GAMEPADBUDDY_SETTINGS", panelData)
	LAM2:RegisterOptionControls("GAMEPADBUDDY_SETTINGS", optionsTable)
end