minetest.register_alias("wool:dark_blue", "wool:blue")
minetest.register_alias("wool:gold", "wool:yellow")

function default.node_wool_defaults(table)

	table = table or {}

	table.footstep = table.footstep or
		{name = "wool_coat_movement", gain = 1.0}

	table.dug = table.dug or
		{name = "wool_coat_movement", gain = 0.25}

	table.place = table.place or
		{name = "default_place_node", gain = 1.0}

	return table
end

local wool_sound = default.node_wool_defaults()
--local wool_sound = default.node_sound_leaves_defaults()

local wool_dyes = {
	{"white", "White"},
	{"grey", "Grey"},
	{"black", "Black"},
	{"red", "Red"},
	{"yellow", "Yellow"},
	{"green", "Green"},
	{"cyan", "Cyan"},
	{"blue", "Blue"},
	{"magenta", "Magenta"},
	{"orange", "Orange"},
	{"violet", "Violet"},
	{"brown", "Brown"},
	{"pink", "Pink"},
	{"dark_grey", "Dark Grey"},
	{"dark_green", "Dark Green"},
}

for _, row in pairs(wool_dyes) do

	minetest.register_node("wool:" .. row[1], {
		description = row[2] .. " Wool",
		tiles = {"wool_" .. row[1] .. ".png"},
		groups = {
			snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,
			flammable = 3, wool = 1
		},
		sounds = wool_sound,
	})

	minetest.register_craft({
		type = "shapeless",
		output = "wool:" .. row[1],
		recipe = {"dye:" .. row[1], "group:wool"},
	})

end