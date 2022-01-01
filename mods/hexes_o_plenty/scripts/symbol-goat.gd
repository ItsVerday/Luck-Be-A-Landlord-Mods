extends "res://Mod Data.gd"

func _init():
    mod_type = "symbol"
    type = "hexes_o_plenty.goat"
    display_name = "Goat"
    value = 2
    description = "Adjacent <group_hex> and <last_hex> give <color_E14A68><value_1>x<end> more <icon_coin>. Has a <color_E14A68><value_2>%<end> chance to <color_E14A68>add<end> <icon_milk>."
    values = [1.5, 5]
    rarity = "uncommon"
    groups = ["spawner0", "organism", "animal", "witchlikes", "farmerlikes", "fossillikes"]
    sfx = ["jump"]
    effects = [
        { # Buff adjacent hexes by 1.5x
            "effect_type": "adjacent_symbols",
            "comparisons": [
                {
                    "a": "groups",
                    "b": "hex"
                }
            ],
            "value_to_change": "value_multiplier",
            "diff": values[0]
        },
        { # 5% chance to add milk
            "comparisons": [
                { # values[0]% chance [5%] of activating
                    "a": { # Random number between 0 and 100
                        "starting_value": {
                            "rand_num": {
                                "min": 0,
                                "max": 100
                            }
                        }
                    },
                    "b": values[1], # 5%
                    "less_than": true
                }
            ],
            "one_time": true, # Only activate once per turn
            "tiles_to_add": [
                { # Add another hex of cloning
                    "type": "milk"
                }
            ], # Animate + Sound
            "anim": "bounce",
            "sfx_type": 0,
            "forbidden_items": [
                "conveyor_belt"
            ]
        },
        { # 10% chance to add milk
            "comparisons": [
                { # values[0]% chance [10%] of activating
                    "a": { # Random number between 0 and 100
                        "starting_value": {
                            "rand_num": {
                                "min": 0,
                                "max": 100
                            }
                        }
                    },
                    "b": values[1] * 2, # 10%
                    "less_than": true
                }
            ],
            "one_time": true, # Only activate once per turn
            "tiles_to_add": [
                { # Add another hex of cloning
                    "type": "milk"
                }
            ], # Animate + Sound
            "anim": "bounce",
            "sfx_type": 0,
            "required_items": [
                "conveyor_belt"
            ]
        }
    ]