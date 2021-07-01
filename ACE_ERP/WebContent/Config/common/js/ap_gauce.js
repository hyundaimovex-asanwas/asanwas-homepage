/* 	2014-06-16	�ɵ���
 * 	���ڰ�������� ���߸� ���� common_gauce ����..
 * 	�ʹ� ��� �׷��� ��Ŭ�������� �� �������� �ʾ� ��_��
 * 
 * 
 * */


/**
 * @type   : prototype_function
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� trim �޼ҵ带 �߰��Ѵ�. trim �޼ҵ�� ��Ʈ���� �հ� �ڿ�
 *           �ִ� white space �� �����Ѵ�.
 * <pre>
 *     var str = " abcde "
 *     str = str.trim();
 * </pre>
 * ���� ������ str�� "abede"�� �ȴ�.
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
 * @desc   : ���콺 Grid�� Style�� ������ Style�� �ٲپ��ش�. Style�� ���õ� ������ ������ǥ�ع����� ������ ��.
 * <pre>
 *     cfStyleGrid(oDelivRsltGG, "comn", features);
 * </pre>
 * @sig    : oGrid, styleName[, features]
 * @param  : oGrid     required Grid ������Ʈ
 * @param  : styleName required Grid�� style name. ����� "comn" �� "comnOnTab" �� �ִ�.
 * @param  : features  optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.
 * <pre>
 *     indWidth  : Grid�� IndWidth �Ӽ� ����.
 *     rowHeight : Grid�� RowHeight �Ӽ� ����.
 *     rowHeight : Grid�� titleHeight �Ӽ� ����.
 *
 *     ��뿹) "indWidth=12,rowHeight=25,titleHeight=30"
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


	// <C> �÷� �Ӽ�
	var CColor;
	var CHeadColor;
	var CHeadBgColor;
	var CHeadFontStyle;


	// <FC> �÷� �Ӽ�
	var FCColor;
	var FCBgColor;
	var FCHeadColor;
	var FCHeadBgColor;


	// <G> �÷� �Ӽ�
	var GHeadColor;
	var GHeadBgColor;


	// <FG> �÷� �Ӽ�
	var FGHeadColor;
	var FGHeadBgColor;


	// <X> �÷� �Ӽ�
	var XHeadColor;
	var XHeadBgColor;


	// <FX> �÷� �Ӽ�
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


	// Grid Style �� ����
	switch (styleName) {
        case "approval":	//����ȭ�� �׸����
            // Grid �Ӽ�
            titleHeight      = 20;
            fontSize         = "9pt";
            fontFamily       = "����";
            indWidth        = "0";
            
            // �÷� ���� �Ӽ�
            sumColor         = "#333333";
            sumBgColor       = "#d4d0c8";
            subColor         = "#ff0000";	//464646
            subBgColor       = "#00ff00";	//D8D8D8
            //subpressBgColor  = "#FFFFFF";
            subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#f8f8f8',1,'#FFFFFF')}"; //"#F0F0F0"


            // �÷��� �Ӽ�
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

        case "apline":	//���缱 �׸����
            // Grid �Ӽ�
            titleHeight      = 20;
            fontSize         = "9pt";
            fontFamily       = "����";
            indWidth        = "0";
            
            // �÷� ���� �Ӽ�
            sumColor         = "#333333";
            sumBgColor       = "#d4d0c8";
            subColor         = "#ff0000";	//464646
            subBgColor       = "#00ff00";	//D8D8D8
            //subpressBgColor  = "#FFFFFF";
            subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#f8f8f8',1,'#FFFFFF')}"; //"#F0F0F0"


            // �÷��� �Ӽ�
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


	// Grid �Ӽ� ����
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

	// Grid Format String �� �Ľ��Ͽ� �÷����� Style �� ���õ� �Ӽ��� �����Ѵ�.
	while ((tagMatch = gFormat.match(tagRE)) != null) {
		var style = "";
		var isSupress = false;

		// ����ڰ� ������ �÷� �Ӽ��� ���� ó��
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

		// ����ڰ� ������ �÷� �Ӽ��� ���� ó��
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		if (style == "TITLE") {
			headColor = "#FFFFFF";
			headBgColor = "#8AA1C2";
			headAlign = "Left";
		} else if (style == "REQUIRED") {
			headColor = "#1467E4";
		}

		// Grid�� Format �� Style ���� �Ӽ������� �����Ѵ�.
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
 * �� �� �� : ln_TRSetting()
 * �Ű����� : ����
 * ��    �� : Transation Parameter Setting
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
 * �� �� �� : tr_post()
 * �Ű����� : ����
 * ��    �� : Transation Post
 */
function tr_post(a_TR)
{
	a_TR.post();
}	
