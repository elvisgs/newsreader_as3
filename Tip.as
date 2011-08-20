package {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.filters.DropShadowFilter;
	
	public class Tip extends Sprite {
		private var _txt:String;
		private var txtFTip:TextField;
		
		public function Tip(txt:String = "") {
			_txt = txt;
			init();
		}
		
		public function init():void {
			graphics.lineStyle(1, 0xCCCCCC);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, 200, 25);
			graphics.endFill();
			
			txtFTip = new TextField();
			
			var format:TextFormat = new TextFormat();
			format.font = "Courier New";
			format.color = 0x000000;
			format.size = 10;
			format.align = TextFormatAlign.CENTER;
			
			txtFTip.defaultTextFormat = format;
			txtFTip.wordWrap = true;
			txtFTip.width = 200;
			txtFTip.height = 30;
			addChild(txtFTip);
			
			this.filters = [ new DropShadowFilter(4, 45, 0, .6) ];
		}
		
		public function set txt(t:String):void {
			_txt = t;
			
			txtFTip.text = _txt;
		}
		
		public function get txt():String {
			return _txt;
		}
	}
}
			