class_name PlayerStateJump extends PlayerState

# What happens when this state is initialized?
func init() -> void:

	pass


# What happens when we enter this state
func enter() -> void:
	# Play animation
	pass
	
	
	
# What happens when we exit this state?
func exit() -> void:
	pass
	
# What happens when an input is pressed?
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
		
	else:
		return null

func process(_delta: float) -> PlayerState:
	if player.direction.y > 0:
		return jump
	return next_state

# What happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.y = player.direction.y * player.jump_strength
	return next_state
