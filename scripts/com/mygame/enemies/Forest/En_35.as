package com.mygame.enemies.Forest
{
   import com.general.Amath;
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_35 extends EnemyBase
   {
       
      
      public function En_35()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 16;
         _armature = GV.factory.buildArmature("Anim_5","Forest");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -35;
         hY = -50;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 60;
         maxX = 140;
         attX = 180;
         super.init(param1);
         create_life(0,-150);
      }
      
      override public function Attack() : void
      {
         var _loc1_:int = GV.heroesArr.length - 1;
         while(_loc1_ >= 0)
         {
            en = GV.heroesArr[_loc1_];
            if(x - attX < en.x)
            {
               GV.heroesArr[_loc1_]["punch"](Amath.random(5,20));
               GV.heroesArr[_loc1_]["PhysicalDamage"](attackPower + Amath.random(-attackPower * 0.2,attackPower * 0.2));
            }
            _loc1_--;
         }
      }
   }
}
