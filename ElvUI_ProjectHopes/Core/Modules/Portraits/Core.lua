function PORTRAIT:UpdatePosition(unit, position, offsetX, offsetY, strata)
    local refs = self.frames[unit]
    if not refs or not refs.frame then 
        return
    end
    
    if not UF or not UF[unit] then 
        refs.frame:ClearAllPoints()
        refs.frame:SetPoint("CENTER", UIParent, "CENTER", offsetX or 0, offsetY or 0)
        refs.frame:SetFrameStrata(strata or "MEDIUM")
        return
    end
    
    local parent = UF[unit]
    local frame = refs.frame
    
    position = position or "center"
    offsetX = offsetX or 0
    offsetY = offsetY or 0
    strata  = strata or "MEDIUM"
    
    local gap = 5
    
    frame:ClearAllPoints()
    
    if position == "left" then
        frame:SetPoint("RIGHT", parent, "LEFT", offsetX - gap, offsetY)
    elseif position == "right" then
        frame:SetPoint("LEFT", parent, "RIGHT", offsetX + gap, offsetY)
    elseif position == "top" then
        frame:SetPoint("BOTTOM", parent, "TOP", offsetX, offsetY + gap)
    elseif position == "bottom" then
        frame:SetPoint("TOP", parent, "BOTTOM", offsetX, offsetY - gap)
    elseif position == "topleft" then
        frame:SetPoint("BOTTOMRIGHT", parent, "TOPLEFT", offsetX - gap, offsetY + gap)
    elseif position == "topright" then
        frame:SetPoint("BOTTOMLEFT", parent, "TOPRIGHT", offsetX + gap, offsetY + gap)
    elseif position == "bottomleft" then
        frame:SetPoint("TOPRIGHT", parent, "BOTTOMLEFT", offsetX - gap, offsetY - gap)
    elseif position == "bottomright" then
        frame:SetPoint("TOPLEFT", parent, "BOTTOMRIGHT", offsetX + gap, offsetY - gap)
    elseif position == "overlay" or position == "center" then
        frame:SetPoint("CENTER", parent, "CENTER", offsetX, offsetY)
    elseif position == "leftoverlay" then
        frame:SetPoint("LEFT", parent, "LEFT", offsetX, offsetY)
    elseif position == "rightoverlay" then
        frame:SetPoint("RIGHT", parent, "RIGHT", offsetX, offsetY)
    elseif position == "topoverlay" then
        frame:SetPoint("TOP", parent, "TOP", offsetX, offsetY)
    elseif position == "bottomoverlay" then
        frame:SetPoint("BOTTOM", parent, "BOTTOM", offsetX, offsetY)
    else
        frame:SetPoint("CENTER", parent, "CENTER", offsetX, offsetY)
    end

    frame:SetFrameStrata(strata)
end