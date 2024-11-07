extends Node
signal logText(text)

func doLog(text):
	logText.emit(text)
