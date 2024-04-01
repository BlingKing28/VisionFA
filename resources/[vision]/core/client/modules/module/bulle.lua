Bulle = {
    bulle = {},
    add = function (nomn, pos, bulles, actions_)
        local newBulle = {
            pos = pos,
            bulle = bulles,
            actions = actions_
        }
        Bulle.bulle[nomn] = newBulle
    end,

    remove = function(nom)
        Bulle.bulle[nom] = nil
    end,
}

Citizen.CreateThread(function()
    while p == nil do Wait(1000) end
    while true do
        local pNear = false

        for k, v in pairs(Bulle.bulle) do
            local dst = GetDistanceBetweenCoords(p:pos(), v.pos, true)

            if dst <= 20.0 then
                pNear = true
                v.bulle()
                if dst <= 3.0 then 
                    if IsControlJustPressed(0, 38) then 
                        v.actions()
                    end
                end
            end
        end

        if pNear then
            Wait(1)
        else
            Wait(500)
        end
    end
end)

-- local alpha1 = 255
-- local alpha2 = 0
local init = {}
local Alpha1 = {}
local Alpha2 = {}

function RobertoBulle(name, pos, textName, alpha1, alpha2)
    if not init[name] then
        init[name] = true
        Alpha1[name] = alpha1
        Alpha2[name] = alpha2
    end
    while p == nil do Wait(1) end
    if #(p:pos() - pos) < 20 then
        if #(p:pos() - pos) < 3 then
            if Alpha1[name] > 0 then
                Alpha1[name] = Alpha1[name] - 6
            end
            if Alpha1[name] <= 100 then
                if Alpha2[name] < 255 then
                    Alpha2[name] = Alpha2[name] + 6
                end
            end
        else
            if Alpha2[name] <= 100 then
                if Alpha1[name] < 255 then
                    Alpha1[name] = Alpha1[name] + 6
                end
            end

            if Alpha2[name] > 0 then
                Alpha2[name] = Alpha2[name] - 6
            end
        end
        local w, h = Modules.UI.ConvertToPixel(14, 15)
        Modules.UI.DrawSprite3dNoDownSize({pos = pos,textureDict = "interact",textureName ="icon",x = 0,y = 0,width = w,height = h,r = 255,g = 255,b = 255,a = Round(Alpha1[name])})
        local w, h = Modules.UI.ConvertToPixel(120, 20)
        Modules.UI.DrawSprite3dNoDownSize({pos = pos,textureDict = "interact",textureName = textName,x = 0,y = 0,width = w,height = h,r = 255,g = 255,b = 255,a = Round(Alpha2[name])})
    end
end

