local models_list = {
    vehicle = {},
    ped = {},
    object = {}
}

function addModel(id, name, modelType)
    models_list[modelType][#models_list[modelType] + 1] = {
        id = id,
        name = name
    }

    -- Оновлюємо клієнтів
    triggerClientEvent(
        root,
        "addClientModel",
        resourceRoot,
        id,
        name,
        modelType
    )

    return true
end


-- Клієнт просить актуальний список
addEvent("requestModels", true)
addEventHandler("requestModels", resourceRoot, function()
    triggerClientEvent(
        client,
        "syncModels",
        resourceRoot,
        models_list
    )
end)


-- Отримати моделі конкретного типу
function getModels(modelType)
    return models_list[modelType]
end
