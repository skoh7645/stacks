#. $script_dir./list.sh

export STACKS_LIST="incubator/java-openliberty"
numberofstacks=$(echo $STACKS_LIST | awk -F' ' '{ print NF }')

if [ $numberofstacks == 1 ]
then
    yamlFile="./$STACKS_LIST/stack.yaml"
    if [ -f $yamlFile ]
        then
            line=$(grep "docker-version" $yamlFile)
            version=$(echo ${line} | sed 's/[^0-9]*\(.*\)"/\1/') 
            echo $version
    fi
else
    echo ""
fi