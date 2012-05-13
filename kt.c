#include "types.h"
#include "stat.h"
#include "user.h"

int common=5;
void* thread()
{
       int i=4;
   	

	i++;	
	while(i>0)   	
	{	
	printf(2,"my thread id is:%d and i=%d\n",kthread_id(),i);
	i--;
	}
        
	kthread_exit();
    

return (void*)2;	

}
int main(void)
{
 
  int i=0;
  
       //void* stack =malloc(4000);
  	//kthread_create(thread,stack,4000);
       for(;i<1;i++)
       {
        void* stack =malloc(4000);
  	kthread_create(thread,stack,4000);
      
       }
   
  kthread_join(25);



   

 
printf(1,"nana\n");

  
  

exit();
return 0;

}
