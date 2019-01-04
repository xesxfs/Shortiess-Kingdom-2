package com.mygame.skills
{
   import caurina.transitions.Tweener;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class BtnSkillBase extends Sprite
   {
       
      
      public var _sprite:MovieClip;
      
      public var _timer:TextField;
      
      public var _isFree:Boolean = false;
      
      public var _isState:String = "ready";
      
      public var _type:int = 0;
      
      public var _heroType:int = 0;
      
      public var _time:int = 0;
      
      public var _sec:int = 0;
      
      public var _delay:int = 60;
      
      public var _sound:String;
      
      public function BtnSkillBase()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:String = "spell") : void
      {
         y = GV.scr_Y - (GV.scr_Y - GV.groundY) / 2;
         this._heroType = param1;
         this._type = param2;
         this._sound = param3;
         if(param1 == 0 && param2 == 3)
         {
            this._sound = "steel2";
         }
         if(param1 == 0 && param2 == 4)
         {
            this._sound = "shield";
         }
         this._sprite = new MovieClip(GV.assets.getTextures("Spell" + param1 + param2 + "_"));
         addChild(this._sprite);
         this._sprite.pivotY = int(this._sprite.height / 2);
         this._sprite.pivotX = int(this._sprite.width / 2);
         this._sprite.addEventListener(TouchEvent.TOUCH,this.select);
         this._timer = new TextField(50,40,"00",new TextFormat("NormalТNum",30,16777215,Align.RIGHT));
         this._timer.x = this._sprite.x - 28;
         this._timer.y = this._sprite.y - 10;
         addChild(this._timer);
         this._timer.visible = false;
         this._timer.touchable = false;
         this.useHandCursor = true;
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            Tweener.removeTweens(this);
            this._isFree = true;
            this._sprite.removeFromParent(true);
            this._sprite = null;
            this._timer.removeFromParent(true);
            this._timer = null;
            this.removeFromParent(true);
         }
      }
      
      public function update() : void
      {
         if(this._isState == "timer")
         {
            if(this._time < GV.real_time)
            {
               this._sec--;
               if(this._sec >= 10)
               {
                  this._timer.text = "" + this._sec;
               }
               else if(this._sec > 0)
               {
                  this._timer.text = "0" + this._sec;
               }
               else
               {
                  this.stop_timer();
               }
               this._time = GV.real_time + 1000;
            }
         }
      }
      
      public function stop_timer() : void
      {
         this._timer.visible = false;
         this._isState = "ready";
         this._sprite.currentFrame = 0;
      }
      
      public function init_timer() : void
      {
         this._isState = "timer";
         this._sprite.currentFrame = 1;
         this._time = GV.real_time + 1000;
         this._sec = this._delay;
         this._timer.visible = true;
         this._timer.text = "" + this._sec;
      }
      
      public function activation_spell() : void
      {
         this._isState = "action";
      }
      
      public function remove() : void
      {
         this._isState = "remove";
         Tweener.removeTweens(this._sprite);
         this._sprite.removeFromParent();
         this._sprite = new MovieClip(GV.assets.getTextures("Spell_un"));
         addChild(this._sprite);
         this._sprite.pivotY = this._sprite.height / 2;
         this._sprite.pivotX = this._sprite.width / 2;
         this._timer.visible = false;
      }
      
      public function select(param1:TouchEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc2_:Touch = param1.getTouch(stage);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               if(this._isState == "ready" && GV.LM._isState != "End" && GV.LM._isState != "Stop")
               {
                  GV.sound.playSFX(this._sound);
                  _loc3_ = GV.heroesArr.length - 1;
                  while(_loc3_ >= 0)
                  {
                     _loc4_ = GV.heroesArr[_loc3_];
                     if(_loc4_["index"] == this._heroType)
                     {
                        _loc4_["Skill_" + this._type](3);
                        this.init_timer();
                        break;
                     }
                     _loc3_--;
                  }
               }
            }
         }
      }
   }
}
