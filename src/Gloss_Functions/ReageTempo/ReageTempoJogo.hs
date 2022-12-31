{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `reageTempo` para página de jogo
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageTempo.ReageTempoJogo where

import LI12223
import Gloss_Functions.JogoFluido.AnimaMapaFluido (animaMapaFluido)
import Gloss_Functions.JogoFluido.JogoFluidoTerminou (jogoFluidoTerminou)
import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, JOGO), fr)
import System.Random (randomRIO)
import Tarefa5_2022li1g031 (deslizaJogo)

{- | Função auxiliar à `reageTempo` para página de jogo -}

reageTempoJogo :: Float -> Estado -> IO Estado
reageTempoJogo _ (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual, yMin) = do
  randomNumber <- randomRIO (1,100)

  let changeGameStatus = mod frameAtual fr == 0

  let frameSeguinte = animaMapaFluido jogo frameAtual
  let novoJogo = if changeGameStatus then deslizaJogo randomNumber frameSeguinte else frameSeguinte
  let novoYMin = if changeGameStatus then yMin else yMin + 1

  let novoMenu = if jogoFluidoTerminou novoJogo changeGameStatus frameAtual then DERROTA else JOGO
  let novoFrameAtual = if changeGameStatus then 1 else frameAtual + 1

  return (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, novoFrameAtual, novoYMin)
