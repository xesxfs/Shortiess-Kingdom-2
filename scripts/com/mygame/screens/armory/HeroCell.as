package com.mygame.screens.armory
{
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class HeroCell extends Sprite
   {
       
      
      public var _index:int;
      
      public var _heroId:int;
      
      public var id:int;
      
      public var type:int;
      
      public var nm:String;
      
      private var img:Image;
      
      private var icon:Image;
      
      private var oldX:int;
      
      private var oldY:int;
      
      private var dX:int;
      
      private var dY:int;
      
      private var _isSelect:Boolean = false;
      
      private var _isMoved:Boolean = false;
      
      public function HeroCell()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:int, param4:int) : *
      {
         x = param1;
         y = param2;
         this._index = param3;
         this._heroId = param4;
         if(param3 == 0)
         {
            this.img = new Image(GV.assets.getTexture("HeadCell0000"));
         }
         else
         {
            switch(param4)
            {
               case 0:
                  this.img = new Image(GV.assets.getTexture("SwordCell0000"));
                  break;
               case 1:
                  this.img = new Image(GV.assets.getTexture("BowCell0000"));
                  break;
               case 2:
                  this.img = new Image(GV.assets.getTexture("StickCell0000"));
            }
         }
         addChild(this.img);
         this.img.x = -29;
         this.img.y = -29;
      }
      
      public function Free() : void
      {
      }
   }
}
