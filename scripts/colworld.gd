extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var s1
var scene = load("res://scenes/player.tscn")
var node = scene.instance()

func _ready():
    s1 = Sprite.new()
    add_child(s1)
    add_child(node)
    add_child(node)
    add_child(node)
    
func _on_shoot():
    var bullet = preload("res://scenes/bullet.tscn").instance()
    add_child(bullet)

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass
