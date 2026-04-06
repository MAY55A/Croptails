extends CanvasLayer

@onready var start_game_button: Button = $MarginContainer/VBoxContainer/StartGameButton
@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton

func _ready() -> void:
	save_game_button.disabled = !SaveGameManager.allow_save_game
	if SaveGameManager.allow_save_game:
		start_game_button.text = "Resume"
		save_game_button.focus_mode = Control.FOCUS_ALL
	else:
		save_game_button.focus_mode =  Control.FOCUS_NONE

func _on_start_game_button_pressed() -> void:
	# Only load at the start of the game to prevent unnecessary reloading when resuming
	if !SaveGameManager.allow_save_game:
		GameManager.start_game()
	queue_free()


func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game()


func _on_exit_game_button_pressed() -> void:
	GameManager.exit_game()
