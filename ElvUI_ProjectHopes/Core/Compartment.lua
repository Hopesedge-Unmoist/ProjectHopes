local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

if not E.Retail then return end

-- OnClick
function ProjectHopes_OnAddonCompartmentClick()
	E:ToggleOptions()
	E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ProjectHopes')
end
