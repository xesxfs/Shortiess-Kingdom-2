package com.mygame.skills
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import com.general.IGameObject;
   import flash.geom.Rectangle;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class DragonFire extends Sprite implements IGameObject
   {
       
      
      public var _mc:MovieClip;
      
      private var _isFree:Boolean = false;
      
      private var _isGround:Boolean = false;
      
      private var attackbox:Rectangle;
      
      public var _time:int = 0;
      
      private var _delay:int = 0;
      
      private var _damage:int = 0;
      
      private var _state:int = 0;
      
      private var speedX:int = 0;
      
      public function DragonFire()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:int) : void
      {
         x = param1;
         y = param2;
         this._damage = param3;
         this._mc = new MovieClip(GV.assets.getTextures("DragonFlame"),12);
         this._mc.x = -22;
         this._mc.y = -22;
         addChild(this._mc);
         this._mc.play();
         GV.juggler.add(this._mc);
         this.scale = 0.5;
         Tweener.addTween(this,{
            "scale":1,
            "time":0.2,
            "transition":"linear"
         });
         this.attackbox = new Rectangle(0,0,60,60);
         this._time = GV.real_time + 2000;
         this.touchable = false;
         this.speedX = Amath.random(40,50);
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            Tweener.removeTweens(this);
            this._isFree = true;
            GV.game.objs.remove(this);
            GV.juggler.remove(this._mc);
            this._mc.removeFromParent(true);
            this._mc = null;
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:int = 0;
         this.attackbox.x = x - 30;
         this.attackbox.y = y - 30;
         if(this._state == 0)
         {
            if(!this._isGround)
            {
               x = x + this.speedX * param1;
               y = y + 50 * param1;
               if(y > GV.groundY)
               {
                  this._isGround = true;
                  this.rotation = Amath.random(-15,15) / 10;
               }
            }
            else
            {
               x = x + this.speedX / 2 * param1;
            }
            if(this._delay < GV.real_time)
            {
               _loc3_ = 0;
               while(_loc3_ < GV.enemiesArr.length)
               {
                  _loc2_ = GV.enemiesArr[_loc3_];
                  if(this.attackbox.intersects(_loc2_["hitbox"]))
                  {
                     _loc2_["PhysicalDamage"](this._damage,false);
                     GV.monk = GV.monk + this._damage;
                  }
                  _loc3_++;
               }
               this._delay = GV.real_time + 400;
            }
            if(this._time < GV.real_time)
            {
               this._state = 1;
               Tweener.addTween(this,{
                  "scale":0,
                  "time":0.5,
                  "transition":"linear",
                  "onComplete":this.free
               });
            }
         }
      }
   }
}
