package com.general
{
   public class ObjectController
   {
       
      
      public var objects:Array;
      
      public function ObjectController()
      {
         this.objects = [];
         super();
      }
      
      public function add(param1:IGameObject) : void
      {
         this.objects[this.objects.length] = param1;
      }
      
      public function remove(param1:IGameObject) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.objects.length)
         {
            if(this.objects[_loc2_] == param1)
            {
               this.objects[_loc2_] = null;
               this.objects.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function clear() : void
      {
         while(this.objects.length > 0)
         {
            this.objects[0].free();
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = this.objects.length - 1;
         while(_loc2_ >= 0)
         {
            this.objects[_loc2_].update(param1);
            _loc2_--;
         }
      }
   }
}
