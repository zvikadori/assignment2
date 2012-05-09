
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 72 02 00 00       	call   280 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 fa 02 00 00       	call   318 <sleep>
  exit();
  1e:	e8 65 02 00 00       	call   288 <exit>
  23:	90                   	nop

00000024 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	57                   	push   %edi
  28:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  29:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2c:	8b 55 10             	mov    0x10(%ebp),%edx
  2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  32:	89 cb                	mov    %ecx,%ebx
  34:	89 df                	mov    %ebx,%edi
  36:	89 d1                	mov    %edx,%ecx
  38:	fc                   	cld    
  39:	f3 aa                	rep stos %al,%es:(%edi)
  3b:	89 ca                	mov    %ecx,%edx
  3d:	89 fb                	mov    %edi,%ebx
  3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  42:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  45:	5b                   	pop    %ebx
  46:	5f                   	pop    %edi
  47:	5d                   	pop    %ebp
  48:	c3                   	ret    

00000049 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  49:	55                   	push   %ebp
  4a:	89 e5                	mov    %esp,%ebp
  4c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  4f:	8b 45 08             	mov    0x8(%ebp),%eax
  52:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  55:	90                   	nop
  56:	8b 45 0c             	mov    0xc(%ebp),%eax
  59:	0f b6 10             	movzbl (%eax),%edx
  5c:	8b 45 08             	mov    0x8(%ebp),%eax
  5f:	88 10                	mov    %dl,(%eax)
  61:	8b 45 08             	mov    0x8(%ebp),%eax
  64:	0f b6 00             	movzbl (%eax),%eax
  67:	84 c0                	test   %al,%al
  69:	0f 95 c0             	setne  %al
  6c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  70:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  74:	84 c0                	test   %al,%al
  76:	75 de                	jne    56 <strcpy+0xd>
    ;
  return os;
  78:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7b:	c9                   	leave  
  7c:	c3                   	ret    

0000007d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7d:	55                   	push   %ebp
  7e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  80:	eb 08                	jmp    8a <strcmp+0xd>
    p++, q++;
  82:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  86:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8a:	8b 45 08             	mov    0x8(%ebp),%eax
  8d:	0f b6 00             	movzbl (%eax),%eax
  90:	84 c0                	test   %al,%al
  92:	74 10                	je     a4 <strcmp+0x27>
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	0f b6 10             	movzbl (%eax),%edx
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	0f b6 00             	movzbl (%eax),%eax
  a0:	38 c2                	cmp    %al,%dl
  a2:	74 de                	je     82 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a4:	8b 45 08             	mov    0x8(%ebp),%eax
  a7:	0f b6 00             	movzbl (%eax),%eax
  aa:	0f b6 d0             	movzbl %al,%edx
  ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  b0:	0f b6 00             	movzbl (%eax),%eax
  b3:	0f b6 c0             	movzbl %al,%eax
  b6:	89 d1                	mov    %edx,%ecx
  b8:	29 c1                	sub    %eax,%ecx
  ba:	89 c8                	mov    %ecx,%eax
}
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    

000000be <strlen>:

uint
strlen(char *s)
{
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  c1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cb:	eb 04                	jmp    d1 <strlen+0x13>
  cd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  d4:	03 45 08             	add    0x8(%ebp),%eax
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	84 c0                	test   %al,%al
  dc:	75 ef                	jne    cd <strlen+0xf>
    ;
  return n;
  de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e1:	c9                   	leave  
  e2:	c3                   	ret    

000000e3 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  e9:	8b 45 10             	mov    0x10(%ebp),%eax
  ec:	89 44 24 08          	mov    %eax,0x8(%esp)
  f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  f7:	8b 45 08             	mov    0x8(%ebp),%eax
  fa:	89 04 24             	mov    %eax,(%esp)
  fd:	e8 22 ff ff ff       	call   24 <stosb>
  return dst;
 102:	8b 45 08             	mov    0x8(%ebp),%eax
}
 105:	c9                   	leave  
 106:	c3                   	ret    

00000107 <strchr>:

