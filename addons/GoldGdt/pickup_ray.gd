extends RayCast3D

# Variables for interaction
var picked_object: RigidBody3D = null
@export var hold_offset: Vector3 = Vector3.ZERO
@export var move_speed: float = 15.0 # Adjust for faster/slower smoothing
@export var hold_distance: float = 2.0 # Distance to hold objects
@export var max_pickup_distance: float = 5.0 # Max distance to grab objects
@export var throw_force: float = 15.0 # Force applied when releasing with momentum

# Input actions
const INTERACT_ACTION = "pm_interact"

func _physics_process(delta: float):
	if Input.is_action_just_pressed(INTERACT_ACTION):
		if picked_object:
			drop_object()
		else:
			pick_up_object()
	elif picked_object:
		move_picked_object(delta)

# Try to pick up an object
func pick_up_object():
	if not is_colliding():
		return # No object to pick up

	var collider = get_collider()
	if collider and collider is RigidBody3D:
		picked_object = collider

		# Compute initial hold offset
		hold_offset = picked_object.global_transform.origin - global_transform.origin

# Drop the picked object
func drop_object():
	if picked_object:
		# Apply a small force to simulate throwing on release
		var throw_direction = -global_transform.basis.z
		picked_object.apply_impulse(Vector3.ZERO, throw_direction * throw_force)
		picked_object = null

# Move the picked object to follow the ray
func move_picked_object(delta: float):
	if not picked_object:
		return

	# Compute target position
	var ray_end = global_transform.origin + -global_transform.basis.z * hold_distance
	var target_position = ray_end + hold_offset

	# Compute velocity for smooth movement
	var current_position = picked_object.global_transform.origin
	var velocity = (target_position - current_position) * move_speed

	# Apply force to move the object
	picked_object.linear_velocity = velocity
