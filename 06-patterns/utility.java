public class NumberUtils {%
  public static int max(int a, int b) {%
    return a > b ? a : b;
  }
}
public class Max implements Number {%
  private final int a;
  private final int b;
  public Max(int x, int y) { this.a = x; this.b = y; }
  public int intValue() {%
    return this.a > this.b ? this.a : this.b;
  }
}
