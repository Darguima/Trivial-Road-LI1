module Gloss_Functions.ReageTempo.ReageTempoBot where
import Bot (moveBot)
import System.Random (randomRIO)
import Tarefa3_2022li1g031 (animaMapa)
import Tarefa5_2022li1g031 (deslizaJogo)
import Tarefa4_2022li1g031 (jogoTerminou)
import Gloss_Functions.GlossData (PaginaAtual(DERROTA, BOT), Estado)
import LI12223 (Jogo)

getJogo :: Estado -> Jogo 
getJogo (jogo , _ , _ , _ , _ , _ ,_ , _ , _  ) = jogo 

reageTempoBot _ (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, 60,ypontos) = do
      randomNumber <- randomRIO (1,100)
      let novoJogo = animaMapa jogo
          novoEstadoBot =  moveBot (novoJogo , texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
          novoJogoDeslize = deslizaJogo randomNumber (getJogo novoEstadoBot) 

      return (novoJogoDeslize, texturas, tamanhoJanela, BOT, pontuacaoAtual, pontuacoes, larguraMapa, 1, ypontos + 1)

reageTempoBot _ (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,ypontos) = do
  return (jogo, texturas, tamanhoJanela, BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual+1,ypontos)
