extends CharacterBody2D

var health: int = 30
var active: bool = false
var max_speed: int = 600
var speed: int = 100
var explosion_radius: int = 250
var vulnerable: bool = true
var explosion_active: bool = false 

func _ready():
	$Explosion.hide()
	$Sprite2D.show()

func _process(delta):
	if active:
		look_at(Globals.player_position)
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play('explosion')
			explosion_active = true
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		_on_target_got_explosion(targets)


func _on_target_got_explosion(targets):
	for target in targets:
		var in_range = target.global_position.distance_to(global_position) < explosion_radius
		if "hit" in target and in_range:
			target.hit()

func hit():
	if vulnerable:
		var tween = create_tween()
		tween.tween_property($Sprite2D,"flip_h", true, 0.1)
		tween.tween_property($Sprite2D,"flip_h", false, 0.1)
		$Sprite2D.material.set_shader_parameter('progress', 0.3)
		health -= 10
		if health <= 0:
			active = false
			$AnimationPlayer.play('explosion')
			explosion_active = true
	

func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter('progress', 0)
