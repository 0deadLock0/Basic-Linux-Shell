#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(int argc,char *argv[])
{
	time_t t=time(NULL);
	struct tm *timeInfo;
	char printableTime[100];

	if(argc==1)
	{
		timeInfo=localtime(&t);
		strftime(printableTime,sizeof(printableTime),"%A %d %B %Y %l:%M:%S %p %Z",timeInfo);
		printf("%s\n",printableTime);
	}
	else if(argc>2)
		printf("Excess arguments recived\n");
	else if(strcmp(argv[1],"-u")==0)
	{
		timeInfo=gmtime(&t);
		strftime(printableTime,sizeof(printableTime),"%A %d %B %Y %l:%M:%S %p %Z",timeInfo);
		printf("%s\n",printableTime);
	}
	else if(strcmp(argv[1],"-R")==0)
	{
		timeInfo=localtime(&t);
		strftime(printableTime,sizeof(printableTime),"%a, %d %b %Y %H:%M:%S %z",timeInfo);
		printf("%s\n",printableTime);
	}
	else
		printf("Invalid argument recieved\n");

	return 0;
}
