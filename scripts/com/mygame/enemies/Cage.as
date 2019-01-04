package com.mygame.enemies
{
   import com.general.Amath;
   import com.mygame.effects.GravityObj;
   import com.mygame.heroes.HeroBase;
   import com.mygame.heroes.mHunter;
   import com.mygame.heroes.mMonk;
   import dragonBones.Slot;
   import dragonBones.animation.WorldClock;
   import dragonBones.starling.StarlingArmatureDisplay;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Cage extends EnemyBase
   {
       
      
      public var t:int;
      
      public var _cage:Image;
      
      public var _headImg:Image;
      
      public function Cage()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         var _loc2_:Slot = null;
         var _loc3_:Image = null;
         var _loc4_:Slot = null;
         switch(this.t)
         {
            case 1:
               _armature = GV.factory.buildArmature("Hunter_0_Anim");
               _loc2_ = _armature.getSlot("Weapon");
               _loc2_.display = new Sprite();
               if(GV.her1[2] == 0)
               {
                  _loc3_ = GV.factory.getTextureDisplay("Bows/B" + 0 + "_","Warriors") as Image;
                  _loc2_.display.addChild(_loc3_);
               }
               else
               {
                  _loc3_ = GV.factory.getTextureDisplay("Bows/B" + GV.bows[GV.her1[2] - 200][1] + "_","Warriors") as Image;
                  _loc3_.x = GV.bows[GV.her1[2] - 200][2];
                  _loc3_.y = GV.bows[GV.her1[2] - 200][3];
                  _loc2_.display.addChild(_loc3_);
               }
               _loc4_ = _armature.getSlot("Head");
               _loc4_.display = new Sprite();
               if(GV.her1[1] == 0)
               {
                  this._headImg = GV.factory.getTextureDisplay("head1/Hu" + 0 + "_","Warriors") as Image;
                  _loc4_.display.addChild(this._headImg);
                  break;
               }
               this._headImg = GV.factory.getTextureDisplay("head1/Hu" + (GV.her1[1] - 400) + "_","Warriors") as Image;
               this._headImg.x = GV.heads0[GV.her1[1] - 400][2] - 3;
               this._headImg.y = GV.heads0[GV.her1[1] - 400][3];
               _loc4_.display.addChild(this._headImg);
               break;
            case 2:
               _armature = GV.factory.buildArmature("MonkAnim");
               _loc2_ = _armature.getSlot("Weapon");
               _loc2_.display = new Sprite();
               if(GV.her2[2] == 0)
               {
                  _loc3_ = GV.factory.getTextureDisplay("Sticks/Ss" + 0 + "_","Warriors") as Image;
                  _loc3_.x = 2;
                  _loc3_.y = 2;
                  _loc2_.display.addChild(_loc3_);
               }
               else
               {
                  _loc3_ = GV.factory.getTextureDisplay("Sticks/Ss" + GV.sticks[GV.her2[2] - 300][1] + "_","Warriors") as Image;
                  _loc3_.x = GV.sticks[GV.her2[2] - 300][2];
                  _loc3_.y = GV.sticks[GV.her2[2] - 300][3];
                  _loc2_.display.addChild(_loc3_);
               }
               _loc4_ = _armature.getSlot("Head");
               _loc4_.display = new Sprite();
               if(GV.her2[1] == 0)
               {
                  this._headImg = GV.factory.getTextureDisplay("head2/Mo" + 0 + "_","Warriors") as Image;
                  _loc4_.display.addChild(this._headImg);
                  break;
               }
               this._headImg = GV.factory.getTextureDisplay("head2/Mo" + (GV.her2[1] - 400) + "_","Warriors") as Image;
               this._headImg.x = GV.heads0[GV.her2[1] - 400][2] - 5;
               this._headImg.y = GV.heads0[GV.her2[1] - 400][3];
               _loc4_.display.addChild(this._headImg);
               break;
         }
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.y = 20;
         _armatureDisplay.scaleX = -1;
         curHP = maxHP = 50;
         _delayAttack = 9999999999;
         _delayReturn = 9999999999;
         attackPower = 0;
         maxSpeedX = 0;
         accX = 0;
         hX = -35;
         hY = -50;
         hitbox = new Rectangle(0,0,70,100);
         minX = 80;
         maxX = 100;
         attX = 120;
         super.init(param1);
         create_life(0,-115);
         this._cage = new Image(GV.assets.getTexture("Cage0000"));
         this._cage.x = -60;
         this._cage.y = -90;
         addChild(this._cage);
      }
      
      override public function Attack() : void
      {
      }
      
      override public function free() : *
      {
         var _loc1_:int = 0;
         if(!_isFree)
         {
            WorldClock.clock.remove(_armature);
            removeChild(_armatureDisplay);
            _armatureDisplay = null;
            _armature = null;
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
            this._cage.removeFromParent(true);
            _isFree = true;
         }
      }
      
      override public function update(param1:Number) : *
      {
         var _loc2_:int = 0;
         var _loc3_:GravityObj = null;
         var _loc4_:HeroBase = null;
         hitbox.x = this.x + hX;
         hitbox.y = this.y + hY;
         if(_debugH)
         {
            _debugH.x = hitbox.x;
            _debugH.y = hitbox.y;
         }
         if(curHP <= 0)
         {
            _loc2_ = 5;
            while(_loc2_ > 0)
            {
               _loc3_ = new GravityObj();
               if(Math.random() > 0.5)
               {
                  _loc3_.scaleX = -1;
               }
               _loc3_.init(x + Amath.random(-50,50),y + Amath.random(-50,50),"CagePart" + "0000");
               _loc2_--;
            }
            GV["her" + this.t][0] = 1;
            switch(this.t)
            {
               case 1:
                  _loc4_ = new mHunter();
                  break;
               case 2:
                  _loc4_ = new mMonk();
            }
            _loc4_.x = x;
            this.free();
            return;
         }
         if(x < GV.enPosX)
         {
            GV.enPosX = hitbox.x;
         }
      }
   }
}
