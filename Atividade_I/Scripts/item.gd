extends Area2D

var player: Node2D = null

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		Global.prismatic_coins += 1
		queue_free()
	
	
