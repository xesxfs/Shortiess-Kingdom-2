package com
{
   import com.general.Amath;
   import com.general.ObjectController;
   import com.general.SimpleCache;
   import com.mygame.effects.Blood;
   import com.mygame.effects.CritNums;
   import com.mygame.effects.Damage_info;
   import com.mygame.managers.BackManager;
   import com.mygame.managers.LevelManager;
   import com.mygame.managers.ScreenManager;
   import dragonBones.animation.WorldClock;
   import flash.utils.getTimer;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class Game extends Sprite
   {
       
      
      public var _stage:Sprite;
      
      public var lay_0:Sprite;
      
      public var lay_1:Sprite;
      
      public var lay_2:Sprite;
      
      public var SM:ScreenManager;
      
      public var BM:BackManager;
      
      public var cacheBlood:SimpleCache;
      
      public var cacheDamage:SimpleCache;
      
      public var cacheCrit:SimpleCache;
      
      public var effects:ObjectController;
      
      public var objs:ObjectController;
      
      private var _angle:Number = 0;
      
      private var amplitude:Number = 10;
      
      private var _isShake:Boolean = false;
      
      private var _t:int;
      
      public function Game()
      {
         this._stage = new Sprite();
         this.lay_0 = new Sprite();
         this.lay_1 = new Sprite();
         this.lay_2 = new Sprite();
         this._t = getTimer();
         super();
         GV.game = this;
      }
      
      public function init() : void
      {
         GV.groundY = int(GV.scr_Y - GV.scr_Y * 0.35);
         this.effects = new ObjectController();
         this.objs = new ObjectController();
         this.BM = new BackManager();
         addChildAt(this.BM,0);
         addChild(this._stage);
         this._stage.addChild(this.lay_0);
         this._stage.addChild(this.lay_1);
         this._stage.addChild(this.lay_2);
         this.lay_1.touchable = false;
         this.lay_2.touchable = false;
         GV.LM = new LevelManager();
         this.cacheBlood = new SimpleCache(Blood,8);
         this.cacheDamage = new SimpleCache(Damage_info,8);
         this.cacheCrit = new SimpleCache(CritNums,1);
         addEventListener(TouchEvent.TOUCH,this.onTouch);
         this.SM = new ScreenManager();
         if(GV.episode != 10)
         {
            this.SM.transition_screen("Map",true);
         }
         else
         {
            this.SM.transition_screen("End",true);
         }
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      public function init_level() : void
      {
         GV.real_time = 0;
         GV.start_time = getTimer();
         GV.delta = 0;
         GV.sound.free_time();
         GV.freeExp = 0;
         GV.hExp0 = 0;
         GV.hExp1 = 0;
         GV.hExp2 = 0;
         GV.factorCoins = 0;
         GV.factorExp = [0,0,0];
         GV.freeCoins = 0;
         GV.camPos = 0;
         this._stage.x = 0;
         this._stage.y = 0;
         this._isShake = false;
         GV.LM.init_level();
         this._stage.visible = true;
         GV.isPlay = true;
      }
      
      public function free_level(param1:Event = null) : void
      {
         this.effects.clear();
         this.objs.clear();
         GV.isPlay = false;
         var _loc2_:int = GV.heroesArr.length - 1;
         while(_loc2_ >= 0)
         {
            GV.heroesArr[_loc2_].free();
            _loc2_--;
         }
         _loc2_ = GV.enemiesArr.length - 1;
         while(_loc2_ >= 0)
         {
            GV.enemiesArr[_loc2_].free();
            _loc2_--;
         }
         GV.LM.free_level();
         this.BM.free();
         this._stage.visible = false;
      }
      
      public function update(param1:EnterFrameEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = getTimer();
         var _loc3_:Number = (_loc2_ - this._t) * 0.01;
         if(GV.isPlay)
         {
            GV.juggler.advanceTime(param1.passedTime);
            WorldClock.clock.advanceTime(-1);
            this.effects.update(_loc3_);
            this.objs.update(_loc3_);
            GV.LM.update();
            if(GV.heroesArr.length > 0)
            {
               GV.camPos = -1000000;
            }
            _loc4_ = GV.heroesArr.length - 1;
            while(_loc4_ >= 0)
            {
               GV.heroesArr[_loc4_].update(_loc3_);
               _loc4_--;
            }
            GV.freeExp = 0;
            GV.enPosX = 1000000;
            _loc4_ = GV.enemiesArr.length - 1;
            while(_loc4_ >= 0)
            {
               GV.enemiesArr[_loc4_].update(_loc3_);
               _loc4_--;
            }
            this._stage.x = Amath.Lerp(this._stage.x,-GV.camPos + GV.cent_X,0.05);
            this.BM.update();
            if(this._isShake)
            {
               this.shake_move(_loc3_);
            }
            GV.real_time = _loc2_ - (GV.start_time + GV.delta);
         }
         else
         {
            GV.delta = _loc2_ - (GV.start_time + GV.real_time);
         }
         this._t = _loc2_;
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            GV.touchX = _loc2_.globalX;
            GV.touchY = _loc2_.globalY;
         }
      }
      
      public function shake_move(param1:Number) : void
      {
         this._stage.y = Math.sin(this._angle) * this.amplitude;
         this._angle = this._angle + 5 * param1;
         this.amplitude = this.amplitude - 0.6 * param1;
         if(this.amplitude <= 0)
         {
            this._stage.y = 0;
            this._isShake = false;
         }
      }
      
      public function shake() : void
      {
         this._stage.y = 0;
         this._angle = 0;
         this.amplitude = 7;
         this._isShake = true;
      }
   }
}
