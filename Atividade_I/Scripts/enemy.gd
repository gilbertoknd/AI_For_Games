extends CharacterBody2D

@export var speed: float = 65.0
@export var damage: int = 1

var patrol_target = Vector2.ZERO
var player: Node2D = null

var skins: Array[Texture2D] = [
	preload("res://Sprites/SlimeAmarelo.png"),
	preload("res://Sprites/SlimeAzul.png"),
	preload("res://Sprites/SlimeVermelho.png")
]

func _ready() -> void:
	if skins.size() > 0:
		$Sprite2D.texture = skins[randi_range(0, skins.size() - 1)]
	
	choose_new_patrol_point()

func _physics_process(delta: float) -> void:
	if player:
		move_towards(player.global_position)
	else:
		move_towards(patrol_target)
		if global_position.distance_to(patrol_target) < 10:
			choose_new_patrol_point()

	move_and_slide()


#Sinais
func _on_campo_de_visao_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body

func _on_campo_de_visao_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player = null

func _on_hit_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(damage)


#Func aux
func choose_new_patrol_point():
	patrol_target = Vector2(randi_range(0, 768), randi_range(0, 768))

func move_towards(target: Vector2):
	var direction = (target - global_position).normalized()
	velocity = direction * speed
