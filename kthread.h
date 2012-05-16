#define MAX_STACK_SIZE 4000
#define MAX_MUTEXES 64
#define MAX_CONDS 64

#define M_UNUSED 0
#define M_UNLOCKED 1
#define M_LOCKED 2

#define C_UNUSED 0
#define C_USED 1

typedef struct{
	int tid;
	int sleepingTID[MAX_THREADS];
	int status; //0 UNUSED, 1 = USED, but not locked, 2= USED AND LOCKED(by tid)
	//for queue:
	int count;
	int startIndex;
}kthread_mutex_t; 

typedef struct{
	int status;
	//for queue:
	int sleepingTID[MAX_THREADS];
	int count;
	int startIndex;
	int waitingMutexID;
}kthread_cond_t;

/********************************
	The API of the KLT package
 ********************************/

//int kthread_create( void*(*start_func)(), void* stack, unit stack_size ); 
int kthread_id();
void kthread_exit();
int kthread_join( int thread_id );

int kthread_mutex_alloc();
int kthread_mutex_dealloc( int mutex_id );
int kthread_mutex_lock( int mutex_id );
int kthread_mutex_unlock( int mutex_id );

int kthread_cond_alloc();
int kthread_cond_dealloc( int cond_id );
int kthread_cond_wait( int cond_id, int mutex_id );
int kthread_cond_signal( int cond_id );
