extends CanvasLayer 

@onready var menu_root = $pauseSlide # Targets the child node!
var is_paused : bool = false
var slide_duration : float = 0.3 

func _ready():
	menu_root.visible = false
	call_deferred("reset_menu_position")

func reset_menu_position():
	var screen_width = get_viewport().get_visible_rect().size.x
	menu_root.position.x = screen_width

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
	
	var screen_width = get_viewport().get_visible_rect().size.x
	var menu_width = menu_root.size.x
	
	var off_screen_x = screen_width
	var on_screen_x = screen_width - menu_width
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	if is_paused:
		menu_root.visible = true
		tween.tween_property(menu_root, "position:x", on_screen_x, slide_duration)
	else:
		tween.tween_property(menu_root, "position:x", off_screen_x, slide_duration)
		tween.tween_callback(func(): menu_root.visible = false)

func _on_resume_button_pressed():
	toggle_pause()


func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_options_menu_pressed() -> void:
	if $pauseSlide/VBoxContainer.visible:
		$pauseSlide/VBoxContainer.visible = false
		$pauseSlide/VBoxContainer2.visible = true
	else:
		$pauseSlide/VBoxContainer2.visible = false
		$pauseSlide/VBoxContainer.visible = true


func _on_fullScreen_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
 
