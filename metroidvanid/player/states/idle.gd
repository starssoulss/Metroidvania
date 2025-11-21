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
	return next_state
