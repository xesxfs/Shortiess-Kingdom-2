package dragonBones.core
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.geom.Transform;
   import flash.geom.Matrix;
   
   public class TransformObject extends BaseObject
   {
       
      
      public var name:String;
      
      public const globalTransformMatrix:Matrix = new Matrix();
      
      public const global:Transform = new Transform();
      
      public const offset:Transform = new Transform();
      
      public var origin:Transform;
      
      public var userData:Object;
      
      var _armature:Armature;
      
      var _parent:Bone;
      
      public function TransformObject(param1:TransformObject)
      {
         super(this);
         if(param1 != this)
         {
            throw new Error(DragonBones.ABSTRACT_CLASS_ERROR);
         }
      }
      
      override protected function _onClear() : void
      {
         this.name = null;
         this.globalTransformMatrix.identity();
         this.global.identity();
         this.offset.identity();
         this.origin = null;
         this.userData = null;
         this._armature = null;
         this._parent = null;
      }
      
      function _setArmature(param1:Armature) : void
      {
         this._armature = param1;
      }
      
      function _setParent(param1:Bone) : void
      {
         this._parent = param1;
      }
      
      public function get armature() : Armature
      {
         return this._armature;
      }
      
      public function get parent() : Bone
      {
         return this._parent;
      }
   }
}
