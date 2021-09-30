#This script takes PR Gen data as input and runs predictions over the data using a problog model.
#The script outputs the predicitons to a file.

import pandas as pd
import numpy as np
import re
from datetime import datetime
from problog.program import PrologString
from problog import get_evaluatable

# This function removes all evidence lines from the ProbLog model file.
def remLines(noOfLinesToRem):
    file = open('./kitchenModelCopy.pl', 'r')
    lines = file.readlines()
    file.close()
    #print(lines)
    file = open('./kitchenModelCopy.pl', 'w')
    #index = noOfLinesToRem * -1
    lines = lines[:-noOfLinesToRem]
    for line in lines:
        file.write(line)
    file.close()

# This function runs the queries on the model.
# This includes:
def runQueries(resultString, observations, model, queries):
    #print("Running Queries: ")
    #Convert model and queries to a single string.
    obs = ''.join(observations)
    modelObs = str(model) + obs
    #queries = queriesFile.read().replace('\n', '')
    fullModel = str(modelObs) + str(queries)
    # Parse the Prolog string
    pl_model = PrologString(fullModel)
    # Compile the Prolog model
    knowledge = get_evaluatable().create_from(pl_model)
    # Evaluate model (run queries)
    results = knowledge.evaluate()
    #print("--------Results---------")
    #print(results)
    # Extract the query with the maximum probability (this will be the prediction).
    max_value = max(results.values())  # maximum value
    max_keys = [k for k, v in results.items() if v == max_value]
    #print(max_keys)
    #print(max_value)
    resultString = resultString + str(max_keys[0]) + ", "
    return resultString

print("makePredictions began")
dat = open('./data/Sept2021/data_50_exp3.csv')

intents = {
  "(made_breakfast)": "iMakeBreakfast(tom)",
  "(lunch_packed)": "iPackLunch(tom)",
  "(made_dinner)": "iMakeDinner(tom)",
  "(taken_medicine)": "iTakeMedicine(tom)",
  "(watching_movie)": "iWatchMovie(tom)",
  "(counter_wiped)": "iWipeCounter(tom)",
  "(plants_tended)": "iTendPlants(tom)",
  "(drank_juice)": "iDrinkJuice(tom)",
}

resultsFile = open("./data/Sept2021/results/experimentPredictions.csv", "a")
queriesFile = open('./queries_exp2.txt', 'r')
queries = queriesFile.read()#.replace('\n', '')
modelFile = open('./humanCoded/kitchenModelHumanCoded_exp2.pl', 'r')
model = modelFile.read()#.replace('\n', '')

results = []
flag = 1
breakFlag = False
counter = 1
for line in dat:
    if breakFlag == False:
        #print(line)
        # The data is presented in 3 lines. Each line is delt with differently.
        # We keep track of lines 1-3 with a flag
        # The first line contains the true intent, the second the time, third, the observation sequence.

        # Open the file containing the model. The model must be updated with each new observation.
        modelFile = open("./kitchenModelCopy.pl", "a")
        resultString = ''

        # The first line contains the label.
        if flag == 1 :
            # Extract the label for the example (the actual intention).
            key = line.strip()
            # ----------------- What is happening here? -----------------------------------
            labelstr = intents[key] + "\n"
            results.append(labelstr)
            flag = flag + 1

        #The second line contains the time
        elif flag == 2 :
            #Setup new observation list
            observations = []
            # Extract time and format
            timestr = "evidence(" + line.strip() + ", true).\n"
            #modelFile.write(timestr)
            observations.append(timestr)
            flag = flag + 1

        # The third line contains the sequence of actions.
        elif flag == 3 :
            print("beginning predictions on new example " + str(counter))
            counter = counter + 1
            # After each example, the action evidence from that example needs to be removed
            # and replaced with the evidence in the new example. The noOfLinesToRem variable
            # tracks how many lines need to be removed from the model file.
            noOfLinesToRem = 1 #starts at one to include time.
            dicta = line.split(",")

            # Put every action in the sequence into prolog format and write to file.
            # We run the queries to test the model after each additional action is added.
            bf = False
            actNum = 0
            for item in dicta:
                if bf == False:
                    actNum = actNum+1
                    actionStr = re.sub(r'[()]', '', item.strip()) #remove brackets and spaces.
                    splitLoc = actionStr.find(" ") #split and extract anction and object.
                    action = actionStr[:splitLoc]
                    object = actionStr[splitLoc+1:]
                    stra = "evidence(" + action + "(" + object + "), true).\n" #put into problog format.
                    #modelFile.write(stra) #write to end of model file
                    observations.append(stra)
                    # query model here
                    resultString = runQueries(resultString, observations, model, queries)
                    noOfLinesToRem = noOfLinesToRem +1
                    #bf = True
            results.append(str(actNum)+"\n")
            results.append(resultString[:-2]+"\n")
            flag = 1
            #remLines(noOfLinesToRem)
            #breakFlag = True

modelFile.close()
dat.close()
#resultsFile = open("./results.csv", "w")
with open('./data/Sept2021/results/results', 'w') as f:
    for item in results:
        f.write(item)
resultsFile.close()
print("makePredictions done")