char*
strchr(const char *s, char c)
{
 107:	55                   	push   %ebp
 108:	89 e5                	mov    %esp,%ebp
 10a:	83 ec 04             	sub    $0x4,%esp
 10d:	8b 45 0c             	mov    0xc(%ebp),%eax
 110:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 113:	eb 14                	jmp    129 <strchr+0x22>
    if(*s == c)
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 11e:	75 05                	jne    125 <strchr+0x1e>
      return (char*)s;
 120:	8b 45 08             	mov    0x8(%ebp),%eax
 123:	eb 13                	jmp    138 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 125:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 129:	8b 45 08             	mov    0x8(%ebp),%eax
 12c:	0f b6 00             	movzbl (%eax),%eax
 12f:	84 c0                	test   %al,%al
 131:	75 e2                	jne    115 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 133:	b8 00 00 00 00       	mov    $0x0,%eax
}
 138:	c9                   	leave  
 139:	c3                   	ret    

0000013a <gets>:

char*
gets(char *buf, int max)
{
 13a:	55                   	push   %ebp
 13b:	89 e5                	mov    %esp,%ebp
 13d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 140:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 147:	eb 44                	jmp    18d <gets+0x53>
    cc = read(0, &c, 1);
 149:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 150:	00 
 151:	8d 45 ef             	lea    -0x11(%ebp),%eax
 154:	89 44 24 04          	mov    %eax,0x4(%esp)
 158:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15f:	e8 3c 01 00 00       	call   2a0 <read>
 164:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 167:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 16b:	7e 2d                	jle    19a <gets+0x60>
      break;
    buf[i++] = c;
 16d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 170:	03 45 08             	add    0x8(%ebp),%eax
 173:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 177:	88 10                	mov    %dl,(%eax)
 179:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 17d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 181:	3c 0a                	cmp    $0xa,%al
 183:	74 16                	je     19b <gets+0x61>
 185:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 189:	3c 0d                	cmp    $0xd,%al
 18b:	74 0e                	je     19b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 190:	83 c0 01             	add    $0x1,%eax
 193:	3b 45 0c             	cmp    0xc(%ebp),%eax
 196:	7c b1                	jl     149 <gets+0xf>
 198:	eb 01                	jmp    19b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 19a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19e:	03 45 08             	add    0x8(%ebp),%eax
 1a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a7:	c9                   	leave  
 1a8:	c3                   	ret    

000001a9 <stat>:

int
stat(char *n, struct stat *st)
{
 1a9:	55                   	push   %ebp
 1aa:	89 e5                	mov    %esp,%ebp
 1ac:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b6:	00 
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	89 04 24             	mov    %eax,(%esp)
 1bd:	e8 06 01 00 00       	call   2c8 <open>
 1c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c9:	79 07                	jns    1d2 <stat+0x29>
    return -1;
 1cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d0:	eb 23                	jmp    1f5 <stat+0x4c>
  r = fstat(fd, st);
 1d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1dc:	89 04 24             	mov    %eax,(%esp)
 1df:	e8 fc 00 00 00       	call   2e0 <fstat>
 1e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ea:	89 04 24             	mov    %eax,(%esp)
 1ed:	e8 be 00 00 00       	call   2b0 <close>
  return r;
 1f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f5:	c9                   	leave  
 1f6:	c3                   	ret    

000001f7 <atoi>:

int
atoi(const char *s)
{
 1f7:	55                   	push   %ebp
 1f8:	89 e5                	mov    %esp,%ebp
 1fa:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 204:	eb 23                	jmp    229 <atoi+0x32>
    n = n*10 + *s++ - '0';
 206:	8b 55 fc             	mov    -0x4(%ebp),%edx
 209:	89 d0                	mov    %edx,%eax
 20b:	c1 e0 02             	shl    $0x2,%eax
 20e:	01 d0                	add    %edx,%eax
 210:	01 c0                	add    %eax,%eax
 212:	89 c2                	mov    %eax,%edx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	0f b6 00             	movzbl (%eax),%eax
 21a:	0f be c0             	movsbl %al,%eax
 21d:	01 d0                	add    %edx,%eax
 21f:	83 e8 30             	sub    $0x30,%eax
 222:	89 45 fc             	mov    %eax,-0x4(%ebp)
 225:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	0f b6 00             	movzbl (%eax),%eax
 22f:	3c 2f                	cmp    $0x2f,%al
 231:	7e 0a                	jle    23d <atoi+0x46>
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 00             	movzbl (%eax),%eax
 239:	3c 39                	cmp    $0x39,%al
 23b:	7e c9                	jle    206 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 23d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 240:	c9                   	leave  
 241:	c3                   	ret    

00000242 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 242:	55                   	push   %ebp
 243:	89 e5                	mov    %esp,%ebp
 245:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 24e:	8b 45 0c             	mov    0xc(%ebp),%eax
 251:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 254:	eb 13                	jmp    269 <memmove+0x27>
    *dst++ = *src++;
 256:	8b 45 f8             	mov    -0x8(%ebp),%eax
 259:	0f b6 10             	movzbl (%eax),%edx
 25c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25f:	88 10                	mov    %dl,(%eax)
 261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 265:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 269:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 26d:	0f 9f c0             	setg   %al
 270:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 274:	84 c0                	test   %al,%al
 276:	75 de                	jne    256 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 278:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27b:	c9                   	leave  
 27c:	c3                   	ret    
 27d:	90                   	nop
 27e:	90                   	nop
 27f:	90                   	nop

00000280 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 280:	b8 01 00 00 00       	mov    $0x1,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <exit>:
SYSCALL(exit)
 288:	b8 02 00 00 00       	mov    $0x2,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <wait>:
SYSCALL(wait)
 290:	b8 03 00 00 00       	mov    $0x3,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <pipe>:
SYSCALL(pipe)
 298:	b8 04 00 00 00       	mov    $0x4,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <read>:
SYSCALL(read)
 2a0:	b8 05 00 00 00       	mov    $0x5,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <write>:
SYSCALL(write)
 2a8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <close>:
SYSCALL(close)
 2b0:	b8 15 00 00 00       	mov    $0x15,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <kill>:
SYSCALL(kill)
 2b8:	b8 06 00 00 00       	mov    $0x6,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <exec>:
SYSCALL(exec)
 2c0:	b8 07 00 00 00       	mov    $0x7,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <open>:
SYSCALL(open)
 2c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mknod>:
SYSCALL(mknod)
 2d0:	b8 11 00 00 00       	mov    $0x11,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <unlink>:
SYSCALL(unlink)
 2d8:	b8 12 00 00 00       	mov    $0x12,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <fstat>:
SYSCALL(fstat)
 2e0:	b8 08 00 00 00       	mov    $0x8,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <link>:
SYSCALL(link)
 2e8:	b8 13 00 00 00       	mov    $0x13,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mkdir>:
SYSCALL(mkdir)
 2f0:	b8 14 00 00 00       	mov    $0x14,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <chdir>:
SYSCALL(chdir)
 2f8:	b8 09 00 00 00       	mov    $0x9,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <dup>:
SYSCALL(dup)
 300:	b8 0a 00 00 00       	mov    $0xa,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <getpid>:
SYSCALL(getpid)
 308:	b8 0b 00 00 00       	mov    $0xb,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <sbrk>:
SYSCALL(sbrk)
 310:	b8 0c 00 00 00       	mov    $0xc,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <sleep>:
SYSCALL(sleep)
 318:	b8 0d 00 00 00       	mov    $0xd,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <uptime>:
SYSCALL(uptime)
 320:	b8 0e 00 00 00       	mov    $0xe,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	83 ec 28             	sub    $0x28,%esp
 32e:	8b 45 0c             	mov    0xc(%ebp),%eax
 331:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 334:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 33b:	00 
 33c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 33f:	89 44 24 04          	mov    %eax,0x4(%esp)
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	89 04 24             	mov    %eax,(%esp)
 349:	e8 5a ff ff ff       	call   2a8 <write>
}
 34e:	c9                   	leave  
 34f:	c3                   	ret    

00000350 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 356:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 35d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 361:	74 17                	je     37a <printint+0x2a>
 363:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 367:	79 11                	jns    37a <printint+0x2a>
    neg = 1;
 369:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 370:	8b 45 0c             	mov    0xc(%ebp),%eax
 373:	f7 d8                	neg    %eax
 375:	89 45 ec             	mov    %eax,-0x14(%ebp)
 378:	eb 06                	jmp    380 <printint+0x30>
  } else {
    x = xx;
 37a:	8b 45 0c             	mov    0xc(%ebp),%eax
 37d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 380:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 387:	8b 4d 10             	mov    0x10(%ebp),%ecx
 38a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 38d:	ba 00 00 00 00       	mov    $0x0,%edx
 392:	f7 f1                	div    %ecx
 394:	89 d0                	mov    %edx,%eax
 396:	0f b6 90 08 0a 00 00 	movzbl 0xa08(%eax),%edx
 39d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3a0:	03 45 f4             	add    -0xc(%ebp),%eax
 3a3:	88 10                	mov    %dl,(%eax)
 3a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3a9:	8b 55 10             	mov    0x10(%ebp),%edx
 3ac:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3af:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b2:	ba 00 00 00 00       	mov    $0x0,%edx
 3b7:	f7 75 d4             	divl   -0x2c(%ebp)
 3ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3c1:	75 c4                	jne    387 <printint+0x37>
  if(neg)
 3c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3c7:	74 2a                	je     3f3 <printint+0xa3>
    buf[i++] = '-';
 3c9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3cc:	03 45 f4             	add    -0xc(%ebp),%eax
 3cf:	c6 00 2d             	movb   $0x2d,(%eax)
 3d2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 3d6:	eb 1b                	jmp    3f3 <printint+0xa3>
    putc(fd, buf[i]);
 3d8:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3db:	03 45 f4             	add    -0xc(%ebp),%eax
 3de:	0f b6 00             	movzbl (%eax),%eax
 3e1:	0f be c0             	movsbl %al,%eax
 3e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e8:	8b 45 08             	mov    0x8(%ebp),%eax
 3eb:	89 04 24             	mov    %eax,(%esp)
 3ee:	e8 35 ff ff ff       	call   328 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3f3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3fb:	79 db                	jns    3d8 <printint+0x88>
    putc(fd, buf[i]);
}
 3fd:	c9                   	leave  
 3fe:	c3                   	ret    

000003ff <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3ff:	55                   	push   %ebp
 400:	89 e5                	mov    %esp,%ebp
 402:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 405:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 40c:	8d 45 0c             	lea    0xc(%ebp),%eax
 40f:	83 c0 04             	add    $0x4,%eax
 412:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 415:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 41c:	e9 7d 01 00 00       	jmp    59e <printf+0x19f>
    c = fmt[i] & 0xff;
 421:	8b 55 0c             	mov    0xc(%ebp),%edx
 424:	8b 45 f0             	mov    -0x10(%ebp),%eax
 427:	01 d0                	add    %edx,%eax
 429:	0f b6 00             	movzbl (%eax),%eax
 42c:	0f be c0             	movsbl %al,%eax
 42f:	25 ff 00 00 00       	and    $0xff,%eax
 434:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 437:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 43b:	75 2c                	jne    469 <printf+0x6a>
      if(c == '%'){
 43d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 441:	75 0c                	jne    44f <printf+0x50>
        state = '%';
 443:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 44a:	e9 4b 01 00 00       	jmp    59a <printf+0x19b>
      } else {
        putc(fd, c);
 44f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 452:	0f be c0             	movsbl %al,%eax
 455:	89 44 24 04          	mov    %eax,0x4(%esp)
 459:	8b 45 08             	mov    0x8(%ebp),%eax
 45c:	89 04 24             	mov    %eax,(%esp)
 45f:	e8 c4 fe ff ff       	call   328 <putc>
 464:	e9 31 01 00 00       	jmp    59a <printf+0x19b>
      }
    } else if(state == '%'){
 469:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 46d:	0f 85 27 01 00 00    	jne    59a <printf+0x19b>
      if(c == 'd'){
 473:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 477:	75 2d                	jne    4a6 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 479:	8b 45 e8             	mov    -0x18(%ebp),%eax
 47c:	8b 00                	mov    (%eax),%eax
 47e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 485:	00 
 486:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 48d:	00 
 48e:	89 44 24 04          	mov    %eax,0x4(%esp)
 492:	8b 45 08             	mov    0x8(%ebp),%eax
 495:	89 04 24             	mov    %eax,(%esp)
 498:	e8 b3 fe ff ff       	call   350 <printint>
        ap++;
 49d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4a1:	e9 ed 00 00 00       	jmp    593 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 4a6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4aa:	74 06                	je     4b2 <printf+0xb3>
 4ac:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4b0:	75 2d                	jne    4df <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b5:	8b 00                	mov    (%eax),%eax
 4b7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4be:	00 
 4bf:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4c6:	00 
 4c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ce:	89 04 24             	mov    %eax,(%esp)
 4d1:	e8 7a fe ff ff       	call   350 <printint>
        ap++;
 4d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4da:	e9 b4 00 00 00       	jmp    593 <printf+0x194>
      } else if(c == 's'){
 4df:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4e3:	75 46                	jne    52b <printf+0x12c>
        s = (char*)*ap;
 4e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e8:	8b 00                	mov    (%eax),%eax
 4ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4ed:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f5:	75 27                	jne    51e <printf+0x11f>
          s = "(null)";
 4f7:	c7 45 f4 c3 07 00 00 	movl   $0x7c3,-0xc(%ebp)
        while(*s != 0){
 4fe:	eb 1e                	jmp    51e <printf+0x11f>
          putc(fd, *s);
 500:	8b 45 f4             	mov    -0xc(%ebp),%eax
 503:	0f b6 00             	movzbl (%eax),%eax
 506:	0f be c0             	movsbl %al,%eax
 509:	89 44 24 04          	mov    %eax,0x4(%esp)
 50d:	8b 45 08             	mov    0x8(%ebp),%eax
 510:	89 04 24             	mov    %eax,(%esp)
 513:	e8 10 fe ff ff       	call   328 <putc>
          s++;
 518:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 51c:	eb 01                	jmp    51f <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 51e:	90                   	nop
 51f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 522:	0f b6 00             	movzbl (%eax),%eax
 525:	84 c0                	test   %al,%al
 527:	75 d7                	jne    500 <printf+0x101>
 529:	eb 68                	jmp    593 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 52b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 52f:	75 1d                	jne    54e <printf+0x14f>
        putc(fd, *ap);
 531:	8b 45 e8             	mov    -0x18(%ebp),%eax
 534:	8b 00                	mov    (%eax),%eax
 536:	0f be c0             	movsbl %al,%eax
 539:	89 44 24 04          	mov    %eax,0x4(%esp)
 53d:	8b 45 08             	mov    0x8(%ebp),%eax
 540:	89 04 24             	mov    %eax,(%esp)
 543:	e8 e0 fd ff ff       	call   328 <putc>
        ap++;
 548:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54c:	eb 45                	jmp    593 <printf+0x194>
      } else if(c == '%'){
 54e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 552:	75 17                	jne    56b <printf+0x16c>
        putc(fd, c);
 554:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 557:	0f be c0             	movsbl %al,%eax
 55a:	89 44 24 04          	mov    %eax,0x4(%esp)
 55e:	8b 45 08             	mov    0x8(%ebp),%eax
 561:	89 04 24             	mov    %eax,(%esp)
 564:	e8 bf fd ff ff       	call   328 <putc>
 569:	eb 28                	jmp    593 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 56b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 572:	00 
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	89 04 24             	mov    %eax,(%esp)
 579:	e8 aa fd ff ff       	call   328 <putc>
        putc(fd, c);
 57e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 581:	0f be c0             	movsbl %al,%eax
 584:	89 44 24 04          	mov    %eax,0x4(%esp)
 588:	8b 45 08             	mov    0x8(%ebp),%eax
 58b:	89 04 24             	mov    %eax,(%esp)
 58e:	e8 95 fd ff ff       	call   328 <putc>
      }
      state = 0;
 593:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 59a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 59e:	8b 55 0c             	mov    0xc(%ebp),%edx
 5a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5a4:	01 d0                	add    %edx,%eax
 5a6:	0f b6 00             	movzbl (%eax),%eax
 5a9:	84 c0                	test   %al,%al
 5ab:	0f 85 70 fe ff ff    	jne    421 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b1:	c9                   	leave  
 5b2:	c3                   	ret    
 5b3:	90                   	nop

000005b4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5ba:	8b 45 08             	mov    0x8(%ebp),%eax
 5bd:	83 e8 08             	sub    $0x8,%eax
 5c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c3:	a1 24 0a 00 00       	mov    0xa24,%eax
 5c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5cb:	eb 24                	jmp    5f1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d0:	8b 00                	mov    (%eax),%eax
 5d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d5:	77 12                	ja     5e9 <free+0x35>
 5d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5da:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5dd:	77 24                	ja     603 <free+0x4f>
 5df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e2:	8b 00                	mov    (%eax),%eax
 5e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5e7:	77 1a                	ja     603 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ec:	8b 00                	mov    (%eax),%eax
 5ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f7:	76 d4                	jbe    5cd <free+0x19>
 5f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fc:	8b 00                	mov    (%eax),%eax
 5fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 601:	76 ca                	jbe    5cd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 603:	8b 45 f8             	mov    -0x8(%ebp),%eax
 606:	8b 40 04             	mov    0x4(%eax),%eax
 609:	c1 e0 03             	shl    $0x3,%eax
 60c:	89 c2                	mov    %eax,%edx
 60e:	03 55 f8             	add    -0x8(%ebp),%edx
 611:	8b 45 fc             	mov    -0x4(%ebp),%eax
 614:	8b 00                	mov    (%eax),%eax
 616:	39 c2                	cmp    %eax,%edx
 618:	75 24                	jne    63e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 61a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61d:	8b 50 04             	mov    0x4(%eax),%edx
 620:	8b 45 fc             	mov    -0x4(%ebp),%eax
 623:	8b 00                	mov    (%eax),%eax
 625:	8b 40 04             	mov    0x4(%eax),%eax
 628:	01 c2                	add    %eax,%edx
 62a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 630:	8b 45 fc             	mov    -0x4(%ebp),%eax
 633:	8b 00                	mov    (%eax),%eax
 635:	8b 10                	mov    (%eax),%edx
 637:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63a:	89 10                	mov    %edx,(%eax)
 63c:	eb 0a                	jmp    648 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 63e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 641:	8b 10                	mov    (%eax),%edx
 643:	8b 45 f8             	mov    -0x8(%ebp),%eax
 646:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 648:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64b:	8b 40 04             	mov    0x4(%eax),%eax
 64e:	c1 e0 03             	shl    $0x3,%eax
 651:	03 45 fc             	add    -0x4(%ebp),%eax
 654:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 657:	75 20                	jne    679 <free+0xc5>
    p->s.size += bp->s.size;
 659:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65c:	8b 50 04             	mov    0x4(%eax),%edx
 65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 662:	8b 40 04             	mov    0x4(%eax),%eax
 665:	01 c2                	add    %eax,%edx
 667:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 66d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 670:	8b 10                	mov    (%eax),%edx
 672:	8b 45 fc             	mov    -0x4(%ebp),%eax
 675:	89 10                	mov    %edx,(%eax)
 677:	eb 08                	jmp    681 <free+0xcd>
  } else
    p->s.ptr = bp;
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 67f:	89 10                	mov    %edx,(%eax)
  freep = p;
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	a3 24 0a 00 00       	mov    %eax,0xa24
}
 689:	c9                   	leave  
 68a:	c3                   	ret    

