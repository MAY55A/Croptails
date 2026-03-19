extends Node
class_name FieldCursorComponent

@export var grass_tilemap_layer: TileMapLayer
@export var tilled_soil_tilemap_layer: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 1

var player: Player

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("remove_dirt"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			remove_tilled_soil_cell()
	elif event.is_action_pressed("hit"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			add_tilled_soil_cell()

func _get_mouse_world() -> Vector2:
	var vp := get_viewport()
	var mouse_screen: Vector2 = vp.get_mouse_position()
	return vp.get_canvas_transform().affine_inverse() * mouse_screen

func _cell_on_layer(layer: TileMapLayer, mouse_world: Vector2) -> Vector2i:
	var mouse_local: Vector2 = layer.to_local(mouse_world)
	return layer.local_to_map(mouse_local)

func get_cell_under_mouse() -> void:
	var mouse_world: Vector2 = _get_mouse_world()
	cell_position = _cell_on_layer(tilled_soil_tilemap_layer, mouse_world)
	var cell_on_grass: Vector2i = _cell_on_layer(grass_tilemap_layer, mouse_world)
	cell_source_id = grass_tilemap_layer.get_cell_source_id(cell_on_grass)
	local_cell_position = tilled_soil_tilemap_layer.map_to_local(cell_position)
	var cell_center_world: Vector2 = tilled_soil_tilemap_layer.to_global(local_cell_position)
	distance = player.global_position.distance_to(cell_center_world)
	
func add_tilled_soil_cell() -> void:
	if distance < 20.0 && cell_source_id != -1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, terrain, true)

func remove_tilled_soil_cell() -> void:
	if distance < 20.0 && cell_source_id != -1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], 0, -1, true)
