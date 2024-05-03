extends Area2D


var rotation_speed = 5
var available_items = ['laser','laser','laser','laser', 'grenade', 'health']
var item = available_items[randi()%len(available_items)]


func _ready():
	
	if item == 'laser':
		$Sprite2D.modulate = Color('008bff')
	if item == 'grenade':
		$Sprite2D.modulate = Color('ff7200')
	if item == 'health':
		$Sprite2D.modulate = Color('00cf19')
		
func _process(delta):
	$Sprite2D.rotation += rotation_speed * delta


func _on_body_entered(body):
	body.add_item(item)
	queue_free()
