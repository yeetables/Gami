extends Node

var i = 1
var j = 1
var k = 1

var introNarrativeArray = ["There is a sickness that disturbs our lands. One that disconnects us from each other, and thus, ourselves.", 
"But you... you have remained untouched. You still feel the world around you.", 
"You are among those who walk with numbness in their hearts. I am grateful that your spirit still shines through.",
"Ascend the mountain. Offer clarity to those in need. We must do our best to save them.","It is time. Wake up."
]

var squirrelNarrativeArray = [
"Maybe you can help me. I’m hungry but I can’t find any food.",
"I know there’s a bear somewhere around here. Dug himself a cave.",
"If we ask nice, he might give us some goodies."]


func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
	$TextPlayer.play("text")
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func _on_TextPlayer_animation_finished(anim_name):
	if i < introNarrativeArray.size()+1:
		$NarrativeLabel.text = introNarrativeArray[i-1]
		i += 1
		$TextPlayer.play("text")

func _on_SquirrelCollision_body_entered(body):
	$SquirrelDialogPlayer.play("squirrel_text")

func _on_SquirrelDialogPlayer_animation_finished(anim_name):
	if j < squirrelNarrativeArray.size()+1:
		$SquirrelLabel.text = squirrelNarrativeArray[j-1]
		j += 1
		$SquirrelDialogPlayer.play("squirrel_text")


func _on_GoalDialogPlayer_animation_finished(anim_name):
	pass
