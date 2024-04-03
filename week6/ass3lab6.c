#include <stdio.h>

int main(){
    int A[7] = {-3, 5, -1, 2, 8, 2, 1};
    
    for (int i = 0; i < 6; i++){
        for( int j = i + 1; j < 7; j++){
            if( A[j] < A[i]){
                int temp = A[i];
                A[i] = A[j];
                A[j] = temp;
            }
        }
    }

    for( int i = 0; i < 7; i++){
        printf("%d ", A[i]);
        if(i < 6) {
            printf(", ");
        }
}
    return 0;
}
