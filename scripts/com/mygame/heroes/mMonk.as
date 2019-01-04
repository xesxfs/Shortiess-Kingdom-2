package com.mygame.heroes
{
   import com.general.Calc;
   import com.mygame.skills.mSkillDragon;
   import com.mygame.skills.mSkillFireBall;
   import com.mygame.skills.mSkillFireGrownd;
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class mMonk extends HeroBase
   {
       
      
      private var numSpell:int;
      
      public function mMonk()
      {
         super();
         index = 2;
         _armature = GV.factory.buildArmature("MonkAnim");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         init_weapon();
         init_head();
         level = GV["her" + index][0];
         curHP = maxHP = Calc.monk_hp(level) + Calc.monk_hp_extra(level,_idHead);
         attackPower = Calc.monk_power(level) + Calc.stick_power(level,_idWeapon) + Calc.monk_power(level) * GV.heads0[_idHead][5] / 100;
         _delayAttack = 3000;
         _delayReturn = 0;
         accX = 2;
         minX = 300;
         maxX = 350;
         attX = 400;
         super.init();
      }
      
      override public function Jump() : void
      {
      }
      
      override public function Attack() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = 1;
         var _loc2_:Number = -1;
         var _loc4_:int = GV.heroesArr.length - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = GV.heroesArr[_loc4_]["curHP"] / GV.heroesArr[_loc4_]["maxHP"];
            if(_loc3_ < _loc1_)
            {
               _loc1_ = _loc3_;
               _loc2_ = _loc4_;
            }
            _loc4_--;
         }
         if(_loc2_ != -1)
         {
            GV.sound.playSFX("heal");
            GV.heroesArr[_loc2_]["Healing"](GV.heroesArr[_loc2_]["maxHP"] * 0.1);
         }
      }
      
      public function Skill_1(param1:int) : void
      {
         StartSkill(param1);
         this.numSpell = 1;
      }
      
      public function Skill_2(param1:int) : void
      {
         StartSkill(param1);
         this.numSpell = 2;
      }
      
      public function Skill_3(param1:int) : void
      {
         StartSkill(param1);
         this.numSpell = 3;
      }
      
      public function Skill_4(param1:int) : void
      {
         StartSkill(param1);
         this.numSpell = 4;
      }
      
      override public function SkillAction() : void
      {
         switch(this.numSpell)
         {
            case 1:
               this.FireBall(attackPower * 6 * spellPower);
               break;
            case 2:
               this.FireGrownd(attackPower * 0.5 * spellPower);
               break;
            case 3:
               this.Dino(attackPower * 0.2 * spellPower);
               break;
            case 4:
               this.Rage(2,17);
         }
      }
      
      public function FireBall(param1:int) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:mSkillFireBall = null;
         var _loc2_:int = 2000;
         var _loc3_:int = -1;
         var _loc4_:int = GV.enemiesArr.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = GV.enemiesArr[_loc4_];
            if(_loc5_.x - x < _loc2_)
            {
               _loc2_ = _loc5_.x - x;
               _loc3_ = _loc4_;
            }
            _loc4_--;
         }
         if(_loc3_ >= 0)
         {
            _loc6_ = new mSkillFireBall();
            _loc6_.init(GV.enemiesArr[_loc3_].x - 250,param1);
         }
      }
      
      public function FireGrownd(param1:Number) : void
      {
         var _loc3_:mSkillFireGrownd = null;
         var _loc2_:int = GV.enemiesArr.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = new mSkillFireGrownd();
            _loc3_.init(GV.enemiesArr[_loc2_],param1);
            _loc2_--;
         }
      }
      
      public function Dino(param1:Number) : void
      {
         var _loc2_:mSkillDragon = new mSkillDragon();
         _loc2_.init(param1);
      }
      
      public function Rage(param1:Number, param2:int) : void
      {
         var _loc3_:int = GV.heroesArr.length - 1;
         while(_loc3_ >= 0)
         {
            GV.heroesArr[_loc3_]["ExtraPower"](param1);
            _loc3_--;
         }
         GV.LM._tMenu.ExtraPower(param2);
      }
   }
}
