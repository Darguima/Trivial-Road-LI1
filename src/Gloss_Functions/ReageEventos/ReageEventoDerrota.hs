module Gloss_Functions.ReageEventos.ReageEventoDerrota where

import Gloss_Functions.GlossData (Estado)

import Graphics.Gloss.Interface.IO.Game (Event)

reageEventoDerrota :: Event -> Estado -> IO Estado
reageEventoDerrota _ estado = return estado
