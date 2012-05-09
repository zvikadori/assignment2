
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	81 ec 30 02 00 00    	sub    $0x230,%esp
  int fd, i;
  char path[] = "stressfs0";
   c:	c7 84 24 1e 02 00 00 	movl   $0x65727473,0x21e(%esp)
  13:	73 74 72 65 
  17:	c7 84 24 22 02 00 00 	movl   $0x73667373,0x222(%esp)
  1e:	73 73 66 73 
  22:	66 c7 84 24 26 02 00 	movw   $0x30,0x226(%esp)
  29:	00 30 00 
  char data[512];

  printf(1, "stressfs starting\n");
  2c:	c7 44 24 04 53 09 00 	movl   $0x953,0x4(%esp)
  33:	00 
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	e8 4f 05 00 00       	call   58f <printf>
  memset(data, 'a', sizeof(data));
  40:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  47:	00 
  48:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  4f:	00 
  50:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  54:	89 04 24             	mov    %eax,(%esp)
  57:	e8 17 02 00 00       	call   273 <memset>

  for(i = 0; i < 4; i++)
  5c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  63:	00 00 00 00 
  67:	eb 11                	jmp    7a <main+0x7a>
    if(fork() > 0)
  69:	e8 a2 03 00 00       	call   410 <fork>
  6e:	85 c0                	test   %eax,%eax
  70:	7f 14                	jg     86 <main+0x86>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  72:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
  79:	01 
  7a:	83 bc 24 2c 02 00 00 	cmpl   $0x3,0x22c(%esp)
  81:	03 
  82:	7e e5                	jle    69 <main+0x69>
  84:	eb 01                	jmp    87 <main+0x87>
    if(fork() > 0)
      break;
  86:	90                   	nop

  printf(1, "write %d\n", i);
  87:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  8e:	89 44 24 08          	mov    %eax,0x8(%esp)
  92:	c7 44 24 04 66 09 00 	movl   $0x966,0x4(%esp)
  99:	00 
  9a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a1:	e8 e9 04 00 00       	call   58f <printf>

  path[8] += i;
  a6:	0f b6 84 24 26 02 00 	movzbl 0x226(%esp),%eax
  ad:	00 
  ae:	89 c2                	mov    %eax,%edx
  b0:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  b7:	01 d0                	add    %edx,%eax
  b9:	88 84 24 26 02 00 00 	mov    %al,0x226(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  c0:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  c7:	00 
  c8:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
  cf:	89 04 24             	mov    %eax,(%esp)
  d2:	e8 81 03 00 00       	call   458 <open>
  d7:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for(i = 0; i < 20; i++)
  de:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  e5:	00 00 00 00 
  e9:	eb 27                	jmp    112 <main+0x112>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  eb:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  f2:	00 
  f3:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  fb:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 102:	89 04 24             	mov    %eax,(%esp)
 105:	e8 2e 03 00 00       	call   438 <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
 10a:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 111:	01 
 112:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 119:	13 
 11a:	7e cf                	jle    eb <main+0xeb>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
 11c:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 123:	89 04 24             	mov    %eax,(%esp)
 126:	e8 15 03 00 00       	call   440 <close>

  printf(1, "read\n");
 12b:	c7 44 24 04 70 09 00 	movl   $0x970,0x4(%esp)
 132:	00 
 133:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13a:	e8 50 04 00 00       	call   58f <printf>

  fd = open(path, O_RDONLY);
 13f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 146:	00 
 147:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
 14e:	89 04 24             	mov    %eax,(%esp)
 151:	e8 02 03 00 00       	call   458 <open>
 156:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for (i = 0; i < 20; i++)
 15d:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
 164:	00 00 00 00 
 168:	eb 27                	jmp    191 <main+0x191>
    read(fd, data, sizeof(data));
 16a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 171:	00 
 172:	8d 44 24 1e          	lea    0x1e(%esp),%eax
 176:	89 44 24 04          	mov    %eax,0x4(%esp)
 17a:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 181:	89 04 24             	mov    %eax,(%esp)
 184:	e8 a7 02 00 00       	call   430 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 189:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 190:	01 
 191:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 198:	13 
 199:	7e cf                	jle    16a <main+0x16a>
    read(fd, data, sizeof(data));
  close(fd);
 19b:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 1a2:	89 04 24             	mov    %eax,(%esp)
 1a5:	e8 96 02 00 00       	call   440 <close>

  wait();
 1aa:	e8 71 02 00 00       	call   420 <wait>
  
  exit();
 1af:	e8 64 02 00 00       	call   418 <exit>

000001b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	57                   	push   %edi
 1b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bc:	8b 55 10             	mov    0x10(%ebp),%edx
 1bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c2:	89 cb                	mov    %ecx,%ebx
 1c4:	89 df                	mov    %ebx,%edi
 1c6:	89 d1                	mov    %edx,%ecx
 1c8:	fc                   	cld    
 1c9:	f3 aa                	rep stos %al,%es:(%edi)
 1cb:	89 ca                	mov    %ecx,%edx
 1cd:	89 fb                	mov    %edi,%ebx
 1cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d5:	5b                   	pop    %ebx
 1d6:	5f                   	pop    %edi
 1d7:	5d                   	pop    %ebp
 1d8:	c3                   	ret    

000001d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1d9:	55                   	push   %ebp
 1da:	89 e5                	mov    %esp,%ebp
 1dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e5:	90                   	nop
 1e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e9:	0f b6 10             	movzbl (%eax),%edx
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	88 10                	mov    %dl,(%eax)
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	0f b6 00             	movzbl (%eax),%eax
 1f7:	84 c0                	test   %al,%al
 1f9:	0f 95 c0             	setne  %al
 1fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 200:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 204:	84 c0                	test   %al,%al
 206:	75 de                	jne    1e6 <strcpy+0xd>
    ;
  return os;
 208:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20b:	c9                   	leave  
 20c:	c3                   	ret    

0000020d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 20d:	55                   	push   %ebp
 20e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 210:	eb 08                	jmp    21a <strcmp+0xd>
    p++, q++;
 212:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 216:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	0f b6 00             	movzbl (%eax),%eax
 220:	84 c0                	test   %al,%al
 222:	74 10                	je     234 <strcmp+0x27>
 224:	8b 45 08             	mov    0x8(%ebp),%eax
 227:	0f b6 10             	movzbl (%eax),%edx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	0f b6 00             	movzbl (%eax),%eax
 230:	38 c2                	cmp    %al,%dl
 232:	74 de                	je     212 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	0f b6 00             	movzbl (%eax),%eax
 23a:	0f b6 d0             	movzbl %al,%edx
 23d:	8b 45 0c             	mov    0xc(%ebp),%eax
 240:	0f b6 00             	movzbl (%eax),%eax
 243:	0f b6 c0             	movzbl %al,%eax
 246:	89 d1                	mov    %edx,%ecx
 248:	29 c1                	sub    %eax,%ecx
 24a:	89 c8                	mov    %ecx,%eax
}
 24c:	5d                   	pop    %ebp
 24d:	c3                   	ret    

