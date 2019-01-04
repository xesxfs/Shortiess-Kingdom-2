package com.mygame.enemies.desert
{
   import com.mygame.effects.Effect;
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_23 extends EnemyBase
   {
       
      
      var _num:int = 5;
      
      public function En_23()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 8;
         _armature = GV.factory.buildArmature("enDesert_03","Desert");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -35;
         hY = -50;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 200;
         maxX = 310;
         attX = 400;
         super.init(param1);
         create_life(0,-80);
      }
      
      override public function Attack() : void
      {
         var _loc1_:En_26 = null;
         var _loc2_:Effect = null;
         if(this._num > 0)
         {
            this._num--;
            _loc1_ = new En_26();
            _loc1_.init(this.x - GV.scr_X);
            _loc1_._curState = "Attack";
            return;
         }
         _loc2_ = new Effect();
         _loc2_.init(x + 20,y - 20,"Smoke1_",24);
         GV.freeExp = GV.freeExp + exp;
         GV.freeCoins = GV.freeCoins + coins;
         free();
      }
   }
}
