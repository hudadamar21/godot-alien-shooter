extends Area2D

@export var speed: int = 1500
var direction: Vector2 = Vector2.UP
var is_move: bool = true

func _ready():
	$SelfDestructTimer.start()

func _process(delta):
	if is_move:
		position += direction * speed * delta

func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	$DestroyTimer.start()
	$ParticleLaserDestory.emitting = true
	is_move = false
	$Sprite2D.visible = false


func _on_timer_timeout():
	queue_free()

func _on_destroy_timer_timeout():
	queue_free()
