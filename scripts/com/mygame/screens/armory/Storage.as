package com.mygame.screens.armory
{
   import caurina.transitions.Tweener;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class Storage extends Sprite
   {
       
      
      var step:int = 66;
      
      var posX:int = 47.0;
      
      var posY:int = 81.0;
      
      private var _btnRigt:Button;
      
      public var _btnLeft:Button;
      
      private var state:int = 1;
      
      private var _texture:Texture;
      
      private var lengthStorage:int;
      
      public var _sprite:Sprite;
      
      private var indexMoveX:int = 0;
      
      private var _mask:Quad;
      
      private var intervalX:int;
      
      private var numInStorage:int;
      
      public function Storage()
      {
         super();
      }
      
      public function Init(param1:*) : *
      {
         var _loc4_:Image = null;
         x = 0;
         y = 0;
         this._btnRigt = new Button(GV.assets.getTexture("BtnArrow0000"));
         this._btnRigt.x = param1 + 270;
         this._btnRigt.y = GV.scr_Y - 75;
         addChild(this._btnRigt);
         this._btnRigt.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnLeft = new Button(GV.assets.getTexture("BtnArrow0000"));
         this._btnLeft.x = param1 - 270;
         this._btnLeft.y = this._btnRigt.y;
         this._btnLeft.scaleX = -1;
         addChild(this._btnLeft);
         this._btnLeft.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._texture = GV.assets.getTexture("StorageCell0000");
         var _loc2_:int = this._btnRigt.x - this._btnLeft.x - 40;
         this.numInStorage = _loc2_ / 70;
         this.intervalX = _loc2_ / this.numInStorage;
         if(GV.storageArr.length < this.numInStorage)
         {
            this.lengthStorage = this.numInStorage;
         }
         else
         {
            this.lengthStorage = GV.storageArr.length;
         }
         this._sprite = new Sprite();
         addChild(this._sprite);
         this._mask = new Quad(_loc2_,120,16711680);
         this._mask.x = this._btnLeft.x + 25;
         this._mask.y = this._btnLeft.y - 30;
         this._sprite.mask = this._mask;
         addChild(this._mask);
         var _loc3_:int = 0;
         while(_loc3_ <= this.lengthStorage)
         {
            _loc4_ = new Image(this._texture);
            _loc4_.pivotY = 30;
            _loc4_.pivotX = 30;
            _loc4_.x = this._btnLeft.x + 60 + this.intervalX * _loc3_;
            _loc4_.y = GV.scr_Y - 50;
            this._sprite.addChildAt(_loc4_,0);
            if(_loc3_ < GV.storageArr.length)
            {
               this.CreateNewItem(GV.storageArr[_loc3_]);
            }
            _loc3_++;
         }
         this.Grouping();
      }
      
      public function CreateNewItem(param1:int) : *
      {
         var _loc2_:Cell = new Cell(param1,0,0,-1);
         this._sprite.addChild(_loc2_);
      }
      
      public function Grouping() : *
      {
         GV.game.SM.screen["CellsArr"].sortOn(["_num"],Array.NUMERIC);
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < GV.game.SM.screen["CellsArr"].length)
         {
            if(GV.game.SM.screen["CellsArr"][_loc2_]["_heroType"] == -1)
            {
               GV.game.SM.screen["CellsArr"][_loc2_].x = this._btnLeft.x + 60 + this.intervalX * _loc1_;
               GV.game.SM.screen["CellsArr"][_loc2_].y = GV.scr_Y - 50;
               _loc1_++;
            }
            _loc2_++;
         }
      }
      
      private function MoveRight() : void
      {
         if(this.indexMoveX < GV.storageArr.length - this.numInStorage + 1)
         {
            this.indexMoveX++;
            Tweener.removeTweens(this._sprite);
            Tweener.addTween(this._sprite,{
               "x":-this.indexMoveX * this.intervalX,
               "time":0.1,
               "transition":"linear"
            });
         }
         else
         {
            Tweener.removeTweens(this._sprite);
            Tweener.addTween(this._sprite,{
               "x":-this.indexMoveX * this.intervalX - 10,
               "time":0.1,
               "transition":"linear"
            });
            Tweener.addTween(this._sprite,{
               "x":-this.indexMoveX * this.intervalX,
               "delay":0.1,
               "time":0.2,
               "transition":"linear"
            });
         }
      }
      
      private function MoveLeft() : void
      {
         if(this.indexMoveX > 0)
         {
            this.indexMoveX--;
            Tweener.removeTweens(this._sprite);
            Tweener.addTween(this._sprite,{
               "x":-this.indexMoveX * this.intervalX,
               "time":0.1,
               "transition":"linear"
            });
         }
         else
         {
            Tweener.removeTweens(this._sprite);
            Tweener.addTween(this._sprite,{
               "x":-this.indexMoveX * this.intervalX + 10,
               "time":0.1,
               "transition":"linear"
            });
            Tweener.addTween(this._sprite,{
               "x":-this.indexMoveX * this.intervalX,
               "delay":0.1,
               "time":0.2,
               "transition":"linear"
            });
         }
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnLeft)
         {
            GV.sound.playSFX("click");
            this.MoveLeft();
         }
         if(_loc2_ as Button == this._btnRigt)
         {
            GV.sound.playSFX("click");
            this.MoveRight();
         }
      }
      
      public function free() : void
      {
         this._btnLeft.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnRigt.removeEventListener(Event.TRIGGERED,this.touch_btns);
      }
   }
}
