extends Node


signal tappy_died
signal point_scored(points: int)


func emit_tappy_died() -> void:
	tappy_died.emit()

func emit_point_score(points) -> void:
	point_scored.emit(points)
