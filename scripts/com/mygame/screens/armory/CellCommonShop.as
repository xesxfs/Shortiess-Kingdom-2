package com.mygame.screens.armory
{
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   import starling.text.TextField;
   
   public class CellCommonShop extends Sprite
   {
       
      
      public var id:int;
      
      public var type:int;
      
      public var _num:int;
      
      public var img:Image;
      
      public var nm:String;
      
      public var _isSelect:Boolean = false;
      
      private var _isMoved:Boolean = false;
      
      private var _priceTxt:TextField;
      
      public function CellCommonShop(param1:int)
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
         this.img.x = this.img.y = -63;
         addChild(this.img);
         this.useHandCursor = true;
         addEventListener(TouchEvent.TOUCH,this.onTouch);
         GV.game.SM.screen["ShopCellsArr"].push(this);
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
                  GV.game.SM.screen["OpenInfo"](this._num,true);
               }
            }
         }
      }
      
      public function free() : *
      {
         removeEventListener(TouchEvent.TOUCH,this.onTouch);
         var _loc1_:int = 0;
         while(_loc1_ < GV.game.SM.screen["ShopCellsArr"].length)
         {
            if(GV.game.SM.screen["ShopCellsArr"][_loc1_] == this)
            {
               GV.game.SM.screen["ShopCellsArr"][_loc1_] = null;
               GV.game.SM.screen["ShopCellsArr"].splice(_loc1_,1);
               break;
            }
            _loc1_++;
         }
         this.removeFromParent(true);
      }
   }
}
