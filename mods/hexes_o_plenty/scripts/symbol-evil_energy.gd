extends "res://Mod Data.gd"

func _init():
    mod_type = "symbol"
    type = "hexes_o_plenty.evil_energy"
    display_name = "Evil Energy"
    value = 2
    description = "Adjacent <group_hex> and <last_hex> give <color_FBF236><icon_coin><value_1><end> more. Gives <color_FBF236><icon_coin><value_2><end> more for each adjacent <group_hex> or <last_hex>."
    values = [3, 2]
    rarity = "rare"
    groups = ["witchlikes", "fossillikes"]
    sfx = []
    effects = [
        { # Buff adjacent hexes by 3 coins
            "effect_type": "adjacent_symbols",
            "comparisons": [
                {
                    "a": "groups",
                    "b": "hex"
                }
            ],
            "value_to_change": "value_bonus",
            "diff": values[0]
        },
        { # Get buffed by adjacent hexes
            "effect_type": "reverse_adjacent_symbol",
            "reverse_groups": "hex",
            "comparisons": [],
            "value_to_change": "value_bonus",
            "diff": values[1]
        }
    ]