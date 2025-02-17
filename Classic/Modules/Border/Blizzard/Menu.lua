local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

local borders = {}
local function SkinFrame(frame)

	if borders[frame] then
		frame.border = borders[frame] -- relink it back
	else
		BORDER:CreateBorder(frame)
		borders[frame] = frame.backdrop -- keep below CreateBackdrop
	end
end

local function OpenMenu(manager, region, menuDescription)
	local menu = manager:GetOpenMenu()
	if menu then
		-- Initial context menu
		SkinFrame(menu)
		-- SubMenus
		menuDescription:AddMenuAcquiredCallback(SkinFrame)
	end
end

function S:Blizzard_Menu()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.misc) then return end
	if not E.db.ProjectHopes.skins.misc then return end

	local manager = _G.Menu.GetManager()
	if manager then
		hooksecurefunc(manager, 'OpenMenu', OpenMenu)
		hooksecurefunc(manager, 'OpenContextMenu', OpenMenu)
	end
end

S:AddCallbackForAddon('Blizzard_Menu')
