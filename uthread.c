#include "types.h"
#include "user.h"
#include "uthread.h"

#define SCHED_RR 0
#define SCHED_PB 1
static int SCHED_POLICY = SCHED_RR; 
static int PB_RR_INDEXES[PRIORITIES] = {-1};
static int RR_INDEX = -1;
static uthread_t *thread = 0;
static int next_tid = 1;
static uthread_t threads[MAX_UTHREADS];
static int numberOfCT = 0;

void wrap_function(void (*entry)())
{
  entry();
  uthread_exit();
}



int
getNextRoundRobin(){
	int lastOneToCheck = RR_INDEX;
	RR_INDEX = (RR_INDEX+1)%MAX_UTHREADS;
	while (RR_INDEX != lastOneToCheck){
		if ((&threads[RR_INDEX])->tid != 0){
			break;
		}
		RR_INDEX = (RR_INDEX+1)%MAX_UTHREADS;
	}
	return RR_INDEX;
}

/* 
 * free stack, free what is needed,
 * pointer in threads array should be zerosized
 */
void
freeThread(uthread_t *t){
	int i;
	numberOfCT--;
	for (i=0; i<MAX_UTHREADS; i++){
		if (t->tid == (&threads[i])->tid){
			free(t->stack_aloc);
			(&threads[i])->tid = 0;
			(&threads[i])->priority = PRIORITIES;
			return;
		}
	}
	
	
}

int
getNumberOfCurrentThreads(){
	return numberOfCT;
}

int getNumberOfThreadInPrioirity(int priority){
	
	int ans = 0;
	int i;
	for(i=0; i< MAX_UTHREADS; i++){
		if ((&threads[i])->tid != 0 && (&threads[i])->priority == priority){
			ans++;
		}
	}
	return ans;
}

int getNextPB(){
	int priorityIndex; 
	int threadsInPriority;
	int roundRobinIndex;
	int lastOneToCheck;
	for (priorityIndex = 0; priorityIndex < PRIORITIES; priorityIndex++){
		threadsInPriority = getNumberOfThreadInPrioirity(priorityIndex);
		//printf(1, "%d\n", getNumberOfThreadInPrioirity(priorityIndex));
		if (threadsInPriority == 0){
			continue;
		}
		
		roundRobinIndex = PB_RR_INDEXES[priorityIndex];
		lastOneToCheck = roundRobinIndex;
		roundRobinIndex = (roundRobinIndex+1)%MAX_UTHREADS;
		while (roundRobinIndex != lastOneToCheck){
			if ((&threads[roundRobinIndex])->tid != 0 && (&threads[roundRobinIndex])->priority == priorityIndex){
				break;
			}
			roundRobinIndex = (roundRobinIndex+1)%MAX_UTHREADS;
		}
		PB_RR_INDEXES[priorityIndex] = roundRobinIndex;
		return roundRobinIndex;
	}
	
	
	printf(1,"problem!");
	return -1; //problem!
}

int
uthread_create(void (*start_func)(), int priority){
	int i;
	uthread_t *t;
	int found = 0;
	void *stack_bp;
	for (i = 0; i<MAX_UTHREADS && found == 0; i++){
		if ((&threads[i])->tid == 0){
			found = 1;
			break;
		}
	}
	//printf(2, "\n i=%d",i);
	t = &threads[i];
	if (found !=0){
		t->tid = next_tid;
		next_tid++;
		stack_bp = (void *) malloc (STACK_SIZE);
		t->stack_aloc = stack_bp;
		t->ss_bp = stack_bp + STACK_SIZE - 1*sizeof(int);
		t->ss_sp = stack_bp + STACK_SIZE - 1*sizeof(int);
		t->ss_size = STACK_SIZE;
		t->priority = priority;
		t->start_func = start_func;
		t->firstRun = 1; //never ran before
		numberOfCT++;
		return t->tid;
	}
	
	return -1;
}

void
uthread_yield(){
	// store esp ebp of current thread.
	int nextThreadToRun = -1;
	STORE_EBP(thread->ss_bp);
	STORE_ESP(thread->ss_sp);
	
	//d find next thread by scheduling policy
	if (SCHED_POLICY == SCHED_RR){
		nextThreadToRun = getNextRoundRobin();
	}
	
	if (SCHED_POLICY == SCHED_PB){
		nextThreadToRun = getNextPB();
	}
	
	thread = &threads[nextThreadToRun];
	LOAD_EBP(thread->ss_bp);
	LOAD_ESP(thread->ss_sp);
	
	//if next thread didnt run at all, use wrap_function, else, just return
	if (thread->firstRun == 1){
		thread->firstRun = 0;
		wrap_function(thread->start_func);
	}
	
	return;
}


void
uthread_exit(){
	int nextThreadToRun = -1;getNumberOfCurrentThreads();
	if (getNumberOfCurrentThreads() == 1){
		freeThread(thread);
		exit();
		
	}
	
	else {  //need to pass the control to nextThreadToRun
		freeThread(thread);
		if (SCHED_POLICY == SCHED_RR){
			nextThreadToRun = getNextRoundRobin();
		}
		
		if (SCHED_POLICY == SCHED_PB){
			nextThreadToRun = getNextPB();
		}
		thread = &threads[nextThreadToRun];
		LOAD_EBP(thread->ss_bp);
		LOAD_ESP(thread->ss_sp);
		if (thread->firstRun == 1){
			thread->firstRun = 0;
			wrap_function(thread->start_func);
		}
		return;
	}
}


int uthread_start_all(){
	//pick up first available thread and starts it
	int nextThreadToRun = -1;
	if (SCHED_POLICY == SCHED_RR){
		nextThreadToRun = getNextRoundRobin();
	}
		
	if (SCHED_POLICY == SCHED_PB){
		nextThreadToRun = getNextPB();
	}
	
	thread = &threads[nextThreadToRun];
	
	//printf(2,"a%d ", nextThreadToRun);;
	if (thread->firstRun == 1){
		thread->firstRun = 0;
		wrap_function(thread->start_func);
	}
	LOAD_EBP(thread->ss_bp);
	LOAD_ESP(thread->ss_sp);
	return -1;
}

int
uthread_setpr(int priority){
	int ans = -1;
	if (priority>=0 && priority<=9){
		ans = thread->priority;
		thread->priority = priority;
	}
	return ans;
}


int
uthread_getpr(){
	return thread->priority;
}

uthread_t uthread_self(){
	return *thread;
}

void printALL(int k){
	int i=0;
	for (i=0; i< k; i++){\
		printf(2 , "tid: %d, priority: %d\n" ,(&threads[i])->tid, (&threads[i])->priority); \
	}
}

