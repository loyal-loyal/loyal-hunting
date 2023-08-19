Config = {}

Config.carcass  = {
    [`a_c_boar`]=           'carcass_boar',
    [`a_c_chickenhawk`] =   'carcass_hawk',
    [`a_c_cormorant`] =     'carcass_cormorant',
    [`a_c_coyote`] =        'carcass_coyote',
    [`a_c_deer`] =          'carcass_deer',
    [`a_c_mtlion`] =        'carcass_mtlion',
    [`a_c_rabbit_01`] =     'carcass_rabbit'
}


Config.carcassPos  = {
    [`a_c_boar`]=           {drag = true, xPos = -0.7, yPos = 1.2, zPos = -1.0, xRot = -200.0, yRot = 0.0, zRot = 0.0},
    [`a_c_chickenhawk`] =   {drag = false, xPos = 0.15, yPos = 0.2, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_cormorant`] =     {drag = false, xPos = 0.15, yPos = 0.2, zPos = 0.4, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_coyote`] =        {drag = false, xPos = -0.2, yPos = 0.15, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_deer`] =          {drag = true, xPos = 0.1, yPos = 1.0, zPos = -1.2, xRot = -200.0, yRot = 30.0, zRot = 0.0},
    [`a_c_mtlion`] =        {drag = true, xPos = 0.1, yPos = 0.7, zPos = -1.0, xRot = -210.0, yRot = 0.0, zRot = 0.0},
    [`a_c_rabbit_01`] =     {drag = false, xPos = 0.12, yPos = 0.25, zPos = 0.45, xRot = 0.0, yRot = 90.0, zRot = 0.0},
}

Config.goodWeapon = {
    -- `WEAPON_MUSKET`,
    `WEAPON_SNIPERRIFLE`,
    -- `WEAPON_KNIFE`
}

Config.sellPrice = {
    ['carcass_boar'] =      {min = 100,max = 100}, -- min = 0 durability   max = 100 durability
    ['carcass_hawk'] =      {min = 120,max = 120},
    ['carcass_cormorant'] = {min = 60,max = 60},
    ['carcass_coyote'] =    {min = 30,max = 30},
    ['carcass_deer'] =      {min = 50,max = 50},
    ['carcass_mtlion'] =    {min = 80,max = 80},
    ['carcass_rabbit'] =    {min = 40,max = 40}
}


Config.gradeMultiplier = {
    ['★☆☆'] = 0.5, -- not killed by a goodWeapon
    ['★★☆'] = 1.0, -- killed by a goodWeapon
    ['★★★'] = 2.0  -- headshot
}

Config.headshotBones = {
    [`a_c_boar`]=           {31086},
    [`a_c_chickenhawk`] =   {39317},
    [`a_c_cormorant`] =     {24818},
    [`a_c_coyote`] =        {31086},
    [`a_c_deer`] =          {31086},
    [`a_c_mtlion`] =        {31086},
    [`a_c_rabbit_01`] =     {31086}
}

Config.antiFarm = {
    enable = true, size = 70.0, time = 10 * 60, maxAmount = 3, personal = true
}

Hunting = {}

Hunting.PedHash = `ig_hunter`
Hunting.PedCoords = vector3(-679.07, 5834.42, 16.33)
Hunting.PedCoordsHeading = 126.27

Hunting.Items = {
    label = "Shop",
    slots = 20,
    items = { 
        [1] = {
            name = 'huntingbait',
            price = 25, 
            amount = 500,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'huntingknife',
            price = 500,
            amount = 500,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'weapon_sniperrifle',
            price = 2500,
            amount = 500,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'snp_ammo',
            price = 1000,
            amount = 500,
            info = {},
            type = 'item',
            slot = 4,
        },
    },
}