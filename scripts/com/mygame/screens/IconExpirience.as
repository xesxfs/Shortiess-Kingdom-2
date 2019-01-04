package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class IconExpirience extends Sprite
   {
       
      
      private var _icon:Image;
      
      private var _line:Image;
      
      private var _frame:Image;
      
      private var _sun:Image;
      
      public var _type:int;
      
      public var _curLevel:int;
      
      private var _levelTxt:TextField;
      
      private var _expTxt:TextField;
      
      private var _curExp:int;
      
      private var _maxExp:int;
      
      private var _stepExp:int;
      
      private var _freeExp:int;
      
      private var isEnd:Boolean = false;
      
      public function IconExpirience()
      {
         super();
      }
      
      public function init(param1:int) : *
      {
         this._type = param1;
         this._curLevel = GV["her" + this._type][0];
         this._curExp = GV["her" + this._type][3];
         this._freeExp = GV["hExp" + this._type] + int(GV["hExp" + this._type] * GV.factorExp[this._type]);
         this._frame = new Image(GV.assets.getTexture("ExpFrame0000"));
         this._frame.x = -80;
         this._frame.y = 70;
         addChild(this._frame);
         this._line = new Image(GV.assets.getTexture("ExpLine0000"));
         this._line.x = -34;
         this._line.y = 83;
         addChild(this._line);
         this._levelTxt = new TextField(50,30,"10",new TextFormat("NormalТNum",27,16777215,Align.CENTER));
         this._levelTxt.x = -84;
         this._levelTxt.y = 79;
         addChild(this._levelTxt);
         this._levelTxt.touchable = false;
         this._expTxt = new TextField(160,30,"1003/4634",new TextFormat("NormalТNum",18,16777215,Align.LEFT));
         this._expTxt.x = -32;
         this._expTxt.y = 84;
         addChild(this._expTxt);
         this._expTxt.touchable = false;
         this._sun = new Image(GV.assets.getTexture("Sun0000"));
         this._sun.pivotY = 62;
         this._sun.pivotX = 62;
         this._sun.y = 37;
         this._sun.scale = 0.1;
         addChild(this._sun);
         this._icon = new Image(GV.assets.getTexture("ExpIcon000" + this._type));
         this._icon.pivotY = 37;
         this._icon.pivotX = 37;
         this._icon.y = 37;
         addChild(this._icon);
         this.calculateExp();
      }
      
      public function free() : *
      {
         Tweener.removeTweens(this._icon);
         Tweener.removeTweens(this._sun);
         this.removeFromParent(true);
      }
      
      private function calculateExp() : *
      {
         this._maxExp = 50 + (this._curLevel - 1) * 150;
         this._stepExp = this._maxExp / 25;
         this._expTxt.text = this._curExp + "/" + this._maxExp;
         this._line.scaleX = this._curExp / this._maxExp;
         this._levelTxt.text = "" + this._curLevel;
      }
      
      public function update() : *
      {
         this._sun.rotation = this._sun.rotation + 0.05;
         if(this._freeExp > 0)
         {
            if(this._freeExp > this._stepExp)
            {
               this._freeExp = this._freeExp - this._stepExp;
               this._curExp = this._curExp + this._stepExp;
            }
            else
            {
               this._curExp = this._curExp + this._freeExp;
               this._freeExp = 0;
            }
            GV["her" + this._type][3] = this._curExp;
            if(this._curExp < this._maxExp)
            {
               this._expTxt.text = this._curExp + "/" + this._maxExp;
               this._line.scaleX = this._curExp / this._maxExp;
            }
            else
            {
               this._curLevel++;
               GV["her" + this._type][0]++;
               this._curExp = 0;
               GV["her" + this._type][3] = 0;
               this.calculateExp();
               Tweener.addTween(this._icon,{
                  "scale":1.3,
                  "time":0.3,
                  "transition":"lenear"
               });
               Tweener.addTween(this._sun,{
                  "scale":2,
                  "time":0.3,
                  "transition":"lenear"
               });
               Tweener.addTween(this._icon,{
                  "scale":1,
                  "delay":0.3,
                  "time":0.9,
                  "transition":"lenear"
               });
               Tweener.addTween(this._sun,{
                  "scale":0,
                  "delay":0.3,
                  "time":2,
                  "transition":"lenear"
               });
            }
         }
         else if(!this.isEnd)
         {
            this.isEnd = true;
            parent.parent["StopExpirience"]();
         }
      }
   }
}
