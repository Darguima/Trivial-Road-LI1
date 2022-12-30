module Gloss_Functions.JogoFluido.AnimaMapaFluido where

import LI12223 ( Coordenadas, Jogador(Jogador), Jogo(..), LinhaDoMapa, Mapa(..), Obstaculo(Tronco) )
import Gloss_Functions.GlossData ( fr )
import Utils.Utils (extrairVelocidade)

animaMapaFluido :: Jogo -> Int -> Jogo
animaMapaFluido (Jogo (Jogador pos@(_, posY)) (Mapa l linhasDoMapa)) frameAtual
  = Jogo (Jogador novaPos) (Mapa l novosObstaculos)
  where velocidadeLinhaAtual = extrairVelocidade (fst(linhasDoMapa !! posY))

        alterarPosicaoJogador = emTronco pos linhasDoMapa && atuarNesteFrame frameAtual velocidadeLinhaAtual
        novaPos = if alterarPosicaoJogador then moveComTronco pos (Mapa l linhasDoMapa) else pos

        novosObstaculos = moveObstaculos pos 0 frameAtual linhasDoMapa

emTronco :: Coordenadas -> [LinhaDoMapa] -> Bool
emTronco (x,y) linhasDoMapa = ( snd (linhasDoMapa !! y) !! x ) == Tronco

moveComTronco :: Coordenadas -> Mapa -> Coordenadas
moveComTronco (x,y) (Mapa l linhasDoMapa) = (x + sentidoMovimento, y)
  where velocidade = extrairVelocidade $ fst (linhasDoMapa !! y)
        sentidoMovimento = if velocidade > 0 then 1 else -1

moveObstaculos :: Coordenadas -> Int -> Int -> [LinhaDoMapa] -> [LinhaDoMapa]
moveObstaculos _ _ _ [] = []
moveObstaculos pos linhaAtual frameAtual ((terreno, obstaculos) : restantesLinhasMapa)
  = (terreno, novosObstaculos) : moveObstaculos pos (linhaAtual + 1) frameAtual restantesLinhasMapa
    where velocidade = extrairVelocidade terreno
          sentidoDoMovimento = if velocidade > 0 then 1 else -1

          novosObstaculos = if atuarNesteFrame frameAtual velocidade
              then rotate pos linhaAtual sentidoDoMovimento obstaculos
              else obstaculos

rotate :: Coordenadas -> Int -> Int -> [Obstaculo] -> [Obstaculo]
rotate _ _ _ [] = []
rotate pos@(posX, posY) linhaAtual sentidoDoMovimento obstaculos@(x:xs)
  | sentidoDoMovimento == 1 = last obstaculos : init obstaculos
  | sentidoDoMovimento == -1 = xs ++ [x]

atuarNesteFrame :: Int -> Int -> Bool
atuarNesteFrame frameAtual 0 = False
atuarNesteFrame frameAtual velocidade = mod frameAtual (div fr velocidade) == 0
