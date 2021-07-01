/* 	2014-06-16	심동현
 * 	전자결재용으로 간추린 기존 common_gauce 파일..
 * 	너무 길어 그런지 이클립스에서 잘 열리지도 않아 ㅠ_ㅠ
 * 
 * 
 * */


/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 trim 메소드를 추가한다. trim 메소드는 스트링의 앞과 뒤에
 *           있는 white space 를 제거한다.
 * <pre>
 *     var str = " abcde "
 *     str = str.trim();
 * </pre>
 * 위의 예에서 str는 "abede"가 된다.
 * @return : trimed String.
 * @author : GAUCE
 */
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}


/*===========================================================================*/
// return first object value about pObjName's paramemr
/*===========================================================================*/
function getObjectFirst(pObjName)	{
	return document.getElementsByName(pObjName)[0];
}


/**
 * @type   : function
 * @access : public
 * @desc   : 가우스 Grid의 Style을 정해진 Style로 바꾸어준다. Style과 관련된 내용은 디자인표준문서를 참고할 것.
 * <pre>
 *     cfStyleGrid(oDelivRsltGG, "comn", features);
 * </pre>
 * @sig    : oGrid, styleName[, features]
 * @param  : oGrid     required Grid 오브젝트
 * @param  : styleName required Grid의 style name. 현재는 "comn" 과 "comnOnTab" 만 있다.
 * @param  : features  optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     indWidth  : Grid의 IndWidth 속성 지정.
 *     rowHeight : Grid의 RowHeight 속성 지정.
 *     rowHeight : Grid의 titleHeight 속성 지정.
 *
 *     사용예) "indWidth=12,rowHeight=25,titleHeight=30"
 * </pre>
 * @author : GAUCE
 */

