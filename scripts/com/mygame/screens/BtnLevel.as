package com.mygame.screens
{
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class BtnLevel extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      public var _id:int;
      
      public var _level:int;
      
      public var _txt:TextField;
      
      public function BtnLevel()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:int) : void
      {
         x = param1;
         y = param2;
         this._id = param3;
         this._mc = new MovieClip(GV.assets.getTextures("Btn_level"));
         this._mc.pivotY = 0;
         this._mc.pivotX = 0;
         this._mc.x = -int(this._mc.width / 2);
         this._mc.y = -int(this._mc.height / 2);
         addChild(this._mc);
         var _loc4_:String = GV.episode + 1 + "-" + (this._id + 1);
         if(GV.episode < 5)
         {
            this._level = GV.episode * 3 + this._id;
         }
         else
         {
            this._level = 15 + (GV.episode - 5) * 5 + this._id;
            if(this._id == 4)
            {
               _loc4_ = "BOSS";
            }
         }
         this._txt = new TextField(100,50,_loc4_,new TextFormat("PORT",17,16777215,Align.CENTER));
         this._txt.x = -50;
         this._txt.y = -80;
         addChild(this._txt);
         if(GV.stars[this._level] == 0)
         {
            this._mc.currentFrame = GV.location;
         }
         else
         {
            this._mc.currentFrame = 5;
         }
         this.useHandCursor = true;
         addEventListener(TouchEvent.TOUCH,this.onTouch);
      }
      
      public function free() : void
      {
         removeEventListener(TouchEvent.TOUCH,this.onTouch);
         this._mc.removeFromParent(true);
         this._mc = null;
         this.removeFromParent(true);
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               if(GV.episode == 0 && GV.stars[0] == 0)
               {
                  GV.level = 0;
               }
               else
               {
                  GV.level = this._level;
               }
               GV.sound.playSFX("fanfar");
               GV.game.SM.transition_screen("Game",false);
            }
         }
      }
      
      public function update() : void
      {
      }
   }
}
