--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

------------------ touch -------------------------
local touchPressionado = false

local botao = -1

local function onTouch ( event ) 

    botao = -1
    
    if ( event.x >= 200 and event.x <= 260 and event.y >= 455  and event.y <= 505 ) then
    botao = 1
  
    elseif ( event.x >= 60 and event.x <= 115 and event.y >= 455  and event.y <= 505 ) then 
    botao = 2

    elseif ( event.x >= 120 and event.x <= 190 and event.y >= 455  and event.y <= 510 ) then
    botao = 3

    elseif ( event.x >= 120 and event.x <= 190 and event.y >= 520  and event.y <= 575 ) then
    botao = 4

    else
      botao = -1
      touchPressionado = false
    end

    if ( event.phase == "began" ) then
      touchPressionado = true
          
    elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
      touchPressionado = false
    end

  return true
end

local bg = display.newImageRect ( "imagens/sky.png", 960 * 3, 240 * 3 )

bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ( "imagens/ground.png", 1028, 256 )

chao.x = display.contentCenterX
chao.y = 490

local player = display.newImageRect ( "imagens/player.png", 532 / 3, 469 / 3 )

player.x = 50
player.y = 320

local function direita ( )
  player.x = player.x + 2
  return true
end

local botaoDireita = display.newImageRect ( "imagens/button.png", 1280 / 20, 1279 / 20 )
botaoDireita.x = display.contentCenterX + 70
botaoDireita.y = display.contentCenterY + display.contentCenterY
--botaoDireita:addEventListener ( "touch", direita )
botaoDireita:addEventListener ( "touch", onTouch )

local function esquerda (  )
  player.x = player.x - 2
  return true
end
  
local botaoEsquerda = display.newImageRect ( "imagens/button.png", 1280 / 20, 1279 / 20 )
botaoEsquerda.x = display.contentCenterX - 70
botaoEsquerda.y = display.contentCenterY + display.contentCenterY
botaoEsquerda.rotation = 180
--botaoEsquerda:addEventListener ( "touch", esquerda)
botaoEsquerda:addEventListener ( "touch", onTouch )

local function salta ( )
  player.y = player.y - 2
  return true
end
  
local botaoSalta = display.newImageRect ( "imagens/button.png", 1280 / 20, 1279 / 20 )
botaoSalta.x = display.contentCenterX
botaoSalta.y = display.contentCenterY + display.contentCenterY
botaoSalta.rotation = 270
--botaoSalta:addEventListener ( "touch", salta )
botaoSalta:addEventListener ( "touch", onTouch )

local function agacha (  )
  player.y = player.y + 2
  return true
end
    
local botaoAgacha = display.newImageRect ( "imagens/button.png", 1280 / 20, 1279 / 20 )
botaoAgacha.x = display.contentCenterX
botaoAgacha.y = display.contentCenterY + display.contentCenterY + 70
botaoAgacha.rotation = 90
--botaoAgacha:addEventListener ( "touch", agacha )
botaoAgacha:addEventListener ( "touch", onTouch )

local retornaBotao = {
  [1] = function ( )
   direita (  )
  end,
  [2] = function ( )
    esquerda (  )
  end,
  [3] = function ( )
    salta (  )
  end,
  [4] = function ( )
    agacha (  )
  end,
}

local function isTouchPressionado ( )
  if ( touchPressionado ) then
   if retornaBotao[botao] then
     retornaBotao[botao]()
   end
  end
 end

 local function loop ( )
  isTouchPressionado ( )
  timer.performWithDelay ( 100, loop )
end

loop()