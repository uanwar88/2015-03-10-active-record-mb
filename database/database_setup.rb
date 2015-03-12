DATABASE = SQLite3::Database.new("/Users/usman/Code/2015-03-10-active-record-mb/database/main.db")

DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS boards (id INTEGER PRIMARY KEY, title TEXT UNIQUE, thread_count INTEGER DEFAULT 0,
  post_count INTEGER DEFAULT 0, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, total_posts INTEGER DEFAULT 0,
                              total_threads INTEGER DEFAULT 0, password TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS posts (id INTEGER PRIMARY KEY, message TEXT, mb_thread_id INTEGER, user_id INTEGER,
                              FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
                              FOREIGN KEY(mb_thread_id) REFERENCES threads(id) ON DELETE CASCADE)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS mb_threads (id INTEGER PRIMARY KEY, title TEXT, user_id INTEGER, board_id INTEGER,
                              FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
                              FOREIGN KEY(board_id) REFERENCES boards(id) ON DELETE CASCADE)")

set :database, {adapter: "sqlite3", database: "/Users/usman/Code/2015-03-10-active-record-mb/database/main.db"}
