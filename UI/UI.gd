extends Control

var max_health = 10
var health = 10

onready var Purple = Color(63.0 / 255.0, 44.0 / 255.0, 95.0 / 255.0, 1)
onready var Blue = Color(105.0 / 255.0, 128.0 / 255.0, 158.0 / 255.0, 1)
onready var Cyan = Color(149.0 / 255.0, 197.0 / 255.0, 172.0 / 255.0, 1)

func _ready():
	visible = true

func set_max_health(var h):
	max_health = h
	set_sprite()

func _process(delta):
	$Score.text = "Score: " + str(Global.score) 


func set_health(var h):
	health = h
	if health < 0:
		health = 0
	elif health > max_health:
		health = max_health
	set_sprite()

func set_sprite():
	if health == max_health:
		if not Cyan == null:
			set_heart_color(Cyan)
	elif health == 0:
		if not Purple == null:
			set_heart_color(Purple)
	else:
		if not Blue == null:
			set_heart_color(Blue)
	$Health_Bar/Color/Bar_Front.rect_size = Vector2(round(((1.0 * health) / (1.0 * max_health) * 256.0) + 0.5), 24) #Base rect is x:64, y:6

func set_bar_color(var color):
	$Health_Bar/Color/Bar_Front.color = color

func set_heart_color(var color):
	$Health_Bar/Color/Heart0.color = color
	$Health_Bar/Color/Heart1.color = color
	$Health_Bar/Color/Heart2.color = color
	$Health_Bar/Color/Heart3.color = color
	$Health_Bar/Color/Heart4.color = color
