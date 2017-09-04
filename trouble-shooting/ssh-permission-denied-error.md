## Issue summary
I generated ssh rsa keys.  
And I also submit public key to github remote repository.   
But when I pull or push to remote repository.  
I got `permission denied` error

## Environment (integrated library, OS, etc)
- Git
- Windows
- Git bash

## Expected behavior
just pull or push successfully.

## Actual behavior
When I pull or push to remote repository.
I got this error
````error
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
````

## Issue detail (Reproduction steps, use case)
N/A

## Trouble shooting
Remote repository do not accept the unauthorized request. Because actually I did not request with private key.  
Or If you can't sure your public key is not registered to github remote repository.  
You can simply use this command.
````bash
ssh -T git@github.com -i ~/.ssh/id_rsa.github
````

In my case, I got error if I didn't include `-i` opotion.  
So I searched google and stackoverflow, finally I found solutions.  
https://stackoverflow.com/questions/4565700/specify-private-ssh-key-to-use-when-executing-shell-command-with-or-without-ruby

### Using `~/.ssh/config ` File
````bash
vi ~/.ssh/config
````
And modifiy
````
Host github.com
  Hostname github.com
  IdentityFile ~/.ssh/github_rsa
  IdentitiesOnly yes
````

### TODO: another solutions