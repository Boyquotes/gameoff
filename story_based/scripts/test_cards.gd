extends Node2D

@export var story_template: PackedScene
@export var card_template: PackedScene

var story = [
	"You are a ___",
	"You live in ___",
	"Until one day you meet ___",
]

var cards = [
	"a boy",
	"a robot",
	"an alcoholic",
	"Italy",
	"the suburbs",
	"your family",
	"9 cats",
	"a dystopian future",
]

@export var cards_dealt: int
var deck: Array[String]


# Called when the node enters the scene tree for the first time.
func _ready():
	for story in $StoryContainer.get_children():
		story.queue_free()
		
	for story_element in story:
		var story_instance = story_template.instantiate()
		story_instance.set_text(story_element)
		$StoryContainer.add_child(story_instance)
		
	
	for card in $CardsContainer.get_children():
		card.queue_free()
		
	for i in range(cards_dealt):
		deck.append(cards.pop_back())
		
	for card in deck:
		var card_instance = card_template.instantiate()
		card_instance.set_text(card)
		$CardsContainer.add_child(card_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
