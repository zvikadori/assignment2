#include "types.h"
#include "x86.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "kthread.h"

extern int kthread_create( void*(*start_func)(), void* stack, unsigned int stack_size );
extern int kthread_id();
extern void kthread_exit();
extern int kthread_join( int thread_id );

int sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;
  
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}



/*    kernel threads section */

int sys_kthread_create(void)
{
int start_func;
int stack;
int stack_size;
void*(*t)() ;
argint(0, &start_func);
argint(1, &stack);
argint(2, &stack_size);
t=  (void* (*)(void*))(start_func);
return kthread_create(t, (void*) stack, (unsigned int) stack_size );
}
int sys_kthread_id(void)
{
     return kthread_id();

}

int sys_kthread_exit(void)
{
	 kthread_exit();
	return 1;

}



int sys_kthread_join(void)
{
     int tid;
     argint(0, &tid);
     return kthread_join(tid);


}
/*    end kernel threads section */

/*    mutex section */

int sys_kthread_mutex_alloc(void){
	return kthread_mutex_alloc();
}
int sys_kthread_mutex_dealloc(void){
	int mutex_id;
	argint(0, &mutex_id); 
	return kthread_mutex_dealloc(mutex_id);
}
int sys_kthread_mutex_lock(void){
	int mutex_id;
	argint(0, &mutex_id); 
	return kthread_mutex_lock(mutex_id);	
}
int sys_kthread_mutex_unlock(void){
	int mutex_id;
	argint(0, &mutex_id); 
	return kthread_mutex_unlock(mutex_id);	
}

/* end mutex section */


int kthread_cond_alloc();
int kthread_cond_dealloc( int cond_id );
int kthread_cond_wait( int cond_id, int mutex_id );
int kthread_cond_signal( int cond_id );

/* cond vars section */
int sys_kthread_cond_alloc(void){
	return kthread_cond_alloc();
}

int sys_kthread_cond_dealloc(void){
	int cond_id;
	argint(0, &cond_id);
	return kthread_cond_dealloc(cond_id);
}

int sys_kthread_cond_wait(void){
	int cond_id;
	int mutex_id;
	argint(0, &cond_id);
	argint(1, &mutex_id);
	return kthread_cond_wait(cond_id, mutex_id);
}

int sys_kthread_cond_signal(void){
	int cond_id;
	argint(0, &cond_id);
	return kthread_cond_signal(cond_id);
}



/* end cond vars section */










