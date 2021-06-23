/**************************/
/* 	PentaBreed co. ltd. 	  */
/* 	jjeony@pentabreed.com  */
/**************************/


var nowOpenedSelectBox = "";
var mousePosition = "";
var ck_value = "";

function selectThisValue(thisId,thisIndex,thisValue,thisString) {
	var objId = thisId;
	var nowIndex = thisIndex;
	var valueString = thisString;
	var sourceObj = document.getElementById(objId);
	var nowSelectedValue = document.getElementById(objId+"SelectBoxOptionValue"+nowIndex).value;
	hideOptionLayer(objId);
	if (sourceObj) sourceObj.value = nowSelectedValue;
	settingValue(objId,valueString);
	selectBoxFocus(objId);
	if (sourceObj.onchange) sourceObj.onchange();
}

function settingValue(thisId,thisString) {
	var objId = thisId;
	var valueString = thisString;
	var selectedArea = document.getElementById(objId+"selectBoxSelectedValue");
	if (selectedArea) selectedArea.innerText = valueString;
}

function viewOptionLayer(thisId) {
	var objId = thisId;
	var optionLayer = document.getElementById(objId+"selectBoxOptionLayer");
	if (optionLayer) optionLayer.style.display = "";
	nowOpenedSelectBox = objId;
	setMousePosition("inBox");
}

function hideOptionLayer(thisId) {
	var objId = thisId;
	var optionLayer = document.getElementById(objId+"selectBoxOptionLayer");
	if (optionLayer) optionLayer.style.display = "none";
}

function setMousePosition(thisValue) {
	var positionValue = thisValue;
	mousePosition = positionValue;
}

function clickMouse() {
	if (mousePosition == "out") hideOptionLayer(nowOpenedSelectBox);
}

function selectBoxFocus(thisId) {
	var objId = thisId;
	var tt = objId.indexOf("Search");
	var obj = document.getElementById(objId + "selectBoxSelectedValue");

	//obj.className = ck_value + "SelectedAreaFocus";


	if (tt == 0){
	 obj.className = "search" + "SelectedAreaFocus";
	}

	else{
	 obj.className =  ck_value + "SelectedAreaFocus";
	}

	obj.focus();


}

function selectBoxBlur(thisId) {
	var objId = thisId;
	var tt = objId.indexOf("Search");
	var obj = document.getElementById(objId + "selectBoxSelectedValue");

	if (tt == 0){
	 obj.className = "search" + "SelectedArea";
	}

	else{
	 obj.className =  ck_value + "SelectedArea";
	}

	//obj.className = ck_value + "SelectedArea";

}

function Select_box(thisId, s_value) {


	var downArrowSrc = "/img/common/select_arrow_"+s_value+".gif";	//오른쪽 화살표이미지
	var downArrowSrcWidth = 17;	//오른쪽 화살표이미지 width
	var optionHeight = 18; // option 하나의 높이
	var optionMaxNum = 6; // 한번에 보여지는 option의 갯수
	var optionInnerLayerHeight = "";
	var objId = thisId;
	var obj = document.getElementById(objId);
	var selectBoxWidth = parseInt(obj.style.width);
	var selectBoxHeight = parseInt(obj.style.height);

	ck_value = s_value;	


	if (obj.options.length > optionMaxNum) optionInnerLayerHeigHt = "height:"+ (optionHeight * optionMaxNum) + "px";
	newSelect  = "<table id='" + objId + "selectBoxOptionLayer' cellpadding='0' cellspacing='0' border='0' style='position:absolute;z-index:100;display:none;' onMouseOver=\"viewOptionLayer('"+ objId + "')\" onMouseOut=\"setMousePosition('out')\">";
	newSelect += "	<tr>";
	newSelect += "		<td height='" + selectBoxHeight + "' style='cursor:hand;' onClick=\"hideOptionLayer('"+ objId + "')\"></td>";
	newSelect += "	</tr>";
	newSelect += "	<tr>";
	newSelect += "		<td height='3'></td>";
	newSelect += "	</tr>";
	newSelect += "	<tr>";
	newSelect += "		<td class='"+s_value+"Select'>";
	newSelect += "		<div class='"+s_value+"OptionInnerLayer' style='width:" + (selectBoxWidth - 2) + "px;" + optionInnerLayerHeight + "'>";
	newSelect += "		<table cellpadding='0' cellspacing='0' border='0' width='100%' style='table-layout:fixed;word-break:break-all;'>";
	for (var i=0 ; i < obj.options.length ; i++) {
		var nowValue = obj.options[i].value;
		var nowText = obj.options[i].text;
		newSelect += "			<tr>";
		newSelect += "				<td height='" + optionHeight + "' class='"+s_value+"Option' onMouseOver=\"this.className='"+s_value+"OptionOver'\" onMouseOut=\"this.className='"+s_value+"Option'\" onClick=\"selectThisValue('"+ objId + "'," + i + ",'" + nowValue + "','" + nowText + "')\" style='cursor:hand;'>" + nowText + "</td>";
		newSelect += "				<input type='hidden' id='"+ objId + "SelectBoxOptionValue" + i + "' value='" + nowValue + "'>";
		newSelect += "			</tr>";
	}

	newSelect += "		</table>";
	newSelect += "		</div>";
	newSelect += "		</td>";
	newSelect += "	</tr>";
	newSelect += "</table>";
	newSelect += "<table cellpadding='0' cellspacing='0' border='0' class='"+s_value+"Select' onClick=\"viewOptionLayer('"+ objId + "')\" style='cursor:hand;'>";
	newSelect += "	<tr>";
	newSelect += "		<td>";
	newSelect += "		<table cellpadding='0' cellspacing='0' border='0'>";
	newSelect += "			<tr>";
	newSelect += "				<td><div id='" + objId + "selectBoxSelectedValue' class='"+s_value+"SelectedArea' style='width:" + (selectBoxWidth - downArrowSrcWidth - 2) + "px;height:" + (selectBoxHeight - 2) + "px;overflow:hidden;' onBlur=\"selectBoxBlur('" + objId + "')\"></div></td>";
	newSelect += "				<td><img src='" + downArrowSrc + "' width='" + downArrowSrcWidth + "' border='0'></td>";
	newSelect += "			</tr>";
	newSelect += "		</table>";
	newSelect += "		</td>";
	newSelect += "	</tr>";
	newSelect += "</table>";
	document.write(newSelect);
	
	var haveSelectedValue = false;
	for (var i=0 ; i < obj.options.length ; i++) {
		if (obj.options[i].selected == true) {
			haveSelectedValue = true;
			settingValue(objId,obj.options[i].text);
		}
	}
	if (!haveSelectedValue) settingValue(objId,obj.options[0].text);
}



document.onmousedown = clickMouse;