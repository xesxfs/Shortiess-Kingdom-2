package com.mygame.enemies.Forest
{
   import caurina.transitions.Tweener;
   import com.general.IGameObject;
   import flash.geom.Rectangle;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class Root extends Sprite implements IGameObject
   {
       
      
      public var mc:MovieClip;
      
      private var _isFree = false;
      
      private var _power:int = 0;
      
      private var attackbox:Rectangle;
      
      private var en:Sprite;
      
      public function Root()
      {
         super();
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            Tweener.removeTweens(this);
            this._isFree = true;
            this.mc.stop();
            GV.juggler.remove(this.mc);
            this.mc.removeFromParent(true);
            GV.game.objs.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function init(param1:int, param2:int) : void
      {
         this._power = param2;
         this.mc = new MovieClip(GV.assets.getTextures("Root"));
         this.mc.x = -22;
         this.mc.y = -22;
         addChild(this.mc);
         GV.juggler.add(this.mc);
         this.attackbox = new Rectangle(0,0,60,120);
         this.touchable = false;
         x = param1;
         y = GV.groundY + 40;
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
         Tweener.addTween(this,{
            "y":GV.groundY - 70,
            "time":0.3,
            "transition":"lenear",
            "onComplete":this.attack
         });
         Tweener.addTween(this,{
            "y":GV.groundY + 40,
            "time":1.6,
            "delay":0.8,
            "transition":"lenear",
            "onComplete":this.free
         });
      }
      
      public function update(param1:Number) : void
      {
         this.attackbox.x = x;
         this.attackbox.y = y;
      }
      
      public function attack() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < GV.heroesArr.length)
         {
            this.en = GV.heroesArr[_loc1_];
            if(this.attackbox.intersects(this.en["hitbox"]))
            {
               this.en["PhysicalDamage"](this._power);
            }
            _loc1_++;
         }
      }
   }
}
