

#define MAX_THREADS 256
#include "kthread.h"
/*
#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
*/
//#include "proc.c"
/*
static int nextThread=0;
int strcmp(const char *p, const char *q)
{
while(*p && *p == *q)
    p++, q++;
 return (uchar)*p - (uchar)*q;
}



 //struct proc* allocproc(void);

int kthread_create( void*(*start_func)(), void* stack, unsigned int stack_size )
{
 int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

np->threadId=nextThread;
nextThread++;
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
void kthread_exit()
{
  
  
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  

  iput(proc->cwd);
  proc->cwd = 0;

  acquire(&ptable.lock);



//TODO JOIN  wakeup1(proc->parent);

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


}
*/


