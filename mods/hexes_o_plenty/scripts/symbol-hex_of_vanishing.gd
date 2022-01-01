extends "res://Mod Data.gd"

func _init():
    mod_type = "symbol"
    type = "hexes_o_plenty.hex_of_vanishing"
    display_name = "Hex of Vanishing"
    value = 3
    description = "Has a <color_E14A68><value_1>%<end> chance of <color_E14A68>destroying<end> itself. Gives <color_FBF236><icon_coin><value_2><end> <color_E14A68>more<end> each spin."
    values = [30, 1]
    rarity = "uncommon"
    groups = ["hex", "witchlikes", "fossillikes"]
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
            "value_to_change": "destroyed",
            "diff": true
        },
        {
            "comparisons": [
                {
                    "a": "times_displayed",
                    "b": 1,
                    "greater_than": true
                }
            ],
            "one_time": true,
            "value_to_change": "permanent_bonus",
            "diff": values[1],
            "forbidden_items": [
                "holy_water"
            ],
            "forbidden_destroyed_items": [
                "holy_water_essence"
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

    effects = [
        { # 30% chance to transform a random hex
            "comparisons": [
                { # values[0]% chance [30%] of activating
                    "a": { # Random number between 0 and 100
                        "starting_value": {
                            "rand_num": {
                                "min": 0,
                                "max": 100
                            }
                        }
                    },
                    "b": values[0], # 30%
                    "less_than": true
                }
            ],
            "one_time": true, # Only activate once per turn
            # Destroy this organism
            "value_to_change": "destroyed",
            "diff": true,
            "anim": "rotate",
            "sfx_type": 0,
            "forbidden_items": [ # Don't do anything if there's holy water
                "holy_water"
            ],
            "forbidden_destroyed_items": [
                "holy_water_essence"
            ]
        },
        { # Increase value by 1 every spin
            "comparisons": [
                {
                    "a": "times_displayed",
                    "b": 1,
                    "greater_than": true
                }
            ],
            "one_time": true,
            "value_to_change": "permanent_bonus",
            "diff": values[1],
            "forbidden_items": [ # Don't do anything if there's holy water
                "holy_water"
            ],
            "forbidden_destroyed_items": [
                "holy_water_essence"
            ]
        }
    ]