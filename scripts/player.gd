extends KinematicBody2D

onready var aimer = $aimer

# Member variables
const MOTION_SPEED = 160 # Pixels/second
const AIM_DISTANCE = 100 # Pixels

func _physics_process(delta):
    var motion = Vector2()
    var aim = Vector2()
    
    if Input.is_action_pressed("move_up"):
        motion += Vector2(0, -1)
    if Input.is_action_pressed("move_bottom"):
        motion += Vector2(0, 1)
    if Input.is_action_pressed("move_left"):
        motion += Vector2(-1, 0)
    if Input.is_action_pressed("move_right"):
        motion += Vector2(1, 0)
        
    if Input.is_key_pressed(KEY_W):
        aim += Vector2(0, -1)
    if Input.is_key_pressed(KEY_S):
        aim += Vector2(0, 1)
    if Input.is_key_pressed(KEY_A):
        aim += Vector2(-1, 0)
    if Input.is_key_pressed(KEY_D):
        aim += Vector2(1, 0)
    
    motion = motion.normalized() * MOTION_SPEED
    aim = aim.normalized() * AIM_DISTANCE
    aimer.offset = aim
    
    move_and_slide(motion)
    
func fire_bullet():
    var clone = $bullet_scene.instance()
    