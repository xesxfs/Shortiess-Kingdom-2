package
{
   public class EmbeddedAssets
   {
      
      public static const art:Class = EmbeddedAssets_art;
      
      public static const artXml:Class = EmbeddedAssets_artXml;
      
      public static const art2:Class = EmbeddedAssets_art2;
      
      public static const artXml2:Class = EmbeddedAssets_artXml2;
      
      public static const _PNG:Class = EmbeddedAssets__PNG;
      
      public static const _JS:Class = EmbeddedAssets__JS;
      
      public static const Warriors:Class = EmbeddedAssets_Warriors;
      
      public static const _PNG2:Class = EmbeddedAssets__PNG2;
      
      public static const _JS2:Class = EmbeddedAssets__JS2;
      
      public static const SwampEn:Class = EmbeddedAssets_SwampEn;
      
      public static const back_1:Class = EmbeddedAssets_back_1;
      
      public static const landscape_1:Class = EmbeddedAssets_landscape_1;
      
      public static const ground_1:Class = EmbeddedAssets_ground_1;
      
      public static const _PNG3:Class = EmbeddedAssets__PNG3;
      
      public static const _JS3:Class = EmbeddedAssets__JS3;
      
      public static const DesetrEn:Class = EmbeddedAssets_DesetrEn;
      
      public static const back_2:Class = EmbeddedAssets_back_2;
      
      public static const landscape_2:Class = EmbeddedAssets_landscape_2;
      
      public static const ground_2:Class = EmbeddedAssets_ground_2;
      
      public static const _PNG4:Class = EmbeddedAssets__PNG4;
      
      public static const _JS4:Class = EmbeddedAssets__JS4;
      
      public static const ForestEn:Class = EmbeddedAssets_ForestEn;
      
      public static const back_3:Class = EmbeddedAssets_back_3;
      
      public static const landscape_3:Class = EmbeddedAssets_landscape_3;
      
      public static const ground_3:Class = EmbeddedAssets_ground_3;
      
      public static const _PNG5:Class = EmbeddedAssets__PNG5;
      
      public static const _JS5:Class = EmbeddedAssets__JS5;
      
      public static const LairEn:Class = EmbeddedAssets_LairEn;
      
      public static const back_4:Class = EmbeddedAssets_back_4;
      
      public static const landscape_4:Class = EmbeddedAssets_landscape_4;
      
      public static const ground_4:Class = EmbeddedAssets_ground_4;
      
      public static const _PNG6:Class = EmbeddedAssets__PNG6;
      
      public static const _JS6:Class = EmbeddedAssets__JS6;
      
      public static const BlackEn:Class = EmbeddedAssets_BlackEn;
      
      public static const back_5:Class = EmbeddedAssets_back_5;
      
      public static const landscape_5:Class = EmbeddedAssets_landscape_5;
      
      public static const ground_5:Class = EmbeddedAssets_ground_5;
      
      public static const DeathDust1:Class = EmbeddedAssets_DeathDust1;
      
      public static const Blood:Class = EmbeddedAssets_Blood;
      
      public static const FireGround:Class = EmbeddedAssets_FireGround;
      
      public static var MyFont1:Class = EmbeddedAssets_MyFont1;
      
      public static const RXml:Class = EmbeddedAssets_RXml;
      
      public static const RedFont:Class = EmbeddedAssets_RedFont;
      
      public static const WXml:Class = EmbeddedAssets_WXml;
      
      public static const WhiteFont:Class = EmbeddedAssets_WhiteFont;
      
      public static const YXml:Class = EmbeddedAssets_YXml;
      
      public static const YellowFont:Class = EmbeddedAssets_YellowFont;
      
      public static const YNXml:Class = EmbeddedAssets_YNXml;
      
      public static const NormalТNum:Class = EmbeddedAssets_NormalТNum;
      
      public static const RNXml:Class = EmbeddedAssets_RNXml;
      
      public static const RedNum:Class = EmbeddedAssets_RedNum;
      
      public static const GNXml:Class = EmbeddedAssets_GNXml;
      
      public static const GreenNum:Class = EmbeddedAssets_GreenNum;
      
      {
         GV.factory.parseDragonBonesData(JSON.parse(new Warriors()),"Warriors");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS()),new _PNG());
         GV.factory.parseDragonBonesData(JSON.parse(new SwampEn()),"Swamp");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS2()),new _PNG2());
         GV.factory.parseDragonBonesData(JSON.parse(new DesetrEn()),"Desert");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS3()),new _PNG3());
         GV.factory.parseDragonBonesData(JSON.parse(new ForestEn()),"Forest");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS4()),new _PNG4());
         GV.factory.parseDragonBonesData(JSON.parse(new LairEn()),"Lair");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS5()),new _PNG5());
         GV.factory.parseDragonBonesData(JSON.parse(new BlackEn()),"Black");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS6()),new _PNG6());
      }
      
      public function EmbeddedAssets()
      {
         super();
      }
   }
}
