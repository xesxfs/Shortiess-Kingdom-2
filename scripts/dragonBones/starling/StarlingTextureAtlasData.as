package dragonBones.starling
{
   import dragonBones.core.BaseObject;
   import dragonBones.textures.TextureAtlasData;
   import dragonBones.textures.TextureData;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public final class StarlingTextureAtlasData extends TextureAtlasData
   {
       
      
      public var disposeTexture:Boolean;
      
      public var texture:Texture;
      
      public function StarlingTextureAtlasData()
      {
         super(this);
      }
      
      public static function fromTextureAtlas(param1:TextureAtlas) : StarlingTextureAtlasData
      {
         var _loc2_:StarlingTextureAtlasData = null;
         var _loc3_:String = null;
         var _loc4_:StarlingTextureData = null;
         _loc2_ = BaseObject.borrowObject(StarlingTextureAtlasData) as StarlingTextureAtlasData;
         for each(_loc3_ in param1.getNames())
         {
            _loc4_ = _loc2_.generateTexture() as StarlingTextureData;
            _loc4_.name = _loc3_;
            _loc4_.texture = param1.getTexture(_loc3_) as SubTexture;
            _loc4_.rotated = param1.getRotation(_loc3_);
            _loc4_.region.copyFrom(param1.getRegion(_loc3_));
            _loc2_.addTexture(_loc4_);
         }
         _loc2_.texture = param1.texture;
         _loc2_.scale = param1.texture.scale;
         return _loc2_;
      }
      
      override protected function _onClear() : void
      {
         super._onClear();
         if(this.texture)
         {
            if(this.disposeTexture)
            {
               this.disposeTexture = false;
               this.texture.dispose();
            }
            this.texture = null;
         }
         else
         {
            this.disposeTexture = false;
         }
      }
      
      override public function generateTexture() : TextureData
      {
         return BaseObject.borrowObject(StarlingTextureData) as StarlingTextureData;
      }
   }
}
