package com.mygame.managers
{
   import com.general.Amath;
   
   public class LootManager
   {
       
      
      public function LootManager()
      {
         super();
      }
      
      public function LootMoney(param1:int) : int
      {
         var _loc2_:int = param1 * param1 * 10;
         return Amath.random(_loc2_ - _loc2_ * 0.3,_loc2_ + _loc2_ * 0.3) * 10;
      }
   }
}
