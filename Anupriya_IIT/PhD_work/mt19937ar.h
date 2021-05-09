void init_genrand(unsigned long s);
 void init_by_array(unsigned long init_key[], int key_length);
unsigned long genrand_int32(void);

void push_mt_state();
void pop_mt_state();