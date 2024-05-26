extends Node2D

class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
	for target in targets:
		target.connect('open', _on_item_appear)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect('laser', _on_scout_laser)

func _on_item_appear(item_position, item_direction):
	var item =  item_scene.instantiate()
	item.position = item_position
	item.direction = item_direction
	$Items.call_deferred("add_child", item)

func _on_player_shoot_laser(pos, player_direction):
	create_laser(pos, player_direction)
	
func _on_scout_laser(pos, direction):
	create_laser(pos, direction)

	
func _on_player_throw_grenade(pos, player_direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity =  player_direction * grenade.speed
	$Projectiles.call_deferred("add_child", grenade, true)

func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D,"zoom", Vector2(0.5,0.5), 1)
	
func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D,"zoom", Vector2(0.4,0.4), 1)
	
	
func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90 
	laser.direction = direction
	$Projectiles.add_child(laser, true)	
	

