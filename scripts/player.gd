extends KinematicBody2D
signal hit
signal fire_bullet

onready var tracer = $tracer
onready var cd_bullet_refresh = $BulletAmmoRefreshCooldown
onready var cd_bullet_shoot = $BulletShootCooldown

# Member variables
const MOTION_SPEED = 160 # Pixels/second
const AIM_DISTANCE = 200 # Pixels

export (int) var max_ammo = 5
var player_name
var using_controller

var aim = Vector2()
onready var ammo = max_ammo


func _ready():
    _update_ammo()
    

func _physics_process(delta):
#    _controller_controls()
    var motion = Vector2()
    if Input.is_action_pressed("move_up"):
        motion += Vector2(0, -1)
    if Input.is_action_pressed("move_bottom"):
        motion += Vector2(0, 1)
    if Input.is_action_pressed("move_left"):
        motion += Vector2(-1, 0)
    if Input.is_action_pressed("move_right"):
        motion += Vector2(1, 0)
    motion = motion.normalized() * MOTION_SPEED
    move_and_slide(motion)
    _keyboard_controls()
    

func _keyboard_controls():
    aim = Vector2()
    
    if Input.is_key_pressed(KEY_W):
        aim += Vector2(0, -1)
    if Input.is_key_pressed(KEY_S):
        aim += Vector2(0, 1)
    if Input.is_key_pressed(KEY_A):
        aim += Vector2(-1, 0)
    if Input.is_key_pressed(KEY_D):
        aim += Vector2(1, 0)
        
    aim = Vector2(get_local_mouse_position())
        
    if(aim.length() != 0):
        aim = aim.normalized() * AIM_DISTANCE
        tracer.offset = aim
        tracer.visible = true
    else:
        tracer.visible = false
    
    
func _controller_controls(): 
    aim = Vector2(Input.get_joy_axis(0, JOY_AXIS_2), Input.get_joy_axis(0, JOY_AXIS_3))
    
    # Deadzone
    if aim.length() < 0.25:
        aim = Vector2()
    
    if(aim.length() != 0):
        aim = aim.normalized() * AIM_DISTANCE
        tracer.offset = aim
        tracer.visible = true
    else:
        tracer.visible = false
    
    
func _process(delta):
    if Input.is_key_pressed(KEY_SPACE) && aim.length() != 0 && _can_shoot():
        print(self.name+" wants to fire with ammo "+str(ammo))
        cd_bullet_refresh.start()
        ammo -= 1
        cd_bullet_shoot.start()
        emit_signal("fire_bullet", self)
        _update_ammo()


func _on_cd_bullet_refresh_timeout():
    if ammo < max_ammo:
        ammo += 1
    else:
        cd_bullet_refresh.stop()
    _update_ammo()
        
        
func _can_shoot():
    return cd_bullet_shoot.time_left == 0 && ammo > 0
    
    
func _update_ammo():
    $BulletAmmoLabel.text = str(ammo)+" / "+str(max_ammo) 