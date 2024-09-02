
game.AddAmmoType({
    name = "flechette12g",
    dmgtype = DMG_BULLET, 
    tracer = TRACER_LINE,
    plydmg = 8,
    npcdmg = 8,
    force = 1308,
    maxcarry = 60,
    minsplash = 4,
    maxsplash = 8,
    flags = 0
})

game.AddAmmoType({
    name = "nitro16mm",
    dmgtype = bit.bor(DMG_BULLET, DMG_SNIPER), 
    tracer = TRACER_LINE,
    plydmg = 20,
    npcdmg = 20,
    force = 10633,
    maxcarry = 22,
    minsplash = 4,
    maxsplash = 8,
    flags = 0
})

game.AddAmmoType({
    name = "ammoflare",
    dmgtype = bit.bor(DMG_BULLET, DMG_BURN), 
    tracer = TRACER_LINE,
    plydmg = 2,
    npcdmg = 2,
    force = 500,
    maxcarry = 8,
    minsplash = 6,
    maxsplash = 10,
    flags = 0
})

game.AddAmmoType({
    name = "ammo10mm",
    dmgtype = DMG_BULLET, 
    tracer = TRACER_LINE,
    plydmg = 5,
    npcdmg = 5,
    force = 750,
    maxcarry = 50,
    minsplash = 4,
    maxsplash = 8,
    flags = 0
})

game.AddAmmoType({
    name = "ammo8mm",
    dmgtype = DMG_BULLET, 
    tracer = TRACER_LINE,
    plydmg = 5,
    npcdmg = 5,
    force = 750,
    maxcarry = 150,
    minsplash = 4,
    maxsplash = 8,
    flags = 0
})

game.AddAmmoType({
    name = "ammo357",
    dmgtype = DMG_BULLET, 
    tracer = TRACER_LINE,
    plydmg = 8,
    npcdmg = 8,
    force = 1300,
    maxcarry = 30,
    minsplash = 4,
    maxsplash = 8,
    flags = 0
})

if CLIENT then
    language.Add("#flechette12g", "Flechette 12g")
    language.Add("#nitro16mm", "16mm Nitro Express")
    language.Add("#ammoflare", "26.5mm flare")
    language.Add("#ammo10mm", "10mm")
    language.Add("#ammo8mm", "8mm")
    language.Add("#ammo357", ".357")
end
