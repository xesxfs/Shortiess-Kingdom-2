package com.mygame.skills
{
   import caurina.transitions.Tweener;
   import com.general.IGameObject;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class mSkillSpinner extends Sprite implements IGameObject
   {
       
      
      public var _mc:Image;
      
      private var _isFree:Boolean = false;
      
      public var _time:int = 0;
      
      private var _delay:int = 0;
      
      private var _damage:int = 0;
      
      private var _state:int = 0;
      
      private var _hero;
      
      var _en:Sprite;
      
      private var num_times:int = 6;
      
      private var attackbox:Rectangle;
      
      public function mSkillSpinner()
      {
         super();
      }
      
      public function init(param1:Sprite, param2:int) : void
      {
         this._hero = param1;
         x = this._hero.x;
         y = GV.groundY - 40;
         this._damage = param2;
         this._mc = new Image(GV.assets.getTexture("Spinner0000"));
         this._mc.pivotY = 0;
         this._mc.pivotX = 0;
         this._mc.x = -this._mc.width / 2;
         this._mc.y = -this._mc.height / 2;
         addChild(this._mc);
         this.scale = 0;
         Tweener.addTween(this,{
            "scale":1,
            "time":0.5,
            "transition":"linear"
         });
         this.attackbox = new Rectangle(0,0,200,200);
         this._time = GV.real_time + 6000;
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_0.addChildAt(this,0);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            Tweener.removeTweens(this);
            this._isFree = true;
            GV.game.objs.remove(this);
            this._mc.removeFromParent(true);
            this._mc = null;
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         this.attackbox.x = x - 100;
         this.attackbox.y = y - 100;
         if(!GV.debug)
         {
         }
         this.rotation = this.rotation + 0.4;
         if(this._hero == null || this._hero["_isFree"])
         {
            this.free();
            return;
         }
         if(this._state == 0)
         {
            x = x + 50 * param1;
            this.Attack();
            if(x > this._hero.x + 300)
            {
               this._state = 1;
               this.Check_loop();
            }
         }
         if(this._state == 1)
         {
            x = x - 50 * param1;
            this.Attack();
            if(x < this._hero.x)
            {
               this._state = 0;
               this.Check_loop();
            }
         }
      }
      
      public function Attack() : void
      {
         var _loc1_:int = 0;
         if(this._delay < GV.real_time)
         {
            GV.sound.playSFX("sword0");
            _loc1_ = 0;
            while(_loc1_ < GV.enemiesArr.length)
            {
               this._en = GV.enemiesArr[_loc1_];
               if(this.attackbox.intersects(this._en["hitbox"]))
               {
                  this._en["PhysicalDamage"](this._damage,false);
                  GV.knight = GV.knight + this._damage;
               }
               _loc1_++;
            }
            this._delay = GV.real_time + 100;
         }
      }
      
      public function Check_loop() : void
      {
         this.num_times--;
         if(this.num_times == 0)
         {
            this._state = 3;
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
