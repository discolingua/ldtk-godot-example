extends Node

var current_scene = null

var playerStats : Dictionary = {"Name": "default",
                                "Level": 1,
                                "Job": "NONE",
                                "Strength": 0,
                                "Reflex": 0,
                                "Body": 0}



func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene(path):
    call_deferred("_deferred_goto_scene", path)


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
