extends Node


const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://Resources/statsrpg.db"

var current_scene = null


var playerStats : Dictionary = {"Name" : "default",
                                "Level" : 1,
                                "Job" : "NONE",
                                "Strength" : 0,
                                "Reflex" : 0,
                                "Body" : 0,
                                "MainWeapName" : "none",
                                "MainWeapID" : 0,
                                "AltWeapID" : 0,
                                "ArmorID" : 0 }

var weaponTable : Array

# char sheet display fields

# onready var mainWeapLabel = $root/CharPanel/MainWeapLabel
# onready var altWeapLabel = $root/CharPanel/AltWeapLabel


func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() - 1)

    # init database
    db = SQLite.new()
    db.path = db_name

        # var _q = "SELECT ID, NAME, DESC, SR, MR, LR, SPEED FROM weapons"
        # weaponTable = readFromdB(_q)
        # Global.playerStats["MainWeapID"] = weaponTable[0]["ID"]
        # Global.playerStats["MainWeapName"] = weaponTable[0]["NAME"]
        # print( weaponTable[0]["NAME"] )


# this is the core scene switch function
func _deferred_goto_scene(path):

    # remove current scene
    current_scene.free()

    # load new scene
    var s = ResourceLoader.load(path)
    current_scene = s.instance()

    # add it to the active scene, as child of root
    get_tree().get_root().add_child(current_scene)

    # sync with the SceneTree.change_scene() API (optional)
    get_tree().set_current_scene(current_scene)



func goto_scene(path):
    call_deferred("_deferred_goto_scene", path)


func readFromdB(q : String) -> Array:

    db.open_db()
    db.query(q)
    print(q)
    return db.query_result


