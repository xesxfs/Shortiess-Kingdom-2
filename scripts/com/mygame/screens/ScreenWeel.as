package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.mygame.screens.armory.CellPremiumShop;
   import com.mygame.screens.armory.InfoItem;
   import starling.display.Button;
   import starling.display.Image;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.events.TouchEvent;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenWeel extends ScrBase
   {
       
      
      private var _btnBack:Button;
      
      private var _btnGet:Button;
      
      private var _coinImg:Image;
      
      public var _coinTxt:TextField;
      
      private var _kImg:Image;
      
      public var _kTxt:TextField;
      
      private var _weel:Weel;
      
      private var _cell:CellPremiumShop;
      
      public var Info:InfoItem;
      
      private var _ticketImg:Image;
      
      private var _ticketTxt:TextField;
      
      public function ScreenWeel()
      {
         super();
         GV.game.addChildAt(this,0);
      }
      
      override public function activation() : void
      {
         this.draw();
         this._btnBack.addEventListener(Event.TRIGGERED,this.touch_btns);
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function deactivation() : void
      {
         this._btnBack.removeEventListener(Event.TRIGGERED,this.touch_btns);
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function free() : void
      {
         this._btnBack.removeFromParent(true);
         this._btnBack = null;
         this._weel.free();
         super.free();
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
      }
      
      private function onTouchEp_1(param1:TouchEvent) : void
      {
      }
      
      override public function draw() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Image = null;
         var _loc1_:int = GV.scr_X / 200 + 1;
         var _loc2_:int = GV.scr_Y / 200 + 1;
         var _loc3_:int = 0;
         while(_loc3_ <= _loc1_)
         {
            _loc4_ = 0;
            while(_loc4_ <= _loc2_)
            {
               _loc5_ = new Image(GV.assets.getTexture("Wall0000"));
               _loc5_.x = _loc3_ * 197;
               _loc5_.y = _loc4_ * 197;
               addChild(_loc5_);
               _loc4_++;
            }
            _loc3_++;
         }
         this._btnBack = new Button(GV.assets.getTexture("Btn_back0000"));
         this._btnBack.x = int(GV.scr_X - 15 - this._btnBack.width);
         this._btnBack.y = 15;
         addChild(this._btnBack);
         this._coinImg = new Image(GV.assets.getTexture("Coin0000"));
         this._coinImg.x = 20;
         this._coinImg.y = 20;
         addChild(this._coinImg);
         this._coinTxt = new TextField(100,30,"" + GV.coins,new TextFormat("NormalТNum",30,16777215,Align.LEFT));
         this._coinTxt.x = this._coinImg.x + 35;
         this._coinTxt.y = this._coinImg.y - 5;
         addChild(this._coinTxt);
         this._kImg = new Image(GV.assets.getTexture("Key0000"));
         this._kImg.x = int(this._coinImg.x + 130);
         this._kImg.y = 15;
         addChild(this._kImg);
         this._kTxt = new TextField(100,30,"" + GV.keys,new TextFormat("NormalТNum",30,16777215,Align.LEFT));
         this._kTxt.x = this._kImg.x + 45;
         this._kTxt.y = this._kImg.y - 5;
         addChild(this._kTxt);
         this._weel = new Weel();
         this._weel.x = GV.cent_X - 20;
         this._weel.y = GV.cent_Y + 20;
         addChild(this._weel);
         this._ticketImg = new Image(GV.assets.getTexture("Ticket0000"));
         this._ticketImg.x = GV.cent_X - 70;
         this._ticketImg.y = 20;
         addChild(this._ticketImg);
         this._ticketTxt = new TextField(100,30,"" + GV.tickets,new TextFormat("PORT",25,16777215,Align.LEFT));
         this._ticketTxt.x = this._ticketImg.x + 55;
         this._ticketTxt.y = this._ticketImg.y - 5;
         addChild(this._ticketTxt);
         this.Info = new InfoItem();
         addChild(this.Info);
         this.translate();
      }
      
      public function useTicket() : void
      {
         GV.tickets--;
         this._ticketTxt.text = "" + GV.tickets;
      }
      
      public function update(param1:EnterFrameEvent) : void
      {
         this._weel.update();
      }
      
      public function add_item(param1:int) : void
      {
         this._cell = new CellPremiumShop(param1);
         this._cell.x = -100;
         this._cell.y = GV.cent_Y;
         addChild(this._cell);
         Tweener.addTween(this._cell,{
            "x":100,
            "y":GV.cent_Y,
            "time":0.2,
            "transition":"easeOutCirc"
         });
      }
      
      public function free_item() : void
      {
         if(this._cell)
         {
            Tweener.addTween(this._cell,{
               "x":-150,
               "time":0.2,
               "transition":"easeOutCirc"
            });
         }
      }
      
      public function OpenInfo(param1:int, param2:Boolean) : void
      {
         this.Info.init(param1,param2);
         this.setChildIndex(this.Info,numChildren - 1);
      }
      
      public function refresh() : void
      {
         GV.tickets++;
         this._ticketTxt.text = "" + GV.tickets;
         this._weel.init_btn_spin();
         GV.save.localSave();
      }
      
      override public function translate() : void
      {
      }
   }
}
