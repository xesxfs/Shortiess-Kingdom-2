package com.mygame.enemies.desert
{
   import com.general.Amath;
   import com.mygame.effects.Effect;
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_25 extends EnemyBase
   {
       
      
      public function En_25()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 10;
         _armature = GV.factory.buildArmature("enDesert_05","Desert");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -40;
         hY = -100;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 60;
         maxX = 180;
         attX = 250;
         super.init(param1);
         create_life(0,-110);
      }
      
      override public function Attack() : void
      {
         GV.game.shake();
         var _loc1_:Effect = new Effect();
         _loc1_.init(x + 60,y - 10,"DustBull",24);
         _loc1_ = new Effect();
         _loc1_.init(x - 60,y - 10,"DustBull",24);
         _loc1_.scaleX = -1;
         var _loc2_:int = GV.heroesArr.length - 1;
         while(_loc2_ >= 0)
         {
            en = GV.heroesArr[_loc2_];
            GV.heroesArr[_loc2_]["punch"](Amath.random(5,20));
            GV.heroesArr[_loc2_]["PhysicalDamage"](attackPower + Amath.random(-attackPower * 0.2,attackPower * 0.2));
            _loc2_--;
         }
      }
   }
}
