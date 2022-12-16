module Gloss_Functions.DesenhaEstado where

import LI12223 ( Jogo(Jogo),Jogador(Jogador),Mapa(..),LinhaDoMapa,Obstaculo(..),Terreno(..) )

import Gloss_Functions.GlossData( Texturas, Estado, MenuAtual(DERROTA, JOGO), tamanhoChunk, getInitialX, getInitialY )

import Graphics.Gloss ( Picture(Pictures, Translate), green, red, yellow, circle, color )

desenharNovoEstado :: Estado -> IO Picture
desenharNovoEstado (Jogo (Jogador (posX, posY)) mapa@(Mapa larguraMapa _), texturas, alturaWindow, JOGO) = do
  return $ Pictures $ 
    desenharMapa mapa texturas (getInitialX larguraMapa) (getInitialY alturaWindow)
    ++ [desenharPlayer posX posY larguraMapa alturaWindow]

  where desenharMapa :: Mapa -> Texturas -> Float -> Float -> [Picture]
  
        desenharMapa (Mapa l (linhaAtual : outrasLinhas)) texturas xInicial yInicial = 
          desenharLinha linhaAtual xInicial yInicial texturas ++ desenharMapa (Mapa l outrasLinhas) texturas xInicial (yInicial - tamanhoChunk)

        desenharMapa _ _ _ _ = []

        desenharLinha :: LinhaDoMapa -> Float -> Float -> Texturas -> [Picture]
        desenharLinha (terreno, chunkAtual : otherChunks) posX posY textures
          = desenharChunk terreno chunkAtual posX posY textures :  desenharLinha (terreno, otherChunks) (posX + tamanhoChunk) posY textures

        desenharLinha (_, []) _ _ _ = []

        desenharChunk :: Terreno -> Obstaculo -> Float -> Float -> Texturas -> Picture
        desenharChunk (Rio _) Nenhum posX posY texturas = Translate posX posY (texturas !! 0)
        desenharChunk (Rio _) Tronco posX posY texturas = Translate posX posY (texturas !! 1)
        desenharChunk Relva Nenhum posX posY texturas = Translate posX posY (texturas !! 2)
        desenharChunk Relva Arvore posX posY texturas = Translate posX posY (texturas !! 3)
        desenharChunk (Estrada _) Nenhum posX posY texturas = Translate posX posY (texturas !! 4)
        desenharChunk (Estrada _) Carro posX posY texturas = Translate posX posY (texturas !! 5)

        desenharPlayer :: Int -> Int -> Int -> Int -> Picture
        desenharPlayer posXJogador posYJogador larguraMapa alturaWindow = Translate posX posY $ color yellow $ circle 20
          where posX = getInitialX larguraMapa + fromIntegral posXJogador * tamanhoChunk
                posY = getInitialY alturaWindow - fromIntegral posYJogador * tamanhoChunk

desenharNovoEstado (jogo, texturas, alturaWindow, DERROTA) = return $ color red $ circle 20
desenharNovoEstado (jogo, texturas, alturaWindow, _) = return $ color green $ circle 20