-- this was my first lua addon so sorry for shit code <3 

local TimeroutConVar = GetConVar("arx_hit_hit_delay")
local DistanceCV = GetConVar("arx_hit_hit_distance")
local FullAlpha = GetConVar("arx_hit_hit_full_alpha")
local MaxRand = GetConVar("arx_hit_dmg_random")
local EnableGrHit = GetConVar("arx_hit_enable_gr_hit")
local EnableSHit = GetConVar("arx_hit_enable_s_hit")
local EnableDMG = GetConVar("arx_hit_enable_dmg")
local EnablePRIKOL = GetConVar("arx_hit_enable_prikol")
local EnableClassic = GetConVar("arx_hit_enable_classic")
local EnableOnenumber = GetConVar("arx_hit_enable_onenumber")
local OneNumberDistance = GetConVar("arx_hit_onenumber_distancey")
local OneNumberDistanceX = GetConVar("arx_hit_onenumber_distancex")
local FontSize = GetConVar("arx_hit_font_size")
local Color1Hex = GetConVar("arx_hit_color1_hex")
local Color2Hex = GetConVar("arx_hit_color2_hex")
local Minus = GetConVar("arx_hit_minus")

surface.CreateFont( "HitmarkFont"..FontSize:GetInt(), {
	font = "Exo 2", 
	size = FontSize:GetInt()*5+8,
	weight = 600,
})

DARKY.fonts = {}
DARKY.fonts[FontSize:GetInt()] = true

function HexColor(hex, alpha)
	hex = hex:gsub("#","")

	local nextr = tonumber("0x"..hex:sub(1,2)) or 0
	local nextg = tonumber("0x"..hex:sub(3,4)) or 0
	local nextb = tonumber("0x"..hex:sub(5,6)) or 0
	local nexta = alpha or 255

	local nextcol = Color(nextr, nextg, nextb, nexta)

	return nextcol
end

local Hits = {}

local GrayColor = Color(50,50,55)
local ButtonColor = Color(45,45,85)
local WhiteColor = Color(255,255,255)
local HitDefault = HexColor(Color1Hex:GetString())
local HitHead = HexColor(Color2Hex:GetString())


local isGrOpen = false
local isNumOpen = false
local isDown = false
local nexttest = CurTime()+0.5

