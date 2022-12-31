module Utils_Spec where

import Utils.Utils (extrairVelocidade)
import LI12223 (Terreno(..))
import Test.HUnit

testsUtils :: Test

extrairVelocidadesTestes = TestList [
  "Teste Extrair Velocidades 01" ~: 0 ~=? extrairVelocidade Relva,
  "Teste Extrair Velocidades 02" ~: 1 ~=? extrairVelocidade (Rio 1),
  "Teste Extrair Velocidades 03" ~: (-2) ~=? extrairVelocidade (Estrada (-2))
  ] 


testsUtils = TestList [extrairVelocidadesTestes]
