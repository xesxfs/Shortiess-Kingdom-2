package com.mygame.enemies.Forest
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
   
   public class Boss_3 extends EnemyBase
   {
       
      
      public var lifeSprite:Sprite;
      
      public var numExplosions:int = 30;
      
      public var time:int = 0;
      
      public var _isFirst:Boolean = false;
      
      public var fire_time:int = 0;
      
      public function Boss_3()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         index = 17;
         _armature = GV.factory.buildArmature("Anim_6","Forest");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 30;
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
                     _loc2_ = GV.enemiesArr.length - 1;
                     while(_loc2_ >= 0)
                     {
                        GV.enemiesArr[_loc2_]["PhysicalDamage"](9999,false);
                        _loc2_--;
                     }
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
                        if(this._isFirst)
                        {
                           _armature.animation.play("Attack1");
                           _nameAmimation = "Attack1";
                           _timeReturn = 0;
                           this._isFirst = false;
                        }
                        else
                        {
                           if(GV.enemiesArr.length < 3)
                           {
                              _armature.animation.play("Attack2");
                              _nameAmimation = "Attack2";
                              this._isFirst = true;
                           }
                           else
                           {
                              _armature.animation.play("Attack1");
                              _nameAmimation = "Attack1";
                           }
                           _timeReturn = 0;
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
                     if(_nameAmimation != "Run")
                     {
                        _armature.animation.play("Run");
                        _nameAmimation = "Run";
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
                     if(_nameAmimation != "Run")
                     {
                        _armature.animation.play("Run");
                        _nameAmimation = "Run";
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
               if(_timeReturn < GV.real_time && _isComleteAttack && _nameAmimation != "Return")
               {
                  if(this._isFirst)
                  {
                     _armature.animation.play("Return2");
                     _nameAmimation = "Return";
                  }
                  else
                  {
                     _armature.animation.play("Return1");
                     _nameAmimation = "Return";
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
      
      override public function _animationHandler(param1:StarlingEvent) : void
      {
         var _loc2_:En_31 = null;
         var _loc3_:int = 0;
         switch(_nameAmimation)
         {
            case "Run":
               _armature.animation.play("Run");
               break;
            case "Wait":
               _armature.animation.play("Wait");
               break;
            case "Attack1":
               _isComleteAttack = true;
               _loc3_ = GV.heroesArr.length - 1;
               while(_loc3_ >= 0)
               {
                  en = GV.heroesArr[_loc3_];
                  if(x - attX < en.x)
                  {
                     GV.heroesArr[_loc3_]["punch"](30 + Amath.random(10,20));
                     GV.heroesArr[_loc3_]["PhysicalDamage"](attackPower + Amath.random(-attackPower * 0.2,attackPower * 0.2));
                  }
                  _loc3_--;
               }
               break;
            case "Attack2":
               _loc2_ = new En_31();
               _loc2_.init(this.x - GV.scr_X);
               _loc2_._curState = "Attack";
               _isComleteAttack = true;
               break;
            case "Return":
               _isAttack = false;
               _armature.animation.play("Wait");
               _nameAmimation = "Wait";
               _timeAttack = GV.real_time + _delayAttack;
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
         var _loc1_:int = GV.heroesArr.length - 1;
         while(_loc1_ >= 0)
         {
            en = GV.heroesArr[_loc1_];
            if(attackbox.intersects(en["hitbox"]))
            {
               GV.heroesArr[_loc1_]["punch"](30 + Amath.random(0,30));
               GV.heroesArr[_loc1_]["PhysicalDamage"](attackPower * 2);
            }
            _loc1_--;
         }
         GV.game.shake();
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
