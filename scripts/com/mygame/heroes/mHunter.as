package com.mygame.heroes
{
   import com.general.Amath;
   import com.general.Calc;
   import com.mygame.skills.mSkillKaban;
   import com.mygame.skills.mSkillKapkan;
   import com.mygame.skills.mSkillTornado;
   import com.mygame.skills.mSkill_Arrows;
   import dragonBones.starling.StarlingArmatureDisplay;
   import starling.events.EnterFrameEvent;
   
   public class mHunter extends HeroBase
   {
       
      
      private var numShots:int = 0;
      
      private var timeShot:int = 0;
      
      private var powerShot:int = 0;
      
      public function mHunter()
      {
         super();
         index = 1;
         _armature = GV.factory.buildArmature("Hunter_0_Anim");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         init_weapon();
         init_head();
         level = GV["her" + index][0];
         curHP = maxHP = Calc.hunter_hp(level) + Calc.hunter_hp_extra(level,_idHead);
         attackPower = Calc.hunter_power(level) + Calc.bow_power(level,_idWeapon) + Calc.hunter_power(level) * GV.heads0[_idHead][5] / 100;
         _delayAttack = 1300;
         _delayReturn = 400;
         accX = 3;
         minX = 200;
         maxX = 250;
         attX = 300;
         super.init();
      }
      
      override public function Attack() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = GV.camPos + 500;
         var _loc2_:int = GV.enemiesArr.length - 1;
         while(_loc2_ >= 0)
         {
            if(GV.enemiesArr[_loc2_].x < _loc1_)
            {
               _loc1_ = GV.enemiesArr[_loc2_].x;
            }
            _loc2_--;
         }
         GV.sound.bow();
         var _loc3_:MyArrow = new MyArrow();
         if(Math.random() < crit)
         {
            _loc3_.init(x + 45,y - 20,_loc1_,GV.groundY + 20,attackPower * 2,"Arrow000" + 0,true);
            GV.hunter = GV.hunter + attackPower * 2;
            GV.sound.damage();
         }
         else
         {
            _loc4_ = Amath.random(-20,20);
            _loc3_.init(x + 45,y - 20,_loc1_,GV.groundY + 20,attackPower * extrPower + attackPower * _loc4_ / 100,"Arrow000" + 0,false);
            GV.hunter = GV.hunter + (attackPower * extrPower + attackPower * _loc4_ / 100);
            GV.sound.damage();
         }
      }
      
      public function Skill_1(param1:int) : void
      {
         StartSkill(param1);
      }
      
      public function Skill_2(param1:int) : void
      {
         var _loc2_:mSkillTornado = new mSkillTornado();
         _loc2_.init(x - 50,attackPower / 3 * spellPower);
      }
      
      public function Skill_3(param1:int) : void
      {
         var _loc2_:mSkillKaban = new mSkillKaban();
         _loc2_.init(6,attackPower * spellPower);
      }
      
      public function Skill_4(param1:int) : void
      {
         var _loc3_:mSkillKapkan = null;
         var _loc2_:int = GV.enemiesArr.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = new mSkillKapkan();
            _loc3_.init(GV.enemiesArr[_loc2_],8);
            _loc2_--;
         }
      }
      
      override public function SkillAction() : void
      {
         this.Spell_Rain(attackPower * spellPower);
      }
      
      private function Spell_Rain(param1:int) : void
      {
         this.powerShot = param1;
         this.numShots = 10;
         this.timeShot = 0;
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.ArrowRain);
      }
      
      private function ArrowRain() : void
      {
         var _loc1_:mSkill_Arrows = null;
         if(this.timeShot < GV.real_time)
         {
            this.timeShot = GV.real_time + 100;
            if(this.numShots > 0)
            {
               this.numShots--;
               _loc1_ = new mSkill_Arrows();
               _loc1_.init(Amath.random(GV.camPos - 200,GV.camPos + 200),this.powerShot);
               GV.sound.bow();
            }
            else
            {
               removeEventListener(EnterFrameEvent.ENTER_FRAME,this.ArrowRain);
            }
         }
      }
      
      override public function sound_attack() : void
      {
      }
   }
}
