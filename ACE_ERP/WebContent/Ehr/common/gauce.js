var TRIM_PATTERN = /(^\s*)|(\s*$)/g; // ������ ���� ������� trim�ϱ� ���Ѱ�(��/��)
var ALL_TRIM_PATTERN = /\s*/g;		 // ��簪�� ������ ����.
/*************************************************************************
 *  String.trim()
 *  ������ �� ���� ������ ������ �ִ� �޼ҵ�
 *************************************************************************
 * Author    : �����
 * Date       : 2004.04.12
 * History   : ���� �ۼ�
 * Desc      : ������ �� ���� ������ ������ �ִ� �޼ҵ�
 * Param    : none
 * Return    : trim()�� ���ڿ�
 *************************************************************************/
String.prototype.trim = function() {
	return this.replace(TRIM_PATTERN, "");
}

/*************************************************************************
 *  String.trimAll()
 *  ������ ��� ������ ������ �ִ� �޼ҵ�
 *************************************************************************
 * Author    : �����
 * Date       : 2004.04.12
 * History   : ���� �ۼ�
 * Desc      : ������ ��� ������ ������ �ִ� �޼ҵ�
 * Param    : none
 * Return    : trimAll()�� ���ڿ�
 *************************************************************************/
String.prototype.trimAll = function() {
	return this.replace(ALL_TRIM_PATTERN, "");
}

/**
 * @type   : function
 * @access : public
 * @desc   : ���콺�� �����ͼ� ������Ʈ ���� �÷� ��� ������ �����Ѵ�.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS);
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet
 * @param  : oOriginDataSet required ���� DataSet
 * @param  : oTargetDataSet required ����Ǿ��� DataSet
 * @author : �����
 */
function cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet) {
	var DsHeader = "";
	var colId   = "";
	var colType = "";
	var colProp = "";
	var colSize = ""
	for (var i = 1; i <= oOriginDataSet.CountColumn; i++) {
 		colId   = oOriginDataSet.ColumnID(i);	     //column id
		colIndex= oOriginDataSet.ColumnIndex(colId);  //column id�� �ش��ϴ� index��
		colSize = oOriginDataSet.ColumnSize(colIndex);//column size
		/* column�� type ���� �ڵ�
			Type  Description
			-----------------
			 1    String
			 2    Integer
			 3    Decimal
			 4    Date
			 5    URL
		*/
		//column type����
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

		/* column�� property ����
			0 : Normal (Key = No)
			1 : Constant
			2 : Key (Normal, Sequence)
			3 : Sequence (Key = No) // ���� �ǹ̾���.
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
 * @desc   : ���콺�� �����ͼ� ������Ʈ ���� �����͸� �����Ѵ�. �������� �Ǵ� �����ͼ��� ������ �����ʹ� ��� �����ȴ�.
 *           features �Ķ���Ϳ��� copyHeader�� yes�� �� ��� DataSet�� �÷��������� ����ȴ�.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS, "copyHeader=no");
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet[, features]
 * @param  : oOriginDataSet required ���� DataSet
 * @param  : oTargetDataSet required ����Ǿ��� DataSet
 * @param  : features       optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.
 * <pre>
 *     copyHeader  : Header�� �������� ����. (default:yes)
 *     resetStatus : ����� DataSet�� Status�� reset �� �� ����. (default:yes)
 *     rowFrom     : ������ row�� ���� index. (default:1)
 *     rowCnt      : ������ row�� ���� index. (default:DataSet.CountRow �� ��)
 *     ��뿹) "copyHeader=yes,rowFrom=1,rowCnt=2"  -> 1�� row ���� 3�� row���� Header�� �Բ� ������.
 * </pre>
 * @author : �����
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
		var temp = oTargetDataSet.dataid;  // importdata�� �� �� DataSet�� ������ dataid �Ӽ����� �������� ���� ����.
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
 * @desc   : features ��Ʈ���� �Ľ��Ͽ� array�� �����ϴ� ���� �Լ�
 * @sig    : features, fNameArray, fValueArray, fTypeArray
 * @param  : features    required features�� ǥ���� ��Ʈ��
 * @param  : fNameArray  required �����ؾ� �� feature�� �̸��� ���� array
 * @param  : fValueArray required �����ؾ� �� feature�� �⺻���� ���� array
 * @param  : fTypeArray  required �����ؾ� �� feature�� ������Ÿ�Կ� ���� array
 * @author : �����
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
 *	ȭ�鿡 ���α׷����� ������Ʈ�� �����Ѵ�.
 */
function cfCreateBar() {
	var progress = "";
	try	{
		if (tempObj.classid.toUpperCase() == "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB") {	// �����ͼ�.
			progress = '<iframe src="/images/loading.gif" id=oProgressBar style="position:absolute;visibility:hidden;width:199;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
		} else if (tempObj.classid.toUpperCase() == "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5") { // Ʈ������ ������Ʈ.
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
		alert("ó�����Դϴ�.\n��ø� ��ٷ� �ֽʽÿ�.");
		return;
	}

}

var GLB_SUBMIT_STATUS = false;
/**
 * ȭ���� ���α׷����ٸ� �����Ѵ�.
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
 *	ȭ�鿡 ���α׷����ٸ� ǥ���Ѵ�.
 */
function cfSubmit() {
	if (GLB_SUBMIT_STATUS == true)	{
		alert("ó�����Դϴ�.\n��ø� ��ٷ� �ֽʽÿ�.");
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
 *	������Ʈ Ÿ�Կ� ���� SUBMIT/POST/RESET�� �����Ѵ�.
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
		if (tempObj.classid.toUpperCase() == "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB") {	// �����ͼ�.
			tempObj.reset();
		} else if (tempObj.classid.toUpperCase() == "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5") { // Ʈ������ ������Ʈ.
			tempObj.post();
		}
	} catch (exception) {
		document.form1.submit();
	}
}

/** Replace�� **/
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
 * author : �����
 * date    : 2004/06/21
 * desc   : �׸��忡 ǥ�� ��Ÿ���� �����Ѵ�.
 * param : styleName  : ��Ÿ�ϸ� (�����ϸ� ǥ�ؽ�Ÿ�� ����)
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


	// <C> �÷� �Ӽ�
	var CColor;
	var CHeadColor;
	var CHeadBgColor;

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

	var indWidth    = 15;
	var rowHeight   = 20;
	var titleHeight = 20;

	// Grid Style �� ����
	switch (styleName) {
		case "comn":
			// Grid �Ӽ�
			titleHeight      = titleHeight;
//				titleHeight      = 20;
			fontSize         = "11px";
			fontFamily       = "Tahoma";

			// �÷� ���� �Ӽ�
			sumColor         = "#000000";
			sumBgColor       = "#FAE9BD";	// Summary
			subColor         = "#000000";
			subBgColor       = "#FBF5D8";
			subpressBgColor  = "#FFFFFF"; //"{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#FCFCFC"

			// �÷��� �Ӽ�
			CColor           = "#454648";
			CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#F5F5F5',1,'#F5F5F5')}"; //"#FCFCFC"
			CHeadColor       = "#000000";	// C�÷� ��� ��Ʈ ����
			CHeadBgColor     = "#DAE5FE";	// C�÷� ��� ����
			FCColor          = "#454648";
			FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#F0F0F0"
			FCHeadColor      = "#000000";	// FC�÷� ��� ��Ʈ ����
			FCHeadBgColor    = "#E4E0D5";	// FC�÷� ��� ����
			GHeadColor       = "#000000";	// G�÷� ��� ��Ʈ ����
			GHeadBgColor     = "#DAE5FE";	// G�÷� ��� ����
			FGHeadColor      = "#000000";	// FG�÷� ��� ��Ʈ ����
			FGHeadBgColor    = "#D4CFC9";	// FG�÷� ��� ����
			XHeadColor       = "#000000";	// X�÷� ��� ��Ʈ ����
			XHeadBgColor     = "#D3CDC1";	// X�÷� ��� ����.
			FXHeadColor      = "#000000";	// FX�÷� ��� ��Ʈ ����
			FXHeadBgColor    = "#D3CDC1";	// FX�÷� ��� ����
			break;

		default:
			// Grid �Ӽ�
			titleHeight      = titleHeight;
//				titleHeight      = 20;
			fontSize         = "11px";
			fontFamily       = "Tahoma";

			// �÷� ���� �Ӽ�
			sumColor         = "#000000";
			sumBgColor       = "#FAE9BD";	// Summary
			subColor         = "#000000";
			subBgColor       = "#FBF5D8";
			subpressBgColor  = "#FFFFFF"; //"{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#FCFCFC"

			// �÷��� �Ӽ�
			CColor           = "#454648";
			CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#FCFCFC"
			CHeadColor       = "#000000";	// C�÷� ��� ��Ʈ ����
			CHeadBgColor     = "#DAE5FE";	// C�÷� ��� ����
			FCColor          = "#454648";
			FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#EFEFEF',1,'#FFFFFF')}"; //"#F0F0F0"
			FCHeadColor      = "#000000";	// FC�÷� ��� ��Ʈ ����
			FCHeadBgColor    = "#CECECE";	// FC�÷� ��� ����
			GHeadColor       = "#000000";	// G�÷� ��� ��Ʈ ����
			GHeadBgColor     = "#B4B4B4";	// G�÷� ��� ����
			FGHeadColor      = "#000000";	// FG�÷� ��� ��Ʈ ����
			FGHeadBgColor    = "#B4B4B4";	// FG�÷� ��� ����
			XHeadColor       = "#000000";	// X�÷� ��� ��Ʈ ����
			XHeadBgColor     = "#9B9B9B";	// X�÷� ��� ����.
			FXHeadColor      = "#000000";	// FX�÷� ��� ��Ʈ ����
			FXHeadBgColor    = "#9B9B9B";	// FX�÷� ��� ����
			break;
	}

	// Grid �Ӽ� ����
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
	oGrid.AutoResizing = true;
	oGrid.HeadLineColor = "#666666";
	oGrid.LineColor  = "#FFFFFF";
	oGrid.HeadBorder = 4;
	oGrid.BorderStyle = 1;
	switch(styleName) {
		case "comn" :
			// Focus�� �ְ� Editable�� ���¿���, ���õ� Row���� ���õ� Cell
			oGrid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#009BA8', TextColor='Black'</SC>";

			// Focus�� �ְ� Editable�� �ƴ� ���¿���, ���õ� Row���� ���õ� Cell�� ������ �ٸ���
			oGrid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#D0E6B8', TextColor='Black'</SC>";

			// Focus�� ���� Editable�� ���¿���, ���õ� Row���� ���õ� Cell
			oGrid.SelectionColor += "<SC>Type='EditCol', BgColor='#FDAB37', TextColor='navy'</SC>";

			// Focus�� ����� Editable�� ���¿���, ���õ� Row���� ���õ� Cell�� ������ ������ Cell��
			oGrid.SelectionColor += "<SC>Type='EditRow', BgColor='#F6ECC1', TextColor='Black'</SC>";

			// Focus�� �ְ� MultiSelect�� �� ���õ� Row(Mark�� Row)�� Cell��(���� Row ? ���� �������� ���õ� Row ? ����)
			oGrid.SelectionColor += "<SC>Type='FocusCurCol', BgColor='Black', TextColor='White'</SC>";

			// Focus�� ���� Editable�� ���¿���, ���õ� Row���� ���õ� Cell
			oGrid.SelectionColor += "<SC>Type='CurCol', BgColor='#0089D8', TextColor='Goldk'</SC>";

			// Focus�� ���� Editable�� ���¿���, ���õ� Row���� ���õ� Cell�� ������ ������ Cell�� (��Ŀ�� ���¿��� ���õ� ROW)
			oGrid.SelectionColor += "<SC>Type='FocusCurRow', BgColor='#FFFF88', TextColor='black'</SC>";

			// Focus�� ���� Editable�� �ƴ� ���¿���, ���õ� Row���� ���õ� Cell (��Ŀ�� ���� ������ ���õ� ROW)
			oGrid.SelectionColor += "<SC>Type='CurRow', BgColor='#E7E498', TextColor='black'</SC>";

			// Focus�� ���� Editable�� �ƴ� ���¿���, ���õ� Row���� ���õ� Cell�� ������ ������ Cell��
			oGrid.SelectionColor += "<SC>Type='FocusSelRow', BgColor='Brown', TextColor='maroon'</SC>";

			//Focus�� ���� MultiSelect�� �� ���õ� Row(Mark�� Row)�� Cell��(���� Row ? ���� �������� ���õ� Row ? ����)
			oGrid.SelectionColor += "<SC>Type='SelRow', BgColor='Green', TextColor='mistyrose'</SC>";
			break;
		default :
			// Focus�� �ְ� Editable�� ���¿���, ���õ� Row���� ���õ� Cell
			oGrid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#00A0C2', TextColor='Black'</SC>";

            // Focus�� �ְ� Editable�� �ƴ� ���¿���, ���õ� Row���� ���õ� Cell�� ������ �ٸ���
			oGrid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#D7EEFF', TextColor='Black'</SC>";

			// Focus�� ���� Editable�� ���¿���, ���õ� Row���� ���õ� Cell
			oGrid.SelectionColor += "<SC>Type='EditCol', BgColor='#00B296', TextColor='navy'</SC>";

			// Focus�� ����� Editable�� ���¿���, ���õ� Row���� ���õ� Cell�� ������ ������ Cell��
			oGrid.SelectionColor += "<SC>Type='EditRow', BgColor='#F3FED2', TextColor='Black'</SC>";

			// Focus�� �ְ� MultiSelect�� �� ���õ� Row(Mark�� Row)�� Cell��(���� Row ? ���� �������� ���õ� Row ? ����)
			oGrid.SelectionColor += "<SC>Type='FocusCurCol', BgColor='Black', TextColor='White'</SC>";

			// Focus�� ���� Editable�� ���¿���, ���õ� Row���� ���õ� Cell
			oGrid.SelectionColor += "<SC>Type='CurCol', BgColor='#0089D8', TextColor='Goldk'</SC>";

			// Focus�� ���� Editable�� ���¿���, ���õ� Row���� ���õ� Cell�� ������ ������ Cell�� (��Ŀ�� ���¿��� ���õ� ROW)
			oGrid.SelectionColor += "<SC>Type='FocusCurRow', BgColor='#0089D8', TextColor='white'</SC>";

			// Focus�� ���� Editable�� �ƴ� ���¿���, ���õ� Row���� ���õ� Cell (��Ŀ�� ���� ������ ���õ� ROW)
			oGrid.SelectionColor += "<SC>Type='CurRow', BgColor='#D4CFE0', TextColor='black'</SC>";

			// Focus�� ���� Editable�� �ƴ� ���¿���, ���õ� Row���� ���õ� Cell�� ������ ������ Cell��
			oGrid.SelectionColor += "<SC>Type='FocusSelRow', BgColor='Brown', TextColor='maroon'</SC>";

			//Focus�� ���� MultiSelect�� �� ���õ� Row(Mark�� Row)�� Cell��(���� Row ? ���� �������� ���õ� Row ? ����)
			oGrid.SelectionColor += "<SC>Type='SelRow', BgColor='Green', TextColor='mistyrose'</SC>";
			break;
	}

}

/**
  * ����¡ó���� ���� ��ü.
  **/ 
function Page(p_dsId, p_x, p_y) {
	var svr_sortexpr = "";	// ���� sortExpr IND���ÿ�.
	var dsId = p_dsId;		// �����ͼ� 
	var sortColumn = "";	// ���� ��Ʈ �÷� 
	var orderBy = "-1";			// Orderby index Laf/J�� dao���� ����.
	var sortType = "";		// ��Ʈ Ÿ�� ���� 1001, 1002
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


	/** ���� �����ʿ� ������ ��Ʈ �÷��� ��ȸ�ϴ� �޼ҵ� **/
	this.getSortColumn = function() {
		return sortColumn;
	}


	/** ���� �����ʿ� ����ǰ��ִ� sortǥ������ ��ȸ�ϴ� �޼ҵ� **/
	this.getSortExpr = function() {
		return svr_sortexpr;
	}

	/** Order by ���� **/
	this.setOrderBy = function(idx) {
		orderBy = idx;
	}

	/** ���� ����� ��ȸ�ϴ� �޼ҵ� **/
	this.getOrderBy = function(col) {
		if (sortColumn == col) {
			return orderBy;
		} else {
			return -1;
		}
	}
	/** ��Ʈ �÷� ���� **/
	this.setSortColumn = function(p_gridObj, col) {
		prevSortColumn = sortColumn;
		sortColumn = col;
		var tmp = p_gridObj.ColumnProp(col, "name");	
		tmp = tmp.replaceStr("��", "");
		tmp = tmp.replaceStr("��", "");
		p_gridObj.ColumnProp(col, "name") = tmp;
		p_gridObj.ColumnProp(col, "ToolTipText") = "���콺 ������ ��ư�� ������ ��Ʈ����� ���� �Ҽ��ֽ��ϴ�.";
	}

	/** ��Ʈ Ÿ�� ���� : 1001(����), 1002(������Ʈ) **/
	this.setSortType = function(p_gridObj, p_sortType) {
		svr_sortexpr = "";	// ��Ʈ Ÿ�� �ʱ�ȭ.
		orderBy = -1;			// ��Ʈ �ε��� �ʱ�ȭ.
		try {
			if (p_sortType == 1001) {			// ������ ��쿡�� status����
				p_gridObj.ColumnProp(prevSortColumn, "HeadColor") = "black";
				if (prevSortColumn == sortColumn || prevSortColumn == "") {
					var tmp = p_gridObj.ColumnProp(sortColumn, "name");	
					if (tmp.indexOf("��") == -1){
						p_gridObj.ColumnProp(sortColumn, "name") = tmp + "��";
					}

				} else {
					var tmp = p_gridObj.ColumnProp(prevSortColumn, "name");	
					tmp = tmp.replaceStr("��", "");
					tmp = tmp.replaceStr("��", "");
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
			alert("��Ʈ Ÿ���� [1001:������Ʈ���, 1002:������Ʈ ��Ʈ���]�� ����ϽǼ��ֽ��ϴ�.");
			return;
		}
	}



	/** Ư�� �������� �̵��Ҷ� ����ϴ� �޼ҵ� **/
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

	/** �����ͼ� �Ǵ� Ʈ������ ������Ʈ�� reset/post �ϴ� �޼ҵ� �� �޼ҵ带 ����ϸ� ���α׷����ٰ� ��Ÿ����. **/
	this.submit = function() {
		cfSubmit(dsId, x, y);
	}

	/** ������ ����Ʈ�� ��ȯ�ϴ� �޼ҵ� **/
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

	/** ��� ������ ǥ�����ִ� �޼ҵ� **/
	this.info = function() {
		alert(dsId.text);
	}

	/** ��Ʈ ��� ����  **/
	this.sort = function(p_grid, row, colid) {
		var col = "";
		
		if (row > 0) return;


		if (sortColumn != "" && sortColumn == colid)	 {	// ���� ��Ʈ�� ��� 
			
			var tmp_name = p_grid.ColumnProp(colid, "name");	

			if (tmp_name.indexOf("��") == -1 && tmp_name.indexOf("��") == -1) {
				tmp_name += "��";
			} else if (tmp_name.indexOf("��")  != -1) {
				tmp_name =  tmp_name.replaceStr("��", "��");
			} else {
				tmp_name =  tmp_name.replaceStr("��", "��");
			}

			if (svr_sortexpr.indexOf(colid) == -1) {
					svr_sortexpr += "+" + colid;
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("��", "");
					col += "��" ;
					p_grid.ColumnProp(colid, "name") = col;
			} else if (svr_sortexpr.indexOf("+" + colid) != -1) {
					svr_sortexpr = svr_sortexpr.replaceStr("+" + colid, "-" + colid);
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("��", "��");
					p_grid.ColumnProp(colid, "name") = col;
			} else if (svr_sortexpr.indexOf("-" + colid) != -1) {
					svr_sortexpr = svr_sortexpr.replaceStr("-" + colid, "+" + colid);
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("��", "��");
					p_grid.ColumnProp(colid, "name") = col;
			}

			p_grid.ColumnProp(colid, "name") = col;		// ind����.

			// orderBy����.
			var param = "&orderBy=" + orderBy;
			var uri = dsId.DataId;
			if (uri.indexOf("&orderBy") != -1) {
				uri = uri.substring(0, uri.indexOf("&orderBy"));
			}
			dsId.DataId = uri + param;
//			result = "";
			var tmp_sort = eval(p_grid.dataId).sortexpr;		// sort����Ʈ.
			if (tmp_sort.indexOf(colid) != -1)	{
				tmp_sort = tmp_sort.replaceStr("+" + colid, "");
				tmp_sort = tmp_sort.replaceStr("-" + colid, "");
			}
			eval(p_grid.dataId).sortexpr = tmp_sort;
			this.clearSort(p_grid, colid);
//			TEST.innerHTML = "DEBUG MSG : type - " +type +  " \n sortColumn : " + sortColumn + " orderBy : " + orderBy + "  sortType : " + sortType + "\n prevSortColumn : " + prevSortColumn +   "  svr_sortexpr : " + svr_sortexpr;
			cfSubmit(dsId, x, y);									// ��ȸ ����
		} else {															// ������Ʈ ��Ʈ�� ���.
			var result = eval(p_grid.dataId).sortexpr;
			if (result.indexOf(colid) == -1) {
					result += "+" + colid;
					col = p_grid.ColumnProp(colid, "name");	
					col += "��" ;
					p_grid.ColumnProp(colid, "name") = col;
			} else if (result.indexOf("+" + colid) != -1) {
					result = result.replaceStr("+" + colid, "-" + colid);
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("��", "��");
					p_grid.ColumnProp(colid, "name") = col;
			} else if (result.indexOf("-" + colid) != -1) {
					result = result.replaceStr("-" + colid, "");
					col = p_grid.ColumnProp(colid, "name");	
					col = col.replaceStr("��", "");
					p_grid.ColumnProp(colid, "name") = col;
			}
			
			eval(p_grid.dataId).sortexpr = result;
			//alert( svr_sortexpr + result);
			eval(p_grid.dataId).sort();
			eval(p_grid.dataId).RowPosition = 1;
		}
	}

	/** ���콺 ������Ʈ�� ��Ʈ �Ӽ��� �����ϴ� �޼ҵ� **/
	this.clearSort = function(p_gridObj, p_colid) {
		var cnt = p_gridObj.CountColumn;
		for ( i=0; i<cnt ; i++ ) {
			if (p_gridObj.GetColumnID(i) != p_colid) {
					var col = p_gridObj.ColumnProp(p_gridObj.GetColumnID(i), "name");	
					col = col.replaceStr("��", "");
					col = col.replaceStr("��", "");
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