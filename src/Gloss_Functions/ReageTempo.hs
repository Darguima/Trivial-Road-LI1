module Gloss_Functions.ReageTempo where

import Gloss_Functions.GlossData ( Estado, PaginaAtual(JOGO, DERROTA) )

import Tarefa3_2022li1g031 (animaMapa)
import Tarefa4_2022li1g031 (jogoTerminou)

reageTempo :: Float -> Estado -> IO Estado
reageTempo _ (jogo, texturas, tamanhoJanela, DERROTA, pontuacaoAtual, pontuacoes, larguraMapa) = do
  return (jogo, texturas, tamanhoJanela, DERROTA, pontuacaoAtual, pontuacoes, larguraMapa)

reageTempo _ (jogo, texturas, tamanhoJanela, JOGO, pontuacaoAtual, pontuacoes, larguraMapa) = do
  let novoJogo = animaMapa jogo
  let novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO
  return (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa)

reageTempo _ (jogo, texturas, tamanhoJanela, menuAtual, pontuacaoAtual, pontuacoes, larguraMapa) = do
  return (jogo, texturas, tamanhoJanela, menuAtual, pontuacaoAtual, pontuacoes, larguraMapa)