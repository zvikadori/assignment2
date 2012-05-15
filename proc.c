#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "kthread.h"




struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;


struct {
  struct spinlock lock;
  kthread_mutex_t kthread_locks[MAX_MUTEXES];
} mtable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);



/*
 * return 1 if threadID is in queue, 0 otherwise
 * assumes that mtable lock is acquired!
 */
int
isInQueue(int mutex_id, int threadID){
	kthread_mutex_t *mutex = &mtable.kthread_locks[mutex_id]; 
	int checkUntil = (mutex->startIndex + mutex->count + 1) % MAX_MUTEXES;
	int i = mutex->startIndex;
	while (i != checkUntil){
		if (mutex->sleepingTID[i] == threadID)
			return 1;
		i = (i + 1) % MAX_MUTEXES;
	}
	return 0;
}

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
 struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm(kalloc)) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  p->state = RUNNABLE;
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  
  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;
	np->threadId=-1;    //changed ass2* main thread of process
   
  // Copy process state from p.

  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    
    return -1;
  }
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
 
  pid = np->pid;
  np->state = RUNNABLE;
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  /* changed ass2 nulling the threads array */
  for(i=0;i<64;i++)
  {
      np->sleepingThreads[i]=0;
  }
/* changed ass2 nulling the threads array */
  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.


// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->state = UNUSED;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}

void
register_handler(sighandler_t sighandler)
{
  char* addr = uva2ka(proc->pgdir, (char*)proc->tf->esp);
  if ((proc->tf->esp & 0xFFF) == 0)
    panic("esp_offset == 0");

    /* open a new frame */
  *(int*)(addr + ((proc->tf->esp - 4) & 0xFFF))
          = proc->tf->eip;
  proc->tf->esp -= 4;

    /* update eip */
  proc->tf->eip = (uint)sighandler;
}


//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);

  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  proc->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
    initlog();
  }
  
  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  proc->state = SLEEPING;
   
  sched();

  // Tidy up.
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

















/* kernel threads section second attempt */



/* kerenl threads section */
 //first attempt fail due to error: " panic kfree"
static int nextThread=0;
int strcmp(const char *p, const char *q)
{
while(*p && *p == *q)
    p++, q++;
 return (uchar)*p - (uchar)*q;
}

int kthread_create( void*(*start_func)(), void* stack, unsigned int stack_size )
{
int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;
for(i=0;i<64;i++)
  {
      np->sleepingThreads[i]=0;
  }
 if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
   
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    
    
    return -1;
  }

nextThread++;
np->threadId=nextThread;
np->pid=proc->pid;
 np->pgdir=proc->pgdir;
  np->sz = proc->sz;
  np->parent = proc->parent;
  
  *np->tf = *proc->tf;
  np->tf->eip=(uint)start_func;
  np->tf->esp=(uint)stack+stack_size;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = proc->ofile[i];
  np->cwd = proc->cwd;
 
  pid = np->pid;
  np->state = RUNNABLE;
  safestrcpy(np->name, "thread", sizeof(proc->name));
  return pid;



}
int kthread_id()
{
   return proc->threadId;

}

//the same code as the original exit
void
New_exit(void)
{
  struct proc *p;
  int fd;
   
  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
  proc->cwd = 0;
 
  acquire(&ptable.lock);
  


  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
  
  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }
 
  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
  
  panic("zombie exit");

}
void kthread_exit()
{
 
	struct proc *p;
	   
	int threadsCounter=0;

	acquire(&ptable.lock);
	  if(proc == initproc)
		panic("init exiting");
	int i=0;

	for(;i<64;i++)
	{
		if(proc->sleepingThreads[i]!=0)
					
			wakeup1(proc->sleepingThreads[i]);

	}

	 
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
	{
		if(p->pid==proc->pid  && p->state!=ZOMBIE && p->state!=UNUSED)
		{
			threadsCounter++;	
		}
		

	}


	if(threadsCounter==1)
	{


		for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
		if(p->state == ZOMBIE  && p->pid ==proc->pid && proc->threadId != p->threadId){
			
			
			kfree(p->kstack);
			p->kstack = 0;
			
			p->state = UNUSED;
			p->pid = 0;
			p->parent = 0;
			p->name[0] = 0;
			p->killed = 0;
			
			
		  }
	   release(&ptable.lock);
	   New_exit();
	   return ; 

	}


	  // Jump into the scheduler, never to return.
	  proc->state = ZOMBIE;
	  sched();
	  panic("zombie exit"); 
	  



}
void manage_exits()
{
   kthread_exit();

}

