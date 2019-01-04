package com.mygame.screens.armory
{
   import caurina.transitions.Tweener;
   import com.general.Calc;
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.animation.WorldClock;
   import dragonBones.starling.StarlingArmatureDisplay;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class HeroField extends Sprite
   {
       
      
      public var _index:int;
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      private var _back:Image;
      
      private var _spell1:Image;
      
      private var _spell2:Image;
      
      private var _nameTxt:TextField;
      
      public var _cell_1:HeroCell;
      
      public var _cell_2:HeroCell;
      
      private var _stat_1_Txt:TextField;
      
      private var _stat_2_Txt:TextField;
      
      private var _stat_3_Txt:TextField;
      
      private var _stat_4_Txt:TextField;
      
      private var _weaponSprite:Sprite;
      
      private var _weaponImg:Image;
      
      private var _headSprite:Sprite;
      
      private var _headImg:Image;
      
      private var level:int;
      
      public function HeroField()
      {
         this._weaponSprite = new Sprite();
         this._headSprite = new Sprite();
         super();
      }
      
      public function Init(param1:int) : *
      {
         var _loc2_:TextField = null;
         var _loc6_:Cell = null;
         this._index = param1;
         this.level = GV["her" + param1][0];
         this._back = new Image(GV.assets.getTexture("HeroField0000"));
         this._back.x = -110;
         addChild(this._back);
         this._back.touchable = false;
         _loc2_ = new TextField(50,50,this.level + "",new TextFormat("NormalТNum",35,16777215,Align.CENTER,Align.CENTER));
         _loc2_.x = -92;
         _loc2_.y = 0;
         addChild(_loc2_);
         _loc2_.touchable = false;
         this._nameTxt = new TextField(100,40,"Knight",new TextFormat("PORT",20,16777215,Align.CENTER));
         this._nameTxt.x = -30;
         this._nameTxt.y = 0;
         addChild(this._nameTxt);
         this._nameTxt.touchable = false;
         this._cell_1 = new HeroCell();
         addChild(this._cell_1);
         this._cell_1.init(47,70,0,this._index);
         this._cell_2 = new HeroCell();
         addChild(this._cell_2);
         this._cell_2.init(this._cell_1.x,this._cell_1.y + 100 - 29,1,this._index);
         var _loc3_:int = GV["her" + this._index][1];
         if(_loc3_ > 0)
         {
            _loc6_ = new Cell(_loc3_,this._cell_1.x,this._cell_1.y,this._index);
            addChild(_loc6_);
         }
         _loc3_ = GV["her" + this._index][2];
         if(_loc3_ > 0)
         {
            _loc6_ = new Cell(_loc3_,this._cell_2.x,this._cell_2.y,this._index);
            addChild(_loc6_);
         }
         this._spell1 = new Image(GV.assets.getTexture("Spell00_0000"));
         this._spell1.x = 33;
         this._spell1.y = 190;
         this._spell1.scale = 0.7;
         addChild(this._spell1);
         this._spell1.touchable = false;
         this._spell2 = new Image(GV.assets.getTexture("Spell00_0000"));
         this._spell2.x = this._spell1.x;
         this._spell2.y = this._spell1.y + 56;
         this._spell2.scale = 0.7;
         addChild(this._spell2);
         this._spell2.touchable = false;
         this._stat_1_Txt = new TextField(200,40,"00000",new TextFormat("PORT",15,15182188,Align.LEFT));
         this._stat_1_Txt.x = 55 - 120;
         this._stat_1_Txt.y = 190;
         addChild(this._stat_1_Txt);
         this._stat_1_Txt.touchable = false;
         this._stat_2_Txt = new TextField(200,40,"00000",new TextFormat("PORT",15,15182188,Align.LEFT));
         this._stat_2_Txt.x = this._stat_1_Txt.x;
         this._stat_2_Txt.y = this._stat_1_Txt.y + 25;
         addChild(this._stat_2_Txt);
         this._stat_2_Txt.touchable = false;
         this._stat_3_Txt = new TextField(200,40,"00000",new TextFormat("PORT",15,15182188,Align.LEFT));
         this._stat_3_Txt.x = this._stat_1_Txt.x;
         this._stat_3_Txt.y = this._stat_1_Txt.y + 25 * 2;
         addChild(this._stat_3_Txt);
         this._stat_3_Txt.touchable = false;
         this._stat_4_Txt = new TextField(200,40,"00000",new TextFormat("PORT",15,15182188,Align.LEFT));
         this._stat_4_Txt.x = this._stat_1_Txt.x;
         this._stat_4_Txt.y = this._stat_1_Txt.y + 25 * 3;
         addChild(this._stat_4_Txt);
         this._stat_4_Txt.touchable = false;
         switch(this._index)
         {
            case 0:
               this._armature = GV.factory.buildArmature("Khight_0_Anim");
               this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
               this._nameTxt.text = "Knight";
               break;
            case 1:
               this._armature = GV.factory.buildArmature("Hunter_0_Anim");
               this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
               this._nameTxt.text = "Hunter";
               break;
            case 2:
               this._armature = GV.factory.buildArmature("MonkAnim");
               this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
               this._nameTxt.text = "Monk";
         }
         var _loc4_:Slot = this._armature.getSlot("Weapon");
         _loc4_.display = this._weaponSprite;
         var _loc5_:Slot = this._armature.getSlot("Head");
         _loc5_.display = this._headSprite;
         this._armature.animation.play("Wait",999999);
         this._armature.animation.timeScale = 0.5;
         this._armatureDisplay.x = 75 - 125;
         this._armatureDisplay.y = 162;
         WorldClock.clock.add(this._armature);
         addChild(this._armatureDisplay);
         this._armatureDisplay.touchable = false;
         this.ChangeSkin();
      }
      
      public function Free() : *
      {
      }
      
      public function Close() : *
      {
         if(scaleX != 0)
         {
            Tweener.addTween(this,{
               "scaleX":0,
               "time":0.2,
               "transition":"linear"
            });
         }
      }
      
      public function Open() : *
      {
         Tweener.addTween(this,{
            "scaleX":1,
            "time":0.2,
            "delay":0.2,
            "transition":"linear",
            "onComplete":parent["Stop_transition"]
         });
      }
      
      public function ChangeSkin() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Image = null;
         var _loc3_:int = 0;
         if(this._weaponSprite)
         {
            this._weaponSprite.removeChildren();
         }
         if(this._headSprite)
         {
            this._headSprite.removeChildren();
         }
         switch(this._index)
         {
            case 0:
               if(GV.her0[2] == 0)
               {
                  _loc1_ = 0;
                  _loc2_ = GV.factory.getTextureDisplay("Swords/S" + 0 + "_","Warriors") as Image;
                  _loc2_.x = 2;
                  _loc2_.y = 2;
                  this._weaponSprite.addChild(_loc2_);
                  this._spell1.texture = GV.assets.getTexture("Spell00_0000");
                  this._spell2.texture = GV.assets.getTexture("Spell00_0000");
               }
               else
               {
                  _loc1_ = GV.her0[2] - 100;
                  _loc2_ = GV.factory.getTextureDisplay("Swords/S" + GV.swords[GV.her0[2] - 100][1] + "_","Warriors") as Image;
                  _loc2_.x = GV.swords[_loc1_][2];
                  _loc2_.y = GV.swords[_loc1_][3];
                  this._weaponSprite.addChild(_loc2_);
                  this._spell1.texture = GV.assets.getTexture("Spell0" + GV.swords[_loc1_][4] + "_0000");
                  this._spell2.texture = GV.assets.getTexture("Spell0" + GV.swords[_loc1_][5] + "_0000");
               }
               if(GV.her0[1] == 0)
               {
                  _loc3_ = 0;
                  _loc2_ = GV.factory.getTextureDisplay("head0/Kn" + 0 + "_","Warriors") as Image;
                  this._headSprite.addChild(_loc2_);
               }
               else
               {
                  _loc3_ = GV.her0[1] - 400;
                  _loc2_ = GV.factory.getTextureDisplay("head0/Kn" + _loc3_ + "_","Warriors") as Image;
                  _loc2_.x = GV.heads0[_loc3_][2];
                  _loc2_.y = GV.heads0[_loc3_][3];
                  this._headSprite.addChild(_loc2_);
               }
               this._stat_1_Txt.text = "" + int(Calc.knight_hp(this.level) / 10);
               if(GV.heads0[_loc3_][4] != 0)
               {
                  this._stat_1_Txt.text = this._stat_1_Txt.text + ("+" + int(Calc.knight_hp_extra(this.level,_loc3_) / 10) + "");
               }
               this._stat_2_Txt.text = "" + int(Calc.knight_power(this.level) / 10);
               if(GV.swords[_loc1_][9] != 0)
               {
                  this._stat_2_Txt.text = this._stat_2_Txt.text + ("(+" + int(Calc.sword_power(this.level,_loc1_) / 10) + ")");
               }
               if(GV.heads0[_loc3_][5] != 0)
               {
                  this._stat_2_Txt.text = this._stat_2_Txt.text + ("(+" + int(Calc.knight_power(this.level) * GV.heads0[_loc3_][5] / 1000) + ")");
               }
               if(GV.swords[_loc1_][11] != 0)
               {
                  this._stat_3_Txt.text = int(GV.swords[_loc1_][11] * 100) + "%";
               }
               if(GV.swords[_loc1_][11] == 0)
               {
                  this._stat_3_Txt.text = "-";
               }
               if(GV.heads0[_loc3_][11] != 0)
               {
                  this._stat_4_Txt.text = "+" + int(GV.heads0[_loc3_][11]) + "%";
               }
               if(GV.heads0[_loc3_][11] == 0)
               {
                  this._stat_4_Txt.text = "-";
                  break;
               }
               break;
            case 1:
               if(GV.her1[2] == 0)
               {
                  _loc1_ = 0;
                  _loc2_ = GV.factory.getTextureDisplay("Bows/B" + 0 + "_","Warriors") as Image;
                  this._weaponSprite.addChild(_loc2_);
                  this._spell1.texture = GV.assets.getTexture("Spell10_0000");
                  this._spell2.texture = GV.assets.getTexture("Spell10_0000");
               }
               else
               {
                  _loc1_ = GV.her1[2] - 200;
                  _loc2_ = GV.factory.getTextureDisplay("Bows/B" + GV.bows[_loc1_][1] + "_","Warriors") as Image;
                  _loc2_.x = GV.bows[_loc1_][2];
                  _loc2_.y = GV.bows[_loc1_][3];
                  this._weaponSprite.addChild(_loc2_);
                  this._spell1.texture = GV.assets.getTexture("Spell1" + GV.bows[_loc1_][4] + "_0000");
                  this._spell2.texture = GV.assets.getTexture("Spell1" + GV.bows[_loc1_][5] + "_0000");
               }
               if(GV.her1[1] == 0)
               {
                  _loc3_ = 0;
                  _loc2_ = GV.factory.getTextureDisplay("head1/Hu" + 0 + "_","Warriors") as Image;
                  this._headSprite.addChild(_loc2_);
               }
               else
               {
                  _loc3_ = GV.her1[1] - 400;
                  _loc2_ = GV.factory.getTextureDisplay("head1/Hu" + _loc3_ + "_","Warriors") as Image;
                  _loc2_.x = GV.heads0[_loc3_][2] - 3;
                  _loc2_.y = GV.heads0[_loc3_][3];
                  this._headSprite.addChild(_loc2_);
               }
               this._stat_1_Txt.text = "" + int(Calc.hunter_hp(this.level) / 10);
               if(GV.heads0[_loc3_][4] != 0)
               {
                  this._stat_1_Txt.text = this._stat_1_Txt.text + ("(+" + int(Calc.hunter_hp_extra(this.level,_loc3_) / 10) + ")");
               }
               this._stat_2_Txt.text = "" + Calc.hunter_power(this.level);
               if(GV.swords[_loc1_][9] != 0)
               {
                  this._stat_2_Txt.text = this._stat_2_Txt.text + ("(+" + int(Calc.bow_power(this.level,_loc1_) / 10) + ")");
               }
               if(GV.heads0[_loc3_][5] != 0)
               {
                  this._stat_2_Txt.text = this._stat_2_Txt.text + ("(+" + int(Calc.hunter_power(this.level) * GV.heads0[_loc3_][5] / 1000) + ")");
               }
               if(GV.bows[_loc1_][11] != 0)
               {
                  this._stat_3_Txt.text = int(GV.bows[_loc1_][11] * 100) + "%";
               }
               if(GV.bows[_loc1_][11] == 0)
               {
                  this._stat_3_Txt.text = "-";
               }
               if(GV.heads0[_loc3_][11] != 0)
               {
                  this._stat_4_Txt.text = "+" + int(GV.heads0[_loc3_][11]) + "%";
               }
               if(GV.heads0[_loc3_][11] == 0)
               {
                  this._stat_4_Txt.text = "-";
                  break;
               }
               break;
            case 2:
               if(GV.her2[2] == 0)
               {
                  _loc1_ = 0;
                  _loc2_ = GV.factory.getTextureDisplay("Sticks/Ss" + 0 + "_","Warriors") as Image;
                  _loc2_.x = 2;
                  _loc2_.y = 2;
                  this._weaponSprite.addChild(_loc2_);
                  this._spell1.texture = GV.assets.getTexture("Spell20_0000");
                  this._spell2.texture = GV.assets.getTexture("Spell20_0000");
               }
               else
               {
                  _loc1_ = GV.her2[2] - 300;
                  _loc2_ = GV.factory.getTextureDisplay("Sticks/Ss" + GV.sticks[_loc1_][1] + "_","Warriors") as Image;
                  _loc2_.x = GV.sticks[_loc1_][2];
                  _loc2_.y = GV.sticks[_loc1_][3];
                  this._weaponSprite.addChild(_loc2_);
                  this._spell1.texture = GV.assets.getTexture("Spell2" + GV.sticks[_loc1_][4] + "_0000");
                  this._spell2.texture = GV.assets.getTexture("Spell2" + GV.sticks[_loc1_][5] + "_0000");
               }
               if(GV.her2[1] == 0)
               {
                  _loc3_ = 0;
                  _loc2_ = GV.factory.getTextureDisplay("head2/Mo" + 0 + "_","Warriors") as Image;
                  this._headSprite.addChild(_loc2_);
               }
               else
               {
                  _loc3_ = GV.her2[1] - 400;
                  _loc2_ = GV.factory.getTextureDisplay("head2/Mo" + _loc3_ + "_","Warriors") as Image;
                  _loc2_.x = GV.heads0[_loc3_][2] - 5;
                  _loc2_.y = GV.heads0[_loc3_][3];
                  this._headSprite.addChild(_loc2_);
               }
               this._stat_1_Txt.text = "" + int(Calc.monk_hp(this.level) / 10);
               if(GV.heads0[_loc3_][4] != 0)
               {
                  this._stat_1_Txt.text = this._stat_1_Txt.text + ("(+" + int(Calc.monk_hp_extra(this.level,_loc3_) / 10) + ")");
               }
               this._stat_2_Txt.text = "" + Calc.monk_power(this.level);
               if(GV.sticks[_loc1_][9] != 0)
               {
                  this._stat_2_Txt.text = this._stat_2_Txt.text + ("(+" + int(Calc.stick_power(this.level,_loc1_) / 10) + ")");
               }
               if(GV.heads0[_loc3_][5] != 0)
               {
                  this._stat_2_Txt.text = this._stat_2_Txt.text + ("(+" + int(Calc.monk_power(this.level) * GV.heads0[_loc3_][5] / 1000) + ")");
               }
               if(GV.sticks[_loc1_][11] != 0)
               {
                  this._stat_3_Txt.text = int(GV.sticks[_loc1_][11] * 100) + "%";
               }
               if(GV.sticks[_loc1_][11] == 0)
               {
                  this._stat_3_Txt.text = "-";
               }
               if(GV.heads0[_loc3_][11] != 0)
               {
                  this._stat_4_Txt.text = "+" + int(GV.heads0[_loc3_][11]) + "%";
               }
               if(GV.heads0[_loc3_][11] == 0)
               {
                  this._stat_4_Txt.text = "-";
                  break;
               }
         }
      }
      
      public function CUpdateStats() : *
      {
      }
   }
}
