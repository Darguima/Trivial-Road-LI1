module Gloss_Functions.JogoFluido.DesenhaJogoFluido where
import LI12223 ( LinhaDoMapa, Coordenadas, Obstaculo(Carro, Tronco), Terreno(Rio, Relva), Mapa(..), Jogador(Jogador), Jogo(..) )
import Gloss_Functions.GlossData ( fr, tamanhoChunk, larguraMapa )
import Graphics.Gloss ( Picture(Translate) )
import Utils.Utils (extrairVelocidade)

deslocamentoInicial :: [Picture] -> Int -> [Picture]
deslocamentoInicial linhaMapaDesenhada velocidade = linhaMapaDesenhada

adicionarChunksRepetidos :: [Picture] -> Int -> [Picture]
adicionarChunksRepetidos linhaMapaDesenhada velocidade
  = map (Translate (-tamanhoChunk * fromIntegral larguraMapa) 0) (takeR (abs velocidade) linhaMapaDesenhada) ++ linhaMapaDesenhada ++ map (Translate (tamanhoChunk * fromIntegral larguraMapa) 0) (take (abs velocidade) linhaMapaDesenhada)
  where takeR n l = reverse $ take n $ reverse l

moverLinha :: [Picture] -> Int -> Int -> Float -> [Picture]
moverLinha linhaMapaDesenhada velocidade frameAtual xInicial = map (Translate (deslocamento + compensacao)  0) linhaMapaDesenhada
  where deslocamento = (fromIntegral frameAtual * fromIntegral velocidade * tamanhoChunk) / fromIntegral fr + ((tamanhoChunk / 2)  * if velocidade > 0 then -1 else 1)
        -- Este cálculo gera valores entre -50 e + (50, 150, 250, 350, ...)
        -- é o número de pixeis que o obstaculo teria que percorrer desde o início do segundo
        compensacao = fromIntegral (div (frameAtual - 1) (div fr (abs velocidade))) * tamanhoChunk * if velocidade > 0 then -1 else 1
        -- Este cálculo gera valores múltiplos do tamanhoChunk. É a distância que entretanto já foi percorrida pelo obstáculo
        -- quando a `animaMapaFluido` o moveu uma casa

desenhaLinhaFluida :: [Picture] -> Terreno -> Int -> Float -> [Picture]
desenhaLinhaFluida linhaMapaDesenhada Relva frameAtual xInicial = linhaMapaDesenhada
desenhaLinhaFluida linhaMapaDesenhada terreno frameAtual xInicial = linhaFluida

  where velocidade = extrairVelocidade terreno

        linhaComChunksRepetidos = adicionarChunksRepetidos linhaMapaDesenhada velocidade
        linhaFluida = moverLinha linhaComChunksRepetidos velocidade frameAtual xInicial

deslizaMapaFluido :: [Picture] -> Int -> [Picture]
deslizaMapaFluido mapa frameAtual = map (Translate 0 deslocamento) mapa
  where deslocamento = -tamanhoChunk * (fromIntegral frameAtual / fromIntegral fr)
