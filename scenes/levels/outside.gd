extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
	Globals.current_scene = "inside"
	
func _on_house_player_entered():
	var tween = get_tree().create_tween()
	print('in')
	tween.tween_property($Player/Camera2D,"zoom", Vector2(0.5,0.5), 1)
	
func _on_house_player_exited():
	var tween = get_tree().create_tween()
	print('out')
	tween.tween_property($Player/Camera2D,"zoom", Vector2(0.4,0.4), 1)
