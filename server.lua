-- Server-side script for FiveMScript

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Register server events here
RegisterNetEvent('fivemscript:serverEvent')
AddEventHandler('fivemscript:serverEvent', function(args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        -- Handle server event
        print('Server event received from player ' .. _source .. ': ' .. json.encode(args))

        -- Example database operation
        MySQL.Async.execute('INSERT INTO ' .. Config.Database.TableName .. ' (player_id, data_value) VALUES (@player_id, @data_value)', {
            ['@player_id'] = xPlayer.identifier,
            ['@data_value'] = 'example_value'
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print('Database operation successful')
            else
                print('Database operation failed')
            end
        end)
    end
end)

-- Register callbacks here
ESX.RegisterServerCallback('fivemscript:getData', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM ' .. Config.Database.TableName .. ' WHERE player_id = @player_id', {
            ['@player_id'] = xPlayer.identifier
        }, function(result)
            cb(result)
        end)
    else
        cb(nil)
    end
end)