
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <errno.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MaxSize 1000

void read_command(char[]);
int parse_command(char[],char[][MaxSize]);
void execute_command(char[][MaxSize],int);

void trim_ends(char[]);
void show_terminal();
int not_a_command(char[],char[][10],int);
void add_to_file(FILE*,char[]);

void print_string(char*);
void print_strings(char*[MaxSize],int);
void print_String(char[]);
void print_Strings(char[][MaxSize],int);

void run_cd(char[][MaxSize],int);
void run_echo(char[][MaxSize],int);
void run_history(char[][MaxSize],int);
void run_pwd(char[][MaxSize],int);
void run_exit(char[][MaxSize],int);
void run_ls(char[][MaxSize],int);
void run_cat(char[][MaxSize],int);
void run_date(char[][MaxSize],int);
void run_rm(char[][MaxSize],int);
void run_mkdir(char[][MaxSize],int);

void (*run_command[])(char[][MaxSize],int) =
{
	run_cd,
	run_echo,
	run_history,
	run_pwd,
	run_exit,
	run_ls,
	run_cat,
	run_date,
	run_rm,
	run_mkdir
};

FILE *historyFile;
char fileName[MaxSize];

char AbsolutePath[MaxSize]= "/home/deadlocks/Codes/assignment1/1.2";

int main()
{
	if(getcwd(AbsolutePath,sizeof(AbsolutePath))==NULL)
	{
		printf("Serious breakdown, terminating program");
		return 0;
	}	
	strcat(AbsolutePath,"/");
	strcpy(fileName,AbsolutePath);
	strcat(fileName,"history.txt");
	historyFile=fopen(fileName,"a+");
	if(historyFile==NULL)
	{
		printf("Unable to open file");
		return -1;
	}
	fseek(historyFile,SEEK_END,0);
	while(1)
	{
		char command[MaxSize];
		char tokens[MaxSize][MaxSize];
		int size;
		
		show_terminal();
		read_command(command);
		size=parse_command(command,tokens);
		add_to_file(historyFile,command);
		execute_command(tokens,size);
	}
	fclose(historyFile);
	return 0;
}

void print_string(char* string)
{
	printf("String- |%s|\n",string);
}
void print_strings(char* strings[MaxSize],int size)
{
	printf("Strings-\n");
	for(int i=0;i<size;++i)
		printf("%d -> |%s|\n",i,strings[i]);
}
void print_String(char string[])
{
	printf("String- |%s|\n",string);
}
void print_Strings(char strings[][MaxSize],int size)
{
	printf("Strings-\n");
	for(int i=0;i<size;++i)
		printf("%d -> |%s|\n",i,strings[i]);
}

void add_to_file(FILE* file,char line[])
{
	fputs(line,file);
	fputs("\n",file);
}
void trim_ends(char line[])
{
	char* temp=line;
	while(*temp!='\0')
		++temp;
	--temp;
	while(isspace(*temp))
	{
		*temp='\0';
		--temp;
	}
	
	temp=line;
	while(isspace(*temp))
		++temp;
	if(temp!=line)
	{
		while(*temp!='\0')
		{
			*line=*temp;
			++line;
			++temp;
		}
		*line='\0';
	}
}
int not_a_command(char command[],char commands[][10],int size)
{
	for(int i=0;i<size;++i)
	{
		if(strcmp(command,commands[i])==0)
			return 0;
	}
	
	return 1;
}
void show_terminal()
{
	char *user;
	user=getlogin();
	if(user==NULL)
		printf("User couldn't be extracted\n");
	else
	{
		char path[MaxSize];
		if(getcwd(path,MaxSize)==NULL)
			printf("Error occured while accessing current working directory\n");
		else
		{
			printf("%s:",user);
			printf("%s$ ",path);
		}
	}
}

void read_command(char command[])
{
	if(fgets(command,MaxSize,stdin)==NULL)
		printf("Error occured while reading input\n");
	else
	{
		int i=0;
		for(;command[i]!='\n';++i);
			command[i]='\0';
	}
}
int parse_command(char command[],char tokens[][MaxSize])
{
	trim_ends(command);
	int quotesFlag=0;
	int i=0,j=0;
	char* tempCommand=command;
	while(*tempCommand!='\0')
	{
		if(isspace(*tempCommand))
		{
			if(quotesFlag)
			{
				tokens[i][j]=' ';
				++j;
			}
			else if(j!=0)
			{
				tokens[i][j]='\0';
				++i;
				j=0;
			}
		}
		else if(*tempCommand=='\"')
		{	
			if(j!=0)
			{
				tokens[i][j]='\0';
				++i;
				j=0;
			}
			if(quotesFlag)
				quotesFlag=0;
			else
				quotesFlag=1;
		}
		else
		{
			tokens[i][j]=*tempCommand;
			++j;
		}
		++tempCommand;
	}
	if(j!=0)
	{
		tokens[i][j]='\0';
		++i;
		j=0;
	}
	
	return i;
}
void execute_command(char tokens[][MaxSize],int size)
{
	char commands[][10]={"cd","echo","history","pwd","exit","ls","cat","date","rm","mkdir"};
	int commandsSize=10;
	if(size==0)
		return;
	if(not_a_command(tokens[0],commands,commandsSize))
		printf("Error not a valid command\n");
	for(int i=0;i<commandsSize;++i)
	{
		if(strcmp(tokens[0],commands[i])==0)
		{
			(*run_command[i])(tokens,size);
			break;
		}
	}	
}

