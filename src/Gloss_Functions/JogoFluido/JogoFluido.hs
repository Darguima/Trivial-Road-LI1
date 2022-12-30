module Gloss_Functions.JogoFluido.JogoFluido where
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