0000024e <strlen>:

uint
strlen(char *s)
{
 24e:	55                   	push   %ebp
 24f:	89 e5                	mov    %esp,%ebp
 251:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 25b:	eb 04                	jmp    261 <strlen+0x13>
 25d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 261:	8b 45 fc             	mov    -0x4(%ebp),%eax
 264:	03 45 08             	add    0x8(%ebp),%eax
 267:	0f b6 00             	movzbl (%eax),%eax
 26a:	84 c0                	test   %al,%al
 26c:	75 ef                	jne    25d <strlen+0xf>
    ;
  return n;
 26e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 271:	c9                   	leave  
 272:	c3                   	ret    

00000273 <memset>:

void*
memset(void *dst, int c, uint n)
{
 273:	55                   	push   %ebp
 274:	89 e5                	mov    %esp,%ebp
 276:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 279:	8b 45 10             	mov    0x10(%ebp),%eax
 27c:	89 44 24 08          	mov    %eax,0x8(%esp)
 280:	8b 45 0c             	mov    0xc(%ebp),%eax
 283:	89 44 24 04          	mov    %eax,0x4(%esp)
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	89 04 24             	mov    %eax,(%esp)
 28d:	e8 22 ff ff ff       	call   1b4 <stosb>
  return dst;
 292:	8b 45 08             	mov    0x8(%ebp),%eax
}
 295:	c9                   	leave  
 296:	c3                   	ret    

00000297 <strchr>:

char*
strchr(const char *s, char c)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 04             	sub    $0x4,%esp
 29d:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2a3:	eb 14                	jmp    2b9 <strchr+0x22>
    if(*s == c)
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	0f b6 00             	movzbl (%eax),%eax
 2ab:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2ae:	75 05                	jne    2b5 <strchr+0x1e>
      return (char*)s;
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
 2b3:	eb 13                	jmp    2c8 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	0f b6 00             	movzbl (%eax),%eax
 2bf:	84 c0                	test   %al,%al
 2c1:	75 e2                	jne    2a5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c8:	c9                   	leave  
 2c9:	c3                   	ret    

000002ca <gets>:

char*
gets(char *buf, int max)
{
 2ca:	55                   	push   %ebp
 2cb:	89 e5                	mov    %esp,%ebp
 2cd:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d7:	eb 44                	jmp    31d <gets+0x53>
    cc = read(0, &c, 1);
 2d9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2e0:	00 
 2e1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2ef:	e8 3c 01 00 00       	call   430 <read>
 2f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2fb:	7e 2d                	jle    32a <gets+0x60>
      break;
    buf[i++] = c;
 2fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 300:	03 45 08             	add    0x8(%ebp),%eax
 303:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 307:	88 10                	mov    %dl,(%eax)
 309:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 30d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 311:	3c 0a                	cmp    $0xa,%al
 313:	74 16                	je     32b <gets+0x61>
 315:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 319:	3c 0d                	cmp    $0xd,%al
 31b:	74 0e                	je     32b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 320:	83 c0 01             	add    $0x1,%eax
 323:	3b 45 0c             	cmp    0xc(%ebp),%eax
 326:	7c b1                	jl     2d9 <gets+0xf>
 328:	eb 01                	jmp    32b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 32a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 32b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 32e:	03 45 08             	add    0x8(%ebp),%eax
 331:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 334:	8b 45 08             	mov    0x8(%ebp),%eax
}
 337:	c9                   	leave  
 338:	c3                   	ret    

00000339 <stat>:

int
stat(char *n, struct stat *st)
{
 339:	55                   	push   %ebp
 33a:	89 e5                	mov    %esp,%ebp
 33c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 346:	00 
 347:	8b 45 08             	mov    0x8(%ebp),%eax
 34a:	89 04 24             	mov    %eax,(%esp)
 34d:	e8 06 01 00 00       	call   458 <open>
 352:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 355:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 359:	79 07                	jns    362 <stat+0x29>
    return -1;
 35b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 360:	eb 23                	jmp    385 <stat+0x4c>
  r = fstat(fd, st);
 362:	8b 45 0c             	mov    0xc(%ebp),%eax
 365:	89 44 24 04          	mov    %eax,0x4(%esp)
 369:	8b 45 f4             	mov    -0xc(%ebp),%eax
 36c:	89 04 24             	mov    %eax,(%esp)
 36f:	e8 fc 00 00 00       	call   470 <fstat>
 374:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 377:	8b 45 f4             	mov    -0xc(%ebp),%eax
 37a:	89 04 24             	mov    %eax,(%esp)
 37d:	e8 be 00 00 00       	call   440 <close>
  return r;
 382:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 385:	c9                   	leave  
 386:	c3                   	ret    

00000387 <atoi>:

int
atoi(const char *s)
{
 387:	55                   	push   %ebp
 388:	89 e5                	mov    %esp,%ebp
 38a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 38d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 394:	eb 23                	jmp    3b9 <atoi+0x32>
    n = n*10 + *s++ - '0';
 396:	8b 55 fc             	mov    -0x4(%ebp),%edx
 399:	89 d0                	mov    %edx,%eax
 39b:	c1 e0 02             	shl    $0x2,%eax
 39e:	01 d0                	add    %edx,%eax
 3a0:	01 c0                	add    %eax,%eax
 3a2:	89 c2                	mov    %eax,%edx
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	0f b6 00             	movzbl (%eax),%eax
 3aa:	0f be c0             	movsbl %al,%eax
 3ad:	01 d0                	add    %edx,%eax
 3af:	83 e8 30             	sub    $0x30,%eax
 3b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 3b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b9:	8b 45 08             	mov    0x8(%ebp),%eax
 3bc:	0f b6 00             	movzbl (%eax),%eax
 3bf:	3c 2f                	cmp    $0x2f,%al
 3c1:	7e 0a                	jle    3cd <atoi+0x46>
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	0f b6 00             	movzbl (%eax),%eax
 3c9:	3c 39                	cmp    $0x39,%al
 3cb:	7e c9                	jle    396 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3d0:	c9                   	leave  
 3d1:	c3                   	ret    

000003d2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3d2:	55                   	push   %ebp
 3d3:	89 e5                	mov    %esp,%ebp
 3d5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3d8:	8b 45 08             	mov    0x8(%ebp),%eax
 3db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3de:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3e4:	eb 13                	jmp    3f9 <memmove+0x27>
    *dst++ = *src++;
 3e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3e9:	0f b6 10             	movzbl (%eax),%edx
 3ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ef:	88 10                	mov    %dl,(%eax)
 3f1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3f5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 3fd:	0f 9f c0             	setg   %al
 400:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 404:	84 c0                	test   %al,%al
 406:	75 de                	jne    3e6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 408:	8b 45 08             	mov    0x8(%ebp),%eax
}
 40b:	c9                   	leave  
 40c:	c3                   	ret    
 40d:	90                   	nop
 40e:	90                   	nop
 40f:	90                   	nop

00000410 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 410:	b8 01 00 00 00       	mov    $0x1,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <exit>:
SYSCALL(exit)
 418:	b8 02 00 00 00       	mov    $0x2,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <wait>:
SYSCALL(wait)
 420:	b8 03 00 00 00       	mov    $0x3,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <pipe>:
SYSCALL(pipe)
 428:	b8 04 00 00 00       	mov    $0x4,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <read>:
SYSCALL(read)
 430:	b8 05 00 00 00       	mov    $0x5,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <write>:
SYSCALL(write)
 438:	b8 10 00 00 00       	mov    $0x10,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <close>:
SYSCALL(close)
 440:	b8 15 00 00 00       	mov    $0x15,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <kill>:
SYSCALL(kill)
 448:	b8 06 00 00 00       	mov    $0x6,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <exec>:
SYSCALL(exec)
 450:	b8 07 00 00 00       	mov    $0x7,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <open>:
SYSCALL(open)
 458:	b8 0f 00 00 00       	mov    $0xf,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <mknod>:
SYSCALL(mknod)
 460:	b8 11 00 00 00       	mov    $0x11,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <unlink>:
SYSCALL(unlink)
 468:	b8 12 00 00 00       	mov    $0x12,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <fstat>:
SYSCALL(fstat)
 470:	b8 08 00 00 00       	mov    $0x8,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <link>:
SYSCALL(link)
 478:	b8 13 00 00 00       	mov    $0x13,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <mkdir>:
SYSCALL(mkdir)
 480:	b8 14 00 00 00       	mov    $0x14,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <chdir>:
SYSCALL(chdir)
 488:	b8 09 00 00 00       	mov    $0x9,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <dup>:
SYSCALL(dup)
 490:	b8 0a 00 00 00       	mov    $0xa,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <getpid>:
SYSCALL(getpid)
 498:	b8 0b 00 00 00       	mov    $0xb,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <sbrk>:
SYSCALL(sbrk)
 4a0:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <sleep>:
SYSCALL(sleep)
 4a8:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <uptime>:
SYSCALL(uptime)
 4b0:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4b8:	55                   	push   %ebp
 4b9:	89 e5                	mov    %esp,%ebp
 4bb:	83 ec 28             	sub    $0x28,%esp
 4be:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4cb:	00 
 4cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d3:	8b 45 08             	mov    0x8(%ebp),%eax
 4d6:	89 04 24             	mov    %eax,(%esp)
 4d9:	e8 5a ff ff ff       	call   438 <write>
}
 4de:	c9                   	leave  
 4df:	c3                   	ret    

000004e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4ed:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4f1:	74 17                	je     50a <printint+0x2a>
 4f3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4f7:	79 11                	jns    50a <printint+0x2a>
    neg = 1;
 4f9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 500:	8b 45 0c             	mov    0xc(%ebp),%eax
 503:	f7 d8                	neg    %eax
 505:	89 45 ec             	mov    %eax,-0x14(%ebp)
 508:	eb 06                	jmp    510 <printint+0x30>
  } else {
    x = xx;
 50a:	8b 45 0c             	mov    0xc(%ebp),%eax
 50d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 510:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 517:	8b 4d 10             	mov    0x10(%ebp),%ecx
 51a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 51d:	ba 00 00 00 00       	mov    $0x0,%edx
 522:	f7 f1                	div    %ecx
 524:	89 d0                	mov    %edx,%eax
 526:	0f b6 90 bc 0b 00 00 	movzbl 0xbbc(%eax),%edx
 52d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 530:	03 45 f4             	add    -0xc(%ebp),%eax
 533:	88 10                	mov    %dl,(%eax)
 535:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 539:	8b 55 10             	mov    0x10(%ebp),%edx
 53c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 53f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 542:	ba 00 00 00 00       	mov    $0x0,%edx
 547:	f7 75 d4             	divl   -0x2c(%ebp)
 54a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 54d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 551:	75 c4                	jne    517 <printint+0x37>
  if(neg)
 553:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 557:	74 2a                	je     583 <printint+0xa3>
    buf[i++] = '-';
 559:	8d 45 dc             	lea    -0x24(%ebp),%eax
 55c:	03 45 f4             	add    -0xc(%ebp),%eax
 55f:	c6 00 2d             	movb   $0x2d,(%eax)
 562:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 566:	eb 1b                	jmp    583 <printint+0xa3>
    putc(fd, buf[i]);
 568:	8d 45 dc             	lea    -0x24(%ebp),%eax
 56b:	03 45 f4             	add    -0xc(%ebp),%eax
 56e:	0f b6 00             	movzbl (%eax),%eax
 571:	0f be c0             	movsbl %al,%eax
 574:	89 44 24 04          	mov    %eax,0x4(%esp)
 578:	8b 45 08             	mov    0x8(%ebp),%eax
 57b:	89 04 24             	mov    %eax,(%esp)
 57e:	e8 35 ff ff ff       	call   4b8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 583:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 587:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 58b:	79 db                	jns    568 <printint+0x88>
    putc(fd, buf[i]);
}
 58d:	c9                   	leave  
 58e:	c3                   	ret    

