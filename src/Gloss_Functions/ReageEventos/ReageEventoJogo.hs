module Gloss_Functions.ReageEventos.ReageEventoJogo where

import LI12223 ( Direcao(Direita, Cima, Baixo, Esquerda), Jogada(Move) )
import Tarefa3_2022li1g031 ( animaJogador )
import Tarefa4_2022li1g031 ( jogoTerminou )
import Tarefa5_2022li1g031 ( deslizaJogo )

import Gloss_Functions.GlossData ( Estado, PaginaAtual(JOGO, DERROTA, Menu), OpcoesMenu (OPCAO_CONTINUAR) )

import Graphics.Gloss.Interface.IO.Game ( Key(SpecialKey), KeyState(Down), SpecialKey(KeySpace, KeyUp, KeyDown, KeyLeft, KeyRight, KeyEsc), Event(EventKey) )
import System.Random ( randomRIO )
import Text.ParserCombinators.ReadP (char)

moverJogador :: Estado -> Jogada -> Estado 
moverJogador (jogo, texturas, tamanhoJanela, JOGO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) jogada = (novoJogo, texturas, tamanhoJanela, novoMenu, novaPontuacaoAtual, pontuacoes, larguraMapa, frameAtual)
  where novoJogo = animaJogador jogo jogada
        novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO;

        novaPontuacaoAtual
          | jogada == Move Cima = pontuacaoAtual + 1
          | jogada == Move Baixo = pontuacaoAtual - 1
          | otherwise = pontuacaoAtual

reageEventoJogo :: Event -> Estado -> IO Estado

reageEventoJogo (EventKey (SpecialKey KeyUp) Down _ _) estado = return $ moverJogador estado (Move Cima)
reageEventoJogo (EventKey (SpecialKey KeyDown) Down _ _) estado = return $ moverJogador estado (Move Baixo)
reageEventoJogo (EventKey (SpecialKey KeyLeft) Down _ _) estado = return $ moverJogador estado (Move Esquerda)
reageEventoJogo (EventKey (SpecialKey KeyRight) Down _ _) estado = return $ moverJogador estado (Move Direita)
reageEventoJogo (EventKey (SpecialKey KeyEsc) Down _ _) (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = return (jogo, texturas, tamanhoJanela, Menu  OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual)
reageEventoJogo (EventKey (SpecialKey KeySpace) Down _ _) (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do 
  randomNumber <- randomRIO (1, 100)
  let newGame = deslizaJogo randomNumber jogo
      novoMenu = if jogoTerminou newGame then DERROTA else JOGO
  return (newGame, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual)


reageEventoJogo _ estado = return estado
