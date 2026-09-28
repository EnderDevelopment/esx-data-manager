-- Client-side script for FiveMScript

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    -- Register client events here
    RegisterNetEvent('fivemscript:clientEvent')
    AddEventHandler('fivemscript:clientEvent', function(data)
        -- Handle client event
        print('Client event received: ' .. json.encode(data))
    end)

    -- Register commands here
    RegisterCommand('fivemscript', function(source, args)
        TriggerServerEvent('fivemscript:serverEvent', args)
    end, false)

    -- Register UI elements here
    -- Example: RageUI or NativeUI elements
end)