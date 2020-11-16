#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

void print_sorted_directory()
{
	struct dirent **files;
	int n=scandir(".",&files,NULL,alphasort);
	for(int i=0;i<n;++i)
	{
		if(strcmp(files[i]->d_name,".")!=0 && strcmp(files[i]->d_name,"..")!=0)
			printf("%s \n",files[i]->d_name);
		free(files[i]);
	}
	free(files);
}
void print_all_sorted_directory()
{
	struct dirent **files;
	int n=scandir(".",&files,NULL,alphasort);
	for(int i=0;i<n;++i)
	{
		printf("%s \n",files[i]->d_name);
		free(files[i]);
	}
	free(files);
}

int main(int argc,char *argv[])
{
	if(argc==1)
		print_sorted_directory();
	else if(argc>2)
		printf("Excess arguments");
	else if(strcmp(argv[1],"-A")==0)
		print_sorted_directory();
	else if(strcmp(argv[1],"-a")==0)
		print_all_sorted_directory();
	else
		printf("Unrecognised flag\n");
	
	return 0;
}
