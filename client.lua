local function createShopMenu(shopIndex)
    local shop = Config.Shops[shopIndex]
    local options = {}

    for _, item in ipairs(shop.items) do
        table.insert(options, {
            title = item.label,
            description = 'Koupit ' .. item.label .. ' za ' .. item.cost.. ' peněz',
            onSelect = function()
                TriggerServerEvent('prv_buy:item', item.name, item.cost)
            end
        })
    end

    lib.registerContext({
        id = 'shop_menu_' .. shopIndex,
        title = 'Nelegal Shop',
        options = options
    })
end

local function spawnShopNPC(shopIndex)
    local shop = Config.Shops[shopIndex]
    RequestModel(GetHashKey(shop.pedModel))

    while not HasModelLoaded(GetHashKey(shop.pedModel)) do
        Wait(1)
    end

    local ped = CreatePed(4, GetHashKey(shop.pedModel), shop.coords.x, shop.coords.y, shop.coords.z - 1.0, shop.heading, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetPedCanRagdoll(ped, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'shop_' .. shopIndex,
            icon = 'fa-solid fa-shop',
            label = 'Otevřit Obchod',
            onSelect = function()
                lib.showContext('shop_menu_' .. shopIndex)
            end
        }
    })
end

Citizen.CreateThread(function()
    for index, shop in ipairs(Config.Shops) do
        createShopMenu(index)
        spawnShopNPC(index)
    end
end)
