#include "types.h"
#include "stat.h"
#include "user.h"
static int lock;
static int cond;
/*
int common=5;
void* thread()
{
	int k;
	kthread_mutex_lock(lock);
	for(k=0; k< 20; k++)
		printf(1, "my name is :%d\n",kthread_id());
	//sleep(300);	
	kthread_mutex_unlock(lock);
	kthread_exit();
	return (void *)1;
}

void* thread1(){
	kthread_mutex_lock(lock1);
	sleep(200);
	kthread_mutex_lock(lock2);
	
	kthread_mutex_unlock(lock2);
	kthread_mutex_unlock(lock1);
	
	kthread_exit();
	return (void *)1;
}

void* thread2(){
	kthread_mutex_lock(lock2);
	sleep(200);
	kthread_mutex_lock(lock1);
	
	kthread_mutex_unlock(lock1);
	kthread_mutex_unlock(lock2);
	
	kthread_exit();
	return (void *)2;
}

int main(void)
{
	int i;
	kthread_mutex_alloc();
	void* stack;// =malloc(4000);
	for(i = 0; i < 25; i++) {
		stack =malloc(4000);
		kthread_create(thread,stack,4000);
	}
	
	//(20);
//	sleep(2000);
//	kthread_mutex_dealloc(lock);
	exit();
}
*/

void * thread1 (void){
	printf(1, "I went to sleep %d\n", kthread_id());
	kthread_mutex_lock(lock);
	kthread_cond_wait(cond, lock);
	printf(1, "im came alive!! %d\n", kthread_id());
	kthread_mutex_unlock(lock);
	kthread_exit();
	return (void *) 0;
}

void * thread2 (void){
	kthread_mutex_lock(lock);
	printf(1,"I will wake him up!! %d", kthread_id());
	kthread_cond_signal(cond);
	kthread_exit();
	return (void *) 0;
}


int main(void){
	lock = kthread_mutex_alloc();
	cond = kthread_cond_alloc();
	int i;
	void* stack;// =malloc(4000);
	for(i = 0; i< 20; i++){
		stack =malloc(4000);
		kthread_create(thread1,stack,4000);
	}
	
	for(i = 0; i< 20; i++){
		stack =malloc(4000);
		kthread_create(thread2,stack,4000);
	}
	
	
	exit();
	//return (void *) 0;
}
