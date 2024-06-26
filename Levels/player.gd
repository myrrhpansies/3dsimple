extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_backwards")
	
	apply_central_force($twistPivot.basis * input * 1200.0 * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$twistPivot.rotate_y(twist_input)
	$twistPivot/pitchPivot.rotate_x(pitch_input)
	$twistPivot/pitchPivot.rotation.x = clamp(
		$twistPivot/pitchPivot.rotation.x,
		deg_to_rad(-30),
		deg_to_rad(30)
	)
func _unhandled_input(event: InputEvent) -> void:
	if event  is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
