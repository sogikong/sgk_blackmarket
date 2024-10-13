ESX = exports.es_extended:getSharedObject()

RegisterServerEvent('prv_buy:item')
AddEventHandler('prv_buy:item', function(itemName, itemCost)
    local xPlayer = ESX.GetPlayerFromId(source)
    local moneyItem = xPlayer.getInventoryItem('money').count

    if moneyItem >= itemCost then
        xPlayer.removeInventoryItem('money', itemCost)
        xPlayer.addInventoryItem(itemName, 1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Nemáš dostatek peněz')
    end
end)
