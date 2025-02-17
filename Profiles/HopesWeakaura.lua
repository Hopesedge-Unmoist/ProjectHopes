local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

function ProjectHopes:Setup_HopesWeakaura()

    E.db["ProjectHopes"]["weakauramainframe"]["Frame"] = true
	E.db["movers"]["HopesUIAnchorMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,408"

	E.db["ProjectHopes"]["weakauramainframe"]["Castbar"] = true
	E.db["ProjectHopes"]["weakauramainframe"]["castbarfont"]["name"] = "Expressway"
	E.db["ProjectHopes"]["weakauramainframe"]["castbarfont"]["style"] = "OUTLINE"
	E.db["ProjectHopes"]["weakauramainframe"]["castbarfont"]["size"] = 12

	E.db["ProjectHopes"]["weakauramainframe"]["PowerBar"] = true
	E.db["ProjectHopes"]["weakauramainframe"]["powerBarFont"]["name"] = "Expressway"
	E.db["ProjectHopes"]["weakauramainframe"]["powerBarFont"]["style"] = "OUTLINE"
	E.db["ProjectHopes"]["weakauramainframe"]["powerBarFont"]["size"] = 18

	E.db["ProjectHopes"]["weakauramainframe"]["Bottombar"] = true

	E.db["ProjectHopes"]["weakauramainframe"]["vigorBar"] = true
	E.db["ProjectHopes"]["weakauramainframe"]["vigorBarFont"]["name"] = "Expressway"
	E.db["ProjectHopes"]["weakauramainframe"]["vigorBarFont"]["style"] = "OUTLINE"
	E.db["ProjectHopes"]["weakauramainframe"]["vigorBarFont"]["size"] = 18

	E.db["ProjectHopes"]["weakauramainframe"]["combatTimer"] = true
	E.db["ProjectHopes"]["weakauramainframe"]["combatTimerFont"]["name"] = "Expressway"
	E.db["ProjectHopes"]["weakauramainframe"]["combatTimerFont"]["style"] = "OUTLINE"
	E.db["ProjectHopes"]["weakauramainframe"]["combatTimerFont"]["size"] = 17

	E.db["ProjectHopes"]["weakauramainframe"]["Classbar"] = true
	E.db["ProjectHopes"]["weakauramainframe"]["classBarFont"]["name"] = "Expressway"
	E.db["ProjectHopes"]["weakauramainframe"]["classBarFont"]["style"] = "OUTLINE"
	E.db["ProjectHopes"]["weakauramainframe"]["classBarFont"]["size"] = 12


    Private:Print(L["Main Frame has been set."])
end