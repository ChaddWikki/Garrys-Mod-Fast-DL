--CLASS: VGUI
InsomniaInterface.VGUI = {}

local screen_width_scale = ScrW()/1920

function InsomniaInterface.VGUI:ColorToComponents(color)
	return color.r, color.g, color.b, color.a
end

function InsomniaInterface.VGUI:DrawText(text, font, x, y, color, align_x, align_y, max_characters)
	surface.SetFont(font)
	surface.SetTextColor(color)
	
	if max_characters then
		if (#text) > max_characters then
			text = string.sub(text, 1, max_characters)
		end
	end
	
	local size_x, size_y = surface.GetTextSize(text)
	
	if align_x == TEXT_ALIGN_CENTER then
		x = x - size_x/2
	elseif align_x == TEXT_ALIGN_RIGHT then
		x = x - size_x
	end
	
	if align_y == TEXT_ALIGN_CENTER then
		y = y - size_y/2
	elseif align_y == TEXT_ALIGN_BOTTOM then
		y = y - size_y
	end
	
	surface.SetTextPos(x, y)
	surface.DrawText(text)
end

function InsomniaInterface.VGUI:DrawTextOutlined(text, font, x, y, text_color, align_x, align_y, outline_width, outline_color, max_characters)
	if max_characters then
		if (#text) > max_characters then
			text = string.sub(text, 1, max_characters)
		end
	end
	
	draw.SimpleTextOutlined(text, font, x, y, text_color, align_x, align_y, outline_width, outline_color)
end

function InsomniaInterface.VGUI:CalculateRegularPolygon(x, y, r, seg)
	local vertexes = {}
	
	for i=0, (seg-1) do
		local a = math.rad((i/seg)*(-360))
		table.insert(vertexes, {x = x + math.sin(a)*r, y = y + math.cos(a)*r})
	end
	
	return vertexes
end

function InsomniaInterface.VGUI:CalculatePolygonPart(vertexes, main_size, center, first_vertex, part_size)
	local sub_vertexes = {}
	table.insert(sub_vertexes, center)
	
	for i=0, (part_size-1) do
		local cur_vertex = (first_vertex + i)%main_size
		
		if cur_vertex == 0 then
			table.insert(sub_vertexes, vertexes[main_size])
		else
			table.insert(sub_vertexes, vertexes[cur_vertex])
		end
	end
	
	return sub_vertexes
end

function InsomniaInterface.VGUI:DrawPolygon(vertexes, color)
	surface.SetDrawColor(InsomniaInterface.VGUI:ColorToComponents(color))
	draw.NoTexture()
	surface.DrawPoly(vertexes)
end

function InsomniaInterface.VGUI:DrawPanelOnPolygon(vertexes, ref)
	render.ClearStencil()
	render.SetStencilEnable(true)
	
	render.SetStencilWriteMask(1)
	render.SetStencilTestMask(1)
	
	render.SetStencilReferenceValue(1)
	render.SetStencilPassOperation(STENCILOPERATION_ZERO)
	render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
	
	InsomniaInterface.VGUI:DrawPolygon(vertexes, Color(0, 0, 0, 255))
	
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	
	ref:PaintManual()
	
	render.SetStencilEnable(false)
	render.ClearStencil()
end

--ref is a DPanel here
function InsomniaInterface.VGUI:SetupPlayerAvatar(ref, x, y, size, ply, is_model)
	ref:SetSize(size, size)
	ref:SetPos(x, y)
	ref:SetPaintedManually(true)
	
	if not is_model then
		if not IsValid(ply) then return end
		
		local image_size
		if size <= 16 then
			image_size = 16
		elseif size <= 32 then
			image_size = 32
		elseif size <= 64 then
			image_size = 64
		elseif size <= 84 then
			image_size = 84
		elseif size <= 128 then
			image_size = 128
		else
			image_size = 184
		end
		ref:SetPlayer(ply, image_size)
		
	else
		ref:SetBackgroundColor(Color(80, 80, 80, 255))
		
		local model_panel = ref:GetChild(0)
		model_panel:SetSize(size, size)
		function model_panel:LayoutEntity() return end
		
		InsomniaInterface.VGUI:SetupPlayermodelOnPlayerAvatar(model_panel, ply)
	end
end

--ref is a DModelPanel here
function InsomniaInterface.VGUI:SetupPlayermodelOnPlayerAvatar(ref, ply)
	if not IsValid(ply) then return end
	local playermodel = ply:GetModel()
	if playermodel == nil then return end
	
	if not (ref.cur_pm == nil) then
		if ref.cur_pm == playermodel then return end
	end
	ref.cur_pm = playermodel
	
	ref:SetModel(playermodel)
	local head_bone = ref.Entity:LookupBone("ValveBiped.Bip01_Head1")
	if head_bone == nil then return end
	
	local eyepos = ref.Entity:GetBonePosition(head_bone)
	ref:SetLookAt(eyepos)
	ref:SetCamPos(eyepos - Vector(-16, 0, 0))
	ref.Entity:SetEyeTarget(eyepos - Vector(-16, 0, 0))
end

function InsomniaInterface.VGUI:GetScreenWidthScale()
	return screen_width_scale
end

function InsomniaInterface.VGUI:ScreenWidthScaleChanged()
	if (ScrW()/1920) != screen_width_scale then return true end
	return false
end

function InsomniaInterface.VGUI:UpdateScreenWidthScale()
	screen_width_scale = ScrW()/1920
end