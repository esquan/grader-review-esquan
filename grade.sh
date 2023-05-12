CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f ./student-submission/ListExamples.java ]]
then 
    cp student-submission/ListExamples.java TestListExamples.java ./lib/* grading-area
else
    echo "Wrong file submitted."
fi

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" grading-area/*.java 2> /dev/null

if [[ $? != 0 ]]
then
    echo "File did not compile"
    exit 1
else
    java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore grading-area/TestListExamples.java > outcome.txt
fi

result=`grep "FAILURES!!!" outcome.txt`
expected="FAILURES!!!"

if [[ $result == $expected ]]
then   
    echo Your tests give the following Junit error:
    cat outcome.txt
else
    echo All tests passed!
fi