0000058f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 58f:	55                   	push   %ebp
 590:	89 e5                	mov    %esp,%ebp
 592:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 595:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 59c:	8d 45 0c             	lea    0xc(%ebp),%eax
 59f:	83 c0 04             	add    $0x4,%eax
 5a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5a5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5ac:	e9 7d 01 00 00       	jmp    72e <printf+0x19f>
    c = fmt[i] & 0xff;
 5b1:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b7:	01 d0                	add    %edx,%eax
 5b9:	0f b6 00             	movzbl (%eax),%eax
 5bc:	0f be c0             	movsbl %al,%eax
 5bf:	25 ff 00 00 00       	and    $0xff,%eax
 5c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5cb:	75 2c                	jne    5f9 <printf+0x6a>
      if(c == '%'){
 5cd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d1:	75 0c                	jne    5df <printf+0x50>
        state = '%';
 5d3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5da:	e9 4b 01 00 00       	jmp    72a <printf+0x19b>
      } else {
        putc(fd, c);
 5df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e2:	0f be c0             	movsbl %al,%eax
 5e5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e9:	8b 45 08             	mov    0x8(%ebp),%eax
 5ec:	89 04 24             	mov    %eax,(%esp)
 5ef:	e8 c4 fe ff ff       	call   4b8 <putc>
 5f4:	e9 31 01 00 00       	jmp    72a <printf+0x19b>
      }
    } else if(state == '%'){
 5f9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5fd:	0f 85 27 01 00 00    	jne    72a <printf+0x19b>
      if(c == 'd'){
 603:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 607:	75 2d                	jne    636 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 609:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60c:	8b 00                	mov    (%eax),%eax
 60e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 615:	00 
 616:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 61d:	00 
 61e:	89 44 24 04          	mov    %eax,0x4(%esp)
 622:	8b 45 08             	mov    0x8(%ebp),%eax
 625:	89 04 24             	mov    %eax,(%esp)
 628:	e8 b3 fe ff ff       	call   4e0 <printint>
        ap++;
 62d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 631:	e9 ed 00 00 00       	jmp    723 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 636:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 63a:	74 06                	je     642 <printf+0xb3>
 63c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 640:	75 2d                	jne    66f <printf+0xe0>
        printint(fd, *ap, 16, 0);
 642:	8b 45 e8             	mov    -0x18(%ebp),%eax
 645:	8b 00                	mov    (%eax),%eax
 647:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 64e:	00 
 64f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 656:	00 
 657:	89 44 24 04          	mov    %eax,0x4(%esp)
 65b:	8b 45 08             	mov    0x8(%ebp),%eax
 65e:	89 04 24             	mov    %eax,(%esp)
 661:	e8 7a fe ff ff       	call   4e0 <printint>
        ap++;
 666:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 66a:	e9 b4 00 00 00       	jmp    723 <printf+0x194>
      } else if(c == 's'){
 66f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 673:	75 46                	jne    6bb <printf+0x12c>
        s = (char*)*ap;
 675:	8b 45 e8             	mov    -0x18(%ebp),%eax
 678:	8b 00                	mov    (%eax),%eax
 67a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 67d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 681:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 685:	75 27                	jne    6ae <printf+0x11f>
          s = "(null)";
 687:	c7 45 f4 76 09 00 00 	movl   $0x976,-0xc(%ebp)
        while(*s != 0){
 68e:	eb 1e                	jmp    6ae <printf+0x11f>
          putc(fd, *s);
 690:	8b 45 f4             	mov    -0xc(%ebp),%eax
 693:	0f b6 00             	movzbl (%eax),%eax
 696:	0f be c0             	movsbl %al,%eax
 699:	89 44 24 04          	mov    %eax,0x4(%esp)
 69d:	8b 45 08             	mov    0x8(%ebp),%eax
 6a0:	89 04 24             	mov    %eax,(%esp)
 6a3:	e8 10 fe ff ff       	call   4b8 <putc>
          s++;
 6a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 6ac:	eb 01                	jmp    6af <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6ae:	90                   	nop
 6af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b2:	0f b6 00             	movzbl (%eax),%eax
 6b5:	84 c0                	test   %al,%al
 6b7:	75 d7                	jne    690 <printf+0x101>
 6b9:	eb 68                	jmp    723 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6bb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6bf:	75 1d                	jne    6de <printf+0x14f>
        putc(fd, *ap);
 6c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c4:	8b 00                	mov    (%eax),%eax
 6c6:	0f be c0             	movsbl %al,%eax
 6c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6cd:	8b 45 08             	mov    0x8(%ebp),%eax
 6d0:	89 04 24             	mov    %eax,(%esp)
 6d3:	e8 e0 fd ff ff       	call   4b8 <putc>
        ap++;
 6d8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6dc:	eb 45                	jmp    723 <printf+0x194>
      } else if(c == '%'){
 6de:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6e2:	75 17                	jne    6fb <printf+0x16c>
        putc(fd, c);
 6e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e7:	0f be c0             	movsbl %al,%eax
 6ea:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ee:	8b 45 08             	mov    0x8(%ebp),%eax
 6f1:	89 04 24             	mov    %eax,(%esp)
 6f4:	e8 bf fd ff ff       	call   4b8 <putc>
 6f9:	eb 28                	jmp    723 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6fb:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 702:	00 
 703:	8b 45 08             	mov    0x8(%ebp),%eax
 706:	89 04 24             	mov    %eax,(%esp)
 709:	e8 aa fd ff ff       	call   4b8 <putc>
        putc(fd, c);
 70e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 711:	0f be c0             	movsbl %al,%eax
 714:	89 44 24 04          	mov    %eax,0x4(%esp)
 718:	8b 45 08             	mov    0x8(%ebp),%eax
 71b:	89 04 24             	mov    %eax,(%esp)
 71e:	e8 95 fd ff ff       	call   4b8 <putc>
      }
      state = 0;
 723:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 72a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 72e:	8b 55 0c             	mov    0xc(%ebp),%edx
 731:	8b 45 f0             	mov    -0x10(%ebp),%eax
 734:	01 d0                	add    %edx,%eax
 736:	0f b6 00             	movzbl (%eax),%eax
 739:	84 c0                	test   %al,%al
 73b:	0f 85 70 fe ff ff    	jne    5b1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 741:	c9                   	leave  
 742:	c3                   	ret    
 743:	90                   	nop

00000744 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 744:	55                   	push   %ebp
 745:	89 e5                	mov    %esp,%ebp
 747:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 74a:	8b 45 08             	mov    0x8(%ebp),%eax
 74d:	83 e8 08             	sub    $0x8,%eax
 750:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 753:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 758:	89 45 fc             	mov    %eax,-0x4(%ebp)
 75b:	eb 24                	jmp    781 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 760:	8b 00                	mov    (%eax),%eax
 762:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 765:	77 12                	ja     779 <free+0x35>
 767:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 76d:	77 24                	ja     793 <free+0x4f>
 76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 772:	8b 00                	mov    (%eax),%eax
 774:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 777:	77 1a                	ja     793 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 779:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77c:	8b 00                	mov    (%eax),%eax
 77e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 781:	8b 45 f8             	mov    -0x8(%ebp),%eax
 784:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 787:	76 d4                	jbe    75d <free+0x19>
 789:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78c:	8b 00                	mov    (%eax),%eax
 78e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 791:	76 ca                	jbe    75d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 793:	8b 45 f8             	mov    -0x8(%ebp),%eax
 796:	8b 40 04             	mov    0x4(%eax),%eax
 799:	c1 e0 03             	shl    $0x3,%eax
 79c:	89 c2                	mov    %eax,%edx
 79e:	03 55 f8             	add    -0x8(%ebp),%edx
 7a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a4:	8b 00                	mov    (%eax),%eax
 7a6:	39 c2                	cmp    %eax,%edx
 7a8:	75 24                	jne    7ce <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 7aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ad:	8b 50 04             	mov    0x4(%eax),%edx
 7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b3:	8b 00                	mov    (%eax),%eax
 7b5:	8b 40 04             	mov    0x4(%eax),%eax
 7b8:	01 c2                	add    %eax,%edx
 7ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	8b 00                	mov    (%eax),%eax
 7c5:	8b 10                	mov    (%eax),%edx
 7c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ca:	89 10                	mov    %edx,(%eax)
 7cc:	eb 0a                	jmp    7d8 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 7ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d1:	8b 10                	mov    (%eax),%edx
 7d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7db:	8b 40 04             	mov    0x4(%eax),%eax
 7de:	c1 e0 03             	shl    $0x3,%eax
 7e1:	03 45 fc             	add    -0x4(%ebp),%eax
 7e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7e7:	75 20                	jne    809 <free+0xc5>
    p->s.size += bp->s.size;
 7e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ec:	8b 50 04             	mov    0x4(%eax),%edx
 7ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f2:	8b 40 04             	mov    0x4(%eax),%eax
 7f5:	01 c2                	add    %eax,%edx
 7f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 800:	8b 10                	mov    (%eax),%edx
 802:	8b 45 fc             	mov    -0x4(%ebp),%eax
 805:	89 10                	mov    %edx,(%eax)
 807:	eb 08                	jmp    811 <free+0xcd>
  } else
    p->s.ptr = bp;
 809:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 80f:	89 10                	mov    %edx,(%eax)
  freep = p;
 811:	8b 45 fc             	mov    -0x4(%ebp),%eax
 814:	a3 d8 0b 00 00       	mov    %eax,0xbd8
}
 819:	c9                   	leave  
 81a:	c3                   	ret    

