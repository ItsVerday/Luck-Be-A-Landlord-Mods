extends "res://Mod Data.gd"

func _init():
    mod_type = "symbol"
    type = "hexes_o_plenty.hex_of_transformation"
    display_name = "Hex of Transformation"
    value = 3
    description = "Has a <color_E14A68><value_1>%<end> chance of <color_E14A68>destroying<end> a <color_E14A68>random adjacent<end> <group_organism> or <last_organism> and <color_E14A68>adding<end> another one of those symbols."
    values = [30]
    rarity = "uncommon"
    groups = ["hex", "witchlikes", "fossillikes"]
    sfx = []
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
        { # Base chance, no Cursed Tome.
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": 100 - values[0],
                    "greater_than": true
                }
            ],
            "forbidden_items": [
                "holy_water",
                "hexes_o_plenty.cursed_tome"
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
        { # 2x chance for Cursed Tome.
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
                "holy_water"
            ],
            "forbidden_destroyed_items": [
                "holy_water_essence"
            ],
            "one_time": true,
            "value_to_change": "saved_value",
            "diff": -2,
            "overwrite": true
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
        { # Dark candle bonus.
            "comparisons": [
                {
                    "a": "saved_value",
                    "b": -2
                }
            ],
            "required_items": [
                "hexes_o_plenty.dark_candle"
            ],
            "one_time": true,
            "value_to_change": "value_bonus",
            "diff": 2
        },

        # Place your effects here.
        {
            "effect_type": "adjacent_symbols",
            "comparisons": [
                {
                    "a": {
                        "starting_value": "saved_value",
						"target_self": true
                    },
                    "b": -2
                },
                {
                    "a": "groups",
                    "b": "organism"
                }
            ],
            "one_time": true,
            "value_to_change": "destroyed",
            "diff": true,
            "anim": "rotate",
            "sfx_type": 0,
            "tiles_to_add": [
                { # Add another hex of cloning
                    "group": "organism"
                }
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