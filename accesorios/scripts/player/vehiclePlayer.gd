extends VehicleBody

#instrument Cluster
var instrument_cluster
#gear
var current_gear = 0
var gear_ratios = [0,1,1.5,2,2.5]

#engine
var max_rpm = 400
var max_torque = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	instrument_cluster = get_node("instrumentCluster")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	steering = lerp(steering, Input.get_axis("ui_right","ui_left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("ui_down","ui_up")
	var rpm = $rearRightWheel.get_rpm()
	$rearRightWheel.engine_force = acceleration * max_torque * gear_ratios[current_gear] * ( 1 - rpm / max_rpm)
	rpm = $rearLeftWheel.get_rpm()
	$rearLeftWheel.engine_force = acceleration * max_torque * gear_ratios[current_gear] * (1 - rpm / max_rpm)
	if Input.is_action_just_pressed("shiftUp"):
		if current_gear < gear_ratios.size()-1:
			current_gear += 1
	elif Input.is_action_just_pressed("shiftDown"):
		if current_gear > 0:
			current_gear -= 1
	#changing camera
	#instrument cluster print
	instrument_cluster.text = str("\ncurrent gear = ",current_gear,
	"\nrpm wheel = ", rpm
	)
