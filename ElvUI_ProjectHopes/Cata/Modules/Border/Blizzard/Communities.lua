local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, pairs, select = next, pairs, select

local BATTLENET_FONT_COLOR = BATTLENET_FONT_COLOR
local GREEN_FONT_COLOR = GREEN_FONT_COLOR
local hooksecurefunc = hooksecurefunc

local function HandleCommunitiesButtons(button)
	BORDER:CreateBorder(button.backdrop)
			
	local color = (button.Background:GetAtlas() == 'communities-nav-button-green-normal' and GREEN_FONT_COLOR) or BATTLENET_FONT_COLOR
	button.Selection:SetVertexColor(color.r, color.g, color.b, 0.2)
end
			
local HandleGuildCards
do
	local card = { 'First', 'Second', 'Third' }
	function HandleGuildCards(cards)
		for _, name in pairs(card) do
		local guildCard = cards[name..'Card']
			BORDER:CreateBorder(guildCard)
			BORDER:CreateBorder(guildCard.RequestJoin, nil, nil, nil, nil, nil, false, true)
		end
	end
end
			
local function HandleCommunityCards(frame)
	if not frame then return end
			
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if not child.IsBorder then
			BORDER:HandleIcon(child.CommunityLogo, true)
			BORDER:CreateBorder(child, nil, -8, 8, 7, -8, false, true)
			
			child.IsBorder = true
		end
	end
end
			
local function HandleRewardButton(button)
	for _, child in next, { button.ScrollTarget:GetChildren() } do
		if not child.IsBorder then
			BORDER:CreateBorder(child.backdrop, nil, nil, nil, 7, nil)
			BORDER:HandleIcon(child.Icon)
			child.IsBorder = true
		end
	end
end


