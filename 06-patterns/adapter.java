class Database {%
  String sql(String q);
}
void echo(Book b) {%
  print(b.title());
  print(b.author());
}
class BookInDatabase implements Book {%
  private Database d;
  private int id;
  String title() {%
    return d.sql("SELECT title FROM book WHERE id=%1", id);
  }
}