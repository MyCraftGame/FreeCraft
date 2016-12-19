-- mods/default/tools.lua

--
-- Tool definition
--

-- The hand
minetest.register_item(":", {
    type = "none",
    wield_image = "wieldhand.png",
    wield_scale = {x=0.7,y=2,z=0.0001}, 
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
            snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
            choppy = {times={[3]=3}},
            cracky = {times={[10]=10, [3]=7.5}},
            oddly_breakable_by_hand = {times={[0]=90.00,[1]=7.00,[2]=3.00,[3]=3*3.33,[4]=250,[5]=999999.0,[6]=0.5}, uses=0, maxlevel=5}
        },
        damage_groups = {fleshy=1},
    }
})

-- Picks
minetest.register_tool("default:pick_wood", {
    description = "Wooden Pickaxe",
    inventory_image = "default_tool_woodpick.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            cracky = {times={[3]=1.60, [10]=1.60}, uses=10, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
    groups = {tools=1},
})
minetest.register_tool("default:pick_stone", {
    description = "Stone Pickaxe",
    inventory_image = "default_tool_stonepick.png",
    tool_capabilities = {
        full_punch_interval = 1.3,
        max_drop_level=0,
        groupcaps={
            cracky = {times={[2]=2.0, [3]=1.20, [3]=0.60}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=4},
    },
    groups = {tools=1},
})
minetest.register_tool("default:pick_steel", {
    description = "Steel Pickaxe",
    inventory_image = "default_tool_steelpick.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=1,
        groupcaps={
            cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80,[3]=0.40}, uses=20, maxlevel=2},
        },
        damage_groups = {fleshy=5},
    },
    groups = {tools=1},
})
minetest.register_tool("default:pick_gold", {
    description = "Gold Pickaxe",
    inventory_image = "default_tool_goldpick.png",
    tool_capabilities = {
        full_punch_interval = 1.3,
        max_drop_level=0,
        groupcaps={
            cracky = {times={[2]=2.0, [3]=1.20, [10]=0.30}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
    groups = {tools=1},
})
minetest.register_tool("default:pick_diamond", {
    description = "Diamond Pickaxe",
    inventory_image = "default_tool_diamondpick.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level=3,
        groupcaps={
            cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50,[4]=20.00,[3]=0.20 }, uses=30, maxlevel=4},
        },
        damage_groups = {fleshy=6},
    },
    groups = {tools=1},
})

-- Shovels
minetest.register_tool("default:shovel_wood", {
    description = "Wooden Shovel",
    inventory_image = "default_tool_woodshovel.png",
    wield_image = "default_tool_woodshovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
    groups = {tools=1},
})
minetest.register_tool("default:shovel_stone", {
    description = "Stone Shovel",
    inventory_image = "default_tool_stoneshovel.png",
    wield_image = "default_tool_stoneshovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.4,
        max_drop_level=0,
        groupcaps={
            crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
    groups = {tools=1},
})
minetest.register_tool("default:shovel_steel", {
    description = "Steel Shovel",
    inventory_image = "default_tool_steelshovel.png",
    wield_image = "default_tool_steelshovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.1,
        max_drop_level=1,
        groupcaps={
            crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
        },
        damage_groups = {fleshy=3},
    },
    groups = {tools=1},
})
minetest.register_tool("default:shovel_gold", {
    description = "Gold Shovel",
    inventory_image = "default_tool_goldshovel.png",
    wield_image = "default_tool_goldshovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.4,
        max_drop_level=0,
        groupcaps={
            crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
    groups = {tools=1},
})
minetest.register_tool("default:shovel_diamond", {
    description = "Diamond Shovel",
    inventory_image = "default_tool_diamondshovel.png",
    wield_image = "default_tool_diamondshovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=1,
        groupcaps={
            crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
        },
        damage_groups = {fleshy=5},
    },
    groups = {tools=1},
})

-- Axes
minetest.register_tool("default:axe_wood", {
    description = "Wooden Axe",
    inventory_image = "default_tool_woodaxe.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
            choppy = {times={[2]=3.00, [3]=2.00}, uses=10, maxlevel=1},
        },
        damage_groups = {fleshy=1},
    },
    groups = {tools=1},
})
minetest.register_tool("default:axe_stone", {
    description = "Stone Axe",
    inventory_image = "default_tool_stoneaxe.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            choppy={times={[1]=3.00, [2]=2.00, [3]=1.50}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
    groups = {tools=1},
})
minetest.register_tool("default:axe_steel", {
    description = "Steel Axe",
    inventory_image = "default_tool_steelaxe.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=1,
        groupcaps={
            choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
        },
        damage_groups = {fleshy=5},
    },
    groups = {tools=1},
})
minetest.register_tool("default:axe_gold", {
    description = "Gold Axe",
    inventory_image = "default_tool_goldaxe.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            choppy={times={[1]=3.00, [2]=2.00, [3]=1.50}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
    groups = {tools=1},
})
minetest.register_tool("default:axe_diamond", {
    description = "Diamond Axe",
    inventory_image = "default_tool_diamondaxe.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level=1,
        groupcaps={
            choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=2},
        },
        damage_groups = {fleshy=6},
    },
    groups = {tools=1},
})

-- Swords
minetest.register_tool("default:sword_wood", {
    description = "Wooden Sword",
    inventory_image = "default_tool_woodsword.png",
    tool_capabilities = {
        full_punch_interval = 1,
        max_drop_level=0,
        groupcaps={
            snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
    groups = {combat=1},
})
minetest.register_tool("default:sword_stone", {
    description = "Stone Sword",
    inventory_image = "default_tool_stonesword.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            snappy={times={[2]=1.4, [3]=0.40}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=4},
    },
    groups = {combat=1},
})
minetest.register_tool("default:sword_steel", {
    description = "Steel Sword",
    inventory_image = "default_tool_steelsword.png",
    tool_capabilities = {
        full_punch_interval = 0.8,
        max_drop_level=1,
        groupcaps={
            snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
        },
        damage_groups = {fleshy=6},
    },
    groups = {combat=1},
})
minetest.register_tool("default:sword_gold", {
    description = "Gold Sword",
    inventory_image = "default_tool_goldsword.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            snappy={times={[2]=1.4, [3]=0.40}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=4},
    },
    groups = {combat=1},
})
minetest.register_tool("default:sword_diamond", {
    description = "Diamond Sword",
    inventory_image = "default_tool_diamondsword.png",
    tool_capabilities = {
        full_punch_interval = 0.7,
        max_drop_level=1,
        groupcaps={
            snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
        },
        damage_groups = {fleshy=7},
    },
    groups = {combat=1},
})

-- Fishing Pole
minetest.register_tool("default:pole", {
    description = "Fishing Rod",
    groups = {},
    inventory_image = "default_tool_fishing_pole.png",
    stack_max = 1,
    groups = {tools=1},
    liquids_pointable = true,
    on_use = function (itemstack, user, pointed_thing)
        if pointed_thing and pointed_thing.under then
            local node = minetest.get_node(pointed_thing.under)
            if string.find(node.name, "default:water") then
                if math.random(1, 100) > 50 then
                    local inv = user:get_inventory()
                    if inv:room_for_item("main", {name="default:fish_raw", count=1, wear=0, metadata=""}) then
                        inv:add_item("main", {name="default:fish_raw", count=1, wear=0, metadata=""})
                    end
                end
                itemstack:add_wear(66000/65) -- 65 uses
                return itemstack
            end
        end
        return nil
    end,
})
