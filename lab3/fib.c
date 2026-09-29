#include <stdio.h>

// Оголошення зовнішньої рекурсивної функції на асемблері
extern unsigned long long fibonacci(unsigned int n);

int main() {
    int n;
    printf("Enter the Fibonacci number you want to calculate (0-93): ");
    if (scanf("%d", &n) != 1) {
        printf("Invalid input.\n");
        return 1;
    }

    if (n < 0 || n > 93) {
        printf("Please enter a number between 0 and 93.\n");
        return 1;
    }

    printf("The %dth Fibonacci number is %llu\n", n, fibonacci((unsigned int)n));
    return 0;
}