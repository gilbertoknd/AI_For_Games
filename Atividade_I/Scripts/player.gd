extends CharacterBody2D

@export var speed: float = 100.0
@export var dash_speed: float = 300.0      
@export var dash_time: float = 0.2         
@export var dash_cooldown: float = 0.4     
@export var hp: int = 5



var is_dashing: bool = false
var dash_dir: Vector2 = Vector2.ZERO
var dash_timer: float = 0.0
var cooldown_timer: float = 0.0

func _process(delta: float) -> void:
	#Vitória
	if Global.prismatic_coins >= 10 and not get_tree().paused:
		show_end_screen("🎉 Você Ganhou!")

	#Game Over
	if Global.player_health <= 0 and not get_tree().paused:
		show_end_screen("💀 Game Over")
		

func _physics_process(delta: float) -> void:
	#Atualiza os timers
	if dash_timer > 0:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			cooldown_timer = dash_cooldown

	if cooldown_timer > 0:
		cooldown_timer -= delta


	if is_dashing:
		velocity = dash_dir * dash_speed
	else:
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

		#Início do dash, só quando n tiver em cooldown
		if Input.is_action_just_pressed("dash") and direction != Vector2.ZERO and cooldown_timer <= 0:
			is_dashing = true
			dash_dir = direction
			dash_timer = dash_time

	move_and_slide()

func take_damage(amount: int) -> void:
	hp -= amount
	Global.player_health = hp
	print("Tomou dano, vida q falta: ", hp)

	if hp <= 0 and not get_tree().paused:
		die()

func die() -> void:
	print("Morreu zé")

func show_end_screen(message: String):
	var end_scene = preload("res://Scenes/end_screen.tscn").instantiate()
	end_scene.show_message(message)
	queue_free()
	#get_tree().root.add_child(end_scene)
	#get_tree().paused = true
	
