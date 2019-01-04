package com.mygame.enemies.Forest
{
   import com.general.Amath;
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_34 extends EnemyBase
   {
       
      
      public function En_34()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 15;
         _armature = GV.factory.buildArmature("Anim_4","Forest");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -35;
         hY = -50;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 60;
         maxX = 200;
         attX = 600;
         super.init(param1);
         create_life(0,-140);
      }
      
      override public function Attack() : void
      {
         var _loc1_:Root = null;
         if(GV.heroesArr.length > 0)
         {
            _loc1_ = new Root();
            _loc1_.init(GV.heroesArr[Amath.random(0,GV.heroesArr.length - 1)].x + Amath.random(-50,50),attackPower);
         }
      }
   }
}
