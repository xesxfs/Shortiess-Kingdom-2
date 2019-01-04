package com.mygame.enemies
{
   import com.general.Amath;
   import com.mygame.effects.CritNums;
   import com.mygame.effects.Damage_info;
   import com.mygame.effects.Effect;
   import com.mygame.effects.EffectHero;
   import com.mygame.effects.GravityObj;
   import dragonBones.Armature;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class EnemyBase extends Sprite
   {
       
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      public var index:int;
      
      public var type:int;
      
      public var level:int;
      
      public var exp:int;
      
      public var coins:int;
      
      public var H_Def:Number = 1;
      
      public var M_Def:Number = 1;
      
      public var curHP:int;
      
      public var maxHP:int;
      
      public var frame:Image;
      
      public var line:Quad;
      
      private var isCollide = false;
      
      public var _isFree:Boolean = false;
      
      public var _curState:String = "Wait";
      
      public var _nameAmimation:String = "Wait";
      
      public var _isComleteAttack:Boolean = false;
      
      public var _isForward:Boolean = false;
      
      public var _isBack:Boolean = false;
      
      public var _isAttack:Boolean = false;
      
      public var _isPlant:Boolean = false;
      
      public var attackbox:Rectangle;
      
      public var hitbox:Rectangle;
      
      protected var _debugH:Quad;
      
      protected var _debugA:Quad;
      
      public var punchPower:int;
      
      public var attackPower:int;
      
      public var _delayAttack:int;
      
      public var _delayReturn:int;
      
      public var _timeAttack:int = 0;
      
      public var _timeReturn:int = 0;
      
      public var _numAttack:int = 1;
      
      public var posX:int;
      
      public var curSpeedX:Number = 0;
      
      public var maxSpeedX:Number;
      
      public var accX:Number;
      
      public var distX:int;
      
      public var maxX:int = 0;
      
      public var minX:int = 0;
      
      public var attX:int = 0;
      
      public var curSpeedY:Number = 0;
      
      public var accY:Number = 8;
      
      public var timeJump:int = 0;
      
      public var posY:int;
      
      public var en:Sprite;
      
      public var hX:int = 0;
      
      public var hY:int = 0;
      
      public var aX:int = 0;
      
      public var aY:int = 0;
      
      public function EnemyBase()
      {
         super();
      }
      
      public function init(param1:int) : *
      {
         y = this.posY = GV.groundY - 20;
         x = param1 + GV.scr_X;
         this.curHP = this.maxHP = GV.enStats[this.index][0];
         this.H_Def = GV.enStats[this.index][1];
         this.M_Def = GV.enStats[this.index][2];
         this.attackPower = GV.enStats[this.index][3];
         this._delayAttack = GV.enStats[this.index][4] * 1000 + Amath.random(0,200);
         this._delayReturn = GV.enStats[this.index][5] * 1000;
         this.maxSpeedX = GV.enStats[this.index][6];
         this.accX = GV.enStats[this.index][7];
         this.exp = GV.enStats[this.index][8];
         this.coins = GV.enStats[this.index][9];
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         this._armature.animation.play("Wait");
         GV.game.lay_0.addChild(this);
         GV.enemiesArr.push(this);
      }
      
      public function free() : *
      {
         var _loc1_:int = 0;
         if(!this._isFree)
         {
            if(!GV.debug)
            {
            }
            if(this._debugH)
            {
               this._debugH.removeFromParent();
            }
            if(this._debugA)
            {
               this._debugA.removeFromParent();
            }
            WorldClock.clock.remove(this._armature);
            removeChild(this._armatureDisplay);
            this._armatureDisplay = null;
            this._armature = null;
            this.frame.removeFromParent(true);
            this.line.removeFromParent(true);
            this.removeFromParent();
            _loc1_ = GV.enemiesArr.length - 1;
            while(_loc1_ >= 0)
            {
               if(GV.enemiesArr[_loc1_] == this)
               {
                  GV.enemiesArr.splice(_loc1_,1);
                  break;
               }
               _loc1_--;
            }
            this._isFree = true;
         }
      }
      
      public function update(param1:Number) : *
      {
         this.hitbox.x = this.x + this.hX;
         this.hitbox.y = this.y + this.hY;
         if(this._debugA)
         {
            this._debugA.x = this.x - this.attX;
            this._debugA.y = this.y - 50;
         }
         if(this._debugH)
         {
            this._debugH.x = this.hitbox.x;
            this._debugH.y = this.hitbox.y;
         }
         if(this.curHP <= 0)
         {
            this.deathEffects();
            GV.freeExp = GV.freeExp + this.exp;
            GV.freeCoins = GV.freeCoins + this.coins;
            this.free();
            return;
         }
         if(x < GV.enPosX)
         {
            GV.enPosX = this.hitbox.x;
         }
         this.YposUpdate(param1);
         x = x - this.curSpeedX * param1;
         if(this._isForward == false && this.curSpeedX > 0)
         {
            this.curSpeedX = this.curSpeedX - this.accX * param1;
         }
         if(this._isBack == false && this.curSpeedX < 0)
         {
            this.curSpeedX = this.curSpeedX + this.accX * param1;
         }
         switch(this._curState)
         {
            case "Attack":
               if(!this._isAttack)
               {
                  if(x - this.attX < GV.camPos)
                  {
                     if(this._timeAttack < GV.real_time)
                     {
                        this._isAttack = true;
                        this._isComleteAttack = false;
                        this._isForward = false;
                        this._isBack = false;
                        this._armature.animation.play("Attack");
                        this._nameAmimation = "Attack";
                        this._timeReturn = GV.real_time + this._delayReturn;
                        return;
                     }
                  }
                  if(x - this.maxX > GV.camPos)
                  {
                     this._isForward = true;
                     this._isBack = false;
                     if(this.curSpeedX < this.maxSpeedX)
                     {
                        this.curSpeedX = this.curSpeedX + this.accX * param1;
                     }
                     if(this._nameAmimation != "Run")
                     {
                        this._armature.animation.play("Run");
                        this._nameAmimation = "Run";
                     }
                     return;
                  }
                  if(x + this.minX > GV.camPos)
                  {
                     this._isForward = false;
                     this._isBack = true;
                     if(this._nameAmimation != "Run")
                     {
                        this._armature.animation.play("Run");
                        this._nameAmimation = "Run";
                     }
                     return;
                  }
                  if(this._nameAmimation != "Wait")
                  {
                     this.curSpeedX = 0;
                     this._armature.animation.play("Wait");
                     this._nameAmimation = "Wait";
                     break;
                  }
                  break;
               }
               if(this.curSpeedX > 0)
               {
                  this.curSpeedX = this.curSpeedX - this.accX * param1 * 2;
               }
               if(this._timeReturn < GV.real_time && this._isComleteAttack && this._nameAmimation != "Return")
               {
                  this._armature.animation.play("Return");
                  this._nameAmimation = "Return";
                  this._timeAttack = GV.real_time + this._delayAttack;
                  break;
               }
               break;
            case "Run":
               this._isForward = true;
               if(this.curSpeedX < this.maxSpeedX)
               {
                  this.curSpeedX = this.curSpeedX + this.accX * param1;
                  break;
               }
         }
      }
      
      public function YposUpdate(param1:Number) : void
      {
         y = y + this.curSpeedY * param1;
         if(y < this.posY)
         {
            this.curSpeedY = this.curSpeedY + this.accY * param1;
         }
         else
         {
            y = this.posY;
            this.curSpeedY = 0;
         }
      }
      
      public function Move(param1:Number) : void
      {
      }
      
      public function Attack() : void
      {
         var _loc1_:int = GV.heroesArr.length - 1;
         while(_loc1_ >= 0)
         {
            this.en = GV.heroesArr[_loc1_];
            if(x - this.attX < this.en.x)
            {
               GV.heroesArr[_loc1_]["punch"](Amath.random(10,20));
               GV.heroesArr[_loc1_]["PhysicalDamage"](this.attackPower + Amath.random(-this.attackPower * 0.2,this.attackPower * 0.2));
               break;
            }
            _loc1_--;
         }
      }
      
      public function _animationHandler(param1:StarlingEvent) : void
      {
         switch(this._nameAmimation)
         {
            case "Attack":
               this.Attack();
               this._isComleteAttack = true;
               break;
            case "Return":
               this._isAttack = false;
               this._armature.animation.play("Wait");
               this._nameAmimation = "Wait";
               break;
            case "Run":
               this._armature.animation.play("Run");
               break;
            case "Wait":
               this._armature.animation.play("Wait");
         }
      }
      
      public function PhysicalDamage(param1:int, param2:Boolean) : void
      {
         if(!param2)
         {
            this.damage(param1 * this.H_Def);
         }
         else
         {
            this.Crit(param1 * this.H_Def);
         }
      }
      
      public function MagicDamage(param1:int, param2:Boolean) : void
      {
         if(!param2)
         {
            this.damage(param1 * this.M_Def);
         }
         else
         {
            this.Crit(param1 * this.M_Def);
         }
      }
      
      public function Crit(param1:int) : void
      {
         this.curHP = this.curHP - param1;
         var _loc2_:CritNums = GV.game.cacheCrit.get() as CritNums;
         _loc2_.init(x + Amath.random(20,40),y - Amath.random(30,70),param1);
         if(this.curHP <= 0)
         {
            this.line.width = 0;
         }
         else
         {
            this.line.scaleX = this.curHP / this.maxHP;
         }
      }
      
      public function damage(param1:int) : void
      {
         this.curHP = this.curHP - param1;
         var _loc2_:Damage_info = GV.game.cacheDamage.get() as Damage_info;
         _loc2_.init(x + Amath.random(20,40),y - Amath.random(30,70),param1);
         if(this.curHP <= 0)
         {
            this.line.width = 0;
         }
         else
         {
            this.line.scaleX = this.curHP / this.maxHP;
         }
      }
      
      public function punch(param1:Number) : void
      {
         if(!this._isPlant)
         {
            this.curSpeedX = -param1;
         }
      }
      
      public function Healing(param1:int) : void
      {
         this.curHP = this.curHP + param1;
         if(this.curHP > this.maxHP)
         {
            this.curHP = this.maxHP;
         }
         this.line.scaleX = this.curHP / this.maxHP;
         this.AddEffect(0,0,"Skill_6_Healing",24);
      }
      
      public function AddEffect(param1:int, param2:int, param3:String, param4:int) : void
      {
         var _loc5_:EffectHero = new EffectHero();
         _loc5_.init(param1,param2,param3,param4);
         addChild(_loc5_);
      }
      
      public function deathEffects() : void
      {
         var _loc1_:GravityObj = null;
         _loc1_ = new GravityObj();
         _loc1_.init(x,y,"Bone" + "0000");
         _loc1_ = new GravityObj();
         _loc1_.init(x,y,"Bone" + "0000");
         _loc1_ = new GravityObj();
         _loc1_.init(x,y,"Skull" + this.index + "_0000");
         GV.sound.die();
         var _loc2_:Effect = new Effect();
         _loc2_.init(x + 20,y - 20,"Smoke1_",24);
      }
      
      public function StartPlantEffects() : void
      {
         if(!this._isPlant && this._curState == "Attack")
         {
            this._isPlant = true;
            y = this.posY;
            this._armature.animation.play("Wait");
            this._nameAmimation = "Wait";
            this._isAttack = false;
            this.curSpeedX = 0;
            this._curState = "Stop";
         }
      }
      
      public function StopPlantEffects() : void
      {
         if(this._isPlant)
         {
            this._isPlant = false;
            this._curState = "Attack";
            this._armature.animation.play("Wait");
            this._nameAmimation = "Wait";
         }
      }
      
      public function Jump() : void
      {
         if(y >= this.posY)
         {
            this.curSpeedY = -Amath.random(20,30);
         }
      }
      
      public function create_life(param1:int, param2:int) : void
      {
         this.frame = new Image(GV.assets.getTexture("LifeFrame0000"));
         this.frame.pivotX = int(this.frame.width / 2) + param1;
         this.frame.y = param2;
         addChild(this.frame);
         this.line = new Quad(40,4,8104471);
         this.line.x = this.frame.x + 2 - int(this.frame.width / 2);
         this.line.y = this.frame.y + 2;
         addChild(this.line);
      }
      
      public function debagHitbox() : void
      {
         this._debugH = new Quad(this.hitbox.width,this.hitbox.height,16711680);
         GV.game.lay_0.addChild(this._debugH);
         this._debugH.alpha = 0.3;
      }
      
      public function debagAttack() : void
      {
         this._debugA = new Quad(this.attX,100,15073024);
         GV.game.lay_0.addChild(this._debugA);
         this._debugA.alpha = 0.3;
      }
      
      public function InitTransition() : void
      {
         this._armature.animation.play("Run");
         this._nameAmimation = "Run";
         this._curState = "Run";
      }
   }
}
