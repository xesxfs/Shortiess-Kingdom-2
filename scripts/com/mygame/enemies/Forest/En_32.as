package com.mygame.enemies.Forest
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_32 extends EnemyBase
   {
       
      
      public function En_32()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 13;
         _armature = GV.factory.buildArmature("Anim_2","Forest");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -35;
         hY = -50;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 200;
         maxX = 310;
         attX = 600;
         super.init(param1);
         create_life(0,-80);
      }
      
      override public function Attack() : void
      {
         var _loc1_:int = GV.camPos - 200;
         var _loc2_:int = GV.heroesArr.length - 1;
         while(_loc2_ >= 0)
         {
            if(GV.heroesArr[_loc2_].x > _loc1_)
            {
               _loc1_ = GV.heroesArr[_loc2_].x + 20;
            }
            _loc2_--;
         }
         var _loc3_:Bomb = new Bomb();
         _loc3_.init(x - 30,y - 20,_loc1_,GV.groundY + 20,attackPower);
      }
   }
}
