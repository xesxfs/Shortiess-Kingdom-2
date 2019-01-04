package com.mygame.skills
{
   import com.general.Amath;
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class mSkill_Arrows extends Sprite implements IGameObject
   {
       
      
      public var _sprite:Image;
      
      public var _trail:Image;
      
      private var _isFree:Boolean = false;
      
      private var _state:int = 1;
      
      private var _time:int = 0;
      
      private var _damage:int = 0;
      
      public function mSkill_Arrows()
      {
         super();
      }
      
      public function init(param1:int, param2:int) : void
      {
         x = param1;
         y = 50;
         this._damage = param2;
         this._trail = new Image(GV.assets.getTexture("Skill_1_Trail0000"));
         this._trail.pivotX = this._trail.width;
         this._trail.pivotY = this._trail.height / 2;
         this._trail.height = 10;
         this._trail.width = 300;
         addChild(this._trail);
         this._sprite = new Image(GV.assets.getTexture("Skill_2_Arrow0000"));
         this._sprite.pivotX = 5;
         this._sprite.pivotY = this._sprite.height / 2;
         addChild(this._sprite);
         this.rotation = 45;
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            GV.game.objs.remove(this);
            this._trail.removeFromParent(true);
            this._trail = null;
            this._sprite.removeFromParent(true);
            this._sprite = null;
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         switch(this._state)
         {
            case 1:
               y = y + 150 * param1;
               x = x + 100 * param1;
               if(y > GV.groundY)
               {
                  if(GV.enemiesArr.length > 0)
                  {
                     GV.enemiesArr[Amath.random(0,GV.enemiesArr.length - 1)]["PhysicalDamage"](this._damage,false);
                     GV.hunter = GV.hunter + this._damage;
                  }
                  y = GV.groundY - 20;
                  this._state = 2;
                  break;
               }
               break;
            case 2:
               if(this._trail.width > 5)
               {
                  this._trail.width = this._trail.width - 10 * param1;
               }
               this._trail.height = this._trail.height - 10 * param1;
               if(this._trail.height < 5)
               {
                  this._trail.visible = false;
                  this._state = 3;
                  this._time = GV.real_time + 3000;
                  break;
               }
               break;
            case 3:
               if(this._time < GV.real_time)
               {
                  this._state = 4;
                  break;
               }
               break;
            case 4:
               this.alpha = this.alpha - 0.1;
               if(this.alpha <= 0)
               {
                  this.free();
                  break;
               }
         }
      }
   }
}
