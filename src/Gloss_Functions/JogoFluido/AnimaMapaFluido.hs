{- |
Module      : Gloss_Functions.JogoFluido.AnimaMapaFluido
Description : Função alternativa à `animaMapa` com efeito de fluidez
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.JogoFluido.AnimaMapaFluido where

import LI12223 ( Coordenadas, Jogador(Jogador), Jogo(..), LinhaDoMapa, Mapa(..), Obstaculo(Tronco) )
import Gloss_Functions.GlossData ( fr )
import Utils.Utils (extrairVelocidade)

{- | Função animaMapaFluido, com a ideia da `Tarefa3_2022li1g031.animaMapa` mas com efeito de fluidez.
  
  Para isso a posição do jogador quando está em cima de um tronco é atualizada chunk por chunk (ao invés de segundo a segundo), ou seja
    o jogador não é "teletransportado" 2 ou mais casas de uma só vez na posição x.
  
  E os obstáculos também têm as suas posições atualizadas com a mesma lógica - a sua posição no eixo do x é atualizada 1 a 1.

  Esta fluidez previne que juntamente com a `Gloss_Functions.JogoFluido.desenhaLinhaFluida` haja a sensação que o jogador perde em tempo real,
    ou seja, com um contacto "real" do carro
  
  Todos estes cálculos são feito com a função auxiliar `atuarNesteFrame`
-}

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

{- | Função atuarNesteFrame, diz à `animaMapaFluido` quando esta deve atuar.
  Por exemplo um jogo a 60fps, num rio/estrada com velocidade:
    1. seria a cada 60 frames
    2. seria a cada 30 frames
    3. seria a cada 20 frames
  
  Assim cada linha sabe quando tem que avançar os seus obstáculos.
  Esta conta é feita através do cálculo:

  @
  atuarNesteFrame frameAtual 0 = False -- nunca atua na relva
  atuarNesteFrame frameAtual velocidade = mod frameAtual (div fr velocidade) == 0
@ 
-}

atuarNesteFrame :: Int -> Int -> Bool
atuarNesteFrame frameAtual 0 = False
atuarNesteFrame frameAtual velocidade = mod frameAtual (div fr velocidade) == 0
