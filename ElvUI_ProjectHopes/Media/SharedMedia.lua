local E, _, V, P, G = unpack(ElvUI)
local Name, Private = ...
local LSM = LibStub('LibSharedMedia-3.0')

if LSM == nil then return end

-- Fonts
LSM:Register('font','Expressway', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Fonts\Expressway.ttf]])
LSM:Register('font','Noto', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Fonts\NotoSans.ttf]])
LSM:Register('font','HopesUI', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Fonts\HopesUI.ttf]])

-- Statusbar Textures
LSM:Register('statusbar','HopesUI', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\HopesUI.tga]])
LSM:Register('statusbar','Health Fill', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\Grid2_HP_Fill.tga]])
LSM:Register('statusbar','Health Background', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\Grid2_HP_Background.tga]])
LSM:Register('statusbar','Blizzard Cast', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzcast.tga]])
LSM:Register('statusbar','Blizzard Cast Background', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzcastback.tga]])
LSM:Register('statusbar','Blizzard Cast Channel', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzcastchannel.tga]])
LSM:Register('statusbar','Blizzard Cast Nonbreakable', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzcastnonbreakable.tga]])
LSM:Register('statusbar','Blizzard Desat', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzdesat.tga]])
LSM:Register('statusbar','Overshield', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\Shield-Overlay.tga]])



-- Borders
E.private.ProjectHopes = E.private.ProjectHopes or {}
E.private.ProjectHopes.qualityOfLife = E.private.ProjectHopes.qualityOfLife or {}
E.private.ProjectHopes.qualityOfLife.automation = E.private.ProjectHopes.qualityOfLife.automation or {}
if E.private.ProjectHopes.qualityOfLife.automation.borederDarkmode then
    LSM:Register('border', 'HopesUI', [[Interface\Addons\ElvUI_ProjectHopes\Media\Borders\HopesUI_Dark.tga]])
else
    LSM:Register('border', 'HopesUI', [[Interface\Addons\ElvUI_ProjectHopes\Media\Borders\HopesUI.tga]])
end

LSM:Register('border', 'HopesUI Light', [[Interface\Addons\ElvUI_ProjectHopes\Media\Borders\HopesUI_Light.tga]])

