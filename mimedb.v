module mimedb

import json
import os

struct MimeType {
	charset string
	compressible bool
	extensions []string
	source string
}

const (
	db_file_path = getenv_or("DB_FILE_PATH", "./mimedb/db.json")
)

pub const (
	mimedb = prepare_db()
)

pub fn getenv_or(env_key string, fallback string) string {
	mut value := getenv(env_key)
	if value.len == 0 {
		value = fallback
	}
	return value
}

pub fn prepare_db() map[string]string {
	s := os.read_file(db_file_path) or {
		panic("Could not read db $db_file_path")
	}

	parsed_data := json.decode(map[string]MimeType, s) or {
		eprint(s)
		panic("Failed parsing data")		
	}

	// println(parsed_data)

	mut extensions_mime_type_map := map[string]string{} 

	for mime_type, data in parsed_data {
		// println(mime_type)
		// println(data)
		for extension in data.extensions {
			extensions_mime_type_map[extension] = mime_type
		}
	}

	// println(extensions_mime_type_map)

	return extensions_mime_type_map
}
