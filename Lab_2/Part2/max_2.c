// Calling Assembly from C

extern int MAX_2(int x, int y);

int main(){
	int list[5] = {1, 2, 3, 4};
	int a;
	int c = 0;
	for(int i = 0; i < 4; i++){
		a = list[i];
		if(MAX_2(a,c) > c){
			c = MAX_2(a,c);
		}
	}

	return c;
}
