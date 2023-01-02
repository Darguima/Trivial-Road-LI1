{- |
Module      :Bot 
Description : Funções que alteram a posição de um bot, consoante o estado do mapa. (A função nao consegue obter todos os estados possiveis da disposicao dos objetos do mapa e por isso mesmo apresenta pequenos erros que podem levar ao crash do jogo.)
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Bot where



import LI12223
import Gloss_Functions.GlossData 
import Tarefa3_2022li1g031 (animaJogador)
import Tarefa4_2022li1g031 (jogoTerminou)
import Gloss_Functions.ReageEventos.ReageEventoJogo (novaPontuacaoAtual)
import Data.List (group)

{- |Esta é a funcão principal por todas as alterações feitas ao bot, tendo em conta alguma das situações:

1. Se o player está no fim do mapa ou no inicio, obrigando o a deslocar se de uma certa forma
2. O player pode mexer se na diagonal
3. Se o player se deparar com um rio com apenas um tronco, irá tentar alcancar esse tronco atraves de vários movimentos sucessivos ao longo de 1 segundo 
4. O player estando acima do limite do mapa, poderá mexer-se ou para a esquerda , direita , cima ou baixo, consoante o estado do mapa atual 
A função pode conter alguns erros, devido á forma aleatória como todo o mapa é gerado.


-}

moveBot :: Estado -> Estado
moveBot  jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos) 
 | x< 0 = moveBot ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | x>= largura = moveBot ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 |  nextIsRio (x, y) linhas && rioCountTroncos (getObstaculosRio (linhas !!(y-1))) == 1  =  moveBot ((Jogo (Jogador (getX 0 (getObstaculosRio (linhas !! (y-1))), y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos) 
 |  nextIsRio (x, y) linhas && rioCountTroncos (getObstaculosRio (linhas !!(y-1))) == 2 =  moveBot ((Jogo (Jogador (getX 0 (getObstaculosRio (linhas !! (y-1))), y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos) 
 | y == 0  = moveBot ((Jogo (Jogador (x, y+1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos) 
 | emRio (x,y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) >0 = moveBot ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | emRio (x,y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) <0 = moveBot ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | y == (largura -1 ) && nextIsRelva (x, y) linhas = if safeXBothSides x  largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | y == (largura-1) && nextIsEstrada (x, y) linhas = if safeXBothSides x largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | y == (largura-1 ) && nextIsRio (x, y) linhas  && sairdomapaRio (x,y-1) largura linhas && getVelocidadeRio (linhas !! (y-1) ) >0 = moveBot ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | y == (largura-1) && nextIsRio (x, y) linhas  = if safeXBothSides x largura then findSafeMoveRiverBoth jogo else if onlySafeLeftSide x largura then findSafeMoveRiverLeft jogo else findSafeMoveRiverRight jogo 
 | y == (largura-1) && nextIsRio (x, y) linhas && sairdomapaRio (x, y-1) largura linhas && getVelocidadeRio (linhas !! (y-1)) <0 = moveBot ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | y == (largura-2) && emRelva (x, y) linhas = if safeXBothSides x largura then (if safeLeftandRight (x,y )linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBoth jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBoth jogo else findSafeMoveRiverBoth jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeft jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeft jogo  else findSafeMoveRiverLeft jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRight jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRight jogo else findSafeMoveRiverRight jogo ))
 | y == (largura-2) && emEstrada (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBoth jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBoth jogo else findSafeMoveRiverBoth jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeft jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeft jogo  else findSafeMoveRiverLeft jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRight jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRight jogo else findSafeMoveRiverRight jogo ))
 | y == (largura-2) && emRio (x, y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) >0  = moveBot ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | y == (largura-2) && emRio (x, y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) <0  = moveBot ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)  
 | y == (largura-2) && emRio (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRightTronco (x,y) linhas then moveInFree jogo else if safeLeftTronco (x,y) linhas then moveInLeft jogo else if safeRightTronco (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBoth jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBoth jogo else findSafeMoveRiverBoth jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeftTronco (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeft jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeft jogo  else findSafeMoveRiverLeft jogo )) else (if safeRightTronco (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRight jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRight jogo else findSafeMoveRiverRight jogo ))
 | emRelva (x,y) linhas =  if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))   
 | emEstrada (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))  
 | emRio (x, y) linhas =   if safeXBothSides x largura then (if safeLeftandRightTronco (x,y) linhas then moveInFree jogo else if safeLeftTronco (x,y) linhas then moveInLeft jogo else if safeRightTronco (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeftTronco (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRightTronco (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))
 | nextIsRelva (x, y) linhas = if safeXBothSides x  largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | nextIsEstrada (x, y) linhas = if safeXBothSides x largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | nextIsRio (x, y) linhas = if safeXBothSides x largura then findSafeMoveRiverBoth jogo else if onlySafeLeftSide x largura then findSafeMoveRiverLeft jogo else findSafeMoveRiverRight jogo 
 | emRelva (x,y) linhas  && y> (div largura 2)=  if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))   
 | emEstrada (x,y) linhas && y > (div largura 2 ) =  jogo
 | emRio (x,y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) >0 = moveBot ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | emRio (x,y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) <0 = moveBot ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos) 
 | x>=1 =  moveBot ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)  
 | otherwise =  moveBot ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)  
moveBot  jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | x< 0 = moveBot ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 | x>= largura = moveBot ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,y1)
 | y == (largura -1 ) && nextIsRelva (x, y) linhas = if safeXBothSides x  largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | y == (largura-1) && nextIsEstrada (x, y) linhas = if safeXBothSides x largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | y == (largura-1) && nextIsRio (x, y) linhas = if safeXBothSides x largura then findSafeMoveRiverBoth jogo else if onlySafeLeftSide x largura then findSafeMoveRiverLeft jogo else findSafeMoveRiverRight jogo
 | nextIsRelva (x, y) linhas = if safeXBothSides x  largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | nextIsEstrada (x, y) linhas = if safeXBothSides x largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | nextIsRio (x, y) linhas = if safeXBothSides x largura then findSafeMoveRiverBoth jogo else if onlySafeLeftSide x largura then findSafeMoveRiverLeft jogo else findSafeMoveRiverRight jogo 
 | emRelva (x,y) linhas  && y> (div largura 2)=  if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))   
 | emRelva (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))  
 | emEstrada (x,y) linhas && y > (div largura 2 ) =  jogo
 | emEstrada (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))  
 | emRio (x,y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) >0 = moveBot ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 | emRio (x,y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) <0 = moveBot ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | emRio (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRightTronco (x,y) linhas then moveInFree jogo else if safeLeftTronco (x,y) linhas then moveInLeft jogo else if safeRightTronco (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeftTronco (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRightTronco (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))
 | otherwise = moveBot ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 

 
{- |A função getObstaculosRio é responsavel por obter a lista de obstaculos de um certo Terreno.

-} 
 
  -- verificarr quando ta na posicao 6, para n voltar para tras, e verificar para o resto, podendo ir para cima , para os lados, ou para baixo,intercalando cada um |
getObstaculosRio :: LinhaDoMapa -> [Obstaculo] 
getObstaculosRio (Rio _ , obstaculos) = obstaculos

{- |A função getX é responsável por obter o x em que um Tronco está, para ser usado na função principal


-} 


getX ::Int -> [Obstaculo] -> Int 
getX n [] = n
getX n (x:xs)
 | x == Tronco = n 
 | otherwise = getX (n+1) xs 


{- |A função rioCountTroncos conta o numero de Troncos presentes num rio


-} 

rioCountTroncos :: [Obstaculo] -> Int 
rioCountTroncos [] = 0 
rioCountTroncos (x:xs) = countGroupTroncos  (group (x:xs ))


{- |Função auxiliar á riosCountTroncos


-} 
countGroupTroncos :: [[Obstaculo]] -> Int 
countGroupTroncos  [] = 0 
countGroupTroncos (x:xs)
 | Tronco `elem` x = 1+ countGroupTroncos  xs
 | otherwise = countGroupTroncos xs


{- |A função sairdomapaRio é responsavel por determinar se o jogador sai do rio ou nao, aquando o movimento de um tronco


-} 

sairdomapaRio :: (Int,Int) ->Int-> [LinhaDoMapa] -> Bool 
sairdomapaRio (x, y) largura linhasMapa 
 | x + v <0 || x+v >= (largura-1) = True 
 | otherwise =  False 
 where v = getVelocidadeRio (linhasMapa !! y)


{- |A função getVelocidadeRio é responsável por obter a velocidade de um rio


-} 

getVelocidadeRio :: LinhaDoMapa -> Int 
getVelocidadeRio (Rio v , _) = v 


{- |A função onlySafeLeftSide é responsavel por verificar se o player está no canto direito do mapa 


-} 

onlySafeLeftSide :: Int -> Int-> Bool
onlySafeLeftSide x largura 
 | (x==largura-1) && x>=1 = True 
 |otherwise= False
{- |A função safeXBothSides é responsavel por verificar se o player não está nem no canto direito, nem esquerdo do mapa

-}

safeXBothSides :: Int -> Int -> Bool 
safeXBothSides x largura 
 | (x<largura-1) && x>=1 = True 
 |otherwise = False 


{- |A função safeLeftTonco é responsavel por verificar se o player tem troncos na sua esquerda 


-}

safeLeftTronco :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeLeftTronco (x,y) linhasmapa =  eTronco (x-1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa


{- |A função safeRightTonco é responsavel por verificar se o player tem troncos na sua direita 

-}

safeRightTronco :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeRightTronco (x,y) linhasmapa =  eTronco (x+1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa
{- |A função safeLeftandRightTonco é responsavel por verificar se o player tem troncos na sua esquerda  e na sua direita

-}
safeLeftandRightTronco :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeLeftandRightTronco (x,y) linhasmapa = eTronco (x+1,y) obstaculos  && eTronco (x-1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa
{- |A função safeLeft é responsavel por verificar se o player não tem obstaculos passiveis da derrota na sua esquerda

-}

safeLeft :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeLeft (x,y) linhasmapa =  eNenhum (x-1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa

 {- |A função safeRight é responsavel por verificar se o player não tem obstaculos passiveis da derrota na sua direita

-}



safeRight :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeRight (x,y) linhasmapa =  eNenhum (x+1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa


{- |A função safeLeftandRight é responsavel por verificar se o player não tem obstaculos passiveis da derrota na sua esquerda e na sua direita

-}


safeLeftandRight :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeLeftandRight (x,y) linhasmapa = eNenhum (x+1,y) obstaculos  && eNenhum (x-1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa


{- |A função moveInRight é responsavel por mover o player para a direita num terreno.

-}
moveInRight :: Estado -> Estado
moveInRight jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 

{- |A função moveInLeft é responsavel por mover o player para a esquerda num terreno.

-}
moveInLeft :: Estado -> Estado
moveInLeft jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 


{- |A função moveInFree é responsavel por mover o player para a direita  ou esquerda, num terreno.

-}
moveInFree :: Estado -> Estado
moveInFree jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | x > (div larguraMapa 2) = ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | otherwise = ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 



{- |A função findsafeMoveBothAll é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador, em qualquer direcao 

-}

findSafeMoveBothAll :: Estado-> Estado 
findSafeMoveBothAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  = if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOk (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOk (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if x > (div largura 2) then  moveBot ((Jogo (Jogador (x-1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else moveBot ((Jogo (Jogador (x+1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
{- |A função finssafeMoveLeftAll é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador, na esquerda

-}

findSafeMoveLeftAll :: Estado->Estado 
findSafeMoveLeftAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = if midOk (x,y) linhas then ((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOk (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

{- |A função findsafeMoveRightAll é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador, na direita

-}
findSafeMoveRightAll :: Estado->Estado 
findSafeMoveRightAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) =  if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if rightOk (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

{- |A função findsafeMoveRiverAll é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador, em qualquer direcao , num rio

-}


findSafeMoveRiverBothAll :: Estado-> Estado 
findSafeMoveRiverBothAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else  moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

{- |A função findsafeMoveRiverLeftAll é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador, na esquerda , num rio

-}
findSafeMoveRiverLeftAll :: Estado->Estado 
findSafeMoveRiverLeftAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

{- |A função findsafeMoveRiverRightAll é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador, na direita , num rio

-}
findSafeMoveRiverRightAll :: Estado->Estado 
findSafeMoveRiverRightAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) =  if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)





{- |A função finssafeMoveBoth é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador em todas as direções , pudendo apenas se deslocar para cima

-}

findSafeMoveBoth :: Estado-> Estado 
findSafeMoveBoth jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  = if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOk (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOk (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else    moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 

{- |A função finssafeMoveLeft é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador , para a esquerda , pudendo apenas se deslocar para cima


-}
findSafeMoveLeft :: Estado->Estado 
findSafeMoveLeft jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOk (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

{- |A função finssafeMoveRight é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador , para a direita , pudendo apenas se deslocar para cima

-}
findSafeMoveRight :: Estado->Estado 
findSafeMoveRight jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) =  if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if rightOk (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
{- |A função finssafeMoveRiverBoth é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente do jogador em todas as direções , pudendo apenas se deslocar para cima, num rio

-}


findSafeMoveRiverBoth :: Estado-> Estado 
findSafeMoveRiverBoth jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  
 | x>= 1 && x == largura -1 = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)   else  moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 | otherwise = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

{- |A função finssafeMoveRiverLeft é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente, para a esquerda  , pudendo apenas se deslocar para cima, num rio

-}
findSafeMoveRiverLeft :: Estado->Estado 
findSafeMoveRiverLeft jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | x>= 1 && x == largura-1 = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 | otherwise = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 {- |A função finssafeMoveRiverRight é responsável por verificar os movimentos possiveis tanto na diagonal, como horizontalmente, para a direita  , pudendo apenas se deslocar para cima, num rio

-}
findSafeMoveRiverRight :: Estado->Estado 
findSafeMoveRiverRight jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | x>=1 && x== largura-1 = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 | otherwise = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)


{- |A função rightOk verifica se diagonalmente existe algum obstaculo possivel,na direita

-}


rightOk :: (Int,Int) -> [LinhaDoMapa] -> Bool 
rightOk (x,y) linhasmapa = eNenhum (x+1,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa

{- |A função rightOkRiver verifica se diagonalmente existe algum obstaculo possivel, na direita do rio

-}

rightOkRiver :: (Int,Int) -> [LinhaDoMapa] -> Bool 
rightOkRiver (x,y) linhasmapa = eTronco (x+1,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa



{- |A função midOk verifica se no meio existe algum obstaculo possivel.

-}
midOk :: (Int,Int) -> [LinhaDoMapa] -> Bool 
midOk (x,y) linhasmapa = eNenhum (x,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa


{- |A função midOk verifica se no meio existe algum obstáculo possivel, no rio.

-}

midOkRiver :: (Int,Int) -> [LinhaDoMapa] -> Bool 
midOkRiver (x,y) linhasmapa = eTronco (x,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa



{- |A função leftOk verifica se diagonalmente existe algum obstaculo possive, na esquerda.

-}


leftOk :: (Int,Int) -> [LinhaDoMapa] -> Bool 
leftOk (x, y) linhasmapa = eNenhum (x-1,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa

{- |A função leftOkRiver verifica se diagonalmente existe algum obstaculo possive, na esquerda do rio.

-}
leftOkRiver :: (Int,Int) -> [LinhaDoMapa] -> Bool 
leftOkRiver (x, y) linhasmapa = eTronco (x-1,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa
{- |A função eNenhum verifica se o obstáculo é Nenhum

-}

eNenhum (x, _) lista = lista!!x == Nenhum

{- |A função eTronco verifica se o obstáculo é Tronco

-}
eTronco (x, _) lista = lista!!x == Tronco
{- |A função getObstaculos obtem a lista de obstaculos de um terreno
-}

getObstaculos (x, y) linhas = snd (linhas!!y) 


{- |A função nextIsRelva verifica se o proximo terreno é uma relva
-}


nextIsRelva :: (Int,Int) -> [LinhaDoMapa] -> Bool 
nextIsRelva (x, y) linhas = (fst (linhas !! (y-1))) == Relva

{- |A função nextIsEstrada verifica se o proximo terreno é uma estrada
-}
nextIsEstrada :: (Int,Int) -> [LinhaDoMapa] -> Bool 
nextIsEstrada (x, y) linhas = verificaEstrada ( (linhas !! (y-1)))

{- |A função nextIsRio verifica se o proximo terreno é um Rio.
-}
nextIsRio :: (Int,Int) -> [LinhaDoMapa] -> Bool 
nextIsRio (x, y) linhas = verificaRio ( (linhas !! (y-1)))


{- |A função verificaEstrada é auxiliar da nextIsEstrada
-}

verificaEstrada :: LinhaDoMapa -> Bool 
verificaEstrada (Estrada _ , _) = True
verificaEstrada _ = False
{- |A função verificaRio é auxiliar da nextIsRIo
-}

verificaRio :: LinhaDoMapa -> Bool 
verificaRio (Rio _ , _) = True
verificaRio _ = False
{- |A função emRio verifica se o player está num rio
-}
emRio :: (Int,Int) -> [LinhaDoMapa]-> Bool 
emRio (x,y) linhas = verificaRio (linhas !! y)
{- |A função emEstrada verifica se o player está numa estrada
-}

emEstrada :: (Int,Int) -> [LinhaDoMapa]-> Bool 
emEstrada (x,y) linhas = verificaEstrada (linhas !! y)
{- |A função emRelva verifica se o player está numa Relva.
-}
emRelva :: (Int,Int) -> [LinhaDoMapa] -> Bool 
emRelva (x, y) linhas = (fst (linhas !! y)) == Relva

