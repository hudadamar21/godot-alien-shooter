extends Area2D


var rotation_speed = 5
var available_items = ['laser','laser','laser','laser', 'grenade', 'health']
var item = available_items[randi()%len(available_items)]

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready():
	
	if item == 'laser':
		$Sprite2D.modulate = Color('008bff')
	if item == 'grenade':
		$Sprite2D.modulate = Color('ff7200')
	if item == 'health':
		$Sprite2D.modulate = Color('00cf19')
		
	#tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0.2,0.2))
		
func _process(delta):
	$Sprite2D.rotation += rotation_speed * delta


func _on_body_entered(_body):
	if item == 'laser':
		Globals.laser_amount += 5
	if item == 'grenade':
		Globals.grenade_amount += 1
	if item == 'health' and Globals.health < 100:
		Globals.health += 20
	queue_free()