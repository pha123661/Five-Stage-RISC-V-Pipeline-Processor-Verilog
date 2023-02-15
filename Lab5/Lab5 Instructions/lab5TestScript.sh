rm -rf Lab5test
cp -r Lab5Code Lab5test
cd Lab5test
mkdir -p result
for ((i=1;i<=13;i++))
do
sed -r -i -e "s/CO_test_data([0-9]+).txt/CO_test_data$i.txt/" Instr_Memory.v
iverilog *.v -o test
./test > result/result_$i.txt
done



bonusScore=0
score=0
# diff
echo "=========================="
for ((i=1;i<=13;i++))
do
    diffResult=$(diff  "../Lab5Answer/result_$i.txt"  "result/result_$i.txt") 
    errono=$?
    #echo "diffresult:"$diffResult,"errorno:"$errono
    if [ $errono -eq 0 ];then
        echo "testcase $i pass"
        if [ $i -gt 10 ]; then
            bonusScore=$(($bonusScore + 1))
        else
            score=$(($score+1))
        fi
    else
        echo "testcase $i wrong"
    fi
done

echo "=============================================="
echo "basic score:$(($score*10))"
echo "bonus score:$(($bonusScore*10))"
echo "total score:$((($bonusScore+$score)*10))"



