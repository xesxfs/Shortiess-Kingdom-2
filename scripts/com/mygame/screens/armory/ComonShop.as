package com.mygame.screens.armory
{
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.textures.Texture;
   import starling.utils.Align;
   
   public class ComonShop extends Sprite
   {
       
      
      private var step:int = 155;
      
      private var _nameTxt:TextField;
      
      public function ComonShop()
      {
         super();
      }
      
      public function Init() : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Image = null;
         this._nameTxt = new TextField(247,40,"Common Shop",new TextFormat("PORT",20,16777215,Align.CENTER));
         this._nameTxt.x = GV.cent_X - 123;
         this._nameTxt.y = 30;
         addChild(this._nameTxt);
         this._nameTxt.touchable = false;
         var _loc1_:Texture = GV.assets.getTexture("ShopEmpty0000");
         _loc2_ = 0;
         while(_loc2_ <= 2)
         {
            _loc3_ = 0;
            while(_loc3_ <= 1)
            {
               _loc3_++;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ <= 1)
         {
            _loc3_ = 0;
            while(_loc3_ <= 2)
            {
               _loc4_ = new Image(_loc1_);
               _loc4_.x = GV.cent_X + (_loc3_ - 1) * this.step - 50;
               _loc4_.y = GV.cent_Y + (_loc2_ - 1) * this.step + 50;
               addChild(_loc4_);
               _loc3_++;
            }
            _loc2_++;
         }
         this.CheckProdacts(0,7,0,"swords",100);
         this.CheckProdacts(1,7,1,"bows",200);
         this.CheckProdacts(2,7,2,"sticks",300);
         this.CheckProdacts(0,8,3,"heads0",400);
         this.CheckProdacts(1,8,4,"heads0",400);
         this.CheckProdacts(2,8,5,"heads0",400);
         this.Grouping();
         this.translate();
      }
      
      public function CheckProdacts(param1:int, param2:int, param3:int, param4:String, param5:int) : *
      {
         var _loc6_:int = 0;
         var _loc7_:CellCommonShop = null;
         if(GV["her" + param1][param2] < GV.open_weapon[param3])
         {
            _loc6_ = 1;
            while(_loc6_ < 15)
            {
               if(GV[param4].length > GV["her" + param1][param2] + _loc6_ && GV["her" + param1][0] != 0)
               {
                  if(GV[param4][GV["her" + param1][param2] + _loc6_][1] <= GV.open_weapon[param3] && GV[param4][GV["her" + param1][param2] + _loc6_][6] == 0)
                  {
                     _loc7_ = new CellCommonShop(param5 + (GV["her" + param1][param2] + _loc6_));
                     addChild(_loc7_);
                     break;
                  }
                  _loc6_++;
                  continue;
               }
               break;
            }
         }
      }
      
      public function Grouping() : *
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ <= 1)
         {
            _loc3_ = 0;
            while(_loc3_ <= 2)
            {
               if(_loc1_ < GV.game.SM.screen["ShopCellsArr"].length)
               {
                  GV.game.SM.screen["ShopCellsArr"][_loc1_].x = GV.cent_X + (_loc3_ - 1) * this.step - 50;
                  GV.game.SM.screen["ShopCellsArr"][_loc1_].y = GV.cent_Y + (_loc2_ - 1) * this.step + 50;
                  _loc1_++;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function Free() : *
      {
         if(GV.settings[2] == 1)
         {
            this._nameTxt.text = "Shop";
         }
         if(GV.settings[2] == 2)
         {
            this._nameTxt.text = "Магазин";
         }
      }
      
      public function translate() : void
      {
      }
   }
}
