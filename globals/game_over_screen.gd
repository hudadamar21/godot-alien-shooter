extends CanvasLayer


func on_game_over():
	Globals.is_game_over = true
	var tween = create_tween()
	tween.parallel()
	tween.tween_property($ColorRect, 'modulate:a', 255, 0)
	tween.tween_property($MarginContainer/RestartButton, 'modulate:a', 255, 0)

func _on_restart_button_pressed():
	if Globals.is_game_over:
		Globals.player_reset()
		var tween = create_tween()
		tween.parallel()
		tween.tween_property($ColorRect, 'modulate:a', 0, 0)
		tween.tween_property($MarginContainer/RestartButton, 'modulate:a', 0, 0)
		
		get_tree().reload_current_scene()
		TransitionLayer.change_scene("res://scenes/levels/outside.tscn")	
		Globals.is_game_over = false
