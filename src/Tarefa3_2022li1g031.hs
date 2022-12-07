{- |
Module      : Tarefa3_2022li1g031
Description : Movimentação do personagem e obstáculos
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2022/23.
-}
module Tarefa3_2022li1g031 where

import LI12223

{- |A função estendeMapa usa duas outras funções auxiliares:
  * proximosTerrenosValidos
  * proximosObstaculosValidos

A função anima jogo movimenta os obst aculos (de acordo com a velocidade) do terreno em
que se encontram), e o personagem, de acordo com a jogada dada (Cima,Baixo,Esquerda,Direita,Parado), e tendo em conta as seguintes restrições: 
(De relembrar que, quando o jogador se move horizontalmente, apenas a coordenada em X sofre alterações, e verticalmente, tanto o X como o Y podem sofrer alterações)
1-Numa estrada ou rio com velocidade v, os obst+aculos devem mover-se
|v| unidades na direção determinada.
2- As jogadas Move Cima, Move Baixo, etc. fazem com que o jogador se
mova 1 unidade para cima, baixo, etc, respectivamente.
3- Mesmo quando o jogador não efectua qualquer movimento (i.e. a sua
jogada  ́e Parado), se o personagem se encontrar em cima de um tronco,
o jogador acompanha o movimento tronco.
4- O jogador não consegue escapar do mapa através dos seus movimentos.
Por exemplo, se o jogador se encontrar na linha de topo do mapa,
então mover-se para cima não tem qualquer efeito, uma vez que já se
encontra no limite do mapa.
5- Ao deslocar os obstáculos de uma linha, estes , assim que
desaparecerem por um dos lados do mapa, devem reaparecer no lado
oposto.

 Para tal , foram criadas 5 funções auxiliares, de modo a tornar o processo mais simples.


== Exemplos de utilização:
>>> animaJogo  (Jogo (Jogador (0,0) (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Tronco,Tronco]), (Estrada 2, [Nenhum,Carro,Carro,Nenhum,Carro])])))  (Move Baixo)
(Jogo (Jogador (0,1) (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Tronco,Tronco]), (Estrada 2, [Nenhum,Carro,Nenhum,Carro,Carro])])))  (Move Baixo)

-}


animaJogo :: Jogo -> Jogada -> Jogo
animaJogo jogo Parado = auxiliarParado jogo
animaJogo jogo (Move Cima) = auxiliarCima jogo
animaJogo jogo (Move Baixo) = auxiliarBaixo jogo
animaJogo jogo (Move Esquerda) = auxiliarEsquerda jogo
animaJogo jogo (Move Direita) = auxiliarDireita jogo

{- | Auxiliar Direita

 @
 auxiliarDireita (Jogo (Jogador (x,y)) (Mapa l linhamapa)) 
 | x+1<l && (emArvoreDireita (x,y) (linhamapa)) == False =auxiliarParado  (Jogo (Jogador (x+1,y)) (Mapa l  ( linhamapa)))
 | x-1<l && (emArvoreDireita (x,y) (linhamapa)) == True = auxiliarParado  (Jogo (Jogador (x,y)) (Mapa l  ( linhamapa)))
 | otherwise = auxiliarParado  (Jogo (Jogador (x ,y)) (Mapa l  (  linhamapa)))
 @
-}

auxiliarDireita :: Jogo-> Jogo
auxiliarDireita (Jogo (Jogador (x,y)) (Mapa l linhamapa))
 | x+1<l && not (emArvoreDireita (x,y) linhamapa) =auxiliarParado  (Jogo (Jogador (x+1,y)) (Mapa l  linhamapa))
 | otherwise = auxiliarParado  (Jogo (Jogador (x ,y)) (Mapa l  linhamapa))


{- | Auxiliar Esquerda

@
auxiliarEsquerda (Jogo (Jogador (x,y)) (Mapa l linhamapa)) 
 | x-1>=0 && (emArvoreEsquerda (x,y) (linhamapa)) == False =auxiliarParado  (Jogo (Jogador (x-1,y)) (Mapa l  ( linhamapa)))
 | x-1>=0 && (emArvoreEsquerda (x,y) (linhamapa)) == True = auxiliarParado  (Jogo (Jogador (x,y)) (Mapa l  ( linhamapa)))
 | otherwise = auxiliarParado  (Jogo (Jogador (x,y)) (Mapa l  ( linhamapa)))
@
-}


