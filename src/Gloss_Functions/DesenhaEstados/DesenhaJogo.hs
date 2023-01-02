module Gloss_Functions.DesenhaEstados.DesenhaJogo where

import Data.List (group)
import LI12223 ( Jogo(Jogo),Jogador(Jogador),Mapa(..),LinhaDoMapa,Obstaculo(..),Terreno(..) )
import Gloss_Functions.GlossData( Texturas, Estado, PaginaAtual(DERROTA, JOGO), tamanhoChunk, getInitialX, getInitialY, getLastX )
import Graphics.Gloss ( Picture(Pictures, Translate, Rotate, Text, Color, Scale), green, red, yellow, circle, color, white )
import Data.Monoid (Last(getLast))

desenhaEstadoJogo :: Estado -> IO Picture
desenhaEstadoJogo (Jogo (Jogador (posX, posY)) mapa, texturas, tamanhoJanela, _, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
  return $ Pictures $ 
    desenharMapa mapa texturas (getInitialX larguraMapa) (getInitialY $ snd tamanhoJanela)
    ++ [desenharPlayer frameAtual posX posY larguraMapa $ snd tamanhoJanela]
    ++ [desenhaPontuacaoAtual larguraMapa (snd tamanhoJanela) pontuacaoAtual]

  where desenharMapa :: Mapa -> Texturas -> Float -> Float -> [Picture]
        desenharMapa (Mapa l [linha]) texturas xInicial yInicial = desenharLinha (linha) xInicial yInicial texturas
        desenharMapa (Mapa l (linhas:outraslinhas)) texturas xInicial yInicial = 
          desenharLinha (last outraslinhas) xInicial yInicial texturas ++ desenharMapa (Mapa l (init (linhas:outraslinhas))) texturas xInicial (yInicial + tamanhoChunk)

        desenharMapa _ _ _ _ = []

        desenharLinha :: LinhaDoMapa -> Float -> Float -> Texturas -> [Picture]
        desenharLinha (_, []) _ _ _ = []
        desenharLinha (Estrada v, listaObjetos@(chunkAtual:otherChunks) ) posX posY textures
         | take3Cars listaObjetos  = desenhar3Chunk (Estrada v) posX posY textures  ++ desenharLinha' (Estrada v, drop 3 listaObjetos) (posX + 3*tamanhoChunk) posY textures
         | take2CarsL listaObjetos  && v> 0  = desenhar2ChunkL (Estrada v) posX posY textures  ++ desenharLinha' (Estrada v,  init $ drop 2 listaObjetos) (posX + 2*tamanhoChunk) posY textures  ++ [Translate (getLastX larguraMapa) (posY) $ texturas !! 10]
         | take2CarsL listaObjetos  && v< 0 = desenhar2ChunkL (Estrada v) posX posY textures  ++ desenharLinha' (Estrada v,  init $ drop 2 listaObjetos) (posX + 2*tamanhoChunk) posY textures  ++ [Translate  (getLastX larguraMapa) (posY) $ texturas !! 7]
         | take2CarsR listaObjetos && v > 0 =[Translate (posX) (posY) $ texturas !! 12]  ++ desenharLinha' (Estrada v,  drop 1 $ reverse.drop 2.reverse $ listaObjetos) (posX + tamanhoChunk) posY textures  ++ desenhar2ChunkR (Estrada v)  (getLastX larguraMapa - tamanhoChunk) posY textures
         | take2CarsR listaObjetos && v < 0 =[Translate (posX) (posY) $ texturas !! 9]  ++ desenharLinha' (Estrada v, drop 1 $ reverse.drop 2.reverse $  listaObjetos) (posX + tamanhoChunk) posY textures  ++ desenhar2ChunkR (Estrada v) (getLastX larguraMapa - tamanhoChunk) posY textures
         | carrosInitFim listaObjetos && v> 0 = [Translate (posX) (posY) $ texturas !! 16] ++ desenharLinha' (Estrada v, drop 1 $ reverse.drop 1.reverse $  listaObjetos) (posX + tamanhoChunk) posY textures ++ [Translate (getLastX larguraMapa) (posY) $ texturas !! 15]
         | carrosInitFim listaObjetos && v<0 = [Translate (posX) (posY) $ texturas !! 14] ++ desenharLinha' (Estrada v, drop 1 $ reverse.drop 1.reverse $  listaObjetos) (posX + tamanhoChunk) posY textures ++ [Translate (getLastX larguraMapa) (posY) $ texturas !! 13 ]
         | carros2juntos listaObjetos = desenhar2Carros (Estrada v) posX posY textures ++ desenharLinha' (Estrada v, drop 2 listaObjetos) (posX + 2*tamanhoChunk) posY textures
         | otherwise = desenharChunk (Estrada v) chunkAtual posX posY textures :  desenharLinha' ( Estrada v, otherChunks) (posX + tamanhoChunk) posY textures              
        desenharLinha (terreno, chunkAtual : otherChunks) posX posY textures =  desenharChunk terreno chunkAtual posX posY textures :  desenharLinha' (terreno, otherChunks) (posX + tamanhoChunk) posY textures            
--1,2,3,4      
        desenharLinha' :: LinhaDoMapa -> Float -> Float -> Texturas -> [Picture]
        desenharLinha' (Estrada v, listaObjetos@(chunkAtual:otherChunks) ) posX posY textures
         | take3Cars listaObjetos  = desenhar3Chunk (Estrada v) posX posY textures  ++ desenharLinha' (Estrada v, drop 3 listaObjetos) (posX + 3*tamanhoChunk) posY textures 
         | carros2juntos listaObjetos = desenhar2Carros (Estrada v) posX posY textures ++ desenharLinha' (Estrada v, drop 2 listaObjetos) (posX + 2*tamanhoChunk) posY textures
         | otherwise = desenharChunk (Estrada v) chunkAtual posX posY textures :  desenharLinha' ( Estrada v, otherChunks) (posX + tamanhoChunk) posY textures
        desenharLinha' (terreno, chunkAtual : otherChunks) posX posY textures = desenharChunk terreno chunkAtual posX posY textures :  desenharLinha' (terreno, otherChunks) (posX + tamanhoChunk) posY textures 
        desenharLinha' (_, []) _ _ _ = []

        desenhar2Carros :: Terreno -> Float->Float->Texturas -> [Picture]
        desenhar2Carros(Estrada v ) posX posY texturas 
         | v <0 = [Translate posX posY $ texturas !! 13]   ++ [Translate (posX + tamanhoChunk) posY $ texturas !! 14]
         | otherwise =[Translate posX posY $ texturas !! 15]   ++ [Translate (posX + tamanhoChunk) posY $ texturas !! 16]
       
--[rio, tronco, relva, arvore, estrada, carro, player, carro1, carro2, carro3, carro4, carro5, carro6,carro7,carro8,carro9,carro10]
        carros2juntos :: [Obstaculo]->Bool
        carros2juntos [] = False
        carros2juntos lista 
         | length lista <2 = False
         | otherwise  = all (== Carro) (take 2 lista)

        
        carrosInitFim :: [Obstaculo]-> Bool
        carrosInitFim [] = False
        carrosInitFim lista@(x:xs)
         | length lista <2 = False 
         | otherwise = x == Carro && last xs == Carro 

        
        take2CarsR ::  [Obstaculo] -> Bool 
        take2CarsR [] = False 
        take2CarsR lista 
         | length lista <=2 = False
         | otherwise = all (==Carro) (drop 6 lista) && (head lista == Carro)    
--a     b c 
--12   10 11
--a b      c
        take2CarsL ::  [Obstaculo] -> Bool 
        take2CarsL [] = False 
        take2CarsL lista 
         | length lista <=2 = False
         | otherwise = all (==Carro) (take 2 lista) && (last lista == Carro)
      
        take3Cars ::  [Obstaculo] -> Bool 
        take3Cars [] = False 
        take3Cars lista 
         | length lista <3 = False
         | otherwise = all (==Carro) (take 3 lista) 
                 
        desenhar3Chunk :: Terreno -> Float->Float->Texturas -> [Picture]
        desenhar3Chunk (Estrada v ) posX posY texturas 
         | v < 0 = [Translate posX posY $ texturas !! 7]   ++ [Translate (posX + tamanhoChunk) posY $ texturas !! 8] ++ [Translate (posX + 2*tamanhoChunk) posY $ texturas !! 9]
         | otherwise = [Translate posX posY $ texturas !! 10]   ++ [Translate (posX + tamanhoChunk) posY $ texturas !! 11] ++ [Translate (posX + 2*tamanhoChunk) posY $ texturas !! 12]
        

        desenhar2ChunkL :: Terreno -> Float->Float->Texturas -> [Picture]
        desenhar2ChunkL (Estrada v ) posX posY texturas 
         | v <0 = [Translate posX posY $ texturas !! 8]   ++ [Translate (posX + tamanhoChunk) posY $ texturas !! 9] 
         | otherwise = [Translate posX posY $ texturas !! 11]   ++ [Translate (posX + tamanhoChunk) posY $ texturas !! 12] 
        
        desenhar2ChunkR :: Terreno -> Float->Float->Texturas -> [Picture]
        desenhar2ChunkR (Estrada v ) posX posY texturas 
         | v <0 = [Translate posX posY $ texturas !! 7]   ++ [Translate (posX + tamanhoChunk) posY $ texturas !! 8] 
         | otherwise = [Translate posX posY $ texturas !! 10]   ++ [Translate (posX + tamanhoChunk) posY $ texturas !! 11] 
        

        desenharChunk :: Terreno -> Obstaculo -> Float -> Float -> Texturas -> Picture
        desenharChunk (Rio _) Nenhum posX posY texturas =  Translate posX posY $ texturas !! 0
        desenharChunk (Rio _) Tronco posX posY texturas = Translate posX posY $ texturas !! 1
        desenharChunk Relva Nenhum posX posY texturas = Translate posX posY $ texturas !! 2
        desenharChunk Relva Arvore posX posY texturas = Translate posX posY $ texturas !! 3
        desenharChunk (Estrada _) Nenhum posX posY texturas = Translate posX posY $ texturas !! 4 
        desenharChunk (Estrada v) Carro posX posY texturas 
         | v > 0 = Translate posX posY $ texturas !! 5
         |otherwise = Translate posX posY $ texturas !! 28

        -- desenharChunk (Estrada vel) Carro posX posY texturas = Translate posX posY $ Rotate angle $ texturas !! 5
        --   where angle = if vel > 0 then 0 else 180 

        desenharPlayer ::Int-> Int -> Int -> Int -> Int -> Picture
        desenharPlayer fr posXJogador posYJogador larguraMapa tamanhoJanela = Translate posX posY $ color yellow $ texturas !! 6
         where posX = getInitialX larguraMapa + fromIntegral posXJogador * tamanhoChunk
               posY = getInitialY tamanhoJanela + (7-fromIntegral posYJogador) * tamanhoChunk
        
        desenhaPontuacaoAtual :: Int -> Int -> Int -> Picture
        desenhaPontuacaoAtual larguraMapa tamanhoJanela score = Translate posX posY $ Scale 0.5 0.5 $ Color white $ Text $ show score ++ " Pontos"
          where posX = getInitialX larguraMapa + fromIntegral larguraMapa * tamanhoChunk - (tamanhoChunk / 2 - 20)
                posY = getInitialY tamanhoJanela - 20
                -- 20 is the padding for text
 