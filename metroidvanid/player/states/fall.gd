class_name PlayStateFall extends PlayState

@export var coyote_time : float = 0.2
@export var fall_gravity_mulitplier : float = 1.165 #临时重力系数，进入调整，结束重置
@export var jump_buffer_time : float = 0.2 #跳跃缓冲时间


var coyote_timer : float = 0
var buffer_timer : float = 0

func init() -> void:
	pass


#进入状态处理函数  
func enter() -> void:
	#播放动画
	player.animation_player.play( "jump" )
	player.animation_player.pause()
	player.gravity_mulitplier = fall_gravity_mulitplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer =coyote_time
	pass
	
	
#退出状态处理函数
func exit() -> void:
	player.gravity_mulitplier = 1.0
	
	#退出时清楚缓冲计时
	buffer_timer = 0
	pass
	
	
#状态处理输入函数,需要传入输入事件
func handle_input( event : InputEvent ) -> PlayState:
	if event.is_action_pressed( "jump" ):
		if coyote_timer >= 0:
			return jump
		else:
			buffer_timer = jump_buffer_time
	return next_state
	
#状态帧渲染处理函数    
func process( delta: float) -> PlayState:
	coyote_timer -= delta
	buffer_timer -= delta
	set_jump_frame()
	return next_state




#状态物理渲染处理函数
func physics_process( _delta: float) -> PlayState:
	if player.is_on_floor():
		#指示器，测试用
		#player.add_debug_indicator( Color.CRIMSON )
		
		#断仍在缓冲时间且jump仍在按键
		if buffer_timer > 0 and Input.is_action_pressed("jump"):
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
	
	
func set_jump_frame() -> void:
	#重映射动画帧，下落点，最大下落速度，映射到0.5-1.0秒
	var frame : float = remap( player.velocity.y, 0.0, player.max_fall_speed, 0.5, 1.0 )
	player.animation_player.seek( frame, true )
	pass
