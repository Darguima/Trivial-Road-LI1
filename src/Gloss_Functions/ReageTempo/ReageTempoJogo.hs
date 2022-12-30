module Gloss_Functions.ReageTempo.ReageTempoJogo where

import Tarefa3_2022li1g031 (animaMapa)
import Tarefa4_2022li1g031 (jogoTerminou)

import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, JOGO))
import System.Random (randomRIO)
import Tarefa5_2022li1g031 (deslizaJogo)

reageTempoJogo :: Float -> Estado -> IO Estado

reageTempoJogo _ (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos) = do
      randomNumber <- randomRIO (1,100)
      let novoJogo = animaMapa jogo
          novoJogoDeslize = deslizaJogo (randomNumber) (novoJogo) 
          novoMenu = if jogoTerminou novoJogoDeslize then DERROTA else JOGO
          

      return (novoJogoDeslize, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, 0,ypontos+1)




reageTempoJogo _ (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,ypontos) = do

  let novoJogo = animaMapa jogo
  let novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO

  return (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual+1,ypontos)


-- randomNumber <- randomRIO (1, 100)
--   let newGame = deslizaJogo randomNumber jogo
--       novoMenu = if jogoTerminou newGame then DERROTA else JOGO
--   return (newGame, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual)