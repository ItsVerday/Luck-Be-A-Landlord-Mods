extends "res://Mod Data.gd"

func _init():
    mod_type = "symbol"
    type = "hexes_o_plenty.hex_of_necromancy"
    display_name = "Hex of Necromancy"
    value = 3
    description = "Has a <color_E14A68><value_1>%<end> chance of <color_E14A68>adding 1<end> symbol that was <color_E14A68>destroyed<end> this game."
    values = [30]
    rarity = "uncommon"
    groups = ["hex", "witchlikes", "fossillikes", "spawner0"]
    sfx = ["hex"]
    effects = [
        { # Mark symbol as needing to pick RNG number
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": 0
                }
            ],
            "one_time": true,
            "value_to_change": "saved_value",
            "diff": -1,
            "overwrite": true
        },
        { # Pick RNG number
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": -1                    
                }
            ],
            "value_to_change": "saved_value",
            "diff": {
                "starting_value": {
                    "rand_num": {
                        "min": 0,
                        "max": 100,
                        "ceil": true
                    }
                }
            },
            "overwrite": true
        },
        # Check RNG number for chance, use required/forbidden items to modify chances based on item inventory.
        { # Base chance, no Cursed Tome/Conveyor Belt.
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": 100 - values[0],
                    "greater_than": true
                }
            ],
            "forbidden_items": [
                "holy_water",
                "hexes_o_plenty.cursed_tome",
                "conveyor_belt"
            ],
            "forbidden_destroyed_items": [
                "holy_water_essence"
            ],
            "one_time": true,
            "value_to_change": "saved_value",
            "diff": -2,
            "overwrite": true,
            "anim": "rotate",
            "sfx_type": 0
        },
        { # 2x chance for Cursed Tome/no Conveyor Belt.
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": 100 - values[0] * 2,
                    "greater_than": true
                }
            ],
            "required_items": [
                "hexes_o_plenty.cursed_tome"
            ],
            "forbidden_items": [
                "holy_water",
                "conveyor_belt"
            ],
            "forbidden_destroyed_items": [
                "holy_water_essence"
            ],
            "one_time": true,
            "value_to_change": "saved_value",
            "diff": -2,
            "overwrite": true,
            "anim": "rotate",
            "sfx_type": 0
        },
        { # no Cursed Tome/2x chance for Conveyor Belt.
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": 100 - values[0] * 2,
                    "greater_than": true
                }
            ],
            "required_items": [
                "conveyor_belt"
            ],
            "forbidden_items": [
                "holy_water",
                "hexes_o_plenty.cursed_tome",
            ],
            "forbidden_destroyed_items": [
                "holy_water_essence"
            ],
            "one_time": true,
            "value_to_change": "saved_value",
            "diff": -2,
            "overwrite": true,
            "anim": "rotate",
            "sfx_type": 0
        },
        { # 2x chance for Cursed Tome/2x chance for Conveyor Belt.
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": 100 - values[0] * 2 * 2,
                    "greater_than": true
                }
            ],
            "required_items": [
                "hexes_o_plenty.cursed_tome",
                "conveyor_belt"
            ],
            "forbidden_items": [
                "holy_water",
            ],
            "forbidden_destroyed_items": [
                "holy_water_essence"
            ],
            "one_time": true,
            "value_to_change": "saved_value",
            "diff": -2,
            "overwrite": true,
            "anim": "rotate",
            "sfx_type": 0
        },
        { # If the RNG check doesn't pass, reset state.
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": 0,
                    "greater_than": true
                }
            ],
            "one_time": true,
            "value_to_change": "saved_value",
            "diff": 0,
            "overwrite": true
        },
        # Perform effects for RNG check if saved_value is -2, meaning the check passed.
        # Place your effects here.
        {
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": -2
                }
            ],
            "one_time": true,
            "tiles_to_add": [
                "prev_destroyed_symbol"
            ]
        },
        

        { # Reset state after effect if RNG check passed.
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": -2
                }
            ],
            "one_time": true,
            "value_to_change": "saved_value",
            "diff": 0,
            "overwrite": true
        }
    ]