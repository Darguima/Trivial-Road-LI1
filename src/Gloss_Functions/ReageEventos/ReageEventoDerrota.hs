{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `reageEvento` para página de derrota
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageEventos.ReageEventoDerrota where

import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, Menu), OpcoesMenu (OPCAO_JOGAR), estadoInicial)

import Graphics.Gloss.Interface.IO.Game

{- | Função auxiliar à `reageEvento` para página de derrota -}

reageEventoDerrota :: Event -> Estado -> IO Estado
reageEventoDerrota (EventKey (SpecialKey KeyEsc) Down _ _) (newGame, texturas, tamanhoJanela,  DERROTA, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return $ estadoInicial texturas tamanhoJanela

reageEventoDerrota (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela,  DERROTA, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return $ estadoInicial texturas tamanhoJanela

reageEventoDerrota (EventKey (SpecialKey KeySpace) Down _ _) (newGame, texturas, tamanhoJanela,  DERROTA, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return $ estadoInicial texturas tamanhoJanela
  
reageEventoDerrota _ estado = return estado
