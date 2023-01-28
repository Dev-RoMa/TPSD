extends VehicleBody

var max_rpm = 500
var max_torque = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	steering = lerp(steering, Input.get_axis("ui_right","ui_left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("ui_down","ui_up")
	var rpm = $rearRightWheel.get_rpm()
	$rearRightWheel.engine_force = acceleration * max_torque * ( 1 - rpm / max_rpm)
	rpm = $rearLeftWheel.get_rpm()
	$rearLeftWheel.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
