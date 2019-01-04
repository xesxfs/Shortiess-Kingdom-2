package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Button;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ScreenLevels extends ScrBase
   {
       
      
      private var _sprite:Sprite;
      
      private var _btnQuit:Button;
      
      private var _back:Quad;
      
      private var _pxArr:Array;
      
      private var _pyArr:Array;
      
      public function ScreenLevels()
      {
         this._pxArr = [-315,-275,-210,-105,15,135,210,220,120,15];
         this._pyArr = [50,-65,-165,-240,-260,-225,-135,-20,60,-15];
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
            GV.game.SM.free_screen();
         }
      }
      
      override public function draw() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BtnLevel = null;
         this._back = new Quad(GV.scr_X,GV.scr_Y,0);
         addChild(this._back);
         this._back.alpha = 0;
         Tweener.addTween(this._back,{
            "alpha":0.8,
            "time":0.2,
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
         this._btnQuit = new Button(GV.assets.getTexture("Btn_close" + "0000"));
         this._btnQuit.x = GV.scr_X - this._btnQuit.width - 20;
         this._btnQuit.y = 20;
         this._btnQuit.useHandCursor = true;
         this._sprite.addChild(this._btnQuit);
         if(GV.episode < 5)
         {
            _loc2_ = GV.cent_X - 130;
            _loc3_ = 2;
         }
         else
         {
            _loc2_ = GV.cent_X - 130 * 2;
            _loc3_ = 4;
         }
         var _loc1_:int = 0;
         while(_loc1_ <= _loc3_)
         {
            _loc4_ = new BtnLevel();
            _loc4_.init(_loc2_ + _loc1_ * 130,GV.cent_Y,_loc1_);
            addChild(_loc4_);
            _loc1_++;
         }
      }
   }
}
