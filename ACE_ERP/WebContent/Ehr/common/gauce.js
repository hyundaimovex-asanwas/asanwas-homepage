var TRIM_PATTERN = /(^\s*)|(\s*$)/g; // 내용의 값을 빈공백을 trim하기 위한것(앞/뒤)
var ALL_TRIM_PATTERN = /\s*/g;		 // 모든값의 공백을 제거.
/*************************************************************************
 *  String.trim()
 *  내용의 좌 우측 공백을 제거해 주는 메소드
 *************************************************************************
 * Author    : 최재원
 * Date       : 2004.04.12
 * History   : 최초 작성
 * Desc      : 내용의 좌 우측 공백을 제거해 주는 메소드
 * Param    : none
 * Return    : trim()된 문자열
 *************************************************************************/
String.prototype.trim = function() {
	return this.replace(TRIM_PATTERN, "");
}

/*************************************************************************
 *  String.trimAll()
 *  내용의 모든 공백을 제거해 주는 메소드
 *************************************************************************
 * Author    : 최재원
 * Date       : 2004.04.12
 * History   : 최초 작성
 * Desc      : 내용의 모든 공백을 제거해 주는 메소드
 * Param    : none
 * Return    : trimAll()된 문자열
 *************************************************************************/
String.prototype.trimAll = function() {
	return this.replace(ALL_TRIM_PATTERN, "");
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 데이터셋 오브젝트 간에 컬럼 헤더 정보를 복사한다.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS);
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet
 * @param  : oOriginDataSet required 원본 DataSet
 * @param  : oTargetDataSet required 복사되어질 DataSet
 * @author : 최재원
 */
function cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet) {
	var DsHeader = "";
	var colId   = "";
	var colType = "";
	var colProp = "";
	var colSize = ""
	for (var i = 1; i <= oOriginDataSet.CountColumn; i++) {
 		colId   = oOriginDataSet.ColumnID(i);	     //column id
		colIndex= oOriginDataSet.ColumnIndex(colId);  //column id에 해당하는 index값
		colSize = oOriginDataSet.ColumnSize(colIndex);//column size
		/* column의 type 정의 코드
			Type  Description
			-----------------
			 1    String
			 2    Integer
			 3    Decimal
			 4    Date
			 5    URL
		*/
		//column type정의
		switch (oOriginDataSet.ColumnType(colIndex)){
		     case 1 :
		              colType = 'String';
		              break;
		     case 2 :
		              colType = 'Integer';
		              break;
		     case 3 :
		              colType = 'Decimal';
		              break;
		     case 4 :
		              colType = 'Date';
		              break;
		     case 5 :
		              colType = 'URL';
		              break;
		     default :
		              colType = "";
		              break;
		}

		/* column의 property 정의
			0 : Normal (Key = No)
			1 : Constant
			2 : Key (Normal, Sequence)
			3 : Sequence (Key = No) // 현재 의미없음.
		*/
		switch (oOriginDataSet.ColumnProp(i)) {
		     case 0 :
		              colProp = "NORMAL";
		              break;
		     case 1 :
		              colProp = "CONSTANT";
		              break;
		     case 2 :
		              colProp = "KEYVALUE";
		              break;
		     default :
		              colProp = "";
		              break;
		}
		//column id,column type,column size, column property
		DsHeader = DsHeader + colId + ":" + colType + "(" + colSize + ")" + ":" + colProp + ",";
	}

	DsHeader = DsHeader.substr(0, DsHeader.length - 1);
	oTargetDataSet.SetDataHeader(DsHeader);
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 데이터셋 오브젝트 간에 데이터를 복사한다. 복사대상이 되는 데이터셋의 기존의 데이터는 모두 삭제된다.
 *           features 파라미터에서 copyHeader를 yes로 할 경우 DataSet의 컬럼정보까지 복사된다.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS, "copyHeader=no");
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet[, features]
 * @param  : oOriginDataSet required 원본 DataSet
 * @param  : oTargetDataSet required 복사되어질 DataSet
 * @param  : features       optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     copyHeader  : Header를 복사할지 여부. (default:yes)
 *     resetStatus : 복사된 DataSet의 Status를 reset 할 지 여부. (default:yes)
 *     rowFrom     : 복사할 row의 시작 index. (default:1)
 *     rowCnt      : 복사할 row의 갯수 index. (default:DataSet.CountRow 의 값)
 *     사용예) "copyHeader=yes,rowFrom=1,rowCnt=2"  -> 1번 row 부터 3번 row까지 Header와 함께 복사함.
 * </pre>
 * @author : 최재원
 */
