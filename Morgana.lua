Config = scriptConfig("Morgana", "Morgana:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal:")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
 
 
myIAC = IAC()
 
OnLoop(function(myHero)
Drawings()
Killsteal()
 
        if IWalkConfig.Combo then
              local target = GetTarget(1000, DAMAGE_MAGIC)
                if ValidTarget(target, 1000) then
                       
                       
                        local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,500,GetCastRange(myHero,_Q),80,true,true)
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_Q)) and Config.Q then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                        end
						local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1100,250,GetCastRange(myHero,_W),175,false,false)
						if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_W)) and Config.W then
						CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
						end
						if CanUseSpell(myHero, _R) == READY and ValidTarget(target, GetCastRange(myHero,_R)) and IsInDistance(target, 600) and Config.R then
                        CastSpell(_R)
						end
                end
        end
end)
 
OnLoop(function(myHero)
 
       
end)
 
function Killsteal()
        for i,enemy in pairs(GetEnemyHeroes()) do
            local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,GetCastRange(myHero,_Q),80,true,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_Q)) and KSConfig.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (50*GetCastLevel(myHero,_Q)+10+GetBonusAP(myHero))) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
end
 
function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
end
