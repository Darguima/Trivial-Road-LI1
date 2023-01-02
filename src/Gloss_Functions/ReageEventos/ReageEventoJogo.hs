{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `reageEvento` para página de jogo
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageEventos.ReageEventoJogo where

import LI12223 ( Direcao(Direita, Cima, Baixo, Esquerda), Jogada(Move), Jogador (Jogador), Jogo (Jogo) )
import Tarefa3_2022li1g031 ( animaJogador )
import Tarefa4_2022li1g031 ( jogoTerminou )
import Tarefa5_2022li1g031 ( deslizaJogo )

import Gloss_Functions.GlossData ( Estado, PaginaAtual(JOGO, DERROTA, Menu), OpcoesMenu (OPCAO_CONTINUAR) )

import Graphics.Gloss.Interface.IO.Game ( Key(SpecialKey), KeyState(Down), SpecialKey(KeySpace, KeyUp, KeyDown, KeyLeft, KeyRight, KeyEsc), Event(EventKey), polygon )
import System.Random ( randomRIO )

{- | Função auxiliar à `reageEvento` para página de jogo -}

reageEventoJogo :: Event -> Estado -> IO Estado

reageEventoJogo (EventKey (SpecialKey KeyUp) Down _ _) estado = return $ moverJogador estado (Move Cima)
reageEventoJogo (EventKey (SpecialKey KeyDown) Down _ _) estado = return $ moverJogador estado (Move Baixo)
reageEventoJogo (EventKey (SpecialKey KeyLeft) Down _ _) estado = return $ moverJogador estado (Move Esquerda)
reageEventoJogo (EventKey (SpecialKey KeyRight) Down _ _) estado = return $ moverJogador estado (Move Direita)

reageEventoJogo (EventKey (SpecialKey KeyEsc) Down _ _) (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = return (jogo, texturas, tamanhoJanela, Menu  OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoJogo (EventKey (SpecialKey KeySpace) Down _ _) (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do 
  randomNumber <- randomRIO (1, 100)
  let newGame = deslizaJogo randomNumber jogo
      novoMenu = if jogoTerminou newGame then DERROTA else JOGO
  return (newGame, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual, y + 1)


reageEventoJogo _ estado = return estado

{- | Função auxiliar à `reageEventoJogo` responsável por mover o jogador no mapa, detetando colisões fatais e calculando novas pontuações (função `novaPontuacaoAtual`) -}

moverJogador :: Estado -> Jogada -> Estado 
moverJogador (jogo@(Jogo (Jogador (_, yInicial)) _), texturas, tamanhoJanela, JOGO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) (Move Cima)
  | novoY < y = (novoJogo, texturas, tamanhoJanela, novoMenu, novaPontuacaoAtual novoY y pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,novoY)
  | otherwise = (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)


  where novoJogo@(Jogo (Jogador (_, novoY)) _) = animaJogador jogo (Move Cima)
        novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO;
    
moverJogador (jogo@(Jogo (Jogador (_, yInicial)) _), texturas, tamanhoJanela, JOGO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) jogada = (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)
  where novoJogo@(Jogo (Jogador (_, novoY)) _) = animaJogador jogo jogada
        novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO;

{- | Função usada para calcular as novas pontuações -}

novaPontuacaoAtual :: Int -> Int -> Int -> Int
novaPontuacaoAtual  novoY y pontuacao 
        | novoY<y = pontuacao+1
        | otherwise = pontuacao
