class_name PlayStateJump extends PlayState

@export var jump_velocity : float = 450.0


func init() -> void:
	pass


#进入状态处理函数
func enter() -> void:
	#播放动画
	
	#施加跳跃速度
	player.velocity.y -= jump_velocity
	
	#指示器，测试用
	player.add_debug_indicator( Color.CHARTREUSE )

	
	pass
	
	
#退出状态处理函数
func exit() -> void:
	
	#指示器，测试用
	player.add_debug_indicator( Color.DARK_ORANGE )
	
	pass
	
	
#状态处理输入函数,需要传入输入事件
func handle_input( event : InputEvent ) -> PlayState:
	#处理可变跳跃高度
	if event.is_action_released("jump"):
		player.velocity.y *= 0.5
		#return fall
	return next_state
	
#状态帧渲染处理函数    
func process( _delta: float) -> PlayState:

	return next_state




#状态物理渲染处理函数
func physics_process( _delta: float) -> PlayState:
	#落到地上返回待机状态
	if player.is_on_floor():
		return idle
	#在顶点开始下落时变为fall
	elif player.velocity.y >= 0:
		return fall
	
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
