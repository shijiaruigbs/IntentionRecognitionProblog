import re
import sys
from typing import Iterable, Any, Tuple


def signal_last(it:Iterable[Any]) -> Iterable[Tuple[bool, Any]]:
    iterable = iter(it)
    ret_var = next(iterable)
    for val in iterable:
        yield False, ret_var
        ret_var = val
    yield True, ret_var

results = open('./results.csv')
# Outputted data in problog format.
correct = 0 #Keep track of number of examples predicted correctly.
incorrect = 0
totalExamples = 0
flag = 1
for line in results:
    # The results are stored in three lines. 1: true intent,
    # 2: total num of action obs, 3: predicitons (1 for each additional action obs)

    if flag == 1 :
        # Extract the true hypothesis for the example (the actual intention).
        trueHyp = line.strip()
        totalExamples = totalExamples + 1
        flag = flag + 1

    elif flag == 2 :
        # Extract total number of action observations.
        totObs = int(line.strip())
        flag = flag + 1

    elif flag == 3 :
        dicta = line.split(",")
        # Compare prediction for every observation with true hypothesis.
        for is_last_element, item in signal_last(dicta):
            if is_last_element:
                if item.strip() == trueHyp:
                    correct = correct+1
                else:
                    incorrect = incorrect+1
            #else:
            #    not_so_special_function(var)
        # reset flag
        flag = 1

print("correct and incorrect egs: ")
print(correct)
print(incorrect)
accuracy = correct / totalExamples  # accuracy = num of correct predictions / num of examples
print("accuracy: ")
print(accuracy)
results.close()
outputFile = open("./analysis.txt","a")
outStr = "Exp no: " + str(sys.argv[1]) + "\n"
outputFile.write(outStr)
outStr = "accuracy: " + str(accuracy) + "\n"
outputFile.write(outStr)
outputFile.close()
