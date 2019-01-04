package starling.textures
{
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import starling.display.Image;
   import starling.utils.StringUtil;
   
   public class TextureAtlas
   {
      
      private static var sNames:Vector.<String> = new Vector.<String>(0);
       
      
      private var _atlasTexture:Texture;
      
      private var _subTextures:Dictionary;
      
      private var _subTextureNames:Vector.<String>;
      
      public function TextureAtlas(param1:Texture, param2:* = null)
      {
         super();
         _subTextures = new Dictionary();
         _atlasTexture = param1;
         if(param2)
         {
            parseAtlasData(param2);
         }
      }
      
      public function dispose() : void
      {
         _atlasTexture.dispose();
      }
      
      protected function parseAtlasData(param1:*) : void
      {
         if(param1 is XML)
         {
            parseAtlasXml(param1 as XML);
            return;
         }
         throw new ArgumentError("TextureAtlas only supports XML data");
      }
      
      protected function parseAtlasXml(param1:XML) : void
      {
         var _loc11_:* = null;
         var _loc12_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc3_:Number = _atlasTexture.scale;
         var _loc15_:Rectangle = new Rectangle();
         var _loc16_:Rectangle = new Rectangle();
         var _loc19_:int = 0;
         var _loc18_:* = param1.SubTexture;
         for each(var _loc10_ in param1.SubTexture)
         {
            _loc11_ = StringUtil.clean(_loc10_.@name);
            _loc12_ = parseFloat(_loc10_.@x) / _loc3_ || 0;
            _loc14_ = parseFloat(_loc10_.@y) / _loc3_ || 0;
            _loc13_ = parseFloat(_loc10_.@width) / _loc3_ || 0;
            _loc17_ = parseFloat(_loc10_.@height) / _loc3_ || 0;
            _loc4_ = parseFloat(_loc10_.@frameX) / _loc3_ || 0;
            _loc8_ = parseFloat(_loc10_.@frameY) / _loc3_ || 0;
            _loc9_ = parseFloat(_loc10_.@frameWidth) / _loc3_ || 0;
            _loc2_ = parseFloat(_loc10_.@frameHeight) / _loc3_ || 0;
            _loc7_ = parseFloat(_loc10_.@pivotX) / _loc3_ || 0;
            _loc6_ = parseFloat(_loc10_.@pivotY) / _loc3_ || 0;
            _loc5_ = StringUtil.parseBoolean(_loc10_.@rotated);
            _loc15_.setTo(_loc12_,_loc14_,_loc13_,_loc17_);
            _loc16_.setTo(_loc4_,_loc8_,_loc9_,_loc2_);
            if(_loc9_ > 0 && _loc2_ > 0)
            {
               addRegion(_loc11_,_loc15_,_loc16_,_loc5_);
            }
            else
            {
               addRegion(_loc11_,_loc15_,null,_loc5_);
            }
            if(_loc7_ != 0 || _loc6_ != 0)
            {
               Image.bindPivotPointToTexture(getTexture(_loc11_),_loc7_,_loc6_);
            }
         }
      }
      
      public function getTexture(param1:String) : Texture
      {
         return _subTextures[param1];
      }
      
      public function getTextures(param1:String = "", param2:Vector.<Texture> = null) : Vector.<Texture>
      {
         if(param2 == null)
         {
            param2 = new Vector.<Texture>(0);
         }
         var _loc5_:int = 0;
         var _loc4_:* = getNames(param1,sNames);
         for each(var _loc3_ in getNames(param1,sNames))
         {
            param2[param2.length] = getTexture(_loc3_);
         }
         sNames.length = 0;
         return param2;
      }
      
      public function getNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         var _loc3_:* = null;
         if(param2 == null)
         {
            param2 = new Vector.<String>(0);
         }
         if(_subTextureNames == null)
         {
            _subTextureNames = new Vector.<String>(0);
            var _loc5_:int = 0;
            var _loc4_:* = _subTextures;
            for(_subTextureNames[_subTextureNames.length] in _subTextures)
            {
            }
            _subTextureNames.sort(1);
         }
         var _loc7_:int = 0;
         var _loc6_:* = _subTextureNames;
         for each(_loc3_ in _subTextureNames)
         {
            if(_loc3_.indexOf(param1) == 0)
            {
               param2[param2.length] = _loc3_;
            }
         }
         return param2;
      }
      
      public function getRegion(param1:String) : Rectangle
      {
         var _loc2_:SubTexture = _subTextures[param1];
         return !!_loc2_?_loc2_.region:null;
      }
      
      public function getFrame(param1:String) : Rectangle
      {
         var _loc2_:SubTexture = _subTextures[param1];
         return !!_loc2_?_loc2_.frame:null;
      }
      
      public function getRotation(param1:String) : Boolean
      {
         var _loc2_:SubTexture = _subTextures[param1];
         return !!_loc2_?_loc2_.rotated:false;
      }
      
      public function addRegion(param1:String, param2:Rectangle, param3:Rectangle = null, param4:Boolean = false) : void
      {
         addSubTexture(param1,new SubTexture(_atlasTexture,param2,false,param3,param4));
      }
      
      public function addSubTexture(param1:String, param2:SubTexture) : void
      {
         if(param2.root != _atlasTexture.root)
         {
            throw new ArgumentError("SubTexture\'s root must be atlas texture.");
         }
         _subTextures[param1] = param2;
         _subTextureNames = null;
      }
      
      public function removeRegion(param1:String) : void
      {
         var _loc2_:SubTexture = _subTextures[param1];
         if(_loc2_)
         {
            _loc2_.dispose();
         }
         delete _subTextures[param1];
         _subTextureNames = null;
      }
      
      public function get texture() : Texture
      {
         return _atlasTexture;
      }
   }
}
