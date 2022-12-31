{- |
Module      : Utils
Description : Contem algumas funções úteis ao jogo
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Utils.Utils where
import LI12223 (Terreno (..))

{- | A função extrairVelocidade recebe um terreno e devolve a velocidade  nesse mesmo terreno.

== Exemplos de utilização:
>>> extrairVelocidade Relva
0

>>> extrairVelocidade (Estrada (-2))
-2

-}

extrairVelocidade :: Terreno -> Int
extrairVelocidade (Rio v) = v
extrairVelocidade (Estrada v) = v
extrairVelocidade Relva = 0
