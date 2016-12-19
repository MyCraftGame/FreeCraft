
local path = minetest.get_modpath("mobs_animal")

-- Animals

dofile(path .. "/chicken.lua") -- JKmurray
dofile(path .. "/cow.lua") -- KrupnoPavel
dofile(path .. "/sheep.lua") -- PilzAdam
dofile(path .. "/bunny.lua") -- ExeterDad
dofile(path .. "/kitten.lua") -- Jordach/BFD
dofile(path .. "/dog.lua") -- KrupnoPavel
dofile(path .. "/pig.lua") -- KrupnoPavel
dofile(path .. "/bear.lua") -- KrupnoPavel

-- Removed
mobs:register_mob("mobs_animal:rat", {
		lifetimer = 1,
	})

-- compatibility
mobs:alias_mob("mobs:rat", "mobs_animal:rat")
mobs:alias_mob("mobs:rat_meat", "mobs:meat_raw")
mobs:alias_mob("mobs:rat_cooked", "mobs:meat")
