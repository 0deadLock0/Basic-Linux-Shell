#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>

int isPresent(char name[])
{
	struct dirent **files;
	int n=scandir(".",&files,NULL,alphasort);
	int flag=0;
	for(int i=0;i<n;++i)
	{
		if(strcmp(name,files[i]->d_name)==0)
			if(files[i]->d_type==DT_DIR)
				flag=1;
		free(files[i]);
	}
	free(files);
	return flag;
}

void print_help()
{
	printf("                          Functions Manual\n");
        printf("\n");                  
printf("NAME\n");
       printf("	mkdir\n");
printf("\n");
printf("SYNOPSIS\n");
       printf("	mkdir [OPTION] fileName\n");

	printf("DESCRIPTION\n");
       printf("	makes a directory.\n");
	printf("\n");
	printf("OPTION\n");
	printf("	mkdir fileName\n");
	printf("		makes a directory with name fileName\n");
	printf("	mkdir -v fileName\n");
	printf("		makes a directory and tell the status after creation\n");
	printf("	mkdir --help\n");
	printf("		display this help\n");
	

}

int main(int argc,char *argv[])
{
	if(argc==1)
		printf("Insufficient arguments recieved");
	else if(argc==2 && strcmp(argv[1],"--help")==0)
		print_help();
	else
	{
		int i=1;
		int flagExplain=0;
		if(strcmp(argv[1],"-v")==0)
		{
			flagExplain=1;
			++i;
		}
		if(flagExplain==1 && argc==2)
			printf("Insufficient arguments recieved");
		else
		{
			for(;i<argc;++i)
			{
				if(isPresent(argv[i]))
					printf("%s is a already present, can't create another\n",argv[i]);
				else
				{
					
					int m=mkdir(argv[i],077);
					if(!m)
					{}
					else
						printf("%s could not be created\n",argv[i]);
					if(flagExplain==1)
						printf("%s is created\n",argv[i]);
				}
			}
		}
	}


	return 0;
}
