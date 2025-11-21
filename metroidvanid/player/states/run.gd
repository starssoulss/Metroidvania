class_name PlayStateRun extends PlayState



func init() -> void:
	pass


#进入状态处理函数
func enter() -> void:
	pass
	
	
#退出状态处理函数
func exit() -> void:
	pass
	
	
	
#状态处理输入函数,需要传入输入事件
func handle_input( _event : InputEvent ) -> PlayState:
	return next_state



#状态帧渲染处理函数    
func process( _delta: float) -> PlayState:
	if player.direction.x == 0:
		return idle
	return next_state




#状态物理渲染处理函数
func physics_process( _delta: float) -> PlayState:
	#水平向量等于水平朝向*100
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
