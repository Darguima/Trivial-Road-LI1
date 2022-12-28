module Gloss_Functions.DesenhaEstados.DesenhaMenu where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData 
import Graphics.Gloss







desenhaEstadoMenu :: Estado -> IO Picture
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
  return $ Translate 0 0 $ texturas !! 17
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
  return $ Translate 0 0 $ texturas !! 18
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
  return $ Translate 0 0 $ texturas !! 19
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_SIM, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
  return $ Translate 0 0 $ texturas !! 21
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_NAO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
  return $ Translate 0 0 $ texturas !! 22
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
  return $ Pictures $ (Translate 0 0 $ texturas !! 23)  : [desenhaPontuacao pontuacaoAtual tamanhoJanela]
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_MENU, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
    return $ Pictures $ (Translate 0 0 $ texturas !! 24)  : [desenhaPontuacao pontuacaoAtual tamanhoJanela]
  


desenhaPontuacao :: Int ->  (Int,Int) -> Picture 
desenhaPontuacao pontuacao (x,y) = Translate (monitorX x) (monitorY y ) $ Color (greyN  0.4)  $ Scale 0.6 0.6 $ Text (show pontuacao) 

monitorX :: Int -> Float 
monitorX largura = let largurafloat = fromIntegral largura 
                   in largurafloat * 850 /1920

monitorY :: Int -> Float 
monitorY altura = let alturafloat = fromIntegral altura
                   in (-alturafloat * 520 /1080)
