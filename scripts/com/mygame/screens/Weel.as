package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import com.general.MyButton;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   
   public class Weel extends Sprite
   {
       
      
      public var id:int;
      
      public var type:int;
      
      public var _num:int;
      
      private var _weel:Sprite;
      
      private var _isState:String = "wait";
      
      private var _sectors:Array;
      
      private var _speed:Number;
      
      private var _types0:Array;
      
      private var _types1:Array;
      
      private var _types2:Array;
      
      private var _types3:Array;
      
      public var _btnStart:MyButton;
      
      private var _startTxt:TextField;
      
      private var _isAlpha:Boolean = false;
      
      private var _targRotation:Number;
      
      private var _numSector:int;
      
      private var _oldFrame:int;
      
      private var _time:int;
      
      private var _numBlink:int;
      
      public var _oldCoin:int;
      
      public var _winCoin:int;
      
      private var arr:Array;
      
      private var level:int = 0;
      
      public function Weel()
      {
         this._sectors = [];
         this._types0 = [1,4,2,5,3,4,2,5];
         this._types1 = [1,6,2,7,3,6,2,7];
         this._types2 = [1,8,2,9,3,8,2,9];
         this._types3 = [1,10,2,11,3,10,2,11];
         this.arr = [];
         super();
         this.draw();
      }
      
      public function free() : void
      {
         Tweener.removeTweens(this);
         this._btnStart.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this.removeFromParent(true);
      }
      
      public function init_btn_spin() : void
      {
         if(GV.tickets > 0)
         {
            this._isState = "wait";
            this._btnStart.alpha = 1;
         }
         else
         {
            this._btnStart.alpha = 0.5;
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         if(this._winCoin > 0)
         {
            this._oldCoin = this._oldCoin + 25;
            this._winCoin = this._winCoin - 25;
            parent["_coinTxt"].text = "" + this._oldCoin;
         }
         switch(this._isState)
         {
            case "wait":
               break;
            case "rotation":
               this._weel.rotation = this._weel.rotation + this._speed;
               this._speed = this._speed - 0.01;
               if(this._speed <= 0)
               {
                  this._isState = "find";
                  break;
               }
               break;
            case "find":
               _loc1_ = Amath.toDegrees(this._weel.rotation);
               if(_loc1_ < 0)
               {
                  _loc1_ = _loc1_ + 360;
               }
               this._numSector = 8 - Math.ceil(_loc1_ / 45);
               if(this._numSector < 0)
               {
                  this._numSector = 0;
               }
               if(this._numSector > 7)
               {
                  this._numSector = 0;
               }
               this._targRotation = -Amath.toRadians(this._numSector * 45 + 22.5);
               this._oldFrame = this._sectors[this._numSector].currentFrame;
               this._isState = "blink";
               GV.sound.playSFX("prize");
               this._time = 0;
               this._numBlink = 8;
               this.Blinking();
               break;
            case "blink":
               this._weel.rotation = Amath.stepToR(this._weel.rotation,this._targRotation,0.005);
               break;
            case "prize":
         }
      }
      
      public function Blinking() : void
      {
         if(this._numBlink == 0)
         {
            this._isState = "prize";
            this.add_prize(this["_types" + this.level][this._numSector]);
            this.init_btn_spin();
            GV.save.localSave();
         }
         else
         {
            if(this._sectors[this._numSector].currentFrame == 3)
            {
               this._sectors[this._numSector].currentFrame = this._oldFrame;
            }
            else
            {
               this._sectors[this._numSector].currentFrame = 3;
            }
            this._numBlink--;
            setTimeout(this.Blinking,100);
         }
      }
      
      public function spin() : void
      {
         if(this._isState == "wait" && GV.tickets > 0)
         {
            GV.sound.playSFX("weel");
            this._speed = Amath.toRadians(Amath.random(50,80) / 2);
            this._isState = "rotation";
            parent["free_item"]();
            parent["useTicket"]();
            GV.save.localSave();
         }
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnStart)
         {
            this.spin();
         }
      }
      
      public function add_prize(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               param1 = this.arr[Amath.random(0,this.arr.length - 1)];
               this.type = Math.floor(param1 / 100);
               this.id = param1 - this.type * 100;
               parent["add_item"](param1);
               this.save_item(param1);
               this.check_items();
               break;
            case 2:
               GV.keys = GV.keys + 1;
               break;
            case 3:
               GV.keys = GV.keys + 2;
               break;
            case 4:
               this._oldCoin = GV.coins;
               this._winCoin = 100;
               break;
            case 5:
               this._oldCoin = GV.coins;
               this._winCoin = 250;
               break;
            case 6:
               this._oldCoin = GV.coins;
               this._winCoin = 250;
               break;
            case 7:
               this._oldCoin = GV.coins;
               this._winCoin = 500;
               break;
            case 8:
               this._oldCoin = GV.coins;
               this._winCoin = 500;
               break;
            case 9:
               this._oldCoin = GV.coins;
               this._winCoin = 1000;
               break;
            case 10:
               this._oldCoin = GV.coins;
               this._winCoin = 2500;
               break;
            case 11:
               this._oldCoin = GV.coins;
               this._winCoin = 5000;
         }
         GV.coins = GV.coins + this._winCoin;
         parent["_kTxt"].text = "" + GV.keys;
      }
      
      public function CheckWeapon(param1:String, param2:int, param3:String, param4:int) : *
      {
         var _loc6_:int = 0;
         var _loc5_:int = GV[param1][7];
         if(_loc5_ < GV.open_weapon[param2])
         {
            _loc6_ = 1;
            while(_loc6_ < 15)
            {
               if(GV[param3].length > _loc5_ + _loc6_ && GV[param1][0] != 0)
               {
                  if(GV[param3][_loc5_ + _loc6_][1] < GV.open_weapon[param2] && GV[param3][_loc5_ + _loc6_][6] == 0)
                  {
                     this.arr.push(param4 + (_loc5_ + _loc6_));
                     break;
                  }
                  _loc6_++;
                  continue;
               }
               break;
            }
         }
      }
      
      public function ChecHat(param1:String, param2:int, param3:String, param4:int, param5:int) : *
      {
         var _loc7_:int = 0;
         var _loc6_:int = GV[param1][8];
         if(_loc6_ < GV.open_weapon[param2])
         {
            _loc7_ = 1;
            while(_loc7_ <= 10)
            {
               if(_loc6_ + _loc7_ <= param5 && GV[param1][0] != 0)
               {
                  if(GV[param3][_loc6_ + _loc7_][1] < GV.open_weapon[param2] && GV[param3][_loc6_ + _loc7_][6] == 0)
                  {
                     this.arr.push(400 + (_loc6_ + _loc7_));
                     break;
                  }
                  _loc7_++;
                  continue;
               }
               break;
            }
         }
      }
      
      private function save_item(param1:int) : *
      {
         GV.storageArr.push(param1);
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
      
      public function add_alpha() : void
      {
         if(this._isAlpha)
         {
            Tweener.addTween(this._startTxt,{
               "alpha":0.1,
               "time":0.3,
               "transition":"linear",
               "onComplete":this.add_alpha
            });
            this._isAlpha = false;
         }
         else
         {
            Tweener.addTween(this._startTxt,{
               "alpha":1,
               "time":0.3,
               "transition":"linear",
               "onComplete":this.add_alpha
            });
            this._isAlpha = true;
         }
      }
      
      public function draw() : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         this._weel = new Sprite();
         this._weel.x = 0;
         this._weel.y = 0;
         addChild(this._weel);
         var _loc1_:Boolean = false;
         var _loc2_:Number = 22.5;
         var _loc3_:int = 0;
         while(_loc3_ < 8)
         {
            if(_loc1_)
            {
               _loc6_ = new MovieClip(GV.assets.getTextures("Sector"));
               _loc1_ = false;
               _loc6_.currentFrame = 1;
            }
            else
            {
               _loc6_ = new MovieClip(GV.assets.getTextures("Sector"));
               _loc1_ = true;
               _loc6_.currentFrame = 2;
            }
            _loc6_.pivotY = _loc6_.height / 2;
            _loc6_.rotation = Amath.toRadians(_loc2_);
            this._weel.addChild(_loc6_);
            this._sectors.push(_loc6_);
            _loc2_ = _loc2_ + 45;
            _loc3_++;
         }
         _loc2_ = 22.5;
         this.level = 0;
         if(GV.episode > 2 && GV.episode < 6)
         {
            this.level = 1;
         }
         else if(GV.episode > 5 && GV.episode < 7)
         {
            this.level = 2;
         }
         else if(GV.episode >= 7)
         {
            this.level = 3;
         }
         trace(GV.episode,this.level);
         this.check_items();
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc7_ = new MovieClip(GV.assets.getTextures("Weel_pics"));
            _loc7_.pivotX = 0;
            _loc7_.pivotY = 0;
            _loc7_.x = this._sectors[_loc3_].localToGlobal(new Point(45,35)).x;
            _loc7_.y = this._sectors[_loc3_].localToGlobal(new Point(45,35)).y;
            _loc7_.rotation = Amath.toRadians(_loc2_);
            _loc7_.currentFrame = this["_types" + this.level][_loc3_];
            this._weel.addChild(_loc7_);
            _loc2_ = _loc2_ + 45;
            _loc3_++;
         }
         var _loc4_:Image = new Image(GV.assets.getTexture("Weel_circle0000"));
         _loc4_.pivotX = _loc4_.pivotY = _loc4_.width / 2;
         this._weel.addChild(_loc4_);
         var _loc5_:Image = new Image(GV.assets.getTexture("Weel_arrow0000"));
         _loc5_.pivotY = _loc5_.height / 2;
         _loc5_.x = this._weel.x + 160;
         _loc5_.y = this._weel.y;
         addChild(_loc5_);
         this._btnStart = new MyButton("btn_spin0000","btn_spin0000");
         this._btnStart.init(250,0,20,16777215,"Spin");
         addChild(this._btnStart);
         this._btnStart.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnStart.useHandCursor = true;
         this._btnStart.alpha = 0.5;
         if(GV.settings[2] == 1)
         {
            this._btnStart._txt.text = "Spin";
         }
         if(GV.settings[2] == 2)
         {
            this._btnStart._txt.text = "Старт";
         }
         this.init_btn_spin();
      }
      
      public function check_items() : void
      {
         this.arr = [];
         this.CheckWeapon("her0",0,"swords",100);
         this.CheckWeapon("her1",1,"bows",200);
         this.CheckWeapon("her2",2,"sticks",300);
         this.ChecHat("her0",3,"heads0",1,9);
         this.ChecHat("her1",4,"heads0",10,18);
         this.ChecHat("her2",5,"heads0",19,27);
         if(this.arr.length == 0)
         {
            this["_types" + this.level][0] = 2;
         }
      }
   }
}
