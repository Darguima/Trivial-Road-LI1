module Gloss_Functions.ReageEvento where

import LI12223 ( Jogada(Move), Direcao (Direita, Cima, Baixo, Esquerda) )
import Tarefa3_2022li1g031 (animaJogador)
import Tarefa4_2022li1g031 (jogoTerminou)
import Tarefa5_2022li1g031 ( deslizaJogo )

import Gloss_Functions.GlossData( Estado, MenuAtual(JOGO, DERROTA) )

import Graphics.Gloss.Interface.IO.Game ( Event(EventKey), Key(SpecialKey), KeyState(Down), SpecialKey(KeySpace, KeyUp, KeyDown, KeyLeft, KeyRight) )
import System.Random ( randomRIO )

moverJogador :: Estado -> Jogada -> Estado 
moverJogador (jogo, texturas, alturaWindow, JOGO) jogada = (novoJogo, texturas, alturaWindow, novoMenu)
  where novoJogo = animaJogador jogo jogada
        novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO;

reageEvento :: Event -> Estado -> IO Estado

reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado = return $ moverJogador estado (Move Cima)
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado = return $ moverJogador estado (Move Baixo)
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado = return $ moverJogador estado (Move Esquerda)
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado = return $ moverJogador estado (Move Direita)

reageEvento (EventKey (SpecialKey KeySpace) Down _ _) (jogo, texturas, alturaWindow, JOGO) = do 
  randomNumber <- randomRIO (1, 100)
  let newGame = deslizaJogo randomNumber jogo
  return (newGame, texturas, alturaWindow, JOGO)

reageEvento _ estado = return estado
