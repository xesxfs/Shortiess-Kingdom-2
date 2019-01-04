package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.mygame.skills.BtnSkillBase;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.setTimeout;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class TopMenu extends Sprite
   {
       
      
      private var _btnPause:Button;
      
      private var _btnTutor:Button;
      
      private var _btnLogo:Button;
      
      private var _lineR:Image;
      
      private var _lineCenter:Image;
      
      private var _lineL:Image;
      
      private var _scullsArr:Array;
      
      private var _skillArr:Array;
      
      public function TopMenu()
      {
         this._scullsArr = [];
         this._skillArr = [];
         super();
         this.draw();
      }
      
      public function init_level(param1:int) : *
      {
         var _loc5_:MovieClip = null;
         this.visible = true;
         var _loc2_:int = param1 * 40 / 2;
         var _loc3_:int = GV.cent_X - _loc2_;
         this._lineCenter.width = _loc2_ * 2;
         this._lineR.x = GV.cent_X + _loc2_ - 20;
         this._lineL.x = GV.cent_X - this._lineR.width - _loc2_ + 20;
         this._scullsArr = [];
         var _loc4_:int = 0;
         while(_loc4_ < param1)
         {
            _loc5_ = new MovieClip(GV.assets.getTextures("BattleSkull"));
            _loc5_.pivotX = 0;
            _loc5_.pivotY = 0;
            _loc5_.x = _loc3_ + _loc4_ * 40 + 20 - _loc5_.width / 2;
            _loc5_.y = this._lineR.y - 12;
            addChild(_loc5_);
            this._scullsArr.push(_loc5_);
            _loc4_++;
         }
      }
      
      public function next_skull(param1:int) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._scullsArr.length)
         {
            if(param1 - 1 > _loc2_)
            {
               this._scullsArr[_loc2_].currentFrame = 2;
            }
            else if(param1 - 1 == _loc2_)
            {
               this._scullsArr[_loc2_].currentFrame = 1;
            }
            _loc2_++;
         }
      }
      
      public function CreateSpell(param1:int, param2:int) : *
      {
         var _loc3_:BtnSkillBase = new BtnSkillBase();
         _loc3_.init(param1,param2);
         _loc3_.y = GV.groundY + 100;
         addChild(_loc3_);
         this._skillArr.push(_loc3_);
         this.GroupingSkill();
      }
      
      public function GroupingSkill() : *
      {
         var _loc2_:* = GV.cent_X - this._skillArr.length * 90 / 2 + 90 / 2;
         var _loc3_:int = this._skillArr.length - 1;
         while(_loc3_ >= 0)
         {
            this._skillArr[_loc3_].x = int(_loc2_ + _loc3_ * 90);
            _loc3_--;
         }
      }
      
      public function RemoveSkill(param1:int) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._skillArr.length)
         {
            if(this._skillArr[_loc2_]["_heroType"] == param1)
            {
               this._skillArr[_loc2_].remove();
            }
            _loc2_++;
         }
      }
      
      public function FreeAllSkills() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._skillArr.length)
         {
            Tweener.addTween(this._skillArr[_loc1_],{
               "y":GV.scr_Y + 100,
               "time":0.6,
               "delay":_loc1_ * 0.2,
               "transition":"easeInBack"
            });
            _loc1_++;
         }
      }
      
      public function free_level() : *
      {
         this.visible = false;
         var _loc1_:int = this._skillArr.length - 1;
         while(_loc1_ >= 0)
         {
            this._skillArr[_loc1_].free();
            this._skillArr[_loc1_] = null;
            this._skillArr.splice(_loc1_,1);
            _loc1_--;
         }
         while(this._scullsArr.length > 0)
         {
            this._scullsArr[0].removeFromParent();
            this._scullsArr[0] = null;
            this._scullsArr.splice(0,1);
         }
      }
      
      public function free() : void
      {
      }
      
      public function openPause() : void
      {
         if(GV.isPlay && GV.LM._isState != "Stop" && GV.LM._isState != "Fail")
         {
            GV.sound.playSFX("click");
            GV.isPlay = false;
            GV.game.SM.open_screen("Pause");
         }
      }
      
      private function openTutorial() : void
      {
         GV.isPlay = false;
         GV.game.SM.open_screen("Tutorial");
      }
      
      public function update() : void
      {
         var _loc1_:int = this._skillArr.length - 1;
         while(_loc1_ >= 0)
         {
            this._skillArr[_loc1_].update();
            _loc1_--;
         }
      }
      
      public function activation() : void
      {
      }
      
      public function FlagDown() : void
      {
      }
      
      public function addCoins(param1:int) : void
      {
      }
      
      public function IronShieldTimer(param1:int) : void
      {
         setTimeout(this.FreeIronShield,param1 * 1000);
      }
      
      private function FreeIronShield() : void
      {
         var _loc1_:int = GV.heroesArr.length - 1;
         while(_loc1_ >= 0)
         {
            GV.heroesArr[_loc1_]["FreeIronShield"]();
            _loc1_--;
         }
      }
      
      public function ExtraPower(param1:int) : void
      {
         setTimeout(this.FreeExtraPower,param1 * 1000);
      }
      
      private function FreeExtraPower() : void
      {
         var _loc1_:int = GV.heroesArr.length - 1;
         while(_loc1_ >= 0)
         {
            GV.heroesArr[_loc1_]["FreeExtraPower"]();
            _loc1_--;
         }
      }
      
      private function link_() : void
      {
         navigateToURL(new URLRequest("http://www.myplayyard.com"));
      }
      
      public function draw() : void
      {
         this.visible = false;
         this._btnPause = new Button(GV.assets.getTexture("Btn_pause0000"));
         this._btnPause.x = int(GV.scr_X - 15 - this._btnPause.width);
         this._btnPause.y = 10;
         addChild(this._btnPause);
         this._btnPause.addEventListener(Event.TRIGGERED,this.openPause);
         this._btnTutor = new Button(GV.assets.getTexture("Btn_Tutrial0000"));
         this._btnTutor.x = int(this._btnPause.x - 10 - this._btnTutor.width);
         this._btnTutor.y = 5;
         addChild(this._btnTutor);
         this._btnTutor.addEventListener(Event.TRIGGERED,this.openTutorial);
         this._btnTutor.visible = false;
         this._lineCenter = new Image(GV.assets.getTexture("BattleLine0000"));
         this._lineCenter.pivotX = this._lineCenter.width / 2;
         this._lineCenter.x = GV.cent_X;
         this._lineCenter.y = 30;
         addChild(this._lineCenter);
         this._lineCenter.touchable = false;
         this._lineR = new Image(GV.assets.getTexture("SideR0000"));
         this._lineR.x = GV.cent_X;
         this._lineR.y = 30;
         addChild(this._lineR);
         this._lineR.touchable = false;
         this._lineL = new Image(GV.assets.getTexture("SideL0000"));
         this._lineL.x = GV.cent_X;
         this._lineL.y = 30;
         addChild(this._lineL);
         this._lineL.touchable = false;
         this._btnLogo = new Button(GV.assets.getTexture("Logo_head0000"));
         this._btnLogo.overState = GV.assets.getTexture("Logo_head0001");
         this._btnLogo.x = 20;
         this._btnLogo.y = 15;
         addChild(this._btnLogo);
         this._btnLogo.addEventListener(Event.TRIGGERED,this.link_);
      }
   }
}
