package dragonBones.starling
{
   import dragonBones.Bone;
   import dragonBones.Slot;
   import dragonBones.core.BaseObject;
   import dragonBones.§core:dragonBones_internal§._armature;
   import dragonBones.§core:dragonBones_internal§._colorTransform;
   import dragonBones.§core:dragonBones_internal§._ffdVertices;
   import dragonBones.§core:dragonBones_internal§._meshData;
   import dragonBones.§core:dragonBones_internal§._parent;
   import dragonBones.§core:dragonBones_internal§._pivotX;
   import dragonBones.§core:dragonBones_internal§._pivotY;
   import dragonBones.§core:dragonBones_internal§._zOrder;
   import flash.geom.Matrix;
   import starling.display.BlendMode;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Mesh;
   import starling.display.Quad;
   import starling.rendering.IndexData;
   import starling.rendering.VertexData;
   import starling.styles.MeshStyle;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   
   public final class StarlingSlot extends Slot
   {
       
      
      public var transformUpdateEnabled:Boolean;
      
      var _indexData:IndexData;
      
      var _vertexData:VertexData;
      
      private var _renderDisplay:DisplayObject;
      
      public function StarlingSlot()
      {
         super(this);
      }
      
      override protected function _onClear() : void
      {
         super._onClear();
         this.transformUpdateEnabled = false;
         if(this._indexData)
         {
            this._indexData.clear();
            this._indexData = null;
         }
         if(this._vertexData)
         {
            this._vertexData.clear();
            this._vertexData = null;
         }
         this._renderDisplay = null;
      }
      
      override protected function _initDisplay(param1:Object) : void
      {
      }
      
      override protected function _disposeDisplay(param1:Object) : void
      {
         (param1 as DisplayObject).dispose();
      }
      
      override protected function _onUpdateDisplay() : void
      {
         this._renderDisplay = (!!_display?_display:_rawDisplay) as DisplayObject;
      }
      
      override protected function _addDisplay() : void
      {
         var _loc1_:StarlingArmatureDisplay = _armature.display as StarlingArmatureDisplay;
         _loc1_.addChild(this._renderDisplay);
      }
      
      override protected function _replaceDisplay(param1:Object) : void
      {
         var _loc2_:StarlingArmatureDisplay = _armature.display as StarlingArmatureDisplay;
         var _loc3_:DisplayObject = param1 as DisplayObject;
         _loc2_.addChild(this._renderDisplay);
         _loc2_.swapChildren(this._renderDisplay,_loc3_);
         _loc2_.removeChild(_loc3_);
      }
      
      override protected function _removeDisplay() : void
      {
         this._renderDisplay.removeFromParent();
      }
      
      override protected function _updateZOrder() : void
      {
         var _loc1_:StarlingArmatureDisplay = null;
         _loc1_ = _armature.display as StarlingArmatureDisplay;
         var _loc2_:int = _loc1_.getChildIndex(this._renderDisplay);
         if(_loc2_ === _zOrder)
         {
            return;
         }
         _loc1_.addChildAt(this._renderDisplay,_zOrder < _loc2_?int(_zOrder):int(_zOrder + 1));
      }
      
      override function _updateVisible() : void
      {
         this._renderDisplay.visible = _parent.visible;
      }
      
      override protected function _updateBlendMode() : void
      {
         switch(_blendMode)
         {
            case dragonBones.enum.BlendMode.Normal:
               this._renderDisplay.blendMode = starling.display.BlendMode.NORMAL;
               break;
            case dragonBones.enum.BlendMode.Add:
               this._renderDisplay.blendMode = starling.display.BlendMode.ADD;
               break;
            case dragonBones.enum.BlendMode.Erase:
               this._renderDisplay.blendMode = starling.display.BlendMode.ERASE;
               break;
            case dragonBones.enum.BlendMode.Multiply:
               this._renderDisplay.blendMode = starling.display.BlendMode.MULTIPLY;
               break;
            case dragonBones.enum.BlendMode.Screen:
               this._renderDisplay.blendMode = starling.display.BlendMode.SCREEN;
         }
      }
      
      override protected function _updateColor() : void
      {
         var _loc2_:uint = 0;
         this._renderDisplay.alpha = _colorTransform.alphaMultiplier;
         var _loc1_:Quad = this._renderDisplay as Quad;
         if(_loc1_)
         {
            _loc2_ = (uint(_colorTransform.redMultiplier * 255) << 16) + (uint(_colorTransform.greenMultiplier * 255) << 8) + uint(_colorTransform.blueMultiplier * 255);
            if(_loc1_.color != _loc2_)
            {
               _loc1_.color = _loc2_;
            }
         }
      }
      
      override protected function _updateFrame() : void
      {
         var _loc3_:StarlingTextureAtlasData = null;
         var _loc4_:Texture = null;
         var _loc5_:Mesh = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:MeshStyle = null;
         var _loc9_:uint = 0;
         var _loc10_:Image = null;
         var _loc1_:Boolean = _meshData && this._renderDisplay === _meshDisplay;
         var _loc2_:StarlingTextureData = _textureData as StarlingTextureData;
         if(_displayIndex >= 0 && _display && _loc2_)
         {
            _loc3_ = _loc2_.parent as StarlingTextureAtlasData;
            if(_armature.replacedTexture && _displayData && _loc3_ === _displayData.texture.parent)
            {
               _loc3_ = _armature._replaceTextureAtlasData as StarlingTextureAtlasData;
               if(!_loc3_)
               {
                  _loc3_ = BaseObject.borrowObject(StarlingTextureAtlasData) as StarlingTextureAtlasData;
                  _loc3_.copyFrom(_textureData.parent);
                  _loc3_.texture = _armature.replacedTexture as Texture;
                  _armature._replaceTextureAtlasData = _loc3_;
               }
               _loc2_ = _loc3_.getTexture(_loc2_.name) as StarlingTextureData;
            }
            _loc4_ = _loc3_.texture;
            if(_loc4_)
            {
               if(!_loc2_.texture)
               {
                  _loc2_.texture = new SubTexture(_loc4_,_loc2_.region,false,null,_loc2_.rotated);
               }
               if(_loc1_)
               {
                  _loc5_ = _meshDisplay as Mesh;
                  this._indexData.clear();
                  this._vertexData.clear();
                  _loc6_ = 0;
                  _loc7_ = _meshData.vertexIndices.length;
                  while(_loc6_ < _loc7_)
                  {
                     this._indexData.setIndex(_loc6_,_meshData.vertexIndices[_loc6_]);
                     _loc6_++;
                  }
                  _loc8_ = _loc5_.style;
                  _loc6_ = 0;
                  _loc7_ = _meshData.uvs.length;
                  while(_loc6_ < _loc7_)
                  {
                     _loc9_ = _loc6_ / 2;
                     _loc8_.setTexCoords(_loc9_,_meshData.uvs[_loc6_],_meshData.uvs[_loc6_ + 1]);
                     _loc8_.setVertexPosition(_loc9_,_meshData.vertices[_loc6_],_meshData.vertices[_loc6_ + 1]);
                     _loc6_ = _loc6_ + 2;
                  }
                  _loc5_.texture = _loc2_.texture;
               }
               else
               {
                  _loc10_ = this._renderDisplay as Image;
                  _loc10_.texture = _loc2_.texture;
                  _loc10_.readjustSize();
               }
               this._updateVisible();
               return;
            }
         }
         if(_loc1_)
         {
            _loc5_ = this._renderDisplay as Mesh;
            _loc5_.visible = false;
            _loc5_.texture = null;
            _loc5_.x = 0;
            _loc5_.y = 0;
         }
         else
         {
            _loc10_ = this._renderDisplay as Image;
            _loc10_.visible = false;
            _loc10_.texture = null;
            _loc10_.readjustSize();
            _loc10_.x = 0;
            _loc10_.y = 0;
         }
      }
      
      override protected function _updateMesh() : void
      {
         var _loc1_:Mesh = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<Number> = null;
         var _loc12_:Vector.<Number> = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Bone = null;
         var _loc16_:Matrix = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Vector.<Number> = null;
         _loc1_ = this._renderDisplay as Mesh;
         var _loc2_:MeshStyle = _loc1_.style;
         var _loc3_:* = _ffdVertices.length > 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = _meshData.vertices.length;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         if(_meshData.skinned)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc5_ = _loc4_ / 2;
               _loc10_ = _meshData.boneIndices[_loc5_];
               _loc11_ = _meshData.boneVertices[_loc5_];
               _loc12_ = _meshData.weights[_loc5_];
               _loc8_ = 0;
               _loc9_ = 0;
               _loc13_ = 0;
               _loc14_ = _loc10_.length;
               while(_loc13_ < _loc14_)
               {
                  _loc15_ = _meshBones[_loc10_[_loc13_]];
                  _loc16_ = _loc15_.globalTransformMatrix;
                  _loc17_ = _loc12_[_loc13_];
                  _loc18_ = 0;
                  _loc19_ = 0;
                  if(_loc3_)
                  {
                     _loc18_ = _loc11_[_loc13_ * 2] + _ffdVertices[_loc6_];
                     _loc19_ = _loc11_[_loc13_ * 2 + 1] + _ffdVertices[_loc6_ + 1];
                  }
                  else
                  {
                     _loc18_ = _loc11_[_loc13_ * 2];
                     _loc19_ = _loc11_[_loc13_ * 2 + 1];
                  }
                  _loc8_ = _loc8_ + (_loc16_.a * _loc18_ + _loc16_.c * _loc19_ + _loc16_.tx) * _loc17_;
                  _loc9_ = _loc9_ + (_loc16_.b * _loc18_ + _loc16_.d * _loc19_ + _loc16_.ty) * _loc17_;
                  _loc6_ = _loc6_ + 2;
                  _loc13_++;
               }
               _loc2_.setVertexPosition(_loc5_,_loc8_,_loc9_);
               _loc4_ = _loc4_ + 2;
            }
         }
         else if(_loc3_)
         {
            _loc20_ = _meshData.vertices;
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc8_ = _loc20_[_loc4_] + _ffdVertices[_loc4_];
               _loc9_ = _loc20_[_loc4_ + 1] + _ffdVertices[_loc4_ + 1];
               _loc2_.setVertexPosition(_loc4_ / 2,_loc8_,_loc9_);
               _loc4_ = _loc4_ + 2;
            }
         }
      }
      
      override protected function _updateTransform(param1:Boolean) : void
      {
         var _loc2_:Matrix = null;
         if(param1)
         {
            _loc2_ = this._renderDisplay.transformationMatrix;
            _loc2_.identity();
            this._renderDisplay.transformationMatrix = _loc2_;
         }
         else if(this.transformUpdateEnabled)
         {
            this._renderDisplay.transformationMatrix = globalTransformMatrix;
            if(_pivotX != 0 || _pivotY != 0)
            {
               this._renderDisplay.pivotX = _pivotX;
               this._renderDisplay.pivotY = _pivotY;
            }
         }
         else
         {
            _loc2_ = this._renderDisplay.transformationMatrix;
            _loc2_.a = globalTransformMatrix.a;
            _loc2_.b = globalTransformMatrix.b;
            _loc2_.c = globalTransformMatrix.c;
            _loc2_.d = globalTransformMatrix.d;
            _loc2_.tx = globalTransformMatrix.tx - (globalTransformMatrix.a * _pivotX + globalTransformMatrix.c * _pivotY);
            _loc2_.ty = globalTransformMatrix.ty - (globalTransformMatrix.b * _pivotX + globalTransformMatrix.d * _pivotY);
            this._renderDisplay.setRequiresRedraw();
         }
      }
   }
}
