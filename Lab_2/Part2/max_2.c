// Calling Assembly from C

extern int MAX_2(int x, int y);

int main(){
	int list[5] = {1, 2, 3, 4};
	int a, b;
	int c = 0;
	for(int i = 0; i < 5; i++){
		a = list[i];
		b = list[i+1];
		if(MAX_2(a,b) > c){
			c = MAX_2(a,b)
		}
	}

	return c;
}