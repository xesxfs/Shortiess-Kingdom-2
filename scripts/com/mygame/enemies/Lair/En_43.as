package com.mygame.enemies.Lair
{
   import com.general.Amath;
   import com.mygame.enemies.EnemyBase;
   import com.mygame.enemies.swamp.EnArrow;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_43 extends EnemyBase
   {
       
      
      public function En_43()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 20;
         _armature = GV.factory.buildArmature("Anim_3","Lair");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -45;
         hY = -100;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 60;
         maxX = 260;
         attX = 400;
         super.init(param1);
         create_life(0,-80);
      }
      
      override public function Attack() : void
      {
         var _loc1_:EnArrow = new EnArrow();
         if(GV.heroesArr.length > 0)
         {
            en = GV.heroesArr[Amath.random(0,GV.heroesArr.length - 1)];
            _loc1_.init(x - 30,y - 50,en.x - 30,GV.groundY - 20,attackPower,"PigArrow0000");
         }
         else
         {
            _loc1_.init(x - 30,y - 50,x - 300,GV.groundY - 20,attackPower,"PigArrow0000");
         }
      }
   }
}