0000081b <morecore>:

static Header*
morecore(uint nu)
{
 81b:	55                   	push   %ebp
 81c:	89 e5                	mov    %esp,%ebp
 81e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 821:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 828:	77 07                	ja     831 <morecore+0x16>
    nu = 4096;
 82a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 831:	8b 45 08             	mov    0x8(%ebp),%eax
 834:	c1 e0 03             	shl    $0x3,%eax
 837:	89 04 24             	mov    %eax,(%esp)
 83a:	e8 61 fc ff ff       	call   4a0 <sbrk>
 83f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 842:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 846:	75 07                	jne    84f <morecore+0x34>
    return 0;
 848:	b8 00 00 00 00       	mov    $0x0,%eax
 84d:	eb 22                	jmp    871 <morecore+0x56>
  hp = (Header*)p;
 84f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 852:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 855:	8b 45 f0             	mov    -0x10(%ebp),%eax
 858:	8b 55 08             	mov    0x8(%ebp),%edx
 85b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 85e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 861:	83 c0 08             	add    $0x8,%eax
 864:	89 04 24             	mov    %eax,(%esp)
 867:	e8 d8 fe ff ff       	call   744 <free>
  return freep;
 86c:	a1 d8 0b 00 00       	mov    0xbd8,%eax
}
 871:	c9                   	leave  
 872:	c3                   	ret    

