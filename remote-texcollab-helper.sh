if [ -d $1 ]; then
    exit 1
else
    fig=($(echo $1 | sed 's/\// /g'))
    if [ "${fig[@]:(-1)}" == "figures" ]; then
        mkdir $1
    else
        mkdir $1
        cd $1
        git init --bare 
    fi
    exit 0
fi
