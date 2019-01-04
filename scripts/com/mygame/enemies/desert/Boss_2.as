package com.mygame.enemies.desert
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import com.mygame.effects.Effect;
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class Boss_2 extends EnemyBase
   {
       
      
      public var lifeSprite:Sprite;
      
      public var numExplosions:int = 30;
      
      public var time:int = 0;
      
      public var _isCry:Boolean = false;
      
      public function Boss_2()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 11;
         _armature = GV.factory.buildArmature("enDesert_06","Desert");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = -130;
         _armatureDisplay.x = -130;
         hX = -65;
         hY = -130;
         hitbox = new Rectangle(0,0,Math.abs(hX) * 2,Math.abs(hY) + 30);
         minX = 130;
         maxX = 180;
         attX = 300;
         super.init(param1);
         this.create_life(0,-95);
      }
      
      override public function update(param1:Number) : *
      {
         var _loc2_:int = 0;
         var _loc3_:Effect = null;
         hitbox.x = this.x + hX;
         hitbox.y = this.y + hY;
         if(_debugA)
         {
            _debugA.x = this.x - attX;
            _debugA.y = this.y - 50;
         }
         if(_debugH)
         {
            _debugH.x = hitbox.x;
            _debugH.y = hitbox.y;
         }
         if(x < GV.enPosX)
         {
            GV.enPosX = hitbox.x;
         }
         x = x - curSpeedX * param1;
         if(_isForward == false && curSpeedX > 0)
         {
            curSpeedX = curSpeedX - accX * param1;
         }
         if(_isBack == false && curSpeedX < 0)
         {
            curSpeedX = curSpeedX + accX * param1;
         }
         switch(_curState)
         {
            case "Attack":
               if(!_isAttack)
               {
                  if(curHP <= 0)
                  {
                     _curState = "Die";
                     _armature.animation.play("Die");
                     _nameAmimation = "Die";
                     curSpeedX = 0;
                     GV.sound.playSFX("dieboss");
                     _loc2_ = GV.heroesArr.length - 1;
                     while(_loc2_ >= 0)
                     {
                        GV.heroesArr[_loc2_].InitWait();
                        _loc2_--;
                     }
                     return;
                  }
                  if(x - attX < GV.camPos)
                  {
                     if(_timeAttack < GV.real_time)
                     {
                        _isAttack = true;
                        _isComleteAttack = false;
                        _isForward = false;
                        _isBack = false;
                        if(this._isCry)
                        {
                           _armature.animation.play("Cry");
                           _nameAmimation = "Cry";
                           _timeReturn = GV.real_time + 3000;
                           GV.sound.playSFX("cry");
                        }
                        else
                        {
                           _armature.animation.play("Hit");
                           _nameAmimation = "Hit";
                           _timeReturn = GV.real_time + 1000;
                           GV.sound.playSFX("steel0");
                        }
                        return;
                     }
                  }
                  if(x - maxX > GV.camPos)
                  {
                     _isForward = true;
                     _isBack = false;
                     if(curSpeedX < maxSpeedX)
                     {
                        curSpeedX = curSpeedX + accX * param1;
                     }
                     if(_nameAmimation != "Wait")
                     {
                        _armature.animation.play("Wait");
                        _nameAmimation = "Wait";
                     }
                     return;
                  }
                  if(x + minX > GV.camPos)
                  {
                     _isForward = false;
                     _isBack = true;
                     if(curSpeedX > -maxSpeedX / 2)
                     {
                        curSpeedX = curSpeedX - accX * param1 / 4;
                     }
                     if(_nameAmimation != "Wait")
                     {
                        _armature.animation.play("Wait");
                        _nameAmimation = "Wait";
                     }
                     return;
                  }
                  if(_nameAmimation != "Wait")
                  {
                     curSpeedX = 0;
                     _armature.animation.play("Wait");
                     _nameAmimation = "Wait";
                     break;
                  }
                  break;
               }
               if(curSpeedX > 0)
               {
                  curSpeedX = curSpeedX - accX * param1 * 2;
               }
               if(_timeReturn < GV.real_time && _nameAmimation != "ReturnCry" && _nameAmimation != "ReturnHit")
               {
                  if(this._isCry)
                  {
                     _armature.animation.play("ReturnCry");
                     _nameAmimation = "ReturnCry";
                     this._isCry = false;
                  }
                  else
                  {
                     _armature.animation.play("ReturnHit");
                     _nameAmimation = "ReturnHit";
                     this._isCry = true;
                  }
                  _timeAttack = GV.real_time + _delayAttack;
                  break;
               }
               break;
            case "Run":
               _isForward = true;
               if(curSpeedX < maxSpeedX)
               {
                  curSpeedX = curSpeedX + accX * param1;
                  break;
               }
               break;
            case "Die":
               if(this.time < GV.real_time)
               {
                  this.time = GV.real_time + 200;
                  if(this.numExplosions > 0)
                  {
                     this.numExplosions--;
                     _loc3_ = new Effect();
                     _loc3_.init(Amath.random(hitbox.x,hitbox.x + hitbox.width),Amath.random(hitbox.y,hitbox.y + hitbox.height),"Smoke1_",24);
                     GV.sound.playSFX("explosion");
                     GV.game.shake();
                     break;
                  }
                  GV.freeExp = GV.freeExp + exp;
                  GV.freeCoins = GV.freeCoins + coins;
                  _curState = "Stop";
                  GV.game.SM.open_screen("Victory");
                  break;
               }
         }
      }
      
      override public function InitTransition() : void
      {
         _armature.animation.play("Wait");
         _nameAmimation = "Wait";
         _curState = "Run";
      }
      
      override public function _animationHandler(param1:StarlingEvent) : void
      {
         switch(_nameAmimation)
         {
            case "Cry":
               _armature.animation.play("Sirena",5);
               _nameAmimation = "Sirena";
               break;
            case "Sirena":
               this.Attack2();
               break;
            case "Hit":
               this.Attack();
               break;
            case "ReturnCry":
               _isAttack = false;
               _armature.animation.play("Wait");
               _nameAmimation = "Wait";
               break;
            case "ReturnHit":
               _isAttack = false;
               _armature.animation.play("Wait");
               _nameAmimation = "Wait";
               break;
            case "Run":
               _armature.animation.play("Run");
               break;
            case "Wait":
               _armature.animation.play("Wait");
         }
      }
      
      override public function Jump() : void
      {
      }
      
      override public function punch(param1:Number) : void
      {
      }
      
      override public function Attack() : void
      {
         GV.game.shake();
         var _loc1_:int = GV.heroesArr.length - 1;
         while(_loc1_ >= 0)
         {
            en = GV.heroesArr[_loc1_];
            if(x - attX < en.x)
            {
               GV.heroesArr[_loc1_]["punch"](30 + Amath.random(10,20));
               GV.heroesArr[_loc1_]["PhysicalDamage"](attackPower + Amath.random(-attackPower * 0.2,attackPower * 0.2));
            }
            _loc1_--;
         }
      }
      
      public function Attack2() : void
      {
         var _loc1_:int = GV.heroesArr.length - 1;
         while(_loc1_ >= 0)
         {
            GV.heroesArr[_loc1_]["punch"](20 + Amath.random(0,5));
            GV.heroesArr[_loc1_]["PhysicalDamage"](attackPower / 5);
            _loc1_--;
         }
      }
      
      override public function create_life(param1:int, param2:int) : void
      {
         this.lifeSprite = new Sprite();
         this.lifeSprite.y = -100;
         GV.LM._tMenu.addChild(this.lifeSprite);
         frame = new Image(GV.assets.getTexture("BossFrame0000"));
         frame.x = int(GV.cent_X - frame.width / 2);
         frame.y = 70;
         this.lifeSprite.addChild(frame);
         line = new Quad(220,8,12392709);
         line.x = frame.x + 51;
         line.y = frame.y + 8;
         this.lifeSprite.addChildAt(line,0);
         Tweener.addTween(this.lifeSprite,{
            "y":0,
            "time":0.5,
            "transition":"linear"
         });
      }
   }
}
