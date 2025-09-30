extends CharacterBody2D

@export var speed: float = 100.0
@export var hp: int = 5

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()

func take_damage(amount: int) -> void:
	hp -= amount
	Global.player_health = hp
	print("Tomou dano, vida q falta: ", hp)

	if hp <= 0:
		die()

func die() -> void:
	print("Morreu zé")
	queue_free() 
