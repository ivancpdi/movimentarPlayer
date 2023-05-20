---------------------------------------------------------------------------------------------------
--------------
--------------   Classe propriedades da imagem (classe base para cracteristicas)
--------------
--------------   Observção: As caracteristicas da imagem incluem, tamanhoY x, distancia y, 
--------------   tamanho x, tamanho y, efeito, index e descrição
--------------   
---------------------------------------------------------------------------------------------------
objetoClasse = { }

function objetoClasse:new ( ) 

  local instance = { } -- cria uma nova tabela para a instancia 
  setmetatable ( instance, self ) -- define a metatable da instancia como a propria class
  self.__index = self -- configura o indice da class para si mesma

  return instance

end

-- Tabela para armazenar os valores das propriedades
local propriedades = {

  armazenamentoImagem = {

   }

}

-- Metatabela para objeto
local metatabela = { 

  __index = function(_, key) 
  return propriedades[key]
end,
 __newindex = function(_, key, value) 
  propriedades[key] = value 
end 

}

-- Definir metatabela para o objeto
setmetatable ( objetoClasse, metatabela )

-- Definir propriedades
objetoClasse.src        = "/"
objetoClasse.display    = nil

objetoClasse.distanciaX = -1
objetoClasse.distanciaY = -1

objetoClasse.tamanhoX   = -1
objetoClasse.tamanhoY   = -1

objetoClasse.efeito     = false
objetoClasse.index      = -1
objetoClasse.funcao     = false
objetoClasse.descricao  = "Descrição da parta da imagem"

-- Mostra um print com todas as propriedas

function objetoClasse:toSTring ( )

  local saidaStrings = ""

  for i = 0, #objeto.armazenamentoImage do
    local objetoSaida = objetoAcao.armazenamentoImage[ i ]
    saidaStrings = "/ src: ".. objetoSaida.src .. " / display: ".. objetoSaida.display .. " / distanciaX: ".. objetoSaida.distanciaX .. " / distanciaY: ".. objetoSaida.distanciaY " / tamanhoX: ".. objetoSaida.tamanhoX " /  tamanhoY: ".. objetoSaida.tamanhoY .. " / efeito: ".. objetoSaida.efeito .. " / index: " .. objetoSaida.index " / funcao: " .. objetoSaida.funcao " / descricao: " .. objetoSaida.descricao
  end

  return saidaStrings 

end

function objetoClasse:pegaObjeto ( )
  
  return objeto.armazenamentoImage

end

function objetoClasse:alteraObjeto ( objetoSaida )
  
  print ("------ Inicio alteraObjeto ")
  print ("-- Antigo")
  print (toSTring)
  
  objeto.armazenamentoImage = obejtoSaida
  
  print ("-- Novo")
  print (toSTring)
  print ("------ Fim alteraObjeto ")

end

-----------------------------------------------------------------------------------------------------
----------------
----------------   Classe objeto (classe para trabalhar o objeto)
----------------
----------------   Observção: as carateriscas da imagem no array não foram acessadas diretamente,
----------------   então essa classe define qual parte sera acessada e depois disponibiliza
----------------   para o resto do código
----------------  
-----------------------------------------------------------------------------------------------------
derivadaObjetoClasse = objetoClasse:new ( )

local meuObjeto = objetoClasse.armazenamentoImage

function derivadaObjetoClasse:toSTring ( )
  
  local saidaString = "src: ".. meuObjeto.src .. " / display: ".. meuObjeto.display .. " / distanciaX: ".. meuObjeto.distanciaX .. " / distanciaY: ".. meuObjeto.distanciaY " / tamanhoX: ".. meuObjeto.tamanhoX " /  tamanhoY: ".. meuObjeto.tamanhoY .. " / efeito: ".. meuObjeto.efeito .. " / index: " .. meuObjeto.index " / funcao: " .. meuObjeto.funcao " / descricao: " .. meuObjeto.descricao

  return saidaString

end

function derivadaObjetoClasse:alteraObjeto ( src, display, distanciaX, distanciaY, tamanhoX, tamanhoY, efeito, index, funcao, descricao )
  
  local objetoSaida = objetoClasse.armazenamentoImage

  objetoSaida.src        = src
  objetoSaida.display    = display
  
  objetoSaida.distanciaX = distanciaX
  objetoSaida.distanciaY = distanciaY
  
  objetoSaida.tamanhoX   = tamanhoX
  objetoSaida.tamanhoY   = tamanhoY
  
  objetoSaida.efeito     = efeito
  objetoSaida.index      = index
  objetoSaida.funcao     = funcao
  objetoSaida.descricao  = descricao
   
  objetoClasse:alteraObjeto( obejtoSaida )
  
