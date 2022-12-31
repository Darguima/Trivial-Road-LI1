{- |
Module      : Gloss_Functions.JogoFluido.DesenhaJogoFluido
Description : Função auxiliar da `desenhaEstadoJogo` para criar efeito de fluidez
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.JogoFluido.DesenhaJogoFluido where
import LI12223 ( LinhaDoMapa, Coordenadas, Obstaculo(Carro, Tronco), Terreno(Rio, Relva), Mapa(..), Jogador(Jogador), Jogo(..) )
import Gloss_Functions.GlossData ( fr, tamanhoChunk, larguraMapa )
import Graphics.Gloss ( Picture(Translate) )
import Utils.Utils (extrairVelocidade)

{- | A função desenhaLinhaFluida, traz fluidez horizontal ao jogo. Esta função deve ser chamada ao resultado da `desenharLinha`,
  auxiliar da `Gloss_Functions.ReageTempo.ReageTempoJogo.desenhaEstadoJogo`

  Esta função vai chamar as auxiliares `adicionarChunksRepetidos` e a `moverLinha` para ao longo do segundo (ou, em principio, dos 60 frames),
    moverem horizontalmente os obstáculos.
-}

desenhaLinhaFluida :: [Picture] -> Terreno -> Int -> Float -> [Picture]
desenhaLinhaFluida linhaMapaDesenhada Relva frameAtual xInicial = linhaMapaDesenhada
desenhaLinhaFluida linhaMapaDesenhada terreno frameAtual xInicial = linhaFluida

  where velocidade = extrairVelocidade terreno

        linhaComChunksRepetidos = adicionarChunksRepetidos linhaMapaDesenhada velocidade
        linhaFluida = moverLinha linhaComChunksRepetidos velocidade frameAtual xInicial

{- | A função adicionarChunksRepetidos, vai adicionar ao início e fim da linha original os exatos chunks que estão na outra extremidade.
  O número de chunks adicionados em cada lado é igual à velocidade.

  Isto é necessário pois ao criar o efeito de deslize é preciso que haja algo no fim da linha para ser mostrado, ou seja, se a linha tem 8 de largura, 
    são necessários 9 chunks (com velocidade = 1).

  São adicionados de ambos os lado pois inicialmente a linha começa com um deslocamento contrário ao do movimento
-}

adicionarChunksRepetidos :: [Picture] -> Int -> [Picture]
adicionarChunksRepetidos linhaMapaDesenhada velocidade
  = map (Translate (-tamanhoChunk * fromIntegral larguraMapa) 0) (takeR (abs velocidade) linhaMapaDesenhada) ++ linhaMapaDesenhada ++ map (Translate (tamanhoChunk * fromIntegral larguraMapa) 0) (take (abs velocidade) linhaMapaDesenhada)
  where takeR n l = reverse $ take n $ reverse l

{- | A função moverLinha, vai criar uma translação em toda a linha calculada através do número do frame atual.
  Para além disso precisa de compensar o trabalho da `Gloss_Functions.JogoFluido.AnimaMapaFluido.animaMapaFluido` que avança os
    obstáculos ao longo do segundo (em princípio, ao longo dos 60 frames). Ambas os cálculos são feitos com estas contas:

    @
    deslocamento = (fromIntegral frameAtual * fromIntegral velocidade * tamanhoChunk) / fromIntegral fr + ((tamanhoChunk / 2)  * if velocidade > 0 then -1 else 1)
    -- Este cálculo gera valores entre -50 e + (50, 150, 250, 350, ...)
    -- é o número de pixeis que o obstaculo teria que percorrer desde o início do segundo
    compensacao = fromIntegral (div (frameAtual - 1) (div fr (abs velocidade))) * tamanhoChunk * if velocidade > 0 then -1 else 1
    -- Este cálculo gera valores múltiplos do tamanhoChunk. É a distância que entretanto já foi percorrida pelo obstáculo
    -- quando a `animaMapaFluido` o moveu uma casa@
-}

moverLinha :: [Picture] -> Int -> Int -> Float -> [Picture]
moverLinha linhaMapaDesenhada velocidade frameAtual xInicial = map (Translate (deslocamento + compensacao)  0) linhaMapaDesenhada
  where deslocamento = (fromIntegral frameAtual * fromIntegral velocidade * tamanhoChunk) / fromIntegral fr + ((tamanhoChunk / 2)  * if velocidade > 0 then -1 else 1)
        -- Este cálculo gera valores entre -50 e + (50, 150, 250, 350, ...)
        -- é o número de pixeis que o obstaculo teria que percorrer desde o início do segundo
        compensacao = fromIntegral (div (frameAtual - 1) (div fr (abs velocidade))) * tamanhoChunk * if velocidade > 0 then -1 else 1
        -- Este cálculo gera valores múltiplos do tamanhoChunk. É a distância que entretanto já foi percorrida pelo obstáculo
        -- quando a `animaMapaFluido` o moveu uma casa

{- | A função deslizaMapaFluido, vai criar uma translação vertical seguindo o mesmo princípio da `moverLinha`.
  O cálculo feito é:

  @deslocamento = -tamanhoChunk * (fromIntegral frameAtual / fromIntegral fr)@
-}

deslizaMapaFluido :: [Picture] -> Int -> [Picture]
deslizaMapaFluido mapa frameAtual = map (Translate 0 deslocamento) mapa
  where deslocamento = -tamanhoChunk * (fromIntegral frameAtual / fromIntegral fr)
