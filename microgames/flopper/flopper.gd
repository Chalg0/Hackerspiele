extends StaticBody2D

@export var is_left: bool
@export var is_muted: bool
@export var base_strength := 80_000.
@export var strength_max_bonus := .25
@export var bend := .3

@onready var chickah: AudioStreamPlayer2D = $Chickah
@onready var click: AudioStreamPlayer2D = $Click
@onready var clock: AudioStreamPlayer2D = $Clock

const MIN_ROT := 0.
const MAX_ROT := 0.42
const SPEED := 8.0
const MIN_X := 10.
const MAX_X := 80.

func _physics_process(delta: float) -> void:
	var action := 'left' if is_left else 'right'
	if Input.is_action_just_pressed(action):
		var ball: RigidBody2D = $'../Ball'
		if ball.get_colliding_bodies().any(func (b): return b == self):
			var dist: float = abs(ball.position.x - position.x)
			var off := (clampf(dist, MIN_X, MAX_X) - MIN_X) / (MAX_X - MIN_X)
			var dir := Vector2(-off * bend, -1.).normalized()
			if is_left: dir.x = -dir.x
			var strength: float = base_strength * (1. + randf() * strength_max_bonus)
			strength *= pow(off, .4)
			ball.apply_central_force(dir * strength)
			if not is_muted: chickah.play()
		else:
			if not is_muted: click.play()
	elif Input.is_action_just_released(action):
		if not is_muted: clock.play()
	if Input.is_action_pressed(action):
		rotation = move_toward(rotation, -MAX_ROT if is_left else MAX_ROT, delta * SPEED)
	else:
		rotation = move_toward(rotation, MIN_ROT, delta * SPEED)
