module Gloss_Functions.ReageTempo.ReageTempoJogo where

import Tarefa3_2022li1g031 (animaMapa)
import Tarefa4_2022li1g031 (jogoTerminou)

import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, JOGO), fr)
import System.Random (randomRIO)
import Tarefa5_2022li1g031 (deslizaJogo)

reageTempoJogo :: Float -> Estado -> IO Estado

reageTempoJogo _ (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual, yMin) = do
  randomNumber <- randomRIO (1,100)
  print frameAtual
  let novoJogo = deslizaJogo randomNumber $ animaMapa jogo
  let novoJogo = animaMapa jogo
  let changeGameStatus = mod frameAtual fr == 0
  let novoMenu = if changeGameStatus && jogoTerminou novoJogo then DERROTA else JOGO
  let jogoAtual = if changeGameStatus then novoJogo else jogo
  let novoFrameAtual = if changeGameStatus then 1 else frameAtual + 1
  return (jogoAtual, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, novoFrameAtual, yMin + 1)
