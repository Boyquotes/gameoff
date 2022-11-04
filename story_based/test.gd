extends Node2D

# https://en.wikipedia.org/wiki/Hero%27s_journey
# https://rhetoricofmythology.weebly.com/the-heros-quest.html

var choices_character = ["boy", "girl", "hobbit", "robot", "alcoholic"]

var choices_world = ["a dystopian future", "the Shire", "a made up place", "Italy", "the suburbs"]

# TODO plural/singular
var choices_other_characters = ["your family", "your partner", "your 9 cats", "your imaginary friend"]

var choices_call_to_adventure = ["{others} are killed", "{others} run away", "a volcano erupts", "{others} is kidnapped"]

var choices_call_refusal = ["you think you are not worthy", "you need to finish your homework", "you are scared that you will fail and everyone will hate you forever"]

var choices_call_accept = ["you realize it is much easier than you though", "you find the strength within you", "you challenge your fears", "you refuse to be set back by doubt", "{others} convinces you that you can do it", "you really want to get out of {world}"]

var choices_mentor = ["a powerful mage", "your mother", "God"]

var choices_supernatural_aid = ["a sword that shines in the dark", "an amulet of power", "a stone shield", "the One Ring"]

var story = ""
var state = {}

func add_story(text, probability=1):
	if randf() <= probability:
		story += text.format(state) + '.\n'

func rand_select(choices):
	return choices[randi_range(0, len(choices) - 1)]
	
func rand_assign(state_key, choices):
	state[state_key] = rand_select(choices).format(state)


func build_story():
	story = ""
	state.clear()
	# ordinary world
	rand_assign("hero", choices_character)
	add_story("You're a {hero}")
	rand_assign("world", choices_world)
	rand_assign("others", choices_other_characters)
	add_story("You live in {world} with {others}")
	
	# call to adventure
	rand_assign("call_to_adventure", choices_call_to_adventure)
	add_story("Until, one day, {call_to_adventure}. Now it is your time to save the day")
	
	# call refusal
	if randf() <= 0.7:
		rand_assign("call_refusal", choices_call_refusal)
		add_story("At first, {call_refusal}")
		rand_assign("call_accept", choices_call_accept)
		add_story("But then, {call_accept}")
	
	# meeting the mentor/supernatural aid
	rand_assign("mentor", choices_mentor)
	rand_assign("supernatural_aid", choices_supernatural_aid)
	add_story("{mentor} appears in front of you and presents you with {supernatural_aid}. This will aid you in your journey")
	# Crossing the first threshold
	# Belly of the Whale
	
	# then follow Campbell (or alternative vogler)
	
func _ready():
	for i in range(10):
		build_story()
		print(story)
	get_tree().quit()

