{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `desenharNovoEstado` para página de menu
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.DesenhaEstados.DesenhaMenu where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData 
import Graphics.Gloss

{- | Função auxiliar à `desenharNovoEstado` para página de menu -}

desenhaEstadoMenu :: Estado -> IO Picture
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Translate 0 0 $ texturas !! 17

desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Translate 0 0 $ texturas !! 18

desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Translate 0 0 $ texturas !! 19

desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_SIM, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Translate 0 0 $ texturas !! 21

desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_NAO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Translate 0 0 $ texturas !! 22

desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Pictures $ Translate 0 0 (texturas !! 23) : [desenhaPontuacaoAtual larguraMapa (snd tamanhoJanela) pontuacaoAtual]

desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_MENU, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
    return $ Pictures $ (Translate 0 0 $ texturas !! 24)  : [desenhaPontuacaoAtual larguraMapa (snd tamanhoJanela) pontuacaoAtual]
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_COMANDOS, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Translate 0 0 $ texturas !! 27
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_JOGADOR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Translate 0 0 $ texturas !! 30
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Translate 0 0 $ texturas !! 29

  

desenhaPontuacaoAtual :: Int -> Int -> Int -> Picture
desenhaPontuacaoAtual larguraMapa tamanhoJanela score = Translate posX posY $ Scale 0.5 0.5 $ Color white $ Text $ show score 
    where posX = getInitialX larguraMapa + fromIntegral larguraMapa * tamanhoChunk + 250
          posY = getInitialY tamanhoJanela - 40
