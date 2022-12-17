module Gloss_Functions.ReageEventos.ReageEventoSobre where

import Gloss_Functions.GlossData (Estado)

import Graphics.Gloss.Interface.IO.Game (Event)

reageEventoSobre :: Event -> Estado -> IO Estado
reageEventoSobre _ estado = return estado
