package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.mygame.managers.LootManager;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenVictory extends ScrBase
   {
       
      
      private var _sprite:Sprite;
      
      public var _sprite2:Sprite;
      
      private var _line:Quad;
      
      private var _RewardPosY:int = 0;
      
      private var _back:Quad;
      
      private var _board:Image;
      
      private var _sun:Image;
      
      private var _startX:int;
      
      private var _numChest:int = 0;
      
      private var chestArr:Array;
      
      private var lootArr:Array;
      
      private var iconsArr:Array;
      
      private var _isState:String = "Init";
      
      private var lootMng:LootManager;
      
      private var posX:int;
      
      private var posY:int;
      
      private var numInLine:int;
      
      private var maxInLine:int = 7;
      
      private var _numLoot:int = 0;
      
      private var _numHeroes:int = 0;
      
      private var _awardTxt:TextField;
      
      private var _lootTxt:TextField;
      
      private var _coinImg:Image;
      
      public var _coinTxt:TextField;
      
      public function ScreenVictory()
      {
         this.chestArr = [];
         this.lootArr = [];
         this.iconsArr = [];
         super();
         GV.game.addChild(this);
      }
      
      public function init(param1:Boolean) : void
      {
         var _loc5_:IconExpirience = null;
         trace("**************");
         trace("knight = " + GV.knight);
         trace("hunter = " + GV.hunter);
         trace("monk = " + GV.monk);
         trace("**************");
         GV.knight = 0;
         GV.hunter = 0;
         GV.monk = 0;
         this._back = new Quad(GV.scr_X,GV.scr_Y,0);
         addChild(this._back);
         this._back.alpha = 0;
         Tweener.addTween(this._back,{
            "alpha":0.7,
            "time":0.4,
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
         this._awardTxt = new TextField(100,30,"Reward:",new TextFormat("PORT",20,16777215,Align.LEFT));
         this._awardTxt.x = GV.cent_X - 330;
         this._awardTxt.y = 50;
         this._sprite.addChild(this._awardTxt);
         this._awardTxt.touchable = false;
         this._coinImg = new Image(GV.assets.getTexture("Coin0000"));
         this._coinImg.x = this._awardTxt.x;
         this._coinImg.y = this._awardTxt.y + 50;
         this._sprite.addChild(this._coinImg);
         this._coinTxt = new TextField(200,30,"",new TextFormat("PORT",25,16777215,Align.LEFT));
         this._coinTxt.x = this._coinImg.x + 35;
         this._coinTxt.y = this._coinImg.y - 7;
         this._sprite.addChild(this._coinTxt);
         GV.sound.stopMusic();
         if(param1)
         {
            GV.sound.playSFX("win");
            this._board = new Image(GV.assets.getTexture("Victory" + "0000"));
            switch(GV.level)
            {
               case 0:
                  if(GV.her0[7] < 1)
                  {
                     this.Add_Item(101);
                     break;
                  }
                  break;
               case 2:
                  GV.episode = 1;
                  if(GV.her1[7] < 1)
                  {
                     this.Add_Item(201);
                  }
                  if(GV.tickets == 0)
                  {
                     GV.tickets++;
                     break;
                  }
                  break;
               case 5:
                  GV.episode = 2;
                  break;
               case 8:
                  GV.episode = 3;
                  break;
               case 11:
                  GV.episode = 4;
                  break;
               case 14:
                  GV.episode = 5;
                  GV.open_weapon = [15,15,15,9,18,27];
                  break;
               case 19:
                  GV.episode = 6;
                  break;
               case 24:
                  GV.episode = 7;
                  break;
               case 29:
                  GV.episode = 8;
                  break;
               case 34:
                  GV.episode = 9;
                  break;
               case 39:
                  GV.episode = 10;
            }
            if(GV.stars[GV.level] == 0)
            {
               GV.freeCoins = GV.freeCoins * 2;
               GV.stars[GV.level] = 1;
               this.Add_Key(1);
               if(Math.random() < 0.3)
               {
                  this.Add_Ticket(1);
               }
            }
         }
         else
         {
            GV.sound.playSFX("fail");
            this._board = new Image(GV.assets.getTexture("Defeat" + "0000"));
         }
         GV.coins = GV.coins + (int(GV.freeCoins) + int(GV.freeCoins * GV.factorCoins));
         this._coinTxt.text = "" + int(GV.freeCoins);
         if(GV.factorCoins > 0)
         {
            this._coinTxt.text = this._coinTxt.text + ("(+" + int(GV.freeCoins * GV.factorCoins) + ")");
         }
         this._board.pivotY = int(this._board.height);
         this._board.x = int(GV.cent_X - this._board.width / 2);
         this._board.y = int(GV.cent_Y - 0);
         this._sprite.addChild(this._board);
         this._sun = new Image(GV.assets.getTexture("Sun0000"));
         this._sun.pivotY = this._sun.height / 2;
         this._sun.pivotX = this._sun.width / 2;
         this._sun.x = GV.cent_X;
         this._sun.y = GV.cent_Y - 100;
         this._sun.scale = 2;
         this._sprite.addChildAt(this._sun,0);
         this._sprite2 = new Sprite();
         addChild(this._sprite2);
         this._sprite2.y = GV.scr_Y;
         this._line = new Quad(GV.scr_X,110,9187631);
         this._line.y = GV.cent_Y + 40;
         this._sprite2.addChild(this._line);
         Tweener.addTween(this._sprite2,{
            "y":0,
            "time":0.4,
            "delay":0.5,
            "transition":"easeOutBack",
            "onComplete":this.StartExpirience
         });
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            if(GV["her" + _loc2_][0] > 0)
            {
               _loc5_ = new IconExpirience();
               _loc5_.init(_loc2_);
               _loc5_.y = this._line.y - 15;
               this._sprite2.addChild(_loc5_);
               this.iconsArr.push(_loc5_);
               this._numHeroes++;
            }
            _loc2_++;
         }
         var _loc3_:* = GV.cent_X + this.iconsArr.length * 150 / 2 - 80;
         _loc2_ = 0;
         while(_loc2_ < this.iconsArr.length)
         {
            this.iconsArr[_loc2_].x = _loc3_ - _loc2_ * 150;
            _loc2_++;
         }
         GV.save.localSave();
         this.translate();
      }
      
      override public function activation() : void
      {
         this.posY = GV.cent_Y + 150;
         GV.game.addChild(this);
         GV.LM._tMenu.FreeAllSkills();
      }
      
      override public function deactivation() : void
      {
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
         removeEventListener(TouchEvent.TOUCH,this.onTouch);
      }
      
      override public function free() : void
      {
         while(this.iconsArr.length > 0)
         {
            this.iconsArr[0].free();
            this.iconsArr[0] = null;
            this.iconsArr.splice(0,1);
         }
         this._back.removeFromParent();
         this._board.removeFromParent();
         this._sun.removeFromParent();
         this._line.removeFromParent();
         super.free();
      }
      
      private function update(param1:Event) : void
      {
         this._sun.rotation = this._sun.rotation + 0.02;
         var _loc2_:int = 0;
         while(_loc2_ < this.iconsArr.length)
         {
            this.iconsArr[_loc2_].update();
            _loc2_++;
         }
      }
      
      private function StartExpirience() : void
      {
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      public function StopExpirience() : void
      {
         this._numHeroes--;
         if(this._numHeroes == 0)
         {
            addEventListener(TouchEvent.TOUCH,this.onTouch);
         }
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               this._isState = "End";
               this.deactivation();
               if(GV.episode != 10)
               {
                  GV.game.SM.transition_screen("Map",true);
               }
               else
               {
                  GV.game.SM.transition_screen("End",true);
               }
            }
         }
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
      }
      
      public function Add_Item(param1:int) : void
      {
         var _loc5_:String = null;
         this._lootTxt = new TextField(100,30,"Loot:",new TextFormat("PORT",20,16777215,Align.CENTER));
         this._lootTxt.x = GV.cent_X + 230;
         this._lootTxt.y = 50;
         this._sprite.addChild(this._lootTxt);
         this._lootTxt.touchable = false;
         GV.storageArr.push(param1);
         var _loc2_:int = Math.floor(param1 / 100);
         var _loc3_:int = param1 - _loc2_ * 100;
         var _loc4_:Image = new Image(GV.assets.getTexture("Swords0000"));
         _loc4_.x = this._lootTxt.x + 20;
         _loc4_.y = this._lootTxt.y + 50;
         this._sprite.addChild(_loc4_);
         if(_loc3_ < 10)
         {
            _loc5_ = "0" + _loc3_;
         }
         else
         {
            _loc5_ = "" + _loc3_;
         }
         switch(_loc2_)
         {
            case 1:
               _loc4_.texture = GV.assets.getTexture("Swords00" + _loc5_);
               if(_loc3_ > GV.her0[7])
               {
                  GV.her0[7] = _loc3_;
                  break;
               }
               break;
            case 2:
               _loc4_.texture = GV.assets.getTexture("Bows00" + _loc5_);
               if(_loc3_ > GV.her1[7])
               {
                  GV.her1[7] = _loc3_;
                  break;
               }
               break;
            case 3:
               _loc4_.texture = GV.assets.getTexture("Sticks00" + _loc5_);
               if(_loc3_ > GV.her2[7])
               {
                  GV.her2[7] = _loc3_;
                  break;
               }
               break;
            case 4:
               _loc4_.texture = GV.assets.getTexture("Hats00" + _loc5_);
               if(_loc3_ < 9)
               {
                  if(_loc3_ > GV.her0[8])
                  {
                     GV.her0[8] = _loc3_;
                     break;
                  }
                  break;
               }
               if(_loc3_ < 18)
               {
                  if(_loc3_ > GV.her1[8])
                  {
                     GV.her1[8] = _loc3_;
                     break;
                  }
                  break;
               }
               if(_loc3_ > GV.her2[8])
               {
                  GV.her2[8] = _loc3_;
                  break;
               }
               break;
         }
         this._RewardPosY++;
      }
      
      public function Add_Key(param1:int) : void
      {
         var _loc2_:Image = new Image(GV.assets.getTexture("Key0000"));
         _loc2_.x = this._awardTxt.x - 10;
         _loc2_.y = this._awardTxt.y + 90;
         this._sprite.addChild(_loc2_);
         var _loc3_:TextField = new TextField(100,30,"x" + param1,new TextFormat("PORT",25,16777215,Align.LEFT));
         _loc3_.x = _loc2_.x + 50;
         _loc3_.y = _loc2_.y - 5;
         this._sprite.addChild(_loc3_);
         GV.keys++;
      }
      
      public function Add_Ticket(param1:int) : void
      {
         var _loc2_:Image = new Image(GV.assets.getTexture("Ticket0000"));
         _loc2_.x = this._awardTxt.x - 15;
         _loc2_.y = this._awardTxt.y + 140;
         this._sprite.addChild(_loc2_);
         var _loc3_:TextField = new TextField(100,30,"x" + param1,new TextFormat("PORT",25,16777215,Align.LEFT));
         _loc3_.x = _loc2_.x + 55;
         _loc3_.y = _loc2_.y - 5;
         this._sprite.addChild(_loc3_);
         GV.tickets++;
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this._awardTxt.text = "Reward:";
            if(this._lootTxt)
            {
               this._lootTxt.text = "Loot:";
            }
         }
         if(GV.settings[2] == 2)
         {
            this._awardTxt.text = "Награда:";
            if(this._lootTxt)
            {
               this._lootTxt.text = "Найдено:";
            }
         }
      }
   }
}
