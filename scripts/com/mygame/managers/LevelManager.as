package com.mygame.managers
{
   import com.mygame.enemies.Black.Boss_5;
   import com.mygame.enemies.Black.En_51;
   import com.mygame.enemies.Black.En_52;
   import com.mygame.enemies.Black.En_53;
   import com.mygame.enemies.Black.En_54;
   import com.mygame.enemies.Black.En_55;
   import com.mygame.enemies.Cage;
   import com.mygame.enemies.EnemyBase;
   import com.mygame.enemies.Forest.Boss_3;
   import com.mygame.enemies.Forest.En_31;
   import com.mygame.enemies.Forest.En_32;
   import com.mygame.enemies.Forest.En_33;
   import com.mygame.enemies.Forest.En_34;
   import com.mygame.enemies.Forest.En_35;
   import com.mygame.enemies.Lair.Boss_4;
   import com.mygame.enemies.Lair.En_41;
   import com.mygame.enemies.Lair.En_42;
   import com.mygame.enemies.Lair.En_43;
   import com.mygame.enemies.Lair.En_44;
   import com.mygame.enemies.Lair.En_45;
   import com.mygame.enemies.desert.Boss_2;
   import com.mygame.enemies.desert.En_21;
   import com.mygame.enemies.desert.En_22;
   import com.mygame.enemies.desert.En_23;
   import com.mygame.enemies.desert.En_24;
   import com.mygame.enemies.desert.En_25;
   import com.mygame.enemies.swamp.Boss_1;
   import com.mygame.enemies.swamp.En_11;
   import com.mygame.enemies.swamp.En_12;
   import com.mygame.enemies.swamp.En_13;
   import com.mygame.enemies.swamp.En_14;
   import com.mygame.enemies.swamp.En_15;
   import com.mygame.heroes.HeroBase;
   import com.mygame.heroes.mHunter;
   import com.mygame.heroes.mKnight;
   import com.mygame.heroes.mMonk;
   import com.mygame.screens.TopMenu;
   
   public class LevelManager
   {
       
      
      public var _maxWave:int;
      
      public var _curWave:int;
      
      public var _isState:String = "";
      
      public var _transition_time:int = 0;
      
      public var countEnemy:int;
      
      public var delay:int;
      
      public var distX:Number;
      
      public var stepX:int;
      
      public var _tMenu:TopMenu;
      
      public var lvl_0:Array;
      
      public var lvl_1:Array;
      
      public var lvl_2:Array;
      
      public var lvl_3:Array;
      
      public var lvl_4:Array;
      
      public var lvl_5:Array;
      
      public var lvl_6:Array;
      
      public var lvl_7:Array;
      
      public var lvl_8:Array;
      
      public var lvl_9:Array;
      
      public var lvl_10:Array;
      
      public var lvl_11:Array;
      
      public var lvl_12:Array;
      
      public var lvl_13:Array;
      
      public var lvl_14:Array;
      
      public var lvl_15:Array;
      
      public var lvl_16:Array;
      
      public var lvl_17:Array;
      
      public var lvl_18:Array;
      
      public var lvl_19:Array;
      
      public var lvl_20:Array;
      
      public var lvl_21:Array;
      
      public var lvl_22:Array;
      
      public var lvl_23:Array;
      
      public var lvl_24:Array;
      
      public var lvl_25:Array;
      
      public var lvl_26:Array;
      
      public var lvl_27:Array;
      
      public var lvl_28:Array;
      
      public var lvl_29:Array;
      
      public var lvl_30:Array;
      
      public var lvl_31:Array;
      
      public var lvl_32:Array;
      
      public var lvl_33:Array;
      
      public var lvl_34:Array;
      
      public var lvl_35:Array;
      
      public var lvl_36:Array;
      
      public var lvl_37:Array;
      
      public var lvl_38:Array;
      
      public var lvl_39:Array;
      
      public function LevelManager()
      {
         this.lvl_0 = [1,[1,0,0,0,0,0,0,0,0,0]];
         this.lvl_1 = [1,[1,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0,0,0]];
         this.lvl_2 = [1,[9,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0,0]];
         this.lvl_3 = [2,[1,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0,0]];
         this.lvl_4 = [2,[1,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,1,0,0,0,0],[2,0,0,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0,0]];
         this.lvl_5 = [2,[9,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,0,1,0,0,0],[2,0,0,0,0,0,0,0,0,0],[2,1,0,0,0,0,0,0,0,0],[2,2,0,1,1,0,0,0,0,0]];
         this.lvl_6 = [3,[1,0,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0,0]];
         this.lvl_7 = [3,[1,0,0,0,0,0,0,0,0,0],[2,1,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0,0],[2,2,0,0,0,0,0,0,0,0]];
         this.lvl_8 = [3,[1,1,0,0,0,0,0,0,0,0],[2,1,0,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0,0],[2,1,0,0,0,0,0,0,0,0]];
         this.lvl_9 = [4,[1,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0,0,0]];
         this.lvl_10 = [4,[2,0,0,0,0,0,0,0,0,0],[2,0,0,1,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0,0],[1,0,0,1,0,0,0,0,0,0]];
         this.lvl_11 = [4,[1,0,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0,0],[1,0,1,0,1,0,1,0,0,0]];
         this.lvl_12 = [5,[2,0,0,0,0,0,0,0,0,0],[1,1,1,0,0,0,0,0,0,0]];
         this.lvl_13 = [5,[2,0,0,0,0,0,0,0,0,0],[2,0,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,1,0,0,0]];
         this.lvl_14 = [5,[1,1,1,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0,0]];
         this.lvl_15 = [1,[2,2,0,0,0,0,0,0,0,0],[3,0,0,0,0,0,0,0,0,0],[3,2,2,0,0,0,0,0,0,0],[3,0,0,0,0,0,1,0,0,1]];
         this.lvl_16 = [1,[2,0,0,0,0,0,0,0,0,0],[3,2,0,0,0,0,0,0,0,0],[3,3,0,0,4,0,0,0,0,0],[3,1,0,0,0,0,0,0,0,0],[3,1,1,1,0,0,0,0,0,0]];
         this.lvl_17 = [1,[3,0,0,0,0,0,0,0,0,0],[2,2,4,0,0,0,0,0,0,0],[3,3,2,0,0,0,0,0,0,0],[5,0,0,0,4,0,0,0,0,0],[3,0,0,0,4,0,0,0,0,0]];
         this.lvl_18 = [1,[5,0,0,0,0,0,0,0,0,0],[2,2,0,3,3,0,0,0,0,0],[5,2,2,2,0,0,0,0,0,0],[5,5,0,0,0,0,0,0,0,0],[3,3,0,4,0,4,0,0,0,0]];
         this.lvl_19 = [1,[6,0,0,0,0,0,0,0,0,0]];
         this.lvl_20 = [2,[2,2,0,0,0,0,0,0,0,0],[3,0,0,0,0,0,0,0,0,0],[3,2,2,0,0,0,0,0,0,0],[3,0,0,0,0,0,1,0,0,1]];
         this.lvl_21 = [2,[2,0,0,0,0,0,0,0,0,0],[3,2,0,0,0,0,0,0,0,0],[3,3,0,0,4,0,0,0,0,0],[3,1,0,0,0,0,0,0,0,0],[3,1,1,1,0,0,0,0,0,0]];
         this.lvl_22 = [2,[3,0,0,0,0,0,0,0,0,0],[2,2,4,0,0,0,0,0,0,0],[3,3,2,0,0,0,0,0,0,0],[5,0,0,0,4,0,0,0,0,0],[3,0,0,0,4,0,0,0,0,0]];
         this.lvl_23 = [2,[5,0,0,0,0,0,0,0,0,0],[2,2,0,3,3,0,0,0,0,0],[5,2,2,2,0,0,0,0,0,0],[5,5,0,0,0,0,0,0,0,0],[3,3,0,4,0,4,0,0,0,0]];
         this.lvl_24 = [2,[6,0,0,0,0,0,0,0,0,0]];
         this.lvl_25 = [3,[2,2,0,0,0,0,0,0,0,0],[3,2,0,0,0,0,0,0,0,0],[3,2,2,0,0,0,0,0,0,0],[3,4,0,0,0,0,0,0,0,0]];
         this.lvl_26 = [3,[2,0,0,0,0,0,0,0,0,0],[0,2,0,0,0,0,0,3,0,0],[0,4,0,0,4,0,0,0,0,0],[0,1,4,0,0,0,0,3,0,0],[0,1,1,1,0,0,0,0,0,0]];
         this.lvl_27 = [3,[3,0,0,0,0,0,0,0,0,0],[2,2,4,0,0,0,0,0,0,0],[3,0,2,0,5,0,0,0,0,0],[4,0,0,0,4,0,0,0,0,0],[3,0,0,0,4,0,0,0,0,0]];
         this.lvl_28 = [3,[5,0,0,0,0,0,0,0,0,0],[2,2,0,0,5,0,0,0,0,3],[5,2,2,2,0,0,0,0,0,0],[5,5,0,0,0,0,0,0,0,0],[5,0,0,4,0,4,0,3,0,0]];
         this.lvl_29 = [3,[6,0,0,0,0,0,0,0,0,0]];
         this.lvl_30 = [4,[2,2,0,0,0,0,0,0,0,0],[3,0,0,0,0,0,0,0,0,0],[3,2,2,0,0,0,0,0,0,0],[3,0,0,0,0,0,1,0,0,1]];
         this.lvl_31 = [4,[2,0,0,0,0,0,0,0,0,0],[3,2,0,0,0,0,0,0,0,0],[3,3,0,0,4,0,0,0,0,0],[3,1,0,0,0,0,0,0,0,0],[3,1,1,1,0,0,0,0,0,0]];
         this.lvl_32 = [4,[3,0,0,0,0,0,0,0,0,0],[2,2,4,0,0,0,0,0,0,0],[3,3,2,0,0,0,0,0,0,0],[5,0,0,0,4,0,0,0,0,0],[3,0,0,0,4,0,0,0,0,0]];
         this.lvl_33 = [4,[5,0,0,0,0,0,0,0,0,0],[2,2,0,3,3,0,0,0,0,0],[5,2,2,2,0,0,0,0,0,0],[5,5,0,0,0,0,0,0,0,0],[3,3,0,4,0,4,0,0,0,0]];
         this.lvl_34 = [4,[6,0,0,0,0,0,0,0,0,0]];
         this.lvl_35 = [5,[2,2,0,0,0,0,0,0,0,0],[3,0,0,0,0,0,0,0,0,0],[3,2,2,0,0,0,0,0,0,0],[3,0,0,0,0,0,1,0,0,1]];
         this.lvl_36 = [5,[2,0,0,0,0,0,0,0,0,0],[3,2,0,0,0,0,0,0,0,0],[3,3,0,0,4,0,0,0,0,0],[3,1,0,0,0,0,0,0,0,0],[3,1,1,1,0,0,0,0,0,0]];
         this.lvl_37 = [5,[3,0,0,0,0,0,0,0,0,0],[2,2,4,0,0,0,0,0,0,0],[3,3,2,0,0,0,0,0,0,0],[5,0,0,0,4,0,0,0,0,0],[3,0,0,0,4,0,0,0,0,0]];
         this.lvl_38 = [5,[5,0,0,0,0,0,0,0,0,0],[2,2,0,3,3,0,0,0,0,0],[5,2,2,2,0,0,0,0,0,0],[5,5,0,0,0,0,0,0,0,0],[3,3,0,4,0,4,0,0,0,0]];
         this.lvl_39 = [5,[6,0,0,0,0,0,0,0,0,0]];
         super();
         this._tMenu = new TopMenu();
         GV.game.addChild(this._tMenu);
      }
      
      public function init_level() : void
      {
         var _loc2_:HeroBase = null;
         var _loc1_:int = 2;
         while(_loc1_ >= 0)
         {
            if(GV["her" + _loc1_][0] > 0)
            {
               switch(_loc1_)
               {
                  case 0:
                     _loc2_ = new mKnight();
                     break;
                  case 1:
                     _loc2_ = new mHunter();
                     break;
                  case 2:
                     _loc2_ = new mMonk();
               }
            }
            _loc1_--;
         }
         GV.location = this["lvl_" + GV.level][0];
         GV.game.BM.init_level(GV.location);
         this._maxWave = this["lvl_" + GV.level].length - 1;
         this._curWave = 0;
         this.stepX = GV.cent_X / 10 - 2;
         this._tMenu.init_level(this._maxWave);
         this._tMenu.visible = true;
         this.delay = 0;
         this.init_transition();
      }
      
      public function free_level() : void
      {
         this._tMenu.free_level();
      }
      
      public function init_transition() : void
      {
         var _loc1_:int = 0;
         if(this._curWave < this._maxWave)
         {
            this._curWave++;
            this._tMenu.next_skull(this._curWave);
            this.countEnemy = 0;
            this._isState = "create_enemies";
         }
         else
         {
            this._curWave++;
            this._tMenu.next_skull(this._curWave);
            _loc1_ = GV.heroesArr.length - 1;
            while(_loc1_ >= 0)
            {
               GV.heroesArr[_loc1_].InitTransition();
               _loc1_--;
            }
            GV.game.SM.open_screen("Victory");
            this._isState = "Stop";
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         this._tMenu.update();
         switch(this._isState)
         {
            case "release":
               break;
            case "create_enemies":
               if(this.delay < GV.real_time)
               {
                  if(this.countEnemy < 10)
                  {
                     if(this["lvl_" + GV.level][this._curWave][this.countEnemy] != 0)
                     {
                        this.create_enemy(this["lvl_" + GV.level][this._curWave][this.countEnemy],-GV.game._stage.x + GV.cent_X + this.countEnemy * this.stepX);
                     }
                     this.delay = GV.real_time + 100;
                     this.countEnemy++;
                     break;
                  }
                  this._tMenu.activation();
                  _loc1_ = GV.enemiesArr.length - 1;
                  while(_loc1_ >= 0)
                  {
                     GV.enemiesArr[_loc1_]._curState = "Attack";
                     _loc1_--;
                  }
                  _loc1_ = GV.heroesArr.length - 1;
                  while(_loc1_ >= 0)
                  {
                     GV.heroesArr[_loc1_]._curState = "Attack";
                     GV.heroesArr[_loc1_]._isAttack = false;
                     _loc1_--;
                  }
                  this._isState = "Battle";
                  break;
               }
               break;
            case "release_enemy":
               break;
            case "Battle":
               if(GV.enemiesArr.length == 0)
               {
                  this.init_transition();
                  return;
               }
               if(GV.heroesArr.length == 0)
               {
                  _loc1_ = GV.enemiesArr.length - 1;
                  while(_loc1_ >= 0)
                  {
                     GV.enemiesArr[_loc1_].InitTransition();
                     _loc1_--;
                  }
                  GV.game.SM.open_screen("Fail");
                  this._isState = "Fail";
                  return;
               }
               break;
            case "End":
               break;
            case "Fail":
               GV.camPos = GV.camPos - 5;
         }
      }
      
      private function create_enemy(param1:int, param2:int) : *
      {
         var _loc3_:EnemyBase = null;
         loop0:
         switch(GV.location)
         {
            case 1:
               switch(param1)
               {
                  case 1:
                     _loc3_ = new En_11();
                     break loop0;
                  case 2:
                     _loc3_ = new En_12();
                     break loop0;
                  case 3:
                     _loc3_ = new En_13();
                     break loop0;
                  case 4:
                     _loc3_ = new En_14();
                     break loop0;
                  case 5:
                     _loc3_ = new En_15();
                     break loop0;
                  case 6:
                     _loc3_ = new Boss_1();
                     break loop0;
                  case 9:
                     if(GV["her" + 1][0] == 0)
                     {
                        _loc3_ = new Cage();
                        _loc3_["t"] = 1;
                        break loop0;
                     }
                     break loop0;
                  default:
                     break loop0;
               }
            case 2:
               switch(param1)
               {
                  case 1:
                     _loc3_ = new En_21();
                     break loop0;
                  case 2:
                     _loc3_ = new En_22();
                     break loop0;
                  case 3:
                     _loc3_ = new En_23();
                     break loop0;
                  case 4:
                     _loc3_ = new En_24();
                     break loop0;
                  case 5:
                     _loc3_ = new En_25();
                     break loop0;
                  case 6:
                     _loc3_ = new Boss_2();
                     break loop0;
                  case 9:
                     if(GV["her" + 2][0] == 0)
                     {
                        _loc3_ = new Cage();
                        _loc3_["t"] = 2;
                        break loop0;
                     }
                     break loop0;
                  default:
                     break loop0;
               }
            case 3:
               switch(param1)
               {
                  case 1:
                     _loc3_ = new En_31();
                     break loop0;
                  case 2:
                     _loc3_ = new En_32();
                     break loop0;
                  case 3:
                     _loc3_ = new En_33();
                     break loop0;
                  case 4:
                     _loc3_ = new En_34();
                     break loop0;
                  case 5:
                     _loc3_ = new En_35();
                     break loop0;
                  case 6:
                     _loc3_ = new Boss_3();
                     break loop0;
                  default:
                     break loop0;
               }
            case 4:
               switch(param1)
               {
                  case 1:
                     _loc3_ = new En_41();
                     break loop0;
                  case 2:
                     _loc3_ = new En_42();
                     break loop0;
                  case 3:
                     _loc3_ = new En_43();
                     break loop0;
                  case 4:
                     _loc3_ = new En_44();
                     break loop0;
                  case 5:
                     _loc3_ = new En_45();
                     break loop0;
                  case 6:
                     _loc3_ = new Boss_4();
                     break loop0;
                  default:
                     break loop0;
               }
            case 5:
               switch(param1)
               {
                  case 1:
                     _loc3_ = new En_51();
                     break loop0;
                  case 2:
                     _loc3_ = new En_52();
                     break loop0;
                  case 3:
                     _loc3_ = new En_53();
                     break loop0;
                  case 4:
                     _loc3_ = new En_54();
                     break loop0;
                  case 5:
                     _loc3_ = new En_55();
                     break loop0;
                  case 6:
                     _loc3_ = new Boss_5();
                     break loop0;
                  default:
                     break loop0;
               }
         }
         if(_loc3_)
         {
            _loc3_.init(param2);
         }
      }
   }
}
