package com.mygame.screens
{
   import starling.display.Sprite;
   
   public class ScrBase extends Sprite
   {
       
      
      public function ScrBase()
      {
         super();
      }
      
      public function activation() : void
      {
      }
      
      public function deactivation() : void
      {
      }
      
      public function free() : void
      {
         removeFromParent(true);
      }
      
      public function draw() : void
      {
      }
      
      public function translate() : void
      {
      }
   }
}
