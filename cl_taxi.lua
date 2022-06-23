ESX = nil

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    PlayerLoaded = true
    ESX.PlayerData = ESX.GetPlayerData()
end)


--------------------------- Vestiaire 

local vestiairetaxi = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255,255,255}, Title = "Taxi" },
    Data = { currentMenu = "Vestiaire :", "Test"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result, slide)
            if btn.slidenum == 1 and btn.name == "Tenue Service" then
                TriggerEvent('skingchanger:getSkin', function(skin)
                    if skin.sex == 0 then 
                        TriggerEvent('skinchanger:loadClothes', skin, Taxi.tenue.m)
                    elseif skin.sex == 1 then
                        TriggerEvent('skinchanger:loadClothes', skin, Taxi.tenue.f) 
                    end
                end)
            elseif btn.slidenum == 2 and btn.name == "Tenue Service" then 
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
            end
        end,
    },

    Menu = {
        ["Vestiaire :"] = {
            b = {
                {name = "Tenue Service", slidemax = {"[ ~g~+ ~s~Mettre sa tenue ]","[ ~r~- ~s~Poser sa tenue ]"}}
            }
        }
    }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k,v in pairs(Taxi.pos.vestiaire) do
            if Vdist2(GetEntityCoords(PlayerPedId(), false), v.x,v.y,v.z ) <= 2 and ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
                DrawMarker(6, v.x, v.y, v.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 255, 249, 51, 200)
                if IsControlJustPressed(1,38) then 
                   CreateMenu(vestiairetaxi)
                end
            end
        end        
    end
end)