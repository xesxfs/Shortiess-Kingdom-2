package com.mygame.skills
{
   import caurina.transitions.Tweener;
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class mSpellSplash extends Sprite implements IGameObject
   {
       
      
      public var _mc:Image;
      
      private var _isFree:Boolean = false;
      
      public function mSpellSplash()
      {
         super();
      }
      
      public function init(param1:int) : void
      {
         x = param1;
         y = GV.groundY + 20;
         this._mc = new Image(GV.assets.getTexture("SplashSpell0000"));
         this._mc.pivotY = int(this._mc.height);
         addChild(this._mc);
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_2.addChildAt(this,0);
         Tweener.addTween(this,{
            "scale":0.4,
            "x":param1 + 350,
            "y":GV.groundY + 80,
            "time":0.7,
            "transition":"easeOutCubic",
            "onComplete":this.free
         });
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            Tweener.removeTweens(this);
            this._isFree = true;
            GV.game.objs.remove(this);
            this._mc.removeFromParent(true);
            this._mc = null;
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
      }
   }
}
