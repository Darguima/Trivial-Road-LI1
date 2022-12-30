module Gloss_Functions.DesenhaEstados.DesenhaDerrota where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado )
import Graphics.Gloss ( green, circle, color, Picture (Translate, Pictures, Text, Color), white )
import System.Directory (renameFile)


desenhaEstadoDerrota :: Estado -> IO Picture
desenhaEstadoDerrota (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = 
    do
    score <- highscore 
    escrevePontuacao pontuacaoAtual score 
    return $ Pictures  $ (Translate 0 0 $ texturas !! 25)  : [Translate 0 0   $ Color  white $ Text  $ show pontuacaoAtual ]





      




highscore :: IO Int
highscore = do 
            score <-  readFile "highscore.txt"
            return (read score)




escrevePontuacao :: Int-> Int-> IO ()
escrevePontuacao pontuacaoAtual score = if pontuacaoAtual > score then  writeNewScore pontuacaoAtual     else return ()


writeNewScore :: Int ->  IO () 
writeNewScore pontuacaoAtual=
   do
   writeFile "highscore1.txt" ( show pontuacaoAtual) 
   renameFile "highscore1.txt" "highscore.txt"