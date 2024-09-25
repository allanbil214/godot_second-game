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
	
	if Input.is_action_just_pressed("kick"):
		if animation_player.current_animation != "kick":
			animation_player.play("kick")
			is_locked = true
	
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
	# As good practice, you should replace UI actions with custom gameplay actions.
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
					
		# Smoothly rotate the visual towards the direction
		var target_rotation_y = atan2(-input_dir.x, -input_dir.y)  # Calculate target yaw based on direction
		visual.rotation.y = lerp_angle(visual.rotation.y, target_rotation_y, SMOOTH_ROTATION_SPEED * delta)  # Smooth rotation

		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
			
	else:
		if !is_locked:
			if animation_player.current_animation != "Idle":
				animation_player.play("Idle")
			
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if !is_locked:
		move_and_slide()
