## Introduction ##
This is vimpro - ViM Project management. It only includes a basis and an upload script yet.

## Dependencies ##
bash, ncftp (with ncftpput) and ssh for sftp file transfers

## Installation ##

-   Put vimup.sh in $PATH
-   create .vimpro in $HOME and put plist and the sample config in in (see doc/samples/)
-   modify .vimrc in $HOME and add this line which binds upload on F5: map <F5> :w<CR>:silent<CR>:!vimup.sh "$(pwd)/%"<CR>
-    modify the project-config (see testprj.conf)
-    open a file within your configured project and press F5 in command mode

## Limitations ##
Copying Files in scp mode relies on the scp comand that comes with the standard ssh packages. Due to the fact that scp does not accept a password as an argument scp mode only works with ssh-keys in place