function DARKY.OpenHitmarker()
	if IsValid(DARKY.Hitmenu) then
		DARKY.Hitmenu:Remove()
	end
	local w, h = ScrW(), ScrH()

	local isOnnOpen = false

	DARKY.Hitmenu = vgui.Create("DFrame")
	DARKY.Hitmenu:SetTitle("")
	DARKY.Hitmenu:MakePopup(true)
	DARKY.Hitmenu:SetDraggable(true)
	DARKY.Hitmenu:SetSize(350,600)
	DARKY.Hitmenu:SetPos(w,h/2-300)
	
	local isAnimating = true
	DARKY.Hitmenu:MoveTo(w-355,h/2-300, 0.5, 0, 0.1, function()
		isAnimating = false
	end)
	DARKY.Hitmenu.OnClose = function()
		isOnnOpen = false
		isGrOpen = false
		isNumOpen = false
		isDown = false
		onenumber = 0
		table.Empty(Hits)
	end
	local shoot = DARKY.Hitmenu:Add("DButton")
	shoot:Dock(BOTTOM)
	shoot:SetTall(40)
	shoot:SetText("")
	shoot.Paint = function(me,w,h)
		surface.SetDrawColor(ButtonColor)
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("#dhit.shoot", "DermaDefault", w/2, h/2, WhiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	function shoot:OnMousePressed()
		isDown = true
	end
	function shoot:OnMouseReleased()
		isDown = false
	end
	local enableSnd = DARKY.Hitmenu:Add("DCheckBox")
	enableSnd:SetPos(10,30)
	enableSnd:SetSize(20,20)
	enableSnd:SetConVar("arx_hit_enable_s_hit")
	local enableGr = DARKY.Hitmenu:Add("DCheckBox")
	enableGr:SetPos(10,60)
	enableGr:SetSize(20,20)
	enableGr:SetConVar("arx_hit_enable_gr_hit")

	local enableClassic = DARKY.Hitmenu:Add("DCheckBox")
	enableClassic:SetPos(30,60)
	enableClassic:SetSize(0,0)
	enableClassic:SetConVar("arx_hit_enable_classic")
	local enableOnenum = DARKY.Hitmenu:Add("DCheckBox")
	enableOnenum:SetPos(30,60)
	enableOnenum:SetSize(0,0)
	enableOnenum:SetConVar("arx_hit_enable_onenumber")
	local enableNum = DARKY.Hitmenu:Add("DCheckBox")
	enableNum:SetPos(30,60)
	enableNum:SetSize(0,0)
	enableNum:SetConVar("arx_hit_enable_dmg")

	local grTime = DARKY.Hitmenu:Add("DNumSlider")
	grTime:SetPos(40,90)
	grTime:SetSize(0,0)
	grTime:SetText("")
	grTime:SetConVar("arx_hit_hit_delay")
	grTime:SetMin(0.7)
	grTime:SetMax(10)
	grTime:SetDecimals(1)

	local grFont = DARKY.Hitmenu:Add("DNumSlider")
	grFont:SetPos(40,120)
	grFont:SetSize(0,0)
	grFont:SetText("")
	grFont:SetConVar("arx_hit_font_size")
	grFont:SetMin(1)
	grFont:SetMax(7) -- *3+8
	grFont:SetDecimals(0)

	local onenumDistance = DARKY.Hitmenu:Add("DNumSlider")
	onenumDistance:SetPos(40,120)
	onenumDistance:SetSize(0,0)
	onenumDistance:SetText("")
	onenumDistance:SetDecimals(0)
	onenumDistance:SetConVar("arx_hit_onenumber_distancey")
	onenumDistance:SetMin(-200)
	onenumDistance:SetMax(200)

	local onenumDistancex = DARKY.Hitmenu:Add("DNumSlider")
	onenumDistancex:SetPos(40,150)
	onenumDistancex:SetSize(0,0)
	onenumDistancex:SetText("")
	onenumDistancex:SetDecimals(0)
	onenumDistancex:SetConVar("arx_hit_onenumber_distancex")
	onenumDistancex:SetMin(-200)
	onenumDistancex:SetMax(200)

	local numDistance = DARKY.Hitmenu:Add("DNumSlider")
	numDistance:SetPos(20,enableNum:GetPos())
	numDistance:SetSize(0,0)
	numDistance:SetText("")
	numDistance:SetDecimals(0)
	numDistance:SetConVar("arx_hit_hit_distance")
	numDistance:SetMin(15)
	numDistance:SetMax(350)

	local numDistance2 = DARKY.Hitmenu:Add("DNumSlider")
	numDistance2:SetPos(20,enableNum:GetPos())
	numDistance2:SetSize(0,0)
	numDistance2:SetText("")
	numDistance2:SetDecimals(1)
	numDistance2:SetConVar("arx_hit_dmg_random")
	numDistance2:SetMin(0)
	numDistance2:SetMax(35)

	local onenumReset = DARKY.Hitmenu:Add("DImageButton")
	onenumReset:SetPos(325,210)
	onenumReset:SetSize(0,0)
	onenumReset:SetImage("icon16/arrow_rotate_clockwise.png")
	onenumReset:SetConsoleCommand("arx_hit_onenumber_distancey", 100)

	local onenumReset2 = DARKY.Hitmenu:Add("DImageButton")
	onenumReset2:SetPos(325,240)
	onenumReset2:SetSize(0,0)
	onenumReset2:SetImage("icon16/arrow_rotate_clockwise.png")
	onenumReset2:SetConsoleCommand("arx_hit_onenumber_distancex", 0)
	
	local numReset = DARKY.Hitmenu:Add("DImageButton")
	numReset:SetPos(325,145)
	numReset:SetSize(0,0)
	numReset:SetImage("icon16/arrow_rotate_clockwise.png")
	numReset:SetConsoleCommand("arx_hit_hit_distance", 150)

	local numReset2 = DARKY.Hitmenu:Add("DImageButton")
	numReset2:SetPos(325,145)
	numReset2:SetSize(0,0)
	numReset2:SetImage("icon16/arrow_rotate_clockwise.png")
	numReset2:SetConsoleCommand("arx_hit_dmg_random", 25)

	local delayReset = DARKY.Hitmenu:Add("DImageButton")
	delayReset:SetPos(325,92)
	delayReset:SetSize(0,0)
	delayReset:SetImage("icon16/arrow_rotate_clockwise.png")
	delayReset:SetConsoleCommand("arx_hit_hit_delay", 3)

	local fontReset = DARKY.Hitmenu:Add("DImageButton")
	fontReset:SetPos(325,122)
	fontReset:SetSize(0,0)
	fontReset:SetImage("icon16/arrow_rotate_clockwise.png")
	fontReset:SetConsoleCommand("arx_hit_font_size", 5)

	local prikol = DARKY.Hitmenu:Add("DCheckBox")
	prikol:SetPos(325,535)
	prikol:SetSize(15,15)
	prikol:SetConVar("arx_hit_enable_prikol")

	local color1 = DARKY.Hitmenu:Add("DTextEntry")
	color1:SetPos(25,490)
	color1:SetSize(55,22)


	local color2 = DARKY.Hitmenu:Add("DTextEntry")
	color2:SetPos(25,520)
	color2:SetSize(55,22)

	

	function openGr() 
		if not isGrOpen then 
			enableNum:MoveTo(40,210, 0.05)
			enableClassic:MoveTo(40,150, 0.05)
			enableOnenum:MoveTo(40,180, 0.05)
			enableOnenum:SizeTo(20,20, 0.05)
			enableNum:SizeTo(20,20, 0.05)
			grTime:SizeTo(280,30, 0.05)
			grFont:SizeTo(280,30, 0.05)
			delayReset:SizeTo(20,20,  0.05)
			fontReset:SizeTo(20,20,  0.05)

			enableClassic:SizeTo(20,20, 0.05, 0, -1, function()
				isGrOpen = true
			end)
		end
	end

	function openOnn() 
		if not isOnnOpen and isGrOpen then
			enableNum:MoveTo(40,280, 0.05)
			onenumReset:SizeTo(20,20,  0.05)
			onenumReset2:SizeTo(20,20,  0.05)
			onenumDistance:SizeTo(250,30, 0.05, 0)
			onenumDistancex:SizeTo(250,30, 0.05, 0, -1, function()
				isOnnOpen = true
			end)
		end
	end

	function openNum() 
		if not isNumOpen and isGrOpen then
			numReset:SizeTo(20,20,  0.05)
			numReset2:SizeTo(20,20,  0.05)
			numDistance2:SizeTo(250,30, 0.05)
			numDistance:SizeTo(250,30, 0.05, 0, -1, function()
				isNumOpen = true
			end)
		end
	end	

	function closeNum() 
		if isNumOpen and isGrOpen then
			numReset:SizeTo(0,0,  0.05)
			numReset2:SizeTo(0,0,  0.05)
			numDistance2:SizeTo(0,0, 0.05)
			numDistance:SizeTo(0,0, 0.05, 0, -1, function()
				isNumOpen = false
			end)
		end
	end
	function closeOnn() 
		if isOnnOpen and isGrOpen then
			enableNum:MoveTo(40,210, 0.05)
			onenumReset:SizeTo(0,0,  0.05)
			onenumReset2:SizeTo(0,0,  0.05)
			onenumDistance:SizeTo(0,0, 0.05, 0, -1)
			onenumDistancex:SizeTo(0,0, 0.05, 0, -1, function()
				isOnnOpen = false
			end)
		end
	end
	
	function closeGr() 
		if isGrOpen then
			enableNum:MoveTo(30,60, 0.05)
			enableClassic:MoveTo(30,60, 0.05)
			enableOnenum:MoveTo(30,60, 0.05)
			enableOnenum:SizeTo(0,0, 0.05)
			enableNum:SizeTo(0,0,  0.05)
			grTime:SizeTo(0,0, 0.05)
			grFont:SizeTo(0,0, 0.05)
			delayReset:SizeTo(0,0,  0.05)
			fontReset:SizeTo(0,0,  0.05)
			enableClassic:SizeTo(0,0, 0.05, 0, -1, function()
				isGrOpen = false
			end)
		end
	end
	
	DARKY.Hitmenu.Think = function(me)
		if #color1:GetValue()==6 or #color1:GetValue()==7 then
			color1:SetConVar("arx_hit_color1_hex")
		end
		if #color2:GetValue()==6 or #color2:GetValue()==7 then
			color2:SetConVar("arx_hit_color2_hex")
		end

		if not DARKY.fonts[FontSize:GetInt()] then
			surface.CreateFont( "HitmarkFont"..FontSize:GetInt(), {
				font = "Exo 2", 
				size = FontSize:GetInt()*5+8,
				weight = 600,
			})
			DARKY.fonts[FontSize:GetInt()] = true
		end
		
		if isDown then
			if CurTime()>nexttest then
				TESTHITMARK()
				nexttest = CurTime()+0.1
			end
		end
		if enableGr:GetChecked() then
			openGr()
		else
			closeGr()
			closeOnn()
			closeNum()
		end
		if enableOnenum:GetChecked() then
			openOnn()
		else
			closeOnn()
		end
		if enableNum:GetChecked() then
			openNum()
		else
			closeNum()
		end
		local numX, numY = enableNum:GetPos()
		local onumX, onumY = enableOnenum:GetPos()
		numDistance:SetPos(numX+30, numY+25)
		numDistance2:SetPos(numX+30, numY+55)
		numReset:SetPos(numX+285, numY+27)
		numReset2:SetPos(numX+285, numY+60)
		onenumDistance:SetPos(onumX+30, onumY+25)
		onenumDistancex:SetPos(onumX+30, onumY+55)
	end
	DARKY.Hitmenu.Paint = function(me,w,h)
		surface.SetDrawColor(GrayColor)
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("#dhit.enablesnd", "DermaDefault", 40, 32, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("#dhit.enablegr", "DermaDefault", 40, 62, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("#dhit.enableprikol", "DermaDefault", 322,535, WhiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		draw.SimpleText("#dhit.name", "DermaDefault", 10, 5, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("#dhit.color1", "DermaDefault", 85, 495, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("#dhit.color2", "DermaDefault", 85, 525, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

		if isGrOpen then
			local numX, numY = enableNum:GetPos()
			local onumX, onumY = enableOnenum:GetPos()
			draw.SimpleText("#dhit.delay", "DermaDefault", 42, 97, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText("#dhit.fontsize", "DermaDefault", 42, 127, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText("#dhit.enableclassic", "DermaDefault", 70, 152, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText("#dhit.enableonenumber", "DermaDefault", 70, 182, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText("#dhit.enabledmgnumbers", "DermaDefault", 70, numY+2, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if isOnnOpen then
				draw.SimpleText("Y offset", "DermaDefault", 90, 212, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				draw.SimpleText("X offset", "DermaDefault", 90, 212+30, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
			if isNumOpen then
				draw.SimpleText("#dhit.distance", "DermaDefault", 90, numY+32, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				draw.SimpleText("#dhit.spread", "DermaDefault", 90, numY+62, WhiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
		end
	end
end
concommand.Add("arx_hit_hitmenu2", DARKY.OpenHitmarker)
	
W = ScrW()/2
H = ScrH()/2




local img = Material( "4etko.png", "noclamp smooth" )

local prik = 0
local onenumber = 0

hook.Add("HUDPaint", "HITMARK", function()
    if EnableGrHit:GetInt() == 1 and EnableDMG:GetInt() == 1 or EnableGrHit:GetInt() == 1 and EnablePRIKOL:GetInt() == 1 or EnableGrHit:GetInt() == 1 and EnableClassic:GetInt() == 1 or EnableGrHit:GetInt() == 1 and EnableOnenumber:GetInt() == 1 then
			if isNumOpen and IsValid(DARKY.Hitmenu) then
				surface.SetDrawColor( 255, 255, 255, 255)
				surface.DrawCircle(W, H, DistanceCV:GetInt()+MaxRand:GetInt()+30, WhiteColor)
				surface.DrawCircle(W, H, DistanceCV:GetInt()-MaxRand:GetInt()-30, WhiteColor)
			end
			for k, v in ipairs( Hits ) do
				surface.SetFont( "HitmarkFont"..FontSize:GetInt() )
				local HitColor = Color(255,255,255)
				local HitColor2 = Color(255,0,0)

				if not v.type then 
					HitColor = HexColor(Color1Hex:GetString(), (v.time - CurTime())*255)
					HitColor2 = HexColor(Color1Hex:GetString(), 255)
				else
					HitColor = HexColor(Color2Hex:GetString(), (v.time - CurTime())*255)
					HitColor2 = HexColor(Color2Hex:GetString(), 255)
				end

				if v.time - CurTime() <= FullAlpha:GetFloat() then
					surface.SetDrawColor(HitColor)
				else
					surface.SetDrawColor(HitColor2)
				end

				if not v.dead and EnableDMG:GetInt() == 1 then						
					draw.SimpleText((Minus:GetBool() and "-" or "") ..v.dmg, "HitmarkFont"..FontSize:GetInt(), W+v.x, H+v.y, HitColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				elseif v.dead and EnableOnenumber:GetInt() == 1 then
					draw.SimpleText("KILL", "HitmarkFont"..FontSize:GetInt(), W+OneNumberDistanceX:GetInt(), H+OneNumberDistance:GetInt()+30, HitColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				elseif v.dead then
					draw.SimpleText("KILL", "HitmarkFont"..FontSize:GetInt(), W+v.x, H+v.y, HitColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end	

                if v.time <= CurTime() then
					table.remove( Hits, k )
				end

				if #Hits == 0 then
					onenumber = 0
				end

				if EnableOnenumber:GetInt() == 1 then
					surface.SetFont("HitmarkFont"..FontSize:GetInt())
					draw.SimpleText((Minus:GetBool() and "-" or "")..onenumber, "HitmarkFont"..FontSize:GetInt(),W+OneNumberDistanceX:GetInt(), H+OneNumberDistance:GetInt(), HitColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end

				if EnableClassic:GetInt() == 1 then
					surface.DrawLine(W,H,W-12,H-12)
					surface.DrawLine(W,H,W+12,H-12)
					surface.DrawLine(W,H,W+12,H+12)
					surface.DrawLine(W,H,W-12,H+12)
				end

				if EnablePRIKOL:GetInt() == 1 and v.dead and v.type then 
					if v.time - CurTime() <= FullAlpha:GetFloat() then
						surface.SetDrawColor( 255, 255, 255, (v.time - CurTime())*255 )
					else
						surface.SetDrawColor(255,255,255,255)
					end
					surface.SetMaterial( img )
					surface.DrawTexturedRect( W-450, H-500, 786, 410 )
				end
            end
		end
end)

function HITMARK()
	local dmg2 = net.ReadUInt(10)
	local head = net.ReadBool()
	local deads = net.ReadBool()

	if dmg2 > 0 or deads then
		if EnableGrHit:GetInt() == 1 and EnableDMG:GetInt() == 1 or EnableGrHit:GetInt() == 1 and EnablePRIKOL:GetInt() == 1 or EnableGrHit:GetInt() == 1 and EnableClassic:GetInt() == 1  or EnableGrHit:GetInt() == 1 and EnableOnenumber:GetInt() == 1 then
			local popa = math.random(1,360)
			table.insert( Hits, {dmg = dmg2, time = CurTime()+TimeroutConVar:GetInt(), type = head, x = -10+math.cos(popa)*DistanceCV:GetInt()-math.random(-MaxRand:GetFloat(),MaxRand:GetFloat()), y = -10+math.sin(popa)*DistanceCV:GetInt()-math.random(-MaxRand:GetFloat(),MaxRand:GetFloat()), dead = deads} )
			onenumber = onenumber + dmg2
		end
		if EnableSHit:GetInt() == 1 or EnablePRIKOL:GetInt() == 1 then
			if head == false and EnableSHit:GetInt() == 1 then
				surface.PlaySound("rust_hitmarker.wav")
			elseif deads and head and EnablePRIKOL:GetInt() == 1 then
				surface.PlaySound("css_headshot.wav")
			elseif EnableSHit:GetInt() == 1 and head then
				surface.PlaySound("rust_headshot.wav")
			end
		end
	end
end

function TESTHITMARK()
	local dmg2 = math.random(12,45)
	local head = not tobool(math.random(0,5))
	local deads = not tobool(math.random(0,10))

	if EnableGrHit:GetInt() == 1 and EnableDMG:GetInt() == 1 or EnableGrHit:GetInt() == 1 and EnablePRIKOL:GetInt() == 1 or EnableGrHit:GetInt() == 1 and EnableClassic:GetInt() == 1  or EnableGrHit:GetInt() == 1 and EnableOnenumber:GetInt() == 1 then
		local popa = math.random(1,360)
		table.insert( Hits, {dmg = dmg2, time = CurTime()+TimeroutConVar:GetInt(), type = head, x = -10+math.cos(popa)*DistanceCV:GetInt()-math.random(-MaxRand:GetFloat(),MaxRand:GetFloat()), y = -10+math.sin(popa)*DistanceCV:GetInt()-math.random(-MaxRand:GetFloat(),MaxRand:GetFloat()), dead = deads} )
		onenumber = onenumber + dmg2
	end
	if EnableSHit:GetInt() == 1 or EnablePRIKOL:GetInt() == 1 then
		if head == false and EnableSHit:GetInt() == 1 then
			surface.PlaySound("rust_hitmarker.wav")
		elseif deads and head and EnablePRIKOL:GetInt() == 1 then
			surface.PlaySound("css_headshot.wav")
		elseif EnableSHit:GetInt() == 1 and head then
			surface.PlaySound("rust_headshot.wav")
		end
	end
end

net.Receive("HITMARKER",HITMARK)
