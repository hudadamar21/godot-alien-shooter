extends RigidBody2D

const speed: int = 750

func explode():
	$Explosion.visible = true
	$AnimationPlayer.play("explosion")
