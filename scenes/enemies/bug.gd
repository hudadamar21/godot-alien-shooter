extends CharacterBody2D

var health: int = 20
var speed: int = 300

var active: bool = false
var player_near: bool = false
var vulnerable: bool = true

@onready var current_direction: Vector2 =  Vector2.DOWN.rotated(rotation)
signal open(pos, direction) 
	

func _process(_delta):
	var direction: Vector2 = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		look_at(Globals.player_position)
		move_and_slide()
		
		
func hit():
	if vulnerable:
		$AudioStreamPlayer2D.play()
		health -= 10
		vulnerable = false
		$Timers/HitTimer.start()
		var custom_material: ShaderMaterial = ShaderMaterial.new()
		custom_material.shader = preload("res://scenes/enemies/enemy.gdshader") 
		custom_material.set_shader_parameter('color', Color('#d4613e'))
		$AnimatedSprite2D.material = custom_material
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.3)
		$Particles/HitParticles.emitting = true
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		open.emit(position, current_direction)
		queue_free()


func _on_animated_sprite_2d_animation_finished():
	if player_near:
		$Timers/AttackTimer.start()
		Globals.health -= 10

func _on_attack_area_body_entered(_body):
	player_near = true
	print('ok')
	$AnimatedSprite2D.play('attack')

func _on_attack_area_body_exited(_body):
	player_near = false
	$AnimatedSprite2D.play('walk')

func _on_notice_area_body_entered(_body):
	active = true
	$AnimatedSprite2D.play('walk')

func _on_notice_area_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()

		
func _on_hit_timer_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter('progress', 0)

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play('attack')
