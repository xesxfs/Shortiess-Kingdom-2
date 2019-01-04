package com.mygame.screens.armory
{
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   import starling.text.TextField;
   
   public class CellPremiumShop extends Sprite
   {
       
      
      public var id:int;
      
      public var type:int;
      
      public var _num:int;
      
      public var img:Image;
      
      public var nm:String;
      
      private var _sun:Image;
      
      public var _isSelect:Boolean = false;
      
      private var _isMoved:Boolean = false;
      
      private var _priceTxt:TextField;
      
      public function CellPremiumShop(param1:int)
      {
         super();
         this._num = param1;
         this.type = Math.floor(param1 / 100);
         this.id = param1 - this.type * 100;
         if(this.id < 10)
         {
            this.nm = "0" + this.id;
         }
         else
         {
            this.nm = "" + this.id;
         }
         switch(this.type)
         {
            case 1:
               this.img = new Image(GV.assets.getTexture("ShopSword00" + this.nm));
               break;
            case 2:
               this.img = new Image(GV.assets.getTexture("ShopBow00" + this.nm));
               break;
            case 3:
               this.img = new Image(GV.assets.getTexture("ShopStick00" + this.nm));
               break;
            case 4:
               this.img = new Image(GV.assets.getTexture("ShopHat00" + this.nm));
         }
         this._sun = new Image(GV.assets.getTexture("Sun0000"));
         this._sun.pivotY = this._sun.height / 2;
         this._sun.pivotX = this._sun.width / 2;
         this._sun.x = 0;
         this._sun.y = 0;
         this._sun.scale = 2;
         addChildAt(this._sun,0);
         this.img.x = this.img.y = -63;
         addChild(this.img);
         this.useHandCursor = true;
         addEventListener(TouchEvent.TOUCH,this.onTouch);
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      private function update(param1:EnterFrameEvent) : void
      {
         this._sun.rotation = this._sun.rotation + 0.02;
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               if(!GV.isTouch)
               {
                  GV.game.SM.screen["OpenInfo"](this._num,false);
               }
            }
         }
      }
      
      public function free() : *
      {
         removeEventListener(TouchEvent.TOUCH,this.onTouch);
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
         this.removeFromParent(true);
      }
   }
}
