package com.mygame.enemies.Forest
{
   import com.general.IGameObject;
   import com.mygame.effects.Effect;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Bomb extends Sprite implements IGameObject
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
      
      public function Bomb()
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
      
      public function init(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         this._mc = new Image(GV.assets.getTexture("Nut0000"));
         this._mc.x = -22;
         this._mc.y = -22;
         addChild(this._mc);
         this.attackbox = new Rectangle(0,0,150,50);
         this.touchable = false;
         this._power = param5;
         x = param1;
         y = param2;
         var _loc6_:int = param3 - (param3 - x) / 2;
         if(y < param4)
         {
            this.cY = y - 50;
         }
         else
         {
            this.cY = param4 - 30;
         }
         this.speed = (param3 - x) / 8;
         this.p = [new Point(x,y),new Point(_loc6_,this.cY),new Point(param3,param4)];
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
         this.attackbox.x = x - 75;
         this.attackbox.y = y - 25;
         if(this._isMove)
         {
            this.rotation = this.rotation - 0.1;
            x = this.dx;
            y = this.a * this.dx * this.dx + this.b * this.dx + this.c;
            if(this.dx + this.speed >= this.p[2].x)
            {
               this.dx = this.dx + this.speed * param1;
            }
            else
            {
               y = GV.groundY - 40;
               this._isMove = false;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < GV.heroesArr.length)
            {
               this._en = GV.heroesArr[_loc2_];
               if(this.attackbox.intersects(this._en["hitbox"]))
               {
                  this._en["PhysicalDamage"](this._power);
                  this._en["Jump"]();
               }
               _loc2_++;
            }
            _loc3_ = new Effect();
            _loc3_.init(x,y,"Skill_4_Explos",18);
            GV.game.shake();
            GV.sound.playSFX("explosion");
            this.free();
         }
      }
   }
}
