class_name Player extends CharacterBody2D


func _process(_delta: float) -> void:
	
	pass


func _physics_process(_delta: float) -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -100
	elif Input.is_action_pressed("right"):
		velocity.x = 100
	
	velocity.y = velocity.y + 980 * _delta 
	move_and_slide()
	pass







#region Pre-Generated movement script from Godot
#extends CharacterBody2D
#
#
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("left", "right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
#endregion
