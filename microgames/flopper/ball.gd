extends RigidBody2D

@onready var bonk: AudioStreamPlayer2D = $Bonk

@onready var boingsee := false

func _physics_process(delta: float) -> void:
	if not boingsee:
		if Input.is_action_just_pressed('submit'):
			apply_central_force(Vector2.UP * 100_000.)
		if position.y < 100.:
			var tile_map: TileMapLayer = get_parent().find_child('Foreground')
			tile_map.set_cell(Vector2i(17, 1), 0, Vector2i.ZERO)
			tile_map.set_cell(Vector2i(17, 2), 0, Vector2i.ZERO)
			print('yoyo')
			boingsee = true

func _on_body_entered(body: Node) -> void:
	bonk.play()
