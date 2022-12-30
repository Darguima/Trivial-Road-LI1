module Gloss_Functions.ReageTempo.ReageTempoJogo where

import Tarefa3_2022li1g031 (animaMapa)
import Gloss_Functions.JogoFluido.JogoFluido (animaMapaFluido)
import Tarefa4_2022li1g031 (jogoTerminou)

import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, JOGO), fr)
import System.Random (randomRIO)
import Tarefa5_2022li1g031 (deslizaJogo)
import LI12223 (Jogo(Jogo), Mapa (Mapa))

reageTempoJogo :: Float -> Estado -> IO Estado
reageTempoJogo _ (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual, yMin) = do
  randomNumber <- randomRIO (1,100)

  let changeGameStatus = mod frameAtual fr == 0

  let frameSeguinte = animaMapaFluido jogo frameAtual
  let novoJogo = if changeGameStatus then deslizaJogo randomNumber frameSeguinte else frameSeguinte
  let novoYMin = if changeGameStatus then yMin else yMin + 1

  let novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO
  let novoFrameAtual = if changeGameStatus then 1 else frameAtual + 1

  return (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, novoFrameAtual, novoYMin)
