extends RigidBody2D

@onready var bonk: AudioStreamPlayer2D = $Bonk
@onready var bing: AudioStreamPlayer2D = $Bing
@onready var kaching: AudioStreamPlayer2D = $Kaching

@onready var boingsee := false

var avoid_boingsee := false

func _physics_process(delta: float) -> void:
	if not boingsee:
		if Input.is_action_just_pressed('submit'):
			apply_central_force(Vector2.UP * 100_000.)
		if position.y < 100.:
			var tile_map: TileMapLayer = get_parent().find_child('Foreground')
			tile_map.set_cell(Vector2i(17, 1), 0, Vector2i.ZERO)
			tile_map.set_cell(Vector2i(17, 2), 0, Vector2i.ZERO)
			boingsee = true
	if position.y > 800.:
		var game: MicroGame = get_parent()
		game.finished.emit(MicroGame.Result.Loss)

func _on_body_shape_entered(body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	if PhysicsServer2D.body_get_collision_layer(body_rid) & 2:
		kaching.play()
		get_parent().add_score(200)
	elif body.is_in_group('flopper-boingsee'):
		if avoid_boingsee: return
		avoid_boingsee = true
		get_tree().create_timer(4.).timeout.connect(func():
			avoid_boingsee = false
			apply_central_force(Vector2(1., -1.) * 50_000.)
			body.scale.y = 1.18
			get_tree().create_timer(.8).timeout.connect(func(): body.scale.y = 1.)
		)
	elif body.is_in_group('flopper-pin'):
		bing.play()
		get_parent().add_score(10)
	elif body.is_in_group('flopper-big-pin'):
		bing.play()
		get_parent().add_score(50)
		apply_central_force((position - body.position).normalized() * 8_000.)
		body.find_child('AnimationPlayer').play('expand')
	else:
		bonk.play()
