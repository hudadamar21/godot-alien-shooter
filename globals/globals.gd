extends Node

signal stats_changed

var current_scene: String = 'outside'
var player_position: Vector2
var player_vunerable: bool = true
var is_game_over: bool = false
var is_game_finish: bool = false

var health = 100:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_vunerable:
				health = value
				player_vunerable = false
				player_invunerable_timer()
				if health <= 0:
					GameOverScreen.on_game_over()
		stats_changed.emit()

var laser_amount = 20:
	set(value):
		laser_amount = value
		stats_changed.emit()

var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stats_changed.emit()
		
var artefact_found = 0:
	set(value):
		artefact_found = value
		stats_changed.emit()
	
func player_reset():
	health = 100
	laser_amount = 20
	grenade_amount = 5
	artefact_found = 0

func player_invunerable_timer(): 
	await get_tree().create_timer(0.5).timeout
	player_vunerable = true
	
