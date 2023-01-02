module Bot where
import LI12223
import Gloss_Functions.GlossData 
import Gloss_Functions.ReageEventos.ReageEventoJogo (novaPontuacaoAtual)
import Tarefa3_2022li1g031 (animaJogador)
import Tarefa4_2022li1g031 (jogoTerminou)


moveBot :: Estado -> Estado
moveBot  jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos) 
 | y == 0  = moveBot ((Jogo (Jogador (x, y+1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos) 
 | emRio (x,y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) >0 = moveBot ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | emRio (x,y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) <0 = moveBot ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | y == (largura -1 ) && nextIsRelva (x, y) linhas = if safeXBothSides x  largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | y == (largura-1) && nextIsEstrada (x, y) linhas = if safeXBothSides x largura then findSafeMoveBoth jogo else if onlySafeLeftSide x largura then findSafeMoveLeft jogo else findSafeMoveRight jogo
 | y == (largura-1) && nextIsRio (x, y) linhas = if safeXBothSides x largura then findSafeMoveRiverBoth jogo else if onlySafeLeftSide x largura then findSafeMoveRiverLeft jogo else findSafeMoveRiverRight jogo 
 | y == (largura-2) && emRelva (x, y) linhas = if safeXBothSides x largura then (if safeLeftandRight (x,y )linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBoth jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBoth jogo else findSafeMoveRiverBoth jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeft jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeft jogo  else findSafeMoveRiverLeft jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRight jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRight jogo else findSafeMoveRiverRight jogo ))
 | y == (largura-2) && emEstrada (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBoth jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBoth jogo else findSafeMoveRiverBoth jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeft jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeft jogo  else findSafeMoveRiverLeft jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRight jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRight jogo else findSafeMoveRiverRight jogo ))
 | y == (largura-2) && emRio (x, y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) >0  = moveBot ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)
 | y == (largura-2) && emRio (x, y) linhas && sairdomapaRio (x,y) largura linhas && getVelocidadeRio (linhas !! y ) <0  = moveBot ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)  
 | y == (largura-2) && emRio (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRightTronco (x,y) linhas then moveInFree jogo else if safeLeftTronco (x,y) linhas then moveInLeft jogo else if safeRightTronco (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBoth jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBoth jogo else findSafeMoveRiverBoth jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeftTronco (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeft jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeft jogo  else findSafeMoveRiverLeft jogo )) else (if safeRightTronco (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRight jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRight jogo else findSafeMoveRiverRight jogo ))
 | emRelva (x,y) linhas =  if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))   
 | emEstrada (x,y) linhas = if safeXBothSides x largura then (if safeLeftandRight (x,y) linhas then moveInFree jogo else if safeLeft (x,y) linhas then moveInLeft jogo else if safeRight (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeft (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRight (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))  
 | emRio (x, y) linhas =   if safeXBothSides x largura then (if safeLeftandRightTronco (x,y) linhas then moveInFree jogo else if safeLeftTronco (x,y) linhas then moveInLeft jogo else if safeRightTronco (x,y) linhas  then moveInRight jogo else ( if nextIsRelva (x,y) linhas  then  findSafeMoveBothAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveBothAll jogo else findSafeMoveRiverBothAll jogo)  )  else if onlySafeLeftSide x largura then ( if safeLeftTronco (x,y) linhas then moveInLeft jogo else (if nextIsRelva (x,y) linhas then  findSafeMoveLeftAll jogo else if nextIsEstrada (x,y) linhas then findSafeMoveLeftAll jogo  else findSafeMoveRiverLeftAll jogo )) else (if safeRightTronco (x,y) linhas then moveInRight jogo else ( if nextIsRelva (x,y) linhas then findSafeMoveRightAll jogo else if nextIsEstrada (x, y) linhas then findSafeMoveRightAll jogo else findSafeMoveRiverRightAll jogo ))
 | x>=1 =  moveBot ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)  
 | otherwise =  moveBot ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, 1,ypontos)  
