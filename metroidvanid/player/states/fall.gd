class_name PlayStateFall extends PlayState




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

	return next_state




#状态物理渲染处理函数
func physics_process( _delta: float) -> PlayState:
	if player.is_on_floor():
		#指示器，测试用
		player.add_debug_indicator( Color.CRIMSON )
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