end

-----------------------------------------------------------------------------------------------------
----------------
----------------   Classe group de imagem (classe base para agrupar a imagem com perfeição)
----------------
----------------   Observção: As partes do personagem são separadas, mão esquerda, mão direita, pe esquerdo,
----------------   pe direito, corpo e cabeça.
----------------   A classe base para isso registra as imagens em um array e suas caracteristicas, 
----------------   tamanhoY x, distancia y, tamanho x, tamanho y e com efeito.
----------------   
-----------------------------------------------------------------------------------------------------

groupImageClass = { }

local playerGroup  = display.newGroup ( ) 
local consoleGroup = display.newGroup ( )

function groupImageClass:new ( ) 
  local instance = { } -- cria uma nova tabela para a instancia 
  setmetatable ( instance, self ) -- define a metatable da instancia como a propria class
  self.__index = self -- configura o indice da class para si mesma
  return instance
end

function groupImageClass:agrupar ( index )
  local a = objetoClasse.armazenamentoImage
  
  if ( a[9] == false ) then
    playerGroup:insert ( a[2] )
    playerGroup:toFront ( )
  else
    consoleGroup:insert ( a[2] )
    consoleGroup:toFront ( )
   end
   objetoClasse[ index ] = a
end

function groupImageClass:alinharX ( )
  return true
end

function groupImageClass:alinharY ( )
  return true 
end

-----------------------------------------------------------------------------------------------------
----------------
----------------   Classe derivada do group imagem (classe derivada para agrupar a imagem)
----------------   Observação: essa é a classe onde temos o controle das propriedades e
----------------   da criação da imagem
----------------
-----------------------------------------------------------------------------------------------------

derivadaGroupImage = groupImageClass:new ( )

local imagemEfeito = -1

function derivadaGroupImage:criarImagem ( src, tamanhoX, tamanhoY, distanciaX, distanciaY, efeito, index, funcao, descricao )
  objetoClasse.armazenamentoImage = {
     src,
  
    derivadaGroupImage:inserir ( src, tamanhoX, tamanhoY, distanciaX, distanciaY, index ),
   
    distanciaX,
    distanciaY,

    tamanhoX,
    tamanhoY,

    efeito,
    index,
    funcao,
    descricao,

    }

    derivadaGroupImage:agrupar ( index )

end

function derivadaGroupImage:inserir ( src, tamanhoX, tamanhoY, distanciaX, distanciaY, index ) 
  local imagemAgrupar = display.newImageRect ( src, tamanhoX, tamanhoY )
  imagemAgrupar.x = distanciaX
  imagemAgrupar.y = distanciaY

    if ( index == 6 ) then
       imagemAgrupar.rotation = 90
    elseif ( index == 5 ) then
      imagemAgrupar.rotation = 270
    elseif ( index == 4 ) then
      imagemAgrupar.rotation = 180
    elseif ( index == 3 ) then
      imagemAgrupar.rotation = 0
    end

    return ( imagemAgrupar )
end

function derivadaGroupImage:agrupar ( imagemAgrupar )
  groupImageClass:agrupar ( imagemAgrupar )

end

function derivadaGroupImage:retornaPisada ( index )
  local objetoImagem = objetoClasse[index]
  return objetoImagem[2] 

end

-----------------------------------------------------------------------------------------------------
----------------
----------------   Classe touch (classe base para movimentar o player)
----------------
-----------------------------------------------------------------------------------------------------
local touchClass = {}

isTouchPressionado = false 
botaoSelecionado = -1

function touchClass:new() 
  local instance = {} -- cria uma nova tabela para a instancia 
  setmetatable(instance, self) -- define a metatable da instancia como a propria class
  self.__index = self -- configura o indice da class para si mesma
  return instance
end

function touchClass:acao (  )
  return true
end

-----------------------------------------------------------------------------------------------------
----------------
----------------   Classe derivada (objeto para sobrecarregar as ações na classe base)
----------------
-----------------------------------------------------------------------------------------------------
local derivadaTouchClass = touchClass:new()
local objetoDerivadoImagem = derivadaGroupImage:new()

local player = display.newImageRect ( "imagens/player.png", 532 / 3, 469 / 3 )
player.x = 50
player.y = 320

local bg = display.newImageRect ( "imagens/sky.png", 960 * 3, 240 * 3 )
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ( "imagens/ground.png", 1028, 256 )
chao.x = display.contentCenterX
chao.y = 490

