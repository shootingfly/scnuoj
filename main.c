#include <stdio.h>

// Accepted
int main() {
    int a, b;
  
    scanf("%d %d", &a, &b);
    printf("%d\n", a + b);
    return 0;
}
// Output Limited > 1024K
#include <stdio.h>

int main() {
    int a, b;
  
   for (int i=0; i < 10000000; i++){
     printf("sss");
   }
    return 0;
}
// Wrong Answer
#include <stdio.h>

int main() {
    int a, b;
  
    scanf("%d %d", &a, &b);
    printf("%d\n", a - b);
    return 0;
}
// Presentation Error
#include <stdio.h>

int main() {
    int a, b;
  
    scanf("%d %d", &a, &b);
    printf("%d           ", a - b);
    return 0;
}
// Time Limited Error
#include <stdio.h>

int main() {
    int a, b;
  
    while(1) {}
    return 0;
}
// Runtime Error
#include <stdio.h>

int main() {
    int a = 1;
    int b = 0;
  
    printf("%d", a / b);
    return 0;
}
