#. $script_dir./list.sh

export STACKS_LIST="incubator/java-openliberty"
if [ ${#STACKS_LIST[@]} == 1 ]
then
    yamlFile="./$STACKS_LIST/stack.yaml"
    if [ -f $yamlFile ]
        then
            line=$(grep "docker-version" $yamlFile)
            version=$(echo ${line} | sed 's/[^0-9]*\(.*\)"/\1/') 
            echo $version
    fi
fi