function cfCopyDataSet(oOriginDataSet, oTargetDataSet, features) {
	var featureNames  = ["copyHeader", "resetStatus", "rowFrom", "rowCnt"];
	var featureValues = [true, true, 1, oOriginDataSet.CountRow];
	var featureTypes  = ["boolean", "boolean", "number", "number"];
	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}
	var copyHeader  = featureValues[0];
	var resetStatus = featureValues[1];
	var rowFrom     = featureValues[2];
	var rowCnt      = featureValues[3];
	if (copyHeader == true) {
		cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet);
	}
	oTargetDataSet.ClearData();
	if (oOriginDataSet.CountRow > 0) {
		var temp = oTargetDataSet.dataid;  // importdata를 한 후 DataSet의 기존의 dataid 속성값이 지워지는 것을 방지.
		oTargetDataSet.ImportData(oOriginDataSet.ExportData(rowFrom, rowCnt, true));
		
		oTargetDataSet.dataid = temp;
		if (resetStatus == true) {
			oTargetDataSet.ResetStatus();
		}
	}
}

/**
 * @type   : function
 * @access : private
 * @desc   : features 스트링을 파싱하여 array에 셋팅하는 내부 함수
 * @sig    : features, fNameArray, fValueArray, fTypeArray
 * @param  : features    required features를 표현한 스트링
 * @param  : fNameArray  required 추출해야 할 feature의 이름에 대한 array
 * @param  : fValueArray required 추출해야 할 feature의 기본값에 대한 array
 * @param  : fTypeArray  required 추출해야 할 feature의 데이터타입에 대한 array
 * @author : 최재원
 */
function cfParseFeature(features, fNameArray, fValueArray, fTypeArray) {
	if (features == null) {
		return;
	}
	var featureArray = features.split(",");
	var featurePair;
	for (var i = 0; i < featureArray.length; i++) {
		featurePair = featureArray[i].trim().split("=");
		for (var j = 0; j < fNameArray.length; j++) {
			if (featurePair[0] == fNameArray[j]) {
				switch (fTypeArray[j]) {
					case "string" :
						fValueArray[j] = featurePair[1];
						break;
					case "number" :
						fValueArray[j] = Number(featurePair[1]);
						break;
					case "boolean" :
						if (featurePair[1].toUpperCase() == "YES" || featurePair[1].toUpperCase() == "TRUE" || featurePair[1] == "1") {
							fValueArray[j] = true;
						} else {
							fValueArray[j] = false;
						}
						break;
				}
			}
		}
	}
}



/**
 *	화면에 프로그래스바 오브젝트를 생성한다.
 */
function cfCreateBar() {
	var progress = "";
	try	{
		if (tempObj.classid.toUpperCase() == "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB") {	// 데이터셋.
			progress = '<iframe src="/images/loading.gif" id=oProgressBar style="position:absolute;visibility:hidden;width:199;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
		} else if (tempObj.classid.toUpperCase() == "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5") { // 트랜젝션 오브젝트.
			if(arguments.length == 2 && arguments[1] == "R") {
				progress = '<iframe src="/images/loading.gif" id=oProgressBar style="position:absolute;visibility:hidden;width:199;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
			} else {
				progress = '<iframe src="/images/loading.gif" id=oProgressBar style="position:absolute;visibility:hidden;width:199;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
			}

		}
	} catch (exception) {
		progress = '<iframe src="/images/loading.gif" id=oProgressBar style="position:absolute;visibility:hidden;width:199;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
	}

	for (var i = 0; i < document.all.length; i++) {
		if (document.all[i].tagName.toUpperCase() == "BODY") {
			document.all[i].insertAdjacentHTML("beforeEnd", progress);
			break;
		}
	}
	try	{
		document.all.oProgressBar.style.zIndex = 0;
		if (arguments.length==3) {
			document.all.oProgressBar.style.left = arguments[1];
			document.all.oProgressBar.style.top = arguments[2];
		} else if (arguments.length == 4) {
			document.all.oProgressBar.style.left = arguments[2];
			document.all.oProgressBar.style.top = arguments[3];
		} else {
			document.all.oProgressBar.style.left = 360;
			document.all.oProgressBar.style.top = 210;
		}		
	} catch (exception)	{	
		alert("처리중입니다.\n잠시만 기다려 주십시오.");
		return;
	}

}

var GLB_SUBMIT_STATUS = false;
/**
 * 화면의 프로그래스바를 제거한다.
 */
