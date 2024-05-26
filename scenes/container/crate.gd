extends ItemContainer

var can_open: bool = false

func hit():
	if not opened:
		$LidSprite.hide()
		$AudioStreamPlayer2D.play()
		for i in range(5):
			var pos =  $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)
		opened = true

func _process(delta):
	if Input.is_action_pressed("action") and can_open:
		print('open')
		hit()

func _on_area_2d_body_entered(body):
	can_open = true


func _on_area_2d_body_exited(body):
	can_open = false
