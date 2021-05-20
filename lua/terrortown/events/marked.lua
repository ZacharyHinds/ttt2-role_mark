
if SERVER then
	AddCSLuaFile()
	resource.AddFile("materials/vgui/ttt/vskin/events/marked.vmt")
end


if CLIENT then
	EVENT.icon = Material("vgui/ttt/vskin/events/marked")
	EVENT.title = "title_event_marked"

	function EVENT:GetText()

		local tools_string = "desc_event_marked_paintgun"
		if self.event.markTool == 1 then 
			tools_string = "desc_event_marked_revival"
		elseif self.event.markTool == 2 then 
			tools_string = "desc_event_marked_grenade"
		elseif self.event.markTool ~= 3 and isstring(self.event.markTool) then -- can make custom message
			tools_string = self.event.markTool 
		end

		return {
			{
				string = "desc_event_marked",
				params = {
					marker = self.event.marker.nick,
					markee = self.event.markee.nick,
					mrole = roles.GetByIndex(self.event.markee.role).name,
					mteam = self.event.markee.team,
				},
				translateParams = true
			},
			{
				string = tools_string
			}
		}
	end
end

if SERVER then
	function EVENT:Trigger(marker, markee, markTool)
		self:AddAffectedPlayers(
			{marker:SteamID64(), markee:SteamID64()},
			{marker:Nick(), markee:Nick()}
		)

		return self:Add({
			marker = {
				nick = marker:Nick(),
				sid64 = marker:SteamID64()
			},
			markee = {
				nick = markee:Nick(),
				sid64 = markee:SteamID64(),
				role = markee:GetSubRole(),
				team = markee:GetTeam(),
			},
			isRevival = isRevival
		})
	end

	function EVENT:CalculateScore()
		local event = self.event

		self:SetPlayerScore(event.marker.sid64, {
			score = 2
		})
	end
end

function EVENT:Serialize()
	return self.event.maker.nick .. " has marked " .. self.event.markee.nick .. " with their paintgun."
end