function cfComplete() {
	GLB_SUBMIT_STATUS = false;
	document.all.oProgressBar.outerHTML = "";
	var lo_obj = document.all;
	for (i=0; i<lo_obj.length; i++) {
		try {
			if (lo_obj[i].type.toUpperCase() == "BUTTON") {
				lo_obj[i].disabled = false;
			}

		} catch (exception) {}
	}
}

var glo_Interval = "";
var tempObj = "";

/**
 *	화면에 프로그래스바를 표시한다.
 */
function cfSubmit() {
	if (GLB_SUBMIT_STATUS == true)	{
		alert("처리중입니다.\n잠시만 기다려 주십시오.");
		return;
	}
	GLB_SUBMIT_STATUS = true;
	if (arguments.length == 1)	{

		try {
			tempObj = arguments[0];
		} catch (exception) {
			try {
				document.all.oProgressBar.style.top = arguments[0];
			} catch (exception) {
			}
			
		}
		cfCreateBar(tempObj);
	} else if (arguments.length == 2) {

		try {
			tempObj = arguments[0];
		} catch (exception) {
			try {
				document.all.oProgressBar.style.top = arguments[0];
			} catch (exception) {
			}
			
		}
		cfCreateBar(tempObj, arguments[1]);
	} else if (arguments.length == 3) {

		try {
			tempObj = arguments[0];
		} catch (exception) {
			try {
				document.all.oProgressBar.style.top = arguments[0];
			} catch (exception) {
			}
			
		}
		cfCreateBar(tempObj, arguments[1], arguments[2]);
	} else if (arguments.length == 4) {

		try {
			tempObj = arguments[0];
		} catch (exception) {
			try {
				document.all.oProgressBar.style.top = arguments[0];
			} catch (exception) {
			}
			
		}
		cfCreateBar(tempObj, arguments[1], arguments[2], arguments[3]);
	}
	try	{
		document.all.oProgressBar.style.visibility="visible";
	} catch (exception) {
	}
	
	glo_Interval = window.setInterval("cfProcess()",300);
}

/**
 *	오브젝트 타입에 따라 SUBMIT/POST/RESET을 수행한다.
 */
function cfProcess() {
	var lo_obj = document.all;
	for (i=0; i<lo_obj.length; i++) {
		try {
			if (lo_obj[i].type.toUpperCase() == "BUTTON") {
				lo_obj[i].disabled = true;
			}

		} catch (exception) {}
	}
	window.clearInterval(glo_Interval);
	try	{
		if (tempObj.classid.toUpperCase() == "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB") {	// 데이터셋.
			tempObj.reset();
		} else if (tempObj.classid.toUpperCase() == "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5") { // 트랜젝션 오브젝트.
			tempObj.post();
		}
	} catch (exception) {
		document.form1.submit();
	}
}

/** Replace용 **/
String.prototype.replaceStr = function(p_oldstr, p_newstr) {
	var v_regstr = p_oldstr;
	v_regstr = v_regstr.replace(/\\/g, "\\\\");
	v_regstr = v_regstr.replace(/\^/g, "\\^");
	v_regstr = v_regstr.replace(/\$/g, "\\$");
	v_regstr = v_regstr.replace(/\*/g, "\\*");
	v_regstr = v_regstr.replace(/\+/g, "\\+");
	v_regstr = v_regstr.replace(/\?/g, "\\?");
	v_regstr = v_regstr.replace(/\./g, "\\.");
	v_regstr = v_regstr.replace(/\(/g, "\\(");
	v_regstr = v_regstr.replace(/\)/g, "\\)");
	v_regstr = v_regstr.replace(/\|/g, "\\|");
	v_regstr = v_regstr.replace(/\,/g, "\\,");
	v_regstr = v_regstr.replace(/\{/g, "\\{");
	v_regstr = v_regstr.replace(/\}/g, "\\}");
	v_regstr = v_regstr.replace(/\[/g, "\\[");
	v_regstr = v_regstr.replace(/\]/g, "\\]");
	v_regstr = v_regstr.replace(/\-/g, "\\-");
  	var re = new RegExp(v_regstr, "g");
    return this.replace(re, p_newstr);

}


