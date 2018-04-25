extends Node2D

var hit_something = false
var direction = Vector2()

const BULLET_SPEED = 200 # Pixels / second


func _ready():
    print("Bullet ready with position "+str(self.position))
    $Area2D.connect("body_entered", self, "_collided")
    
    
func _physics_process(delta):
    var forward_dir = direction.normalized()
    global_translate(forward_dir * BULLET_SPEED * delta)
#    move_and_slide(forward_dir * BULLET_SPEED * delta)
    
    
func _collided(body):
    if hit_something == false:
        if body.has_method("bullet_hit"):
            body.bullet_hit(self.global_transform.origin)
        print("Bullet collided with {s}".format([body.name], "{s}"))

    hit_something = true
    queue_free()