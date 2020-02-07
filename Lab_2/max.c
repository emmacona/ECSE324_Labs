// max using C

#include <stdio.h>

int main(){
	int a[5] = {1, 20, 3, 4, 5};
	int max_val = 0;

	for(int i = 0; i < 5; i++){
		if(max_val < a[i]){
			max_val = a[i];
		}
	}

	return(max_val);
}