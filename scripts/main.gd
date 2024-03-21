extends Node2D

func _on_ball_timer_timeout():
	$Ball.new_ball()
