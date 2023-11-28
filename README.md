# shell-scripting

This is a repository created to host all the automation related to Roboshop starting from basics to advanced.
All the coding standards are close to best coding standards followed by all the major openSource companies.

In this repo, we start everything from basics and follow sequential order.

Shell is native to linux and had better native advantage with better performance.

# Exception handling Operators

&& : second command will be executed only if the first command is true or a pass

     ex : df -h && uptime   : first cmd is true so second cmd will be executed
        : df -asdfghj && uptime : first cmd is false so 2nd cmd wont be executed.

          we will see output of uptime only if first command is executed/true

|| : second command will be executed if the first command is false or a failure

  :      df -h || uptime   : first cmd is true so second cmd will not be executed
  : df -asdfghj || uptime : first cmd is false so 2nd cmd will be executed.