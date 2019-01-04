package com.mygame.screens
{
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.events.Event;
   
   public class ScreenEnd extends ScrBase
   {
       
      
      private var _back:Quad;
      
      public var _btnettings:Button;
      
      private var img:Image;
      
      public function ScreenEnd()
      {
         super();
         this.draw();
         GV.game.addChildAt(this,0);
      }
      
      override public function activation() : void
      {
         this._btnettings.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnettings.removeEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function free() : void
      {
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnettings)
         {
            GV.sound.playSFX("click");
            GV.game.SM.open_screen("Settings");
         }
      }
      
      public function select_level(param1:int) : void
      {
      }
      
      override public function draw() : void
      {
         this._back = new Quad(GV.scr_X + 10,GV.scr_Y + 10,7093021);
         this._back.x = -5;
         this._back.y = -5;
         addChild(this._back);
         this.img = new Image(GV.assets.getTexture("End_pic0000"));
         this.img.x = int(GV.cent_X - this.img.width / 2);
         this.img.y = int(GV.cent_Y - this.img.height / 2);
         addChild(this.img);
         this._btnettings = new Button(GV.assets.getTexture("BtnSettings" + "0000"));
         this._btnettings.x = int(GV.scr_X - this._btnettings.width - 20);
         this._btnettings.y = 15;
         this._btnettings.useHandCursor = true;
         addChild(this._btnettings);
      }
   }
}
