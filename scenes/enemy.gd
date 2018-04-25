extends KinematicBody2D

const MOTION_SPEED = 100 # Pixels/second

var movement_direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))

func bullet_hit(body):
    print(str(self)+" was hit by a bullet!")
    queue_free()
    
    
func _physics_process(delta):
    move_and_slide(movement_direction.normalized() * MOTION_SPEED)
        
    
func _on_MovementDirectionTimer_timeout():
    movement_direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
