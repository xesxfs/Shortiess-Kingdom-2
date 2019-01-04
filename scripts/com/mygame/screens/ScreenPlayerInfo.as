package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Button;
   import starling.display.Quad;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenPlayerInfo extends ScrBase
   {
       
      
      private var _btnQuit:Button;
      
      private var _back:Quad;
      
      private var _panel:Quad;
      
      public var _text:TextField;
      
      public function ScreenPlayerInfo()
      {
         super();
         this.draw();
         GV.game.addChild(this);
      }
      
      override public function activation() : void
      {
         this._btnQuit.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnQuit.removeEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function free() : void
      {
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnQuit)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.free_screen();
         }
      }
      
      override public function draw() : void
      {
         this._back = new Quad(GV.scr_X,GV.scr_Y,0);
         addChild(this._back);
         this._back.alpha = 0;
         Tweener.addTween(this._back,{
            "alpha":0.8,
            "time":0.2,
            "delay":0,
            "transition":"linear"
         });
         this._panel = new Quad(400,200,2760744);
         this._panel.x = GV.cent_X - this._panel.width / 2;
         this._panel.y = GV.cent_Y - this._panel.height / 2;
         addChild(this._panel);
         this._btnQuit = new Button(GV.assets.getTexture("Btn_close" + "0000"));
         this._btnQuit.x = this._panel.x + this._panel.width - this._btnQuit.width / 2 - 10;
         this._btnQuit.y = this._panel.y - this._btnQuit.height / 2 + 10;
         this._btnQuit.useHandCursor = true;
         addChild(this._btnQuit);
         this._text = new TextField(this._panel.width - 40,this._panel.height - 40,"Видео не доступно. \n Проверьте соединение с интернетом.",new TextFormat("PORT",30,14397907,Align.CENTER));
         this._text.x = this._panel.x + 20;
         this._text.y = this._panel.y + 20;
         addChild(this._text);
         this._text.touchable = false;
      }
   }
}
