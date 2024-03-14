CreateClientConVar( "arx_hit_enable_s_hit", 1, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_enable_gr_hit", 1, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_enable_prikol", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_enable_classic", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_enable_dmg", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_hit_delay", 2, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_hit_distance", 150, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_hit_full_alpha", 1.0, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_dmg_random", 25, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_enable_onenumber", 1, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_onenumber_distancex", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_onenumber_distancey", 100, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_font_size", 6, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_color1_hex", "#FFFFFF", { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_color2_hex", "#DD2222", { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "arx_hit_minus", 1, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )


DARKY = {}

hook.Add( "PopulateToolMenu", "arx_hit_markers", function()
    spawnmenu.AddToolMenuOption( "Options", "Darky Arx HUD", "arx_hit_hits", "#dhit.name", "", "", function( panel )
        panel:AddControl( "Button", {
            Label = "#dhit.openmenu",
            Command = "arx_hit_hitmenu2"
        } )
    end)
end )
