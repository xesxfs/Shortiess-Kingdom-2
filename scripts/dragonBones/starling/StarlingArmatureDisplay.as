package dragonBones.starling
{
   import dragonBones.Armature;
   import dragonBones.animation.Animation;
   import dragonBones.core.IArmatureDisplay;
   import dragonBones.events.EventObject;
   import starling.display.Sprite;
   
   public final class StarlingArmatureDisplay extends Sprite implements IArmatureDisplay
   {
      
      public static var useDefaultStarlingEvent:Boolean = false;
       
      
      var _armature:Armature;
      
      public function StarlingArmatureDisplay()
      {
         super();
      }
      
      public function _onClear() : void
      {
         this._armature = null;
      }
      
      public function _dispatchEvent(param1:String, param2:EventObject) : void
      {
         var _loc3_:StarlingEvent = null;
         if(useDefaultStarlingEvent)
         {
            dispatchEventWith(param1,false,param2);
         }
         else
         {
            _loc3_ = new StarlingEvent(param1,param2);
            dispatchEvent(_loc3_);
         }
      }
      
      public function _debugDraw(param1:Boolean) : void
      {
      }
      
      override public function dispose() : void
      {
         if(this._armature)
         {
            this._armature.dispose();
            this._armature = null;
         }
         super.dispose();
      }
      
      public function hasEvent(param1:String) : Boolean
      {
         return hasEventListener(param1);
      }
      
      public function addEvent(param1:String, param2:Function) : void
      {
         addEventListener(param1,param2);
      }
      
      public function removeEvent(param1:String, param2:Function) : void
      {
         removeEventListener(param1,param2);
      }
      
      public function get armature() : Armature
      {
         return this._armature;
      }
      
      public function get animation() : Animation
      {
         return this._armature.animation;
      }
      
      public function advanceTimeBySelf(param1:Boolean) : void
      {
         if(param1)
         {
            StarlingFactory._clock.add(this._armature);
         }
         else
         {
            StarlingFactory._clock.remove(this._armature);
         }
      }
   }
}
