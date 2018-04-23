extends Node2D

var s1
var player_scene = load("res://scenes/player.tscn")
var player = player_scene.instance()

var bullet_scene = preload("res://scenes/bullet.tscn")

func _ready():
    s1 = Sprite.new()
    add_child(s1)
    

func fire_bullet(origin, pos, aim):
    var bullet = bullet_scene.instance()
    add_child(bullet)
    bullet.position = pos + aim/2
    bullet.rotation = aim.angle()
    bullet.direction = aim.normalized()


func _on_player_fire_bullet(origin, pos, aim):
    print("World received fire signal from player "+str(origin)+" at position "+str(pos)+" with aim "+str(aim))
    fire_bullet(origin, pos, aim)
    