void run_cd(char tokens[][MaxSize],int size)
{
	if(size>2)
		printf("Excess of arguments\n");
	else if(size==1 || (size==2 && strcmp(tokens[1],"~")==0))
	{
		if(chdir("/")==-1)
			printf("Unable to open path\n");
		if(chdir("home")==-1)
			printf("Unable to open path\n");
		char *user="deadlocks";
		user=getlogin();
		if(user==NULL)
			printf("Unable to open path\n");
		if(chdir(user)==-1)
			printf("Unable to open path\n");
	}
	else if(size==2 && strcmp(tokens[1],"--help")==0)
	{
		strcpy(tokens[0],"cat");
		strcpy(tokens[1],AbsolutePath);
		strcat(tokens[1],"CD/help_cd.txt");
		run_cat(tokens,size);
	}
	else if(chdir(tokens[1])==-1)
		printf("Invalid Path\n");
}
void run_echo(char tokens[][MaxSize],int size)
{
	if(size==1)
		printf("\n");
	else if(strcmp(tokens[1],"-n")==0)
	{
		for(int i=2;i<size;++i)
			printf("%s ",tokens[i]);
	}
	else if(strcmp(tokens[1],"-E")==0)
	{
		for(int i=2;i<size;++i)
			printf("%s ",tokens[i]);
		printf("\n");
	}
	else if(strcmp(tokens[1],"-e")!=0)
	{
		for(int i=1;i<size;++i)
			printf("%s ",tokens[i]);
		printf("\n");
	}
	else
		printf("Unrecognised flag");
}
void run_history(char tokens[][MaxSize],int size)
{
	if(size==1)
	{
		fseek(historyFile,SEEK_SET,0);
		char line[MaxSize];
		int count=0;
		while(fgets(line,sizeof(line),historyFile)!=NULL)
		{	
			++count;
			printf("%5d %s",count,line);
		}
		fseek(historyFile,SEEK_END,0);
	}
	else if(size>2)
		printf("Excess of arguments");
	else if(strcmp(tokens[1],"--help")==0)
	{
		strcpy(tokens[0],"cat");
		strcpy(tokens[1],AbsolutePath);
		strcat(tokens[1],"HISTORY/help_history.txt");
		run_cat(tokens,size);
	}
	else if(strcmp(tokens[1],"-c")==0)
	{
		fclose(historyFile);
		historyFile=fopen(fileName,"w");
		fclose(historyFile);
		historyFile=fopen(fileName,"a+");
		fseek(historyFile,SEEK_END,0);
	}
	else
	{
		int i=0;
		int flag=1;
		while(tokens[1][i]!='\0')
		{
			if(!isdigit(tokens[1][i]))
			{
				flag=0;
				break;
			}
			++i;
		}
		if(flag==0)
			printf("Invalid argument\n");		
		else
		{
			int num=atoi(tokens[1]);
			if(num==0 || num<0)
				printf("Invalid argument\n");
			else
			{
				char lines[MaxSize][MaxSize];
				
				fseek(historyFile,SEEK_SET,0);
				char line[MaxSize];
				int count=0;
				while(fgets(line,sizeof(line),historyFile)!=NULL)
				{
					strcpy(lines[count],line);	
					++count;
				}
				fseek(historyFile,SEEK_END,0);
				int min=(num<count)?num:count;
				for(int i=count-min;i<count;++i)
					printf("%5d %s",i+1,lines[i]);
			}
		}
	}
}
void run_pwd(char tokens[][MaxSize],int size)
{
	if(size>2)
		printf("Excess of arguments\n");
	else if(size==1 || (size==2 && strcmp(tokens[1],"-P")==0))
	{
		char path[MaxSize];
		if(getcwd(path,MaxSize)==NULL)
			printf("Error occured while accessing current working directory\n");
		
		else
			printf("%s\n",path);
	}
	else if(size==2 && strcmp(tokens[1],"--help")==0)
	{
		strcpy(tokens[0],"cat");
		strcpy(tokens[1],AbsolutePath);
		strcat(tokens[1],"PWD/help_pwd.txt");
		run_cat(tokens,size);
	}
	else
		printf("Unrecognised flag\n");
		
}
void run_exit(char tokens[][MaxSize],int size)
{
	if(size==2 && strcmp(tokens[1],"--help")==0)
	{
		strcpy(tokens[0],"cat");
		strcpy(tokens[1],AbsolutePath);
		strcat(tokens[1],"EXIT/help_exit.txt");
		run_cat(tokens,size);
	}
	else if(size<=2)
	{
		fclose(historyFile);
		exit(0);
	}
	else
		printf("Excess arguments\n");
}
void run_ls(char tokens[][MaxSize],int size)
{
	char** modifiedTokens=(char**)calloc(size+1,MaxSize);
	char absolutePath[MaxSize];
	strcpy(absolutePath,AbsolutePath);
	strcat(absolutePath,"LS/LS");
	modifiedTokens[0]=absolutePath;
	for(int i=1;i<size;++i)
		modifiedTokens[i]=tokens[i];
	modifiedTokens[size]=(char*)NULL;
	++size;
	pid_t pid=fork();
	if(pid<0)
		printf("Failed to create process\n");
	else if(pid==0)
	{
		if(execv(modifiedTokens[0],modifiedTokens)==-1)
			exit(-1);
		else
			exit(0);
	}
	else
	{
		if(waitpid(pid,NULL,0)==-1)
			printf("Process didn't worked\n");
	}
}
void run_cat(char tokens[][MaxSize],int size)
{
	char** modifiedTokens=(char**)calloc(size+1,MaxSize);
	char absolutePath[MaxSize];
	strcpy(absolutePath,AbsolutePath);
	strcat(absolutePath,"CAT/CAT");
	modifiedTokens[0]=absolutePath;
	for(int i=1;i<size;++i)
		modifiedTokens[i]=tokens[i];
	modifiedTokens[size]=(char*)NULL;
	++size;
	pid_t pid=fork();
	if(pid<0)
		printf("Failed to create process\n");
	else if(pid==0)
	{
		if(execv(modifiedTokens[0],modifiedTokens)==-1)
			exit(-1);
		else
			exit(0);
	}
	else
	{
		if(waitpid(pid,NULL,0)==-1)
			printf("Process didn't worked\n");
	}
}
void run_date(char tokens[][MaxSize],int size)
{
	char** modifiedTokens=(char**)calloc(size+1,MaxSize);
	char absolutePath[MaxSize];
	strcpy(absolutePath,AbsolutePath);
	strcat(absolutePath,"DATE/DATE");
	modifiedTokens[0]=absolutePath;
	for(int i=1;i<size;++i)
		modifiedTokens[i]=tokens[i];
	modifiedTokens[size]=(char*)NULL;
	++size;
	pid_t pid=fork();
	if(pid<0)
		printf("Failed to create process\n");
	else if(pid==0)
	{
		if(execv(modifiedTokens[0],modifiedTokens)==-1)
			exit(-1);
		else
			exit(0);
	}
	else
	{
		if(waitpid(pid,NULL,0)==-1)
			printf("Process didn't worked\n");
	}
}
void run_rm(char tokens[][MaxSize],int size)
{
	char** modifiedTokens=(char**)calloc(size+1,MaxSize);
	char absolutePath[MaxSize];
	strcpy(absolutePath,AbsolutePath);
	strcat(absolutePath,"RM/RM");
	modifiedTokens[0]=absolutePath;
	for(int i=1;i<size;++i)
		modifiedTokens[i]=tokens[i];
	modifiedTokens[size]=(char*)NULL;
	++size;
	pid_t pid=fork();
	if(pid<0)
		printf("Failed to create process\n");
	else if(pid==0)
	{
		if(execv(modifiedTokens[0],modifiedTokens)==-1)
			exit(-1);
		else
			exit(0);
	}
	else
	{
		if(waitpid(pid,NULL,0)==-1)
			printf("Process didn't worked\n");
	}
}
void run_mkdir(char tokens[][MaxSize],int size)
{
	char** modifiedTokens=(char**)calloc(size+1,MaxSize);
	char absolutePath[MaxSize];
	strcpy(absolutePath,AbsolutePath);
	strcat(absolutePath,"MKDIR/MKDIR");
	modifiedTokens[0]=absolutePath;
	for(int i=1;i<size;++i)
		modifiedTokens[i]=tokens[i];
	modifiedTokens[size]=(char*)NULL;
	++size;
	pid_t pid=fork();
	if(pid<0)
		printf("Failed to create process\n");
	else if(pid==0)
	{
		if(execv(modifiedTokens[0],modifiedTokens)==-1)
			exit(-1);
		else
			exit(0);
	}
	else
	{
		if(waitpid(pid,NULL,0)==-1)
			printf("Process didn't worked\n");
	}
}
