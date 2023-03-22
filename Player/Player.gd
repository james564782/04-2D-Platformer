extends KinematicBody2D

onready var SM = $StateMachine
onready var AS = $AnimatedSprite

var velocity = Vector2.ZERO
var direction = 1

export var gravity = Vector2(0,14)

export var move_speed = 10
export var max_move = 100
export var jump_power = 500
export var dash_speed = 300
export var apex_velocity_threshold = 100
export var shoot_cooldown = 0.5

var in_air_value = 1 #either 0, 1, or 2 representing whether it is going up, at the apex of the jump, or falling
var dash_direction = Vector2(0, 1)

var shooting = false
var dashing = false
var can_dash = true

var detects_ground = false

export var health = 10

func damage(var damage):
	health -= damage

func jump():
	velocity = Vector2(velocity.x, velocity.y - (jump_power))

func shoot():
	shooting = true
	var input = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
	if input.x == 0:
		input = Vector2(direction, input.y)
	generate_bullet(input)
	var t = Timer.new()
	t.set_wait_time(shoot_cooldown)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	shooting = false

func generate_bullet(var vector):
	print("Shoot: " + str(vector.x) + " " + str(vector.y))

func _physics_process(_delta):
	detects_ground = $Detect_Ground.is_colliding()
	$RichTextLabel.text = "Health: " + str(health)
	velocity.x = clamp(velocity.x,-max_move,max_move)
	if direction < 0 and not $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = true
		if $Gun.scale.x == 1:
			$Gun.scale = Vector2(-1, 1)
	if direction > 0 and $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = false
		if $Gun.scale.x == -1:
			$Gun.scale = Vector2(1, 1)

func set_direction(d):
	direction = d

func set_animation(anim):
	#if has same number of frames then set it on same frame as well as long as it is not dash
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): 
		var frameCount = $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation)
		var frame = $AnimatedSprite.frame
		$AnimatedSprite.play(anim)
		if not anim == "Dash":
			if frameCount == $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation):
				$AnimatedSprite.frame = frame
			elif frameCount - 4 == $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation):
				$AnimatedSprite.frame = frame - 4
			elif frameCount == $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation) - 4:
				$AnimatedSprite.frame = frame + 4
	else: 
		$AnimatedSprite.play()

