extends CharacterBody2D
class_name NonPlayableCharacter

@export var min_walk_cycle: int = 2
@export var max_walk_cycle: int = 6
@export var min_audio_wait_time: int = 4
@export var max_audio_wait_time: int = 10
@export var audio_play_time_component: Timer

var walk_cycles: int
var current_walk_cycle: int

func _ready() -> void:
	walk_cycles = randi_range(min_walk_cycle, max_walk_cycle)
	audio_play_time_component.wait_time = randi_range(min_audio_wait_time, max_audio_wait_time)
