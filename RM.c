#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

int isFolder(char name[])
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

int main(int argc,char *argv[])
{
	if(argc==1)
		printf("Insufficient arguments recieved");
	else
	{
		int i=1;
		int flagPrompt=0;
		int flagExplain=0;
		if(strcmp(argv[1],"-i")==0)
		{
			flagPrompt=1;
			++i;
		}
		else if(strcmp(argv[1],"-v")==0)
		{
			flagExplain=1;
			++i;
		}
		if((flagPrompt==1 || flagExplain==1) && argc==2)
			printf("Insufficient arguments recieved");
		else
		{
			char c='Y';
			for(;i<argc;++i)
			{
				if(isFolder(argv[i]))
					printf("%s is a directory, can't delete\n",argv[i]);
				else
				{
					if(flagPrompt==1)
					{
						printf("Do you want to remove %s[Y/N]\n",argv[i]);
						scanf(" %c",&c);
						if(c=='N')
							continue;
					}
					int r=remove(argv[i]);
					if(r==-1)
						printf("%s could not be removed\n",argv[i]);
					if(flagExplain==1)
						printf("%s is removed\n",argv[i]);
				}
			}
		}
	}

	return 0;
}
