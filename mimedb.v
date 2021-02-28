module mimedb

import os

const (
	db_file_path = getenv("DB_FILE_PATH")
)

pub const db = read_db()

pub fn read_db() string {
	data := os.read_file(db_file_path) or {
		panic("Could not read db $db_file_path")
	}

	println(data)

	return "h"
}