auxiliarEsquerda :: Jogo-> Jogo
auxiliarEsquerda (Jogo (Jogador (x,y)) (Mapa l linhamapa))
 | x-1>=0 && not (emArvoreEsquerda (x,y) linhamapa) =auxiliarParado  (Jogo (Jogador (x-1,y)) (Mapa l  linhamapa))
 | otherwise = auxiliarParado  (Jogo (Jogador (x,y)) (Mapa l  linhamapa))
{- | Auxiliar Baixo
@ 
auxiliarBaixo (Jogo (Jogador (x,y)) (Mapa l linhamapa)) 
 | y+1 < l &&  emArvoreBaixo (x,y) (linhamapa) == True = auxiliarParado (Jogo (Jogador (x,y)) (Mapa l linhamapa) )
 | y+1< l  = (Jogo (Jogador (x,y+1)) (Mapa l (moveObstaculos linhamapa))) 
 | otherwise =  auxiliarParado (Jogo (Jogador (x,(y))) (Mapa l  ( linhamapa)))

@
-}

auxiliarBaixo :: Jogo -> Jogo
auxiliarBaixo (Jogo (Jogador (x,y)) (Mapa l linhamapa))
 | y+1 < l &&  not (emArvoreBaixo (x,y) linhamapa) = auxiliarParado (Jogo (Jogador (x,y+1)) (Mapa l linhamapa))
 | otherwise =  auxiliarParado (Jogo (Jogador (x,y)) (Mapa l linhamapa))

{- | Auxiliar Cima

@ 
auxiliarCima (Jogo (Jogador (x,y)) (Mapa l linhamapa) ) 
  | y-1>=0 && emArvoreCima (x,y) (linhamapa) == True = auxiliarParado (Jogo (Jogador (x,y)) (Mapa l linhamapa) )
  | y-1>=0 && emArvoreCima (x,y) (linhamapa) == False =  (Jogo (Jogador (x,y-1)) (Mapa l ( moveObstaculos linhamapa)) )
  | otherwise = auxiliarParado (Jogo (Jogador (x,y)) (Mapa l  ( linhamapa)))

@

-}
auxiliarCima :: Jogo -> Jogo
auxiliarCima (Jogo (Jogador (x,y)) (Mapa l linhamapa) )
  | y-1>=0 && not (emArvoreCima (x,y) linhamapa) = auxiliarParado (Jogo (Jogador (x,y-1)) (Mapa l linhamapa))
  | otherwise = auxiliarParado (Jogo (Jogador (x,y)) (Mapa l linhamapa))


{- | Auxiliar Parado

@  
auxiliarParado (Jogo  (Jogador (x,y) ) (Mapa l a) ) 
  | emTronco (x,y) (a)  == False = (Jogo  (Jogador (x,y) ) (Mapa l  (moveObstaculos a) ))
  | otherwise =  (Jogo  (Jogador (moveComTronco (x,y)( Mapa l a))) ) (Mapa l  (moveObstaculos a) )
@
-}

auxiliarParado :: Jogo ->  Jogo
auxiliarParado (Jogo  (Jogador pos) (Mapa l linhasDoMapa) )
  | emTronco pos linhasDoMapa = Jogo (Jogador (moveComTronco pos ( Mapa l linhasDoMapa))) (Mapa l  (moveObstaculos pos 0 linhasDoMapa) )
  | otherwise = Jogo (Jogador pos ) (Mapa l (moveObstaculos pos 0 linhasDoMapa) )



{- |A função emTronco, foi criada de modo a detectar a presença de Troncos na mesma posição do Jogador. Recebendo uma Coordenada e a lista de terrenos e obstaculos,verifica se, numa dada posição, existe algum Tronco.
Esta função é util principalmente nos casos em que o jogador ou está Parado, ou se move e está em cima de um Tronco (soma vetorial de velocidades)


== Exemplo de utilização:
>>> emTronco (3,0) [(Rio 3 , [Nenhum,Nenhum,Nenhum,Tronco,Nenhum,Nenhum]),(Relva, [Nenhum,Arvore,Arvore,Nenhum,Nenhum,Nenhum]))]
False
-}
emTronco :: Coordenadas -> [LinhaDoMapa] -> Bool
emTronco (x,y) linhamapa
 | ( snd (linhamapa !! y) !! x ) == Tronco = True
 | otherwise= False

