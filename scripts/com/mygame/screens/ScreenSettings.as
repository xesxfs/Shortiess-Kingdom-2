package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.general.MyMusicVolume;
   import com.general.MySoundVolume;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   
   public class ScreenSettings extends ScrBase
   {
       
      
      private var _back:Quad;
      
      private var _board1:Image;
      
      private var _board2:Image;
      
      private var _board3:Image;
      
      private var _board4:Image;
      
      private var _sprite:Sprite;
      
      private var _btnReset:Button;
      
      private var _btnRate:Button;
      
      private var _btnBack:Button;
      
      private var _nameTxt:TextField;
      
      private var _resetTxt:TextField;
      
      private var _rateTxt:TextField;
      
      private var _btnSound:MySoundVolume;
      
      private var _btnMusic:MyMusicVolume;
      
      private var _btnEn:Button;
      
      private var _btnRu:Button;
      
      private var _numCheat:int = 0;
      
      public function ScreenSettings()
      {
         super();
         this.draw();
         GV.game.addChild(this);
      }
      
      override public function activation() : void
      {
         Tweener.addTween(this._sprite,{
            "y":0,
            "time":0.2,
            "transition":"linear",
            "onComplete":this.init_btn
         });
      }
      
      private function init_btn() : void
      {
         this._btnBack.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnEn.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnRu.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnReset.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnRate.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnBack.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnEn.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnRu.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnReset.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnRate.removeEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function free() : void
      {
         this._back.removeFromParent(true);
         this._board1.removeFromParent(true);
         this._board2.removeFromParent(true);
         this._board3.removeFromParent(true);
         this._board4.removeFromParent(true);
         this._nameTxt.removeFromParent(true);
         this._btnSound.free();
         this._btnMusic.free();
         this._btnEn.removeFromParent(true);
         this._btnRu.removeFromParent(true);
         this._btnReset.removeFromParent(true);
         this._btnRate.removeFromParent(true);
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnBack)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.save.localSave();
            GV.game.SM.free_screen();
         }
         if(_loc2_ as Button == this._btnEn)
         {
            GV.sound.playSFX("click");
            GV.settings[2] = 1;
            GV.game.SM.translate();
         }
         if(_loc2_ as Button == this._btnRu)
         {
            GV.sound.playSFX("click");
            GV.settings[2] = 2;
            GV.game.SM.translate();
            this._numCheat++;
         }
         if(_loc2_ as Button == this._btnReset)
         {
            GV.sound.playSFX("click");
            if(this._numCheat == 5)
            {
               GV.save.load_cheat();
            }
            else
            {
               GV.save.reset();
            }
            GV.game.SM.transition_screen("Map",true);
         }
         if(_loc2_ as Button == this._btnRate)
         {
            GV.sound.playSFX("click");
            navigateToURL(new URLRequest("https://play.google.com/store/apps/details?id=air.dennatolich.shortieskingdom2"));
         }
      }
      
      override public function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         this._back = new Quad(GV.scr_X,GV.scr_Y,0);
         addChild(this._back);
         this._back.alpha = 0.3;
         Tweener.addTween(this._back,{
            "alpha":0.7,
            "time":0.2,
            "delay":0,
            "transition":"linear"
         });
         this._sprite = new Sprite();
         addChild(this._sprite);
         this._sprite.y = -GV.scr_Y;
         _loc1_ = -40;
         _loc2_ = -5;
         _loc3_ = GV.cent_Y - 20;
         this._board1 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board1.pivotY = this._board1.height;
         this._board1.x = GV.cent_X + _loc1_;
         this._board1.y = _loc3_ - _loc2_;
         this._sprite.addChild(this._board1);
         this._board2 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board2.pivotY = this._board1.height;
         this._board2.x = GV.cent_X - _loc1_;
         this._board2.y = _loc3_ - _loc2_;
         this._sprite.addChild(this._board2);
         this._board2.scaleX = -1;
         this._board3 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board3.pivotY = this._board1.height;
         this._board3.x = GV.cent_X + _loc1_;
         this._board3.y = _loc3_ + _loc2_;
         this._sprite.addChild(this._board3);
         this._board3.scaleY = -1;
         this._board4 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board4.pivotY = this._board1.height;
         this._board4.x = GV.cent_X - _loc1_;
         this._board4.y = _loc3_ + _loc2_;
         this._sprite.addChild(this._board4);
         this._board4.scaleX = -1;
         this._board4.scaleY = -1;
         this._btnBack = new Button(GV.assets.getTexture("Btn_close0000"));
         this._btnBack.x = GV.cent_X + 150;
         this._btnBack.y = _loc3_ - 200;
         this._sprite.addChild(this._btnBack);
         this._nameTxt = new TextField(150,30,"Settings");
         this._nameTxt.format.setTo("PORT",22,16777215,"center");
         this._nameTxt.x = GV.cent_X - this._nameTxt.width / 2;
         this._nameTxt.y = this._board1.y - 170;
         this._sprite.addChild(this._nameTxt);
         this._nameTxt.touchable = false;
         this._btnSound = new MySoundVolume();
         this._btnSound.init(GV.cent_X + 20,this._board1.y - 90);
         this._sprite.addChild(this._btnSound);
         this._btnMusic = new MyMusicVolume();
         this._btnMusic.init(GV.cent_X + 20,this._board1.y - 10);
         this._sprite.addChild(this._btnMusic);
         this._btnReset = new Button(GV.assets.getTexture("Btn_reset0000"));
         this._btnReset.x = GV.cent_X - 150;
         this._btnReset.y = _loc3_ + 60;
         this._sprite.addChild(this._btnReset);
         this._resetTxt = new TextField(100,60,"");
         this._resetTxt.format.setTo("PORT",17,2429958,"center");
         this._resetTxt.x = this._btnReset.x - 50 + 30;
         this._resetTxt.y = this._btnReset.y + 60;
         this._sprite.addChild(this._resetTxt);
         this._resetTxt.touchable = false;
         this._btnRate = new Button(GV.assets.getTexture("Btn_rate0000"));
         this._btnRate.x = this._btnReset.x + 80;
         this._btnRate.y = _loc3_ + 60;
         this._sprite.addChild(this._btnRate);
         this._btnRate.visible = false;
         this._rateTxt = new TextField(100,60,"");
         this._rateTxt.format.setTo("PORT",17,2429958,"center");
         this._rateTxt.x = this._btnRate.x - 50 + 30;
         this._rateTxt.y = this._btnRate.y + 60;
         this._sprite.addChild(this._rateTxt);
         this._rateTxt.touchable = false;
         this._rateTxt.visible = false;
         this._btnEn = new Button(GV.assets.getTexture("Btn_English0000"));
         this._btnEn.x = this._btnRate.x + 80;
         this._btnEn.y = _loc3_ + 60;
         this._sprite.addChild(this._btnEn);
         _loc4_ = new TextField(100,30,"EN");
         _loc4_.format.setTo("PORT",17,2429958,"center");
         _loc4_.x = this._btnEn.x - 50 + 30;
         _loc4_.y = this._btnEn.y + 60;
         this._sprite.addChild(_loc4_);
         _loc4_.touchable = false;
         this._btnRu = new Button(GV.assets.getTexture("Btn_Russian0000"));
         this._btnRu.x = this._btnEn.x + 80;
         this._btnRu.y = _loc3_ + 60;
         this._sprite.addChild(this._btnRu);
         var _loc5_:TextField = new TextField(100,30,"RU");
         _loc5_.format.setTo("PORT",17,2429958,"center");
         _loc5_.x = this._btnRu.x - 50 + 30;
         _loc5_.y = this._btnRu.y + 60;
         this._sprite.addChild(_loc5_);
         _loc5_.touchable = false;
         this.translate();
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this._nameTxt.text = "Settings";
            this._rateTxt.text = "Rate \n game ";
            this._resetTxt.text = "Clear \n data ";
         }
         if(GV.settings[2] == 2)
         {
            this._nameTxt.text = "Настройки";
            this._rateTxt.text = "Оценить \n игру ";
            this._resetTxt.text = "Сбросить \n прогресс";
         }
      }
   }
}
