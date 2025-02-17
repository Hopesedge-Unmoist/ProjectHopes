local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

function S:MirrorTimers() -- Mirror Timers (Underwater Breath, etc.)
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.mirrorTimers) then return end
	if not E.db.ProjectHopes.skins.mirrorTimers then return end

	hooksecurefunc(
		_G.MirrorTimerContainer,
		"SetupTimer",
		function(container, timer)
			local bar = container:GetAvailableTimer(timer)
			if not bar then
				return
			end
	
			if bar.border then
				bar.border:Hide()
				bar.border = nil
			end
	
			BORDER:CreateBorder(bar)
		end
	)
end

S:AddCallback('MirrorTimers')
