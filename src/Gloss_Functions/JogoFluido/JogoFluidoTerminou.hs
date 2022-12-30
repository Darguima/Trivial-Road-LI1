module Gloss_Functions.JogoFluido.JogoFluidoTerminou where
import LI12223 ( Jogador(Jogador), Jogo(..), Mapa(Mapa), Obstaculo(Carro, Nenhum), Terreno(Estrada, Rio) )
import Gloss_Functions.GlossData (fr)

jogoFluidoTerminou :: Jogo -> Bool -> Int -> Bool
jogoFluidoTerminou (Jogo (Jogador (posX, posY)) (Mapa largura linhasMapa)) changeGameStatus frameAtual
  | changeGameStatus || metadeDoFrameRate = saiuLimitesX ||  saiuLimitesY || auxObstaculos terrenoLinhaAtual (obstaculosLinhaAtual !! posX) 
  | otherwise = False

  where (terrenoLinhaAtual, obstaculosLinhaAtual) = linhasMapa !! posY
        metadeDoFrameRate = frameAtual == div fr 2
        
        saiuLimitesX = posX < 0 || largura <= posX
        saiuLimitesY = posY < 0 || (metadeDoFrameRate && largura <= posY)

        auxObstaculos :: Terreno -> Obstaculo -> Bool
        auxObstaculos (Rio _) Nenhum = True
        auxObstaculos (Estrada _) Carro = True
        auxObstaculos _ _ = False
