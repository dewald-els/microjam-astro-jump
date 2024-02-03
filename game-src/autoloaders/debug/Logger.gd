extends Node

enum LogType {
	Session,
}

func write(type: LogType, message: String) -> void:
	var time: String = Time.get_datetime_string_from_system(true)
	
	if type == LogType.Session:
		var file: FileAccess = FileAccess.open("user://session.log", FileAccess.WRITE)
		file.store_string(time + " " + message)
