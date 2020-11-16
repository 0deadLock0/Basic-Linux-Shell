Explanations:

System Calls:
	fork() to create a child process to aid the parent process in completing task
	waitpid() to wait for the child process to finish, so that parent can start working
	execv() to pass arguments to executable binaries

Working:
	The shell runs inside main() in a while loop.
	First the user input is taken in raw form using read_command() method.
	Then this entered command is passed to parse_command method which trims spaces from both sides, tokenize the command.
	After calling parse_command(), we have tokens of the command which are used to run the command.
	These tokens are sent to execute_command() method, in order to get executed.
	The functions check if the first token is a vliad command or not.
	Based on the outcomes, if the first token is a valid command, the coressponding method to execute it is called.
	In the method, using the tokens, the complete argument set is extracted and ran within the fucntion in case of internal commands and using the dedicated executables in case of external commands
	Every External command is run by first changing the flow of program from the current program to the dedicated executable.
	This is done using fork() and execv(), while to run the further process smoothly by the parent process waitpid is used.
	In the execuatbles the tokens are checked for specific signature of working commands, and no matching are run.
	This cycles continues, till the users wishes.

Note:
	To handle command with meaningful spaces, like name of a file, double qoutes should be used to enter such name. Example- "hello world.txt"
	
Error Handling:
	Check for file successfully opend
	Check for process created successfully
	Check for process ended successfully
	Check for Insufficient arguments for command
	Check for excess arguments for command
	Check for unrecognized command
	Check for Invalid command type
	Check for File do not exits
	Check for argument validity in context
	
Commands:
	cd - change the current working directory of shell
	pwd - get the current working directory of shell
	history - to check the entered commands 
	echo - to show user input back
	exit - to exit the shell
	cat - to print files
	ls - to show content of current directory
	date - to show the current time
	rm - to remove a file
	mkdir - to make directory

Specific Inbuilt Functions:
	fork() - to create a child process
	waitpid() - to wait parent for child process to finish
	execv() - to call executable
	exit() - to exit from a program
	chdir() - to change the current working directory
	getcwd() - to get the current working directory
	getlogin() - to get the user logged in currently
	scandir() - to scan the contents of a directory
	fopen() - to open a file for reading/wrirting
	fclose() - to close a file
	fseek() - to reach a particular point in a file
	fgets() - to read a line from a stream
	fputs() - to transfer content to a stream'
	time() - to get time in epoch form
	strftime() - to format the time form
	gmtime() - to get utc time
	localtime() - to get local time


Known Bug:
Using mkdir, changes access permission in the applied folder.
