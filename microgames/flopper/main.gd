extends MicroGame

const number_offset := Vector2i(1, 12)
const number_count := 6

@onready var score := 0

func _input(event: InputEvent) -> void:
	if event.is_action('submit'):
		if event.is_pressed():
			$Boingsee/Sprite2D.scale.y = 1.4
			$Boingsee/Sprite2D.position.y = -14.
		else:
			$Boingsee/Sprite2D.scale.y = 1.
			$Boingsee/Sprite2D.position.y = 0.

func add_score(val: int) -> void:
	score += val
	if score >= 1000:
		finished.emit(Result.Win)
	update_score()

func update_score() -> void:
	var val := score
	for i in range(number_count-1,-1,-1):
		var coord := number_offset + Vector2i(i, 0)
		var source: int = $Foreground.get_cell_source_id(coord)
		$Foreground.set_cell(coord, source, Vector2i(0, val % 10))
		val = val / 10
