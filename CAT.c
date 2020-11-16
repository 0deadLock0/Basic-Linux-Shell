#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void read_from_stdin(int* count,int flagLineNumber,int flagMarkEnd)
{
	char buf[1000];
	while(1)
	{
		if(fgets(buf,sizeof(buf),stdin)==NULL)
		{
			printf("Error Occured");
			return;
		}
		++(*count);
		if(flagLineNumber==1)
			printf("%5d ",*count);
		int i=0;
		while(buf[i]!='\n')
		{
			printf("%c",buf[i]);
			++i;
		}
		if(flagMarkEnd==1)
			printf("$");
		printf("\n");
	}
}

void read_from_file(FILE* file,int* count,int flagLineNumber,int flagMarkEnd)
{
	char line[1000];
	while(fgets(line,sizeof(line),file))
	{
		++(*count);
		if(flagLineNumber==1)
			printf("%5d ",*count);
		int i=0;
		while(line[i]!='\n')
		{
			printf("%c",line[i]);
			++i;
		}
		if(flagMarkEnd==1)
			printf("$");
		printf("\n");
	}
}

void print_file(char stream[1000],int* count,int flagLineNumber,int flagMarkEnd)
{
	if(strcmp(stream,"-")==0)
		read_from_stdin(count,flagLineNumber,flagMarkEnd);
	else
	{
		FILE *file=fopen(stream,"r");
		if(file==NULL)
			printf("cat: '%s': No such file or directory\n",
stream);
		else
		{
			read_from_file(file,count,flagLineNumber,flagMarkEnd);
			fclose(file);
		}
	}
}

int main(int argc,char *argv[])
{
	int count=0;
	int flagLineNumber=0;
	int flagMarkEnd=0;
	if(argc==1)
		read_from_stdin(&count,flagLineNumber,flagMarkEnd);
	int i=1;
	if(strcmp(argv[1],"-n")==0)
	{
		flagLineNumber=1;
		++i;
	}
	else if(strcmp(argv[1],"-E")==0)
	{	
		flagMarkEnd=1;
		++i;
	}
	for(;i<argc;++i)
		print_file(argv[i],&count,flagLineNumber,flagMarkEnd);

	return 0;
}
