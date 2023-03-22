extends StaticBody2D

var player

var health = 10

var cooldown = false
var attacking = false

var attack_rate = 3 #every time the idle animation runs # of times then it attackings
var attacking_range = 500

var attacking_direction
var can_switch_animation = true
var shot = false #how many times has shot per attack

func _physics_process(delta):
	player = get_node_or_null("/root/Scene/Player")
	if not player == null:
		if attacking:
			attacking()
		elif not cooldown:
			if can_attack() != Vector2.ZERO:
				print("-Attack")
				attacking_direction = can_attack()
				attacking()
		elif cooldown:
			idle()

#If the player attack finished then start timer
func cooldown_timer(var time):
	cooldown = true
	var t = Timer.new()
	t.set_wait_time(time)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	cooldown = false

func idle():
	pass

func can_attack():
	if global_position.distance_to(player.global_position) <= attacking_range:
		var detect_terrain = $Detect_Terrain
		detect_terrain.cast_to = player.global_position - global_position
		if not detect_terrain.is_colliding(): #if not colliding with terrain
			var dir = (player.global_position - global_position).normalized()
			return dir
	return Vector2.ZERO

func attacking():
	if not attacking:
		$AnimatedSprite.play("Shoot")
		attacking = true
	else:
		if $AnimatedSprite.frame == 2:
			shot = true
			generate_bullet(attacking_direction)
			if $Line2D.get_point_count() != 0:
				$Line2D.clear_points()
			$Line2D.add_point($Gun.global_position - global_position)
			$Line2D.add_point(attacking_direction*100.0)
		elif $AnimatedSprite.frame == 4:
			$AnimatedSprite.play("Idle")
			cooldown_timer(attack_rate)
			attacking = false
			shot = false
			if $Line2D.get_point_count() != 0:
				$Line2D.clear_points()

func generate_bullet(var vector):
	pass





