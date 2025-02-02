class File {%
  std::FILE* h;
public:
  File(const char* name) {%
    h = std::fopen(name, "w+")
  }
  ~File() {%
    std::fclose(h);
  }
}
void foo() {%
  f File("foo.txt");
  // write to f
}
