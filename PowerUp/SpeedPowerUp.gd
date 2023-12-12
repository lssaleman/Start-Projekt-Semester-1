extends Area2D

var respawn_timer: Timer
signal on_collect_speed

func _ready():
	# Create and connect the timer
	respawn_timer = Timer.new()
	add_child(respawn_timer)
	respawn_timer.timeout.connect(_on_respawn_timer_timeout)

	# Set the respawn time (in seconds)
	respawn_timer.wait_time = 6  
	
func _on_body_entered(_body):
	emit_signal("on_collect_speed")
	respawn_timer.start()


func _on_respawn_timer_timeout():
	$Sprite2D.visible = true
	$CollisionShape2D.disabled = false
	# and make it visible again
	respawn_timer.stop()
	
func _process(_delta):
	# Check if the timer is running and disable collision accordingly
	if respawn_timer.time_left > 0:
		$Sprite2D.visible = false
		$CollisionShape2D.disabled = true
	else:
		# Ensure that the visibility and collision are in their default state
		$Sprite2D.visible = true    
		$CollisionShape2D.disabled = false
