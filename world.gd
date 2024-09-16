extends Node3D


@onready var areas = [$coin.global_position, $coin2.global_position, $coin3.global_position, $coin4.global_position, $coin5.global_position, $coin6.global_position, $coin7.global_position, $coin8.global_position]

var COIN = preload("res://coin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(str(areas))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(_delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	if fps > 60:
		if Engine.physics_ticks_per_second != fps:
			Engine.physics_ticks_per_second = fps
			Engine.max_physics_steps_per_frame = fps / 7.5
		else: return
	else:
		if Engine.physics_ticks_per_second != 60:
			Engine.physics_ticks_per_second = 60
			Engine.max_physics_steps_per_frame = 8
		else: return


func _on_timer_timeout() -> void:
	var coin = COIN.instantiate()
	add_child(coin)
	reset_coin(coin)
	

func reset_coin(coin):
	var random = randi_range(0, 7)
	var value = areas[random]
	coin.global_position = value

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("coin fell!")
	body.queue_free()


func _coin_out_of_bounds(body: Node3D) -> void:
	print("coin out of bounds!!")
	reset_coin(body)
