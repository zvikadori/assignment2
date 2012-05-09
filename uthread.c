#include "uthread.h"

#define RR 0
#define PB 1
#define SCHED_METHOD = RR; 
static int RR_INDEX = 0;
static int nextThreadToRun = 0;
#define SCHED_RR { \
	//find non zero thread and return it
	(RR_INDEX++)%MAX_UTHREADS); 	\
	for (;threads[RR_INDEX] == 0 ;(RR_INDEX++)%MAX_UTHREADS){ 	\
		nextThreadToRun = threads[RR_INDEX]->tid;	 \
	}	 \
}

int next_tid = 1;



int
uthread_create(void (*start_func)(), int priority){
	int i;
	uthread_t *t;
	int found = 0;
	void *stack_bp;
	for (i = 0; i<MAX_UTHREADS && found == 0; i++){
		if (threads[i] == 0){
			found = 1;
		}
	}
	
	
	if (found !=0){
		t = (uthread_t *) malloc (sizeof uthread_t);
		t->tid = next_tid;
		next_tid++;
		stack_bp = (void *)malloc (STACK_SIZE);
		t->ss_bp = stack_bp;
		t->ss_sp = stack_bp + STACK_SIZE - 1*sizeof(int);
		t->ss_size = STACK_SIZE;
		t->priority = priority;
		t->pc = start_func;
		return t->tid;
	}
	return -1;
}

void uthread_yield(){
	
}
