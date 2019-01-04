package dragonBones.geom
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public final class Transform
   {
       
      
      public var x:Number = 0.0;
      
      public var y:Number = 0.0;
      
      public var skewX:Number = 0.0;
      
      public var skewY:Number = 0.0;
      
      public var scaleX:Number = 1.0;
      
      public var scaleY:Number = 1.0;
      
      public function Transform()
      {
         super();
      }
      
      public static function normalizeRadian(param1:Number) : Number
      {
         param1 = (param1 + Math.PI) % (Math.PI * 2);
         param1 = param1 + (param1 > 0?-Math.PI:Math.PI);
         return param1;
      }
      
      public static function transformPoint(param1:Matrix, param2:Number, param3:Number, param4:Point, param5:Boolean = false) : void
      {
         param4.x = param1.a * param2 + param1.c * param3;
         param4.y = param1.b * param2 + param1.d * param3;
         if(!param5)
         {
            param4.x = param4.x + param1.tx;
            param4.y = param4.y + param1.ty;
         }
      }
      
      public function toString() : String
      {
         return "[object dragonBones.geom.Transform] x:" + this.x + " y:" + this.y + " skewX:" + this.skewX * 180 / Math.PI + " skewY:" + this.skewY * 180 / Math.PI + " scaleX:" + this.scaleX + " scaleY:" + this.scaleY;
      }
      
      public final function copyFrom(param1:Transform) : Transform
      {
         this.x = param1.x;
         this.y = param1.y;
         this.skewX = param1.skewX;
         this.skewY = param1.skewY;
         this.scaleX = param1.scaleX;
         this.scaleY = param1.scaleY;
         return this;
      }
      
      public final function identity() : Transform
      {
         this.x = this.y = this.skewX = this.skewY = 0;
         this.scaleX = this.scaleY = 1;
         return this;
      }
      
      public final function add(param1:Transform) : Transform
      {
         this.x = this.x + param1.x;
         this.y = this.y + param1.y;
         this.skewX = this.skewX + param1.skewX;
         this.skewY = this.skewY + param1.skewY;
         this.scaleX = this.scaleX * param1.scaleX;
         this.scaleY = this.scaleY * param1.scaleY;
         return this;
      }
      
      public final function minus(param1:Transform) : Transform
      {
         this.x = this.x - param1.x;
         this.y = this.y - param1.y;
         this.skewX = normalizeRadian(this.skewX - param1.skewX);
         this.skewY = normalizeRadian(this.skewY - param1.skewY);
         this.scaleX = this.scaleX / param1.scaleX;
         this.scaleY = this.scaleY / param1.scaleY;
         return this;
      }
      
      public final function fromMatrix(param1:Matrix) : Transform
      {
         var _loc2_:Number = Math.PI * 0.25;
         var _loc3_:Number = this.scaleX;
         var _loc4_:Number = this.scaleY;
         this.x = param1.tx;
         this.y = param1.ty;
         this.skewX = Math.atan(-param1.c / param1.d);
         this.skewY = Math.atan(param1.b / param1.a);
         if(this.skewX !== this.skewX)
         {
            this.skewX = 0;
         }
         if(this.skewY !== this.skewY)
         {
            this.skewY = 0;
         }
         if(this.skewX > -_loc2_ && this.skewX < _loc2_)
         {
            this.scaleY = param1.d / Math.cos(this.skewX);
         }
         else
         {
            this.scaleY = -param1.c / Math.sin(this.skewX);
         }
         if(this.skewY > -_loc2_ && this.skewY < _loc2_)
         {
            this.scaleX = param1.a / Math.cos(this.skewY);
         }
         else
         {
            this.scaleX = param1.b / Math.sin(this.skewY);
         }
         if(_loc3_ >= 0 && this.scaleX < 0)
         {
            this.scaleX = -this.scaleX;
            this.skewY = this.skewY - Math.PI;
         }
         if(_loc4_ >= 0 && this.scaleY < 0)
         {
            this.scaleY = -this.scaleY;
            this.skewX = this.skewX - Math.PI;
         }
         return this;
      }
      
      public final function toMatrix(param1:Matrix) : Transform
      {
         if(this.skewX !== 0 || this.skewY !== 0)
         {
            param1.a = Math.cos(this.skewY);
            param1.b = Math.sin(this.skewY);
            if(this.skewX === this.skewY)
            {
               param1.c = -param1.b;
               param1.d = param1.a;
            }
            else
            {
               param1.c = -Math.sin(this.skewX);
               param1.d = Math.cos(this.skewX);
            }
            if(this.scaleX !== 1 || this.scaleY !== 1)
            {
               param1.a = param1.a * this.scaleX;
               param1.b = param1.b * this.scaleX;
               param1.c = param1.c * this.scaleY;
               param1.d = param1.d * this.scaleY;
            }
         }
         else
         {
            param1.a = this.scaleX;
            param1.b = 0;
            param1.c = 0;
            param1.d = this.scaleY;
         }
         param1.tx = this.x;
         param1.ty = this.y;
         return this;
      }
      
      public final function get rotation() : Number
      {
         return this.skewY;
      }
      
      public final function set rotation(param1:Number) : void
      {
         var _loc2_:Number = param1 - this.skewY;
         this.skewX = this.skewX + _loc2_;
         this.skewY = this.skewY + _loc2_;
      }
   }
}
