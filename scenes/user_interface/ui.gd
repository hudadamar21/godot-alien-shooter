extends CanvasLayer

@onready var laser_label: Label = $MarginContainer2/Control/HBoxContainer/LaserCounter/Label
@onready var grenade_label: Label = $MarginContainer2/Control/HBoxContainer/GrenadeCounter/Label
@onready var laser_icon: TextureRect = $MarginContainer2/Control/HBoxContainer/LaserCounter/TextureRect
@onready var grenade_icon: TextureRect = $MarginContainer2/Control/HBoxContainer/GrenadeCounter/TextureRect
@onready var health_value: TextureProgressBar = $MarginContainer/HealtBar

var red_color: Color = Color("ff4636")
var green_color: Color = Color("ffffff")

func _ready():
	update_laser_text()
	update_grenade_text()
	update_health_value()

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func update_health_value():
	health_value.value = Globals.health_amount

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount == 0:
		label.modulate = red_color
		icon.modulate = red_color
	else:
		label.modulate = green_color
		icon.modulate = green_color
	
