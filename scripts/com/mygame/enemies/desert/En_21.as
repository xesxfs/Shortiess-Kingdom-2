package com.mygame.enemies.desert
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_21 extends EnemyBase
   {
       
      
      public function En_21()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 6;
         _armature = GV.factory.buildArmature("enDesert_01","Desert");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -35;
         hY = -50;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 80;
         maxX = 100;
         attX = 120;
         super.init(param1);
         create_life(0,-80);
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
