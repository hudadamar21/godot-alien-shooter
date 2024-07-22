extends Area2D

func _on_body_entered(_body):
	if(Globals.artefact_found < 6):
		Globals.artefact_found += 1
		queue_free()
	