0000068b <morecore>:

static Header*
morecore(uint nu)
{
 68b:	55                   	push   %ebp
 68c:	89 e5                	mov    %esp,%ebp
 68e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 691:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 698:	77 07                	ja     6a1 <morecore+0x16>
    nu = 4096;
 69a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6a1:	8b 45 08             	mov    0x8(%ebp),%eax
 6a4:	c1 e0 03             	shl    $0x3,%eax
 6a7:	89 04 24             	mov    %eax,(%esp)
 6aa:	e8 61 fc ff ff       	call   310 <sbrk>
 6af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6b2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6b6:	75 07                	jne    6bf <morecore+0x34>
    return 0;
 6b8:	b8 00 00 00 00       	mov    $0x0,%eax
 6bd:	eb 22                	jmp    6e1 <morecore+0x56>
  hp = (Header*)p;
 6bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c8:	8b 55 08             	mov    0x8(%ebp),%edx
 6cb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d1:	83 c0 08             	add    $0x8,%eax
 6d4:	89 04 24             	mov    %eax,(%esp)
 6d7:	e8 d8 fe ff ff       	call   5b4 <free>
  return freep;
 6dc:	a1 24 0a 00 00       	mov    0xa24,%eax
}
 6e1:	c9                   	leave  
 6e2:	c3                   	ret    

