
/********************************
	Macors which inline assembly
 ********************************/
// Saves the value of esp to var
#define STORE_ESP(var) 	asm("movl %%esp, %0;" : "=r" ( var ))

// Loads the contents of var into esp
#define LOAD_ESP(var) 	asm("movl %0, %%esp;" : : "r" ( var ))

/*adding ebp support, for asm leave command - mov ebp esp*/

// Saves the value of ebp to var
#define STORE_EBP(var) 	asm("movl %%ebp, %0;" : "=r" ( var ))

// Loads the contents of var into ebp
#define LOAD_EBP(var) 	asm("movl %0, %%ebp;" : : "r" ( var ))


/*end adding support...*/


// Callsc the function func
#define CALL(addr)		asm("call *%0;" : : "r" ( addr ))

// Pushes the contents of var to the stack
#define PUSH(var)		asm("movl %0, %%edi; push %%edi;" : : "r" ( var ))



#define MAX_UTHREADS 64
#define STACK_SIZE 1024 * sizeof(int) //4KB in pthread it is 8MB
#define PRIORITIES 10

// Represents a ULT. 
// Feel free to extend this definition as needed.
typedef struct
{
	int tid;			// A unique thread ID within the process
	void *ss_sp;		// Stack base or pointer
	void *ss_bp;		// Stack base pointer
	void *stack_aloc;	//pointer to stack allocation
	size_t ss_size;	// Stack size
	int priority;		// The priority of the thread 0�9 (0 is highest)
	void *start_func; //one time var, after first exec it is not relevant
	int firstRun;
} uthread_t;

typedef struct
{
	uthread_t *thread;
	struct uthread_entry *next;
} uthread_entry;

typedef struct
{
	uthread_entry *first;
} uthread_list; 



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
void printALL(int k);


// A function that wraps the entry functipn of a thread.
// This is just a siggestion, fell free to modify it as needed.
void wrap_function(void (*entry)());
