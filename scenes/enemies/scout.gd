extends CharacterBody2D

@onready var health: int = $TextureProgressBar.max_value
var player_nearby: bool
var can_laser: bool = true
var vulnerable: bool = true
var right_gun_use: bool = true

signal laser(pos, direction)

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var pos: Vector2 = $LaserSpawnPositions.get_child(right_gun_use).global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			right_gun_use = not right_gun_use
			$Timers/LaserTimer.start()
	

func _on_area_2d_body_entered(_body):
	player_nearby = true

func _on_area_2d_body_exited(_body):
	player_nearby = false

func _on_laser_cooldown_timeout():
	can_laser = true

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/HitTimer.start()
		$TextureProgressBar.value -= 10
		$Sprite2D.material.set_shader_parameter('progress', 0.8)
	if health <= 0:
		queue_free()


func _on_laser_timer_timeout():
	can_laser = true


func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter('progress', 0)