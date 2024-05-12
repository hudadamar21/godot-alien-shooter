extends CharacterBody2D

var health: int = 100
var speed: int = 300

var active: bool = false
var player_near: bool = false
var vulnerable: bool = true
	

func _process(_delta):
	var direction: Vector2 = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		look_at(Globals.player_position)
		move_and_slide()
		
		
func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/HitTimer.start()
		#$TextureProgressBar.value -= 10
		$AnimatedSprite2D.material.set_shader_parameter('progress', 0.2)
		$Particles/HitParticles.emitting = true
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()


func _on_animated_sprite_2d_animation_finished():
	if player_near:
		$Timers/AttackTimer.start()
		Globals.health -= 10

func _on_attack_area_body_entered(body):
	player_near = true
	$AnimatedSprite2D.play('attack')

func _on_attack_area_body_exited(body):
	player_near = false
	$AnimatedSprite2D.play('walk')

func _on_notice_area_body_entered(body):
	active = true
	$AnimatedSprite2D.play('walk')

func _on_notice_area_body_exited(body):
	active = false
	$AnimatedSprite2D.stop()

		
func _on_hit_timer_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter('progress', 0)

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play('attack')
