-- Importa os módulos necessários
require "System\\ScriptCore"
require "System\\ScriptDefines"

-- Anexa a função Welcome_OnCharacterEntry ao evento OnCharacterEntry
BridgeFunctionAttach("OnCharacterEntry", "Welcome_OnCharacterEntry")

-- Função chamada quando um personagem entra no jogo
function Welcome_OnCharacterEntry(aIndex)
    -- Obtém o nome do usuário
    local UserName = GetObjectName(aIndex)

    -- Obtém o nível de conta do usuário
    local UserAccountLevel = GetObjectAccountLevel(aIndex)

    -- Obtém a data de expiração da conta do usuário
    local UserAccountExpireDate = GetObjectAccountExpireDate(aIndex)
    
    -- Calcula os dias até a expiração da conta em formato brasileiro
    local BrazilianFormattedDate = daysUntilExpiration(UserAccountExpireDate)

    -- Envia uma mensagem de boas-vindas ao usuário
    NoticeSend(aIndex, 0, string.format(MessageGet(2500), UserName))

    -- Envia uma mensagem baseada no nível de conta do usuário
    if UserAccountLevel == 0 then 
        NoticeSend(aIndex, 1, string.format(MessageGet(2501), UserName))
    elseif UserAccountLevel == 1 then
        NoticeSend(aIndex, 1, string.format(MessageGet(2502), BrazilianFormattedDate))
    elseif UserAccountLevel == 2 then
        NoticeSend(aIndex, 1, string.format(MessageGet(2502), BrazilianFormattedDate))
    elseif UserAccountLevel == 3 then
        NoticeSend(aIndex, 1, string.format(MessageGet(2502), BrazilianFormattedDate))
    end
    
    -- Envia uma mensagem global se o usuário tiver autoridade de GM ou superior
    if GetObjectAuthority(aIndex) == 1 then
        MessageSendToAll(4, 4, "" .. UserName .. ": Online")
    elseif GetObjectAuthority(aIndex) >= 2 then
        NoticeSendToAll(0, " [STAFF] " .. UserName .. " Online")   
    end
end

-- Função para converter uma string de data para um valor de tempo (timestamp)
function parseDate(dateString)
    local year, month, day, hour, min, sec = dateString:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    return os.time({year = year, month = month, day = day, hour = hour, min = min, sec = sec})
end

-- Função para calcular a diferença de dias entre a data atual e a data de expiração
function daysUntilExpiration(expireDateString)
    local expireDate = parseDate(expireDateString)
    local currentDate = os.time()
    
    -- Calcula a diferença em segundos e converte para dias
    local diffInSeconds = expireDate - currentDate
    local diffInDays = math.floor(diffInSeconds / (60 * 60 * 24))
    
    return diffInDays
end
