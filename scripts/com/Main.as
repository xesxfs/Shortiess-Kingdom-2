package com
{
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.utils.setTimeout;
   import starling.animation.Juggler;
   import starling.core.Starling;
   import starling.utils.AssetManager;
   
   public class Main extends Sprite
   {
       
      
      public var Background:MovieClip;
      
      public var Title:MovieClip;
      
      private var _blackScreen:Sprite;
      
      private var screenWidth;
      
      private var screenHeight;
      
      public function Main()
      {
         super();
         if(stage)
         {
            this.start();
         }
         else
         {
            addEventListener(flash.events.Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      private function onAddedToStage(param1:flash.events.Event) : void
      {
         removeEventListener(flash.events.Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.start();
      }
      
      private function start() : void
      {
         trace("4v45");
         this.stage.showDefaultContextMenu = false;
         this.stage.scaleMode = StageScaleMode.SHOW_ALL;
         this.stage.align = StageAlign.TOP;
         GV.main = this;
         this.screenWidth = GV._width;
         this.screenHeight = GV._height;
         GV.isWEB = true;
         var _loc1_:Number = this.screenWidth / this.screenHeight;
         var _loc2_:Number = GV._width / GV._height;
         if(_loc1_ > _loc2_)
         {
            GV.dX = GV._height / this.screenHeight * this.screenWidth - GV._width;
         }
         if(_loc1_ < _loc2_)
         {
            GV.dY = GV._width / this.screenWidth * this.screenHeight - GV._height;
         }
         GV.scr_X = GV._width + GV.dX;
         GV.scr_Y = GV._height + GV.dY;
         GV.cent_X = GV.scr_X / 2;
         GV.cent_Y = GV.scr_Y / 2;
         GV.main["Background"].x = GV.main["Title"].x = this.screenWidth / 2;
         GV.main["Background"].y = GV.main["Title"].y = this.screenHeight / 2;
         GV.main["Background"].width = this.screenWidth + 10;
         GV.main["Background"].height = this.screenHeight + 10;
         this._blackScreen = new BlackScreen();
         this._blackScreen.x = 0;
         this._blackScreen.y = 0;
         this._blackScreen.width = this.screenWidth;
         this._blackScreen.height = this.screenHeight;
         this._blackScreen.mouseEnabled = false;
         this._blackScreen.mouseChildren = false;
         setTimeout(this.initStarling,500);
      }
      
      private function initStarling() : void
      {
         Starling.multitouchEnabled = false;
         var viewPort:Rectangle = new Rectangle(0,0,this.screenWidth,this.screenHeight);
         GV.starling = new Starling(Game,stage,viewPort);
         GV.starling.stage.stageWidth = GV.scr_X;
         GV.starling.stage.stageHeight = GV.scr_Y;
         GV.starling.antiAliasing = 1;
         GV.juggler = new Juggler();
         GV.starling.addEventListener(starling.events.Event.ROOT_CREATED,function onRootCreated():void
         {
            loadAssets(lastLoad);
         });
      }
      
      private function removeBlack() : void
      {
         if(this.contains(this._blackScreen))
         {
            this.removeChild(this._blackScreen);
         }
      }
      
      private function loadAssets(param1:Function) : void
      {
         var onComplete:Function = param1;
         GV.assets = new AssetManager();
         GV.assets.verbose = false;
         GV.assets.enqueue(EmbeddedAssets);
         GV.assets.loadQueue(function(param1:Number):void
         {
            if(param1 == 1)
            {
               System.pauseForGCIfCollectionImminent(0);
               System.gc();
               onComplete(GV.assets);
               GV.starling.start();
               GV.save.init_saves();
               GV.sound.setVolumeSOUND(GV.settings[0] / 10);
               GV.sound.setVolumeMUS(GV.settings[1] / 10);
               setTimeout(MoveLaunchScreen,1000);
            }
         });
      }
      
      private function lastLoad(param1:AssetManager) : void
      {
      }
      
      private function MoveLaunchScreen() : void
      {
         Tweener.addTween(GV.main["Title"],{
            "alpha":0,
            "time":0.1,
            "transition":"linear"
         });
         Tweener.addTween(GV.main["Background"],{
            "alpha":0,
            "time":0.1,
            "transition":"linear",
            "onComplete":this.RemoveLaunchScreen
         });
      }
      
      private function RemoveLaunchScreen() : void
      {
         GV.game.init();
         removeChild(GV.main["Background"]);
         GV.main["Background"] = null;
         removeChild(GV.main["Title"]);
         GV.main["Title"] = null;
      }
   }
}
