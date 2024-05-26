extends CharacterBody2D

var pos: Vector2 = Vector2.ZERO
var test_scale: float = 1
var max_speed: int = 600
var speed: int = max_speed

var can_laser: bool = true
var can_grenade: bool = true
var can_dodge: bool = true
var dodge_timer: bool = false

signal shoot_laser(pos, player_direction)
signal throw_grenade(pos, player_direction)

func _ready():
	$Node2D/Explosion.visible = false
	#pos = Vector2(300, 200)
	#position = pos
	#test_scale = 2
	#scale = Vector2(test_scale,test_scale)
	#$"..".test()
	
func _process(_delta):
	#pos.x += speed * delta
	#position = pos
	#test_scale += 0.001
	#scale = Vector2(test_scale, test_scale)
	
	var direction = Input.get_vector("left", "right","up", "down")
	if Input.is_action_just_pressed("dodge") and can_dodge:
		can_dodge = false
		dodge_timer = true
		$DodgeTimer.start()
		$CanDodgeTimer.start()
	
	if dodge_timer:
		velocity = direction * speed * 2
	else:
		velocity = direction * speed
	move_and_slide()
	Globals.player_position = global_position
	
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()


	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$ParticleLaserShot.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		shoot_laser.emit(selected_laser.global_position, player_direction)
		can_laser = false
		$LaserTimer.start()
		
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeTimer.start()
		var start_pos = $LaserStartPositions.get_children()[0].global_position
		throw_grenade.emit(start_pos, player_direction)
		
	var tween = create_tween()
	if Globals.current_scene == 'inside':
		tween.tween_property($BodyLight, "energy", 1.5, 0.5)
	if Globals.current_scene == 'outside':
		tween.tween_property($BodyLight, "energy", 0, 0.5)


func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true

func _on_dodge_timer_timeout():
	dodge_timer = false

func _on_can_dodge_timer_timeout():
	can_dodge = true
	
func hit():
	Globals.health -= 10
	$AudioStreamPlayer2D.play()
	
func hit_explosion():
	Globals.health -= 20
	$AudioStreamPlayer2D.play()
	$Node2D/AnimationPlayer.play("hit_explosion")
