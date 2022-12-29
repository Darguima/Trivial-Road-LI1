module Gloss_Functions.JogoFluido.JogoFluido where
import LI12223 ( LinhaDoMapa, Terreno(..) )
import Gloss_Functions.GlossData ( fr, tamanhoChunk, larguraMapa )
import Graphics.Gloss ( Picture(Translate) )
import Utils.Utils (extrairVelocidade)

--         --   | velocity > 0 = (Estrada velocity, takeR velocity linha ++ linha)
--         --   | otherwise = (Estrada velocity, linha ++ take (abs velocity) linha)

--         takeR n l = reverse $ take n $ reverse l

deslocamentoInicial :: [Picture] -> Int -> [Picture]
deslocamentoInicial linhaMapaDesenhada velocidade
  | velocidade > 0 = linhaMapaDesenhada
  | otherwise = linhaMapaDesenhada

adicionarChunksRepetidos :: [Picture] -> Int -> [Picture]
adicionarChunksRepetidos linhaMapaDesenhada velocidade
  | velocidade > 0 = linhaMapaDesenhada
  | otherwise = linhaMapaDesenhada

moverLinha :: [Picture] -> Int -> Int -> Float -> [Picture]
moverLinha linhaMapaDesenhada velocidade frameAtual xInicial = map (Translate deslocamento 0) linhaMapaDesenhada
  where deslocamento = (fromIntegral frameAtual * fromIntegral velocidade * tamanhoChunk) / fromIntegral fr + ((tamanhoChunk / 2) * if velocidade > 0 then -1 else 1)
  -- Este cálculo gera valores entre -50 e + (50, 150, 250, 350, ...)

desenhaLinhaFluida :: [Picture] -> Terreno -> Int -> Float -> [Picture]
desenhaLinhaFluida linhaMapaDesenhada terreno frameAtual xInicial =
  let velocidade = extrairVelocidade terreno
      linha1 = deslocamentoInicial linhaMapaDesenhada velocidade 
      linha2 = adicionarChunksRepetidos linha1 velocidade
      linhaFluida = moverLinha linha2 velocidade frameAtual xInicial in
      linhaFluida