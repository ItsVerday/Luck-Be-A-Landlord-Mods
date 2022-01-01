extends "res://Mod Data.gd"

func _init():
    mod_type = "item"
    type = "hexes_o_plenty.cursed_tome"
    display_name = "Cursed Tome"
    value = 0
    description = "<group_hex> and <last_hex> give <color_E14A68><value_1>x<end> more <icon_coin>. <group_hex> and <last_hex> are <color_E14A68>2x<end> as likely to activate random effects."
    values = [2]
    rarity = "rare"
    groups = []
    effects = [
        { # Buff hexes by 2x
            "effect_type": "symbols",
            "comparisons": [
                {
                    "a": "groups",
                    "b": "hex"
                }
            ],
            "value_to_change": "value_multiplier",
            "diff": values[0]
        },
        { # Buff vanilla hex chance
            "effect_type": "symbols",
            "comparisons": [
                {
                    "a": "groups",
                    "b": "hex"
                }
            ],
            "value_to_change": "bonus_value_multipliers",
            "diff": 2
        }
    ]