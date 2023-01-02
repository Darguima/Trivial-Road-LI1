module Gloss_Functions.DesenhaEstados.DesenhaDerrota where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado, Texturas )
import Graphics.Gloss ( green, circle, color, Picture (Translate, Pictures, Text, Color), white )
import System.Directory (renameFile)


desenhaEstadoDerrota :: Estado -> IO Picture
desenhaEstadoDerrota (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = 
    do
    score<- highscore
    escrevePontuacao pontuacaoAtual score 
    return $ novafoto pontuacaoAtual score texturas
    






-- escrevelista :: Int -> [Int] -> IO ()
-- escrevelista pontuacao lista =  do
--     let newlist = pontuacao:lista 
--     writeFile "pontuacoes1.json" (  show newlist) 
--     renameFile "pontuacoes1.json" "pontuacoes.json"



-- lista :: IO [Int]
-- lista = do 
--         list <- readFile "pontuacoes.json"
--         return (read list)     




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


novafoto :: Int -> Int-> Texturas ->  Picture 
novafoto x y texturas
 | x>=y =   Pictures  $ (Translate 0 0 $ texturas !! 26)  : [Translate 0 0   $ Color  white $ Text  $ show x ]
 |otherwise =   Pictures  $ (Translate 0 0 $ texturas !! 25)  : [Translate 0 0   $ Color  white $ Text  $ show x]