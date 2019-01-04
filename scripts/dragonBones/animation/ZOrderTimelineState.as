package dragonBones.animation
{
   import dragonBones.objects.ZOrderFrameData;
   
   public final class ZOrderTimelineState extends TimelineState
   {
       
      
      public function ZOrderTimelineState()
      {
         super(this);
      }
      
      override protected function _onArriveAtFrame() : void
      {
         super._onArriveAtFrame();
         _armature._sortZOrder((_currentFrame as ZOrderFrameData).zOrder);
      }
   }
}
