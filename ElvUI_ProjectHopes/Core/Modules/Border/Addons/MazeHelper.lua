local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

function S:MazeHelper()
	if not E.db.ProjectHopes.skins.mazeHelper then return end

	local Maze = _G.ST_Maze_Helper
	Maze:StripTextures()
	Maze:SetTemplate('Transparent')

	BORDER:CreateBorder(Maze, 1)
end

S:AddCallbackForAddon("MazeHelper")
