extends Control

@onready var options_popup: PopupPanel = $OptionPopup
@onready var sound_checkbutton: CheckButton = $OptionPopup/CheckButton

func _ready() -> void:
	# Default: music is ON, button pressed if music is enabled
	sound_checkbutton.button_pressed = MusicManager.music_enabled

	# Connect the toggled signal
	sound_checkbutton.toggled.connect(_on_check_button_toggled)

func _process(delta: float) -> void:
	pass

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://assests/scenes/text_story.tscn")

func _on_options_button_pressed() -> void:
	options_popup.popup_centered()

func _on_check_button_toggled(pressed: bool) -> void:
	# Toggle music via MusicManager
	MusicManager.set_music_enabled(pressed)


func _on_button_3_pressed() -> void:
	get_tree().quit()# Replace with function body.
