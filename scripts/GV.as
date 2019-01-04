package
{
   import com.Game;
   import com.Main;
   import com.general.MySaveGame;
   import com.general.MySound;
   import com.mygame.managers.LevelManager;
   import dragonBones.starling.StarlingFactory;
   import starling.animation.Juggler;
   import starling.core.Starling;
   import starling.utils.AssetManager;
   
   public class GV
   {
      
      public static var debug:Boolean = false;
      
      public static var isWEB:Boolean = true;
      
      public static var main:Main;
      
      public static var game:Game;
      
      public static var _width:int = 760;
      
      public static var _height:int = 500;
      
      public static var scr_X:int;
      
      public static var scr_Y:int;
      
      public static var cent_X:int;
      
      public static var cent_Y:int;
      
      public static var dX:int = 0;
      
      public static var dY:int = 0;
      
      public static var assets:AssetManager;
      
      public static var starling:Starling;
      
      public static var juggler:Juggler;
      
      public static var factory:StarlingFactory = new StarlingFactory();
      
      public static var real_time:int = 0;
      
      public static var start_time:int = 0;
      
      public static var delta:int = 0;
      
      public static var touchX:int = 0;
      
      public static var touchY:int = 0;
      
      public static var groundY:int = 0;
      
      public static var isPlay:Boolean = false;
      
      public static var isTouch:Boolean = false;
      
      public static var sound:MySound = MySound.getInstance();
      
      public static var save:MySaveGame = MySaveGame.getInstance();
      
      public static var LM:LevelManager;
      
      public static var settings = [8,8,1];
      
      public static var _cur_level = 0;
      
      public static var level:int = 0;
      
      public static var location:int = 0;
      
      public static var episode:int = 6;
      
      public static var camPos:int = 0;
      
      public static var enPosX:int = 0;
      
      public static var coins = 10000;
      
      public static var keys = 0;
      
      public static var tickets = 1;
      
      public static var freeCoins:int = 0;
      
      public static var numAds:int = 0;
      
      public static var heroesArr:Array = [];
      
      public static var enemiesArr:Array = [];
      
      public static var freeExp:int = 0;
      
      public static var hExp0:int = 0;
      
      public static var hExp1:int = 0;
      
      public static var hExp2:int = 0;
      
      public static var factorCoins:Number = 0;
      
      public static var factorExp:Array = [0,0,0];
      
      public static var knight:int = 0;
      
      public static var hunter:int = 0;
      
      public static var monk:int = 0;
      
      public static var open_weapon = [9,9,9,5,14,23];
      
      public static var her0 = [200,0,101,0,3,1,1,0,0];
      
      public static var her1 = [200,0,203,0,3,1,1,0,9];
      
      public static var her2 = [200,0,301,0,3,1,1,0,18];
      
      public static var storageArr = [401,402,403,404,405,406,407,408,101,201,202,203,204,205,206,207,208,301,302,303,304,305,306,307,308];
      
      public static var stars = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      
      public static var enStats = [[80,1,1,3,1,0.4,20,4,25,10],[500,1,1,10,1.5,0.4,22,3,50,100],[4000,1,1,100,3,1,15,3,250,150],[5000,1,1,50,2,0.6,10,4,250,200],[7500,1,1,150,4,1.2,15,4,300,200],[30000,1,1,90,2.5,0.5,24,4,2000,5000],[400,1,1,7,2,0,10,6,75,30],[700,1,1,25,1,0.6,20,4,100,70],[3500,1,1,0,8,0,15,3,300,300],[7000,1,1,150,1,0,15,3,300,400],[6000,1,1,50,3,0,15,5,300,500],[50000,1,1,200,2.5,3,20,4,3000,10000],[1600,1,1,20,1.5,0,30,6,100,0],[700,1,1,20,3,0,10,4,90,70],[3000,1,1,0,3,0,15,4,400,400],[6000,1,1,100,2,0,15,4,400,800],[7000,1,1,150,1.5,0,15,4,400,800],[70000,1,0.8,200,2.5,3,20,4,4000,20000],[2000,1,1,50,1,0,15,3,150,120],[1500,1,1,50,5,1,20,4,150,120],[5000,1,1,150,1,0,15,3,500,800],[8000,1,1,150,1,1,15,3,500,800],[10000,1,1,200,1,0,15,3,500,1000],[100000,1,1,300,2,0,20,4,5000,40000],[1500,1,1,70,2,0,15,3,200,150],[3000,1,1,130,3,0.6,20,4,200,150],[8000,1,1,250,1,0,15,3,600,1000],[10000,1,1,300,1,0,15,3,600,1000],[15000,1,1,350,1,0,15,3,600,1500],[150000,1,1,50,2.5,3,20,4,6000,500000],[3000,1,1,100,2,0,15,5,0,0],[1000,1,1,25,2,0,15,5,0,0]];
      
      public static var swords = [["",0,0,0,0,0,0,0,0,0,0,0,0,0,0],["Short Sword",1,0,0,1,0,0,10,"Короткий меч",20,0,0.03,0,0,0],["Iron Broadsword",2,-5,-16,2,0,1,150,"Железный меч",30,0,0.04,10,0,0],["Cutlass",3,-1,-16,3,0,0,300,"Сабля",40,0,0.1,0,0,0],["Hot Steel",4,-2,-15,4,0,0,600,"Горячая сталь",50,0,0.05,0,0,0],["Mace of Justice",5,-5,-6,1,0,1,600,"Булава правосудия",60,0,0.06,10,0,0],["Psycho Knife",6,-6,-27,1,3,0,2400,"Нож маньяка",70,0,0.1,0,0,0],["Sharp Blade",7,-9,-25,1,4,0,5000,"Острое лезвие",80,0,0.07,0,0,0],["Ancient Ax",8,-3,-18,2,3,2,5000,"Древний топор",90,0,0.08,20,20,0],["Titanium Sword",9,-5,-29,2,4,0,10000,"Титановый меч",100,0,0.15,0,0,0],["Excalibur",10,-6,-24,1,4,0,20000,"Экскалибур",110,0,0.09,0,0,0],["Curved Sword",11,-5,-27,2,4,1,20000,"Кривой меч",120,0,0.1,10,0,0],["Butcher\'s Knife",12,2,-32,3,4,0,40000,"Нож мясника",130,0,0.15,0,0,0],["Night\'s Edge",13,-9,-25,1,2,0,80000,"Край ночи",140,0,0.1,0,0,0],["Сrenellated Sword",14,-7,-37,1,4,2,80000,"Зубчатый меч",150,0,0.1,20,20,0],["Demon\'s Ax",15,-9,-33,3,4,0,150000,"Демонический Топор",160,0,0.2,0,0,0]];
      
      public static var bows = [["",0,0,0,0,0,0,0,"",0,0,0,0,0,0],["Bone Bow",1,0,0,1,0,0,10,"Костяной Лук",20,0,0.03,0,0,0],["Forest Force",2,0,0,2,0,1,150,"Сила Леса",30,0,0.04,10,0,0],["ChickenFoot",3,0,0,3,0,0,300,"Куриные Лапки",40,0,0.1,0,0,0],["Curved Bow",4,0,0,4,0,0,600,"Изогнутый Лук",50,0,0.05,0,0,0],["Iron Bow",5,0,0,1,0,1,600,"Железный Лук",60,0,0.06,10,0,0],["Bamboo Bow",6,0,0,3,0,0,2400,"Бамбуковый Лук",75,0,0.1,0,0,0],["Secret of Vines",7,0,0,1,4,0,5000,"Виноградная Лоза",80,0,0.07,0,0,0],["Rings of Truth",8,0,0,2,3,2,5000,"Кольчатый Лук",90,0,0.08,20,20,0],["Flamestrike",9,0,0,2,4,0,10000,"Огненый Лук",100,0,0.15,0,0,0],["Rat\'s Tail",10,0,0,1,4,0,20000,"Крысиный Лук",110,0,0.09,0,0,0],["Teeth of Shark",11,0,0,2,4,1,20000,"Зубы Акулы",120,0,0.1,10,0,0],["Bow of Wind",12,0,0,3,4,0,40000,"Лук 7 Ветров",130,0,0.15,0,0,0],["Ice Bow",13,0,0,1,2,0,80000,"Ледяной Лук",140,0,0.1,0,0,0],["Snakebite",14,0,0,1,4,2,80000,"Змеиный Укус",150,0,0.1,20,20,0],["Hellwing Bow",15,0,0,3,4,0,150000,"Адский Лук",160,0,0.2,0,0,0]];
      
      public static var sticks = [["",0,0,0,0,0,0,0,"",0,0,0,0,0,0],["Star Staff",1,2.8,-4.2,1,0,0,10,"Звездный Посох",20,0,0.03,0,0,0],["Green Staff",2,-0.7,-11,2,0,1,150,"Зеленый Посох",30,0,0.04,10,0,0],["Healing Staff",3,1.3,-9.9,3,0,0,300,"Посох Хилера",35,0,0.1,0,0,0],["Moon Scepter",4,-1,-9,4,0,0,600,"Лунный Скипитр",40,0,0.05,0,0,0],["Crystal Scepter",5,4.2,-12.7,1,0,1,600,"Кристальный Скипитр",50,0,0.06,10,0,0],["Scepter of Mending",6,-2.6,-8.1,3,0,0,2400,"Скипитр восстанавления",55,0,0.1,0,0,0],["Scepter of Forest",7,-4.4,-16.5,1,0,0,5000,"Лесная Сила",60,0,0.07,0,0,0],["Staff of Magelight",8,-6,-17,2,0,2,5000,"Магический Свет",70,0,0.08,20,20,0],["Hawkish Staff",9,0,-26,2,0,0,10000,"Орлиный Посох",75,0,0.15,0,0,0],["Vulture Staff",10,0,-10,1,4,0,20000,"Посох Птичий",80,0,0.09,0,0,0],["Ice Staff",11,-4.7,-11.2,2,4,1,20000,"Ледяной Посох",90,0,0.1,10,0,0],["Red Staff",12,-2.8,-12,3,4,0,40000,"Алый Посох",95,0,0.15,0,0,0],["Dragon Staff",13,-5.8,-18.8,1,2,0,80000,"Посох Драконов",100,0,0.1,0,0,0],["Staff of Flames",14,2,-24.3,1,4,2,80000,"Огненый Посох",110,0,0.1,20,20,0],["Inferno Scepter",15,-10,-18.7,3,4,0,150000,"Адский Скипитр",125,0,0.2,0,0,0]];
      
      public static var heads0 = [["",0,0,0,0,0,0,0,"",0,0,0],["Infantry Helmet",1,0,0,20,0,0,50,"Шлем пехотинца",0,0,0],["Rugged Helmet",2,1,2,40,0,0,250,"Прочный шлем",0,0,0],["Barbarian Helmet",3,4,0,60,0,1,1000,"Шлем варвара",10,0,0],["Soldier\'s Helm",4,-4,-6,80,0,0,3000,"Солдатский шлем",0,0,0],["Heavy Helmet",5,4,2,100,0,2,5000,"Тяжелый шлем",20,20,0],["Knight\'s Helmet",6,1,4,120,0,0,12000,"Рыцарский шлем",0,0,0],["Dwarven Helmet",7,1,-8,140,0,1,30000,"Шлем гномов",10,0,0],["Helm of Sentinel",8,0,2,160,0,0,50000,"Шлем Стража",0,0,0],["Dragon\'s Helm",9,0,1,180,0,2,100000,"Драконий Шлем",20,20,0],["Leather Helm",10,2,2,10,5,0,50,"Кожпный шлем",0,0,0],["Bandana",11,-4,0,20,7,0,250,"Бандана",0,0,0],["Fur Hat",12,1,0,30,9,1,1000,"Меховая Шапка",10,0,0],["Sharpshooter\'s Hat",13,-6,-10,40,11,0,3000,"Шапка Стрелка",0,0,0],["Experienced Hunter",14,0,-2,50,15,2,5000,"Шапка Охотника",20,20,0],["Studded Helm",15,1,-7,60,20,0,12000,"Шипованный Шлам",0,0,0],["Spy Hood",16,0,1,40,25,1,30000,"Шпионский Капюшон",10,0,0],["Wild Boar",17,1,-12,70,30,0,50000,"Дикий Кабан",0,0,0],["The Long Sight",18,-3,-9,100,35,2,100000,"Орлиный Глаз",20,20,0],["Mage\'s Hat",19,-8,-5,10,0,0,50,"Шляпа мага",0,0,10],["Turban",20,2,0,15,0,0,250,"Волшебный Тюрбан",0,0,15],["Fiery Hood",21,0,1,20,0,1,1000,"Огненый Капюшон",10,0,20],["Monk\'s Hat",22,-11,0,25,0,0,3000,"Шляпа Монаха",0,0,25],["Chicken оf War",23,-1,-15,30,0,2,5000,"Цыпленок",20,20,30],["Strength of Monster",24,-3,-17,35,0,0,12000,"Сила монстра",0,0,35],["Hat of Wizard",25,-8,-15,40,0,1,30000,"Шляпа волшебника",10,0,40],["Sea Creature",26,0,-17,50,0,0,50000,"Морское чудовище",0,0,45],["Evil mask",27,0,0,70,0,2,100000,"Маска Дьявола",20,20,50]];
       
      
      public function GV()
      {
         super();
      }
   }
}
