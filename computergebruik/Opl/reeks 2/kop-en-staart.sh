### command 1 ###

tail -n 25 passwd

### command 2 ###

head -n 75 passwd | tail -n 50

### command 3 ###

head -n 2 passwd | tail -n 1

### command 4 ###

ls -a ~| wc -l
