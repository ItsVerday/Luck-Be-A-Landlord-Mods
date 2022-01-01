extends "res://Mod Data.gd"

func _init():
    mod_type = "symbol"
    type = "hexes_o_plenty.dark_energy"
    display_name = "Dark Energy"
    value = 1
    description = "Adjacent <group_hex> and <last_hex> give <color_FBF236><icon_coin><value_1><end> more."
    values = [1]
    rarity = "common"
    groups = ["witchlikes"]
    sfx = []
    effects = [
        { # Buff adjacent hexes by 1 coin
            "effect_type": "adjacent_symbols",
            "comparisons": [
                {
                    "a": "groups",
                    "b": "hex"
                }
            ],
            "value_to_change": "value_bonus",
            "diff": values[0]
        }
    ]