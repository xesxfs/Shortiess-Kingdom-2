package com.general
{
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class MySoundVolume extends Sprite
   {
       
      
      private var _btnMin:Button;
      
      private var _btnMax:Button;
      
      private var _line:Image;
      
      private var _level:Image;
      
      private var _pic:Image;
      
      public function MySoundVolume()
      {
         super();
      }
      
      public function init(param1:int, param2:int) : *
      {
         x = param1;
         y = param2;
         this._line = new Image(GV.assets.getTexture("Sn_line0000"));
         this._line.pivotX = int(this._line.width / 2);
         this._line.pivotY = int(this._line.height / 2);
         addChild(this._line);
         this._level = new Image(GV.assets.getTexture("Sn_level0000"));
         this._level.pivotY = int(this._level.height / 2);
         addChild(this._level);
         this._pic = new Image(GV.assets.getTexture("Sn_pic0000"));
         this._pic.x = -165;
         this._pic.y = -15;
         addChild(this._pic);
         this._btnMin = new Button(GV.assets.getTexture("Btn_min0000"));
         this._btnMin.pivotX = int(this._btnMin.width / 2);
         this._btnMin.pivotY = int(this._btnMin.height / 2);
         this._btnMin.x = -90;
         addChild(this._btnMin);
         this._btnMin.useHandCursor = true;
         this._btnMax = new Button(GV.assets.getTexture("Btn_max0000"));
         this._btnMax.pivotX = int(this._btnMax.width / 2);
         this._btnMax.pivotY = int(this._btnMax.height / 2);
         this._btnMax.x = 95;
         addChild(this._btnMax);
         this._btnMax.useHandCursor = true;
         this.move_level();
         this._btnMin.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnMax.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      public function free() : *
      {
         this._btnMin.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnMin.useHandCursor = false;
         this._btnMin.removeFromParent(true);
         this._btnMax.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnMax.useHandCursor = false;
         this._btnMax.removeFromParent(true);
         this._line.removeFromParent(true);
         this._level.removeFromParent(true);
         this._pic.removeFromParent(true);
         this.removeFromParent(true);
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnMin)
         {
            GV.sound.playSFX("click");
            GV.settings[0] = GV.settings[0] - 2;
            if(GV.settings[0] < 0)
            {
               GV.settings[0] = 0;
            }
            GV.sound.setVolumeSOUND(GV.settings[0] / 10);
            this.move_level();
         }
         if(_loc2_ as Button == this._btnMax)
         {
            GV.sound.playSFX("click");
            GV.settings[0] = GV.settings[0] + 2;
            if(GV.settings[0] > 10)
            {
               GV.settings[0] = 10;
            }
            GV.sound.setVolumeSOUND(GV.settings[0] / 10);
            this.move_level();
         }
      }
      
      public function move_level() : void
      {
         this._level.x = this._line.x - this._line.pivotX + GV.settings[0] / 2 * this._line.width / 6 - 2;
      }
   }
}
