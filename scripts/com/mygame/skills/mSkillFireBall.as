package com.mygame.skills
{
   import com.general.Amath;
   import com.general.IGameObject;
   import com.mygame.effects.Effect;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class mSkillFireBall extends Sprite implements IGameObject
   {
       
      
      public var _sprite:Image;
      
      private var _isFree:Boolean = false;
      
      private var _state:int = 1;
      
      private var _time:int = 0;
      
      private var _power:int = 0;
      
      private var attackbox:Rectangle;
      
      public function mSkillFireBall()
      {
         super();
      }
      
      public function init(param1:*, param2:int) : void
      {
         x = param1;
         y = -100;
         this._power = param2;
         this._sprite = new Image(GV.assets.getTexture("Skill_4_FireBall0000"));
         this._sprite.pivotX = 40;
         this._sprite.pivotY = this._sprite.height / 2;
         addChild(this._sprite);
         this._sprite.rotation = 45;
         this.attackbox = new Rectangle(0,0,200,200);
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
            this._sprite.removeFromParent(true);
            this._sprite = null;
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Effect = null;
         var _loc3_:Sprite = null;
         var _loc4_:Effect = null;
         var _loc5_:int = 0;
         this.attackbox.x = x - 100;
         this.attackbox.y = y - 100;
         switch(this._state)
         {
            case 1:
               y = y + 90 * param1;
               x = x + 50 * param1;
               if(y > GV.groundY - 50)
               {
                  y = GV.groundY - 40;
                  GV.game.shake();
                  this._state = 2;
               }
               if(this._time < GV.real_time)
               {
                  _loc4_ = new Effect();
                  _loc4_.init(x + Amath.random(-10,10),y + Amath.random(-10,10),"Skill_4_Eff",12);
                  _loc4_.rotation = Amath.random(0,360);
                  this._time = GV.real_time + 20;
                  break;
               }
               break;
            case 2:
               this._sprite.visible = false;
               GV.sound.playSFX("explosion");
               _loc2_ = new Effect();
               _loc2_.init(x,y,"Skill_4_Explos",18);
               _loc5_ = GV.enemiesArr.length - 1;
               while(_loc5_ >= 0)
               {
                  _loc3_ = GV.enemiesArr[_loc5_];
                  if(this.attackbox.intersects(_loc3_["hitbox"]))
                  {
                     _loc3_["punch"](40 + Amath.random(5,10));
                     _loc3_["PhysicalDamage"](this._power,false);
                     GV.monk = GV.monk + this._power;
                  }
                  _loc5_--;
               }
               _loc5_ = GV.heroesArr.length - 1;
               while(_loc5_ >= 0)
               {
                  _loc3_ = GV.heroesArr[_loc5_];
                  if(this.attackbox.intersects(_loc3_["hitbox"]))
                  {
                     _loc3_["punch"](30 + Amath.random(5,10));
                  }
                  _loc5_--;
               }
               this.free();
         }
      }
   }
}
