package com.mygame.enemies.desert
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_26 extends EnemyBase
   {
       
      
      public function En_26()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 30;
         _armature = GV.factory.buildArmature("enDesert_01","Desert");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -35;
         hY = -50;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 60;
         maxX = 120;
         attX = 140;
         super.init(param1);
         create_life(0,-80);
         y = posY + 150;
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
      
      override public function YposUpdate(param1:Number) : void
      {
         if(y > posY)
         {
            y = y - 15 * param1;
         }
         else
         {
            y = posY;
            curSpeedY = 0;
         }
      }
   }
}
