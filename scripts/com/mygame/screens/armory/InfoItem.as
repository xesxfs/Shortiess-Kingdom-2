package com.mygame.screens.armory
{
   import com.general.MyButton;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class InfoItem extends Sprite
   {
       
      
      private var _btnClose:Button;
      
      private var img:Image;
      
      private var _field:Image;
      
      private var coin:Image;
      
      public var id:int;
      
      public var type:int;
      
      public var _num:int;
      
      public var _typeString:String;
      
      public var isPremium:Boolean;
      
      private var _nameTxt:TextField;
      
      private var _levelTxt:TextField;
      
      private var _typeTxt:TextField;
      
      private var _priceTxt:TextField;
      
      private var _dmgTxt:TextField;
      
      private var _spell1:Image;
      
      private var _spell2:Image;
      
      private var q1:Quad;
      
      private var q2:Quad;
      
      private var q3:Quad;
      
      public var nm:String;
      
      public var buyBtn:MyButton;
      
      var txt:String;
      
      public function InfoItem()
      {
         super();
         var _loc1_:Quad = new Quad(GV.scr_X,GV.scr_Y,0);
         _loc1_.alpha = 0.8;
         addChild(_loc1_);
         this._field = new Image(GV.assets.getTexture("Scroll0000"));
         this._field.x = GV.cent_X - int(this._field.width / 2);
         this._field.y = GV.cent_Y - int(this._field.height / 2) - 30;
         addChild(this._field);
         this.q1 = new Quad(282,46,6723840);
         this.q1.x = this._field.x + 7;
         this.q1.y = this._field.y + 9;
         addChild(this.q1);
         this.q2 = new Quad(282,46,6723840);
         this.q2.x = this._field.x + 7;
         this.q2.y = this._field.y + 279;
         addChild(this.q2);
         this.q3 = new Quad(262,80,5651232);
         this.q3.x = this._field.x + 17;
         this.q3.y = this._field.y + 130;
         addChild(this.q3);
         this.img = new Image(GV.assets.getTexture("Swords0000"));
         this.img.x = GV.cent_X - 29;
         this.img.y = this._field.y + 60;
         addChild(this.img);
         this.coin = new Image(GV.assets.getTexture("CoinPrice0000"));
         this.coin.x = this._field.x + this._field.width - 55;
         this.coin.y = this.q2.y + 10;
         addChild(this.coin);
         this._spell1 = new Image(GV.assets.getTexture("Spell00_0000"));
         this._spell1.x = this._field.x + 85;
         this._spell1.y = this._field.y + 215;
         this._spell1.scale = 0.8;
         addChild(this._spell1);
         this._spell1.touchable = false;
         this._spell2 = new Image(GV.assets.getTexture("Spell00_0000"));
         this._spell2.x = this._spell1.x + 70;
         this._spell2.y = this._spell1.y;
         this._spell2.scale = 0.8;
         addChild(this._spell2);
         this._spell2.touchable = false;
         this._nameTxt = new TextField(300,46,"Name",new TextFormat("PORT",20,16777215,Align.CENTER));
         this._nameTxt.x = GV.cent_X - 150;
         this._nameTxt.y = this.q1.y;
         addChild(this._nameTxt);
         this._nameTxt.touchable = false;
         this._typeTxt = new TextField(150,30,"LEGENDARY",new TextFormat("PORT",16,9992782,Align.RIGHT));
         this._typeTxt.x = this._field.x + this._field.width - 165;
         this._typeTxt.y = this._field.y + 50;
         this._typeTxt.touchable = false;
         addChild(this._typeTxt);
         this._priceTxt = new TextField(100,40,"120000",new TextFormat("NormalТNum",30,16777215,Align.RIGHT,Align.CENTER));
         this._priceTxt.x = this.coin.x - 110;
         this._priceTxt.y = this.q2.y - 3;
         this._priceTxt.touchable = false;
         addChild(this._priceTxt);
         this._dmgTxt = new TextField(this.q3.width - 10,this.q3.height,"Attack + 10%" + "\n" + "Atwefwetack + 10%" + "\n" + "Attawefewfeck + 10%",new TextFormat("PORT",16,16777215,Align.CENTER,Align.CENTER));
         this._dmgTxt.x = this.q3.x + 5;
         this._dmgTxt.y = this.q3.y;
         this._dmgTxt.touchable = false;
         addChild(this._dmgTxt);
         this._btnClose = new Button(GV.assets.getTexture("Btn_close0000"));
         this._btnClose.x = this._field.x + this._field.width - this._btnClose.width + 20;
         this._btnClose.y = this._field.y - 20;
         addChild(this._btnClose);
         this._btnClose.addEventListener(Event.TRIGGERED,this.close_info);
         this.buyBtn = new MyButton("Btn_buy_green0000","Btn_buy_green0000");
         this.buyBtn.init(GV.cent_X,GV.cent_Y + 180,20,16777215,"BUY");
         addChild(this.buyBtn);
         this.buyBtn.visible = false;
         this.buyBtn.addEventListener(Event.TRIGGERED,this.buy_item);
         if(GV.settings[2] == 1)
         {
            this.buyBtn._txt.text = "BUY";
         }
         if(GV.settings[2] == 2)
         {
            this.buyBtn._txt.text = "КУПИТЬ";
         }
         this.visible = false;
      }
      
      public function init(param1:int, param2:Boolean) : *
      {
         this._num = param1;
         this.type = Math.floor(param1 / 100);
         this.id = param1 - this.type * 100;
         this.txt = "";
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
               this.img.texture = GV.assets.getTexture("Swords00" + this.nm);
               this._typeString = "swords";
               this.weapon_description();
               break;
            case 2:
               this.img.texture = GV.assets.getTexture("Bows00" + this.nm);
               this._typeString = "bows";
               this.weapon_description();
               break;
            case 3:
               this.img.texture = GV.assets.getTexture("Sticks00" + this.nm);
               this._typeString = "sticks";
               this.weapon_description();
               break;
            case 4:
               this.img.texture = GV.assets.getTexture("Hats00" + this.nm);
               this._typeString = "heads0";
               if(GV.settings[2] == 1)
               {
                  if(GV[this._typeString][this.id][4] != 0)
                  {
                     this.txt = "Hp +" + int(GV[this._typeString][this.id][4]) + "%";
                  }
                  if(GV[this._typeString][this.id][5] != 0)
                  {
                     this.txt = this.txt + ("\n" + "Attack Power +" + int(GV[this._typeString][this.id][5]) + "%");
                  }
                  if(GV[this._typeString][this.id][11] != 0)
                  {
                     this.txt = this.txt + ("\n" + "Magic Power +" + int(GV[this._typeString][this.id][11]) + "%");
                  }
                  if(GV[this._typeString][this.id][9] != 0)
                  {
                     this.txt = this.txt + ("\n" + "Experience +" + int(GV[this._typeString][this.id][9]) + "%");
                  }
                  if(GV[this._typeString][this.id][10] != 0)
                  {
                     this.txt = this.txt + ("\n" + "Coins +" + int(GV[this._typeString][this.id][10]) + "%");
                  }
               }
               if(GV.settings[2] == 2)
               {
                  if(GV[this._typeString][this.id][4] != 0)
                  {
                     this.txt = "Жизнь +" + int(GV[this._typeString][this.id][4]) + "%";
                  }
                  if(GV[this._typeString][this.id][5] != 0)
                  {
                     this.txt = this.txt + ("\n" + "Усиление Атаки +" + int(GV[this._typeString][this.id][5]) + "%");
                  }
                  if(GV[this._typeString][this.id][11] != 0)
                  {
                     this.txt = this.txt + ("\n" + "Усиление Магии +" + int(GV[this._typeString][this.id][11]) + "%");
                  }
                  if(GV[this._typeString][this.id][9] != 0)
                  {
                     this.txt = this.txt + ("\n" + "Опыт +" + int(GV[this._typeString][this.id][9]) + "%");
                  }
                  if(GV[this._typeString][this.id][10] != 0)
                  {
                     this.txt = this.txt + ("\n" + "Награда +" + int(GV[this._typeString][this.id][10]) + "%");
                     break;
                  }
                  break;
               }
         }
         this._dmgTxt.text = this.txt;
         if(GV.settings[2] == 1)
         {
            this._nameTxt.text = GV[this._typeString][this.id][0];
         }
         if(GV.settings[2] == 2)
         {
            this._nameTxt.text = GV[this._typeString][this.id][8];
         }
         switch(GV[this._typeString][this.id][6])
         {
            case 0:
               this.q1.color = this.q2.color = 9992782;
               this._typeTxt.format.color = 12885583;
               if(GV.settings[2] == 1)
               {
                  this._typeTxt.text = "COMMON";
               }
               if(GV.settings[2] == 2)
               {
                  this._typeTxt.text = "ОБЫЧНОЕ";
               }
               this.isPremium = false;
               break;
            case 1:
               this.q1.color = this.q2.color = 6723840;
               this._typeTxt.format.color = 9292562;
               if(GV.settings[2] == 1)
               {
                  this._typeTxt.text = "UNCOMMON";
               }
               if(GV.settings[2] == 2)
               {
                  this._typeTxt.text = "НЕОБЫЧНОЕ";
               }
               this.isPremium = true;
               break;
            case 2:
               this.q1.color = this.q2.color = 16750848;
               this._typeTxt.format.color = 16750848;
               if(GV.settings[2] == 1)
               {
                  this._typeTxt.text = "LEGENDARY";
               }
               if(GV.settings[2] == 2)
               {
                  this._typeTxt.text = "ЛЕГЕНДАРНОЕ";
               }
               this.isPremium = true;
         }
         if(param2)
         {
            this.buyBtn.visible = true;
            if(GV[this._typeString][this.id][7] <= GV.coins)
            {
               this.buyBtn.overState = this.buyBtn.upState = this.buyBtn.downState = GV.assets.getTexture("Btn_buy_green0000");
            }
            else
            {
               this.buyBtn.overState = this.buyBtn.upState = this.buyBtn.downState = GV.assets.getTexture("Btn_grey0000");
            }
            if(this.isPremium)
            {
               this._priceTxt.text = "" + GV[this._typeString][this.id][8];
               this.coin.texture = GV.assets.getTexture("Cristal0000");
            }
            else
            {
               this._priceTxt.text = "" + GV[this._typeString][this.id][7];
               this.coin.texture = GV.assets.getTexture("CoinPrice0000");
            }
         }
         else
         {
            this.buyBtn.visible = false;
            this._priceTxt.text = "" + GV[this._typeString][this.id][7];
            this.coin.texture = GV.assets.getTexture("CoinPrice0000");
         }
         if(this.type < 4)
         {
            this._spell1.texture = GV.assets.getTexture("Spell" + (this.type - 1) + GV[this._typeString][this.id][4] + "_0000");
            this._spell1.visible = true;
            if(GV[this._typeString][this.id][5] > 0)
            {
               this._spell2.texture = GV.assets.getTexture("Spell" + (this.type - 1) + GV[this._typeString][this.id][5] + "_0000");
               this._spell1.x = this._field.x + 85;
               this._spell2.x = this._spell1.x + 70;
               this._spell2.visible = true;
            }
            else
            {
               this._spell1.x = this._field.x + 120;
               this._spell2.visible = false;
            }
         }
         else
         {
            this._spell1.visible = false;
            this._spell2.visible = false;
         }
         this.visible = true;
      }
      
      private function weapon_description() : *
      {
         if(GV.settings[2] == 1)
         {
            this.txt = "Attack + " + int(GV[this._typeString][this.id][9]) + "%";
            if(GV[this._typeString][this.id][12] != 0)
            {
               this.txt = this.txt + ("\n" + "Experience +" + int(GV[this._typeString][this.id][12]) + "%");
            }
            if(GV[this._typeString][this.id][13] != 0)
            {
               this.txt = this.txt + ("\n" + "Coins +" + int(GV[this._typeString][this.id][13]) + "%");
            }
         }
         if(GV.settings[2] == 2)
         {
            this.txt = "Атака + " + int(GV[this._typeString][this.id][9]) + "%";
            if(GV[this._typeString][this.id][12] != 0)
            {
               this.txt = this.txt + ("\n" + "Опыт +" + int(GV[this._typeString][this.id][12]) + "%");
            }
            if(GV[this._typeString][this.id][13] != 0)
            {
               this.txt = this.txt + ("\n" + "Награда +" + int(GV[this._typeString][this.id][13]) + "%");
            }
         }
      }
      
      private function close_info(param1:Event) : *
      {
         GV.sound.playSFX("click");
         this.visible = false;
      }
      
      private function buy_item(param1:Event) : *
      {
         if(!this.isPremium)
         {
            if(GV[this._typeString][this.id][7] <= GV.coins)
            {
               GV.sound.playSFX("sell");
               GV.coins = GV.coins - GV[this._typeString][this.id][7];
               GV.game.SM.screen["_coinTxt"].text = "" + GV.coins;
               this.save_item();
               GV.save.localSave();
            }
            else
            {
               parent["Shake"]();
               GV.sound.playSFX("error");
            }
         }
      }
      
      private function save_item() : *
      {
         var _loc2_:String = null;
         if(this.isPremium)
         {
            _loc2_ = "2";
         }
         else
         {
            _loc2_ = "";
         }
         var _loc1_:int = 0;
         while(_loc1_ < GV.game.SM.screen["Shop" + _loc2_ + "CellsArr"].length)
         {
            if(GV.game.SM.screen["Shop" + _loc2_ + "CellsArr"][_loc1_]._num == this._num)
            {
               GV.game.SM.screen["Shop" + _loc2_ + "CellsArr"][_loc1_].free();
               break;
            }
            _loc1_++;
         }
         GV.storageArr.push(this._num);
         GV.game.SM.screen["_inventory"]["CreateNewItem"](this._num);
         GV.game.SM.screen["_inventory"]["Grouping"]();
         this.visible = false;
         switch(this.type)
         {
            case 1:
               if(this.id > GV.her0[7])
               {
                  GV.her0[7] = this.id;
                  break;
               }
               break;
            case 2:
               if(this.id > GV.her1[7])
               {
                  GV.her1[7] = this.id;
                  break;
               }
               break;
            case 3:
               if(this.id > GV.her2[7])
               {
                  GV.her2[7] = this.id;
                  break;
               }
               break;
            case 4:
               if(this.id < 10)
               {
                  if(this.id > GV.her0[8])
                  {
                     GV.her0[8] = this.id;
                     break;
                  }
                  break;
               }
               if(this.id < 19)
               {
                  if(this.id > GV.her1[8])
                  {
                     GV.her1[8] = this.id;
                     break;
                  }
                  break;
               }
               if(this.id > GV.her2[8])
               {
                  GV.her2[8] = this.id;
                  break;
               }
               break;
         }
      }
   }
}
