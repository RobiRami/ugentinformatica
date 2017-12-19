c="false"
f="false"

while getopts ":c:f" opt; do
    case $opt in
        c )
            if [ ${#OPTARG} = 0 ]; then
                echo "Syntaxis: schuttingtaal [-f] [-c commit] <git-repo> <token>" 1>&2
                exit 1
            fi
            c=$OPTARG
            ;;
        f )
            f="true"
            ;;
        \? )
            echo "Syntaxis: schuttingtaal [-f] [-c commit] <git-repo> <token>" 1>&2
            exit 1
    esac
done
shift $((OPTIND - 1))

if [[ ! $# -eq 2 ]]; then
    echo "Syntaxis: schuttingtaal [-f] [-c commit] <git-repo> <token>" 1>&2
    exit 1
fi

gitrepo=$1
word=$2

directory=$(echo $gitrepo | egrep -o '[^//]*$' | sed 's/.git//')

if [[ ! -d $directory ]]; then
    git clone $gitrepo $directory > /dev/null
    cd $directory
else
    cd $directory
    git pull origin master > /dev/null
fi

if [[ $c != "false" ]]; then
    git checkout $c > /dev/null
    if [ $? != 0 ]; then
        exit 2
    fi
    if [ $f = "true" ]; then
        result="$(grep -rl $word | wc -l)"
    else
        result="$(grep -r $word | wc -l)"
    fi
else
    if [ $f = "true" ]; then
        result="$(grep -rl $word | wc -l)"
    else
        result="$(grep -r $word | wc -l)"
    fi
fi

echo $result








