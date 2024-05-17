# Script de Boas-vindas

Este script em Lua é projetado para fornecer uma mensagem de boas-vindas aos jogadores ao entrarem no jogo. Ele obtém e utiliza detalhes específicos do jogador, como nome de usuário, nível da conta e data de expiração da conta, para personalizar a experiência de boas-vindas.

## Pré-requisitos

- Interpretador Lua
- Módulos Lua necessários: `System\\ScriptCore` e `System\\ScriptDefines`

## Visão Geral do Script

### Importação dos Módulos

O script começa importando os módulos necessários:

```lua
require "System\\ScriptCore"
require "System\\ScriptDefines"
```

## Anexando a Função de Boas-vindas

A função Welcome_OnCharacterEntry é anexada ao evento OnCharacterEntry:

```lua
BridgeFunctionAttach("OnCharacterEntry", "Welcome_OnCharacterEntry")
```

## Função de Boas-vindas

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
## Funções Auxiliares

Parse Date
Esta função converte uma string de data em um timestamp:

```lua
function parseDate(dateString)
    local year, month, day, hour, min, sec = dateString:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    return os.time({year = year, month = month, day = day, hour = hour, min = min, sec = sec})
end
```

## Dias Até a Expiração

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

## Uso

- Certifique-se de que os módulos necessários estão disponíveis.
- Anexe a função Welcome_OnCharacterEntry ao evento OnCharacterEntry.
- Personalize as mensagens de boas-vindas e as mensagens baseadas no nível da conta conforme necessário.