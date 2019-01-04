package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ScreenPause extends ScrBase
   {
       
      
      private var _sprite:Sprite;
      
      private var _btnQuit:Button;
      
      private var _btnContinue:Button;
      
      private var _back:Quad;
      
      private var _board:Image;
      
      public function ScreenPause()
      {
         super();
         this.draw();
         GV.game.addChild(this);
      }
      
      override public function activation() : void
      {
         this._btnQuit.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnContinue.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnContinue.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnContinue.useHandCursor = false;
         this._btnQuit.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnQuit.useHandCursor = false;
      }
      
      override public function free() : void
      {
         super.free();
      }
      
      private function update(param1:Event) : void
      {
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnQuit)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.open_screen("Fail");
         }
         if(_loc2_ as Button == this._btnContinue)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.isPlay = true;
            GV.game.SM.free_screen();
            GV.sound.playMusic("game");
         }
      }
      
      override public function draw() : void
      {
         this._back = new Quad(GV.scr_X,GV.scr_Y,0);
         addChild(this._back);
         this._back.alpha = 0;
         Tweener.addTween(this._back,{
            "alpha":0.7,
            "time":0.4,
            "delay":0,
            "transition":"linear"
         });
         this._sprite = new Sprite();
         addChild(this._sprite);
         this._sprite.y = -GV.scr_Y;
         Tweener.addTween(this._sprite,{
            "y":0,
            "time":0.4,
            "delay":0,
            "transition":"easeOutBack"
         });
         this._board = new Image(GV.assets.getTexture("Pause_board" + "0000"));
         this._board.x = int(GV.cent_X - this._board.width / 2);
         this._board.y = int(GV.cent_Y - this._board.height / 2 - 80);
         this._sprite.addChild(this._board);
         this._btnQuit = new Button(GV.assets.getTexture("Btn_map" + "0000"));
         this._btnQuit.x = GV.cent_X - this._btnQuit.width - 20;
         this._btnQuit.y = this._board.y + 110;
         this._btnQuit.useHandCursor = true;
         this._sprite.addChild(this._btnQuit);
         this._btnContinue = new Button(GV.assets.getTexture("Btn_continue" + "0000"));
         this._btnContinue.x = GV.cent_X + 20;
         this._btnContinue.y = this._board.y + 110;
         this._btnContinue.useHandCursor = true;
         this._sprite.addChild(this._btnContinue);
      }
   }
}