function S:Blizzard_Communities()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.communities) then return end
    if not E.db.ProjectHopes.skins.communities then return end

	local CommunitiesFrame = _G.CommunitiesFrame

	BORDER:CreateBorder(CommunitiesFrame)
	
	local CommunitiesFrameCommunitiesList = _G.CommunitiesFrameCommunitiesList
	BORDER:CreateBorder(CommunitiesFrameCommunitiesList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(CommunitiesFrame.StreamDropdown, nil, nil, nil, nil, nil, true, true)
	for _, child in next, { CommunitiesFrameCommunitiesList.ScrollBox.ScrollTarget:GetChildren() } do
		HandleCommunitiesButtons(child)
	end
	hooksecurefunc(CommunitiesFrameCommunitiesList.ScrollBox, 'Update', function(frame)
		for _, child in next, { CommunitiesFrameCommunitiesList.ScrollBox.ScrollTarget:GetChildren() } do
			HandleCommunitiesButtons(child)
		end
	end)
	-- Add Community Button
	hooksecurefunc(_G.CommunitiesListEntryMixin, 'SetAddCommunity', HandleCommunitiesButtons)
	hooksecurefunc(_G.CommunitiesListEntryMixin, 'SetFindCommunity', HandleCommunitiesButtons)
	hooksecurefunc(_G.CommunitiesListEntryMixin, 'SetGuildFinder', HandleCommunitiesButtons)
	
	BORDER:CreateBorder(CommunitiesFrame.ChatTab)
	CommunitiesFrame.ChatTab:Point('TOPLEFT', nil, 'TOPRIGHT', 6, 0)
	
	BORDER:CreateBorder(CommunitiesFrame.RosterTab)
	CommunitiesFrame.RosterTab:Point('TOPLEFT', CommunitiesFrame.ChatTab, 'BOTTOMLEFT', 0, -6)
	
	BORDER:CreateBorder(CommunitiesFrame.GuildBenefitsTab)
	CommunitiesFrame.GuildBenefitsTab:Point('TOPLEFT', CommunitiesFrame.RosterTab, 'BOTTOMLEFT', 0, -6)
	
	BORDER:CreateBorder(CommunitiesFrame.GuildInfoTab)
	CommunitiesFrame.GuildInfoTab:Point('TOPLEFT', CommunitiesFrame.GuildBenefitsTab, 'BOTTOMLEFT', 0, -6)
	
	BORDER:CreateBorder(CommunitiesFrame.GuildMemberDetailFrame)
	BORDER:CreateBorder(CommunitiesFrame.ClubFinderInvitationFrame)
	
	local ClubFinderCommunityAndGuildFinderFrame = _G.ClubFinderCommunityAndGuildFinderFrame
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab)
	ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab:Point('TOPLEFT', ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab, 'BOTTOMLEFT', 0, -6)
	
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab)
	ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab:Point('TOPLEFT', CommunitiesFrame, 'TOPRIGHT', 6, 0)
	
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.RequestToJoinFrame)
	
	local ClubFinderGuildFinderFrame = _G.ClubFinderGuildFinderFrame
	BORDER:CreateBorder(ClubFinderGuildFinderFrame.ClubFinderPendingTab)
	ClubFinderGuildFinderFrame.ClubFinderPendingTab:Point('TOPLEFT', ClubFinderGuildFinderFrame.ClubFinderSearchTab, 'BOTTOMLEFT', 0, -6)
	
	BORDER:CreateBorder(ClubFinderGuildFinderFrame.ClubFinderSearchTab)
	ClubFinderGuildFinderFrame.ClubFinderSearchTab:Point('TOPLEFT', CommunitiesFrame, 'TOPRIGHT', 6, 0)

	BORDER:CreateBorder(CommunitiesFrame.InviteButton, nil, nil, nil, nil, nil, false, true)

	-- Chat Tab
	BORDER:CreateBorder(CommunitiesFrame.Chat.InsetFrame)
	
	BORDER:CreateBorder(CommunitiesFrame.Chat.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(CommunitiesFrame.ChatEditBox, nil, -9, nil, 9, nil)

	for _, name in next, {'GuildFinderFrame', 'InvitationFrame', 'TicketFrame', 'CommunityFinderFrame', 'ClubFinderInvitationFrame'} do
		local frame = CommunitiesFrame[name]
		if frame then    
			if frame.CircleMask then
				BORDER:CreateBorder(frame.Icon)
			end
		
			if frame.FindAGuildButton then BORDER:CreateBorder(frame.FindAGuildButton, nil, nil, nil, nil, nil, false, true) end
			if frame.AcceptButton then BORDER:CreateBorder(frame.AcceptButton, nil, nil, nil, nil, nil, false, true) end
			if frame.DeclineButton then BORDER:CreateBorder(frame.DeclineButton, nil, nil, nil, nil, nil, false, true) end
			if frame.ApplyButton then BORDER:CreateBorder(frame.ApplyButton, nil, nil, nil, nil, nil, false, true) end
		
			local requestFrame = frame.RequestToJoinFrame
			if requestFrame then
				hooksecurefunc(requestFrame, 'Initialize', function(s)
					for button in s.SpecsPool:EnumerateActive() do
						if button.Checkbox then
							BORDER:CreateBorder(button.Checkbox, nil, nil, nil, nil, nil, true, true)
							button.Checkbox:Size(26)
						end
					end
				end)
		
				BORDER:CreateBorder(requestFrame.MessageFrame.MessageScroll, nil, -9, 9, 9, -9, true)
				BORDER:CreateBorder(requestFrame.Apply, nil, nil, nil, nil, nil, false, true)
				BORDER:CreateBorder(requestFrame.Cancel, nil, nil, nil, nil, nil, false, true)
			end
		
			if frame.GuildCards then HandleGuildCards(frame.GuildCards) end
			if frame.PendingGuildCards then HandleGuildCards(frame.PendingGuildCards) end
			if frame.CommunityCards then
				BORDER:CreateBorder(frame.CommunityCards.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
				hooksecurefunc(frame.CommunityCards.ScrollBox, 'Update', HandleCommunityCards)
			end
			if frame.PendingCommunityCards then
				BORDER:CreateBorder(frame.PendingCommunityCards.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
				hooksecurefunc(frame.PendingCommunityCards.ScrollBox, 'Update', HandleCommunityCards)
			end
		end
	end

	-- Guild finder Frame
	local ClubFinderGuildFinderFrame = _G.ClubFinderGuildFinderFrame        
	BORDER:CreateBorder(_G.ClubFinderLanguageDropdown, nil, nil, nil, nil, nil, true)

	BORDER:CreateBorder(ClubFinderGuildFinderFrame.OptionsList.ClubFilterDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(ClubFinderGuildFinderFrame.OptionsList.ClubSizeDropdown, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(ClubFinderGuildFinderFrame.RequestToJoinFrame)

	ClubFinderGuildFinderFrame.OptionsList.Search:ClearAllPoints()
	ClubFinderGuildFinderFrame.OptionsList.Search:Point('TOP', ClubFinderGuildFinderFrame.OptionsList.SearchBox, 'BOTTOM', 1, -5)

	BORDER:CreateBorder(ClubFinderGuildFinderFrame.OptionsList.SearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(ClubFinderGuildFinderFrame.OptionsList.Search, nil, nil, nil, nil, nil, false, true)

	if not ClubFinderGuildFinderFrame.OptionsList.TankRoleFrame.Checkbox.IsSkinned then 
		for _, checkButton in next, {
		ClubFinderGuildFinderFrame.OptionsList.TankRoleFrame.Checkbox,
		ClubFinderGuildFinderFrame.OptionsList.HealerRoleFrame.Checkbox,
		ClubFinderGuildFinderFrame.OptionsList.DpsRoleFrame.Checkbox,
		} do
			S:HandleCheckBox(checkButton)
			checkButton:SetFrameLevel(checkButton:GetFrameLevel() + 1)
		end
	end

	BORDER:CreateBorder(ClubFinderGuildFinderFrame.OptionsList.TankRoleFrame.Checkbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(ClubFinderGuildFinderFrame.OptionsList.HealerRoleFrame.Checkbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(ClubFinderGuildFinderFrame.OptionsList.DpsRoleFrame.Checkbox, nil, nil, nil, nil, nil, true, true)

	-- Community and Guild finder Tab
	local ClubFinderCommunityAndGuildFinderFrame = _G.ClubFinderCommunityAndGuildFinderFrame
	
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.OptionsList.ClubFilterDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.OptionsList.SortByDropdown, nil, nil, nil, nil, nil, true, true)
			
	ClubFinderCommunityAndGuildFinderFrame.OptionsList.Search:ClearAllPoints()
	ClubFinderCommunityAndGuildFinderFrame.OptionsList.Search:Point('TOP', ClubFinderCommunityAndGuildFinderFrame.OptionsList.SearchBox, 'BOTTOM', 1, -5)
	
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.OptionsList.SearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.OptionsList.Search, nil, nil, nil, nil, nil, false, true)
	
	if not ClubFinderCommunityAndGuildFinderFrame.OptionsList.TankRoleFrame.Checkbox.IsSkinned then 
		for _, checkButton in next, {
			ClubFinderCommunityAndGuildFinderFrame.OptionsList.TankRoleFrame.Checkbox,
			ClubFinderCommunityAndGuildFinderFrame.OptionsList.HealerRoleFrame.Checkbox,
			ClubFinderCommunityAndGuildFinderFrame.OptionsList.DpsRoleFrame.Checkbox
		} do
			S:HandleCheckBox(checkButton)
			checkButton:SetFrameLevel(checkButton:GetFrameLevel() + 1)
		end
	end

	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.OptionsList.TankRoleFrame.Checkbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.OptionsList.HealerRoleFrame.Checkbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(ClubFinderCommunityAndGuildFinderFrame.OptionsList.DpsRoleFrame.Checkbox, nil, nil, nil, nil, nil, true, true)
	
	-- Member Details
	BORDER:CreateBorder(CommunitiesFrame.GuildMemberDetailFrame.RemoveButton, nil, nil, nil, nil, nil, false, true)
	CommunitiesFrame.GuildMemberDetailFrame.RemoveButton:ClearAllPoints()
	CommunitiesFrame.GuildMemberDetailFrame.RemoveButton:Point('BOTTOMLEFT', 5, 5)
	
	BORDER:CreateBorder(CommunitiesFrame.GuildMemberDetailFrame.GroupInviteButton, nil, nil, nil, nil, nil, false, true)
	CommunitiesFrame.GuildMemberDetailFrame.GroupInviteButton:ClearAllPoints()
	CommunitiesFrame.GuildMemberDetailFrame.GroupInviteButton:Point('BOTTOMRIGHT', -5, 5)

	BORDER:CreateBorder(CommunitiesFrame.GuildMemberDetailFrame.NoteBackground)
	
	local DropDown = CommunitiesFrame.GuildMemberDetailFrame.RankDropdown
	DropDown:Point('LEFT', CommunitiesFrame.GuildMemberDetailFrame.RankLabel, 'RIGHT', -12, -3)
	BORDER:CreateBorder(DropDown)
	-- Roster Tab
	local MemberList = CommunitiesFrame.MemberList
	local ColumnDisplay = MemberList.ColumnDisplay
	
	BORDER:CreateBorder(MemberList.InsetFrame)
	BORDER:CreateBorder(CommunitiesFrame.GuildMemberListDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(CommunitiesFrame.CommunitiesControlFrame.GuildControlButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CommunitiesFrame.CommunitiesControlFrame.GuildRecruitmentButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CommunitiesFrame.CommunitiesControlFrame.CommunitiesSettingsButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CommunitiesFrame.MemberList.ShowOfflineButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(MemberList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	
	CommunitiesFrame.CommunitiesControlFrame.GuildRecruitmentButton:ClearAllPoints()
	CommunitiesFrame.CommunitiesControlFrame.GuildRecruitmentButton:Point('RIGHT', CommunitiesFrame.InviteButton, 'LEFT', -5, 0)
	
	hooksecurefunc(CommunitiesFrame.MemberList, 'RefreshListDisplay', function(frame)
		for _, child in next, { frame.ColumnDisplay:GetChildren() } do
			BORDER:CreateBorder(child, nil, -7, 7, 7, -7)
		end
	end)
	
	-- Perks Tab
	local GuildBenefitsFrame = CommunitiesFrame.GuildBenefitsFrame
	
	BORDER:CreateBorder(CommunitiesFrame.GuildBenefitsFrame.Perks.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	
	if E.private.skins.parchmentRemoverEnable then
		hooksecurefunc(CommunitiesFrame.GuildBenefitsFrame.Perks.ScrollBox, 'Update', HandleRewardButton)
		hooksecurefunc(CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBox, 'Update', HandleRewardButton)
	end
	
	-- Guild Reputation Bar
	local StatusBar = CommunitiesFrame.GuildBenefitsFrame.FactionFrame.Bar
	BORDER:CreateBorder(StatusBar)
	StatusBar.Progress:Point('BOTTOMRIGHT')
	StatusBar.background:Point('BOTTOMRIGHT', 0, 0)

	-- Info Tab
	local GuildDetails = _G.CommunitiesFrameGuildDetailsFrame
	
	BORDER:CreateBorder(_G.CommunitiesFrameGuildDetailsFrameInfo.DetailsFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.CommunitiesFrameGuildDetailsFrameNews.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
			
	if E.private.skins.parchmentRemoverEnable then
		-- Guild Challenges Background
		local GuildDetailsFrameInfo = _G.CommunitiesFrameGuildDetailsFrameInfo
		for _, child in ipairs({GuildDetailsFrameInfo:GetChildren()}) do
			if child:GetObjectType() == "Frame" then
				local width, height = child:GetSize()
				if width > 22 and height > 22 then
					BORDER:CreateBorder(child)
				end
			end
		end
	end
	
	BORDER:CreateBorder(CommunitiesFrame.GuildLogButton, nil, nil, nil, nil, nil, false, true)
	
	-- Filters Frame
	local FiltersFrame = _G.CommunitiesGuildNewsFiltersFrame
	BORDER:CreateBorder(FiltersFrame)
	
	BORDER:CreateBorder(FiltersFrame.GuildAchievement, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(FiltersFrame.Achievement, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(FiltersFrame.DungeonEncounter, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(FiltersFrame.EpicItemLooted, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(FiltersFrame.EpicItemCrafted, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(FiltersFrame.EpicItemPurchased, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(FiltersFrame.LegendaryItemLooted, nil, nil, nil, nil, nil, true, true)
	
	-- Guild Message EditBox
	local EditFrame = _G.CommunitiesGuildTextEditFrame
	BORDER:CreateBorder(EditFrame)
	
	BORDER:CreateBorder(EditFrame.Container.ScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.CommunitiesGuildTextEditFrameAcceptButton, nil, nil, nil, nil, nil, false, true)
	
	local closeButton = select(4, _G.CommunitiesGuildTextEditFrame:GetChildren())
	BORDER:CreateBorder(closeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CommunitiesGuildTextEditFrameCloseButton, nil, nil, nil, nil, nil, false, true)

	-- Guild Log
	local GuildLogFrame = _G.CommunitiesGuildLogFrame
	BORDER:CreateBorder(GuildLogFrame)
	BORDER:CreateBorder(GuildLogFrame.Container.NineSlice)
	
	BORDER:CreateBorder(GuildLogFrame.Container.ScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	closeButton = select(3, _G.CommunitiesGuildLogFrame:GetChildren()) -- swap local variable
	BORDER:CreateBorder(closeButton, nil, nil, nil, nil, nil, false, true)

	-- Recruitment Dialog
	local RecruitmentDialog = _G.CommunitiesFrame.RecruitmentDialog
	BORDER:CreateBorder(RecruitmentDialog)
	
	BORDER:CreateBorder(RecruitmentDialog.ShouldListClub.Button, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(RecruitmentDialog.ClubFocusDropdown, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(RecruitmentDialog.LookingForDropdown, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(RecruitmentDialog.LanguageDropdown, nil, nil, nil, nil, nil, true, false)
	
	BORDER:CreateBorder(RecruitmentDialog.RecruitmentMessageFrame.RecruitmentMessageInput, nil, -9, nil, 9, nil)
	BORDER:CreateBorder(RecruitmentDialog.MaxLevelOnly.Button, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(RecruitmentDialog.MinIlvlOnly.Button, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(RecruitmentDialog.MinIlvlOnly.EditBox, nil, -9, nil, 9, nil)
	BORDER:CreateBorder(RecruitmentDialog.Accept, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(RecruitmentDialog.Cancel, nil, nil, nil, nil, nil, false, true)
	
	-- Notification Settings Dialog
	local NotificationSettings = _G.CommunitiesFrame.NotificationSettingsDialog
	BORDER:CreateBorder(NotificationSettings)
	BORDER:CreateBorder(NotificationSettings.CommunitiesListDropDownMenu, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(NotificationSettings.ScrollFrame.Child.QuickJoinButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(NotificationSettings.ScrollFrame.Child.AllButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(NotificationSettings.ScrollFrame.Child.NoneButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(NotificationSettings.Selector.OkayButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(NotificationSettings.Selector.CancelButton, nil, nil, nil, nil, nil, false, true)

	-- Communities Settings
	local Settings = _G.CommunitiesSettingsDialog
	BORDER:CreateBorder(Settings)
	BORDER:CreateBorder(Settings.IconPreview)
	BORDER:CreateBorder(Settings.CrossFactionToggle.CheckButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Settings.ShouldListClub.Button, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Settings.AutoAcceptApplications.Button, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Settings.MaxLevelOnly.Button, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Settings.MinIlvlOnly.Button, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Settings.MinIlvlOnly.EditBox, nil, nil, nil, nil, nil, true)

	BORDER:CreateBorder(Settings.NameEdit, nil, -9, nil, 9, nil)
	BORDER:CreateBorder(Settings.ShortNameEdit, nil, -9, nil, 9, nil)
	BORDER:CreateBorder(Settings.Description, nil, -9, nil, 9, nil)
	BORDER:CreateBorder(Settings.MessageOfTheDay, nil, -9, nil, 9, nil)
	
	BORDER:CreateBorder(Settings.ChangeAvatarButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(Settings.Accept, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(Settings.Delete, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(Settings.Cancel, nil, nil, nil, nil, nil, false, true)

	for _, checkButton in next, {
		Settings.CrossFactionToggle.CheckButton,
		Settings.ShouldListClub.Button,
		Settings.AutoAcceptApplications.Button,
		Settings.MaxLevelOnly.Button,
		Settings.MinIlvlOnly.Button,
			} do
		checkButton:Size(24)
	end

    local Avatar = _G.CommunitiesAvatarPickerDialog
        
    Avatar:HookScript('OnShow', function(frame)
        for _, child in next, { frame.ScrollBox.ScrollTarget:GetChildren() } do
            local button = child.Icon
            BORDER:CreateBorder(Avatar)
            if button then
                BORDER:CreateBorder(button, nil, -7.5, nil, nil, nil, nil, true)
                BORDER:CreateBorder(Avatar.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
                BORDER:CreateBorder(Avatar.Selector.OkayButton, nil, nil, nil, nil, nil, false, true)
                BORDER:CreateBorder(Avatar.Selector.CancelButton, nil, nil, nil, nil, nil, false, true)
            end
        end
    end)

    -- Invite Frame
    local TicketManager = _G.CommunitiesTicketManagerDialog
    BORDER:CreateBorder(TicketManager)
        
    BORDER:CreateBorder(TicketManager.LinkToChat, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(TicketManager.Copy, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(TicketManager.Close, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(TicketManager.GenerateLinkButton, nil, nil, nil, nil, nil, false, true)
        
    BORDER:CreateBorder(TicketManager.ExpiresDropDownMenu, nil, nil, nil, nil, nil, true)
    BORDER:CreateBorder(TicketManager.UsesDropDownMenu, nil, nil, nil, nil, nil, true)
        
    BORDER:CreateBorder(TicketManager.MaximizeButton, nil, nil, nil, nil, nil, false, true)
        
    -- InvitationsFrames
    local ClubFinderInvitationFrame = CommunitiesFrame.ClubFinderInvitationFrame
    BORDER:CreateBorder(ClubFinderInvitationFrame)
        
    BORDER:CreateBorder(ClubFinderInvitationFrame.AcceptButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(ClubFinderInvitationFrame.DeclineButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(ClubFinderInvitationFrame.ApplyButton, nil, nil, nil, nil, nil, false, true)
        
    BORDER:CreateBorder(ClubFinderInvitationFrame.WarningDialog.Accept, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(ClubFinderInvitationFrame.WarningDialog.Cancel, nil, nil, nil, nil, nil, false, true)
        
     local InvitationFrame = CommunitiesFrame.InvitationFrame
    BORDER:CreateBorder(InvitationFrame)
        
    BORDER:CreateBorder(InvitationFrame.AcceptButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(InvitationFrame.DeclineButton, nil, nil, nil, nil, nil, false, true)
	
end

S:AddCallbackForAddon('Blizzard_Communities')
