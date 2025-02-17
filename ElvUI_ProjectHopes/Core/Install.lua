local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local C_UI_Reload = C_UI.Reload
local format = format

local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

local function InstallComplete()
	E.global.ProjectHopes.install_version = Private.Version
	E.private.ProjectHopes.install_version = Private.Version

	C_UI_Reload()
end

function ProjectHopes:ImproveInstall()
	BORDER:CreateBorder(PluginInstallFrame, nil, nil, nil, nil, nil, false, false, PluginInstallFrame, PluginInstallTitleFrame)

	for i = 1, 4 do
		local button = _G["PluginInstallOption"..i.."Button"]
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end
	
	BORDER:CreateBorder(PluginInstallPrevButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(PluginInstallNextButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(PluginInstallStatus)
	
	local Gabseparator = CreateFrame("Frame", nil, PluginInstallTitleFrame, "BackdropTemplate")
	Gabseparator:SetBackdrop(Private.vSeparator)
	Gabseparator:SetWidth(16)
	Gabseparator:SetPoint("TOPLEFT", PluginInstallTitleFrame, -4, 0)
	Gabseparator:SetPoint("BOTTOMLEFT", PluginInstallTitleFrame, 0, 0)
	
end

E.PopupDialogs['HOPESUI_INSTALL'] = {
	text = L["|cff919191Project|r |cffffc607Hopes|r\nDo you want to Setup HopesUI?"],
	button1 = YES,
	button2 = NO,
	OnCancel = E.noop
}

function ProjectHopes:SetupHopesUI(Profile)
	if Profile == "main" then
		E.PopupDialogs['HOPESUI_INSTALL'].OnAccept = ProjectHopes.Setup_HopesWeakaura
		ProjectHopes:Setup_Layout('main')
	elseif Profile == "healing" then
		E.PopupDialogs['HOPESUI_INSTALL'].OnAccept = ProjectHopes.Setup_HopesWeakaura
		ProjectHopes:Setup_Layout('healing')
	end

	E:StaticPopup_Show("HOPESUI_INSTALL")
end

function ProjectHopes:ResizeInstall()
	PluginInstallFrame:SetSize(1040,520)
	PluginInstallFrame.Desc1:ClearAllPoints()
	PluginInstallFrame.Desc1:SetPoint("TOP", PluginInstallFrame.SubTitle, "BOTTOM", 0,-30)
end

-- Installer table
ProjectHopes.InstallerData = {
	Title = Private.Name,
	Name = Private.Name,
	tutorialImage = ('Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\logo.tga'),
	Pages = {
		[1] = function()
			ProjectHopes:ResizeInstall()
			ProjectHopes:ImproveInstall()
			PluginInstallFrame.SubTitle:SetText(L["Welcome"])
			PluginInstallFrame.Desc1:SetText(L["This prompt will help you install "]..Private.Name..L[" and import its settings"])
			PluginInstallFrame.Desc2:SetText('|cff66FF66' ..L["Your existing profiles will not change. The installer will create a fresh profile."].. '|r')
			PluginInstallFrame.Desc3:SetText("")
			PluginInstallFrame.Desc4:SetText(L["Please read the steps carefully before clicking any buttons."])

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
			PluginInstallFrame.Option1:SetText(L["Skip and close the installer"])

		end,
		[2] = function()
			ProjectHopes:ResizeInstall()
			PluginInstallFrame.SubTitle:SetText(L["ElvUI Layouts"])
			PluginInstallFrame.Desc1:SetText(L["This step will configure the ElvUI layout of your choice."])
			PluginInstallFrame.Desc2:SetText(L["Recommend to install both and after the installation change to the profile you want."])
			PluginInstallFrame.Desc3:SetText('|cffFFC907' ..L["A Popup will come if you want to enable HopesUI aswell for each profile."].. '|r')
			PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ProjectHopes:SetupHopesUI("main") end)
			PluginInstallFrame.Option1:SetText(L["DPS/Tanks Profile"])
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() ProjectHopes:SetupHopesUI('healing') end)
			PluginInstallFrame.Option2:SetText(L["Healing Profile"])
		end,
		[3] = function()
			ProjectHopes:ResizeInstall()
			PluginInstallFrame.SubTitle:SetText(L["Plater"])
			PluginInstallFrame.Desc1:SetText(L["This step will install my Plater profile."])
			PluginInstallFrame.Desc2:SetText("")
			PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')

			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ProjectHopes:Setup_Plater() end)
			PluginInstallFrame.Option1:SetText('Plater')
			if (not IsAddOnLoaded("Plater")) then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc1:SetText("")
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Plater is not installed or enabled."]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Run the installer again when Plater is installed or enabled."])
				PluginInstallFrame.Option1:Disable()
			end
		end,
		[4] = function()
			ProjectHopes:ResizeInstall()
			PluginInstallFrame.SubTitle:SetText(L["BigWigs and LittleWigs"])
			PluginInstallFrame.Desc1:SetText(L["This step will apply Project Hopes' BigWigs and LittleWigs profile."])
			PluginInstallFrame.Desc2:SetText("")
			PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')

			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ProjectHopes:Setup_BigWigs('main') end)
			PluginInstallFrame.Option1:SetText('BigWigs')
			if (not IsAddOnLoaded('BigWigs')) then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc1:SetText("")
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["BigWigs is not installed or enabled."]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Run the installer again when BigWigs is installed or enabled."])
				PluginInstallFrame.Option1:Disable()
			end
		end,
		[5] = function()
			ProjectHopes:ResizeInstall()
			PluginInstallFrame.SubTitle:SetText(L["Details Profile"])
			PluginInstallFrame.Desc1:SetText(L["This step will apply Project Hopes' Details! Damage Meter profile."])
			PluginInstallFrame.Desc2:SetText("")
			PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')

			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ProjectHopes:Setup_Details() end)
			PluginInstallFrame.Option1:SetText(L["Details"])
			if (not IsAddOnLoaded('Details')) then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc1:SetText("")
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Details is not installed or enabled."]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Run the installer again when Details is installed or enabled."])
				PluginInstallFrame.Option1:Disable()
			end
		end,
		[6] = function()
			ProjectHopes:ResizeInstall()
			PluginInstallFrame.SubTitle:SetText(L["OmniCD Profile"])
			PluginInstallFrame.Desc1:SetText(L["This step will apply Project Hopes' OmniCD profile."])
			PluginInstallFrame.Desc2:SetText("")
			PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')

			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ProjectHopes:Setup_OmniCD('main') end)
			PluginInstallFrame.Option1:SetText('OmniCD')
			if (not IsAddOnLoaded('OmniCD')) then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc1:SetText("")
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["OmniCD is not installed or enabled."]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Run the installer again when OmniCD is installed or enabled."])
				PluginInstallFrame.Option1:Disable()
			end
		end,
		[E.Retail and 7] = function()
			ProjectHopes:ResizeInstall()
			PluginInstallFrame.SubTitle:SetText(L["WarpDeplete Profile"])
			PluginInstallFrame.Desc1:SetText(L["This step will apply Project Hopes' WarpDeplete profile."])
			PluginInstallFrame.Desc2:SetText("")
			PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')

			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ProjectHopes:Setup_WarpDeplete() end)
			PluginInstallFrame.Option1:SetText('WarpDeplete')
			if (not IsAddOnLoaded('WarpDeplete')) then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc1:SetText("")
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["WarpDeplete is not installed or enabled."]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Run the installer again when WarpDeplete is installed or enabled."])
				PluginInstallFrame.Option1:Disable()
			end
		end,
		[E.Retail and 8 or 7] = function()
			ProjectHopes:ResizeInstall()
			PluginInstallFrame.SubTitle:SetText(L["Weakauras"])
			PluginInstallFrame.Desc1:SetText(L["This step will import Hope's General Weakauras"])
			PluginInstallFrame.Desc2:SetText('|cffFFC907' ..L["Class Weakauras can be imported later on in Project Hopes' tab 'Weakauras'"].. '|r')
			PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')

			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetText('Essentials')
			if E.Retail then
				PluginInstallFrame.Option1:SetScript("OnClick", function()
					ProjectHopes:Setup_Weakauras()
					ProjectHopes:ImportWeakAura(PluginInstallFrame, "HIGH", ProjectHopes.Essentials)
				end)

				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetText('Dungeon')
				PluginInstallFrame.Option2:SetScript("OnClick", function()
					ProjectHopes:Setup_Weakauras()
					ProjectHopes:ImportWeakAura(PluginInstallFrame, "HIGH", ProjectHopes.Dungoen)
				end)

				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetText('Raid')
				PluginInstallFrame.Option3:SetScript("OnClick", function()
					ProjectHopes:Setup_Weakauras()
					ProjectHopes:ImportWeakAura(PluginInstallFrame, "HIGH", ProjectHopes.Raid)
				end)
			elseif E.Classic then
				PluginInstallFrame.Option1:SetScript("OnClick", function()
					ProjectHopes:Setup_WeakaurasClassic()
					ProjectHopes:ImportWeakAura(PluginInstallFrame, "HIGH", ProjectHopes.EssentialsClassic)
				end)
			elseif E.Cata then
				PluginInstallFrame.Option1:SetScript("OnClick", function()
					ProjectHopes:Setup_WeakaurasCata()
					ProjectHopes:ImportWeakAura(PluginInstallFrame, "HIGH", ProjectHopes.EssentialsCata)
				end)
			end
		end,
		[E.Retail and 9 or 8] = function()
			ProjectHopes:ResizeInstall()
			PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
			PluginInstallFrame.Desc1:SetText(L["You have completed the installation process, please click 'Finished' to reload the UI."])
			PluginInstallFrame.Desc2:SetText(L["If you got any questions feel free to ask in my Discord."])

			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ProjectHopes_EDITBOX', nil, nil, 'https://discord.gg/xRY4bwA') end)
			PluginInstallFrame.Option1:SetText('Discord')
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', InstallComplete)
			PluginInstallFrame.Option2:SetText(format('|cff4beb2c%s', L["Finished"]))
		end
	},
	StepTitles = {
		[1] = L["Welcome"],
		[2] = L["ElvUI Layouts"],
		[3] = L["Plater"],
		[4] = L["BigWigs"],
		[5] = L["Details"],
		[6] = L["OmniCD"],
		[E.Retail and 7] = L["WarpDeplete"],
		[E.Retail and 8 or 7] = L["Weakauras"],
		[E.Retail and 9 or 8 or 7] = L["Installation Complete"],

	},
	StepTitlesColor = { 1, 1, 1 },
	StepTitlesColorSelected = { 1, 0.776, 0.027 },
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = 'LEFT',
}
