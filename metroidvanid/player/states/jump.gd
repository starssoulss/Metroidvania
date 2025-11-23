class_name PlayStateJump extends PlayState

@export var jump_velocity : float = 450.0


func init() -> void:
	pass


#进入状态处理函数
func enter() -> void:
	#播放动画
	player.animation_player.play( "jump" )
	player.animation_player.pause()
	#施加跳跃速度
	player.velocity.y = -jump_velocity
	
	#指示器，测试用
	player.add_debug_indicator( Color.CHARTREUSE )
	
	#跳跃缓冲可变跳跃高度失效修复替代方案，方案1在掉落状态物理进程处理
	#if player.previous_state == fall and not Input.is_action_pressed( "jump" ):
		#await get_tree().physics_frame
		#player.velocity.y *= 0.5
		#player.change_state( fall )
		#pass
	
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
	
	set_jump_frame()

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
	
	
	
	
	
func set_jump_frame() -> void:
	#重映射动画帧，起跳速度，顶点，映射到0.0-0.5秒
	var frame : float = remap( player.velocity.y, -jump_velocity, 0.0, 0.0, 0.5 )
	player.animation_player.seek( frame, true )
	pass
