package {
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Holder extends Sprite {
		private var loadProgress:TextField;
		private var loader:Loader;
		
		public function Holder() {
			init();
		}
		
		public function init():void {
			loader = new Loader()
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.load(new URLRequest("NewsReader.swf"));
			addChild(loader);
														
			loadProgress = new TextField();
			addChild(loadProgress);
			loadProgress.width = 80;
			loadProgress.height = 20;
			loadProgress.x = stage.stageWidth / 2 - 40;
			loadProgress.y = stage.stageHeight / 2 - 10;
			
			var format:TextFormat = new TextFormat();
			format.font = "Courier New";
			format.size = 12;
			format.align = TextFormatAlign.CENTER;
			loadProgress.defaultTextFormat = format;
		}
		
		private function onComplete(event:Event):void {
			loadProgress.visible = false;
		}
		
		private function onProgress(event:ProgressEvent):void {
			var loaded:Number = event.target.bytesLoaded;
			var total:Number = event.target.bytesTotal;
			
			loadProgress.text = loaded + " / " + total;
		}
	}
}