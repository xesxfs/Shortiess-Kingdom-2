package com.mygame.heroes
{
   import com.general.Amath;
   import com.mygame.effects.Damage_info;
   import com.mygame.effects.EffectHero;
   import com.mygame.effects.GravityObj;
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class HeroBase extends Sprite
   {
       
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      public var _headImg:Image;
      
      public var _headMc:MovieClip;
      
      public var _ShieldMc:MovieClip;
      
      public var curHP:int;
      
      public var maxHP:int;
      
      public var frame:Image;
      
      public var line:Quad;
      
      public var _isFree:Boolean = false;
      
      public var _isCollide:Boolean = false;
      
      public var _isAttack:Boolean = false;
      
      public var _isSkill:Boolean = false;
      
      public var _isForward:Boolean = false;
      
      public var _isBack:Boolean = false;
      
      public var _isComleteAttack:Boolean = false;
      
      public var _curState:String = "Attack";
      
      public var _nameAmimation:String = "Run";
      
      public var index:int;
      
      public var type:int;
      
      public var level:int;
      
      public var H_Exp:Number = 1;
      
      public var _idWeapon:int;
      
      public var _idHead:int;
      
      public var H_Skill_Def:Number = 1;
      
      public var H_Def:Number = 1;
      
      public var M_Def:Number = 1;
      
      public var punchPower:int;
      
      public var attackPower:int;
      
      public var extrPower:int = 1;
      
      public var crit:Number;
      
      public var _delayAttack:int = 1000;
      
      public var _delayReturn:int = 0;
      
      public var _timeAttack:int = 2000;
      
      public var _timeReturn:int = 0;
      
      public var _numAttack:int = 1;
      
      public var spellPower:int = 1;
      
      public var _skillRang:int;
      
      public var attackbox:Rectangle;
      
      public var hitbox:Rectangle;
      
      protected var _debugH:Quad;
      
      protected var _debugA:Quad;
      
      public var curSpeedX:Number = 0;
      
      public var maxSpeedX:Number = 24;
      
      public var accX:Number = 4;
      
      public var maxX:int = 0;
      
      public var minX:int = 0;
      
      public var attX:int = 0;
      
      public var distX:int;
      
      public var curSpeedY:Number = 0;
      
      public var accY:Number = 8;
      
      public var timeJump:int = 0;
      
      public var posY:int;
      
      public var en:Sprite;
      
      public function HeroBase()
      {
         this.hitbox = new Rectangle(0,0,50,70);
         super();
      }
      
      public function init() : *
      {
         y = this.posY = GV.groundY - 20;
         x = GV.cent_X - 100 * this.index;
         this._armatureDisplay.y = 30;
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         this._armature.animation.play("Run");
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         this.frame = new Image(GV.assets.getTexture("LifeFrame0000"));
         this.frame.pivotX = int(this.frame.width / 2);
         this.frame.y = -55;
         addChild(this.frame);
         this.line = new Quad(40,4,8104471);
         this.line.x = this.frame.x + 2 - int(this.frame.width / 2);
         this.line.y = this.frame.y + 2;
         addChild(this.line);
         this.H_Def = GV["her" + this.index][5];
         this.M_Def = GV["her" + this.index][6];
         if(GV.heads0[this._idHead][11] != 0)
         {
            this.spellPower = 1 + GV.heads0[this._idHead][11] / 100;
         }
         GV.game.lay_1.addChild(this);
         GV.heroesArr.push(this);
      }
      
      public function free() : *
      {
         var _loc1_:int = 0;
         if(!this._isFree)
         {
            if(this._debugH)
            {
               this._debugH.removeFromParent();
            }
            if(this._debugA)
            {
               this._debugA.removeFromParent();
            }
            this.FreeExtraPower();
            this.FreeIronShield();
            WorldClock.clock.remove(this._armature);
            removeChild(this._armatureDisplay);
            this._armatureDisplay = null;
            this._armature = null;
            this.frame.removeFromParent(true);
            this.line.removeFromParent(true);
            this.removeFromParent();
            _loc1_ = GV.heroesArr.length - 1;
            while(_loc1_ >= 0)
            {
               if(GV.heroesArr[_loc1_] == this)
               {
                  GV.heroesArr.splice(_loc1_,1);
                  break;
               }
               _loc1_--;
            }
            this._isFree = true;
         }
      }
      
      public function update(param1:Number) : *
      {
         this.hitbox.x = this.x - 25;
         this.hitbox.y = this.y - 35;
         if(x > GV.camPos)
         {
            GV.camPos = x;
         }
         GV["hExp" + this.index] = GV["hExp" + this.index] + GV.freeExp * this.H_Exp;
         if(this.curHP <= 0 && !this._isSkill)
         {
            this.deathEffects();
            GV.LM._tMenu.RemoveSkill(this.index);
            this.free();
            return;
         }
         x = x + this.curSpeedX * param1;
         if(this._isForward == false && this.curSpeedX > 0)
         {
            this.curSpeedX = this.curSpeedX - this.accX * param1;
         }
         if(this._isBack == false && this.curSpeedX < 0)
         {
            this.curSpeedX = this.curSpeedX + this.accX * param1;
         }
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
         switch(this._curState)
         {
            case "Attack":
               if(!this._isAttack)
               {
                  if(x + this.attX > GV.enPosX)
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
                        this.Jump();
                        this.sound_attack();
                        return;
                     }
                  }
                  if(x + this.maxX < GV.enPosX)
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
                  if(x + this.minX > GV.enPosX)
                  {
                     this._isForward = false;
                     this._isBack = true;
                     if(this.curSpeedX > -this.maxSpeedX / 2)
                     {
                        this.curSpeedX = this.curSpeedX - this.accX * param1 / 4;
                     }
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
            case "Skill":
               if(this.curSpeedX > 0)
               {
                  this.curSpeedX = this.curSpeedX - this.accX * param1 * 2;
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
               break;
            case "Stop":
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
               break;
            case "SkillStart":
               this.SkillAction();
               this._armature.animation.play("SkillReturn");
               this._nameAmimation = "SkillReturn";
               break;
            case "SkillReturn":
               this.StopSkill();
         }
      }
      
      public function Attack() : void
      {
      }
      
      public function PhysicalDamage(param1:int) : void
      {
         this.damage(param1 * this.H_Def);
         GV.sound.damage();
      }
      
      public function MagicDamage(param1:int) : void
      {
         this.damage(param1 * this.M_Def);
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
         this.curSpeedX = -param1;
      }
      
      public function deathEffects() : void
      {
         var _loc1_:GravityObj = null;
         _loc1_ = new GravityObj();
         _loc1_.init(x,y,"Bone" + "0000");
         _loc1_ = new GravityObj();
         _loc1_.init(x,y,"Bone" + "0000");
         _loc1_ = new GravityObj();
         _loc1_.init(x,y,"Skull" + "0000");
         this.AddEffect(0,0,"Smoke1_",24);
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
      
      public function IrionShield(param1:Number) : void
      {
         this.H_Def = param1;
         this.M_Def = param1;
         this._ShieldMc = new MovieClip(GV.assets.getTextures("ShieldAnim"),24);
         this._ShieldMc.loop = false;
         this._ShieldMc.setFrameDuration(0,0);
         this._ShieldMc.x = -50;
         this._ShieldMc.y = -60;
         addChild(this._ShieldMc);
         GV.juggler.add(this._ShieldMc);
         this._ShieldMc.play();
      }
      
      public function FreeIronShield() : void
      {
         this.H_Def = GV["her" + this.index][5];
         this.M_Def = GV["her" + this.index][6];
         if(this._ShieldMc)
         {
            this._ShieldMc.stop();
            GV.juggler.remove(this._ShieldMc);
            this._ShieldMc.removeFromParent();
            this._ShieldMc = null;
         }
      }
      
      public function ExtraPower(param1:Number) : void
      {
         var _loc2_:Slot = null;
         if(!this._headMc)
         {
            this.extrPower = param1;
            this._delayAttack = this._delayAttack / 2;
            this._headImg.visible = false;
            _loc2_ = this._armature.getSlot("Head");
            this._headMc = new MovieClip(GV.assets.getTextures("FireSkull"));
            this._headMc.pivotY = 10;
            this._headMc.pivotX = 10;
            this._headMc.setFrameDuration(0,0);
            this._headMc.x = -10;
            this._headMc.y = -30;
            _loc2_.display.addChild(this._headMc);
            GV.juggler.add(this._headMc);
            this._headMc.play();
         }
      }
      
      public function FreeExtraPower() : void
      {
         this.extrPower = 1;
         this._headImg.visible = true;
         this._delayAttack = this._delayAttack * 2;
         if(this._headMc)
         {
            this._headMc.stop();
            GV.juggler.remove(this._headMc);
            this._headMc.removeFromParent();
            this._headMc = null;
         }
      }
      
      public function Up(param1:Number) : void
      {
         this._armatureDisplay.scale = param1;
      }
      
      public function AddEffect(param1:int, param2:int, param3:String, param4:int) : void
      {
         var _loc5_:EffectHero = new EffectHero();
         _loc5_.init(param1,param2,param3,param4);
         addChild(_loc5_);
      }
      
      public function InitTransition() : void
      {
         this._armature.animation.play("Run");
         this._nameAmimation = "Run";
         this._curState = "Run";
      }
      
      public function StartSkill(param1:int) : void
      {
         if(this._curState != "Skill" && this._curState != "Stop")
         {
            this._skillRang = param1;
            this._curState = "Skill";
            this._armature.animation.play("SkillStart");
            this._nameAmimation = "SkillStart";
            this._isAttack = false;
            this._timeAttack = GV.real_time + this._delayAttack * 2;
         }
      }
      
      public function StopSkill() : void
      {
         if(this._curState != "Stop")
         {
            this._curState = "Attack";
         }
         this._armature.animation.play("Wait");
         this._nameAmimation = "Wait";
      }
      
      public function SkillAction() : void
      {
      }
      
      public function SecondSkillAction(param1:int) : void
      {
      }
      
      public function initStop() : void
      {
         this._curState = "Stop";
         this._armature.animation.play("Wait");
         this._nameAmimation = "Wait";
         this.curSpeedX = 0;
      }
      
      public function Jump() : void
      {
         if(Math.random() > 0.7)
         {
            this.curSpeedY = -Amath.random(20,30);
         }
      }
      
      public function InitWait() : void
      {
         this._armature.animation.gotoAndPlayByFrame("Wait",Amath.random(0,10));
         this._nameAmimation = "Wait";
         this._curState = "Wait";
         this.curSpeedX = 0;
      }
      
      public function init_weapon() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Image = null;
         this._idWeapon = GV["her" + this.index][2] - (100 + 100 * this.index);
         if(this._idWeapon < 0)
         {
            this._idWeapon = 0;
         }
         switch(this.index)
         {
            case 0:
               _loc2_ = "Swords/S";
               _loc3_ = "swords";
               break;
            case 1:
               _loc2_ = "Bows/B";
               _loc3_ = "bows";
               break;
            case 2:
               _loc2_ = "Sticks/Ss";
               _loc3_ = "sticks";
         }
         this.crit = GV[_loc3_][this._idWeapon][11];
         var _loc1_:Slot = this._armature.getSlot("Weapon");
         _loc1_.display = new Sprite();
         if(this._idWeapon == 0)
         {
            _loc4_ = GV.factory.getTextureDisplay(_loc2_ + 0 + "_","Warriors") as Image;
            _loc4_.x = 2;
            _loc4_.y = 2;
            _loc1_.display.addChild(_loc4_);
         }
         else
         {
            _loc4_ = GV.factory.getTextureDisplay(_loc2_ + GV[_loc3_][this._idWeapon][1] + "_","Warriors") as Image;
            _loc4_.x = GV[_loc3_][this._idWeapon][2];
            _loc4_.y = GV[_loc3_][this._idWeapon][3];
            _loc1_.display.addChild(_loc4_);
            if(GV[_loc3_][this._idWeapon][4] != 0)
            {
               GV.LM._tMenu.CreateSpell(this.index,GV[_loc3_][this._idWeapon][4]);
            }
            if(GV[_loc3_][this._idWeapon][5] != 0)
            {
               GV.LM._tMenu.CreateSpell(this.index,GV[_loc3_][this._idWeapon][5]);
            }
         }
         if(GV[_loc3_][this._idWeapon][12] != 0)
         {
            GV.factorExp[this.index] = GV.factorExp[this.index] + GV[_loc3_][this._idWeapon][12] / 100;
         }
         if(GV[_loc3_][this._idWeapon][13] != 0)
         {
            GV.factorCoins = GV.factorCoins + GV[_loc3_][this._idWeapon][13] / 100;
         }
      }
      
      public function init_head() : void
      {
         var _loc2_:String = null;
         var _loc1_:Slot = this._armature.getSlot("Head");
         _loc1_.display = new Sprite();
         this._idHead = GV["her" + this.index][1] - 400;
         if(this._idHead < 0)
         {
            this._idHead = 0;
         }
         switch(this.index)
         {
            case 0:
               _loc2_ = "head0/Kn";
               break;
            case 1:
               _loc2_ = "head1/Hu";
               break;
            case 2:
               _loc2_ = "head2/Mo";
         }
         if(this._idHead == 0)
         {
            this._headImg = GV.factory.getTextureDisplay(_loc2_ + 0 + "_","Warriors") as Image;
            _loc1_.display.addChild(this._headImg);
         }
         else
         {
            this._headImg = GV.factory.getTextureDisplay(_loc2_ + this._idHead + "_","Warriors") as Image;
            this._headImg.x = GV.heads0[this._idHead][2];
            this._headImg.y = GV.heads0[this._idHead][3];
            _loc1_.display.addChild(this._headImg);
         }
         if(GV.heads0[this._idHead][9] != 0)
         {
            GV.factorExp[this.index] = GV.factorExp[this.index] + GV.heads0[this._idHead][9] / 100;
         }
         if(GV.heads0[this._idHead][10] != 0)
         {
            GV.factorCoins = GV.factorCoins + GV.heads0[this._idHead][10] / 100;
         }
      }
      
      public function sound_attack() : void
      {
         GV.sound.sword();
      }
   }
}
