{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `reageEvento` para página de menu
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageEventos.ReageEventoMenu where

import Gloss_Functions.GlossData
import Graphics.Gloss.Interface.IO.Game ( Key(SpecialKey, Char), Event(EventKey), KeyState(Down), SpecialKey(KeyEnter, KeyDown, KeyUp, KeyEsc, KeyLeft, KeyRight) )
import System.Exit (exitSuccess, exitFailure)
import LI12223 (Jogo(Jogo), Mapa (Mapa))

{- | Função auxiliar à `reageEvento` para página de menu -}

reageEventoMenu :: Event -> Estado -> IO Estado

reageEventoMenu (EventKey (SpecialKey KeyDown) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyUp) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyDown) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyUp) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyUp) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyDown) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_JOGADOR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_NAO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SIM, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  exitSuccess

reageEventoMenu (EventKey (SpecialKey KeyLeft) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SIM, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_NAO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyRight) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SIM, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_NAO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyRight) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_NAO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SIM, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyLeft) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_NAO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SIM, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_NAO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyDown) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_MENU, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyUp) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_MENU, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyDown) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_MENU, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyUp) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_MENU, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  JOGO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_MENU, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (estadoInicial texturas tamanhoJanela)
  
reageEventoMenu (EventKey (Char 'c'  ) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_COMANDOS, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (Char 'C'   ) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_COMANDOS, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (Char 'c'  ) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_COMANDOS, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (Char 'C'   ) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_COMANDOS, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (Char 'c'  ) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_COMANDOS, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (Char 'C'   ) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_COMANDOS, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEsc  ) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_COMANDOS, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyLeft) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGADOR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEsc) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGADOR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEsc) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_JOGAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyRight) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGADOR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyLeft) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_JOGADOR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyRight) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_JOGADOR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (Jogo jogador (Mapa l mapa), texturas, tamanhoJanela, Menu OPCAO_BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  let novoMapa = mapaInicialBot
  let newGame = Jogo jogador novoMapa
  return (newGame, texturas, tamanhoJanela, BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, Menu OPCAO_JOGADOR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return (newGame, texturas, tamanhoJanela,  JOGO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

reageEventoMenu _ estado = return estado
