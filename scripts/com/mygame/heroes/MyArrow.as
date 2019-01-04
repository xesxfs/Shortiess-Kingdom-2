package com.mygame.heroes
{
   import com.general.IGameObject;
   import com.mygame.effects.Effect;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class MyArrow extends Sprite implements IGameObject
   {
       
      
      public var _mc:Image;
      
      private var _isFree = false;
      
      private var _isMove = true;
      
      private var _isEnd = false;
      
      private var _isCrit = false;
      
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
      
      private var _debugA:Quad;
      
      private var attackbox:Rectangle;
      
      private var en:Sprite;
      
      public function MyArrow()
      {
         this.p = [];
         super();
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            if(this._debugA)
            {
               this._debugA.removeFromParent(true);
            }
            this._mc.removeFromParent(true);
            this._mc = null;
            GV.game.objs.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function init(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String, param7:Boolean) : void
      {
         this._isCrit = param7;
         this._mc = new Image(GV.assets.getTexture(param6));
         this._mc.x = -int(this._mc.width);
         this._mc.y = -int(this._mc.height / 2);
         addChild(this._mc);
         this.attackbox = new Rectangle(-25,-25,50,50);
         this.touchable = false;
         this._power = param5;
         x = param1;
         y = param2;
         var _loc8_:int = param3 - (param3 - x) / 2;
         if(y < param4)
         {
            this.cY = y - 150;
         }
         else
         {
            this.cY = param4 - 100;
         }
         this.speed = (param3 - x) / 8;
         this.p = [new Point(x,y),new Point(_loc8_,this.cY),new Point(param3,param4)];
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
         this.attackbox.x = x - 25;
         this.attackbox.y = y - 25;
         if(this._debugA)
         {
            this._debugA.x = this.attackbox.x;
            this._debugA.y = this.attackbox.y;
         }
         if(this._isMove)
         {
            this.rotation = Math.atan(2 * this.a * this.dx + this.b) + 1.5;
            x = this.dx;
            y = this.a * this.dx * this.dx + this.b * this.dx + this.c;
            if(this.dx + this.speed <= this.p[2].x + 10)
            {
               this.dx = this.dx + this.speed * param1;
               _loc2_ = 0;
               while(_loc2_ < GV.enemiesArr.length)
               {
                  this.en = GV.enemiesArr[_loc2_];
                  if(this.attackbox.intersects(this.en["hitbox"]))
                  {
                     GV.sound.damage();
                     if(this._isCrit)
                     {
                        this.en["punch"](5);
                        this.en["PhysicalDamage"](this._power,true);
                     }
                     else
                     {
                        this.en["punch"](5);
                        this.en["PhysicalDamage"](this._power,false);
                     }
                     _loc3_ = new Effect();
                     _loc3_.init(x,y,"ArrowEff",24);
                     this.free();
                     return;
                  }
                  _loc2_++;
               }
            }
            else
            {
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
      
      public function debagAHitbox() : void
      {
         this._debugA = new Quad(this.attackbox.width,this.attackbox.height,2097407);
         GV.game.lay_0.addChild(this._debugA);
      }
   }
}
