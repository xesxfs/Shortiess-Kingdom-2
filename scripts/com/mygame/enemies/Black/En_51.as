package com.mygame.enemies.Black
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_51 extends EnemyBase
   {
       
      
      public function En_51()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 24;
         _armature = GV.factory.buildArmature("Anim_1","Black");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -45;
         hY = -100;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 80;
         maxX = 120;
         attX = 140;
         super.init(param1);
         create_life(0,-80);
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