-- Sounds
LSM:Register("sound","|cffffc907Add|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Add.ogg]])
LSM:Register("sound","|cffffc907Adds|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Adds.ogg]])
LSM:Register("sound","|cffffc907AoE|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\AoE.ogg]])
LSM:Register("sound","|cffffc907Avoid|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Avoid.ogg]])
LSM:Register("sound","|cffffc907Bait|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Bait.ogg]])
LSM:Register("sound","|cffffc907Behind|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Behind.ogg]])
LSM:Register("sound","|cffffc907Bloodlust|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Bloodlust.ogg]])
LSM:Register("sound","|cffffc907CC|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\CC.ogg]])
LSM:Register("sound","|cffffc907Collect|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Collect.ogg]])
LSM:Register("sound","|cffffc907Charge|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Charge.ogg]])
LSM:Register("sound","|cffffc907Clear|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Clear.ogg]])
LSM:Register("sound","|cffffc907Dance|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Dance.ogg]])
LSM:Register("sound","|cffffc907Dispel|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Dispel.ogg]])
LSM:Register("sound","|cffffc907Defensive|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Defensive.ogg]])
LSM:Register("sound","|cffffc907Dodge|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Dodge.ogg]])
LSM:Register("sound","|cffffc907Fixate|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Fixate.ogg]])
LSM:Register("sound","|cffffc907Frontal|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Frontal.ogg]])
LSM:Register("sound","|cffffc907Hide|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Hide.ogg]])
LSM:Register("sound","|cffffc907Inside|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Inside.ogg]])
LSM:Register("sound","|cffffc907Interrupt|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Interrupt.ogg]])
LSM:Register("sound","|cffffc907Kite|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Kite.ogg]])
LSM:Register("sound","|cffffc907Knock|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Knock.ogg]])
LSM:Register("sound","|cffffc907Link|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Link.ogg]])
LSM:Register("sound","|cffffc907LOS|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\LOS.ogg]])
LSM:Register("sound","|cffffc907Move|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Move.ogg]])
LSM:Register("sound","|cffffc907MoveOut|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\MoveOut.ogg]])
LSM:Register("sound","|cffffc907Orbs|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Orbs.ogg]])
LSM:Register("sound","|cffffc907Out|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Out.ogg]])
LSM:Register("sound","|cffffc907OutofRange|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\OutofRange.ogg]])
LSM:Register("sound","|cffffc907Pull|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Pull.ogg]])
LSM:Register("sound","|cffffc907Run|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Run.ogg]])
LSM:Register("sound","|cffffc907Soak|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Soak.ogg]])
LSM:Register("sound","|cffffc907Spike|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Spike.ogg]])
LSM:Register("sound","|cffffc907Spikes|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Spikes.ogg]])
LSM:Register("sound","|cffffc907Spread|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Spread.ogg]])
LSM:Register("sound","|cffffc907Totem|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\Totem.ogg]])
LSM:Register("sound","|cffffc9071|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\1.ogg]])
LSM:Register("sound","|cffffc9072|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\2.ogg]])
LSM:Register("sound","|cffffc9073|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\3.ogg]])
LSM:Register("sound","|cffffc9074|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\4.ogg]])
LSM:Register("sound","|cffffc9075|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\5.ogg]])
LSM:Register("sound","|cffffc9076|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\6.ogg]])
LSM:Register("sound","|cffffc9077|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\7.ogg]])
LSM:Register("sound","|cffffc9078|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\8.ogg]])
LSM:Register("sound","|cffffc9079|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\9.ogg]])
LSM:Register("sound","|cffffc90710|r", [[Interface\Addons\ElvUI_ProjectHopes\Media\Sounds\10.ogg]])
 
local texCoords = {
	WARRIOR     = { 0, 0, 0, 0.125, 0.125, 0, 0.125, 0.125 },
	MAGE        = { 0.125, 0, 0.125, 0.125, 0.25, 0, 0.25, 0.125 },
	ROGUE       = { 0.25, 0, 0.25, 0.125, 0.375, 0, 0.375, 0.125 },
	DRUID       = { 0.375, 0, 0.375, 0.125, 0.5, 0, 0.5, 0.125 },
	EVOKER      = { 0.5, 0, 0.5, 0.125, 0.625, 0, 0.625, 0.125 },
	HUNTER      = { 0, 0.125, 0, 0.25, 0.125, 0.125, 0.125, 0.25 },
	SHAMAN      = { 0.125, 0.125, 0.125, 0.25, 0.25, 0.125, 0.25, 0.25 },
	PRIEST      = { 0.25, 0.125, 0.25, 0.25, 0.375, 0.125, 0.375, 0.25 },
	WARLOCK     = { 0.375, 0.125, 0.375, 0.25, 0.5, 0.125, 0.5, 0.25 },
	PALADIN     = { 0, 0.25, 0, 0.375, 0.125, 0.25, 0.125, 0.375 },
	DEATHKNIGHT = { 0.125, 0.25, 0.125, 0.375, 0.25, 0.25, 0.25, 0.375 },
	MONK        = { 0.25, 0.25, 0.25, 0.375, 0.375, 0.25, 0.375, 0.375 },
	DEMONHUNTER = { 0.375, 0.25, 0.375, 0.375, 0.5, 0.25, 0.5, 0.375 },
}

Private.Media = {
	Class = {
		blizzard = {
			texture = "Interface\\WorldStateFrame\\Icons-Classes",
			texCoords = CLASS_ICON_TCOORDS,
			name = LSM["Blizzard"],
			transparent = true,
		},
		hd = {
			texture = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\classHD.tga",
			texCoords = texCoords,
			name = LSM["Blizzard HD"],
      transparent = false,
		},
  },
}

