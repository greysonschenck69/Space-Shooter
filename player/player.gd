extends CharacterBody2D


var speed = 5
var max_speed = 400
var rotate_speed = 0.08
var nose = Vector2(0,-80)
var Bullet = load("res://Player/Bullet.tscn")

func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("Forward"):
		to_return += Vector2(0,-1)
		$Exhaust.show()
	if Input.is_action_pressed("Left"):
		rotation_degrees -= rotate_speed
	if Input.is_action_pressed("Right"):
		rotation_degrees += rotate_speed
	return to_return.rotated(rotation)

func _physics_process(_delta):
	velocity += get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	position.x = wrapf(position.x, 0.0, 1152.0)
	position.y = wrapf(position.y, 0.0, 648.0)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot"):
		var bullet = Bullet.instantiate()
		bullet.rotation = rotation
		bullet.global_position = global_position + nose.rotated(rotation)
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			Effects.add_child(bullet)
