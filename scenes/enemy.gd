extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func bullet_hit(body):
    print(self.name+" was hit by a bullet!")
    queue_free()