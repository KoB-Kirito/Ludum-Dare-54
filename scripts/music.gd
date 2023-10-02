extends Node


@onready var bgm_morning: AudioStreamPlayer = $bgm_morning
@onready var bgm_noon: AudioStreamPlayer = $bgm_noon
@onready var bgm_evening: AudioStreamPlayer = $bgm_evening
@onready var bgm_night: AudioStreamPlayer = $bgm_night

var current_playing: AudioStreamPlayer


func _ready() -> void:
	bgm_morning.play()
	current_playing = bgm_morning


func change_music(phase: Globals.Phase):
	match phase:
		Globals.Phase.MORNING:
			if current_playing == bgm_morning:
				return
			
			fade_music(bgm_morning)
		
		Globals.Phase.NOON:
			if current_playing == bgm_noon:
				return
			
			fade_music(bgm_noon)
		
		Globals.Phase.EVENING:
			if current_playing == bgm_evening:
				return
			
			fade_music(bgm_evening)
		
		Globals.Phase.NIGHT:
			if current_playing == bgm_night:
				return
			
			fade_music(bgm_night)


func fade_music(new_player: AudioStreamPlayer) -> void:
	new_player.volume_db = -30
	new_player.play(current_playing.get_playback_position())
	var tween := create_tween().set_parallel()
	tween.tween_property(new_player, "volume_db", 0.0, 1.0)
	tween.tween_property(current_playing, "volume_db", -30.0, 1.0)
	await tween.finished
	current_playing.stop()
	current_playing = new_player
