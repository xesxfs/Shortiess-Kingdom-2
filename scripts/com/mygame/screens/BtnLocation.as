package com.mygame.screens
{
   import starling.display.Button;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   public class BtnLocation extends Sprite
   {
       
      
      private var _hb:Quad;
      
      private var _btn:Button;
      
      public var _id:int;
      
      private var _angle:Number = 0;
      
      private var amplitude:Number = 5;
      
      public function BtnLocation()
      {
         super();
      }
      
      public function init(param1:int, param2:int) : void
      {
         x = param1;
         y = param2;
         this._hb = new Quad(80,80);
         this._hb.y = -40;
         this._hb.x = -40;
         this._hb.alpha = 0.01;
         addChild(this._hb);
         this._btn = new Button(GV.assets.getTexture("Btn_location0000"));
         this._btn.pivotX = this._btn.pivotY = int(this._btn.width / 2);
         addChild(this._btn);
         addEventListener(TouchEvent.TOUCH,this.onTouch);
         this.useHandCursor = true;
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      public function free() : void
      {
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
         this._hb.removeFromParent(true);
         this._hb = null;
         this._btn.removeFromParent(true);
         this._btn = null;
         this.removeFromParent(true);
      }
      
      public function update(param1:EnterFrameEvent) : void
      {
         this._btn.y = Math.sin(this._angle) * this.amplitude;
         this._angle = this._angle + 0.5;
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               GV.sound.playSFX("click");
               GV.location = GV.episode;
               if(GV.location > 4)
               {
                  GV.location = GV.location - 5;
               }
               GV.game.SM.open_screen("Levels");
            }
         }
      }
   }
}
