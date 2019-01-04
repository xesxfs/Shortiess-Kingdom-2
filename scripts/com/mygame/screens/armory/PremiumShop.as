package com.mygame.screens.armory
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class PremiumShop extends Sprite
   {
       
      
      public var id:int;
      
      public var type:int;
      
      public var _num:int;
      
      private var _name1Txt:TextField;
      
      private var _name2Txt:TextField;
      
      private var _chest1:MovieClip;
      
      private var _chest2:MovieClip;
      
      private var _price1:Image;
      
      private var _price2:Image;
      
      private var _sprite1:Sprite;
      
      private var _sprite2:Sprite;
      
      private var state:String = "stop";
      
      private var _hit:int = 0;
      
      private var seect_num:int;
      
      private var gereenArr:Array;
      
      private var yellowArr:Array;
      
      private var _cell:CellPremiumShop;
      
      public function PremiumShop()
      {
         this.gereenArr = [];
         this.yellowArr = [];
         super();
      }
      
      public function Init() : *
      {
         this._sprite1 = new Sprite();
         this._sprite1.x = (GV.scr_X - 100) / 2 - 120;
         addChild(this._sprite1);
         this._chest1 = new MovieClip(GV.assets.getTextures("Chest1_"));
         this._chest1.x = -int(this._chest1.width / 2) - 20;
         this._chest1.y = 180;
         this._chest1.useHandCursor = true;
         this._sprite1.addChild(this._chest1);
         this._chest1.addEventListener(TouchEvent.TOUCH,this.onTouchChest1);
         this._name1Txt = new TextField(200,80,"Uncommon \n items",new TextFormat("PORT",20,6723840,Align.CENTER));
         this._name1Txt.x = -100;
         this._name1Txt.y = this._chest1.y - 70;
         this._name1Txt.touchable = false;
         this._sprite1.addChild(this._name1Txt);
         this._price1 = new Image(GV.assets.getTexture("Price1Key0000"));
         this._price1.x = -int(this._price1.width / 2);
         this._price1.y = this._chest1.y + 160;
         this._sprite1.addChild(this._price1);
         this._sprite2 = new Sprite();
         this._sprite2.x = (GV.scr_X - 100) / 2 + 120;
         addChild(this._sprite2);
         this._chest2 = new MovieClip(GV.assets.getTextures("Chest2_"));
         this._chest2.x = -int(this._chest2.width / 2) + 20;
         this._chest2.y = 180;
         this._chest2.useHandCursor = true;
         this._sprite2.addChild(this._chest2);
         this._name2Txt = new TextField(200,80,"Uncommon \n items",new TextFormat("PORT",20,16750848,Align.CENTER));
         this._name2Txt.x = -100;
         this._name2Txt.y = this._chest1.y - 70;
         this._name2Txt.touchable = false;
         this._sprite2.addChild(this._name2Txt);
         this._price2 = new Image(GV.assets.getTexture("Price2Key0000"));
         this._price2.x = -int(this._price2.width / 2);
         this._price2.y = this._chest1.y + 160;
         this._sprite2.addChild(this._price2);
         this._chest2.addEventListener(TouchEvent.TOUCH,this.onTouchChest2);
      }
      
      public function CheckWeapon(param1:String, param2:int, param3:String, param4:int, param5:int) : *
      {
         var _loc7_:int = 0;
         var _loc6_:int = GV[param1][7];
         if(_loc6_ < GV.open_weapon[param2])
         {
            _loc7_ = 1;
            while(_loc7_ < 15)
            {
               if(GV[param3].length > _loc6_ + _loc7_ && GV[param1][0] != 0)
               {
                  if(GV[param3][_loc6_ + _loc7_][1] <= GV.open_weapon[param2] && GV[param3][_loc6_ + _loc7_][6] == param5)
                  {
                     if(param5 == 1)
                     {
                        this.gereenArr.push(param4 + (_loc6_ + _loc7_));
                     }
                     if(param5 == 2)
                     {
                        this.yellowArr.push(param4 + (_loc6_ + _loc7_));
                        break;
                     }
                     break;
                  }
                  _loc7_++;
                  continue;
               }
               break;
            }
         }
      }
      
      public function ChecHat(param1:String, param2:int, param3:String, param4:int, param5:int, param6:int) : *
      {
         var _loc8_:int = 0;
         var _loc7_:int = GV[param1][8];
         if(_loc7_ < GV.open_weapon[param2])
         {
            _loc8_ = 1;
            while(_loc8_ <= 10)
            {
               if(_loc7_ + _loc8_ <= param5 && GV[param1][0] != 0)
               {
                  if(GV[param3][_loc7_ + _loc8_][1] <= GV.open_weapon[param2] && GV[param3][_loc7_ + _loc8_][6] == param6)
                  {
                     if(param6 == 1)
                     {
                        this.gereenArr.push(400 + (_loc7_ + _loc8_));
                     }
                     if(param6 == 2)
                     {
                        this.yellowArr.push(400 + (_loc7_ + _loc8_));
                        break;
                     }
                     break;
                  }
                  _loc8_++;
                  continue;
               }
               break;
            }
         }
      }
      
      public function Update_Items() : *
      {
         this.gereenArr = [];
         this.yellowArr = [];
         this.CheckWeapon("her0",0,"swords",100,1);
         this.CheckWeapon("her1",1,"bows",200,1);
         this.CheckWeapon("her2",2,"sticks",300,1);
         this.ChecHat("her0",3,"heads0",1,9,1);
         this.ChecHat("her1",4,"heads0",10,18,1);
         this.ChecHat("her2",5,"heads0",19,27,1);
         this.CheckWeapon("her0",0,"swords",100,2);
         this.CheckWeapon("her1",1,"bows",200,2);
         this.CheckWeapon("her2",2,"sticks",300,2);
         this.ChecHat("her0",3,"heads0",1,9,2);
         this.ChecHat("her1",4,"heads0",10,18,2);
         this.ChecHat("her2",5,"heads0",19,27,2);
      }
      
      public function init_open(param1:int) : void
      {
         this.seect_num = param1;
         this._hit = 0;
         this.state = "open";
         this["_chest" + this.seect_num].currentFrame = 1;
         Tweener.addTween(this._sprite1,{
            "x":(GV.scr_X - 100) / 2 - 200,
            "time":0.2,
            "transition":"easeOutCirc"
         });
         Tweener.addTween(this._sprite2,{
            "x":(GV.scr_X - 100) / 2 + 230,
            "time":0.2,
            "transition":"easeOutCirc"
         });
      }
      
      private function onTouchChest1(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this._chest1);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               if(this.state == "stop" && GV.keys >= 3 && this.gereenArr.length > 0)
               {
                  GV.keys = GV.keys - 3;
                  GV.game.SM.screen["_cristalTxt"].text = "" + GV.keys;
                  this.init_open(1);
                  this._num = this.gereenArr[Amath.random(0,this.gereenArr.length - 1)];
                  this.type = Math.floor(this._num / 100);
                  this.id = this._num - this.type * 100;
                  this._cell = new CellPremiumShop(this._num);
                  this._cell.x = this._chest1.x + this._sprite1.x;
                  this._cell.y = this._chest1.y;
                  addChild(this._cell);
                  Tweener.addTween(this._cell,{
                     "x":(GV.scr_X - 100) / 2 + 15,
                     "y":140,
                     "time":0.2,
                     "transition":"easeOutCirc"
                  });
                  this.save_item();
               }
            }
         }
      }
      
      private function onTouchChest2(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this._chest2);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               if(this.state == "stop" && GV.keys >= 7 && this.yellowArr.length > 0)
               {
                  GV.keys = GV.keys - 7;
                  GV.game.SM.screen["_cristalTxt"].text = "" + GV.keys;
                  this.init_open(2);
                  this._num = this.yellowArr[Amath.random(0,this.yellowArr.length - 1)];
                  this.type = Math.floor(this._num / 100);
                  this.id = this._num - this.type * 100;
                  this._cell = new CellPremiumShop(this._num);
                  this._cell.x = this._chest2.x + this._sprite2.x;
                  this._cell.y = this._chest2.y;
                  addChild(this._cell);
                  Tweener.addTween(this._cell,{
                     "x":(GV.scr_X - 100) / 2 + 15,
                     "y":140,
                     "time":0.2,
                     "transition":"easeOutCirc"
                  });
                  this.save_item();
               }
            }
         }
      }
      
      private function save_item() : *
      {
         GV.storageArr.push(this._num);
         GV.game.SM.screen["_inventory"]["CreateNewItem"](this._num);
         GV.game.SM.screen["_inventory"]["Grouping"]();
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
      
      public function refresh_shop() : *
      {
         this.Update_Items();
         switch(this.state)
         {
            case "stop":
               break;
            case "open":
               this._chest1.currentFrame = 0;
               this._chest2.currentFrame = 0;
               Tweener.addTween(this._sprite1,{
                  "x":(GV.scr_X - 100) / 2 - 120,
                  "time":0.2,
                  "transition":"easeOutCirc"
               });
               Tweener.addTween(this._sprite2,{
                  "x":(GV.scr_X - 100) / 2 + 120,
                  "time":0.2,
                  "transition":"easeOutCirc"
               });
               Tweener.addTween(this._cell,{
                  "y":-100,
                  "time":0.2,
                  "transition":"easeOutCirc",
                  "onComplete":this.StopMove
               });
               this.state = "move";
         }
      }
      
      public function StopMove() : *
      {
         this._cell.free();
         this.state = "stop";
      }
      
      public function Free() : *
      {
      }
      
      public function translate() : void
      {
      }
   }
}
