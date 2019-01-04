package dragonBones.starling
{
   import dragonBones.events.EventObject;
   import starling.events.Event;
   
   public final class StarlingEvent extends Event
   {
       
      
      public function StarlingEvent(param1:String, param2:EventObject)
      {
         super(param1,false,param2);
      }
      
      public function get eventObject() : EventObject
      {
         return data as EventObject;
      }
   }
}
