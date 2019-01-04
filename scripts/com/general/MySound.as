package com.general
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class MySound
   {
      
      public static var _instance:MySound;
      
      public static var _allowInstance:Boolean = false;
       
      
      public var allowSounds:Boolean;
      
      public var allowSFX:Boolean;
      
      var sound:Object;
      
      var musics:Object;
      
      private var mSoundChannels:Array;
      
      private var mMusicChannel:SoundChannel;
      
      private const MAX_SOUND_CHANNELS:int = 18;
      
      public var vol_sound:Number = 0.8;
      
      public var vol_music:Number = 0.6;
      
      private var curMusName:String;
      
      private var _rand:int = 0;
      
      private var t0:int = 0;
      
      private var t1:int = 0;
      
      private var t2:int = 0;
      
      private var t3:int = 0;
      
      private var t4:int = 0;
      
      private var t5:int = 0;
      
      private var t6:int = 0;
      
      private var t7:int = 0;
      
      private var t8:int = 0;
      
      private var t9:int = 0;
      
      private var t10:int = 0;
      
      private var t11:int = 0;
      
      public function MySound()
      {
         super();
         if(!_allowInstance)
         {
            throw new Error("Error: Use TurtleSounds.getInstance () instead of the new keyword.");
         }
         this.initSounds();
      }
      
      public static function getInstance() : MySound
      {
         if(_instance == null)
         {
            _allowInstance = true;
            _instance = new MySound();
            _allowInstance = false;
         }
         return _instance;
      }
      
      private function initSounds() : void
      {
         this.allowSounds = true;
         this.allowSFX = true;
         this.mSoundChannels = [];
         this.sound = new Object();
         this.sound["win"] = new sound_01();
         this.sound["fail"] = new sound_02();
         this.sound["sword0"] = new sound_03();
         this.sound["sword1"] = new sound_04();
         this.sound["sword2"] = new sound_05();
         this.sound["bow0"] = new sound_06();
         this.sound["bow1"] = new sound_07();
         this.sound["bow2"] = new sound_08();
         this.sound["put"] = new sound_10();
         this.sound["open"] = new sound_11();
         this.sound["click"] = new sound_12();
         this.sound["sell"] = new sound_13();
         this.sound["weel"] = new sound_14();
         this.sound["blade"] = new sound_15();
         this.sound["die0"] = new sound_16();
         this.sound["die1"] = new sound_17();
         this.sound["die2"] = new sound_18();
         this.sound["die3"] = new sound_19();
         this.sound["spell"] = new sound_20();
         this.sound["dam0"] = new sound_21();
         this.sound["dam1"] = new sound_22();
         this.sound["dam2"] = new sound_23();
         this.sound["dam3"] = new sound_24();
         this.sound["dam4"] = new sound_25();
         this.sound["dam5"] = new sound_26();
         this.sound["dam6"] = new sound_27();
         this.sound["steel0"] = new sound_28();
         this.sound["steel1"] = new sound_29();
         this.sound["steel2"] = new sound_30();
         this.sound["shield"] = new sound_31();
         this.sound["heal"] = new sound_32();
         this.sound["explosion"] = new sound_33();
         this.sound["fanfar"] = new sound_34();
         this.sound["dieboss"] = new sound_35();
         this.sound["cry"] = new sound_36();
         this.sound["kaban"] = new sound_37();
         this.sound["prize"] = new sound_38();
         this.sound["error"] = new sound_39();
         this.musics = new Object();
         this.musics["menu"] = new mus_1();
         this.musics["game"] = new mus_2();
      }
      
      public function playSFX(param1:String) : void
      {
         var _loc5_:SoundChannel = null;
         if(!this.allowSFX || this.vol_sound < 0.001)
         {
            return;
         }
         var _loc2_:Sound = this.sound[param1];
         if(!this.sound)
         {
            return;
         }
         if(this.mSoundChannels.length >= this.MAX_SOUND_CHANNELS)
         {
            _loc5_ = this.mSoundChannels.shift();
            _loc5_.stop();
         }
         var _loc3_:SoundTransform = new SoundTransform();
         _loc3_.volume = this.vol_sound;
         var _loc4_:SoundChannel = _loc2_.play(0,0,_loc3_);
         this.mSoundChannels.push(_loc4_);
         _loc4_.addEventListener(Event.SOUND_COMPLETE,this.OnSFXComplete);
      }
      
      private function OnSFXComplete(param1:Event) : void
      {
         var _loc2_:SoundChannel = param1.currentTarget as SoundChannel;
         _loc2_.removeEventListener(Event.SOUND_COMPLETE,this.OnSFXComplete);
         var _loc3_:int = this.mSoundChannels.indexOf(_loc2_);
         this.mSoundChannels.splice(_loc3_,1);
      }
      
      public function setVolumeMUS(param1:*) : void
      {
         this.vol_music = param1;
         if(this.curMusName)
         {
            this.playMusic(this.curMusName);
         }
      }
      
      public function setVolumeSOUND(param1:*) : void
      {
         this.vol_sound = param1;
      }
      
      public function musOFF() : void
      {
         this.allowSounds = false;
         if(this.curMusName)
         {
            this.playMusic(this.curMusName);
         }
      }
      
      public function musON() : void
      {
         this.allowSounds = true;
         if(this.curMusName)
         {
            this.playMusic(this.curMusName);
         }
      }
      
      public function soundOFF() : void
      {
         this.allowSFX = false;
      }
      
      public function soundON() : void
      {
         this.allowSFX = true;
      }
      
      public function playMusic(param1:String) : void
      {
         var _loc2_:SoundTransform = new SoundTransform(this.vol_music);
         if(!this.allowSounds)
         {
            _loc2_.volume = 0;
         }
         if(this.curMusName != param1)
         {
            if(this.mMusicChannel)
            {
               this.mMusicChannel.stop();
               this.mMusicChannel = null;
            }
            if(!this.mMusicChannel)
            {
               this.mMusicChannel = this.musics[param1].play(0,9999,_loc2_);
            }
            this.curMusName = param1;
         }
         else
         {
            this.mMusicChannel.soundTransform = _loc2_;
         }
      }
      
      public function stopMusic() : void
      {
         if(this.mMusicChannel)
         {
            this.mMusicChannel.stop();
            this.curMusName = "";
         }
      }
      
      public function free_time() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ <= 10)
         {
            this["t" + _loc1_] = 0;
            _loc1_++;
         }
      }
      
      public function sword() : void
      {
         if(this.t1 < GV.real_time)
         {
            this.t1 = GV.real_time + 50;
            this.playSFX("sword" + Amath.random(0,2));
         }
      }
      
      public function bow() : void
      {
         this.playSFX("bow" + Amath.random(0,2));
      }
      
      public function die() : void
      {
         if(this.t2 < GV.real_time)
         {
            this.t2 = GV.real_time + 50;
            this.playSFX("die" + Amath.random(0,3));
         }
      }
      
      public function damage() : void
      {
         if(this.t3 < GV.real_time)
         {
            this.t3 = GV.real_time + 50;
            this.playSFX("dam" + Amath.random(0,6));
         }
      }
      
      public function steel() : void
      {
         if(this.t4 < GV.real_time)
         {
            this.t4 = GV.real_time + 50;
            this.playSFX("steel" + Amath.random(0,2));
         }
      }
   }
}
