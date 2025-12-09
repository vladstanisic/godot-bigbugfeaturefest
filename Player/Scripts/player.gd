class_name Player extends CharacterBody2D

#Reference to a separate scene that contains the actual indicator
const DEBUG_JUMP_INDICATOR = preload("uid://8ujwm3bfimf0")
var debug_enabled = false

#region /// on ready variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_raycast: RayCast2D = $OneWayPlatformRaycast
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
#endregion


#region /// export variables
@export var move_speed : float = 150
@export var jump_height : float = 100

#endregion


#region /// State Machine Variables
var states : Array[ PlayerState ]
var current_state : PlayerState : 
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// standard variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_multiplier : float = 0.0
#endregion



func _ready() -> void:
	initialize_states()
	label.visible = false

	pass
	
func _toggle_child():
	return
	

func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handle_input(event) )
	pass

func _process(_delta: float) -> void:
	update_direction()
	change_state( current_state.process(_delta) )
	
	pass


func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta * gravity_multiplier
	move_and_slide()
	change_state( current_state.physics_process(_delta) )
	pass


func initialize_states() -> void:
	states = []
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
		pass

	if states.size() == 0:
		return


	#initialize all states
	for state in states:
		state.init()
		
	change_state( current_state )
	current_state.enter()
	$Label.text = current_state.name
	
	#set our first state
	pass


func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
		
	states.push_front(new_state)
	current_state.enter()
	states.resize( 3 )
	$Label.text = current_state.name
	
	pass
	
func update_direction() -> void:
	var prev_direction : Vector2 = direction
	
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	
	if prev_direction.x != direction.x:
		if direction.x > 0:
			sprite.flip_h = true
		if direction.x < 0:
			sprite.flip_h = false
	pass

# This function instantiates the Debug Jump Indicator scene and places it
# by the players global position
func jump_indicator( color : Color = Color.RED ) -> void:
	if debug_enabled:
		var debug_instance : Node2D = null
		debug_instance = DEBUG_JUMP_INDICATOR.instantiate()
		get_tree().root.add_child( debug_instance )

		
		# Change the color to red
		debug_instance.global_position = global_position
		debug_instance.modulate = color
		
		# Creates a 3s timer that deletes the d-variable after its done

		await get_tree().create_timer(3.0).timeout
		debug_instance.queue_free()
	
	pass
	
