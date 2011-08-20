package {
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	
	public class Node extends Sprite {
		private var _title:String;
		private var _subtitle:String;
		private var _content:String;
		private var _image:Bitmap;
		private var _lastX:Number;
		private var _lastY:Number;
		private var _lastScaleX:Number;
		private var _lastScaleY:Number;
		private var _lastAlpha:Number;
		
		public function Node(title:String = "title", subtitle:String = "subtitle", content:String = "content", image:Bitmap = null) {
			_title = title;
			_subtitle = subtitle;
			_content = content;
			_image = image;
			init();
		}
		
		private function init():void {
			graphics.lineStyle(1, 0xAACCAA)
			graphics.drawRect(-203, -153, 406, 306);
			
			graphics.beginFill(0xAACCAA);
			graphics.drawRect(-200, -150, 400, 300);
			graphics.endFill();
						
			var txtTitle:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = 0xFFFFFF;
			format.size = 18;
			format.align = TextFormatAlign.LEFT;
			txtTitle.defaultTextFormat = format;
			txtTitle.text = _title;
			txtTitle.selectable = false;
			txtTitle.wordWrap = true;
			txtTitle.width = 380;
			txtTitle.height = 30;
			//txtTitle.background = true;
			//txtTitle.backgroundColor = 0x000000;
			txtTitle.x = -190;
			txtTitle.y = -150;
			addChild(txtTitle);
			
			var txtSubtitle:TextField = new TextField();
			format.font = "Arial";
			format.color = 0xFFFFFF;
			format.size = 12;
			format.align = TextFormatAlign.LEFT;
			txtSubtitle.defaultTextFormat = format;
			txtSubtitle.text = _subtitle;
			txtSubtitle.selectable = false;
			txtSubtitle.multiline = true;
			txtSubtitle.width = 380;
			txtSubtitle.height = 40;
			//txtSubtitle.background = true;
			//txtSubtitle.backgroundColor = 0x000000;
			txtSubtitle.x = -190;
			txtSubtitle.y = -130;
			addChild(txtSubtitle);
			
			var txtContent:TextField = new TextField();
			format.font = "Arial";
			format.color = 0xFFFFFF;
			format.size = 12;
			format.align = TextFormatAlign.JUSTIFY;
			txtContent.defaultTextFormat = format;
			txtContent.htmlText = _content;
			txtContent.selectable = false;
			txtContent.multiline = true;
			txtContent.wordWrap = true;
			txtContent.width = 380;
			txtContent.height = 220;
			txtContent.border = true;
			txtContent.borderColor = 0xFFFFFF;
			//txtContent.background = true;
			//txtContent.backgroundColor = 0x000000;
			txtContent.x = -190;
			txtContent.y = -100;
			addChild(txtContent);
			txtContent.scrollV ++;
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0xFFFFFF);
			rect.graphics.drawRect(-203, -153, 406, 306);
			rect.graphics.endFill();
			rect.alpha = 0;
			addChild(rect);
		}
		
		public function set title(t:String):void {
			_title = t;
		}
		
		public function get title():String {
			return _title;
		}
		
		public function set lastX(lx:Number):void {
			_lastX = lx;
		}
		
		public function get lastX():Number {
			return _lastX;
		}
		
		public function set lastY(ly:Number):void {
			_lastY = ly;
		}
		
		public function get lastY():Number {
			return _lastY;
		}
		
		public function set lastScaleX(lsx:Number):void {
			_lastScaleX = lsx;
		}
		
		public function get lastScaleX():Number {
			return _lastScaleX;
		}
		
		public function set lastScaleY(lsy:Number):void {
			_lastScaleY = lsy;
		}
		
		public function get lastScaleY():Number {
			return _lastScaleY;
		}
		
		public function set lastAlpha(lalpha:Number):void {
			_lastAlpha = lalpha;
		}
		
		public function get lastAlpha():Number {
			return _lastAlpha;
		}
	}
}