module Gloss_Functions.ReageEventos.ReageEventoJogo where

import LI12223 ( Direcao(Direita, Cima, Baixo, Esquerda), Jogada(Move), Jogador (Jogador), Jogo (Jogo) )
import Tarefa3_2022li1g031 ( animaJogador )
import Tarefa4_2022li1g031 ( jogoTerminou )
import Tarefa5_2022li1g031 ( deslizaJogo )

import Gloss_Functions.GlossData ( Estado, PaginaAtual(JOGO, DERROTA, Menu), OpcoesMenu (OPCAO_CONTINUAR) )

import Graphics.Gloss.Interface.IO.Game ( Key(SpecialKey), KeyState(Down), SpecialKey(KeySpace, KeyUp, KeyDown, KeyLeft, KeyRight, KeyEsc), Event(EventKey), polygon )
import System.Random ( randomRIO )

moverJogador :: Estado -> Jogada -> Estado 
moverJogador (jogo@(Jogo (Jogador (_, yInicial)) _), texturas, tamanhoJanela, _, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) (Move Cima)
  |  novoY <  y = (novoJogo, texturas, tamanhoJanela, novoMenu, novaPontuacaoAtual novoY y pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,novoY)
  | otherwise = (novoJogo, texturas, tamanhoJanela, novoMenu,  pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)


   where novoJogo@(Jogo (Jogador (_, novoY)) _) = animaJogador jogo (Move Cima)
         novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO;
    
moverJogador (jogo@(Jogo (Jogador (_, yInicial)) _), texturas, tamanhoJanela, _, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) jogada = (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)
  where novoJogo@(Jogo (Jogador (_, novoY)) _) = animaJogador jogo jogada
        novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO;


novaPontuacaoAtual :: Int -> Int -> Int -> Int
novaPontuacaoAtual  novoY y pontuacao 
        | novoY<y = pontuacao+1
        |otherwise = pontuacao
        
reageEventoJogo :: Event -> Estado -> IO Estado

reageEventoJogo (EventKey (SpecialKey KeyUp) Down _ _) estado = return $ moverJogador estado (Move Cima)
reageEventoJogo (EventKey (SpecialKey KeyDown) Down _ _) estado = return $ moverJogador estado (Move Baixo)
reageEventoJogo (EventKey (SpecialKey KeyLeft) Down _ _) estado = return $ moverJogador estado (Move Esquerda)
reageEventoJogo (EventKey (SpecialKey KeyRight) Down _ _) estado = return $ moverJogador estado (Move Direita)
reageEventoJogo (EventKey (SpecialKey KeyEsc) Down _ _) (jogo, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = return (jogo, texturas, tamanhoJanela, Menu  OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)
reageEventoJogo _ estado = return estado
