extends CharacterBody2D

var active: bool = false
var player_near: bool = false
var speed: int = 500
var vulnerable: bool = true
var health: int = 100

@onready var current_direction: Vector2 =  Vector2.DOWN.rotated(rotation)
signal open(pos, direction) 

func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_position
	
func _physics_process(_delta):
	if active:
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide() 
		var look_angle = direction.angle()
		rotation = look_angle + PI / 2
		
		
func attack():
	if player_near:
		Globals.health -= 20
		
func hit():
	if vulnerable:
		$AudioStreamPlayer2D.play()
		health -= 10
		vulnerable = false
		$Timers/HitTimer.start()
		if health <= 0:
			open.emit(position, current_direction)
			queue_free()

func _on_notice_area_body_entered(_body):
	active = true
	$AnimationPlayer.play('RESET')
	$AnimationPlayer.play('walk')


func _on_notice_area_body_exited(_body):
	active = false
	$AnimationPlayer.stop()


func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_position

func _on_attack_area_body_entered(_body):
	player_near = true
	$AnimationPlayer.play("attack")


func _on_attack_area_body_exited(_body):
	player_near = false
	$AnimationPlayer.play('RESET')
	$AnimationPlayer.play("walk")


func _on_hit_timer_timeout():
	vulnerable = true
