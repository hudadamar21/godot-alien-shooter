extends StaticBody2D

class_name ItemContainer

@onready var current_direction: Vector2 =  Vector2.DOWN.rotated(rotation)
var opened: bool = false
var can_open: bool = false

signal open(pos, direction) 

func hit():
	print('hitted')

func _process(_delta):
	if Input.is_action_pressed("action") and can_open:
		hit()

func _on_area_2d_body_entered(_body):
	can_open = true


func _on_area_2d_body_exited(_body):
	can_open = false
