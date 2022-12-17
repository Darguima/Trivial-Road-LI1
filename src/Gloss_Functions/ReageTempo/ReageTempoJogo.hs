module Gloss_Functions.ReageTempo.ReageTempoJogo where

import Tarefa3_2022li1g031 (animaMapa)
import Tarefa4_2022li1g031 (jogoTerminou)

import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, JOGO))

reageTempoJogo :: Float -> Estado -> IO Estado
reageTempoJogo _ (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa) = do
  let novoJogo = animaMapa jogo
  let novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO
  return (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa)
