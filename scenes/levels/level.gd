extends Node2D

class_name ParentLevel

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _ready():
	pass
	#$Player.rotation_degrees = 90
	
func _process(_delta):
	pass 
	#$Player.rotation_degrees += 50 * delta
	#if $Player.pos.x > 1000:
		#print($Player.pos.x)
		#$Player.pos.x = 0
 
#func test():
	#print("Player - HP: " + str($Player.hp) + ", Exp: " + str($Player.exp) + ", Level: " + str($Player.level))

func _on_player_shoot_laser(pos, player_direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(player_direction.angle()) + 90 
	laser.direction = player_direction
	$Projectiles.add_child(laser, true)	

func _on_player_throw_grenade(pos, player_direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity =  player_direction * grenade.speed
	$Projectiles.add_child(grenade, true)	

func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D,"zoom", Vector2(0.5,0.5), 1)
	
func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D,"zoom", Vector2(0.4,0.4), 1)

