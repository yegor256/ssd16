void foo(int a) {
  if (a % 2 == 0) {
    printf("Even!");
    goto exit;
  }
  printf("Odd!");
  exit:
}
void foo(int a) {
  if (a % 2 == 0) {
    printf("Even!");
  } else {
    printf("Odd!");
  }
}