package com.general
{
   public class Calc
   {
       
      
      public function Calc()
      {
         super();
      }
      
      public static function knight_power(param1:int) : int
      {
         return param1 * 10;
      }
      
      public static function sword_power(param1:int, param2:int) : int
      {
         return param1 * 10 * GV.swords[param2][9] / 100;
      }
      
      public static function hunter_power(param1:int) : int
      {
         return param1 * 15;
      }
      
      public static function bow_power(param1:int, param2:int) : int
      {
         return param1 * 15 * GV.bows[param2][9] / 100;
      }
      
      public static function monk_power(param1:int) : int
      {
         return param1 * 20;
      }
      
      public static function stick_power(param1:int, param2:int) : int
      {
         return param1 * 20 * GV.sticks[param2][9] / 100;
      }
      
      public static function knight_hp(param1:int) : int
      {
         return param1 * 25;
      }
      
      public static function knight_hp_extra(param1:int, param2:int) : int
      {
         return param1 * 25 * GV.heads0[param2][4] / 100;
      }
      
      public static function hunter_hp(param1:int) : int
      {
         return param1 * 18;
      }
      
      public static function hunter_hp_extra(param1:int, param2:int) : int
      {
         return param1 * 18 * GV.heads0[param2][4] / 100;
      }
      
      public static function monk_hp(param1:int) : int
      {
         return param1 * 12;
      }
      
      public static function monk_hp_extra(param1:int, param2:int) : int
      {
         return param1 * 12 * GV.heads0[param2][4] / 100;
      }
   }
}
