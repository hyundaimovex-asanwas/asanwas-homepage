/* 
ActionSript : 프린트
만 든 이 : nanpjs
만든날짜 : 2010.3
Q : RGB박대리
*/
class AS.PrintFunction {
	//private static var mcPrintContent:Object
	public function PrintFunction() {
	}
	//
	public function Print():Void {
		printFn(_root.mcPrintContent, 550);
	}
	// 프린트 함수 
	function printFn(obj:Object, limitWidth:Number):Void {
		var obj:Object;
		var printObj:PrintJob = new PrintJob();
		var pageNum:Number = 0;
		var limitWidth:Number;
		var oriXscale:Number = obj._xscale;
		var oriYscale:Number = obj._yscale;
		var a = obj._height;
		// 오브젝트가 기준값보다 크면 scale 기준값 에 맞추기.
		if (obj._width>limitWidth) {
			var ratio:Number = limitWidth/obj._width*100;
			obj._xscale = obj._yscale=ratio;
		}
		if (printObj.start()) {
			var xMaxNum:Number;
			// 넓이 페이지 몇장이 나올지 계산
			var horiPageNum:Number = Math.ceil(obj._width/printObj.pageWidth);
			trace(horiPageNum);
			// 높이 페이지 몇장이 나올지 계산
			var verPageNum:Number = Math.ceil(obj._height/printObj.pageHeight);
			trace(verPageNum);
			for (var i:Number = 0; i<horiPageNum; i++) {
				for (var j:Number = 0; j<verPageNum; j++) {
					if (printObj.orientation == "portrait") {
						// 8.5" x 11" , 600 X 800
						xMaxNum = 800;
					} else {
						// 11" x 8.5" , 800 X 600
						xMaxNum = 750;
					}
					printObj.addPage(obj, {xMin:(i*printObj.pageWidth), xMax:((i+1)*xMaxNum), yMin:(j*1200), yMax:((j+1)*1200)}, {printAsBitmap:true});
					//printObj.addPage(obj, {xMin:(i*printObj.pageWidth), xMax:((i+1)*xMaxNum), yMin:(j*printObj.pageHeight), yMax:((j+1)*printObj.pageHeight)}, {printAsBitmap:true});
				}
			}
			if (pageNum>0) {
				printObj.send();
			}
		}
		obj._xscale = obj._yscale=oriXscale;
		delete printObj;
	}
}
