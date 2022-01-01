extends "res://Mod Data.gd"

func _init():
    mod_type = "item"
    type = "hexes_o_plenty.dark_candle"
    display_name = "Dark Candle"
    value = 0
    description = "<group_hex> and <last_hex> give <color_FBF236><icon_coin><value_1><end> more."
    values = [2]
    rarity = "rare"
    groups = []
    effects = [
        { # Buff adjacent hexes by 2 coins
            "effect_type": "symbols",
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