extends Node2D

var can_open: bool = false

func _process(_delta):
	if Input.is_action_just_pressed("action") and can_open:
		if Globals.artefact_found == 6:
			var tween = get_tree().create_tween()
			tween.tween_property($StaticBody2D, 'modulate:a', 0, 0.5)
			$BlockedBreak.play()
			await get_tree().create_timer(0.5).timeout
			$StaticBody2D.queue_free()
		else:
			print('you need 6 artifact for breaking this')

func _on_area_2d_body_entered(body):
	can_open = true

func _on_area_2d_body_exited(body):
	can_open = false

func _on_stage_clear_area_body_entered(body):
	GameFinishScreen.on_game_finish()
