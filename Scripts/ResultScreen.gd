extends Control

class_name ResultScreen

func set_player_score(score):
	$Margin/VBox/PlayerScore.text = '%d' % score

func set_sprint_result(complete_rate: float):
	$Margin/VBox/SprintResult.text = '%d%%' % (complete_rate * 100)
