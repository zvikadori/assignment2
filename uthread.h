
/********************************
	Macors which inline assembly
 ********************************/

// Saves the value of esp to var
#define STORE_ESP(var) 	asm("movl %%esp, %0;" : "=r" ( var ))

// Loads the contents of var into esp
#define LOAD_ESP(var) 	asm("movl %0, %%esp;" : : "r" ( var ))

// Calls the function func
#define CALL(addr)		asm("call *%0;" : : "r" ( addr ))

// Pushes the contents of var to the stack
#define PUSH(var)		asm("movl %0, %%edi; push %%edi;" : : "r" ( var ))



#define MAX_UTHREADS 64
#define STACK_SIZE 1024 * sizeof(int); //4KB in pthread it is 8MB
static int currentThread=0;

// Represents a ULT. 
// Feel free to extend this definition as needed.
typedef struct thread
{
	int tid;				// A unique thread ID within the process
	void *ss_sp;		// Stack base or pointer
	void *ss_bp;		// Stack base pointer
	size_t ss_size;	// Stack size
	int priority;		// The priority of the thread 0…9 (0 is highest)
	void *start_func; //one time var, after first exec it is not relevant
} uthread_t;


static uthread_t threads[MAX_UTHREADS];

// A function that wraps the entry functipn of a thread.
// This is just a siggestion, fell free to modify it as needed.
void wrap_function(void (*entry)())
{
  entry();
  uthread_exit();
}

/********************************
	The API of the ULT package
 ********************************/
 
int uthread_create(void (*start_func)(), int priority);
void uthread_yield();
void uthread_exit();
int uthread_start_all();
int uthread_setpr(int priority);
int uthread_getpr();
uthread_t uthread_self();


