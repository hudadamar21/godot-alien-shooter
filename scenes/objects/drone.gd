extends CharacterBody2D

var health: int = 100

func _process(_delta):
	var direction = Vector2.RIGHT 
	velocity = direction * 200
	move_and_slide()

func hit():
	var tween = create_tween()
	tween.tween_property($Sprite2D,"flip_h", true, 0.1)
	tween.tween_property($Sprite2D,"flip_h", false, 0.1)
	health -= 10
	if health == 0:
		queue_free()
