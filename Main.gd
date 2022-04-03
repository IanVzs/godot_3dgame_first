extends Node

export (PackedScene) var mob_scene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$UserInterface/Retry.hide()


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()

func _on_MobTimer_timeout():
	# Create a Mob instance and add it to the scene.
	var mob = mob_scene.instance()

	# Choose a random location on Path2D.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.unit_offset = randf()

	var player_position = $Player.transform.origin

	add_child(mob)
	mob.initialize(mob_spawn_location.translation, player_position)
	mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")

func _on_Player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()
