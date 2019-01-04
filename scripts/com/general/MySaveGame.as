package com.general
{
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   
   public class MySaveGame
   {
      
      public static var _instance:MySaveGame;
       
      
      private var name:String = "Shorties2w";
      
      public var _myData:Object;
      
      public var _sharedObject:SharedObject;
      
      public function MySaveGame()
      {
         super();
         this.bind();
      }
      
      public static function getInstance() : MySaveGame
      {
         if(_instance == null)
         {
            _instance = new MySaveGame();
         }
         return _instance;
      }
      
      public function init_saves() : void
      {
         if(this._sharedObject.size == 0)
         {
            this.reset();
         }
         else
         {
            this.local_load();
         }
      }
      
      public function bind() : Boolean
      {
         this._sharedObject = null;
         try
         {
            this._sharedObject = SharedObject.getLocal(this.name,"/");
         }
         catch(e:Error)
         {
            _sharedObject = null;
            return false;
         }
         return true;
      }
      
      public function local_load() : void
      {
         if(this._sharedObject != null)
         {
            this._myData = JSONN.decode(this._sharedObject.data.myJson);
            GV.settings = this._myData.settings;
            GV.episode = this._myData.episode;
            GV.coins = this._myData.coins;
            GV.keys = this._myData.keys;
            GV.tickets = this._myData.tickets;
            GV.open_weapon = this._myData.open_weapon;
            GV.her0 = this._myData.her0;
            GV.her1 = this._myData.her1;
            GV.her2 = this._myData.her2;
            GV.storageArr = this._myData.storageArr;
            GV.stars = this._myData.stars;
         }
      }
      
      public function localSave(param1:uint = 0) : Boolean
      {
         var myJson:String = null;
         var MinFileSize:uint = param1;
         if(this._sharedObject == null)
         {
            return false;
         }
         var status:Object = null;
         try
         {
            this._myData = {
               "settings":GV.settings,
               "episode":GV.episode,
               "coins":GV.coins,
               "keys":GV.keys,
               "tickets":GV.tickets,
               "open_weapon":GV.open_weapon,
               "her0":GV.her0,
               "her1":GV.her1,
               "her2":GV.her2,
               "storageArr":GV.storageArr,
               "stars":GV.stars
            };
            myJson = JSONN.encode(this._myData);
            this._sharedObject.data.myJson = myJson;
            status = this._sharedObject.flush(MinFileSize);
         }
         catch(e:Error)
         {
            return false;
         }
         return status == SharedObjectFlushStatus.FLUSHED;
      }
      
      public function reset() : void
      {
         GV.episode = 0;
         GV.coins = 0;
         GV.keys = 0;
         GV.tickets = 0;
         GV.open_weapon = [9,9,9,5,14,23];
         GV.her0 = [1,0,0,0,3,1,1,0,0];
         GV.her1 = [0,0,0,0,3,1,1,0,9];
         GV.her2 = [0,0,0,0,3,1,1,0,18];
         GV.storageArr = [];
         GV.stars = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         this.localSave();
      }
      
      public function load_cheat() : void
      {
         GV.episode = 4;
         GV.coins = 5000;
         GV.keys = 10;
         GV.tickets = 10;
         GV.open_weapon = [15,15,15,9,18,27];
         GV.her0 = [5,402,110,0,3,1,1,0,0];
         GV.her1 = [5,411,210,0,3,1,1,0,9];
         GV.her2 = [5,420,310,0,3,1,1,0,18];
         GV.storageArr = [406,407,408,415,416,417,424,425,426,112,113,114,115,212,213,214,215,312,313,314,315];
         GV.stars = [1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         this.localSave();
      }
   }
}
