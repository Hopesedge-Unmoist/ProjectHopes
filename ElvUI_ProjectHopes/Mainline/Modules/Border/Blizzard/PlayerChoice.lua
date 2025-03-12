local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local BL = E:GetModule('Blizzard')

local _G = _G
local pairs = pairs
local hooksecurefunc = hooksecurefunc

function BORDER:PlayerChoice_SetupButtons(buttons)
	if buttons and buttons.buttonFramePool then
		for buttonFrame in buttons.buttonFramePool:EnumerateActive() do
			if not buttonFrame.IsBorder then
				BORDER:CreateBorder(buttonFrame.Button, nil, nil, nil, nil, nil, false, true)

				buttonFrame.IsBorder = true
			end
		end
	end
end

function BORDER:PlayerChoice_SetupRewards(rewards)
	if rewards and rewards.rewardsPool then
		local parchmentRemover = E.private.skins.parchmentRemoverEnable
		for reward in rewards.rewardsPool:EnumerateActive() do               
			local item = reward.itemButton
			if item then
				BORDER:CreateBorder(item)
				BORDER:HandleIconBorder(item.IconBorder, item.border)
			end
		end
	end
end

local function ReskinSpellWidget(spell)
	if spell.Icon and spell.Icon.backdrop then
		BORDER:HandleIcon(spell.Icon)
	end
end

function BORDER:PlayerChoice_SetupOptions()
	if not self.IsBorder then
		BORDER:CreateBorder(self)
		self.IsBorder = true
	end

	if self.border then
		self.border:SetShown(self.template and self.template == "Transparent")

		hooksecurefunc(
			self,
			"SetTemplate",
			function(_, template)
				self.border:SetShown(template and template == "Transparent")
			end
		)
	end

	if self.optionFrameTemplate and self.optionPools then
		for option in self.optionPools:EnumerateActiveByTemplate(self.optionFrameTemplate) do
			BORDER:PlayerChoice_SetupRewards(option.rewards)
			BORDER:PlayerChoice_SetupButtons(option.buttons)
			local container = option.WidgetContainer
			if container and container.widgetFrames then
				for _, frame in pairs(container.widgetFrames) do
					if frame.Spell then
						ReskinSpellWidget(frame.Spell)
					end
				end
			end
		end
	end
end

function S:Blizzard_PlayerChoice()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.playerChoice) then return end
	if not E.db.ProjectHopes.skins.playerChoice then return end

	if _G.GenericPlayerChoiceToggleButton then
		BORDER:CreateBorder(_G.GenericPlayerChoiceToggleButton, nil, nil, nil, nil, nil, false, true)
	end

	hooksecurefunc(_G.PlayerChoiceFrame, 'SetupOptions', BORDER.PlayerChoice_SetupOptions)
end

S:AddCallbackForAddon('Blizzard_PlayerChoice')