{- |A função moveComTronco foi construida para auxiliar na movimentação de um jogador quando este se encontra em cima de um Tronco com uma determinada velocidade. Assim, o jogador ou sai do mapa devido ao movimento do tronco (perdendo assim o jogo) ou então desloca-se até
um ponto espeficio, dependendo da direção escolhida. 


==Exemplo de utilização:
>>> moveComTronco (3,0) ( Mapa 6 [(Rio 3 , [Nenhum,Nenhum,Nenhum,Tronco,Nenhum,Nenhum]),(Relva, [Nenhum,Arvore,Arvore,Nenhum,Nenhum,Nenhum]))])
(6,0) - ou seja, devido ao facto de o Tronco se ter deslocado 3 unidades para a direita, o jogador sai do mapa, perdendo assim o jogo.
-}
moveComTronco :: Coordenadas -> Mapa -> Coordenadas
moveComTronco (x,y) (Mapa l linhamapa)
  | velocidade > 0 && x+velocidade>=l = (l,y)
  | velocidade <0 && x+velocidade <0 = (-1,y)
  | velocidade>0 && x+velocidade<l = (x+velocidade,y)
  | otherwise = (x+velocidade,y)
  where
      (Rio velocidade, obstaculos) = linhamapa !! y

{- |As funções definidas de seguida, (emArvoreDireita, emArvoreEsquerda,emArvoreCima,emArvoreBaixo) foram construidas para determinar a presença de arvores nas direções determinadas pelo jogador.  
Assim, apesar de possivelmente as funções poderem ser definidas todas numa, foram divididas em 4 de modo a tornar o processo mais simples e percetivel a todos. (Futuramente estas funções poderão vir a sofrer alterações, em contexto de melhoramento de desempenho.)


@

emArvoreDireita :: Coordenadas -> [LinhaDoMapa]-> Bool 
emArvoreDireita (x,y) ( linhamapa)
 | ( snd(linhamapa !! (y)) !! (x+1) ) == Arvore = True 
 | otherwise= False 

emArvoreEsquerda :: Coordenadas -> [LinhaDoMapa]-> Bool 
emArvoreEsquerda (x,y) ( linhamapa)
 | ( snd(linhamapa !! (y)) !! (x-1) ) == Arvore = True 
 | otherwise= False 

emArvoreCima :: Coordenadas -> [LinhaDoMapa] -> Bool 
emArvoreCima (x,y) ( linhamapa)
 | ( snd(linhamapa !! (y-1)) !! x ) == Arvore = True 
 | otherwise= False 

emArvoreBaixo :: Coordenadas -> [LinhaDoMapa]-> Bool
emArvoreBaixo (x,y) ( linhamapa)
 | ( snd(linhamapa !! (y+1)) !! x ) == Arvore = True 
 | otherwise= False 



@
-}
emArvoreDireita :: Coordenadas -> [LinhaDoMapa]-> Bool
emArvoreDireita (x,y) linhamapa
 | ( snd (linhamapa !! y) !! (x+1) ) == Arvore = True
 | otherwise= False

emArvoreEsquerda :: Coordenadas -> [LinhaDoMapa]-> Bool
emArvoreEsquerda (x,y) linhamapa
 | ( snd (linhamapa !! y) !! (x-1) ) == Arvore = True
 | otherwise= False

emArvoreCima :: Coordenadas -> [LinhaDoMapa] -> Bool
emArvoreCima (x,y) linhamapa
 | ( snd (linhamapa !! (y-1)) !! x ) == Arvore = True
 | otherwise= False

emArvoreBaixo :: Coordenadas -> [LinhaDoMapa]-> Bool
emArvoreBaixo (x,y) linhamapa
 | ( snd (linhamapa !! (y+1)) !! x ) == Arvore = True
 | otherwise= False


