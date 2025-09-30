extends CharacterBody2D

@export var speed: float = 60.0
@export var damage: int = 1

var skins: Array[Texture2D] = [
	preload("res://Sprites/SlimeAmarelo.png"),
	preload("res://Sprites/SlimeAzul.png"),
	preload("res://Sprites/SlimeVermelho.png")
]

var player: Node2D = null

func _ready() -> void:
	if skins.size() > 0:
		$Sprite2D.texture = skins[randi_range(0, skins.size() - 1)]

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_campo_de_visao_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body

func _on_campo_de_visao_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player = null


func _on_hit_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
