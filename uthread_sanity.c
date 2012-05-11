/*
 * uthread_sanity
 */


#include "types.h"
#include "user.h"
#include "uthread.h"
/*
void doSomething(){
	uthread_t t = uthread_self();
	printf(2, "is this realy working??? tid: %d\n",t.tid);
	uthread_yield();
	
	printf(2, "YESSSSSSSSSSSSSS OR NO%d", t.tid);
	uthread_exit();
}
void doNothing(){
	printf(1,"nothing");
	uthread_yield();
	uthread_exit();
}

int
main(int argc, char **argv){
	uthread_create(doSomething, 0);
	uthread_create(doNothing, 0);
	uthread_start_all();
	exit();
}
*/


static int numOfIterations;

void sanityMethod(){
	int i;
	uthread_t t = uthread_self();
	for (i = 0; i<numOfIterations; i++){
		printf(2, "thread %d iteration %d\n",t.tid, i);
		uthread_yield();
	}
	printf(3, "killing %d, with %d and %d iters", t.tid, t.priority, numOfIterations);
	//uthread_exit();
}

int
main(int argc, char **argv){
	int n;
	int i;
	if (argc == 3){
		n = atoi(argv[1]);
		numOfIterations = atoi(argv[2]);
		
		for (i=0; i< n; i++){
			uthread_create(sanityMethod, i%3);
		}
		uthread_start_all();
	}
	else{
		printf(1,"Error: bad usage, try uthread_sanity {n} {k}");
	} 
	exit();
}
