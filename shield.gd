extends Area2D

var energy = 10.0
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_shield_activation():
	show() # Replace with function body.
