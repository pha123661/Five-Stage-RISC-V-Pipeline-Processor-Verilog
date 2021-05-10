rm -rf Lab3test
cp -r Lab3Code Lab3test
cd Lab3test
mkdir -p result
for ((i=1;i<=10;i++))
do
sed -r -i -e "s/CO_test_data([0-9]+).txt/CO_test_data$i.txt/" Instr_Memory.v
iverilog *.v -o test
./test > result/result_$i.txt
done



bonusScore=0
score=0
# diff
echo "=========================="
for ((i=1;i<=10;i++))
do
    if [ $(diff <(cat ../Lab3Answer/result_$i.txt) <(cat result/result_$i.txt) | wc -l ) -eq 0 ]
    then
        echo "testcase $i pass"
        score=$(($score+1))
    else
        echo "testcase $i wrong"
    fi
done

echo "=============================================="
echo "total score:$(($score*10))"



