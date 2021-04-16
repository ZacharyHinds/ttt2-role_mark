AddCSLuaFile()

SWEP.HoldType = "grenade"

if CLIENT then
   SWEP.PrintName = "Marker Grenade"
   SWEP.Author = "Wasted"
   SWEP.Instructions = "Throw grenade with primary fire"
   SWEP.Slot = 3

   SWEP.ViewModelFlip = false
   SWEP.ViewModelFOV = 54

   SWEP.Icon = "vgui/ttt/icon_nades"
   SWEP.IconLetter = "h"

   SWEP.EquipMenuData = {
     type = "item_weapon",
     name = "ttt2_markernade_name",
     desc = "ttt2_markernade_desc"
   }
end

SWEP.Base = "weapon_tttbasegrenade"

-- SWEP.WeaponID = AMMO_DISCOMB
SWEP.Kind = WEAPON_NONE

SWEP.Spawnable = false
SWEP.AutoSpawnable = false

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel = "models/weapons/w_eq_fraggrenade.mdl"

SWEP.Weight = 5

-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "ttt2_markernade_proj"
end