moveBot  jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
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
 

 
 
 
  -- verificarr quando ta na posicao 6, para n voltar para tras, e verificar para o resto, podendo ir para cima , para os lados, ou para baixo,intercalando cada um |


sairdomapaRio :: (Int,Int) ->Int-> [LinhaDoMapa] -> Bool 
sairdomapaRio (x, y) largura linhasMapa 
 | x + v <0 || x+v >= (largura-1) = True 
 | otherwise =  False 
 where v = getVelocidadeRio (linhasMapa !! y)

getVelocidadeRio :: LinhaDoMapa -> Int 
getVelocidadeRio (Rio v , _) = v 

onlySafeLeftSide :: Int -> Int-> Bool
onlySafeLeftSide x largura 
 | (x==largura-1) && x>=1 = True 
 |otherwise= False


safeXBothSides :: Int -> Int -> Bool 
safeXBothSides x largura 
 | (x<largura-1) && x>=1 = True 
 |otherwise = False 

safeLeftTronco :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeLeftTronco (x,y) linhasmapa =  eTronco (x-1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa


safeRightTronco :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeRightTronco (x,y) linhasmapa =  eTronco (x+1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa

safeLeftandRightTronco :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeLeftandRightTronco (x,y) linhasmapa = eTronco (x+1,y) obstaculos  && eTronco (x-1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa


safeLeft :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeLeft (x,y) linhasmapa =  eNenhum (x-1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa


safeRight :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeRight (x,y) linhasmapa =  eNenhum (x+1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa

safeLeftandRight :: (Int,Int) -> [LinhaDoMapa] -> Bool 
safeLeftandRight (x,y) linhasmapa = eNenhum (x+1,y) obstaculos  && eNenhum (x-1,y) obstaculos
 where obstaculos = getObstaculos (x,y) linhasmapa



moveInRight :: Estado -> Estado
moveInRight jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 

moveInLeft :: Estado -> Estado
moveInLeft jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 

moveInFree :: Estado -> Estado
moveInFree jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | x > (div larguraMapa 2) = ((Jogo (Jogador (x-1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | otherwise = ((Jogo (Jogador (x+1, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 


findSafeMoveBothAll :: Estado-> Estado 
findSafeMoveBothAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  = if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOk (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOk (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if x > (div largura 2) then  moveBot ((Jogo (Jogador (x-1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else moveBot ((Jogo (Jogador (x+1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

findSafeMoveLeftAll :: Estado->Estado 
findSafeMoveLeftAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = if midOk (x,y) linhas then ((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOk (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

findSafeMoveRightAll :: Estado->Estado 
findSafeMoveRightAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) =  if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if rightOk (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)



findSafeMoveRiverBothAll :: Estado-> Estado 
findSafeMoveRiverBothAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else  moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

findSafeMoveRiverLeftAll :: Estado->Estado 
findSafeMoveRiverLeftAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

findSafeMoveRiverRightAll :: Estado->Estado 
findSafeMoveRiverRightAll jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) =  if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)







findSafeMoveBoth :: Estado-> Estado 
findSafeMoveBoth jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  = if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOk (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOk (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else    moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 

findSafeMoveLeft :: Estado->Estado 
findSafeMoveLeft jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) = if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOk (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

findSafeMoveRight :: Estado->Estado 
findSafeMoveRight jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) =  if midOk (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if rightOk (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

findSafeMoveRiverBoth :: Estado-> Estado 
findSafeMoveRiverBoth jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  
 | x>= 1 && x == largura -1 = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)   else  moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 | otherwise = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

findSafeMoveRiverLeft :: Estado->Estado 
findSafeMoveRiverLeft jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | x>= 1 && x == largura-1 = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 | otherwise = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) else if leftOkRiver (x,y) linhas then ((Jogo (Jogador (x-1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
findSafeMoveRiverRight :: Estado->Estado 
findSafeMoveRiverRight jogo@((Jogo (Jogador (x, y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1) 
 | x>=1 && x== largura-1 = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x-1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)
 | otherwise = if midOkRiver (x,y) linhas then ((Jogo (Jogador (x, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else if rightOkRiver (x,y) linhas then ((Jogo (Jogador (x+1, y-1)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina , pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)  else moveBot ((Jogo (Jogador (x+1,y)) (Mapa largura linhas)), texturas, tamanhoJanela, pagina, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y1)

rightOk :: (Int,Int) -> [LinhaDoMapa] -> Bool 
rightOk (x,y) linhasmapa = eNenhum (x+1,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa


rightOkRiver :: (Int,Int) -> [LinhaDoMapa] -> Bool 
rightOkRiver (x,y) linhasmapa = eTronco (x+1,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa

midOk :: (Int,Int) -> [LinhaDoMapa] -> Bool 
midOk (x,y) linhasmapa = eNenhum (x,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa


midOkRiver :: (Int,Int) -> [LinhaDoMapa] -> Bool 
midOkRiver (x,y) linhasmapa = eTronco (x,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa




leftOk :: (Int,Int) -> [LinhaDoMapa] -> Bool 
leftOk (x, y) linhasmapa = eNenhum (x-1,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa

leftOkRiver :: (Int,Int) -> [LinhaDoMapa] -> Bool 
leftOkRiver (x, y) linhasmapa = eTronco (x-1,y) obstaculos 
 where obstaculos = getObstaculos (x,y-1) linhasmapa


eNenhum (x, _) lista = lista!!x == Nenhum
eTronco (x, _) lista = lista!!x == Tronco


getObstaculos (x, y) linhas = snd (linhas!!y) 


nextIsRelva :: (Int,Int) -> [LinhaDoMapa] -> Bool 
nextIsRelva (x, y) linhas = (fst (linhas !! (y-1))) == Relva


nextIsEstrada :: (Int,Int) -> [LinhaDoMapa] -> Bool 
nextIsEstrada (x, y) linhas = verificaEstrada ( (linhas !! (y-1)))


nextIsRio :: (Int,Int) -> [LinhaDoMapa] -> Bool 
nextIsRio (x, y) linhas = verificaRio ( (linhas !! (y-1)))


verificaEstrada :: LinhaDoMapa -> Bool 
verificaEstrada (Estrada _ , _) = True
verificaEstrada _ = False


verificaRio :: LinhaDoMapa -> Bool 
verificaRio (Rio _ , _) = True
verificaRio _ = False

emRio :: (Int,Int) -> [LinhaDoMapa]-> Bool 
emRio (x,y) linhas = verificaRio (linhas !! y)


emEstrada :: (Int,Int) -> [LinhaDoMapa]-> Bool 
emEstrada (x,y) linhas = verificaEstrada (linhas !! y)

emRelva :: (Int,Int) -> [LinhaDoMapa] -> Bool 
emRelva (x, y) linhas = (fst (linhas !! y)) == Relva

moverBot :: Estado -> Jogada -> Estado 
moverBot (jogo@(Jogo (Jogador (_, yInicial)) _), texturas, tamanhoJanela, _, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) (Move Cima)
  |  novoY <  y = (novoJogo, texturas, tamanhoJanela, novoMenu, novaPontuacaoAtual novoY y pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,novoY)
  | otherwise = (novoJogo, texturas, tamanhoJanela, novoMenu,  pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)


   where novoJogo@(Jogo (Jogador (_, novoY)) _) = animaJogador jogo (Move Cima)
         novoMenu = if jogoTerminou novoJogo then DERROTA else BOT;
    
moverJogador (jogo@(Jogo (Jogador (_, yInicial)) _), texturas, tamanhoJanela, _, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) jogada = (novoJogo, texturas, tamanhoJanela, novoMenu, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)
  where novoJogo@(Jogo (Jogador (_, novoY)) _) = animaJogador jogo jogada
        novoMenu = if jogoTerminou novoJogo then DERROTA else BOT;