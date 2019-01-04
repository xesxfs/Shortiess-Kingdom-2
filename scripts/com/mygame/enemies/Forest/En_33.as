package com.mygame.enemies.Forest
{
   import com.mygame.effects.Effect;
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_33 extends EnemyBase
   {
       
      
      public function En_33()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 14;
         _armature = GV.factory.buildArmature("Anim_3","Forest");
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
         var _loc3_:Number = NaN;
         var _loc5_:Effect = null;
         var _loc1_:Number = 1;
         var _loc2_:Number = -1;
         var _loc4_:int = GV.enemiesArr.length - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = GV.enemiesArr[_loc4_]["curHP"] / GV.enemiesArr[_loc4_]["maxHP"];
            if(_loc3_ < _loc1_)
            {
               _loc1_ = _loc3_;
               _loc2_ = _loc4_;
            }
            _loc4_--;
         }
         if(_loc2_ != -1)
         {
            GV.enemiesArr[_loc2_]["Healing"](GV.enemiesArr[_loc2_]["maxHP"] * 0.1);
         }
         if(GV.enemiesArr.length == 1)
         {
            _loc5_ = new Effect();
            _loc5_.init(x + 20,y - 20,"Smoke1_",24);
            GV.freeExp = GV.freeExp + exp;
            GV.freeCoins = GV.freeCoins + coins;
            free();
            return;
         }
      }
   }
}
