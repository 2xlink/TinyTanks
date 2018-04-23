extends Node2D

const BULLET_SPEED = 200 # Pixels / second

var hit_something = false
var direction = Vector2(0, 0)


func _ready():
    get_node("Area2D").connect("body_entered", self, "collided")
    set_physics_process(true) # Implicitly set by overriding _physics_process(delta)
    
func _physics_process(delta):
    var forward_dir = global_transform.basis.z.normalized()
    global_translate(forward_dir * BULLET_SPEED * delta)

func _process(delta):
    # Called every frame. Delta is time since last frame.
    # Update game logic here.
    pass
    
func collided(body):
    if hit_something == false:
        if body.has_method("bullet_hit"):
            body.bullet_hit(self.global_transform.origin)

    hit_something = true
    queue_free()