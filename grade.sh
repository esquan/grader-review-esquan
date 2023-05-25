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
    cp student-submission/ListExamples.java TestListExamples.java grading-area
    cp -r ./lib/ grading-area
else
    echo "Wrong file submitted."
fi

cd grading-area
javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java

if [[ $? != 0 ]]
then
    echo "File did not compile"
    exit 1
else
    java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > outcome.txt
fi

result=`grep "FAILURES!!!" outcome.txt`
expected="FAILURES!!!"

failed=`grep "Tests run:" outcome.txt`
COUNT_FAIL=${failed:25:1}
COUNT_TOTAL=${failed:11:1}
COUNT_GRADE=$(($COUNT_TOTAL-$COUNT_FAIL))

if [[ $result == $expected ]]
then   
    echo $COUNT_FAIL "test(s) failed"
    echo Grade: $COUNT_GRADE/$COUNT_TOTAL
else
    echo All tests passed!
    echo Grade: 1/1
fi

