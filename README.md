# Script Welcome.lua

Este script em Lua é projetado para fornecer uma mensagem de boas-vindas aos jogadores ao entrarem no jogo. Ele obtém e utiliza detalhes específicos do jogador, como nome de usuário, nível da conta e data de expiração da conta, para personalizar a experiência de boas-vindas.

## Pré-requisitos

- <a href="https://emulator.matrixsecurity.online/" target="_blank">Emulador Matrix</a>
- Interpretador Lua
- Módulos Lua necessários: `System\\ScriptCore` e `System\\ScriptDefines`

## Visão Geral do Script

#### Criação do arquivo

- Crie 1 um arquivo com nome Welcome.lua na pasta ( Muserver/Data/Lua/Bridge )
- Acressente no arquivo message.txt ( Muserver/Data ) o codigo abaixo

```txt
2500      "Bem vindo %s ao MuTop10"
2501      "%s Ajude o Servidor compre seu VIP"
2502      "%s Dias restantes de Vip"
```
#### Importação dos Módulos

O script começa importando os módulos necessários:

```lua
require "System\\ScriptCore"
require "System\\ScriptDefines"
```

#### Anexando a Função de Boas-vindas

A função Welcome_OnCharacterEntry é anexada ao evento OnCharacterEntry:

```lua
BridgeFunctionAttach("OnCharacterEntry", "Welcome_OnCharacterEntry")
```

#### Função de Boas-vindas

Esta função é chamada quando um personagem entra no jogo. Ela executa as seguintes ações:

- Obtém o nome do usuário, nível da conta e data de expiração da conta.
- Calcula os dias até a expiração da conta.
- Envia uma mensagem de boas-vindas personalizada baseada no nível da conta do usuário.
- Envia uma mensagem global se o usuário tiver autoridade de GM ou superior.

```lua
function Welcome_OnCharacterEntry(aIndex)
    local UserName = GetObjectName(aIndex)
    local UserAccountLevel = GetObjectAccountLevel(aIndex)
    local UserAccountExpireDate = GetObjectAccountExpireDate(aIndex)
    local BrazilianFormattedDate = daysUntilExpiration(UserAccountExpireDate)
    
    NoticeSend(aIndex, 0, string.format(MessageGet(2500), UserName))
    
    if UserAccountLevel == 0 then 
        NoticeSend(aIndex, 1, string.format(MessageGet(2501), UserName))
    elseif UserAccountLevel == 1 then
        NoticeSend(aIndex, 1, string.format(MessageGet(2502), BrazilianFormattedDate))
    elseif UserAccountLevel == 2 then
        NoticeSend(aIndex, 1, string.format(MessageGet(2502), BrazilianFormattedDate))
    elseif UserAccountLevel == 3 then
        NoticeSend(aIndex, 1, string.format(MessageGet(2502), BrazilianFormattedDate))
    end
    
    if GetObjectAuthority(aIndex) == 1 then
        MessageSendToAll(4, 4, "" .. UserName .. ": Online")
    elseif GetObjectAuthority(aIndex) >= 2 then
        NoticeSendToAll(0, " [STAFF] " .. UserName .. " Online")   
    end
end
```
#### Funções Auxiliares

Parse Date
Esta função converte uma string de data em um timestamp:

```lua
function parseDate(dateString)
    local year, month, day, hour, min, sec = dateString:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    year = tonumber(year)
    month = tonumber(month)
    day = tonumber(day)
    hour = tonumber(hour)
    min = tonumber(min)
    sec = tonumber(sec)
    
    -- Verificar se a data é antes do limite suportado (por exemplo, 1970)
    if year < 1970 then
        -- Retornar uma data padrão em caso de data antiga
        return os.time({year = 2020, month = 1, day = 1, hour = 0, min = 0, sec = 0})
    end

    return os.time({year = year, month = month, day = day, hour = hour, min = min, sec = sec})
```

#### Dias Até a Expiração

Esta função calcula o número de dias até a data de expiração da conta:

```lua
function daysUntilExpiration(expireDateString)
    local expireDate = parseDate(expireDateString)
    local currentDate = os.time()
    local diffInSeconds = expireDate - currentDate
    local diffInDays = math.floor(diffInSeconds / (60 * 60 * 24))
    return diffInDays
end
```

#### Uso

- Certifique-se de que os módulos necessários estão disponíveis.
- Anexe a função Welcome_OnCharacterEntry ao evento OnCharacterEntry.
- Personalize as mensagens de boas-vindas e as mensagens baseadas no nível da conta conforme necessário.

#### Contacts

<div> 
  <a href="http://www.youtube.com/@WebersonCarlos" target="_blank"><img src="https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white" target="_blank"></a>
  <a href="https://www.instagram.com/weberson.code/" target="_blank"><img src="https://img.shields.io/badge/-Instagram-%23E4405F?style=for-the-badge&logo=instagram&logoColor=white" target="_blank"></a>
  <a href="https://discord.gg/j8v3SHQ6NM" target="_blank"><img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white" target="_blank"></a> 
  <a href = "mailto:calinhos_usa@hotmail.com"><img src="https://img.shields.io/badge/-Hotmail-%23333?style=for-the-badge&logo=hotmail&logoColor=white" target="_blank"></a>
  <a href="https://api.whatsapp.com/send?phone=5562996727496" target="_blank"><img src="https://img.shields.io/badge/-Whatsapp-%230077B5?style=for-the-badge&logo=whatsapp&logoColor=white" target="_blank"></a> 
  
</div>