/*************************************************************************
 * cfStyleGrid(oGrid, styleName, features)
 *************************************************************************
 * author : 최재원
 * date    : 2004/06/21
 * desc   : 그리드에 표준 스타일을 적용한다.
 * param : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex      : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleGrid(oGrid, styleName, indicate) {

	var titleHeight;
	var bgColor;
	var fontSize;
	var fontFamily;
	var sumColor;
	var sumBgColor;
	var subColor;
	var subBgColor;
	var subpressBgColor;
	var color;
	var headAlign;
	var headColor;
	var headBgColor;


	// <C> 컬럼 속성
	var CColor;
	var CHeadColor;
	var CHeadBgColor;

	// <FC> 컬럼 속성
	var FCColor;
	var FCBgColor;
	var FCHeadColor;
	var FCHeadBgColor;

	// <G> 컬럼 속성
	var GHeadColor;
	var GHeadBgColor;

	// <FG> 컬럼 속성
	var FGHeadColor;
	var FGHeadBgColor;

	// <X> 컬럼 속성
	var XHeadColor;
	var XHeadBgColor;

	// <FX> 컬럼 속성

	var FXHeadColor;
	var FXHeadBgColor;

	var indWidth    = 15;
	var rowHeight   = 20;
	var titleHeight = 20;

	// Grid Style 별 정의
	switch (styleName) {
		case "comn":
			// Grid 속성
			titleHeight      = titleHeight;
//				titleHeight      = 20;
			fontSize         = "11px";
			fontFamily       = "Tahoma";

			// 컬럼 공통 속성
			sumColor         = "#000000";
			sumBgColor       = "#FAE9BD";	// Summary
			subColor         = "#000000";
			subBgColor       = "#FBF5D8";
			subpressBgColor  = "#FFFFFF"; //"{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#FCFCFC"

			// 컬럼별 속성
			CColor           = "#454648";
			CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#F5F5F5',1,'#F5F5F5')}"; //"#FCFCFC"
			CHeadColor       = "#000000";	// C컬럼 헤더 폰트 색상
			CHeadBgColor     = "#DAE5FE";	// C컬럼 헤더 색상
			FCColor          = "#454648";
			FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#F0F0F0"
			FCHeadColor      = "#000000";	// FC컬럼 헤더 폰트 색상
			FCHeadBgColor    = "#E4E0D5";	// FC컬럼 헤더 색상
			GHeadColor       = "#000000";	// G컬럼 헤더 폰트 색상
			GHeadBgColor     = "#DAE5FE";	// G컬럼 헤더 색상
			FGHeadColor      = "#000000";	// FG컬럼 헤더 폰트 색상
			FGHeadBgColor    = "#D4CFC9";	// FG컬럼 헤더 색상
			XHeadColor       = "#000000";	// X컬럼 헤더 폰트 색상
			XHeadBgColor     = "#D3CDC1";	// X컬럼 헤더 색상.
			FXHeadColor      = "#000000";	// FX컬럼 헤더 폰트 색상
			FXHeadBgColor    = "#D3CDC1";	// FX컬럼 헤더 색상
			break;

		default:
			// Grid 속성
			titleHeight      = titleHeight;
//				titleHeight      = 20;
			fontSize         = "11px";
			fontFamily       = "Tahoma";

			// 컬럼 공통 속성
			sumColor         = "#000000";
			sumBgColor       = "#FAE9BD";	// Summary
			subColor         = "#000000";
			subBgColor       = "#FBF5D8";
			subpressBgColor  = "#FFFFFF"; //"{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#FCFCFC"

			// 컬럼별 속성
			CColor           = "#454648";
			CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#FCFCFC"
			CHeadColor       = "#000000";	// C컬럼 헤더 폰트 색상
			CHeadBgColor     = "#DAE5FE";	// C컬럼 헤더 색상
			FCColor          = "#454648";
			FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#F0F0F0"
			FCHeadColor      = "#000000";	// FC컬럼 헤더 폰트 색상
			FCHeadBgColor    = "#CECECE";	// FC컬럼 헤더 색상
			GHeadColor       = "#000000";	// G컬럼 헤더 폰트 색상
			GHeadBgColor     = "#B4B4B4";	// G컬럼 헤더 색상
			FGHeadColor      = "#000000";	// FG컬럼 헤더 폰트 색상
			FGHeadBgColor    = "#B4B4B4";	// FG컬럼 헤더 색상
			XHeadColor       = "#000000";	// X컬럼 헤더 폰트 색상
			XHeadBgColor     = "#9B9B9B";	// X컬럼 헤더 색상.
			FXHeadColor      = "#000000";	// FX컬럼 헤더 폰트 색상
			FXHeadBgColor    = "#9B9B9B";	// FX컬럼 헤더 색상
			break;
	}

	// Grid 속성 설정
	{
		oGrid.RowHeight = rowHeight;
		oGrid.TitleHeight = titleHeight;
		if (indicate != true)
		{
			oGrid.IndWidth = 0;		// indwidth 0
		} else {
			oGrid.IndWidth = 17;		// indwidth 0
		}

		oGrid.style.fontSize    = fontSize;
		oGrid.style.fontFamily  = fontFamily;
		oGrid.FillArea = true;
		oGrid.BorderStyle = 2;
		oGrid.ColSizing = 1;
	}

	var tagRE = /<(fc|c|g|fg|x|fx)>/i;
	var colAttrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;
	var gFormat = oGrid.Format;
	var newGFormat = "";
	var tagMatch;
	var tagName;
	var colAttrData;
	var colAttrMatch;
	var colAttrName;
	var colAttrValue;
	var insertStr;

	// Grid Format String 을 파싱하여 컬럼별로 Style 과 관련된 속성을 삽입한다.
	while ((tagMatch = gFormat.match(tagRE)) != null) {
		var style = "";
		var isSupress = false;

		// 사용자가 지정한 컬럼 속성에 따른 처리
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {
			colAttrName = colAttrMatch[1].toUpperCase();
			colAttrValue = colAttrMatch[2].toUpperCase();
			if (colAttrName == "STYLE") {
				if (colAttrValue == "TITLE") {
					style = "TITLE";
				} else if (colAttrValue == "REQUIRED") {
					style = "REQUIRED";
				}
			}


			if (colAttrName == "SUPPRESS") {
				isSupress = true;
			}

			colAttrData = colAttrData.substr(colAttrMatch.lastIndex);
		}

		insertStr = "";
		tagName = tagMatch[1].trim().toUpperCase();
		switch (tagName) {
			case "C" :
				headAlign = "Center";
				headColor = CHeadColor;
				headBgColor= CHeadBgColor;

				if (isSupress) {
					insertStr = insertStr + " BgColor=" + subpressBgColor;
				} else {
					insertStr = insertStr + " BgColor=" + CBgColor;
				}

				insertStr = insertStr + " Color=" + CColor +
							" SumColor=" + sumColor +
							" SumBgColor=" + sumBgColor +
							" SubColor=" + subColor +
							" SubBgColor=" + subBgColor;
				break;

			case "FC" :
				headAlign = "Center";
				headColor= FCHeadColor;
				headBgColor= FCHeadBgColor;
				if (isSupress) {
					insertStr = insertStr + " BgColor=" + subpressBgColor;
				} else {
					insertStr = insertStr + " BgColor=" + FCBgColor;
				}

				insertStr = insertStr + " Color=" + FCColor +
							" SumColor=" + sumColor +
							" SumBgColor=" + sumBgColor +
							" SubColor=" + subColor +
							" SubBgColor=" + subBgColor;
				break;

			case "G" :
				headAlign = "Center";
				headColor= GHeadColor;
				headBgColor= GHeadBgColor;
				break;
			case "FG" :
				headAlign = "Center";
				headColor= FGHeadColor;
				headBgColor= FGHeadBgColor;
				break;
			case "X" :
				headAlign = "Center";
				headColor= XHeadColor;
				headBgColor= XHeadBgColor;
				break;
			case "FX" :
				headAlign = "Center";
				headColor= FXHeadColor;
				headBgColor= FXHeadBgColor;
				break;
			default :
				break;
		}

		// 사용자가 지정한 컬럼 속성에 따른 처리
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		if (style == "TITLE") {
			headColor = "#FFFFFF";
			headBgColor = "#8AA1C2";
			headAlign = "Left";
		} else if (style == "REQUIRED") {
			headColor = "#1467E4";
		}


		// Grid의 Format 에 Style 관련 속성값들을 삽입한다.
		insertStr = insertStr +
					" HeadColor=" + headColor +
					" HeadBgColor=" + headBgColor +
					" HeadAlign=" + headAlign + " ";

		newGFormat = newGFormat + gFormat.substring(0, tagMatch.lastIndex) + insertStr;
		gFormat = gFormat.substr(tagMatch.lastIndex);
	}

	newGFormat = newGFormat + gFormat;
	oGrid.Format = newGFormat;
	oGrid.AutoResizing = true;
	oGrid.HeadLineColor = "#666666";
	oGrid.LineColor  = "#FFFFFF";
	oGrid.HeadBorder = 4;
	oGrid.BorderStyle = 1;
	switch(styleName) {
		case "comn" :
			// Focus가 있고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
			oGrid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#009BA8', TextColor='Black'</SC>";

			// Focus가 있고 Editable이 아닌 상태에서, 선택된 Row에서 선택된 Cell을 제외한 다른셀
			oGrid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#D0E6B8', TextColor='Black'</SC>";

			// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
			oGrid.SelectionColor += "<SC>Type='EditCol', BgColor='#FDAB37', TextColor='navy'</SC>";

			// Focus가 없고고 Editable인 상태에서, 선택된 Row에서 선택된 Cell을 제외한 나머지 Cell들
			oGrid.SelectionColor += "<SC>Type='EditRow', BgColor='#F6ECC1', TextColor='Black'</SC>";

			// Focus가 있고 MultiSelect일 때 선택된 Row(Mark된 Row)의 Cell들(현재 Row ? 가장 마지막에 선택된 Row ? 제외)
			oGrid.SelectionColor += "<SC>Type='FocusCurCol', BgColor='Black', TextColor='White'</SC>";

			// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
			oGrid.SelectionColor += "<SC>Type='CurCol', BgColor='#0089D8', TextColor='Goldk'</SC>";

			// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell을 제외한 나머지 Cell들 (포커스 상태에서 선택된 ROW)
			oGrid.SelectionColor += "<SC>Type='FocusCurRow', BgColor='#FFFF88', TextColor='black'</SC>";

			// Focus가 없고 Editable이 아닌 상태에서, 선택된 Row에서 선택된 Cell (포커스 떠난 상태의 선택된 ROW)
			oGrid.SelectionColor += "<SC>Type='CurRow', BgColor='#E7E498', TextColor='black'</SC>";

			// Focus가 없고 Editable이 아닌 상태에서, 선택된 Row에서 선택된 Cell을 제외한 나머지 Cell들
			oGrid.SelectionColor += "<SC>Type='FocusSelRow', BgColor='Brown', TextColor='maroon'</SC>";

			//Focus가 없고 MultiSelect일 때 선택된 Row(Mark된 Row)의 Cell들(현재 Row ? 가장 마지막에 선택된 Row ? 제외)
			oGrid.SelectionColor += "<SC>Type='SelRow', BgColor='Green', TextColor='mistyrose'</SC>";
			break;
		default :
			// Focus가 있고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
			oGrid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#00A0C2', TextColor='Black'</SC>";

            // Focus가 있고 Editable이 아닌 상태에서, 선택된 Row에서 선택된 Cell을 제외한 다른셀
			oGrid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#D7EEFF', TextColor='Black'</SC>";

			// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
			oGrid.SelectionColor += "<SC>Type='EditCol', BgColor='#00B296', TextColor='navy'</SC>";

			// Focus가 없고고 Editable인 상태에서, 선택된 Row에서 선택된 Cell을 제외한 나머지 Cell들
			oGrid.SelectionColor += "<SC>Type='EditRow', BgColor='#F3FED2', TextColor='Black'</SC>";

			// Focus가 있고 MultiSelect일 때 선택된 Row(Mark된 Row)의 Cell들(현재 Row ? 가장 마지막에 선택된 Row ? 제외)
			oGrid.SelectionColor += "<SC>Type='FocusCurCol', BgColor='Black', TextColor='White'</SC>";

			// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
			oGrid.SelectionColor += "<SC>Type='CurCol', BgColor='#0089D8', TextColor='Goldk'</SC>";

			// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell을 제외한 나머지 Cell들 (포커스 상태에서 선택된 ROW)
			oGrid.SelectionColor += "<SC>Type='FocusCurRow', BgColor='#0089D8', TextColor='white'</SC>";

			// Focus가 없고 Editable이 아닌 상태에서, 선택된 Row에서 선택된 Cell (포커스 떠난 상태의 선택된 ROW)
			oGrid.SelectionColor += "<SC>Type='CurRow', BgColor='#D4CFE0', TextColor='black'</SC>";

			// Focus가 없고 Editable이 아닌 상태에서, 선택된 Row에서 선택된 Cell을 제외한 나머지 Cell들
			oGrid.SelectionColor += "<SC>Type='FocusSelRow', BgColor='Brown', TextColor='maroon'</SC>";

			//Focus가 없고 MultiSelect일 때 선택된 Row(Mark된 Row)의 Cell들(현재 Row ? 가장 마지막에 선택된 Row ? 제외)
			oGrid.SelectionColor += "<SC>Type='SelRow', BgColor='Green', TextColor='mistyrose'</SC>";
			break;
	}

}

/**
  * 페이징처리를 위한 객체.
  **/ 
