package com.mygame.screens.armory
{
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class SellItem extends Sprite
   {
       
      
      private var _btnNo:Button;
      
      private var _btnYes:Button;
      
      private var _field:Image;
      
      public var _num:int;
      
      public var _price:int;
      
      private var _text:TextField;
      
      public function SellItem()
      {
         super();
         var _loc1_:Quad = new Quad(GV.scr_X,GV.scr_Y,0);
         _loc1_.alpha = 0.8;
         addChild(_loc1_);
         this._field = new Image(GV.assets.getTexture("SellField0000"));
         this._field.x = GV.cent_X - int(this._field.width / 2);
         this._field.y = GV.cent_Y - int(this._field.height / 2) - 30;
         addChild(this._field);
         this._btnNo = new Button(GV.assets.getTexture("Btn_no0000"));
         this._btnNo.x = this._field.x + this._field.width / 2 - 80 - 30;
         this._btnNo.y = this._field.y + 100;
         addChild(this._btnNo);
         this._btnNo.addEventListener(Event.TRIGGERED,this.noSell);
         this._btnYes = new Button(GV.assets.getTexture("Btn_ok0000"));
         this._btnYes.x = this._field.x + this._field.width / 2 + 80 - 40;
         this._btnYes.y = this._btnNo.y;
         addChild(this._btnYes);
         this._btnYes.addEventListener(Event.TRIGGERED,this.yesSell);
         this._text = new TextField(230,80,"",new TextFormat("PORT",18,16777215,Align.CENTER));
         this._text.x = this._field.x + 10;
         this._text.y = this._field.y + 10;
         addChild(this._text);
         this._text.touchable = false;
         this.visible = false;
      }
      
      public function init(param1:int) : *
      {
         var _loc4_:String = null;
         this._num = param1;
         var _loc2_:int = Math.floor(this._num / 100);
         var _loc3_:int = param1 - _loc2_ * 100;
         switch(_loc2_)
         {
            case 1:
               _loc4_ = "swords";
               break;
            case 2:
               _loc4_ = "bows";
               break;
            case 3:
               _loc4_ = "sticks";
               break;
            case 4:
               _loc4_ = "heads0";
         }
         this._price = GV[_loc4_][_loc3_][7];
         if(GV.settings[2] == 1)
         {
            this._text.text = "Are you sure \n you want to sell it for " + int(this._price) + " ?";
         }
         if(GV.settings[2] == 2)
         {
            this._text.text = "Вы хотите продать \n это за " + int(this._price) + " ?";
         }
         this.visible = true;
      }
      
      private function noSell(param1:Event) : *
      {
         GV.sound.playSFX("click");
         this.visible = false;
         GV.game.SM.screen["_inventory"]["CreateNewItem"](this._num);
         GV.game.SM.screen["_inventory"]["Grouping"]();
      }
      
      private function yesSell(param1:Event) : *
      {
         GV.sound.playSFX("sell");
         this.visible = false;
         GV.coins = GV.coins + int(this._price * 1);
         GV.game.SM.screen["_coinTxt"].text = "" + GV.coins;
         GV.game.SM.screen["_inventory"]["Grouping"]();
      }
   }
}
