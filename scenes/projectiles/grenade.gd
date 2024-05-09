extends RigidBody2D

const speed: int = 750
var explosion_active: bool = false
var explosion_radius: int = 250

func explode():
	$Explosion.visible = true
	$AnimationPlayer.play("explosion")
	explosion_active = true
	

func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		_on_target_got_explosion(targets)


func _on_target_got_explosion(targets):
	for target in targets:
		var in_range = target.global_position.distance_to(global_position) < explosion_radius
		if "hit" in target and in_range:
			target.hit()
