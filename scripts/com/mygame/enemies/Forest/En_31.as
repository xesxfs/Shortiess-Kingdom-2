package com.mygame.enemies.Forest
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   
   public class En_31 extends EnemyBase
   {
       
      
      private var _angle:Number = 0;
      
      private var amplitude:Number = 10;
      
      public function En_31()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 12;
         _armature = GV.factory.buildArmature("Anim_1","Forest");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
         hX = -35;
         hY = -50;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 80;
         maxX = 100;
         attX = 130;
         super.init(param1);
         create_life(0,-80);
         posY = y;
      }
      
      override public function update(param1:Number) : *
      {
         y = posY + Math.sin(this._angle) * this.amplitude;
         this._angle = this._angle + 0.2;
         super.update(param1);
      }
      
      override public function YposUpdate(param1:Number) : void
      {
      }
      
      override public function Jump() : void
      {
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
