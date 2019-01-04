package com.mygame.enemies.Black
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_55 extends EnemyBase
   {
       
      
      public function En_55()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 28;
         _armature = GV.factory.buildArmature("Anim_5","Black");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -45;
         hY = -100;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 80;
         maxX = 140;
         attX = 200;
         super.init(param1);
         create_life(0,-140);
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
