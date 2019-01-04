package com.mygame.effects
{
   import com.general.IGameObject;
   import starling.display.Sprite;
   import starling.extensions.NoBlendParticleSystem;
   
   public class Blood extends Sprite implements IGameObject
   {
       
      
      public var _sprite:NoBlendParticleSystem;
      
      private var _isFree:Boolean = false;
      
      private var _isStop:Boolean = false;
      
      private var _time:int = 0;
      
      public function Blood()
      {
         super();
         this._sprite = new NoBlendParticleSystem(GV.assets.getXml("Blood"),GV.assets.getTexture("Part_circle0000"));
         addChild(this._sprite);
         this.touchable = false;
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            this._sprite.stop();
            GV.juggler.remove(this._sprite);
            GV.game.cacheBlood.set(this);
            GV.game.effects.remove(this);
            this.removeFromParent(false);
         }
      }
      
      public function init(param1:int, param2:int) : void
      {
         this._isFree = false;
         this._isStop = false;
         this._sprite.start();
         GV.juggler.add(this._sprite);
         this._time = GV.real_time + 150;
         x = param1;
         y = param2;
         GV.game.effects.add(this);
         GV.game.lay_2.addChild(this);
      }
      
      public function update(param1:Number) : void
      {
         if(!this._isStop)
         {
            if(this._time < GV.real_time)
            {
               this._sprite.stop();
               this._isStop = true;
               this._time = GV.real_time + 500;
            }
         }
         else if(this._time < GV.real_time)
         {
            this.free();
         }
      }
   }
}
