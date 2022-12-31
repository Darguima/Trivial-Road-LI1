{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `reageEvento` para página de menu
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageEventos.ReageEventoMenu where

import Gloss_Functions.GlossData 
import Graphics.Gloss.Interface.IO.Game ( Event(EventKey), Key(SpecialKey), KeyState(Down), SpecialKey(KeyEnter, KeyRight, KeyLeft, KeyDown, KeyUp) )
import System.Exit (exitSuccess, exitFailure)

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
  return (newGame, texturas, tamanhoJanela,  JOGO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)

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
  return $ estadoInicial texturas tamanhoJanela

reageEventoMenu _ estado = return estado
