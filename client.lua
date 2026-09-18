local models_list = {
    vehicle = {},
    ped = {},
    object = {}
}

-- Додаємо одну нову модель
addEvent("addClientModel", true)
addEventHandler("addClientModel", resourceRoot, function(id, name, modelType)
    models_list[modelType][#models_list[modelType] + 1] = {
        id = id,
        name = name
    }
end)


-- Повна синхронізація із сервера
addEvent("syncModels", true)
addEventHandler("syncModels", resourceRoot, function(serverModels)

    models_list = serverModels or {
        vehicle = {{id = -1, name = "NO MODELS SYNCED"}},
        ped = {},
        object = {}
    }

    outputDebugString(
        "Models synchronized: " ..
        "vehicles=" .. tostring(#models_list.vehicle) ..
        " peds=" .. tostring(#models_list.ped) ..
        " objects=" .. tostring(#models_list.object)
    )

    triggerEvent("onCustomModelsUpdated", resourceRoot)
end)


-- При старті клієнта просимо сервер віддати список
addEventHandler("onClientResourceStart", resourceRoot, function()
    triggerServerEvent("requestModels", resourceRoot)
end)


-- Отримати моделі конкретного типу
function getModelsClient(modelType)
    return models_list[modelType]
    -- return {
    --     {id = -1, name = "TEST 1"},
    --     {id = -2, name = "TEST 2"},
    --     {id = -3, name = "TEST 3"},
    --     {id = -4, name = "TEST 4"},
    -- }
end

addCommandHandler("modelslist", function()
    outputChatBox("===== newmodels_list =====")
    local total = 0
    for modelType, models in pairs(models_list) do
        outputChatBox( "[" .. tostring(modelType) .. "] " .. tostring(#models) .. " models" )
        for i, model in ipairs(models) do
            outputChatBox( " ID: " .. tostring(model.id) .. " | " .. tostring(model.name) )
            total = total + 1
        end
    end
    outputChatBox( "Total models: " .. tostring(total) )
end)