local retornaBotao = {
  [1] = function ( )
    playerGroup.x = playerGroup.x + 2
    playerGroup.y =playerGroup.y
    print ("Boneco andou para direita com classe derivada")
  end,

  [2] = function ( )
    playerGroup.x = playerGroup.x - 2
    playerGroup.y = playerGroup.y
    print ("Boneco andou para esquerda com classe derivada")
  end,

  [3] = function ( )
    playerGroup.x = playerGroup.x
    playerGroup.y = playerGroup.y - 2
    print ("Boneco andou para baixo com classe derivada")
  end,

  [4] = function ( )
    playerGroup.x = playerGroup.x
    playerGroup.y = playerGroup.y + 2
    print ("Boneco andou para cima com classe derivada")
  end,

}

local function efeitoPisada( pisada, index)
  if ( pisada == false ) then 
  transition.to(derivadaGroupImage:retornaPisada ( 2 ), { time = 100, xScale = 0.8, yScale = 0.8, onComplete = function()
  transition.to(derivadaGroupImage:retornaPisada ( 2 ), { time = 50, xScale = 1.1, yScale = 1.1, onComplete = function() 
  transition.to(derivadaGroupImage:retornaPisada ( 2 ), { time = 90, xScale = 1, yScale = 1  })
  end })
end })
end
end

local function acao ()
  if retornaBotao[botaoSelecionado] then
    retornaBotao[botaoSelecionado]()    
  end

end

-----------------------------------------------------------------------------------------------------
----------------
----------------   Classe main (ou objeto com todas as heranças)
----------------
-----------------------------------------------------------------------------------------------------
local objectDerivadoTouch = derivadaTouchClass:new()

local objetoDerivadoImagem = derivadaGroupImage:new()

function onTouch( event )
  botaoSelecionado = -1
    
  if ( event.x >= 200 and event.x <= 260 and event.y >= 455  and event.y <= 505 ) then
    botaoSelecionado  = 1
    imagemEfeito =  3

  elseif ( event.x >= 60 and event.x <= 115 and event.y >= 455  and event.y <= 505 ) then 
    botaoSelecionado  = 2
    imagemEfeito =  4

  elseif ( event.x >= 120 and event.x <= 190 and event.y >= 455  and event.y <= 510 ) then
    botaoSelecionado  = 3
    imagemEfeito =  5
    
  elseif ( event.x >= 120 and event.x <= 190 and event.y >= 520  and event.y <= 575 ) then
    botaoSelecionado  = 4
    imagemEfeito =  6

  else
    botaoSelecionado  = -1
    isTouchPressionado = false
  end
  
  if ( event.phase == "began" ) then
    isTouchPressionado = true
    efeitoPisada( true, imagemEfeito )
    acao ( )

  elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
    efeitoPisada( false, imagemEfeito )
    isTouchPressionado = false
  end

  return true
end

function touchPressionado ( )
  if ( isTouchPressionado ) then
    acao ()
 end
end

local function loop ( )
  touchPressionado ( )
  timer.performWithDelay ( 100, loop )
end

objetoDerivadoImagem:criarImagem( "imagens/mariosempe1.png", 532 * 0.30, 469 * 0.30, 100, display.contentCenterY + 60, false, 0, false, "Corpo SuperMario" )
objetoDerivadoImagem:criarImagem( "imagens/pedireito1.png", 146 * 0.30, 144 * 0.30, 100 + 33, display.contentCenterY + 120, true, 1, false, "Pé direito" )
objetoDerivadoImagem:criarImagem( "imagens/peesquerdo1.png", 124 * 0.30, 131 * 0.30, 100 - 78, display.contentCenterY + 79, true, 2, false, "Pé esquerdo" )


objetoDerivadoImagem:criarImagem( "imagens/button.png", 1280 / 20, 1279 / 20, display.contentCenterX + 70, display.contentCenterY + display.contentCenterY, false, 3, true, "Botao direita")
objetoDerivadoImagem:criarImagem( "imagens/button.png", 1280 / 20, 1279 / 20, display.contentCenterX - 70, display.contentCenterY + display.contentCenterY, false, 4, true, "Botao esquerda")
objetoDerivadoImagem:criarImagem( "imagens/button.png", 1280 / 20, 1279 / 20, display.contentCenterX, display.contentCenterY + display.contentCenterY, false, 5, true, "Botao salta")
objetoDerivadoImagem:criarImagem( "imagens/button.png", 1280 / 20, 1279 / 20, display.contentCenterX, display.contentCenterY + display.contentCenterY + 70, false, 6, true, "Botao agacha")

for i = 3, 6 do
local objetoAcao = objetoClasse[i]
objetoAcao[2]:addEventListener("touch", onTouch)
end

player:toBack()

loop()
