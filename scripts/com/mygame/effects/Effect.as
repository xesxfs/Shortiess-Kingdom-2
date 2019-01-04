package com.mygame.effects
{
   import com.general.IGameObject;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class Effect extends Sprite implements IGameObject
   {
       
      
      public var _sprite:MovieClip;
      
      public var _isFree = false;
      
      public var _totalFrame:int;
      
      public function Effect()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:String, param4:int) : void
      {
         this._sprite = new MovieClip(GV.assets.getTextures(param3),param4);
         this._sprite.pivotX = 0;
         this._sprite.pivotY = 0;
         this._sprite.x = -this._sprite.width / 2;
         this._sprite.y = -this._sprite.height / 2;
         addChild(this._sprite);
         this._sprite.loop = false;
         GV.starling.juggler.add(this._sprite);
         this._totalFrame = this._sprite.numFrames - 1;
         x = param1;
         y = param2;
         this.touchable = false;
         GV.game.effects.add(this);
         GV.game.lay_2.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            this._sprite.stop();
            GV.starling.juggler.remove(this._sprite);
            GV.game.effects.remove(this);
            this._sprite.removeFromParent(true);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         if(this._sprite.currentFrame == this._totalFrame)
         {
            this.free();
         }
      }
   }
}
