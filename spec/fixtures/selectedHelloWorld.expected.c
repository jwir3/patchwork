#include <stdio.h>

int main (int argc, char** argv) {
  int i = 0;
  while (i < 35) {
    printf("i is now: %d\n", i);
    i++;
  }

  printf("Hello World!\n");
}

int doTheSameAsMain() {
  int i = 0;
  while (i < 35) {
-    printf("i is now: %d\n", i);
+    printf("***** DEBUG_jwir3: i is currently: %d\n",  i);
    i++;
  }
}
