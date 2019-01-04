package com.mygame.effects
{
   import starling.display.MovieClip;
   
   public class EffectHero extends Effect
   {
       
      
      public function EffectHero()
      {
         super();
      }
      
      override public function init(param1:int, param2:int, param3:String, param4:int) : void
      {
         _sprite = new MovieClip(GV.assets.getTextures(param3),param4);
         _sprite.pivotX = 0;
         _sprite.pivotY = 0;
         _sprite.x = -_sprite.width / 2;
         _sprite.y = -_sprite.height / 2;
         addChild(_sprite);
         _sprite.loop = false;
         GV.starling.juggler.add(_sprite);
         _totalFrame = _sprite.numFrames - 1;
         x = param1;
         y = param2;
         this.touchable = false;
         GV.game.effects.add(this);
      }
   }
}
