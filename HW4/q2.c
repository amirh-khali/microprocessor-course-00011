#include <stdio.h>
#include <conio.h>
#include <stdbool.h>

int main() {
    
    int x, y, cmd, ans;

    printf("Enter 2 numbers:\n");
    scanf("%d %d", &x, &y);

    while (true) {
        printf("Menu:\n" 
           "0: Addition\n" 
           "1: Subtraction\n" 
           "2: Multiplication\n" 
           "3: Division\n" 
           "4: Exit\n");
        scanf("%d", &cmd);

        if (cmd == 0)
            __asm__("add %%ebx, %%eax;" : "=a" (ans) : "a" (x), "b" (y));
        
        else if (cmd == 1)
            if (x > y) 
                __asm__("sub %%ebx, %%eax;" : "=a" (ans) : "a" (x), "b" (y)); 
            else
                __asm__("sub %%ebx, %%eax;" : "=a" (ans) : "a" (y), "b" (x));
        
        else if (cmd == 2)
            __asm__("mul %%ebx;" : "=a" (ans) : "a" (x), "b" (y));    
        
        else if (cmd == 3)
            __asm__("mov $0x0, %%edx;"
                    "div %%ebx;" : "=a" (ans) : "a" (x), "b" (y));  
        else
            break;

        __asm__("int $0x21;" : : "d" (ans)); 
    }

    return 0;
}
