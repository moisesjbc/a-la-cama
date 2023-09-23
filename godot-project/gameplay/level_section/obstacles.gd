extends Area2D




func _on_obstacles_body_entered(body):
	body.destroy()
