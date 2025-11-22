class_name PlayStateIdle extends PlayState




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
	if _event.is_action_pressed( "jump" ):
		return jump
	return next_state
	
#状态帧渲染处理函数    
func process( _delta: float) -> PlayState:
	
	#玩家水平方向不等于0
	if player.direction.x != 0:
		return run
	#玩家数值方向大于0.5
	elif player.direction.y > 0.5:
		return crouch
	return next_state




#状态物理渲染处理函数
func physics_process( _delta: float) -> PlayState:
	#水平向量=0
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state
