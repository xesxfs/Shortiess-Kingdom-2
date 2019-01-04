package com.mygame.skills
{
   import caurina.transitions.Tweener;
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class mSkillKaban extends Sprite implements IGameObject
   {
       
      
      public var _palm:MovieClip;
      
      public var _flash:Image;
      
      public var _trail:Image;
      
      private var _isFree:Boolean = false;
      
      private var _maxS:int = 100;
      
      private var _curS:int = 0;
      
      private var _accS:int = 8;
      
      private var _numPunch:int = 0;
      
      private var _power:int = 0;
      
      private var _state:int = 0;
      
      public function mSkillKaban()
      {
         super();
      }
      
      public function init(param1:int, param2:int) : void
      {
         GV.sound.playSFX("kaban");
         x = GV.camPos - GV.cent_X - 100;
         y = GV.groundY - 30;
         this._numPunch = param1;
         this._power = param2;
         this._flash = new Image(GV.assets.getTexture("FlashPalm0000"));
         this._flash.pivotX = this._flash.width + 10;
         this._flash.pivotY = -80;
         addChild(this._flash);
         this._palm = new MovieClip(GV.assets.getTextures("Kaban"));
         this._palm.pivotY = 0;
         this._palm.pivotX = 0;
         this._palm.x = -int(this._palm.width / 2);
         this._palm.y = -30;
         addChild(this._palm);
         GV.juggler.add(this._palm);
         this._palm.play();
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            GV.game.objs.remove(this);
            Tweener.removeTweens(this._palm);
            this._flash.removeFromParent(true);
            this._flash = null;
            this._palm.stop();
            GV.juggler.remove(this._palm);
            this._palm.removeFromParent(true);
            this._palm = null;
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Sprite = null;
         if(this._curS < this._maxS)
         {
            this._curS = this._curS + this._accS;
         }
         x = x + this._curS * param1;
         if(this._state == 1 && this._curS > 0)
         {
            this._state = 0;
            this._palm.play();
            this._flash.visible = true;
         }
         if(this._state == 0 && this._curS < 0)
         {
            this._state = 1;
            this._palm.stop();
            this._palm.currentFrame = 1;
            this._flash.visible = false;
         }
         var _loc3_:int = GV.enemiesArr.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = GV.enemiesArr[_loc3_];
            if(x > _loc2_["hitbox"].x)
            {
               GV.sound.playSFX("kaban");
               _loc2_["punch"](50);
               _loc2_["PhysicalDamage"](this._power,false);
               GV.hunter = GV.hunter + this._power;
               this._numPunch--;
               this._curS = -100;
               GV.game.shake();
               if(this._numPunch == 0)
               {
                  this.free();
               }
               return;
            }
            _loc3_--;
         }
         if(x > GV.camPos + 700)
         {
            this.free();
         }
      }
   }
}
