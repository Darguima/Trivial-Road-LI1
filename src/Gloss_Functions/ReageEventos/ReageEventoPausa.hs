module Gloss_Functions.ReageEventos.ReageEventoPausa where

import Gloss_Functions.GlossData (Estado)

import Graphics.Gloss.Interface.IO.Game (Event)

reageEventoPausa :: Event -> Estado -> IO Estado
reageEventoPausa _ estado = return estado
