package com.mygame.skills
{
   import com.general.Amath;
   import com.general.IGameObject;
   import dragonBones.Armature;
   import dragonBones.animation.WorldClock;
   import dragonBones.starling.StarlingArmatureDisplay;
   import starling.display.Sprite;
   
   public class mSkillDragon extends Sprite implements IGameObject
   {
       
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      private var _isFree:Boolean = false;
      
      private var _attackTime:int = 0;
      
      private var _endTime:int = 0;
      
      private var _delay:int;
      
      private var _power:int = 0;
      
      private var _isAttack:Boolean = false;
      
      private var _angle:Number = 0;
      
      private var amplitude:Number = 10;
      
      private var posY:int;
      
      private var posX:int;
      
      private var checkTime:int = 0;
      
      private var id:int = -1;
      
      private var dist:int = 2000;
      
      public function mSkillDragon()
      {
         super();
      }
      
      public function init(param1:int) : void
      {
         this._power = param1;
         x = GV.camPos - 700;
         y = this.posY = GV.groundY - 200;
         this._armature = GV.factory.buildArmature("DragonAnim");
         this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         this._armature.animation.play("Wait",99999999999);
         this.touchable = false;
         this._attackTime = GV.real_time + 2000;
         this._endTime = GV.real_time + 15000;
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
         var _loc2_:Sprite = null;
         var _loc3_:int = 0;
         var _loc4_:DragonFire = null;
         if(this._endTime > GV.real_time)
         {
            y = this.posY + Math.sin(this._angle) * this.amplitude;
            this._angle = this._angle + 0.1;
            if(this.checkTime < GV.real_time)
            {
               this.checkTime = GV.real_time + 100;
               if(GV.enemiesArr.length > 0)
               {
                  this.id = -1;
                  this.dist = 9999999990;
                  _loc3_ = GV.enemiesArr.length - 1;
                  while(_loc3_ >= 0)
                  {
                     _loc2_ = GV.enemiesArr[_loc3_];
                     if(_loc2_.x < this.dist && _loc2_.x < GV.camPos + GV.cent_X)
                     {
                        this.dist = _loc2_.x;
                        this.id = _loc3_;
                     }
                     _loc3_--;
                  }
                  if(this.id >= 0)
                  {
                     this.posX = GV.enemiesArr[this.id].x - 200;
                  }
                  else if(GV.heroesArr.length > 0)
                  {
                     this.posX = GV.heroesArr[0].x;
                  }
               }
            }
            x = Amath.Lerp(x,this.posX,0.04);
            if(this._attackTime < GV.real_time)
            {
               if(!this._isAttack)
               {
                  this._isAttack = true;
                  this._delay = 0;
                  this._attackTime = GV.real_time + 2000;
                  this._armature.animation.play("Attack",99999999999);
               }
               else
               {
                  this._isAttack = false;
                  this._attackTime = GV.real_time + 2000;
                  this._armature.animation.play("Wait",99999999999);
               }
            }
            if(this._isAttack && this._delay < GV.real_time && this.id >= 0)
            {
               this._delay = GV.real_time + 100;
               _loc4_ = new DragonFire();
               _loc4_.init(x + 60,y + 20,this._power);
            }
         }
         else
         {
            y = y - 15 * param1;
            if(y < -100)
            {
               this.free();
            }
         }
      }
   }
}
