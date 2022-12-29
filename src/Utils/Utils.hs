module Utils.Utils where
import LI12223 (Terreno (..))

extrairVelocidade :: Terreno -> Int
extrairVelocidade (Rio v) = v
extrairVelocidade (Estrada v) = v
extrairVelocidade Relva = 0
