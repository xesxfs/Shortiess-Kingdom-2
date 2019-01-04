package com.mygame.enemies.swamp
{
   import com.general.IGameObject;
   import flash.display.Shape;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class PoisinBullet extends Sprite implements IGameObject
   {
       
      
      public var _mc:Image;
      
      private var _isFree = false;
      
      private var _power:int = 0;
      
      public var _hitbox:Point;
      
      public var _hitboxOffset:Point;
      
      public var debug_shape:Shape;
      
      private var _en:Sprite;
      
      private var attackbox:Rectangle;
      
      public function PoisinBullet()
      {
         super();
      }
      
      public function EnArrow() : *
      {
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            if(GV.debug && this.debug_shape)
            {
               GV.main.stage.removeChild(this.debug_shape);
               this.debug_shape = null;
            }
            this._mc.removeFromParent(true);
            GV.game.objs.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function init(param1:int, param2:int, param3:int, param4:String) : void
      {
         this._mc = new Image(GV.assets.getTexture(param4));
         this._mc.pivotX = this._mc.width;
         this._mc.pivotY = this._mc.height / 2;
         addChild(this._mc);
         this.attackbox = new Rectangle(0,0,50,50);
         this.touchable = false;
         this._power = param3;
         x = param1;
         y = param2;
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
      }
      
      public function update(param1:Number) : void
      {
         this.attackbox.x = x - 25;
         this.attackbox.y = y - 25;
         x = x - 50 * param1;
         y = y + 0.1;
         var _loc2_:int = 0;
         while(_loc2_ < GV.heroesArr.length)
         {
            this._en = GV.heroesArr[_loc2_];
            if(this.attackbox.intersects(this._en["hitbox"]))
            {
               this._en["punch"](5);
               this._en["MagicDamage"](this._power);
               this.free();
               return;
            }
            _loc2_++;
         }
         if(x < GV.camPos - 500)
         {
            this.free();
         }
      }
   }
}
