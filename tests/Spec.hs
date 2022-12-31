module Main where

import Tarefa1_2022li1g031_Spec
import Tarefa2_2022li1g031_Spec
import Tarefa3_2022li1g031_Spec
import Tarefa4_2022li1g031_Spec
import Tarefa5_2022li1g031_Spec

import Utils_Spec

import Test.HUnit

runTestsT1 = runTestTT testsT1

runTestsT2 = runTestTT testsT2

runTestsT3 = runTestTT testsT3

runTestsT4 = runTestTT testsT4

runTestsT5 = runTestTT testsT5

runTestsUtils = runTestTT testsUtils

main = runTestTTAndExit $ TestList [testsT1, testsT2, testsT3, testsT4, testsT5, testsUtils]
