package com.general
{
   import starling.display.Button;
   import starling.text.TextField;
   
   public class MyButton extends Button
   {
       
      
      public var _txt:TextField;
      
      public function MyButton(param1:String, param2:String)
      {
         super(GV.assets.getTexture(param1),"",null,GV.assets.getTexture(param2));
      }
      
      public function free() : void
      {
         this._txt.removeFromParent(true);
         this.removeFromParent(true);
      }
      
      public function init(param1:int, param2:int, param3:int, param4:*, param5:String) : void
      {
         x = param1;
         y = param2;
         this.pivotY = 0;
         this.pivotX = 0;
         this.x = param1 - int(width / 2);
         this.y = param2 - int(height / 2);
         this.useHandCursor = true;
         this._txt = new TextField(this.width,this.height,param5);
         this._txt.format.setTo("PORT",param3,param4,"center");
         this.overlay.addChild(this._txt);
         this._txt.touchable = false;
      }
   }
}
