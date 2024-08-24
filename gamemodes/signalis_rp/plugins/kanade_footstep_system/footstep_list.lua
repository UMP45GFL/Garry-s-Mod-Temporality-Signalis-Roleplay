
local path = "eternalis/player/footsteps/"

ETERNALIS_FOOTSTEP_LIST = {
    {
        mat = MAT_DIRT,
        surface = "dirt",
        sounds = {
            path.."dirt1.wav",
            path.."dirt2.wav",
            path.."dirt3.wav",
            path.."dirt4.wav"
        }
    },
    {
        mat = MAT_GRASS,
        surface = "grass",
        sounds = {
            path.."grass1.wav",
            path.."grass2.wav",
            path.."grass3.wav",
            path.."grass4.wav"
        }
    },
    {
        mat = MAT_METAL,
        surface = "metal",
        sounds = {
            path.."metal1.wav",
            path.."metal2.wav",
            path.."metal3.wav",
            path.."metal4.wav"
        }
    },
    {
        mat = MAT_SAND,
        surface = "sand",
        sounds = {
            path.."sand1.wav",
            path.."sand2.wav",
            path.."sand3.wav",
            path.."sand4.wav"
        }
    },
    {
        mat = MAT_WOOD,
        surface = "wood",
        sounds = {
            path.."wood1.wav",
            path.."wood2.wav",
            path.."wood3.wav",
            path.."wood4.wav"
        }
    },
    {
        -- might want to get better sounds cuz these sounds like the player has big boots and the tiles are dirty
        mat = MAT_TILE,
        surface = "tile",
        sounds = {
            path.."tile1.wav",
            path.."tile2.wav",
            path.."tile3.wav",
            path.."tile4.wav"
        }
    },
    {
        mat = MAT_GRATE,
        surface = "grate",
        sounds = {
            path.."metalgrate1.wav",
            path.."metalgrate2.wav",
            path.."metalgrate3.wav",
            path.."metalgrate4.wav"
        }
    },
    {
        mat = MAT_CONCRETE,
        surface = {"concrete", "rock"},
        sounds = {
            path.."concrete1.wav",
            path.."concrete2.wav",
            path.."concrete3.wav",
            path.."concrete4.wav"
        }
    },
    {
        surface = "wood_plank",
        sounds = {
            path.."woodpanel1.wav",
            path.."woodpanel2.wav",
            path.."woodpanel3.wav",
            path.."woodpanel4.wav"
        }
    },
    {
        mat = MAT_PLASTIC,
        surface = {"plastic", "rubber"},
        sounds = {
            "physics/plastic/plastic_box_impact_soft1.wav",
            "physics/plastic/plastic_box_impact_soft2.wav",
            "physics/plastic/plastic_box_impact_soft3.wav",
            "physics/plastic/plastic_box_impact_soft4.wav"
        }
    },
    {
        surface = {"paper", "cardboard"},
        sounds = {
            "physics/cardboard/cardboard_box_impact_soft1.wav",
            "physics/cardboard/cardboard_box_impact_soft2.wav",
            "physics/cardboard/cardboard_box_impact_soft3.wav",
            "physics/cardboard/cardboard_box_impact_soft4.wav",
            "physics/cardboard/cardboard_box_impact_soft5.wav",
            "physics/cardboard/cardboard_box_impact_soft6.wav",
            "physics/cardboard/cardboard_box_impact_soft7.wav"
        }
    },
    {
        -- we need a snow sound
        mat = MAT_SNOW,
        surface = "snow",
        sounds = true -- default
    },
    {
        mat = MAT_FLESH,
        surface = "flesh",
        sounds = {
            "physics/flesh/flesh_impact_hard1.wav",
            "physics/flesh/flesh_impact_hard2.wav",
            "physics/flesh/flesh_impact_hard3.wav"
        }
    },
    {
        surface = "mud",
        sounds = {
            path.."mud1.wav",
            path.."mud2.wav",
            path.."mud3.wav",
            path.."mud4.wav"
        }
    },
    {
        mat = MAT_SLOSH,
        surface = "slosh",
        sounds = {
            path.."slosh1.wav",
            path.."slosh2.wav",
            path.."slosh3.wav",
            path.."slosh4.wav"
        }
    },
    {
        mat = MAT_VENT,
        surface = "vent",
        sounds = {
            path.."duct1.wav",
            path.."duct2.wav",
            path.."duct3.wav",
            path.."duct4.wav"
        }
    },
    {
        mat = MAT_COMPUTER,
        surface = "computer",
        sounds = {
            "physics/metal/metal_box_footstep1.wav",
            "physics/metal/metal_box_footstep2.wav",
            "physics/metal/metal_box_footstep3.wav",
            "physics/metal/metal_box_footstep4.wav"
        }
    },
    {
        mat = MAT_GLASS,
        surface = "glass",
        sounds = {
            "physics/glass/glass_sheet_impact_soft1.wav",
            "physics/glass/glass_sheet_impact_soft2.wav",
            "physics/glass/glass_sheet_impact_soft3.wav"
        }
    },
    {
        mat = MAT_CARPET,
        surface = "carpet",
        sounds = {
            path.."carpet1.wav",
            path.."carpet2.wav",
            path.."carpet3.wav",
            path.."carpet4.wav",
            path.."carpet5.wav",
            path.."carpet6.wav",
            path.."carpet7.wav",
            path.."carpet8.wav"
        }
    }
}
