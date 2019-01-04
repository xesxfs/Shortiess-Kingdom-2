package com.mygame.screens
{
   import com.general.MyButton;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import starling.display.Button;
   import starling.display.Image;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenMap extends ScrBase
   {
       
      
      private var _btnArmory:Button;
      
      private var _btnWeel:Button;
      
      public var _btnettings:Button;
      
      private var _btnChest:Button;
      
      private var _btnPart1:Button;
      
      private var _btnLogo:Button;
      
      private var _btnGoogle:Button;
      
      private var _map:Image;
      
      private var _btnArr:Array;
      
      private var _pxArr:Array;
      
      private var _pyArr:Array;
      
      private var _btnBattle:BtnLocation;
      
      private var _coinImg:Image;
      
      private var _coinTxt:TextField;
      
      private var _cristalImg:Image;
      
      private var _cristalTxt:TextField;
      
      private var _btnSave:MyButton;
      
      private var _btnLoad:MyButton;
      
      public function ScreenMap()
      {
         this._btnArr = [];
         this._pxArr = [170,274,422,748,642];
         this._pyArr = [325,230,295,302,185];
         super();
         this.draw();
         GV.game.addChildAt(this,0);
      }
      
      override public function activation() : void
      {
         if(this._btnLogo)
         {
            this._btnLogo.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnWeel)
         {
            this._btnWeel.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnArmory)
         {
            this._btnArmory.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnGoogle)
         {
            this._btnGoogle.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnChest)
         {
            this._btnChest.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         this._btnettings.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnettings.removeEventListener(Event.TRIGGERED,this.touch_btns);
         if(this._btnChest)
         {
            this._btnChest.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnArmory)
         {
            this._btnArmory.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnWeel)
         {
            this._btnWeel.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnLogo)
         {
            this._btnLogo.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnGoogle)
         {
            this._btnGoogle.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
      }
      
      override public function free() : void
      {
         GV.game.effects.clear();
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnArmory)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.transition_screen("Inventory",true);
         }
         if(_loc2_ as Button == this._btnettings)
         {
            GV.sound.playSFX("click");
            GV.game.SM.open_screen("Settings");
         }
         if(_loc2_ as Button == this._btnWeel)
         {
            GV.sound.playSFX("click");
            GV.game.SM.transition_screen("Weel",true);
         }
         if(_loc2_ as Button == this._btnChest)
         {
            GV.sound.playSFX("click");
            GV.game.SM.transition_screen("Chest",true);
         }
         if(_loc2_ as Button == this._btnLoad)
         {
            GV.save.local_load();
            GV.game.SM.transition_screen("Map",true);
         }
         if(_loc2_ as Button == this._btnSave)
         {
            GV.save.localSave();
         }
         if(_loc2_ as Button == this._btnPart1)
         {
            GV.sound.playSFX("click");
            navigateToURL(new URLRequest("http://www.myplayyard.com/action/play-shorties-s-kingdom"));
         }
         if(_loc2_ as Button == this._btnLogo)
         {
            GV.sound.playSFX("click");
            navigateToURL(new URLRequest("http://www.myplayyard.com"));
         }
         if(_loc2_ as Button == this._btnGoogle)
         {
            GV.sound.playSFX("click");
            navigateToURL(new URLRequest("https://play.google.com/store/apps/details?id=air.dennatolich.shortieskingdom2"));
         }
      }
      
      public function select_level(param1:int) : void
      {
      }
      
      override public function draw() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Image = null;
         var _loc4_:Image = null;
         var _loc5_:int = 0;
         var _loc6_:Image = null;
         var _loc7_:HandTutorial = null;
         var _loc1_:int = Math.ceil((GV.scr_Y + 10) / 98);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = new Image(GV.assets.getTexture("Wood" + "0000"));
            _loc4_.x = -5;
            _loc4_.y = _loc2_ * 98;
            _loc4_.width = GV.scr_X + 10;
            addChild(_loc4_);
            _loc2_++;
         }
         this._map = new Image(GV.assets.getTexture("Map0000"));
         this._map.pivotX = this._map.pivotY = 0;
         this._map.x = int(GV.cent_X - this._map.width / 2);
         this._map.y = int(GV.cent_Y - this._map.height / 2);
         addChild(this._map);
         _loc3_ = new Image(GV.assets.getTexture("Land_title0000"));
         _loc3_.pivotX = _loc3_.pivotY = 0;
         _loc3_.x = int(GV.cent_X - _loc3_.width / 2 - 20);
         _loc3_.y = int(GV.cent_Y - 235);
         addChild(_loc3_);
         if(GV.episode < 10)
         {
            _loc5_ = GV.episode;
            if(_loc5_ > 4)
            {
               _loc5_ = _loc5_ - 5;
            }
            this._btnBattle = new BtnLocation();
            this._btnBattle.init(this._map.x + this._pxArr[_loc5_],this._map.y + this._pyArr[_loc5_]);
            addChild(this._btnBattle);
            this._btnArmory = new Button(GV.assets.getTexture("Btn_armory" + "0000"));
            this._btnArmory.x = GV.cent_X - 340;
            this._btnArmory.y = GV.scr_Y - 10 - this._btnArmory.height;
            this._btnArmory.useHandCursor = true;
            addChild(this._btnArmory);
            this._btnWeel = new Button(GV.assets.getTexture("Btn_weel" + "0000"));
            this._btnWeel.x = this._btnArmory.x + 100;
            this._btnWeel.y = GV.scr_Y - 10 - this._btnWeel.height;
            this._btnWeel.useHandCursor = true;
            addChild(this._btnWeel);
            if(GV.episode == 0)
            {
               this._btnWeel.visible = false;
            }
            if(GV.tickets > 0 && this._btnWeel.visible == true)
            {
               _loc6_ = new Image(GV.assets.getTexture("Indicator0000"));
               _loc6_.x = this._btnWeel.x + 55;
               _loc6_.y = this._btnWeel.y - 5;
               _loc6_.touchable = false;
               addChild(_loc6_);
            }
            this._btnChest = new Button(GV.assets.getTexture("Btn_chest" + "0000"));
            this._btnChest.x = this._btnWeel.x + 100;
            this._btnChest.y = GV.scr_Y - 10 - this._btnWeel.height;
            this._btnChest.useHandCursor = true;
            addChild(this._btnChest);
            if(GV.episode == 0)
            {
               this._btnChest.visible = false;
            }
            if(GV.keys >= 3 && this._btnChest.visible == true)
            {
               _loc6_ = new Image(GV.assets.getTexture("Indicator0000"));
               _loc6_.x = this._btnChest.x + 55;
               _loc6_.y = this._btnChest.y - 5;
               addChild(_loc6_);
               _loc6_.touchable = false;
            }
         }
         this._coinImg = new Image(GV.assets.getTexture("Coin0000"));
         this._coinImg.x = 20;
         this._coinImg.y = 20;
         addChild(this._coinImg);
         this._coinTxt = new TextField(100,30,"" + GV.coins,new TextFormat("NormalТNum",30,16777215,Align.LEFT));
         this._coinTxt.x = this._coinImg.x + 35;
         this._coinTxt.y = this._coinImg.y - 5;
         addChild(this._coinTxt);
         this._cristalImg = new Image(GV.assets.getTexture("Key0000"));
         this._cristalImg.x = int(this._coinImg.x + 130) - 20;
         this._cristalImg.y = 15;
         addChild(this._cristalImg);
         this._cristalTxt = new TextField(100,30,"" + GV.keys,new TextFormat("NormalТNum",30,16777215,Align.LEFT));
         this._cristalTxt.x = this._cristalImg.x + 45;
         this._cristalTxt.y = this._cristalImg.y - 5;
         addChild(this._cristalTxt);
         this._btnettings = new Button(GV.assets.getTexture("BtnSettings" + "0000"));
         this._btnettings.x = int(GV.scr_X - this._btnettings.width - 20);
         this._btnettings.y = 15;
         this._btnettings.useHandCursor = true;
         addChild(this._btnettings);
         this._btnSave = new MyButton("btn_spin0000","btn_spin0000");
         this._btnSave.init(GV.cent_X + 50,GV.scr_Y - 30,20,16777215,"Save");
         addChild(this._btnSave);
         this._btnSave.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnSave.scale = 0.7;
         this._btnSave.visible = false;
         this._btnLoad = new MyButton("btn_spin0000","btn_spin0000");
         this._btnLoad.init(GV.cent_X + 0 + 130,GV.scr_Y - 30,20,16777215,"Load");
         addChild(this._btnLoad);
         this._btnLoad.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnLoad.scale = 0.7;
         this._btnLoad.visible = false;
         this._btnPart1 = new Button(GV.assets.getTexture("Btn_shorties" + "0000"));
         this._btnPart1.x = int(GV.cent_X + 250);
         this._btnPart1.y = int(GV.scr_Y - this._btnPart1.height - 10);
         addChild(this._btnPart1);
         this._btnPart1.addEventListener(Event.TRIGGERED,this.touch_btns);
         if(GV.episode == 0)
         {
            this._btnPart1.visible = false;
         }
         if(GV.episode == 0 && GV.stars[0] == 0)
         {
            this._btnArmory.visible = false;
            _loc7_ = new HandTutorial();
            addChild(_loc7_);
            _loc7_.init_touch(this._map.x + this._pxArr[0] + 40,this._map.y + this._pyArr[0] + 40);
         }
         if(GV.episode == 0 && GV.stars[0] != 0 && GV.stars[1] == 0 && GV.her0[2] == 0)
         {
            this._btnBattle.visible = false;
            _loc7_ = new HandTutorial();
            addChild(_loc7_);
            _loc7_.init_touch(this._btnArmory.x + 50,this._btnArmory.y + 50);
         }
         this._btnLogo = new Button(GV.assets.getTexture("Logo_head0000"));
         this._btnLogo.overState = GV.assets.getTexture("Logo_head0001");
         this._btnLogo.x = int(GV.scr_X - 340);
         this._btnLogo.y = GV.scr_Y - 80;
         addChild(this._btnLogo);
         this._btnGoogle = new Button(GV.assets.getTexture("Btn_Google0000"));
         this._btnGoogle.x = int(GV.scr_X - 240);
         this._btnGoogle.y = 16;
         addChild(this._btnGoogle);
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
         }
         if(GV.settings[2] == 2)
         {
         }
      }
   }
}
