package com.mygame.heroes
{
   import com.general.Amath;
   import com.general.Calc;
   import com.mygame.effects.Effect;
   import com.mygame.skills.mSkillGrass;
   import com.mygame.skills.mSkillSpinner;
   import com.mygame.skills.mSpellSplash;
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class mKnight extends HeroBase
   {
       
      
      public function mKnight()
      {
         super();
         index = 0;
         _armature = GV.factory.buildArmature("Khight_0_Anim","Warriors");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         init_weapon();
         init_head();
         level = GV["her" + index][0];
         curHP = maxHP = Calc.knight_hp(level) + Calc.knight_hp_extra(level,_idHead);
         attackPower = Calc.knight_power(level) + Calc.sword_power(level,_idWeapon) + Calc.knight_power(level) * GV.heads0[_idHead][5] / 100;
         _delayAttack = 300;
         _delayReturn = 600;
         minX = 80;
         maxX = 100;
         attX = 150;
         super.init();
      }
      
      override public function Attack() : void
      {
         var _loc4_:Effect = null;
         var _loc5_:int = 0;
         var _loc1_:int = 2000;
         var _loc2_:int = -1;
         var _loc3_:int = GV.enemiesArr.length - 1;
         while(_loc3_ >= 0)
         {
            en = GV.enemiesArr[_loc3_];
            if(en.x - x < _loc1_ && x + attX > en["hitbox"].x)
            {
               _loc1_ = en.x - x;
               _loc2_ = _loc3_;
            }
            _loc3_--;
         }
         if(_loc2_ >= 0)
         {
            if(Math.random() < crit)
            {
               GV.enemiesArr[_loc2_]["punch"](40);
               GV.enemiesArr[_loc2_]["PhysicalDamage"](attackPower * 2,true);
               GV.knight = GV.knight + attackPower * 2;
            }
            else
            {
               _loc5_ = Amath.random(-20,20);
               GV.enemiesArr[_loc2_]["punch"](Amath.random(0,20));
               GV.enemiesArr[_loc2_]["PhysicalDamage"](attackPower * extrPower + attackPower * _loc5_ / 100,false);
               GV.knight = GV.knight + (attackPower * extrPower + attackPower * _loc5_ / 100);
            }
            GV.sound.damage();
            _loc4_ = new Effect();
            _loc4_.init(x + 100,y - 10,"BladeEff",12);
            _loc4_.rotation = Amath.random(-5,5) / 10;
         }
      }
      
      public function Skill_1(param1:int) : void
      {
         StartSkill(param1);
      }
      
      public function Skill_2(param1:int) : void
      {
         this.Spell_Spinner(attackPower * 0.5 * spellPower);
      }
      
      public function Skill_3(param1:int) : void
      {
         this.Spell_Spikes(attackPower * 2 * spellPower);
      }
      
      public function Skill_4(param1:int) : void
      {
         this.Spell_Shield(0,8);
      }
      
      override public function SkillAction() : void
      {
         GV.game.shake();
         this.Spell_Blade(attackPower * 5 * spellPower);
      }
      
      private function Spell_Blade(param1:int) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         GV.sound.playSFX("blade");
         var _loc2_:int = GV.enemiesArr.length - 1;
         while(_loc2_ >= 0)
         {
            _loc4_ = GV.enemiesArr[_loc2_];
            _loc5_ = _loc4_["hitbox"].x - x;
            if(_loc5_ < 150)
            {
               GV.enemiesArr[_loc2_]["punch"](50);
               GV.enemiesArr[_loc2_]["PhysicalDamage"](param1,false);
               GV.knight = GV.knight + param1;
            }
            else if(_loc5_ < 200)
            {
            }
            _loc2_--;
         }
         var _loc3_:mSpellSplash = new mSpellSplash();
         _loc3_.init(x + 50);
      }
      
      private function Spell_Shield(param1:Number, param2:int) : void
      {
         var _loc3_:int = GV.heroesArr.length - 1;
         while(_loc3_ >= 0)
         {
            GV.heroesArr[_loc3_]["IrionShield"](param1);
            _loc3_--;
         }
         GV.LM._tMenu.IronShieldTimer(param2);
      }
      
      private function Spell_Spinner(param1:int) : void
      {
         var _loc2_:mSkillSpinner = new mSkillSpinner();
         _loc2_.init(this,param1);
      }
      
      private function Spell_Spikes(param1:int) : void
      {
         var _loc2_:int = 2000;
         var _loc3_:int = -1;
         var _loc4_:int = GV.enemiesArr.length - 1;
         while(_loc4_ >= 0)
         {
            en = GV.enemiesArr[_loc4_];
            if(en.x - x < _loc2_ && en["hitbox"].x < GV.camPos + 400)
            {
               _loc2_ = en.x - x;
               _loc3_ = _loc4_;
            }
            _loc4_--;
         }
         var _loc5_:mSkillGrass = new mSkillGrass();
         if(_loc3_ >= 0)
         {
            _loc5_.init(GV.enemiesArr[_loc3_].x,param1);
         }
         else
         {
            _loc5_.init(GV.heroesArr[0].x + 300,param1);
         }
      }
   }
}
