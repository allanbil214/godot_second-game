extends CharacterBody3D

var SPEED = 0.0
var is_running = false
var is_locked = false
# Set the vertical rotation limits
var min_camera_angle = -PI / 2  # -90 degrees
var max_camera_angle = PI / 2.2   # 90 degrees
@export var WalkingSpeed = 2.0
@export var RunningSpeed = 5.0
@export var JUMP_VELOCITY = 4.5	
@export var sens_h = 0.4
@export var sens_v = 0.4
@export var SMOOTH_ROTATION_SPEED = 15.0  # Speed of smooth rotation

# New variables for rotation completion
var target_rotation_y = 0.0
var is_rotating = false
var last_input_dir = Vector2.ZERO

@onready var camera_mount: Node3D = $camera_mount
@onready var animation_player: AnimationPlayer = $visual/aya/AnimationPlayer
@onready var visual: Node3D = $visual

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_h))
		visual.rotate_y(deg_to_rad(event.relative.x * sens_h))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_v))
		
		# Adjust camera mount rotation and clamp the vertical angle
		camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_v))
		camera_mount.rotation.x = clamp(camera_mount.rotation.x, min_camera_angle, max_camera_angle)
		# Wrap the horizontal Y-axis rotation
		camera_mount.rotation.y = wrapf(camera_mount.rotation.y, -PI, PI)

func _physics_process(delta: float) -> void:
	if !animation_player.is_playing():
		is_locked = false
	handle_kick()
	handle_movement(delta)

func handle_kick() -> void:
	if Input.is_action_just_pressed("kick"):
		if animation_player.current_animation != "kick":
			animation_player.play("kick")
			is_locked = true

func handle_movement(delta: float) -> void:
	if Input.is_action_pressed("run"):
		SPEED = RunningSpeed
		is_running = true
	else:
		SPEED = WalkingSpeed
		is_running = false

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		if !is_locked:
			if is_running:
				if animation_player.current_animation != "RunForward":
					animation_player.play("RunForward")
			else:
				if animation_player.current_animation != "Walking":
					animation_player.play("Walking")
		
		# Start rotation and store target
		if input_dir != last_input_dir:
			target_rotation_y = atan2(-input_dir.x, -input_dir.y)
			is_rotating = true
			last_input_dir = input_dir
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if !is_locked:
			if animation_player.current_animation != "Idle":
				animation_player.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		last_input_dir = Vector2.ZERO

	# Handle rotation independently from movement
	if is_rotating:
		var angle_diff = wrapf(target_rotation_y - visual.rotation.y, -PI, PI)
		if abs(angle_diff) > 0.01:
			visual.rotation.y = lerp_angle(visual.rotation.y, target_rotation_y, SMOOTH_ROTATION_SPEED * delta)
		else:
			visual.rotation.y = target_rotation_y
			is_rotating = false

	if !is_locked:
		move_and_slide()
