package com.mygame.enemies.swamp
{
   import com.general.IGameObject;
   import com.mygame.effects.Effect;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class EnArrow extends Sprite implements IGameObject
   {
       
      
      public var _mc:Image;
      
      private var _isFree = false;
      
      private var _isMove = true;
      
      private var _isEnd = false;
      
      private var speed:Number;
      
      private var p:Array;
      
      private var a:Number;
      
      private var b:Number;
      
      private var c:Number;
      
      private var dx:Number;
      
      private var cX:int;
      
      private var cY:int;
      
      private var _power:int = 0;
      
      private var _timer:int = 0;
      
      private var attackbox:Rectangle;
      
      private var _en:Sprite;
      
      public function EnArrow()
      {
         this.p = [];
         super();
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            this._mc.removeFromParent(true);
            GV.game.objs.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function init(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String) : void
      {
         this._mc = new Image(GV.assets.getTexture(param6));
         this._mc.pivotX = this._mc.width;
         this._mc.pivotY = this._mc.height / 2;
         addChild(this._mc);
         this.attackbox = new Rectangle(0,0,70,70);
         this.touchable = false;
         this._power = param5;
         x = param1;
         y = param2;
         var _loc7_:int = param3 - (param3 - x) / 2;
         if(y < param4)
         {
            this.cY = y - 50;
         }
         else
         {
            this.cY = param4 - 30;
         }
         this.speed = (param3 - x) / 6;
         this.p = [new Point(x,y),new Point(_loc7_,this.cY),new Point(param3,param4)];
         this.a = (this.p[2].y - (this.p[2].x * (this.p[1].y - this.p[0].y) + this.p[1].x * this.p[0].y - this.p[0].x * this.p[1].y) / (this.p[1].x - this.p[0].x)) / (this.p[2].x * (this.p[2].x - this.p[0].x - this.p[1].x) + this.p[0].x * this.p[1].x);
         this.b = (this.p[1].y - this.p[0].y) / (this.p[1].x - this.p[0].x) - this.a * (this.p[0].x + this.p[1].x);
         this.c = (this.p[1].x * this.p[0].y - this.p[0].x * this.p[1].y) / (this.p[1].x - this.p[0].x) + this.a * this.p[0].x * this.p[1].x;
         this.dx = x;
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
         this.update(1);
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Effect = null;
         this.attackbox.x = x - 35;
         this.attackbox.y = y - 35;
         if(this._isMove)
         {
            this._mc.rotation = Math.atan(2 * this.a * this.dx + this.b) + 1.5;
            x = this.dx;
            y = this.a * this.dx * this.dx + this.b * this.dx + this.c;
            if(this.dx + this.speed >= this.p[2].x)
            {
               this.dx = this.dx + this.speed * param1;
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < GV.heroesArr.length)
               {
                  this._en = GV.heroesArr[_loc2_];
                  if(this.attackbox.intersects(this._en["hitbox"]))
                  {
                     this._en["punch"](5);
                     this._en["PhysicalDamage"](this._power);
                     _loc3_ = new Effect();
                     _loc3_.init(x,y,"ArrowEff",24);
                     this.free();
                     return;
                  }
                  _loc2_++;
               }
               this._isMove = false;
            }
         }
         else if(!this._isEnd)
         {
            y = y + 100 * param1;
            x = x + this.speed * param1;
            if(y > GV.groundY)
            {
               y = GV.groundY + 10;
               this._isEnd = true;
               this._timer = GV.real_time + 4000;
               return;
            }
         }
         else if(this._timer < GV.real_time)
         {
            this.alpha = this.alpha - 0.1;
            if(this.alpha <= 0)
            {
               this.free();
            }
         }
      }
   }
}
