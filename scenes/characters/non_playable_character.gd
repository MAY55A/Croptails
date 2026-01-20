extends CharacterBody2D
class_name NonPlayableCharacter

@export var min_walk_cycle: int = 2
@export var max_walk_cycle: int = 6

var walk_cycles: int
var current_walk_cycle: int
