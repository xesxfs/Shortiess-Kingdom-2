package com.mygame.effects
{
   import caurina.transitions.Tweener;
   import com.general.IGameObject;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class CritNums extends Sprite implements IGameObject
   {
       
      
      public var _sprite:TextField;
      
      private var _isFree = false;
      
      public function CritNums()
      {
         super();
         this._sprite = new TextField(100,50,"000",new TextFormat("RedNum",44,16777215,Align.LEFT));
         this._sprite.pivotX = this._sprite.width / 2;
         addChild(this._sprite);
         this.touchable = false;
      }
      
      public function init(param1:int, param2:int, param3:int) : void
      {
         this._isFree = false;
         x = param1;
         y = param2;
         this._sprite.text = "-" + param3;
         Tweener.addTween(this,{
            "y":param2 - 60,
            "time":0.5,
            "transition":"easeOutQuint",
            "onComplete":this.free
         });
         GV.game.effects.add(this);
         GV.game.lay_2.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            Tweener.removeTweens(this);
            GV.game.cacheCrit.set(this);
            GV.game.effects.remove(this);
            this.removeFromParent(false);
         }
      }
      
      public function update(param1:Number) : void
      {
      }
   }
}
