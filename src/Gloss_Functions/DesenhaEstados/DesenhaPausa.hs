module Gloss_Functions.DesenhaEstados.DesenhaPausa where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado, OpcoesMenu (OPCAO_CONTINUAR, OPCAO_SAIR), PaginaAtual (Menu) )
import Graphics.Gloss ( green, circle, color, Picture (Translate) )

-- desenhaEstadoPausa :: Estado -> IO Picture
-- desenhaEstadoPausa (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
--  return $ Translate   0 0 $ texturas !! 23
-- desenhaEstadoPausa (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, Menu OPCAO_SAIR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
--  return $ Translate   0 0 $ texturas !! 24