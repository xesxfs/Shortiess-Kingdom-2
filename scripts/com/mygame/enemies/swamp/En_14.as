package com.mygame.enemies.swamp
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_14 extends EnemyBase
   {
       
      
      public function En_14()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 3;
         _armature = GV.factory.buildArmature("Anim_04","Swamp");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -60;
         hY = -80;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 200;
         maxX = 310;
         attX = 600;
         super.init(param1);
         create_life(0,-80);
      }
      
      override public function Attack() : void
      {
         var _loc1_:PoisinBullet = new PoisinBullet();
         _loc1_.init(x - 10,y - 30,attackPower,"PoisonBullet0000");
      }
   }
}
