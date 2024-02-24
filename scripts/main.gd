extends Node2D

func _on_ball_timer_timeout():
	print("df")	
	$Ball.new_ball()
