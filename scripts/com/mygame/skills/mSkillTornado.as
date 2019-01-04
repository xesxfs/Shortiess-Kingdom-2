package com.mygame.skills
{
   import caurina.transitions.Tweener;
   import com.general.IGameObject;
   import flash.geom.Rectangle;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class mSkillTornado extends Sprite implements IGameObject
   {
       
      
      public var mc:MovieClip;
      
      private var _isFree:Boolean = false;
      
      private var attackbox:Rectangle;
      
      private var _time:int;
      
      private var _power:int = 5;
      
      private var en:Sprite;
      
      private var _isEnd:Boolean = false;
      
      private var _timeEnd:int;
      
      public function mSkillTornado()
      {
         super();
      }
      
      public function init(param1:int, param2:int) : void
      {
         this._power = param2;
         x = param1;
         y = GV.groundY + 40;
         this.mc = new MovieClip(GV.assets.getTextures("Tornado"));
         this.mc.pivotY = 0;
         this.mc.pivotX = 0;
         this.mc.x = -int(this.mc.width);
         this.mc.y = -int(this.mc.height);
         addChild(this.mc);
         GV.juggler.add(this.mc);
         this.mc.play();
         this.attackbox = new Rectangle(0,0,150,150);
         this._time = GV.real_time + 500;
         this._timeEnd = GV.real_time + 7000;
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
         this.scale = 0.2;
         Tweener.addTween(this,{
            "scale":1,
            "time":1,
            "transition":"linear"
         });
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            Tweener.removeTweens(this);
            GV.juggler.remove(this.mc);
            this.mc.stop();
            this.mc.removeFromParent(true);
            this.mc = null;
            this.removeFromParent(true);
            GV.game.objs.remove(this);
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = 0;
         this.attackbox.x = x - 75;
         this.attackbox.y = y - 75;
         x = x + 20 * param1;
         if(!this._isEnd)
         {
            if(this._time < GV.real_time)
            {
               this._time = GV.real_time + 100;
               _loc2_ = 0;
               while(_loc2_ < GV.enemiesArr.length)
               {
                  this.en = GV.enemiesArr[_loc2_];
                  if(this.attackbox.intersects(this.en["hitbox"]))
                  {
                     this.en["PhysicalDamage"](this._power,false);
                     GV.hunter = GV.hunter + this._power;
                  }
                  _loc2_++;
               }
            }
            if(this._timeEnd < GV.real_time)
            {
               this._isEnd = true;
               Tweener.addTween(this,{
                  "scale":0.2,
                  "time":1,
                  "transition":"linear",
                  "onComplete":this.free
               });
            }
            if(x > GV.camPos + 500)
            {
               this.free();
            }
         }
      }
   }
}
