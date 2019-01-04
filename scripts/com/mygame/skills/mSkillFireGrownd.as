package com.mygame.skills
{
   import com.general.IGameObject;
   import starling.display.Sprite;
   import starling.extensions.PDParticleSystem;
   
   public class mSkillFireGrownd extends Sprite implements IGameObject
   {
       
      
      public var _fire:PDParticleSystem;
      
      private var _isFree:Boolean = false;
      
      private var _isEnd = false;
      
      public var _time:int = 0;
      
      private var _power:int = 0;
      
      private var _distance:int = 0;
      
      private var _posX:int = 0;
      
      private var _enemy:Sprite;
      
      public function mSkillFireGrownd()
      {
         super();
      }
      
      public function init(param1:Sprite, param2:int) : void
      {
         this._enemy = param1;
         this._power = param2;
         x = this._enemy.x;
         y = GV.groundY + 14;
         this._fire = new PDParticleSystem(GV.assets.getXml("FireGround"),GV.assets.getTexture("PartFire0000"));
         this._fire.start();
         this._fire.emitterXVariance = this._enemy["hitbox"].width / 2;
         this._fire.capacity = int(this._enemy["hitbox"].width / 5);
         addChild(this._fire);
         GV.juggler.add(this._fire);
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_2.addChildAt(this,0);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            GV.game.objs.remove(this);
            this._fire.stop();
            this._fire.removeFromParent(true);
            GV.juggler.remove(this._fire);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         if(!this._isEnd)
         {
            if(this._enemy == null || this._enemy["_isFree"])
            {
               this._isEnd = true;
               this._time = GV.real_time + 600;
               this._fire.stop();
               return;
            }
            x = this._enemy.x;
            if(this._time < GV.real_time)
            {
               this._enemy["PhysicalDamage"](this._power,false);
               this._time = GV.real_time + 1000;
               GV.monk = GV.monk + this._power;
            }
         }
         else if(this._time < GV.real_time)
         {
            this.free();
         }
      }
   }
}
