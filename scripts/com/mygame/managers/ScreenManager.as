package com.mygame.managers
{
   import caurina.transitions.Tweener;
   import com.mygame.screens.ScrBase;
   import com.mygame.screens.ScreenChest;
   import com.mygame.screens.ScreenEnd;
   import com.mygame.screens.ScreenLevels;
   import com.mygame.screens.ScreenMap;
   import com.mygame.screens.ScreenPause;
   import com.mygame.screens.ScreenPlayerInfo;
   import com.mygame.screens.ScreenSettings;
   import com.mygame.screens.ScreenVictory;
   import com.mygame.screens.ScreenWeel;
   import com.mygame.screens.armory.ScreenArmory;
   import starling.display.Quad;
   import starling.events.EnterFrameEvent;
   
   public class ScreenManager
   {
       
      
      private var _blackScreen:Quad;
      
      public var screen:ScrBase;
      
      public var screen2:ScrBase;
      
      private var _isBlack:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      public var newScreenName:String;
      
      public function ScreenManager()
      {
         super();
      }
      
      public function transition_screen(param1:String, param2:Boolean) : void
      {
         Tweener.removeAllTweens();
         GV.game.addEventListener(EnterFrameEvent.ENTER_FRAME,this.init_blackscreen);
         this.newScreenName = param1;
      }
      
      private function init_blackscreen() : void
      {
         GV.game.removeEventListener(EnterFrameEvent.ENTER_FRAME,this.init_blackscreen);
         this._blackScreen = new Quad(GV.scr_X + 10,GV.scr_Y + 10,0);
         this._blackScreen.x = -5;
         this._blackScreen.y = -5;
         GV.game.addChild(this._blackScreen);
         this._blackScreen.alpha = 0;
         Tweener.addTween(this._blackScreen,{
            "alpha":1,
            "time":0.5,
            "transition":"linear",
            "onComplete":this.under_blackscreen
         });
      }
      
      private function under_blackscreen() : void
      {
         this.new_screen(this.newScreenName);
      }
      
      public function new_screen(param1:String) : void
      {
         this.newScreenName = param1;
         if(this.screen2)
         {
            this.free_screen();
         }
         if(this.screen)
         {
            this.screen.free();
            this.screen = null;
         }
         switch(param1)
         {
            case "Game":
               GV.game.init_level();
               GV.sound.playMusic("game");
               break;
            case "Inventory":
               this.screen = new ScreenArmory();
               this.screen.activation();
               break;
            case "Map":
               GV.game.free_level();
               this.screen = new ScreenMap();
               this.screen.activation();
               GV.sound.playMusic("menu");
               break;
            case "Weel":
               this.screen = new ScreenWeel();
               this.screen.activation();
               break;
            case "Chest":
               this.screen = new ScreenChest();
               this.screen.activation();
               break;
            case "End":
               GV.game.free_level();
               this.screen = new ScreenEnd();
               this.screen.activation();
               GV.sound.playMusic("menu");
         }
         if(this._blackScreen)
         {
            GV.game.setChildIndex(this._blackScreen,GV.game.numChildren - 1);
            Tweener.addTween(this._blackScreen,{
               "alpha":0,
               "time":0.4,
               "delay":0.2,
               "transition":"linear",
               "onComplete":this.remove_blackScreen
            });
         }
      }
      
      private function remove_blackScreen() : void
      {
         this._blackScreen.removeFromParent(true);
         this._blackScreen = null;
         this._isBlack = false;
      }
      
      public function open_screen(param1:String) : void
      {
         this.free_screen();
         switch(param1)
         {
            case "Levels":
               this.screen2 = new ScreenLevels();
               this.screen2.activation();
               break;
            case "Pause":
               GV.sound.playMusic("menu");
               this.screen2 = new ScreenPause();
               this.screen2.activation();
               break;
            case "Fail":
               this.screen2 = new ScreenVictory();
               this.screen2["init"](false);
               this.screen2.activation();
               break;
            case "Victory":
               this.screen2 = new ScreenVictory();
               this.screen2["init"](true);
               this.screen2.activation();
               break;
            case "Settings":
               this.screen2 = new ScreenSettings();
               this.screen2.activation();
               break;
            case "PayerInfo":
               this.screen2 = new ScreenPlayerInfo();
               this.screen2.activation();
         }
      }
      
      public function free_screen() : void
      {
         if(this.screen2)
         {
            this.screen2.free();
            this.screen2 = null;
         }
      }
      
      public function translate() : void
      {
         if(this.screen)
         {
            this.screen.translate();
         }
         if(this.screen2)
         {
            this.screen2.translate();
         }
      }
   }
}
