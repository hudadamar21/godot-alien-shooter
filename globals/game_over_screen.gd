extends CanvasLayer

func on_game_over():
	var tween = create_tween()
	tween.tween_property($ColorRect, 'modulate', Color("#ffffff"), 1)