00000873 <malloc>:

void*
malloc(uint nbytes)
{
 873:	55                   	push   %ebp
 874:	89 e5                	mov    %esp,%ebp
 876:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 879:	8b 45 08             	mov    0x8(%ebp),%eax
 87c:	83 c0 07             	add    $0x7,%eax
 87f:	c1 e8 03             	shr    $0x3,%eax
 882:	83 c0 01             	add    $0x1,%eax
 885:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 888:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 88d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 890:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 894:	75 23                	jne    8b9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 896:	c7 45 f0 d0 0b 00 00 	movl   $0xbd0,-0x10(%ebp)
 89d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a0:	a3 d8 0b 00 00       	mov    %eax,0xbd8
 8a5:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 8aa:	a3 d0 0b 00 00       	mov    %eax,0xbd0
    base.s.size = 0;
 8af:	c7 05 d4 0b 00 00 00 	movl   $0x0,0xbd4
 8b6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bc:	8b 00                	mov    (%eax),%eax
 8be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c4:	8b 40 04             	mov    0x4(%eax),%eax
 8c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8ca:	72 4d                	jb     919 <malloc+0xa6>
      if(p->s.size == nunits)
 8cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cf:	8b 40 04             	mov    0x4(%eax),%eax
 8d2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8d5:	75 0c                	jne    8e3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8da:	8b 10                	mov    (%eax),%edx
 8dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8df:	89 10                	mov    %edx,(%eax)
 8e1:	eb 26                	jmp    909 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e6:	8b 40 04             	mov    0x4(%eax),%eax
 8e9:	89 c2                	mov    %eax,%edx
 8eb:	2b 55 ec             	sub    -0x14(%ebp),%edx
 8ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f7:	8b 40 04             	mov    0x4(%eax),%eax
 8fa:	c1 e0 03             	shl    $0x3,%eax
 8fd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 900:	8b 45 f4             	mov    -0xc(%ebp),%eax
 903:	8b 55 ec             	mov    -0x14(%ebp),%edx
 906:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 909:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90c:	a3 d8 0b 00 00       	mov    %eax,0xbd8
      return (void*)(p + 1);
 911:	8b 45 f4             	mov    -0xc(%ebp),%eax
 914:	83 c0 08             	add    $0x8,%eax
 917:	eb 38                	jmp    951 <malloc+0xde>
    }
    if(p == freep)
 919:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 91e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 921:	75 1b                	jne    93e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 923:	8b 45 ec             	mov    -0x14(%ebp),%eax
 926:	89 04 24             	mov    %eax,(%esp)
 929:	e8 ed fe ff ff       	call   81b <morecore>
 92e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 931:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 935:	75 07                	jne    93e <malloc+0xcb>
        return 0;
 937:	b8 00 00 00 00       	mov    $0x0,%eax
 93c:	eb 13                	jmp    951 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 941:	89 45 f0             	mov    %eax,-0x10(%ebp)
 944:	8b 45 f4             	mov    -0xc(%ebp),%eax
 947:	8b 00                	mov    (%eax),%eax
 949:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 94c:	e9 70 ff ff ff       	jmp    8c1 <malloc+0x4e>
}
 951:	c9                   	leave  
 952:	c3                   	ret    
