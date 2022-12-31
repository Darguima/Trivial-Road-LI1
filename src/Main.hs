{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Módulo Principal
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Main where

import LI12223
import Tarefa6_2022li1g031 ( play )

{- | A função main pode ser executada para correr o projeto todo.

Na pasta root do projeto rodar com o `ghci`:

>>> ghci -i="src" -i="tests" src/Main.hs

-}

main :: IO ()
main = do Tarefa6_2022li1g031.play