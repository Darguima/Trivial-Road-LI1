module Gloss_Functions.ReageEventos.ReageEventoMenu where

import Gloss_Functions.GlossData (Estado)

import Graphics.Gloss.Interface.IO.Game (Event)

reageEventoMenu :: Event -> Estado -> IO Estado
reageEventoMenu _ estado = return estado
