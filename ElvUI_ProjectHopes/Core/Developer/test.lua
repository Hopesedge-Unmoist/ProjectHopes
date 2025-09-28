local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local TESTMODULE = E:NewModule('TESTMODULE', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

function TESTMODULE:Initialize()

end

E:RegisterModule(TESTMODULE:GetName())