000006e3 <malloc>:

void*
malloc(uint nbytes)
{
 6e3:	55                   	push   %ebp
 6e4:	89 e5                	mov    %esp,%ebp
 6e6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ec:	83 c0 07             	add    $0x7,%eax
 6ef:	c1 e8 03             	shr    $0x3,%eax
 6f2:	83 c0 01             	add    $0x1,%eax
 6f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6f8:	a1 24 0a 00 00       	mov    0xa24,%eax
 6fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 700:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 704:	75 23                	jne    729 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 706:	c7 45 f0 1c 0a 00 00 	movl   $0xa1c,-0x10(%ebp)
 70d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 710:	a3 24 0a 00 00       	mov    %eax,0xa24
 715:	a1 24 0a 00 00       	mov    0xa24,%eax
 71a:	a3 1c 0a 00 00       	mov    %eax,0xa1c
    base.s.size = 0;
 71f:	c7 05 20 0a 00 00 00 	movl   $0x0,0xa20
 726:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 729:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72c:	8b 00                	mov    (%eax),%eax
 72e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 731:	8b 45 f4             	mov    -0xc(%ebp),%eax
 734:	8b 40 04             	mov    0x4(%eax),%eax
 737:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 73a:	72 4d                	jb     789 <malloc+0xa6>
      if(p->s.size == nunits)
 73c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73f:	8b 40 04             	mov    0x4(%eax),%eax
 742:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 745:	75 0c                	jne    753 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 747:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74a:	8b 10                	mov    (%eax),%edx
 74c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74f:	89 10                	mov    %edx,(%eax)
 751:	eb 26                	jmp    779 <malloc+0x96>
      else {
        p->s.size -= nunits;
 753:	8b 45 f4             	mov    -0xc(%ebp),%eax
 756:	8b 40 04             	mov    0x4(%eax),%eax
 759:	89 c2                	mov    %eax,%edx
 75b:	2b 55 ec             	sub    -0x14(%ebp),%edx
 75e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 761:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 764:	8b 45 f4             	mov    -0xc(%ebp),%eax
 767:	8b 40 04             	mov    0x4(%eax),%eax
 76a:	c1 e0 03             	shl    $0x3,%eax
 76d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 770:	8b 45 f4             	mov    -0xc(%ebp),%eax
 773:	8b 55 ec             	mov    -0x14(%ebp),%edx
 776:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 779:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77c:	a3 24 0a 00 00       	mov    %eax,0xa24
      return (void*)(p + 1);
 781:	8b 45 f4             	mov    -0xc(%ebp),%eax
 784:	83 c0 08             	add    $0x8,%eax
 787:	eb 38                	jmp    7c1 <malloc+0xde>
    }
    if(p == freep)
 789:	a1 24 0a 00 00       	mov    0xa24,%eax
 78e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 791:	75 1b                	jne    7ae <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 793:	8b 45 ec             	mov    -0x14(%ebp),%eax
 796:	89 04 24             	mov    %eax,(%esp)
 799:	e8 ed fe ff ff       	call   68b <morecore>
 79e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a5:	75 07                	jne    7ae <malloc+0xcb>
        return 0;
 7a7:	b8 00 00 00 00       	mov    $0x0,%eax
 7ac:	eb 13                	jmp    7c1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b7:	8b 00                	mov    (%eax),%eax
 7b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7bc:	e9 70 ff ff ff       	jmp    731 <malloc+0x4e>
}
 7c1:	c9                   	leave  
 7c2:	c3                   	ret    
