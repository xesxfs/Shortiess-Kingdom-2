package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class HandTutorial extends Sprite
   {
       
      
      public var state:String;
      
      public var isMove:Boolean = false;
      
      public var img:Image;
      
      private var posX1:int;
      
      private var posX2:int;
      
      private var posY1:int;
      
      private var posY2:int;
      
      public function HandTutorial()
      {
         super();
         this.img = new Image(GV.assets.getTexture("Hand0000"));
         addChild(this.img);
         this.touchable = false;
      }
      
      public function free() : void
      {
         Tweener.removeTweens(this);
         this.img.removeFromParent(true);
         this.removeFromParent(true);
      }
      
      public function touch() : void
      {
         if(this.state == "up")
         {
            Tweener.addTween(this,{
               "x":this.posX1,
               "y":this.posY1,
               "time":0.2,
               "delay":0,
               "transition":"linear",
               "onComplete":this.touch
            });
            this.state = "down";
         }
         else
         {
            Tweener.addTween(this,{
               "x":this.posX1 - 11,
               "y":this.posY1 - 10,
               "time":0.2,
               "delay":0,
               "transition":"linear",
               "onComplete":this.touch
            });
            this.state = "up";
         }
      }
      
      public function move() : void
      {
         if(this.state == "up")
         {
            Tweener.addTween(this,{
               "x":this.posX2,
               "y":this.posY2,
               "time":1,
               "delay":0,
               "transition":"linear",
               "onComplete":this.move
            });
            this.state = "down";
         }
         else
         {
            Tweener.addTween(this,{
               "x":this.posX1,
               "y":this.posY1,
               "time":0.4,
               "delay":0,
               "transition":"linear",
               "onComplete":this.move
            });
            this.state = "up";
         }
      }
      
      public function init_touch(param1:int, param2:int) : void
      {
         Tweener.removeTweens(this);
         this.posX1 = param1;
         this.posY1 = param2;
         this.state = "up";
         this.touch();
      }
      
      public function init_move(param1:int, param2:int, param3:int, param4:int) : void
      {
         Tweener.removeTweens(this);
         this.posX1 = param1;
         this.posY1 = param2;
         this.posX2 = param3;
         this.posY2 = param4;
         this.state = "up";
         this.move();
      }
   }
}