function Page(p_dsId, p_x, p_y) {
	var svr_sortexpr = "";	// 서버 sortExpr IND셋팅용.
	var dsId = p_dsId;		// 데이터셋 
	var sortColumn = "";	// 서버 소트 컬럼 
	var orderBy = "-1";			// Orderby index Laf/J쪽 dao에서 사용됨.
	var sortType = "";		// 소트 타입 설정 1001, 1002
	var prevSortColumn = "";
	var x = 0;
	var y = 0;
	if (arguments.length == 1)	{
		x = 300;
		y = 200;
	} else {
		x = p_x;
		y = p_y;
	}


	/** 현재 서버쪽에 지정된 소트 컬럼을 조회하는 메소드 **/
	this.getSortColumn = function() {
		return sortColumn;
	}


	/** 현재 서버쪽에 적용되고있는 sort표현식을 조회하는 메소드 **/
	this.getSortExpr = function() {
		return svr_sortexpr;
	}

	/** Order by 설정 **/
	this.setOrderBy = function(idx) {
		orderBy = idx;
	}

	/** 정렬 방식을 조회하는 메소드 **/
	this.getOrderBy = function(col) {
		if (sortColumn == col) {
			return orderBy;
		} else {
			return -1;
		}
	}
	/** 소트 컬럼 지정 **/
	this.setSortColumn = function(p_gridObj, col) {
		prevSortColumn = sortColumn;
		sortColumn = col;
		var tmp = p_gridObj.ColumnProp(col, "name");	
		tmp = tmp.replaceStr("↑", "");
		tmp = tmp.replaceStr("↓", "");
		p_gridObj.ColumnProp(col, "name") = tmp;
		p_gridObj.ColumnProp(col, "ToolTipText") = "마우스 오른쪽 버튼을 누르면 소트기능을 설정 할수있습니다.";
	}

	/** 소트 타입 설정 : 1001(서버), 1002(컴포넌트) **/
	this.setSortType = function(p_gridObj, p_sortType) {
		svr_sortexpr = "";	// 소트 타입 초기화.
		orderBy = -1;			// 소트 인덱스 초기화.
		try {
			if (p_sortType == 1001) {			// 서버인 경우에만 status변경
				p_gridObj.ColumnProp(prevSortColumn, "HeadColor") = "black";
				if (prevSortColumn == sortColumn || prevSortColumn == "") {
					var tmp = p_gridObj.ColumnProp(sortColumn, "name");	
					if (tmp.indexOf("↓") == -1){
						p_gridObj.ColumnProp(sortColumn, "name") = tmp + "↓";
					}

				} else {
					var tmp = p_gridObj.ColumnProp(prevSortColumn, "name");	
					tmp = tmp.replaceStr("↑", "");
					tmp = tmp.replaceStr("↓", "");
					p_gridObj.ColumnProp(prevSortColumn, "name") = tmp;
				}
			}
		}catch (exception)	{		}// ingnore

		sortType = p_sortType;
		if (sortType == "1001")	{
			p_gridObj.ColumnProp(sortColumn, "HeadColor") = "14968596";
		} else if (sortType == "1002")	{
			p_gridObj.ColumnProp(sortColumn, "HeadColor") = "black";
			sortColumn = "";
			orderBy = "-1";
		} else {
			alert("소트 타입은 [1001:서버소트기능, 1002:컴포넌트 소트기능]만 사용하실수있습니다.");
			return;
		}
	}



	/** 특정 페이지로 이동할때 사용하는 메소드 **/
	this.goPage = function(idx) {
		var param = "&targetRow=" + idx;
		var uri = dsId.DataId;
		if (uri.indexOf("&targetRow") != -1) {
			uri = uri.substring(0, uri.indexOf("&targetRow"));
		}
		dsId.DataId = uri + param;
		cfSubmit(dsId, x, y);
		//dsId.reset();
	}

	/** 데이터셋 또는 트랜젝션 컴포넌트를 reset/post 하는 메소드 이 메소드를 사용하면 프로그래스바가 나타난다. **/
	this.submit = function() {
		cfSubmit(dsId, x, y);
	}

	/** 페이지 리스트를 반환하는 메소드 **/
	this.pageInfo = function(pageObj) {
		try {
			cfComplete();
		} catch (exception)	{}
		/**
		var tmp = dsId.NameValue(1,"PAGE_INFO");
		if (typeof(tmp) == "undefined") {
			pageObj.innerHTML = "";
		} else {
			pageObj.innerHTML = tmp;
		} **/
	}

	/** 헤더 정보를 표시해주는 메소드 **/
	this.info = function() {
		alert(dsId.text);
	}

	/** 소트 기능 구현  **/
	this.sort = function(p_grid, row, colid) {
		var col = "";
		
		if (row > 0) return;


		if (sortColumn != "" && sortColumn == colid)	 {	// 서버 소트인 경우 
			
			var tmp_name = p_grid.ColumnProp(colid, "name");	

			if (tmp_name.indexOf("↑") == -1 && tmp_name.indexOf("↓") == -1) {
				tmp_name += "↓";
			} else if (tmp_name.indexOf("↓")  != -1) {
				tmp_name =  tmp_name.replaceStr("↓", "↑");
			} else {
				tmp_name =  tmp_name.replaceStr("↑", "↓");
			}

			if (svr_sortexpr.indexOf(colid) == -1) {
					svr_sortexpr += "+" + colid;
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("↓", "");
					col += "↑" ;
					p_grid.ColumnProp(colid, "name") = col;
			} else if (svr_sortexpr.indexOf("+" + colid) != -1) {
					svr_sortexpr = svr_sortexpr.replaceStr("+" + colid, "-" + colid);
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("↑", "↓");
					p_grid.ColumnProp(colid, "name") = col;
			} else if (svr_sortexpr.indexOf("-" + colid) != -1) {
					svr_sortexpr = svr_sortexpr.replaceStr("-" + colid, "+" + colid);
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("↓", "↑");
					p_grid.ColumnProp(colid, "name") = col;
			}

			p_grid.ColumnProp(colid, "name") = col;		// ind셋팅.

			// orderBy셋팅.
			var param = "&orderBy=" + orderBy;
			var uri = dsId.DataId;
			if (uri.indexOf("&orderBy") != -1) {
				uri = uri.substring(0, uri.indexOf("&orderBy"));
			}
			dsId.DataId = uri + param;
//			result = "";
			var tmp_sort = eval(p_grid.dataId).sortexpr;		// sort리스트.
			if (tmp_sort.indexOf(colid) != -1)	{
				tmp_sort = tmp_sort.replaceStr("+" + colid, "");
				tmp_sort = tmp_sort.replaceStr("-" + colid, "");
			}
			eval(p_grid.dataId).sortexpr = tmp_sort;
			this.clearSort(p_grid, colid);
//			TEST.innerHTML = "DEBUG MSG : type - " +type +  " \n sortColumn : " + sortColumn + " orderBy : " + orderBy + "  sortType : " + sortType + "\n prevSortColumn : " + prevSortColumn +   "  svr_sortexpr : " + svr_sortexpr;
			cfSubmit(dsId, x, y);									// 조회 수행
		} else {															// 컴포넌트 소트인 경우.
			var result = eval(p_grid.dataId).sortexpr;
			if (result.indexOf(colid) == -1) {
					result += "+" + colid;
					col = p_grid.ColumnProp(colid, "name");	
					col += "↑" ;
					p_grid.ColumnProp(colid, "name") = col;
			} else if (result.indexOf("+" + colid) != -1) {
					result = result.replaceStr("+" + colid, "-" + colid);
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("↑", "↓");
					p_grid.ColumnProp(colid, "name") = col;
			} else if (result.indexOf("-" + colid) != -1) {
					result = result.replaceStr("-" + colid, "");
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("↓", "");
					p_grid.ColumnProp(colid, "name") = col;
			}
			
			eval(p_grid.dataId).sortexpr = result;
			//alert( svr_sortexpr + result);
			eval(p_grid.dataId).sort();
			eval(p_grid.dataId).RowPosition = 1;
		}
	}

	/** 가우스 오브젝트의 소트 속성을 제거하는 메소드 **/
	this.clearSort = function(p_gridObj, p_colid) {
		var cnt = p_gridObj.CountColumn;
		for ( i=0; i<cnt ; i++ ) {
			if (p_gridObj.GetColumnID(i) != p_colid) {
					var col = p_gridObj.ColumnProp(p_gridObj.GetColumnID(i), "name");	
					col = col.replaceStr("↓", "");
					col = col.replaceStr("↑", "");
					p_gridObj.ColumnProp(p_gridObj.GetColumnID(i), "name") = col;
			}
		}
		eval(p_gridObj.dataId).sortexpr = "";
		eval(p_gridObj.dataId).sort();
	}
}



function __patch__(obj) {
	document.write( obj.text );
	obj.id = "";
}