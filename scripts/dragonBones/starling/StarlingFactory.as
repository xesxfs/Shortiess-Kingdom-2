package dragonBones.starling
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.animation.WorldClock;
   import dragonBones.core.BaseObject;
   import dragonBones.§core:dragonBones_internal§.*;
   import dragonBones.enum.DisplayType;
   import dragonBones.factories.BaseFactory;
   import dragonBones.factories.BuildArmaturePackage;
   import dragonBones.objects.ActionData;
   import dragonBones.objects.DisplayData;
   import dragonBones.objects.SkinSlotData;
   import dragonBones.objects.SlotData;
   import dragonBones.parsers.DataParser;
   import dragonBones.textures.TextureAtlasData;
   import flash.display.BitmapData;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Mesh;
   import starling.events.EnterFrameEvent;
   import starling.rendering.IndexData;
   import starling.rendering.VertexData;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   
   public final class StarlingFactory extends BaseFactory
   {
      
      protected static const _eventManager:StarlingArmatureDisplay = new StarlingArmatureDisplay();
      
      static const _clock:WorldClock = new WorldClock();
      
      public static const factory:StarlingFactory = new StarlingFactory();
       
      
      public var generateMipMaps:Boolean = true;
      
      public function StarlingFactory(param1:DataParser = null)
      {
         super(this,param1);
      }
      
      protected static function _clockHandler(param1:EnterFrameEvent) : void
      {
         _clock.advanceTime(param1.passedTime);
      }
      
      override protected function _generateTextureAtlasData(param1:TextureAtlasData, param2:Object) : TextureAtlasData
      {
         if(param1)
         {
            if(param2 is BitmapData)
            {
               (param1 as StarlingTextureAtlasData).texture = Texture.fromBitmapData(param2 as BitmapData,this.generateMipMaps,false,param1.scale);
               (param1 as StarlingTextureAtlasData).disposeTexture = true;
            }
            else if(param2 is Texture)
            {
               (param1 as StarlingTextureAtlasData).texture = param2 as Texture;
            }
         }
         else
         {
            param1 = BaseObject.borrowObject(StarlingTextureAtlasData) as StarlingTextureAtlasData;
         }
         return param1;
      }
      
      override protected function _generateArmature(param1:BuildArmaturePackage) : Armature
      {
         if(Starling.current && !Starling.current.stage.hasEventListener(EnterFrameEvent.ENTER_FRAME))
         {
            Starling.current.stage.addEventListener(EnterFrameEvent.ENTER_FRAME,_clockHandler);
         }
         var _loc2_:Armature = BaseObject.borrowObject(Armature) as Armature;
         var _loc3_:StarlingArmatureDisplay = new StarlingArmatureDisplay();
         _loc3_._armature = _loc2_;
         _loc2_._init(param1.armature,param1.skin,_loc3_,_loc3_,_eventManager);
         return _loc2_;
      }
      
      override protected function _generateSlot(param1:BuildArmaturePackage, param2:SkinSlotData, param3:Armature) : Slot
      {
         var _loc9_:DisplayData = null;
         var _loc10_:Armature = null;
         var _loc11_:Vector.<ActionData> = null;
         var _loc12_:ActionData = null;
         var _loc4_:StarlingSlot = BaseObject.borrowObject(StarlingSlot) as StarlingSlot;
         var _loc5_:SlotData = param2.slot;
         var _loc6_:Vector.<Object> = new Vector.<Object>(param2.displays.length,true);
         _loc4_._indexData = new IndexData();
         _loc4_._vertexData = new VertexData();
         _loc4_._init(param2,new Image(null),new Mesh(_loc4_._vertexData,_loc4_._indexData));
         var _loc7_:uint = 0;
         var _loc8_:uint = param2.displays.length;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = param2.displays[_loc7_];
            switch(_loc9_.type)
            {
               case DisplayType.Image:
                  if(!_loc9_.texture || param1.textureAtlasName)
                  {
                     _loc9_.texture = _getTextureData(param1.textureAtlasName || param1.dataName,_loc9_.name);
                  }
                  _loc6_[_loc7_] = _loc4_.rawDisplay;
                  break;
               case DisplayType.Mesh:
                  if(!_loc9_.texture)
                  {
                     _loc9_.texture = _getTextureData(param1.textureAtlasName || param1.dataName,_loc9_.name);
                  }
                  _loc6_[_loc7_] = _loc4_.meshDisplay;
                  break;
               case DisplayType.Armature:
                  _loc10_ = buildArmature(_loc9_.name,param1.dataName,null,param1.textureAtlasName);
                  if(_loc10_)
                  {
                     if(!_loc10_.inheritAnimation)
                     {
                        _loc11_ = _loc5_.actions.length > 0?_loc5_.actions:_loc10_.armatureData.actions;
                        if(_loc11_.length > 0)
                        {
                           for each(_loc12_ in _loc11_)
                           {
                              _loc10_._bufferAction(_loc12_);
                           }
                        }
                        else
                        {
                           _loc10_.animation.play();
                        }
                     }
                     _loc9_.armature = _loc10_.armatureData;
                  }
                  _loc6_[_loc7_] = _loc10_;
                  break;
               default:
                  _loc6_[_loc7_] = null;
            }
            _loc7_++;
         }
         _loc4_._setDisplayList(_loc6_);
         return _loc4_;
      }
      
      public function buildArmatureDisplay(param1:String, param2:String = null, param3:String = null, param4:String = null) : StarlingArmatureDisplay
      {
         var _loc5_:Armature = buildArmature(param1,param2,param3,param4);
         if(_loc5_)
         {
            _clock.add(_loc5_);
            return _loc5_.display as StarlingArmatureDisplay;
         }
         return null;
      }
      
      public function getTextureDisplay(param1:String, param2:String = null) : Image
      {
         var _loc4_:Texture = null;
         var _loc3_:StarlingTextureData = _getTextureData(param2,param1) as StarlingTextureData;
         if(_loc3_)
         {
            if(!_loc3_.texture)
            {
               _loc4_ = (_loc3_.parent as StarlingTextureAtlasData).texture;
               _loc3_.texture = new SubTexture(_loc4_,_loc3_.region,false,null,_loc3_.rotated);
            }
            return new Image(_loc3_.texture);
         }
         return null;
      }
      
      public function get soundEventManager() : StarlingArmatureDisplay
      {
         return _eventManager;
      }
   }
}
