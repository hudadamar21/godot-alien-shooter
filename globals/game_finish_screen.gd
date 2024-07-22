extends CanvasLayer


func on_game_finish():
	Globals.is_game_finish = true
	var tween = create_tween()
	tween.parallel()
	tween.tween_property($ColorRect, 'modulate:a', 255, 0)
	tween.tween_property($Button, 'modulate:a', 255, 0)

func _on_button_pressed():
	if Globals.is_game_finish:
		Globals.player_reset()
		var tween = create_tween()
		tween.parallel()
		tween.tween_property($ColorRect, 'modulate:a', 0, 0)
		tween.tween_property($Button, 'modulate:a', 0, 0)
		
		get_tree().reload_current_scene()
		TransitionLayer.change_scene("res://scenes/levels/outside.tscn")	
		Globals.is_game_finish = false
