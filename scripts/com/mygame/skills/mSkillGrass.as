package com.mygame.skills
{
   import com.general.IGameObject;
   import dragonBones.Armature;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import flash.geom.Rectangle;
   import starling.display.Sprite;
   
   public class mSkillGrass extends Sprite implements IGameObject
   {
       
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      private var _isFree:Boolean = false;
      
      private var attackbox:Rectangle;
      
      private var _time:int;
      
      private var _soundtime:int = 0;
      
      private var _sound_num = 6;
      
      private var _num:int = 5;
      
      private var _power:int = 5;
      
      private var _en:Sprite;
      
      public function mSkillGrass()
      {
         super();
      }
      
      public function init(param1:int, param2:int) : void
      {
         this._power = param2;
         x = param1 + 20;
         y = GV.groundY - 20;
         this._armature = GV.factory.buildArmature("Grass");
         this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
         this._armatureDisplay.y = 30;
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         this._armature.animation.play("Attack");
         this.attackbox = new Rectangle(0,0,150,150);
         this._time = GV.real_time + 500;
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_1.addChildAt(this,0);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            WorldClock.clock.remove(this._armature);
            removeChild(this._armatureDisplay);
            this._armatureDisplay = null;
            this._armature = null;
            this.removeFromParent(true);
            GV.game.objs.remove(this);
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = 0;
         this.attackbox.x = this.x - 75;
         this.attackbox.y = this.y - 100;
         if(this._soundtime < GV.real_time && this._sound_num > 0)
         {
            this._soundtime = GV.real_time + 100;
            this._sound_num--;
            GV.sound.playSFX("steel2");
         }
         if(this._time < GV.real_time && this._num > 0)
         {
            this._num--;
            this._time = GV.real_time + 200;
            _loc2_ = 0;
            while(_loc2_ < GV.enemiesArr.length)
            {
               this._en = GV.enemiesArr[_loc2_];
               if(this.attackbox.intersects(this._en["hitbox"]))
               {
                  this._en["PhysicalDamage"](this._power,false);
                  GV.knight = GV.knight + this._power;
               }
               _loc2_++;
            }
         }
      }
      
      public function _animationHandler(param1:StarlingEvent) : void
      {
         this.free();
      }
   }
}
