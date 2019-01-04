package dragonBones.starling
{
   import dragonBones.textures.TextureData;
   import starling.textures.SubTexture;
   
   public final class StarlingTextureData extends TextureData
   {
       
      
      public var texture:SubTexture = null;
      
      public function StarlingTextureData()
      {
         super(this);
      }
      
      override protected function _onClear() : void
      {
         super._onClear();
         if(this.texture)
         {
            this.texture.dispose();
            this.texture = null;
         }
      }
   }
}
