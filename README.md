# newmodels_list

Ресурс для зберігання та синхронізації списків кастомних моделей MTA:SA.

Підтримувані типи:

- `vehicle`
- `ped`
- `object`

## Встановлення

Додайте ресурс до `mtaserver.conf`:

```xml
<resource src="newmodels_list" />
```

Або запустіть його командою:

```text
start newmodels_list
```

## Серверні експорти

### `addModel`

Додає модель і синхронізує її з усіма клієнтами.

```lua
exports.newmodels_list:addModel(id, name, modelType)
```

Приклад:

```lua
exports.newmodels_list:addModel(1234, "Custom Vehicle", "vehicle")
```

### `getModels`

Повертає список моделей певного типу.

```lua
local vehicles = exports.newmodels_list:getModels("vehicle")
```

## Клієнтський експорт

### `getModelsClient`

Повертає список моделей, синхронізований із сервером.

```lua
local vehicles = exports.newmodels_list:getModelsClient("vehicle")
```

## Подія оновлення

Після повної синхронізації викликається подія:

```lua
addEventHandler("onCustomModelsUpdated", resourceRoot, function()
    local models = exports.newmodels_list:getModelsClient("vehicle")
end)
```

## Діагностика

Для перегляду списку моделей використовуйте команду:

```text
/modelslist
```

## Структура ресурсу

```text
newmodels_list/
├── client.lua
├── server.lua
├── meta.xml
└── README.md
```