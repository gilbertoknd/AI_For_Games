extends Node2D

@export var map_size: Vector2 = Vector2(768, 768)   
@export var item_scenes: Array[PackedScene] = [preload("res://Scenes/item.tscn")]
@export var enemy_scenes: Array[PackedScene] = [preload("res://Scenes/enemy.tscn")]       
@export var num_items: int = 10                     
@export var num_enemies: int = 15                   

func _ready() -> void:
	spawn_initial(item_scenes, num_items)
	spawn_initial(enemy_scenes, num_enemies)

func spawn_initial(scene_list: Array[PackedScene], count: int) -> void: #Cena do objeto pra spawnar e quantidade
	if scene_list.is_empty():
		return

	for i in count:
		var scene = scene_list[randi_range(0, scene_list.size() - 1)]
		var instance = scene.instantiate()
		
		var pos = Vector2(
			randi_range(0, map_size.x),
			randi_range(0, map_size.y)
		)
		
		instance.position = pos
		add_child(instance)