int kthread_join( int thread_id )
{
   struct proc *p;
  
  int ans=0;
  
  acquire(&ptable.lock);
  
  int i=0;
    // Scan through table looking for zombie children and correct thread
    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->threadId == thread_id  && p->state!=ZOMBIE)
	{
            ans=1;
	    break;
        }
        
      
   
    }
	
    
	
    if(ans==0)
    {
   release(&ptable.lock);
    return -1;

    }

    if(ans==1)
    {
	for(;i<64;i++)
	{
		if(p->sleepingThreads[i]==0)        
		{			
						
			p->sleepingThreads[i]=proc;
			break;		
			}
	}
         
        sleep(proc, &ptable.lock); 
	
	p->sleepingThreads[i]=0;
	release(&ptable.lock);
        return 0;
    }

   return -1;

}

void
exit(void)
{
   
  manage_exits();

}






void
minit(void)
{
  initlock(&mtable.lock, "mtable");
}


int 
kthread_mutex_alloc(){
	int i,j;
	kthread_mutex_t *mutex;
	acquire(&mtable.lock);
	//find unused mutex and allocate it:
	for (i = 0 ; i < MAX_MUTEXES ; i++){
		mutex = &mtable.kthread_locks[i];
		if (mutex->status == M_UNUSED){
			mutex->tid = 0;
			mutex->status = M_UNLOCKED;
			for (j = 0; j<MAX_THREADS; j++)
				mutex->sleepingTID[j] = 0;
			mutex->count = 0;
			mutex->startIndex = 0;
			release(&mtable.lock);
			return i;
		}
	}
	release(&mtable.lock);
	return -1;
}

int 
kthread_mutex_dealloc( int mutex_id ){
	kthread_mutex_t *mutex;
	acquire(&mtable.lock);
	mutex = &mtable.kthread_locks[mutex_id];
	if (mutex->status == M_UNLOCKED){
		mutex->status = M_UNUSED;
		release(&mtable.lock);
		return 0;
	}
	return -1;
}

int
kthread_mutex_lock( int mutex_id ){
	kthread_mutex_t *mutex;
	int destinationIndex;
	//int isInSleepingTID = 0;
	while(1){
		acquire(&mtable.lock);
		mutex = &mtable.kthread_locks[mutex_id];
		if (mutex->status == M_UNUSED){
			release(&mtable.lock);
			return -1;
		} else if (mutex->status == M_UNLOCKED){
					mutex->status = M_LOCKED;
					mutex->tid = proc->threadId;
					release(&mtable.lock);
					return 0;
		} else if (mutex->status == M_LOCKED){
					//add tid to the queue
					if (isInQueue(mutex_id, proc->threadId) == 0){
						destinationIndex =  (mutex->startIndex + mutex->count) % MAX_THREADS;
						mutex->sleepingTID[destinationIndex] = proc->threadId;
						mutex->count = mutex->count+1;
						//isInSleepingTID = 1;
					}
					release(&mtable.lock);
					//block
					acquire(&ptable.lock);
					proc->state = BLOCKING;
					sched();
					release(&ptable.lock);
					
					acquire(&mtable.lock);
					/*if (proc->threadId == mutex->tid){
						release(&mtable.lock);
						return 0;
					} else {
						release(&mtable.lock);
					}*/
					release(&mtable.lock);
					
		}
	}		
	return -1;
}


int
kthread_mutex_unlock( int mutex_id ){
	kthread_mutex_t *mutex;
	int i;
	int tidToWakeUp;
	struct proc *p;
	acquire(&mtable.lock);

	mutex = &mtable.kthread_locks[mutex_id];
	for( i = 0; i< MAX_THREADS; i++){
		cprintf("%d, ", mutex->sleepingTID[i]);
	}
	if (proc->threadId == mutex->tid && mutex->status == M_LOCKED){
		mutex->status=M_UNLOCKED;
		mutex->tid=0;
		//queue
		tidToWakeUp = mutex->sleepingTID[mutex->startIndex];
		if (tidToWakeUp !=0){
			mutex->count = mutex->count-1;
			mutex->startIndex = (mutex->startIndex + 1) % MAX_THREADS;
		}
	
		cprintf("\n%d, should wake up\n  start index: %d ", tidToWakeUp, mutex->startIndex);
		//end messing with queue
		//
		acquire(&ptable.lock); // now touching ptable!!
		//mutex->tid = tidToWakeUp;
		for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
			//cprintf("do yo come here");
			if (p->state == BLOCKING && p->threadId == tidToWakeUp){
				p->state = RUNNABLE;
				break;
			}
		}
		release(&ptable.lock);
		//wakeup(mutex);
		release(&mtable.lock);
		
		return 0;	
	} else {
	
		release(&mtable.lock);
		return -1;
	}
	
}


