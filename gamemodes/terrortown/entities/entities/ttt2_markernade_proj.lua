AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "ttt_basegrenade_proj"
ENT.Model = Model("models/weapons/w_eq_fraggrenade_thrown.mdl")

-- local ttt_allow_jump = CreateConVar("ttt_allow_discomb_jump", "0")

local function PaintRadius(pos, painter)
  local radius = 200

  local plys = ents.FindInSphere(pos, radius)
  for i = 1, #plys do
    local ply = plys[i]
    if not IsValid(ply) then continue end
    if ply:IsPlayer() and ply:Alive() and not ply:IsSpec() and not ply:HasTeam(TEAM_MARKER) then
      MARKER_DATA:SetMarkedPlayer(ply)
    end
  end
  -- MARKER_DATA:UpdateAfterChange()

  local phexp = ents.Create("env_physexplosion")
  if IsValid(phexp) then
    phexp:SetPos(pos)
    phexp:SetKeyValue("magnitude", 50) --max
    phexp:SetKeyValue("radius", radius)
    -- 1 = no dmg, 2 = push ply, 4 = push radial, 8 = los, 16 = viewpunch
    phexp:SetKeyValue("spawnflags", 1 + 16)
    phexp:Spawn()
    phexp:Fire("Explode", "", 0.2)
  end
  --Create Smoke on client
end

local paintsound = Sound("marker/pbhit.wav")
function ENT:Explode(tr)
  if SERVER then
    self:SetNoDraw(true)
    self:SetSolid(SOLID_NONE)

    if tr.Fraction != 1.0 then
      self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
    end

    local pos = self:GetPos()

    self:Remove()

    PaintRadius(pos, self:GetThrower())

    local effect = EffectData()
    effect:SetStart(pos)
    effect:SetOrigin(pos)

    if tr.Fraction != 1.0 then
      effect:SetNormal(tr.HitNormal)
    end

    util.Effect("Explosion", effect, true, true)
    util.Effect("cball_explode", effect, true, true)

    sound.Play(paintsound, pos, 100, 100)
  else
    local spos = self:GetPos()
    local trs = util.TraceLine({start = spos + Vector(0, 0, 64), endpos = spos + Vector(0, 0, -128), filter = self})
    util.Decal("splat" .. math.random(1, 12), trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)

    self:SetDetonateExact(0)
  end
end
