extends CanvasLayer

func _physics_process(delta: float) -> void:
	$UI_VBoxContainer/HP_HBoxContainer/HP_Label.text = "%d" % Global.player_health
	$UI_VBoxContainer/Coins_HBoxContainer/Coins_Label.text = " %d" % Global.prismatic_coins