function cfStyleGrid(oGrid, styleName, features) {
	var titleHeight;
	var bgColor;
	var fontSize;
	var fontFamily;
	var LineColor;
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
	var CHeadFontStyle;


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
	var featureNames  = ["indWidth","rowHeight","titleHeight"];
	var featureValues = [15, 20, 20];
	var featureTypes  = ["number", "number" ,"number"];

	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}

	var indWidth    = featureValues[0];
	var rowHeight   = featureValues[1];
	var titleHeight = featureValues[2];


	// Grid Style 별 정의
	switch (styleName) {
        case "approval":	//결재화면 그리드용
            // Grid 속성
            titleHeight      = 20;
            fontSize         = "9pt";
            fontFamily       = "굴림";
            indWidth        = "0";
            
            // 컬럼 공통 속성
            sumColor         = "#333333";
            sumBgColor       = "#d4d0c8";
            subColor         = "#ff0000";	//464646
            subBgColor       = "#00ff00";	//D8D8D8
            //subpressBgColor  = "#FFFFFF";
            subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#f8f8f8',1,'#FFFFFF')}"; //"#F0F0F0"


            // 컬럼별 속성
            CColor           = "#333333";
            CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#f8f8f8',1,'#FFFFFF')}"; //"#FCFCFC"
            CHeadColor       = "#333333";	//FFFFFF
            CHeadBgColor     = "#d4d0c8";	//5c7cac
			CHeadFontStyle	 = "bold";

            FCColor          = "#333333";
            FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#f8f8f8',1,'#FFFFFF')}"; //"#F0F0F0"
            FCHeadColor      = "#333333";	//FFFFFF
            FCHeadBgColor    = "#d4d0c8";	//5c7cac	
            GHeadColor       = "#333333";	//FFFFFF
            GHeadBgColor     = "#d4d0c8";	//5c7cac
            FGHeadColor      = "#333333";	//FFFFFF
            FGHeadBgColor    = "#d4d0c8";	//5c7cac
            XHeadColor       = "#333333";	//FFFFFF
            XHeadBgColor     = "#d4d0c8";	//5c7cac
            FXHeadColor      = "#333333";	//FFFFFF
            FXHeadBgColor    = "#d4d0c8";	//5c7cac
            break;

        case "apline":	//결재선 그리드용
            // Grid 속성
            titleHeight      = 20;
            fontSize         = "9pt";
            fontFamily       = "굴림";
            indWidth        = "0";
            
            // 컬럼 공통 속성
            sumColor         = "#333333";
            sumBgColor       = "#d4d0c8";
            subColor         = "#ff0000";	//464646
            subBgColor       = "#00ff00";	//D8D8D8
            //subpressBgColor  = "#FFFFFF";
            subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#f8f8f8',1,'#FFFFFF')}"; //"#F0F0F0"


            // 컬럼별 속성
            CColor           = "#333333";
            CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#f8f8f8',1,'#FFFFFF')}"; //"#FCFCFC"
            CHeadColor       = "#333333";	//FFFFFF
            CHeadBgColor     = "#d4d0c8";	//5c7cac
			CHeadFontStyle	 = "bold";

            FCColor          = "#333333";
            FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#f8f8f8',1,'#FFFFFF')}"; //"#F0F0F0"
            FCHeadColor      = "#333333";	//FFFFFF
            FCHeadBgColor    = "#d4d0c8";	//5c7cac	
            GHeadColor       = "#333333";	//FFFFFF
            GHeadBgColor     = "#d4d0c8";	//5c7cac
            FGHeadColor      = "#333333";	//FFFFFF
            FGHeadBgColor    = "#d4d0c8";	//5c7cac
            XHeadColor       = "#333333";	//FFFFFF
            XHeadBgColor     = "#d4d0c8";	//5c7cac
            FXHeadColor      = "#333333";	//FFFFFF
            FXHeadBgColor    = "#d4d0c8";	//5c7cac
            break;            



		default:
			return;
	}


	// Grid 속성 설정
	{
		oGrid.RowHeight = rowHeight;
		oGrid.TitleHeight = titleHeight;
		oGrid.IndWidth = indWidth;
		oGrid.style.fontSize    = fontSize;
		oGrid.style.fontFamily  = fontFamily;
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
				            " HeadFontStyle=" + CHeadFontStyle +
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
				            " HeadFontStyle=" + CHeadFontStyle +
				            " SubBgColor=" + subBgColor;
				break;

			case "G" :
				headAlign = "Center";
				headColor= GHeadColor;
				headBgColor= GHeadBgColor;
				insertStr = insertStr + " HeadFontStyle=" + CHeadFontStyle ;
	            				
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

    oGrid.SelectionColorProp("FocusEditRow", "BgColor") = "#D1DEF0";
    oGrid.SelectionColorProp("FocusEditCol", "BgColor") = "#D1DEF0";
    oGrid.SelectionColorProp("FocusEditCol", "TextColor") = "Black";
    oGrid.SelectionColorProp("FocusSelRow", "BgColor") = "#D1DEF0";
    oGrid.SelectionColorProp("FocusSelRow", "TextColor") = "Black";
    oGrid.SelectionColorProp("FocusCurRow", "BgColor") = "#D1DEF0";
    oGrid.SelectionColorProp("FocusCurRow", "TextColor") = "Black";
    
    oGrid.SelectionColorProp("SelRow", "BgColor") = "#D1DEF0";
    oGrid.SelectionColorProp("CurRow", "BgColor") = "#D1DEF0";
    oGrid.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF";
    oGrid.SelectionColorProp("CurCol", "TextColor") = "Black";

    oGrid.LineColor = "#666666";	//A0B1CA
    
	oGrid.RowPosition = 0;

}


/**
 * 함 수 명 : ln_TRSetting()
 * 매개변수 : 없슴
 * 설    명 : Transation Parameter Setting
 */
function ln_TRSetting(a_TR, a_TR_ACTION,a_TR_KEYVALUE, a_TR_PARAMETERS )
{

	a_TR.ServerIP   = ""              ;
  	a_TR.Action     = a_TR_ACTION     ;
  	a_TR.KeyName    = "Toinb_dataid4" ;
  	a_TR.KeyValue   = a_TR_KEYVALUE   ;
  	a_TR.Parameters = a_TR_PARAMETERS ;

}

/**
 * 함 수 명 : tr_post()
 * 매개변수 : 없슴
 * 설    명 : Transation Post
 */
function tr_post(a_TR)
{
	a_TR.post();
}	
