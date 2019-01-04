package com.general
{
   import flash.geom.Point;
   import starling.display.Sprite;
   
   public class Amath
   {
      
      public static var p1:Point = new Point(0,0);
      
      public static var p2:Point = new Point(0,0);
      
      public static var p3:Point = new Point(0,0);
      
      public static var p4:Point = new Point(0,0);
       
      
      public function Amath()
      {
         super();
      }
      
      public static function distance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param3 - param1;
         var _loc6_:Number = param4 - param2;
         return Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
      }
      
      public static function random(param1:Number, param2:Number) : Number
      {
         return Math.round(Math.random() * (param2 - param1)) + param1;
      }
      
      public static function equal(param1:Number, param2:Number, param3:Number = 1.0E-5) : Boolean
      {
         return Math.abs(param1 - param2) <= param3;
      }
      
      public static function getAngle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = true) : Number
      {
         var _loc6_:Number = param3 - param1;
         var _loc7_:Number = param4 - param2;
         var _loc8_:Number = Math.atan2(_loc7_,_loc6_);
         if(param5)
         {
            if(_loc8_ < 0)
            {
               _loc8_ = Math.PI * 2 + _loc8_;
            }
            else if(_loc8_ >= Math.PI * 2)
            {
               _loc8_ = _loc8_ - Math.PI * 2;
            }
         }
         return _loc8_;
      }
      
      public static function getAngleDeg(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = true) : Number
      {
         var _loc6_:Number = param3 - param1;
         var _loc7_:Number = param4 - param2;
         var _loc8_:Number = Math.atan2(_loc7_,_loc6_) / Math.PI * 180;
         if(param5)
         {
            if(_loc8_ < 0)
            {
               _loc8_ = 360 + _loc8_;
            }
            else if(_loc8_ >= 360)
            {
               _loc8_ = _loc8_ - 360;
            }
         }
         return _loc8_;
      }
      
      public static function toDegrees(param1:Number) : Number
      {
         return param1 * 180 / Math.PI;
      }
      
      public static function toRadians(param1:Number) : Number
      {
         return param1 * Math.PI / 180;
      }
      
      public static function Lerp(param1:Number, param2:Number, param3:Number) : Number
      {
         return Math.floor(param1 + param3 * (param2 - param1));
      }
      
      public static function stepToR(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param2 - param1 > 3.14)
         {
            param1 = param1 + 6.28;
         }
         else if(param2 - param1 < -3.14)
         {
            param1 = param1 - 6.28;
         }
         if(Math.abs(param1 - param2) <= param3)
         {
            return param2;
         }
         if(param1 < param2)
         {
            return param1 + param3;
         }
         return param1 - param3;
      }
      
      public static function collision(param1:Sprite, param2:Sprite) : Boolean
      {
         p1 = param1.localToGlobal(param1["_hitboxOffset"]);
         p2 = param1.localToGlobal(param1["_hitbox"]);
         p3 = param2.localToGlobal(param2["_hitbox"]);
         p4 = param2.localToGlobal(param2["_hitboxOffset"]);
         if(p4.x > p1.x && p3.x < p2.x && p4.y > p1.y && p3.y < p2.y)
         {
            return true;
         }
         return false;
      }
      
      public static function rectangles(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:int, param14:int, param15:int, param16:int) : Boolean
      {
         if(!isProjectedAxisCollision(param1,param2,param3,param4,param9,param10,param11,param12,param13,param14,param15,param16))
         {
            return false;
         }
         if(!isProjectedAxisCollision(param3,param4,param5,param6,param9,param10,param11,param12,param13,param14,param15,param16))
         {
            return false;
         }
         if(!isProjectedAxisCollision(param9,param10,param11,param12,param1,param2,param3,param4,param5,param6,param7,param8))
         {
            return false;
         }
         if(!isProjectedAxisCollision(param11,param12,param13,param14,param1,param2,param3,param4,param5,param6,param7,param8))
         {
            return false;
         }
         return true;
      }
      
      public static function isProjectedAxisCollision(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int) : Boolean
      {
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         if(param1 == param3)
         {
            _loc13_ = _loc14_ = _loc15_ = _loc16_ = param1;
            _loc17_ = param6;
            _loc18_ = param8;
            _loc19_ = param10;
            _loc20_ = param12;
            if(param2 > param4)
            {
               if(_loc17_ > param2 && _loc18_ > param2 && _loc19_ > param2 && _loc20_ > param2 || _loc17_ < param4 && _loc18_ < param4 && _loc19_ < param4 && _loc20_ < param4)
               {
                  return false;
               }
            }
            else if(_loc17_ > param4 && _loc18_ > param4 && _loc19_ > param4 && _loc20_ > param4 || _loc17_ < param2 && _loc18_ < param2 && _loc19_ < param2 && _loc20_ < param2)
            {
               return false;
            }
            return true;
         }
         if(param2 == param4)
         {
            _loc13_ = param5;
            _loc14_ = param7;
            _loc15_ = param9;
            _loc16_ = param11;
            _loc17_ = _loc18_ = _loc19_ = _loc20_ = param2;
         }
         else
         {
            _loc21_ = (param2 - param4) / (param1 - param3);
            _loc22_ = 1 / _loc21_;
            _loc23_ = param3 * _loc21_ - param4;
            _loc24_ = 1 / (_loc21_ + _loc22_);
            _loc13_ = (param6 + _loc23_ + param5 * _loc22_) * _loc24_;
            _loc14_ = (param8 + _loc23_ + param7 * _loc22_) * _loc24_;
            _loc15_ = (param10 + _loc23_ + param9 * _loc22_) * _loc24_;
            _loc16_ = (param12 + _loc23_ + param11 * _loc22_) * _loc24_;
            _loc17_ = param6 + (param5 - _loc13_) * _loc22_;
            _loc18_ = param8 + (param7 - _loc14_) * _loc22_;
            _loc19_ = param10 + (param9 - _loc15_) * _loc22_;
            _loc20_ = param12 + (param11 - _loc16_) * _loc22_;
         }
         if(param1 > param3)
         {
            if(_loc13_ > param1 && _loc14_ > param1 && _loc15_ > param1 && _loc16_ > param1 || _loc13_ < param3 && _loc14_ < param3 && _loc15_ < param3 && _loc16_ < param3)
            {
               return false;
            }
         }
         else if(_loc13_ > param3 && _loc14_ > param3 && _loc15_ > param3 && _loc16_ > param3 || _loc13_ < param1 && _loc14_ < param1 && _loc15_ < param1 && _loc16_ < param1)
         {
            return false;
         }
         return true;
      }
      
      public static function laser(param1:Point, param2:Point, param3:Point, param4:Point, param5:Point, param6:Point, param7:Point, param8:Point) : Boolean
      {
         if(lineCross(param1,param2,param5,param7))
         {
            return true;
         }
         if(lineCross(param1,param2,param6,param8))
         {
            return true;
         }
         if(lineCross(param3,param4,param5,param7))
         {
            return true;
         }
         if(lineCross(param3,param4,param6,param8))
         {
            return true;
         }
         return false;
      }
      
      public static function lineCross(param1:Point, param2:Point, param3:Point, param4:Point) : Boolean
      {
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc5_:Number = param1.x;
         var _loc6_:Number = param1.y;
         var _loc7_:Number = param2.x;
         var _loc8_:Number = param2.y;
         var _loc9_:Number = param3.x;
         var _loc10_:Number = param3.y;
         var _loc11_:Number = param4.x;
         var _loc12_:Number = param4.y;
         var _loc13_:Number = Math.max(_loc5_,_loc7_);
         var _loc14_:Number = Math.max(_loc6_,_loc8_);
         var _loc15_:Number = Math.min(_loc5_,_loc7_);
         var _loc16_:Number = Math.min(_loc6_,_loc8_);
         var _loc17_:Number = Math.max(_loc9_,_loc11_);
         var _loc18_:Number = Math.max(_loc10_,_loc12_);
         var _loc19_:Number = Math.min(_loc9_,_loc11_);
         var _loc20_:Number = Math.min(_loc10_,_loc12_);
         var _loc21_:Number = _loc7_ - _loc5_;
         var _loc22_:Number = _loc8_ - _loc6_;
         var _loc23_:Number = _loc11_ - _loc9_;
         var _loc24_:Number = _loc12_ - _loc10_;
         var _loc25_:Number = _loc5_ - _loc9_;
         var _loc26_:Number = _loc6_ - _loc10_;
         _loc27_ = _loc24_ * _loc21_ - _loc23_ * _loc22_;
         if(_loc27_ == 0)
         {
            return false;
         }
         if(_loc27_ > 0)
         {
            _loc28_ = _loc23_ * _loc26_ - _loc24_ * _loc25_;
            if(_loc28_ < 0 || _loc28_ > _loc27_)
            {
               return false;
            }
            _loc28_ = _loc21_ * _loc26_ - _loc22_ * _loc25_;
            if(_loc28_ < 0 || _loc28_ > _loc27_)
            {
               return false;
            }
         }
         else
         {
            _loc28_ = -(_loc23_ * _loc26_ - _loc24_ * _loc25_);
            if(_loc28_ < 0 || _loc28_ > -_loc27_)
            {
               return false;
            }
            _loc28_ = -(_loc21_ * _loc26_ - _loc22_ * _loc25_);
            if(_loc28_ < 0 || _loc28_ > -_loc27_)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getPointOfIntersection(param1:Point, param2:Point, param3:Point, param4:Point) : Point
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc5_:Number = (param1.x - param2.x) * (param4.y - param3.y) - (param1.y - param2.y) * (param4.x - param3.x);
         var _loc6_:Number = (param1.x - param3.x) * (param4.y - param3.y) - (param1.y - param3.y) * (param4.x - param3.x);
         var _loc7_:Number = (param1.x - param2.x) * (param1.y - param3.y) - (param1.y - param2.y) * (param1.x - param3.x);
         var _loc8_:Number = _loc6_ / _loc5_;
         var _loc9_:Number = _loc7_ / _loc5_;
         if(_loc8_ >= 0 && _loc8_ <= 1 && _loc9_ >= 0 && _loc9_ <= 1)
         {
            _loc10_ = param1.x + _loc8_ * (param2.x - param1.x);
            _loc11_ = param1.y + _loc8_ * (param2.y - param1.y);
            return new Point(_loc10_,_loc11_);
         }
         return null;
      }
   }
}
