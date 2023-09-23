extends MarginContainer


signal time_ended
var total_time: float = 0
var remaining_time: float = 0


func start(time):
	total_time = time
	remaining_time = time
	
	
func _physics_process(delta):
	if remaining_time > 0:
		remaining_time -= delta
		if remaining_time < 0:
			remaining_time = 0
			emit_signal("time_ended")
		$center_container/slider.set_value((1 - (remaining_time / total_time)) * 100)
