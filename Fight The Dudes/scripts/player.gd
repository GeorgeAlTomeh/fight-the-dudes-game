extends CharacterBody3D

var speed 
@export var walk_speed : float = 5.0
@export var crouch_speed : float = 2.5
@export var sprint_speed : float= 7.5
@export var jump_velocity : float = 4.5

var can_walk : bool = true
var is_sprinting : bool = false


# crouch variables
var is_crouching : bool = false
@export_range(5, 10, 0.1) var _crouch_speed : float = 7.0
@export var _toggle_crouch : bool = true 

# bob variables
const bob_frequency = 2.4
const bob_amplitude = 0.08
var t_bob = 0.0

# health variables
@export var health : int = 100;

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera
var sensitivity : float = 0.004

@onready var crouch_ceiling_detection: ShapeCast3D = $CrouchCeilingDetection

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# set default speed 
	speed = walk_speed
	
	# add crouch check chape cast collision exception for CharacterBody2D node
	crouch_ceiling_detection.add_exception($".")


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("exit"):
		get_tree().quit()
	
	# handle crouch
	if event.is_action_pressed("crouch") && is_on_floor() && _toggle_crouch == true:
		toggle_crouch()
	if event.is_action_pressed("crouch") && is_on_floor() && is_crouching == false && _toggle_crouch == false : # hold to crouch
		crouching(true)
	if event.is_action_released("crouch") && _toggle_crouch == false: # release to uncrouch
		if crouch_ceiling_detection.is_colliding() == false:
			crouching(false)
		elif crouch_ceiling_detection.is_colliding() == true:
			uncrouch_check()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_velocity
		
	# handle sprint
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
		is_sprinting = true
	else:
		speed = walk_speed 
		is_sprinting = false
		
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.x * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.x * speed, delta * 3.0)
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = head_bob(t_bob)
	
	# handle health decrease
	
	health = Global.health;
	$user_interface/labels/Label.text = str(health);
	
	if health <= 0:
		await get_tree().create_timer(0.1).timeout
		#get_tree().change_scene_to_file('res://scenes/lose_menu.tscn');
		$"../Control/menus/lose_menu".show()
		queue_free();
		Global.ui = true;
	
	if can_walk:
		move_and_slide()


func head_bob(time):
	var pos : Vector3 = Vector3.ZERO
	pos.y = sin(time * bob_frequency) * bob_amplitude
	pos.x = cos(time * bob_frequency / 2) * bob_amplitude
	return pos


func toggle_crouch():
	if is_crouching == true && crouch_ceiling_detection.is_colliding() == false:
		crouching(false)
	elif is_crouching == false:
		crouching(true)


func uncrouch_check():
	if crouch_ceiling_detection.is_colliding() == false:
		crouching(false)
	elif crouch_ceiling_detection.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch_check()


func crouching(state: bool):
	match state:
		true:
			animation_player.play("crouch", 0, _crouch_speed)
			set_movement_speed("crouch")
		false:
			animation_player.play("crouch", 0, -_crouch_speed, true)
			set_movement_speed("walk")


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "crouch":
		is_crouching = !is_crouching


func set_movement_speed(state: String):
	match state:
		"crouch":
			speed = crouch_speed
		"walk":
			speed = walk_speed
