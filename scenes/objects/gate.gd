extends StaticBody2D

signal player_entered_gate(body)

func _on_gate_door_body_entered(body):
	player_entered_gate.emit(body)