{- |A função moveObstaculos é utilizada para , consoante a velocidade de cada Terreno, conseguir alterar a posição dos elementos (possiveis de serem movimentados) ao longo da lista.  

@
moveObstaculos :: [LinhaDoMapa]-> [LinhaDoMapa]
moveObstaculos [] = [] 
moveObstaculos ((Rio velocidade, obstaculos ):t)
    | velocidade>0 =  (Rio velocidade , rotateRight velocidade (obstaculos)) : moveObstaculos t 
    | otherwise = (Rio velocidade , rotateLeft  (abs velocidade) (obstaculos)) : moveObstaculos t 
moveObstaculos ((Estrada  velocidade, obstaculos ):t)
    |  velocidade>0 =  (Estrada velocidade , rotateRight velocidade (obstaculos)) : moveObstaculos t 
    | otherwise = (Estrada  velocidade , rotateLeft  (abs velocidade) obstaculos) : moveObstaculos t 

moveObstaculos (x:t) = x : moveObstaculos t  
@

==Exemplo de utilização 
>>> moveObstaculos [(Rio 2 , [Nenhum,Tronco,Tronco,Nenhum,Nenhum]), [(Estrada (-1) , [Carro, Nenhum,Carro,Carro,Nenhum])]
[(Rio 2,[Nenhum,Nenhum,Nenhum,Tronco,Tronco]),(Estrada (-1),[Nenhum,Carro,Carro,Nenhum,Carro])]

-}

moveObstaculos :: Coordenadas -> Int ->[LinhaDoMapa]-> [LinhaDoMapa]
moveObstaculos _ _  [] = []
moveObstaculos pos currentLine ((Rio velocidade, obstaculos) : t)
    | velocidade > 0 =  (Rio velocidade , rotateRight pos currentLine velocidade obstaculos) : moveObstaculos pos (currentLine + 1) t
    | otherwise = (Rio velocidade , rotateLeft pos currentLine(abs velocidade) obstaculos) : moveObstaculos pos (currentLine + 1) t
moveObstaculos pos currentLine ((Estrada  velocidade, obstaculos ):t)
    |  velocidade>0 =  (Estrada velocidade , rotateRight pos currentLine velocidade obstaculos) : moveObstaculos pos (currentLine + 1) t
    | otherwise = (Estrada  velocidade , rotateLeft pos currentLine (abs velocidade) obstaculos) : moveObstaculos pos (currentLine + 1) t

moveObstaculos pos currentLine (h:t) = h : moveObstaculos pos (currentLine + 1) t

{- |A função rotateRight foi criada de modo a auxiliar a função moveObstaculos, de modo a dar "shift" aos elementos da lista n posições para a direita, consoante a velocidade.

@
rotateRight :: Int->[Obstaculo]-> [Obstaculo]
rotateRight _  [] = []
rotateRight 0 obstaculos = obstaculos 
rotateRight velocidade (x:xs) = rotateRight  (velocidade-1) ([last xs]++[x] ++ init xs)
@

==Exemplo de utilização 
>>> rotateRight 3 [Nenhum,Carro,Carro,Nenhum,Nenhum,Nenhum,Carro]
[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum]

-}
rotateRight :: Coordenadas -> Int -> Int -> [Obstaculo] -> [Obstaculo]
rotateRight _ _ _ [] = []
rotateRight _ _ 0 obstaculos = obstaculos
rotateRight pos@(posX, posY) currentLine velocidade obstaculos 
  | newObstaculos !! posX == Carro && posY == currentLine = newObstaculos
  | otherwise = rotateRight pos currentLine (velocidade - 1) newObstaculos
 where newObstaculos = last obstaculos : init obstaculos


{- |A função rotateLeft foi criada de modo a auxiliar a função moveObstaculos, de modo a dar "shift" aos elementos da lista n posições para a esquerda, consoante a velocidade.

@
rotateLeft _ [] = [] 
rotateLeft 0 obstaculos = obstaculos
rotateLeft  velocidade (x:xs) = rotateLeft ( velocidade-1) (xs ++ [x])
@

==Exemplo de utilização 

>>> rotateLeft 2 [Nenhum,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco]

[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco]
-}

rotateLeft :: Coordenadas -> Int-> Int -> [Obstaculo]-> [Obstaculo]
rotateLeft _ _ _ [] = []
rotateLeft _ _ 0 obstaculos = obstaculos
rotateLeft  pos@(posX, posY) currentLine velocidade obstaculos@(x:xs)  
 | newObstaculos !! posX == Carro && posY == currentLine = newObstaculos
 | otherwise = rotateLeft pos currentLine (velocidade - 1) newObstaculos
  where newObstaculos = xs ++ [x]
