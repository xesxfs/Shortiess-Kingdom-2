package com.mygame.screens.armory
{
   import com.mygame.screens.HandTutorial;
   import com.mygame.screens.ScrBase;
   import dragonBones.animation.WorldClock;
   import starling.display.Button;
   import starling.display.Image;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.events.TouchEvent;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenArmory extends ScrBase
   {
       
      
      private var _btnBack:Button;
      
      private var _coinImg:Image;
      
      public var _coinTxt:TextField;
      
      private var _cristalImg:Image;
      
      public var _cristalTxt:TextField;
      
      private var _btnHeroes:Button;
      
      private var _btnCommonShop:Button;
      
      private var _btnPremium:Button;
      
      public var _fieldHero0:HeroField;
      
      public var _fieldHero1:HeroField;
      
      public var _fieldHero2:HeroField;
      
      public var _inventory:Storage;
      
      public var Info:InfoItem;
      
      public var Sell:SellItem;
      
      public var _isShop:Boolean = false;
      
      public var CellsArr:Array;
      
      public var ShopCellsArr:Array;
      
      public var Shop2CellsArr:Array;
      
      public var _commonShop:ComonShop;
      
      public var _premShop:PremiumShop;
      
      public var _isHand:Boolean = false;
      
      private var hand:HandTutorial;
      
      private var isShake:Boolean = false;
      
      private var _angle:Number = 0;
      
      private var amplitude:Number = 10;
      
      public function ScreenArmory()
      {
         this.CellsArr = [];
         this.ShopCellsArr = [];
         this.Shop2CellsArr = [];
         super();
         GV.game.addChildAt(this,0);
      }
      
      override public function activation() : void
      {
         GV.isTouch = false;
         this.draw();
         this._btnBack.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnHeroes.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnCommonShop.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnPremium.addEventListener(Event.TRIGGERED,this.touch_btns);
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function deactivation() : void
      {
         this._btnBack.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnHeroes.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnCommonShop.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnPremium.removeEventListener(Event.TRIGGERED,this.touch_btns);
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function free() : void
      {
         this._btnBack.removeFromParent(true);
         this._btnBack = null;
         while(this.CellsArr.length > 0)
         {
            this.CellsArr[0].free();
         }
         while(this.ShopCellsArr.length > 0)
         {
            this.ShopCellsArr[0].free();
         }
         this._inventory.free();
         super.free();
      }
      
      public function update() : void
      {
         WorldClock.clock.advanceTime(-1);
         if(this._isHand && GV.her0[2] != 0)
         {
            this._isHand = false;
            this.hand.init_touch(this._btnBack.x + 50,this._btnBack.y + 50);
         }
         if(this.isShake)
         {
            this._coinTxt.y = this._coinImg.y - 5 + Math.sin(this._angle) * this.amplitude;
            this._angle = this._angle + 0.8;
            this.amplitude = this.amplitude - 0.6;
            if(this.amplitude <= 0)
            {
               this._coinTxt.y = this._coinImg.y - 5;
               this.isShake = false;
            }
         }
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnBack)
         {
            trace("inventary:" + GV.storageArr);
            trace("h0:" + GV.her0[1],Number(GV.her0[2]));
            trace("h1:" + GV.her1[1],Number(GV.her1[2]));
            trace("h2:" + GV.her2[1],Number(GV.her2[2]));
            this.deactivation();
            GV.sound.playSFX("click");
            GV.game.SM.transition_screen("Map",true);
         }
         if(_loc2_ as Button == this._btnHeroes)
         {
            GV.sound.playSFX("click");
            this._fieldHero0.visible = true;
            this._fieldHero1.visible = true;
            this._fieldHero2.visible = true;
            this._commonShop.visible = false;
            this._premShop.visible = false;
            this._isShop = false;
         }
         if(_loc2_ as Button == this._btnCommonShop)
         {
            GV.sound.playSFX("click");
            if(!this._isHand)
            {
               this._fieldHero0.visible = false;
               this._fieldHero1.visible = false;
               this._fieldHero2.visible = false;
               this._commonShop.visible = true;
               this._premShop.visible = false;
               this._isShop = true;
            }
         }
         if(_loc2_ as Button == this._btnPremium)
         {
            this._fieldHero0.visible = false;
            this._fieldHero1.visible = false;
            this._fieldHero2.visible = false;
            this._commonShop.visible = false;
            this._premShop.visible = true;
            this._premShop.refresh_shop();
            this._isShop = true;
         }
      }
      
      private function onTouchEp_1(param1:TouchEvent) : void
      {
      }
      
      override public function draw() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Image = null;
         var _loc1_:int = GV.scr_X / 200 + 1;
         var _loc2_:int = GV.scr_Y / 200 + 1;
         var _loc3_:int = 0;
         while(_loc3_ <= _loc1_)
         {
            _loc5_ = 0;
            while(_loc5_ <= _loc2_)
            {
               _loc6_ = new Image(GV.assets.getTexture("Wall0000"));
               _loc6_.x = _loc3_ * 197;
               _loc6_.y = _loc5_ * 197;
               addChild(_loc6_);
               _loc5_++;
            }
            _loc3_++;
         }
         this._btnBack = new Button(GV.assets.getTexture("Btn_back0000"));
         this._btnBack.x = int(GV.scr_X - 15 - this._btnBack.width);
         this._btnBack.y = 15;
         addChild(this._btnBack);
         this._btnHeroes = new Button(GV.assets.getTexture("BtnHero0000"));
         this._btnHeroes.x = GV.scr_X - 100;
         this._btnHeroes.y = GV.cent_Y - 125;
         addChild(this._btnHeroes);
         this._btnCommonShop = new Button(GV.assets.getTexture("BtnHat0000"));
         this._btnCommonShop.x = GV.scr_X - 100;
         this._btnCommonShop.y = this._btnHeroes.y + 120;
         addChild(this._btnCommonShop);
         this._btnPremium = new Button(GV.assets.getTexture("BtnWeapon0000"));
         this._btnPremium.x = GV.scr_X - 100;
         this._btnPremium.y = this._btnCommonShop.y + 120;
         addChild(this._btnPremium);
         this._btnPremium.visible = false;
         _loc4_ = (GV.scr_X - 90) / 2;
         this._fieldHero0 = new HeroField();
         addChild(this._fieldHero0);
         this._fieldHero0.Init(0);
         this._fieldHero0.x = _loc4_ + 215;
         this._fieldHero0.y = GV.cent_Y - 170;
         this._fieldHero1 = new HeroField();
         addChild(this._fieldHero1);
         this._fieldHero1.Init(1);
         this._fieldHero1.x = _loc4_;
         this._fieldHero1.y = GV.cent_Y - 170;
         this._fieldHero2 = new HeroField();
         addChild(this._fieldHero2);
         this._fieldHero2.Init(2);
         this._fieldHero2.x = _loc4_ - 215;
         this._fieldHero2.y = GV.cent_Y - 170;
         if(GV.her2[0] == 0)
         {
            if(GV.her1[0] == 0)
            {
               this._fieldHero0.x = _loc4_;
               this._fieldHero1.x = -1000;
               this._fieldHero2.x = -1000;
            }
            else
            {
               this._fieldHero0.x = _loc4_ + 109;
               this._fieldHero1.x = _loc4_ - 109;
               this._fieldHero2.x = -1000;
            }
         }
         this._inventory = new Storage();
         this._inventory.Init(_loc4_);
         addChild(this._inventory);
         this._commonShop = new ComonShop();
         this._commonShop.Init();
         addChild(this._commonShop);
         this._commonShop.visible = false;
         this._premShop = new PremiumShop();
         this._premShop.Init();
         addChild(this._premShop);
         this._premShop.visible = false;
         if(GV.episode == 0 && GV.stars[0] != 0 && GV.stars[1] == 0 && GV.her0[2] == 0)
         {
            this._isHand = true;
            this.hand = new HandTutorial();
            this.hand.x = this._inventory["_btnLeft"].x + 50;
            this.hand.y = this._inventory["_btnLeft"].y + 50;
            addChild(this.hand);
            this.hand.init_move(this._inventory["_btnLeft"].x + 50,this._inventory["_btnLeft"].y + 50,this._fieldHero0.x + 50,this._fieldHero0.y + 130);
         }
         this.Info = new InfoItem();
         addChild(this.Info);
         this.Sell = new SellItem();
         addChild(this.Sell);
         this._coinImg = new Image(GV.assets.getTexture("Coin0000"));
         this._coinImg.x = 20;
         this._coinImg.y = 20;
         addChild(this._coinImg);
         this._coinTxt = new TextField(100,30,"" + GV.coins,new TextFormat("NormalТNum",30,16777215,Align.LEFT));
         this._coinTxt.x = this._coinImg.x + 35;
         this._coinTxt.y = this._coinImg.y - 5;
         addChild(this._coinTxt);
         this._cristalImg = new Image(GV.assets.getTexture("Key0000"));
         this._cristalImg.x = int(this._coinImg.x + 130);
         this._cristalImg.y = 15;
         addChild(this._cristalImg);
         this._cristalImg.visible = false;
         this._cristalTxt = new TextField(100,30,"" + GV.keys,new TextFormat("NormalТNum",30,16777215,Align.LEFT));
         this._cristalTxt.x = this._cristalImg.x + 45;
         this._cristalTxt.y = this._cristalImg.y - 5;
         addChild(this._cristalTxt);
         this._cristalTxt.visible = false;
         this.translate();
      }
      
      public function OpenInfo(param1:int, param2:Boolean) : void
      {
         this.Info.init(param1,param2);
      }
      
      public function OpenSell(param1:int) : void
      {
         this.Sell.init(param1);
      }
      
      public function Shake() : void
      {
         this.isShake = true;
         this._angle = 0;
         this.amplitude = 20;
      }
      
      override public function translate() : void
      {
      }
   }
}
