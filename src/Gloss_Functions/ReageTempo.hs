module Gloss_Functions.ReageTempo where

import Gloss_Functions.GlossData ( Estado, MenuAtual(JOGO, DERROTA) )

import Tarefa3_2022li1g031 (animaMapa)
import Tarefa4_2022li1g031 (jogoTerminou)

reageTempo :: Float -> Estado -> IO Estado
reageTempo _ (jogo, texturas, alturaWindow, DERROTA) = do
  return (jogo, texturas, alturaWindow, DERROTA)

reageTempo _ (jogo, texturas, alturaWindow, JOGO) = do
  let novoJogo = animaMapa jogo
  let novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO
  return (novoJogo, texturas, alturaWindow, novoMenu)

reageTempo _ (jogo, texturas, alturaWindow, menuAtual) = do
  return (jogo, texturas, alturaWindow, menuAtual)