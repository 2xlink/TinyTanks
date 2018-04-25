extends Node2D

var player_scene = load("res://scenes/player.tscn")
var enemy_scene = load("res://scenes/enemy.tscn")

var bullet_scene = preload("res://scenes/bullet.tscn")

func _ready():
    randomize()
    
    # Add players
    var player1 = player_scene.instance()
    add_child(player1)
    player1.position = Vector2(90, 270)
    player1.connect("fire_bullet", self, "_on_fire_bullet")
    
    # Add enemies
    var enemy1 = enemy_scene.instance()
    add_child(enemy1)
    enemy1.position = Vector2(100, 300)
    

func _on_fire_bullet(origin):
    var aim = origin.aim
    var pos = origin.position
    print("World received fire signal from player "+str(origin)+" at position "+str(pos)+" with aim "+str(aim))
    var bullet = bullet_scene.instance()
    add_child(bullet)
    bullet.position = pos + aim.normalized() * 20
    bullet.rotation = aim.angle()
    bullet.direction = aim.normalized()