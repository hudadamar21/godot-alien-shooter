extends CharacterBody2D

var health: int = 100
var active: bool = false
var speed: int = 300

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

func hit():
	var tween = create_tween()
	tween.tween_property($Sprite2D,"flip_h", true, 0.1)
	tween.tween_property($Sprite2D,"flip_h", false, 0.1)
	health -= 10
	if health <= 0:
		active = false
		$AnimationPlayer.play('explosion')
	

func _on_notice_area_body_entered(_body):
	active = true
