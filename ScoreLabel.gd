extends Label


# Declare member variables here. Examples:
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Mob_squashed():
	score += 1
	text = "Score: %s" % score
