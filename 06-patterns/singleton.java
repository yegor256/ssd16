class Database {%
  public static Database INSTANCE = new Database();
  private Database() {  /* start */ }
  public java.sql.Connection connect() { /* fetch */ }
}
c = Database.INSTANCE.connect();
class Foo {%
  private final Database d;
  void foo() {%
    this.d.connect();
  }
}