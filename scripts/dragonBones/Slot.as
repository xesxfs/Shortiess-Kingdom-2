package dragonBones
{
   import dragonBones.core.DragonBones;
   import dragonBones.core.TransformObject;
   import dragonBones.§core:dragonBones_internal§.*;
   import dragonBones.enum.BlendMode;
   import dragonBones.geom.Transform;
   import dragonBones.objects.ActionData;
   import dragonBones.objects.BoundingBoxData;
   import dragonBones.objects.DisplayData;
   import dragonBones.objects.MeshData;
   import dragonBones.objects.SkinSlotData;
   import dragonBones.objects.SlotData;
   import dragonBones.textures.TextureData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Slot extends TransformObject
   {
      
      protected static const _helpPoint:Point = new Point();
      
      protected static const _helpMatrix:Matrix = new Matrix();
       
      
      public var displayController:String;
      
      protected var _displayDirty:Boolean;
      
      protected var _zOrderDirty:Boolean;
      
      protected var _blendModeDirty:Boolean;
      
      var _colorDirty:Boolean;
      
      var _meshDirty:Boolean;
      
      protected var _originalDirty:Boolean;
      
      protected var _transformDirty:Boolean;
      
      protected var _updateState:int;
      
      protected var _blendMode:int;
      
      protected var _displayIndex:int;
      
      var _zOrder:int;
      
      protected var _cachedFrameIndex:int;
      
      var _pivotX:Number;
      
      var _pivotY:Number;
      
      protected const _localMatrix:Matrix = new Matrix();
      
      const _colorTransform:ColorTransform = new ColorTransform();
      
      const _ffdVertices:Vector.<Number> = new Vector.<Number>();
      
      protected const _displayList:Vector.<Object> = new Vector.<Object>();
      
      const _replacedDisplayDatas:Vector.<DisplayData> = new Vector.<DisplayData>();
      
      protected const _meshBones:Vector.<Bone> = new Vector.<Bone>();
      
      protected var _skinSlotData:SkinSlotData;
      
      protected var _displayData:DisplayData;
      
      protected var _replacedDisplayData:DisplayData;
      
      protected var _textureData:TextureData;
      
      var _meshData:MeshData;
      
      protected var _boundingBoxData:BoundingBoxData;
      
      protected var _rawDisplay:Object;
      
      protected var _meshDisplay:Object;
      
      protected var _display:Object;
      
      var _childArmature:Armature;
      
      var _cachedFrameIndices:Vector.<int>;
      
      public function Slot(param1:Slot)
      {
         super(param1);
         if(param1 != this)
         {
            throw new Error(DragonBones.ABSTRACT_CLASS_ERROR);
         }
      }
      
      override protected function _onClear() : void
      {
         var _loc4_:Object = null;
         super._onClear();
         var _loc1_:Vector.<Object> = new Vector.<Object>();
         var _loc2_:uint = 0;
         var _loc3_:uint = this._displayList.length;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this._displayList[_loc2_];
            if(_loc4_ != this._rawDisplay && _loc4_ != this._meshDisplay && _loc1_.indexOf(_loc4_) < 0)
            {
               _loc1_.push(_loc4_);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         _loc3_ = _loc1_.length;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc1_[_loc2_];
            if(_loc4_ is Armature)
            {
               (_loc4_ as Armature).dispose();
            }
            else
            {
               this._disposeDisplay(_loc4_);
            }
            _loc2_++;
         }
         if(this._meshDisplay && this._meshDisplay != this._rawDisplay)
         {
            this._disposeDisplay(this._meshDisplay);
         }
         if(this._rawDisplay)
         {
            this._disposeDisplay(this._rawDisplay);
         }
         this.displayController = null;
         this._displayDirty = false;
         this._zOrderDirty = false;
         this._blendModeDirty = false;
         this._colorDirty = false;
         this._meshDirty = false;
         this._originalDirty = false;
         this._transformDirty = false;
         this._updateState = -1;
         this._blendMode = BlendMode.Normal;
         this._displayIndex = -1;
         this._zOrder = 0;
         this._pivotX = 0;
         this._pivotY = 0;
         this._localMatrix.identity();
         this._colorTransform.alphaMultiplier = 1;
         this._colorTransform.redMultiplier = 1;
         this._colorTransform.greenMultiplier = 1;
         this._colorTransform.blueMultiplier = 1;
         this._colorTransform.alphaOffset = 0;
         this._colorTransform.redOffset = 0;
         this._colorTransform.greenOffset = 0;
         this._colorTransform.blueOffset = 0;
         this._ffdVertices.length = 0;
         this._displayList.length = 0;
         this._replacedDisplayDatas.length = 0;
         this._meshBones.length = 0;
         this._skinSlotData = null;
         this._displayData = null;
         this._replacedDisplayData = null;
         this._textureData = null;
         this._meshData = null;
         this._boundingBoxData = null;
         this._rawDisplay = null;
         this._meshDisplay = null;
         this._display = null;
         this._childArmature = null;
         this._cachedFrameIndices = null;
      }
      
      protected function _initDisplay(param1:Object) : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _disposeDisplay(param1:Object) : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _onUpdateDisplay() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _addDisplay() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _replaceDisplay(param1:Object) : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _removeDisplay() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _updateZOrder() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      function _updateVisible() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _updateBlendMode() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _updateColor() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _updateFilters() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _updateFrame() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _updateMesh() : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _updateTransform(param1:Boolean) : void
      {
         throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
      }
      
      protected function _isMeshBonesUpdate() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = this._meshBones.length;
         while(_loc1_ < _loc2_)
         {
            if(this._meshBones[_loc1_]._transformDirty != 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function _updateDisplayData() : void
      {
         var _loc6_:DisplayData = null;
         var _loc7_:Number = NaN;
         var _loc8_:Rectangle = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc1_:DisplayData = this._displayData;
         var _loc2_:DisplayData = this._replacedDisplayData;
         var _loc3_:TextureData = this._textureData;
         var _loc4_:MeshData = this._meshData;
         var _loc5_:Object = this._displayIndex >= 0 && this._displayIndex < this._displayList.length?this._displayList[this._displayIndex]:null;
         if(this._displayIndex >= 0 && this._displayIndex < this._skinSlotData.displays.length)
         {
            this._displayData = this._skinSlotData.displays[this._displayIndex];
         }
         else
         {
            this._displayData = null;
         }
         if(this._displayIndex >= 0 && this._displayIndex < this._replacedDisplayDatas.length)
         {
            this._replacedDisplayData = this._replacedDisplayDatas[this._displayIndex];
         }
         else
         {
            this._replacedDisplayData = null;
         }
         if(this._displayData !== _loc1_ || this._replacedDisplayData !== _loc2_ || this._display !== _loc5_)
         {
            _loc6_ = !!this._replacedDisplayData?this._replacedDisplayData:this._displayData;
            if(_loc6_ && (_loc5_ === this._rawDisplay || _loc5_ === this._meshDisplay))
            {
               this._textureData = !!this._replacedDisplayData?this._replacedDisplayData.texture:this._displayData.texture;
               if(_loc5_ === this._meshDisplay)
               {
                  if(this._replacedDisplayData && this._replacedDisplayData.mesh)
                  {
                     this._meshData = this._replacedDisplayData.mesh;
                  }
                  else
                  {
                     this._meshData = this._displayData.mesh;
                  }
               }
               else
               {
                  this._meshData = null;
               }
               if(this._meshData)
               {
                  this._pivotX = 0;
                  this._pivotY = 0;
               }
               else if(this._textureData)
               {
                  _loc7_ = _armature.armatureData.scale;
                  this._pivotX = _loc6_.pivot.x;
                  this._pivotY = _loc6_.pivot.y;
                  if(_loc6_.isRelativePivot)
                  {
                     _loc8_ = !!this._textureData.frame?this._textureData.frame:this._textureData.region;
                     _loc9_ = _loc8_.width * _loc7_;
                     _loc10_ = _loc8_.height * _loc7_;
                     if(this._textureData.rotated)
                     {
                        _loc9_ = _loc8_.height;
                        _loc10_ = _loc8_.width;
                     }
                     this._pivotX = this._pivotX * _loc9_;
                     this._pivotY = this._pivotY * _loc10_;
                  }
                  if(this._textureData.frame)
                  {
                     this._pivotX = this._pivotX + this._textureData.frame.x * _loc7_;
                     this._pivotY = this._pivotY + this._textureData.frame.y * _loc7_;
                  }
               }
               else
               {
                  this._pivotX = 0;
                  this._pivotY = 0;
               }
               if(this._displayData && _loc6_ !== this._displayData && (!this._meshData || this._meshData !== this._displayData.mesh))
               {
                  this._displayData.transform.toMatrix(_helpMatrix);
                  _helpMatrix.invert();
                  Transform.transformPoint(_helpMatrix,0,0,_helpPoint);
                  this._pivotX = this._pivotX - _helpPoint.x;
                  this._pivotY = this._pivotY - _helpPoint.y;
                  _loc6_.transform.toMatrix(_helpMatrix);
                  _helpMatrix.invert();
                  Transform.transformPoint(_helpMatrix,0,0,_helpPoint);
                  this._pivotX = this._pivotX + _helpPoint.x;
                  this._pivotY = this._pivotY + _helpPoint.y;
               }
               if(this._meshData !== _loc4_)
               {
                  if(this._meshData && this._displayData && this._meshData === this._displayData.mesh)
                  {
                     if(this._meshData.skinned)
                     {
                        this._meshBones.length = this._meshData.bones.length;
                        _loc11_ = 0;
                        _loc12_ = this._meshBones.length;
                        while(_loc11_ < _loc12_)
                        {
                           this._meshBones[_loc11_] = _armature.getBone(this._meshData.bones[_loc11_].name);
                           _loc11_++;
                        }
                        _loc13_ = 0;
                        _loc11_ = 0;
                        _loc12_ = this._meshData.boneIndices.length;
                        while(_loc11_ < _loc12_)
                        {
                           _loc13_ = _loc13_ + this._meshData.boneIndices[_loc11_].length;
                           _loc11_++;
                        }
                        this._ffdVertices.length = _loc13_ * 2;
                     }
                     else
                     {
                        this._meshBones.length = 0;
                        this._ffdVertices.length = this._meshData.vertices.length;
                     }
                     _loc11_ = 0;
                     _loc12_ = this._ffdVertices.length;
                     while(_loc11_ < _loc12_)
                     {
                        this._ffdVertices[_loc11_] = 0;
                        _loc11_++;
                     }
                     this._meshDirty = true;
                  }
                  else
                  {
                     this._meshBones.length = 0;
                     this._ffdVertices.length = 0;
                  }
               }
               else if(this._textureData != _loc3_)
               {
                  this._meshDirty = true;
               }
            }
            else
            {
               this._textureData = null;
               this._meshData = null;
               this._pivotX = 0;
               this._pivotY = 0;
               this._meshBones.length = 0;
               this._ffdVertices.length = 0;
            }
            this._displayDirty = true;
            this._originalDirty = true;
            if(this._displayData)
            {
               origin = this._displayData.transform;
            }
            else if(this._replacedDisplayData)
            {
               origin = this._replacedDisplayData.transform;
            }
         }
         if(this._replacedDisplayData)
         {
            this._boundingBoxData = this._replacedDisplayData.boundingBox;
         }
         else if(this._displayData)
         {
            this._boundingBoxData = this._displayData.boundingBox;
         }
         else
         {
            this._boundingBoxData = null;
         }
      }
      
      protected function _updateDisplay() : void
      {
         var _loc4_:Vector.<ActionData> = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc1_:Object = this._display || this._rawDisplay;
         var _loc2_:Armature = this._childArmature;
         if(this._displayIndex >= 0 && this._displayIndex < this._displayList.length)
         {
            this._display = this._displayList[this._displayIndex];
            if(this._display is Armature)
            {
               this._childArmature = this._display as Armature;
               this._display = this._childArmature.display;
            }
            else
            {
               this._childArmature = null;
            }
         }
         else
         {
            this._display = null;
            this._childArmature = null;
         }
         var _loc3_:Object = this._display || this._rawDisplay;
         if(_loc3_ != _loc1_)
         {
            this._onUpdateDisplay();
            if(_loc1_)
            {
               this._replaceDisplay(_loc1_);
            }
            else
            {
               this._addDisplay();
            }
            this._blendModeDirty = true;
            this._colorDirty = true;
         }
         if(_loc3_ == this._rawDisplay || _loc3_ == this._meshDisplay)
         {
            this._updateFrame();
         }
         if(this._childArmature != _loc2_)
         {
            if(_loc2_)
            {
               _loc2_._parent = null;
               _loc2_.clock = null;
               if(_loc2_.inheritAnimation)
               {
                  _loc2_.animation.reset();
               }
            }
            if(this._childArmature)
            {
               this._childArmature._parent = this;
               this._childArmature.clock = _armature.clock;
               if(this._childArmature.inheritAnimation)
               {
                  if(this._childArmature.cacheFrameRate == 0)
                  {
                     _loc5_ = _armature.cacheFrameRate;
                     if(_loc5_ != 0)
                     {
                        this._childArmature.cacheFrameRate = _loc5_;
                     }
                  }
                  _loc4_ = this._skinSlotData.slot.actions.length > 0?this._skinSlotData.slot.actions:this._childArmature.armatureData.actions;
                  if(_loc4_.length > 0)
                  {
                     _loc6_ = 0;
                     _loc7_ = _loc4_.length;
                     while(_loc6_ < _loc7_)
                     {
                        this._childArmature._bufferAction(_loc4_[_loc6_]);
                        _loc6_++;
                     }
                  }
                  else
                  {
                     this._childArmature.animation.play();
                  }
               }
            }
         }
      }
      
      protected function _updateLocalTransformMatrix() : void
      {
         if(origin)
         {
            global.copyFrom(origin).add(offset).toMatrix(this._localMatrix);
         }
         else
         {
            global.copyFrom(offset).toMatrix(this._localMatrix);
         }
      }
      
      protected function _updateGlobalTransformMatrix() : void
      {
         globalTransformMatrix.copyFrom(this._localMatrix);
         globalTransformMatrix.concat(_parent.globalTransformMatrix);
         global.fromMatrix(globalTransformMatrix);
      }
      
      function _init(param1:SkinSlotData, param2:Object, param3:Object) : void
      {
         if(this._skinSlotData)
         {
            return;
         }
         this._skinSlotData = param1;
         var _loc4_:SlotData = this._skinSlotData.slot;
         name = _loc4_.name;
         this._zOrder = _loc4_.zOrder;
         this._blendMode = _loc4_.blendMode;
         this._colorTransform.alphaMultiplier = _loc4_.color.alphaMultiplier;
         this._colorTransform.redMultiplier = _loc4_.color.redMultiplier;
         this._colorTransform.greenMultiplier = _loc4_.color.greenMultiplier;
         this._colorTransform.blueMultiplier = _loc4_.color.blueMultiplier;
         this._colorTransform.alphaOffset = _loc4_.color.alphaOffset;
         this._colorTransform.redOffset = _loc4_.color.redOffset;
         this._colorTransform.greenOffset = _loc4_.color.greenOffset;
         this._colorTransform.blueOffset = _loc4_.color.blueOffset;
         this._rawDisplay = param2;
         this._meshDisplay = param3;
         this._blendModeDirty = true;
         this._colorDirty = true;
      }
      
      override function _setArmature(param1:Armature) : void
      {
         if(_armature === param1)
         {
            return;
         }
         if(_armature)
         {
            _armature._removeSlotFromSlotList(this);
         }
         _armature = param1;
         this._onUpdateDisplay();
         if(_armature)
         {
            _armature._addSlotToSlotList(this);
            this._addDisplay();
         }
         else
         {
            this._removeDisplay();
         }
      }
      
      function _update(param1:int) : void
      {
         var _loc2_:int = 0;
         this._updateState = -1;
         if(this._displayDirty)
         {
            this._displayDirty = false;
            this._updateDisplay();
         }
         if(this._zOrderDirty)
         {
            this._zOrderDirty = false;
            this._updateZOrder();
         }
         if(!this._display)
         {
            return;
         }
         if(this._blendModeDirty)
         {
            this._blendModeDirty = false;
            this._updateBlendMode();
         }
         if(this._colorDirty)
         {
            this._colorDirty = false;
            this._updateColor();
         }
         if(this._originalDirty)
         {
            this._originalDirty = false;
            this._transformDirty = true;
            this._updateLocalTransformMatrix();
         }
         if(param1 >= 0 && this._cachedFrameIndices)
         {
            _loc2_ = this._cachedFrameIndices[param1];
            if(_loc2_ >= 0 && this._cachedFrameIndex === _loc2_)
            {
               this._transformDirty = false;
            }
            else if(_loc2_ >= 0)
            {
               this._transformDirty = true;
               this._cachedFrameIndex = _loc2_;
            }
            else if(this._transformDirty || _parent._transformDirty !== 0)
            {
               this._transformDirty = true;
               this._cachedFrameIndex = -1;
            }
            else if(this._cachedFrameIndex >= 0)
            {
               this._transformDirty = false;
               this._cachedFrameIndices[param1] = this._cachedFrameIndex;
            }
            else
            {
               this._transformDirty = true;
               this._cachedFrameIndex = -1;
            }
         }
         else if(this._transformDirty || _parent._transformDirty !== 0)
         {
            param1 = -1;
            this._transformDirty = true;
            this._cachedFrameIndex = -1;
         }
         if(this._meshData && this._displayData && this._meshData === this._displayData.mesh)
         {
            if(this._meshDirty || this._meshData.skinned && this._isMeshBonesUpdate())
            {
               this._meshDirty = false;
               this._updateMesh();
            }
            if(this._meshData.skinned)
            {
               if(this._transformDirty)
               {
                  this._transformDirty = false;
                  this._updateTransform(true);
               }
               return;
            }
         }
         if(this._transformDirty)
         {
            this._transformDirty = false;
            if(this._cachedFrameIndex < 0)
            {
               this._updateGlobalTransformMatrix();
               if(param1 >= 0)
               {
                  this._cachedFrameIndex = this._cachedFrameIndices[param1] = _armature._armatureData.setCacheFrame(globalTransformMatrix,global);
               }
            }
            else
            {
               _armature._armatureData.getCacheFrame(globalTransformMatrix,global,this._cachedFrameIndex);
            }
            this._updateTransform(false);
            this._updateState = 0;
         }
      }
      
      function _updateTransformAndMatrix() : void
      {
         if(this._updateState < 0)
         {
            this._updateState = 0;
            this._updateLocalTransformMatrix();
            this._updateGlobalTransformMatrix();
         }
      }
      
      function _setDisplayList(param1:Vector.<Object>) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         if(param1 && param1.length)
         {
            if(this._displayList.length != param1.length)
            {
               this._displayList.length = param1.length;
            }
            _loc2_ = 0;
            _loc3_ = param1.length;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = param1[_loc2_];
               if(_loc4_ && _loc4_ != this._rawDisplay && _loc4_ != this._meshDisplay && !(_loc4_ is Armature) && this._displayList.indexOf(_loc4_) < 0)
               {
                  this._initDisplay(_loc4_);
               }
               this._displayList[_loc2_] = _loc4_;
               _loc2_++;
            }
         }
         else if(this._displayList.length > 0)
         {
            this._displayList.length = 0;
         }
         if(this._displayIndex >= 0 && this._displayIndex < this._displayList.length)
         {
            this._displayDirty = this._display != this._displayList[this._displayIndex];
         }
         else
         {
            this._displayDirty = this._display != null;
         }
         this._updateDisplayData();
         return this._displayDirty;
      }
      
      function _setDisplayIndex(param1:int) : Boolean
      {
         if(this._displayIndex == param1)
         {
            return false;
         }
         this._displayIndex = param1;
         this._displayDirty = true;
         this._updateDisplayData();
         return true;
      }
      
      function _setZorder(param1:Number) : Boolean
      {
         if(this._zOrder === param1)
         {
         }
         this._zOrder = param1;
         this._zOrderDirty = true;
         return true;
      }
      
      function _setColor(param1:ColorTransform) : Boolean
      {
         this._colorTransform.alphaMultiplier = param1.alphaMultiplier;
         this._colorTransform.redMultiplier = param1.redMultiplier;
         this._colorTransform.greenMultiplier = param1.greenMultiplier;
         this._colorTransform.blueMultiplier = param1.blueMultiplier;
         this._colorTransform.alphaOffset = param1.alphaOffset;
         this._colorTransform.redOffset = param1.redOffset;
         this._colorTransform.greenOffset = param1.greenOffset;
         this._colorTransform.blueOffset = param1.blueOffset;
         this._colorDirty = true;
         return true;
      }
      
      public function containsPoint(param1:Number, param2:Number) : Boolean
      {
         if(!this._boundingBoxData)
         {
            return false;
         }
         this._updateTransformAndMatrix();
         _helpMatrix.copyFrom(globalTransformMatrix);
         _helpMatrix.invert();
         Transform.transformPoint(_helpMatrix,param1,param2,_helpPoint);
         return this._boundingBoxData.containsPoint(_helpPoint.x,_helpPoint.y);
      }
      
      public function intersectsSegment(param1:Number, param2:Number, param3:Number, param4:Number, param5:Point = null, param6:Point = null, param7:Point = null) : int
      {
         if(!this._boundingBoxData)
         {
            return 0;
         }
         this._updateTransformAndMatrix();
         _helpMatrix.copyFrom(globalTransformMatrix);
         _helpMatrix.invert();
         Transform.transformPoint(_helpMatrix,param1,param2,_helpPoint);
         param1 = _helpPoint.x;
         param2 = _helpPoint.y;
         Transform.transformPoint(_helpMatrix,param3,param4,_helpPoint);
         param3 = _helpPoint.x;
         param4 = _helpPoint.y;
         var _loc8_:int = this._boundingBoxData.intersectsSegment(param1,param2,param3,param4,param5,param6,param7);
         if(_loc8_ > 0)
         {
            if(_loc8_ === 1 || _loc8_ === 2)
            {
               if(param5)
               {
                  Transform.transformPoint(globalTransformMatrix,param5.x,param5.y,param5);
                  if(param6)
                  {
                     param6.x = param5.x;
                     param6.y = param5.y;
                  }
               }
               else if(param6)
               {
                  Transform.transformPoint(globalTransformMatrix,param6.x,param6.y,param6);
               }
            }
            else
            {
               if(param5)
               {
                  Transform.transformPoint(globalTransformMatrix,param5.x,param5.y,param5);
               }
               if(param6)
               {
                  Transform.transformPoint(globalTransformMatrix,param6.x,param6.y,param6);
               }
            }
            if(param7)
            {
               Transform.transformPoint(globalTransformMatrix,Math.cos(param7.x),Math.sin(param7.x),_helpPoint,true);
               param7.x = Math.atan2(_helpPoint.y,_helpPoint.x);
               Transform.transformPoint(globalTransformMatrix,Math.cos(param7.y),Math.sin(param7.y),_helpPoint,true);
               param7.y = Math.atan2(_helpPoint.y,_helpPoint.x);
            }
         }
         return _loc8_;
      }
      
      public function invalidUpdate() : void
      {
         this._displayDirty = true;
         this._transformDirty = true;
      }
      
      public function get skinSlotData() : SkinSlotData
      {
         return this._skinSlotData;
      }
      
      public function get boundingBoxData() : BoundingBoxData
      {
         return this._boundingBoxData;
      }
      
      public function get rawDisplay() : Object
      {
         return this._rawDisplay;
      }
      
      public function get meshDisplay() : Object
      {
         return this._meshDisplay;
      }
      
      public function get displayIndex() : int
      {
         return this._displayIndex;
      }
      
      public function set displayIndex(param1:int) : void
      {
         if(this._setDisplayIndex(param1))
         {
            this._update(-1);
         }
      }
      
      public function get displayList() : Vector.<Object>
      {
         return this._displayList.concat();
      }
      
      public function set displayList(param1:Vector.<Object>) : void
      {
         var _loc6_:Object = null;
         var _loc2_:Vector.<Object> = this._displayList.concat();
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         if(this._setDisplayList(param1))
         {
            this._update(-1);
         }
         var _loc4_:uint = 0;
         var _loc5_:uint = _loc2_.length;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc2_[_loc4_];
            if(_loc6_ && _loc6_ != this._rawDisplay && this._displayList.indexOf(_loc6_) < 0)
            {
               if(_loc3_.indexOf(_loc6_) < 0)
               {
                  _loc3_.push(_loc6_);
               }
            }
            _loc4_++;
         }
         _loc4_ = 0;
         _loc5_ = _loc3_.length;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc3_[_loc4_];
            if(_loc6_ is Armature)
            {
               (_loc6_ as Armature).dispose();
            }
            else
            {
               this._disposeDisplay(_loc6_);
            }
            _loc4_++;
         }
      }
      
      public function get display() : Object
      {
         return this._display;
      }
      
      public function set display(param1:Object) : void
      {
         var _loc3_:Vector.<Object> = null;
         if(this._display === param1)
         {
            return;
         }
         var _loc2_:uint = this._displayList.length;
         if(this._displayIndex < 0 && _loc2_ === 0)
         {
            this._displayIndex = 0;
         }
         if(this._displayIndex < 0)
         {
            return;
         }
         _loc3_ = this.displayList;
         if(_loc2_ <= this._displayIndex)
         {
            _loc3_.length = this._displayIndex + 1;
         }
         _loc3_[this._displayIndex] = param1;
         this.displayList = _loc3_;
      }
      
      public function get childArmature() : Armature
      {
         return this._childArmature;
      }
      
      public function set childArmature(param1:Armature) : void
      {
         if(this._childArmature === param1)
         {
            return;
         }
         this.display = param1;
      }
   }
}
