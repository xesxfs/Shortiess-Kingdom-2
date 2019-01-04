package com.mygame.screens.armory
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   public class Cell extends Sprite
   {
       
      
      public var id:int;
      
      public var type:int;
      
      public var _num:int;
      
      public var _heroType:int;
      
      public var img:Image;
      
      public var nm:String;
      
      public var onHero:Boolean;
      
      public var onInventary:Boolean;
      
      public var _isSelect:Boolean = false;
      
      private var _isMoved:Boolean = false;
      
      public var oldX:int;
      
      public var oldY:int;
      
      private var dX:int = -29;
      
      private var dY:int = -29;
      
      private var _selectHero:int = -1;
      
      public function Cell(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this._num = param1;
         this.type = Math.floor(param1 / 100);
         this.id = param1 - this.type * 100;
         this._heroType = param4;
         if(this.id < 10)
         {
            this.nm = "0" + this.id;
         }
         else
         {
            this.nm = "" + this.id;
         }
         x = this.oldX = param2;
         y = this.oldY = param3;
         switch(this.type)
         {
            case 1:
               this.img = new Image(GV.assets.getTexture("Swords00" + this.nm));
               break;
            case 2:
               this.img = new Image(GV.assets.getTexture("Bows00" + this.nm));
               break;
            case 3:
               this.img = new Image(GV.assets.getTexture("Sticks00" + this.nm));
               break;
            case 4:
               this.img = new Image(GV.assets.getTexture("Hats00" + this.nm));
         }
         this.img.x = this.img.y = -29;
         addChild(this.img);
         this.useHandCursor = true;
         addEventListener(TouchEvent.TOUCH,this.onTouch);
         GV.game.SM.screen["CellsArr"].push(this);
      }
      
      private function move(param1:EnterFrameEvent) : void
      {
         var _loc2_:int = 0;
         x = GV.touchX + this.dX;
         y = GV.touchY + this.dY;
         if(!this._isMoved)
         {
            if(Amath.distance(x,y,this.oldX,this.oldY) > 20)
            {
               this._isMoved = true;
               this.dX = this.dX + parent.x;
               this.dY = this.dY + parent.y;
               removeFromParent();
               GV.game.SM.screen.addChild(this);
               x = GV.touchX + this.dX;
               y = GV.touchY + this.dY;
               this.oldX = x;
               this.oldY = y;
               if(this._heroType >= 0)
               {
                  if(this.type == 4)
                  {
                     GV["her" + this._heroType][1] = 0;
                  }
                  else
                  {
                     GV["her" + this._heroType][2] = 0;
                  }
                  GV.game.SM.screen["_fieldHero" + this._heroType]["ChangeSkin"]();
               }
               else
               {
                  _loc2_ = 0;
                  while(_loc2_ < GV.storageArr.length)
                  {
                     if(GV.storageArr[_loc2_] == this._num)
                     {
                        GV.storageArr.splice(_loc2_,1);
                        break;
                     }
                     _loc2_++;
                  }
               }
            }
         }
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            GV.touchX = _loc2_.globalX;
            GV.touchY = _loc2_.globalY;
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               if(!GV.isTouch)
               {
                  parent.setChildIndex(this,parent.numChildren - 1);
                  this.oldX = x;
                  this.oldY = y;
                  this.dX = x - GV.touchX;
                  this.dY = y - GV.touchY;
                  this._isMoved = false;
                  this._isSelect = true;
                  GV.isTouch = true;
                  addEventListener(EnterFrameEvent.ENTER_FRAME,this.move);
               }
            }
            else if(_loc2_.phase == TouchPhase.ENDED)
            {
               if(this._isSelect)
               {
                  this._isSelect = false;
                  removeEventListener(EnterFrameEvent.ENTER_FRAME,this.move);
                  if(!this._isMoved)
                  {
                     x = this.oldX;
                     y = this.oldY;
                     GV.isTouch = false;
                     GV.game.SM.screen["OpenInfo"](this._num,false);
                  }
                  else
                  {
                     if(GV.game.SM.screen["_isShop"] && GV.touchY < GV.scr_Y - 150 && GV.game.SM.screen["_premShop"].visible == false)
                     {
                        GV.game.SM.screen["OpenSell"](this._num);
                        this.free();
                        GV.isTouch = false;
                        return;
                     }
                     this._selectHero = -1;
                     _loc3_ = 0;
                     while(_loc3_ <= 2)
                     {
                        if(GV["her" + _loc3_][0] > 0 && GV.touchX > GV.game.SM.screen["_fieldHero" + _loc3_].x - 80 && GV.touchX < GV.game.SM.screen["_fieldHero" + _loc3_].x + 110 && GV.touchY > GV.game.SM.screen["_fieldHero" + _loc3_].y && GV.touchY < GV.game.SM.screen["_fieldHero" + _loc3_].y + 250)
                        {
                           this._selectHero = _loc3_;
                        }
                        _loc3_++;
                     }
                     if(this._selectHero >= 0 && GV.game.SM.screen["_premShop"].visible == false)
                     {
                        if(this.type == 4)
                        {
                           this.oldX = GV.game.SM.screen["_fieldHero" + this._selectHero]["_cell_1"].x + GV.game.SM.screen["_fieldHero" + this._selectHero].x;
                           this.oldY = GV.game.SM.screen["_fieldHero" + this._selectHero]["_cell_1"].y + GV.game.SM.screen["_fieldHero" + this._selectHero].y;
                        }
                        else if(this.type - 1 == this._selectHero)
                        {
                           this.oldX = GV.game.SM.screen["_fieldHero" + this._selectHero]["_cell_2"].x + GV.game.SM.screen["_fieldHero" + this._selectHero].x;
                           this.oldY = GV.game.SM.screen["_fieldHero" + this._selectHero]["_cell_2"].y + GV.game.SM.screen["_fieldHero" + this._selectHero].y;
                        }
                        else
                        {
                           if(this._heroType == -1)
                           {
                              Tweener.addTween(this,{
                                 "x":this.oldX,
                                 "y":this.oldY,
                                 "time":Amath.distance(x,y,this.oldX,this.oldY) / 3000,
                                 "transition":"linear",
                                 "onComplete":this.toInventory
                              });
                              return;
                           }
                           this._selectHero = this._heroType;
                        }
                        Tweener.addTween(this,{
                           "x":this.oldX,
                           "y":this.oldY,
                           "time":Amath.distance(x,y,this.oldX,this.oldY) / 3000,
                           "transition":"linear",
                           "onComplete":this.toHero
                        });
                     }
                     else
                     {
                        this.toInventory();
                     }
                  }
               }
            }
         }
      }
      
      private function toHero() : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         GV.sound.playSFX("put");
         removeFromParent();
         if(this.type == 4)
         {
            _loc2_ = 1;
            if(GV["her" + this._selectHero][1] != 0)
            {
               _loc3_ = 0;
               while(_loc3_ < GV.game.SM.screen["CellsArr"].length)
               {
                  if(GV.game.SM.screen["CellsArr"][_loc3_] != this && GV.game.SM.screen["CellsArr"][_loc3_]["_heroType"] == this._selectHero && GV.game.SM.screen["CellsArr"][_loc3_]["type"] == 4)
                  {
                     GV.game.SM.screen["CellsArr"][_loc3_].removeFromParent();
                     GV.game.SM.screen["_inventory"]["_sprite"].addChild(GV.game.SM.screen["CellsArr"][_loc3_]);
                     GV.game.SM.screen["CellsArr"][_loc3_]["_heroType"] = -1;
                     GV.storageArr.push(GV.game.SM.screen["CellsArr"][_loc3_]["_num"]);
                     GV.game.SM.screen["_inventory"]["Grouping"]();
                     break;
                  }
                  _loc3_++;
               }
            }
            GV["her" + this._selectHero][1] = this._num;
         }
         else
         {
            _loc2_ = 2;
            if(GV["her" + this._selectHero][2] != 0)
            {
               _loc3_ = 0;
               while(_loc3_ < GV.game.SM.screen["CellsArr"].length)
               {
                  if(GV.game.SM.screen["CellsArr"][_loc3_] != this && GV.game.SM.screen["CellsArr"][_loc3_]["_heroType"] == this._selectHero && GV.game.SM.screen["CellsArr"][_loc3_]["type"] - 1 == this._selectHero)
                  {
                     GV.game.SM.screen["CellsArr"][_loc3_].removeFromParent();
                     GV.game.SM.screen["_inventory"]["_sprite"].addChild(GV.game.SM.screen["CellsArr"][_loc3_]);
                     GV.game.SM.screen["CellsArr"][_loc3_]["_heroType"] = -1;
                     GV.storageArr.push(GV.game.SM.screen["CellsArr"][_loc3_]["_num"]);
                     GV.game.SM.screen["_inventory"]["Grouping"]();
                     break;
                  }
                  _loc3_++;
               }
            }
            GV["her" + this._selectHero][2] = this._num;
         }
         var _loc1_:String = "_fieldHero" + this._selectHero;
         GV.game.SM.screen[_loc1_].addChild(this);
         x = GV.game.SM.screen[_loc1_]["_cell_" + _loc2_].x;
         y = GV.game.SM.screen[_loc1_]["_cell_" + _loc2_].y;
         GV.game.SM.screen[_loc1_].ChangeSkin();
         this._heroType = this._selectHero;
         this._selectHero = -1;
         GV.game.SM.screen["_inventory"]["Grouping"]();
         GV.isTouch = false;
      }
      
      private function toInventory() : *
      {
         removeFromParent();
         x = this.x - GV.game.SM.screen["_inventory"].x;
         y = this.y - GV.game.SM.screen["_inventory"].y;
         GV.game.SM.screen["_inventory"]["_sprite"].addChild(this);
         GV.storageArr.push(this._num);
         this._heroType = -1;
         GV.game.SM.screen["_inventory"]["Grouping"]();
         GV.isTouch = false;
      }
      
      public function free() : *
      {
         removeEventListener(TouchEvent.TOUCH,this.onTouch);
         var _loc1_:int = 0;
         while(_loc1_ < GV.game.SM.screen["CellsArr"].length)
         {
            if(GV.game.SM.screen["CellsArr"][_loc1_] == this)
            {
               GV.game.SM.screen["CellsArr"][_loc1_] = null;
               GV.game.SM.screen["CellsArr"].splice(_loc1_,1);
               break;
            }
            _loc1_++;
         }
         this.removeFromParent(true);
      }
   }
}
