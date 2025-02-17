local E, _, V, P, G = unpack(ElvUI)
local Name, Private = ...
local LSM = LibStub('LibSharedMedia-3.0')

if LSM == nil then return end

-- Fonts
LSM:Register('font','Expressway', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Fonts\Expressway.ttf]])
LSM:Register('font','Noto', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Fonts\NotoSans.ttf.ttf]])
-- Statusbar Textures
LSM:Register('statusbar','HopesUI', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\HopesUI.tga]])
LSM:Register('statusbar','Health Fill', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\Grid2_HP_Fill.tga]])
LSM:Register('statusbar','Health Background', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\Grid2_HP_Background.tga]])
LSM:Register('statusbar','Blizzard Cast', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzcast.tga]])
LSM:Register('statusbar','Blizzard Cast Background', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzcastback.tga]])
LSM:Register('statusbar','Blizzard Cast Channel', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzcastchannel.tga]])
LSM:Register('statusbar','Blizzard Cast Nonbreakable', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzcastnonbreakable.tga]])
LSM:Register('statusbar','Blizzard Desat', [[Interface\AddOns\ElvUI_ProjectHopes\Media\Statusbar\blizzdesat.tga]])

-- Borders
E.private.ProjectHopes = E.private.ProjectHopes or {}
E.private.ProjectHopes.qualityOfLife = E.private.ProjectHopes.qualityOfLife or {}
if E.private.ProjectHopes.qualityOfLife.borederDarkmode then
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
