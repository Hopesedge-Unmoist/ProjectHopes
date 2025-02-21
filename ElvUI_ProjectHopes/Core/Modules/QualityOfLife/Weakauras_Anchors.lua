local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI);

local WAS = E:NewModule('Weakauras_Anchors', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

function WAS:Initialize()
  if not E.private.ProjectHopes.qualityOfLife.weakAurasAnchors then
    return
  end

  ProjectHopesBarAnchor = CreateFrame("Frame", "ProjectHopesBarAnchor", E.UIParent, 'BackdropTemplate')
  ProjectHopesBarAnchor:Point('CENTER', UIParent, 'CENTER', 300, 200)
  ProjectHopesBarAnchor:Size(200, 38)
  E:CreateMover(ProjectHopesBarAnchor, "ProjectHopes_Bar_AnchorMover", "ProjectHopes: Bar Anchor", nil, nil, nil, "ALL,PROJECTHOPES")

  ProjectHopesExtraBarAnchor = CreateFrame("Frame", "ProjectHopesExtraBarAnchor", E.UIParent, 'BackdropTemplate')
  ProjectHopesExtraBarAnchor:Point('CENTER', UIParent, 'CENTER', 300, 240)
  ProjectHopesExtraBarAnchor:Size(200, 38)
  E:CreateMover(ProjectHopesExtraBarAnchor, "ProjectHopes_ExtraBar_AnchorMover", "ProjectHopes: Extra Bar Anchor", nil, nil, nil, "ALL,PROJECTHOPES")

  ProjectHopesIconAnchor = CreateFrame("Frame", "ProjectHopesIconAnchor", E.UIParent, 'BackdropTemplate')
  ProjectHopesIconAnchor:Point('CENTER', UIParent, 'CENTER', 300, 120)
  ProjectHopesIconAnchor:Size(50, 50)
  E:CreateMover(ProjectHopesIconAnchor, "ProjectHopes_Icon_AnchorMover", "ProjectHopes:\nIcon Anchor", nil, nil, nil, "ALL,PROJECTHOPES")

  ProjectHopesExtraIconAnchor = CreateFrame("Frame", "ProjectHopesExtraIconAnchor", E.UIParent, 'BackdropTemplate')
  ProjectHopesExtraIconAnchor:Point('CENTER', UIParent, 'CENTER', 300, 60)
  ProjectHopesExtraIconAnchor:Size(50, 50)
  E:CreateMover(ProjectHopesExtraIconAnchor, "ProjectHopes_ExtraIcon_AnchorMover", "ProjectHopes:\nExtra Icon Anchor", nil, nil, nil, "ALL,PROJECTHOPES")

  ProjectHopesTextAnchor = CreateFrame("Frame", "ProjectHopesTextAnchor", E.UIParent, 'BackdropTemplate')
  ProjectHopesTextAnchor:Point('CENTER', UIParent, 'CENTER')
  ProjectHopesTextAnchor:Size(50, 50)
  E:CreateMover(ProjectHopesTextAnchor, "ProjectHopes_Text_AnchorMover", "ProjectHopes:\nText Anchor", nil, nil, nil, "ALL,PROJECTHOPES")
end

E:RegisterModule(WAS:GetName())