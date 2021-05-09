#include <stdio.h>
#define N 10
#define str1 "Array: "
#define str2 "Sorted: "

int data[10] = {5, 3, 6, 7, 31, 23, 43, 12, 45, 1};

void bubblesort();
void swap(int v[], int k);
void printArray();

int main(void)
{
    printf("%s\n", str1);
    printArray();
    bubblesort();
    printf("%s\n", str2);
    printArray();

    return 0;
}

void bubblesort()
{
    int i, j;
    for (i = 0; i < N; i++)
    {
        for (j = i - 1; j >= 0 && data[j] > data[j + 1]; j--)
        {
            swap(data, j);
        }
    }
}

void swap(int v[], int k)
{
    int temp;
    temp = v[k];
    v[k] = v[k + 1];
    v[k + 1] = temp;
}

void printArray()
{
    int i;
    for (i = 0; i < N; i++)
    {
        printf("%d ", data[i]);
    }
    printf("\n");
}
