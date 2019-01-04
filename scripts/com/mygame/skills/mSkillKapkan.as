package com.mygame.skills
{
   import caurina.transitions.Tweener;
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class mSkillKapkan extends Sprite implements IGameObject
   {
       
      
      public var _plant:Image;
      
      private var _isFree:Boolean = false;
      
      private var _state:int = 0;
      
      public var _time:int = 0;
      
      private var _enemy;
      
      public function mSkillKapkan()
      {
         super();
      }
      
      public function init(param1:Sprite, param2:int) : void
      {
         this._enemy = param1;
         x = this._enemy.x;
         y = GV.groundY + 100;
         this._plant = new Image(GV.assets.getTexture("Skill_5_Plant0000"));
         this._plant.pivotX = int(this._plant.width / 2) + 10;
         addChild(this._plant);
         this._time = GV.real_time + param2 * 1000;
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_1.addChildAt(this,0);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            Tweener.removeTweens(this);
            this._isFree = true;
            GV.game.objs.remove(this);
            this._plant.removeFromParent(true);
            this._plant = null;
            this.removeFromParent(true);
         }
      }
      
      public function StopGrow() : void
      {
         this._state = 1;
      }
      
      public function Destroy() : void
      {
         if(this._enemy != null && !this._enemy["_isFree"])
         {
            this._enemy["StopPlantEffects"]();
         }
         this.free();
      }
      
      public function update(param1:Number) : void
      {
         if(this._enemy == null || this._enemy["_isFree"])
         {
            if(this._state != -2)
            {
               this._state = 3;
            }
         }
         else
         {
            x = this._enemy.x;
         }
         switch(this._state)
         {
            case 0:
               Tweener.addTween(this,{
                  "y":GV.groundY - 40,
                  "time":0.5,
                  "transition":"easeOutBack",
                  "onComplete":this.StopGrow
               });
               this._state = -1;
               break;
            case 1:
               this._enemy["StartPlantEffects"]();
               this._state = 2;
               break;
            case 2:
               if(this._time < GV.real_time)
               {
                  this._state = 3;
                  break;
               }
               break;
            case 3:
               Tweener.addTween(this,{
                  "y":GV.groundY + 100,
                  "time":0.5,
                  "transition":"easeInBack",
                  "onComplete":this.Destroy
               });
               this._state = -2;
         }
      }
   }
}
