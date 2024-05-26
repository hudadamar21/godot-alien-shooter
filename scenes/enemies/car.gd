extends PathFollow2D


var player_near: bool = false

@onready var laser1: Line2D = $Turret/RayCast2D/Laser1
@onready var laser2: Line2D = $Turret/RayCast2D2/Laser2

@onready var gunfire1: Sprite2D = $Turret/GunFire1
@onready var gunfire2: Sprite2D = $Turret/GunFire2
var player: CharacterBody2D


func fire():
	$AudioStreamPlayer2D.play()
	gunfire1.modulate.a = 1
	gunfire2.modulate.a = 1
	await get_tree().create_timer(0.2).timeout
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gunfire1, "modulate:a", 0, randf_range(0.1, 0.3))
	tween.tween_property(gunfire2, "modulate:a", 0, randf_range(0.1, 0.3))
	
	if player_near:
		if "hit_explosion" in player:
			player.hit_explosion()

func _ready():
	laser1.add_point($Turret/RayCast2D.target_position)
	laser2.add_point($Turret/RayCast2D2.target_position)

func _process(delta):
	progress_ratio += 0.03 * delta
	if player_near:
		$Turret.look_at(Globals.player_position)


func _on_area_2d_body_entered(body):
	player = body
	player_near = true
	$AnimationPlayer.play("laser_load")


func _on_area_2d_body_exited(_body):
	player_near = false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(laser1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(laser2, "width", 0, randf_range(0.1, 0.5))
	await tween.finished
	$AnimationPlayer.stop()




