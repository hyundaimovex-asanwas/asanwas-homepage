/*****************************************************
* @source      : input.js
* @description : 입력관련 UTIL들 모음
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/24      조정호                   최초작성
*****************************************************/

//유효성 검사에 사용하는 메세지
var Message = "을(를) 입력하세요";

/**
 * 입력창의 상태를(사용함)으로 변경 시킨다.
 * @param oElementList - 상태값을 변경시킬 항목 리스트
 * @param oExceptionList - oElementList중에서 검사를 하지 않을 항목들 
 */
function fnc_EnableElementAll(oElementList, oExceptionList) {    
	var oElementName = null;           
    for(i=0; i<oElementList.length; i++) {
    	oElementName = oElementList[i];
        //예외사항을 검색하여 예외에 해당하면 다시 처음부터
		if(!isNotException(oElementName, oExceptionList)) {
			continue;
		}    
        fnc_ChangeStateElement(true, oElementName);
    }                         

}

/**
 * 입력창의 상태를(사용안함)으로 변경 시킨다.
 * @param oElementList - 상태값을 변경시킬 항목 리스트
 * @param oExceptionList - oElementList중에서 검사를 하지 않을 항목들 
 */
function fnc_DisableElementAll(oElementList, oExceptionList) {   
	
	var oElementName = null;                        
	
    for(i=0; i<oElementList.length; i++) {
    	
    	oElementName = oElementList[i];
        //예외사항을 검색하여 예외에 해당하면 다시 처음부터

		if(!isNotException(oElementName, oExceptionList)) {
			continue;
		}    

        fnc_ChangeStateElement(false, oElementName);
   
    }            
    
}

/**
 * 선택 항목의 상태값을 변경 시킨다.
 * @param isEnable - 값을 disable 시킬건지 여부 검증 boolean
 * @param elementName - 변경시킬 엘리먼트 이름
 */
function fnc_ChangeStateElement(isEnable, oElementName) {
	
	var oElementList;
	    
    var oElement = document.getElementById(oElementName);
  
    if(oElement == undefined || oElement == null) {
    	return;
    }
    
    var vNodeName = oElement.nodeName.toLowerCase();
    var vType;
    
    var bindClassName;
    var bindStatus;
    
    //입력시킬 값 설정
    if(isEnable) {
        bindClassName = "";
        bindStatus = false;
    } else {
        bindClassName = "input_ReadOnly";
        bindStatus = true;
    }
    
    //입력창일때
    if(vNodeName == "input") {
    	vType = oElement.type.toLowerCase();
    
		//radio, checkbox
       	if(vType == "radio" || vType == "checkbox") {
			oElementList = document.getElementsByName(oElementName);
       		for(var i=0; i<oElementList.length; i++) {
	       		oElementList[i].disabled = bindStatus;
       		}
       	}           
       	
       	//button
       	else if(vType == "button") {
       		oElement.disabled = bindStatus;
       	}  
       	
       	//그 외 입력창들
       	else {      	
    	    oElement.readOnly = bindStatus;
    	    oElement.className = bindClassName;
    	}
    }
    //Gauce EmEdit Component
   	else if(vNodeName == "object" && oElement.classid == "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F") {
   		oElement.Enable = isEnable;
   		oElement.className = bindClassName;
   	}        
   	//Gauce Radio Component
   	else if(vNodeName == "object" && oElement.classid == "CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0") {
   		oElement.Enable = isEnable;
   	}        
   	//그 외
    else {
        oElement.disabled = bindStatus;
   	}           
    
    
}

/**
 * 입력창의 내용을 비운다.
 * @param oElementList - 지울 항목 리스트
 * @param oExceptionList - oElementList중에서 검사를 하지 않을 항목들 
 * @param defaultVal - 내용을 비울때 DEFAULT로 넣을 내용
 */
function fnc_ClearInputElement(oElementList, oExceptionList, defaultVal) {
	var oElement = null;
	var oElementName = null;
	var vNodeName;

	if(defaultVal == undefined || defaultVal == null) {
		defaultVal = "";
	}

    if(oElementList != null && oElementList != undefined) {
        for(i=0; i<oElementList.length; i++) {
        	oElementName = oElementList[i];
        
	        //예외사항을 검색하여 예외에 해당하면 다시 처음부터
			if(!isNotException(oElementName, oExceptionList)) {
				continue;
			}
        
            oElement = document.getElementById(oElementName);
            
	       	if(oElement == undefined) {
	       		alert("["+oElementName+"] Element 를 찾을 수 없습니다.");
	       		return;
	       	}            
            
			//항목 값 가져오기
			vNodeName = oElement.nodeName.toLowerCase();
	       	if(oElement.nodeName.toLowerCase() == "object" 
	       			&& oElement.classid == "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F") {
				oElement.text = defaultVal;
	       	} else if(oElement.nodeName.toLowerCase() == "object" 
	       			&& oElement.classid == "CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0") {
				oElement.CodeValue = "";
			} else if(oElement.nodeName.toLowerCase() == "input"
					&& (oElement.type.toLowerCase() == "radio" || oElement.type.toLowerCase() == "checkbox")) {
				document.getElementsByName(oElementName)[0].checked = true;
			} else {
				oElement.value = defaultVal;
			}
        }
    }    
}

/**
 * 유효성 검사 예외 항목인지 아닌지 체크
 * @param elementName - 검사할 엘리먼트 이름
 * @param oExceptionList - 예외 항목이 정의되어 있는 List
 */
function isNotException(elementName, oExceptionList) {
    var result      = true;

    if(typeof oExceptionList != 'undefined') {
        for(k=0; k < oExceptionList.length; k++) {
            if(elementName == oExceptionList[k]) result = false;
        }
    }

    return result;
}

/**
 * 유효성 검사를 한다.
 * @param oElementList - Input, Select Element 이름들을 가지고 있는 List
 * @param oElementMsgList - 에러 Msg들을 가지고 있는 List (oElementList와 크기가 같아야 함)
 * @param oExceptionList - oElementList중에서 검사를 하지 않을 항목들
 */
function fnc_CheckElement(oElementList, oElementMsgList, oExceptionList) {
	var oElement = null;
	var oElementName = null;
	var oElementValue = null;
	var oElementMsg = null;
	
	for(j=0; j<oElementList.length; j++) {
       	oElementName = oElementList[j];
       
     	//예외사항을 검색하여 예외에 해당하면 다시 처음부터
		if(!isNotException(oElementName, oExceptionList)) {
			continue;
		}
       
       	oElement 		= document.getElementById(oElementName);
       	oElementMsg 	= oElementMsgList[j];      	//항목 메세지 가져오기
       	
       	if(oElement == undefined) {
       		alert("["+oElementName+"] Element 를 찾을 수 없습니다.");
       		return;
       	}
       	
       	//항목 값 가져오기
       	if(oElement.nodeName.toLowerCase() == "object" 
       			&& oElement.classid == "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F") {
			oElementValue 	= oElement.text;
		} else {
			oElementValue 	= oElement.value;
		}
       
       	//값이 없으면
       	if(oElementValue == null || oElementValue.trim() == "" || oElementValue.trim() == "0") {
           	alert(oElementMsg+Message+oElementValue);
           	oElement.focus();
           	return false;
       	}
   	} 
   	return true;
}

/**
 * 유효성 검사를 한다.
 * @param oDataSet - GauceDataSet 객체
 * @param oElementList - Input, Select Element 이름들을 가지고 있는 List
 * @param oElementMsgList - 에러 Msg들을 가지고 있는 List (oElementList와 크기가 같아야 함)
 * @param oExceptionList - oElementList중에서 검사를 하지 않을 항목들
 */
function fnc_CheckDataSetElement(oDataSet, oElementList, oElementMsgList, oExceptionList) {
	var oElement = null;
	var oElementName = null;
	var type = null;
	var oElementValue = null;
	var oElementMsg = null;
	var saveStatus = null;

	//ds에 포함된 row 갯수를 가져옴
    for(i=1; i<=oDataSet.CountRow; i++){
        //ds 입력 타입이 insert 인지 update인지를 구분함
        //1:Insert
        //3:Update
        saveStatus = oDataSet.RowStatus(i);

		//입력상태가 insert, update 일때 그외 항목들 검증
        if(saveStatus == 1 || saveStatus == 3) {
		    for(j=0; j<oElementList.length; j++) {
		        oElementName = oElementList[j];
		        
		        //예외사항을 검색하여 예외에 해당하면 다시 처음부터
				if(!isNotException(oElementName, oExceptionList)) {
					continue;
				}
				
				type = oElementName.substr(0, 3).toLowerCase();
				if(type == "txt" || type == "cmb" || type == "med" || type == "chk") {
					oElement = document.getElementById(oElementName);
			        oElementValue = oDataSet.NameString(i, oElementName.substring(3));    //항목 값 가져오기
			        oElementMsg = oElementMsgList[j];                       //항목 메세지 가져오기
			        
			        //값이 없으면
			        if(oElementValue == null || oElementValue.trim() == "" || oElementValue.trim() == "0") {
			            alert(i+" "+oElementMsg+Message+oElementValue);
			            oDataSet.RowPosition = i;
			            oElement.focus();
			            return false;
			        }
				}
		        else {
		        	oElementValue = oDataSet.NameString(i, oElementName);   //항목 값 가져오기
			        oElementMsg = oElementMsgList[j];                       //항목 메세지 가져오기
			        
			        //값이 없으면
			        if(oElementValue == null || oElementValue.trim() == "" || oElementValue.trim() == "0") {
			            alert(i+" "+oElementMsg+Message+oElementValue);
			            oDataSet.RowPosition = i;
			            return false;
			        }
		        }
		    } 
		}
	}
	
	return true;
}

/**
 * input Element, select Element 들을 초기화 시킴
 * @param oExceptionList - 초기화 시키지 않을 필드 이름
 */
function fnc_ClearInputFieldAll(oExceptionList) {
    //값들 초기화
    fnc_ClearInputField("input", oExceptionList);
    fnc_ClearInputField("select", oExceptionList);
}

/**
 * input Element, select Element 들을 초기화 시킴
 * @param TagName - 초기화 시킬 Element Tag 이름
 * @param oExceptionList - 초기화 시키지 않을 필드 이름
 */
function fnc_ClearInputField(TagName, oExceptionList) {
	var oElementList = document.getElementsByTagName(TagName.toLowerCase());
	var oElement = null;
	var oElementName = null;
	var type = null;

	if(oElementList != null) {
	    for(i=0; i< oElementList.length; i++) {
	        oElement = oElementList[i];
	        oElementName = oElement.getAttribute("name");
	        type = oElement.getAttribute("type").toLowerCase();

			//예외사항을 검색하여 예외에 해당하면 다시 처음부터
			if(!isNotException(oElementName, oExceptionList)) {
				continue;
			}
			
			if(TagName.toLowerCase() == "input") {
				if(type == "button") continue;
				if(type == "checkbox") oElement.checked = false;
				else oElement.value = "";
			}
			else oElement.value = "";
	    }
    }
}

/**
 * 숫자형인지 아닌지 검증
 * @param chkVal - 검사할 값
 */
function isNum(str){ 
	if(str.length < 1) { 
		return false;
  	}
     
    for(var idx=0;idx < str.length;idx++){
		if(str.charAt(idx) < '0' || str.charAt(idx) > '9'){
       		return false;
      	}
   	}
    return true;
}

/**
 * radio Element에 해당 값을 check 한다.
 * @param elementName - 해당 Element Name
 * @param checkValue - check 할 값
 */
function fnc_CheckedElement(elementName, checkValue) {
	var oElementList = document.getElementsByName(elementName);
	var oElement = null;
	
	for(var i=0; i<oElementList.length; i++) {
		oElement = oElementList[i];
		
		//해당 Element의 값이 같다면 checked
		if(oElement.value == checkValue) {
			oElement.checked = true;
		}
	}
}

/**
 * check된 radio Element에 해당 값을 가져온다.
 * @param elementName - 해당 Element Name 
 */
function fnc_GetCheckedValue(elementName) {
	var oElementList = document.getElementsByName(elementName);
	var oElement = null;
	
	for(var i=0; i<oElementList.length; i++) {
		oElement = oElementList[i];
		
		//선택 되어 있다면 선택된 값 반환
		if(oElement.checked) {
			return oElement.value;
		}
	}	
	
	return "";
}

/**
 * 해당되는 DataSet 객체 값을 Target Object에 바인딩 시킴
 * @param oDataSet - GauceDataSet 객체
 * @param elementName - select Object 객체 이름
 */
function fnc_BindingCommonCode(oDataSet, elementName) {
	var oSelect = document.getElementById(elementName);
	var oOption = null;
	
	//첫번째 라인을 제외한 모든 option 삭제
	for(i=oSelect.options.length-1; i>0; i--) {
	    oSelect.remove(i);
	}
	
	// 직종 구분 검색 콤보박스 생성
	for(i = 1; i <= oDataSet.CountRow; i++ ) {
	    oOption       = document.createElement("OPTION");
	    oOption.value = oDataSet.NameValue(i,"CODE");
	    oOption.text  = oDataSet.NameValue(i,"CODE_NAME");
	    oSelect.add(oOption);
	}	
}

/**
 * 해당되는 DataSet 객체를 바인딩 시키고 초기화 시킨다.
 * (fnc_BindingCommonCode 와 차이점 - ds를 객체로 받지않고 함수내에서 조회 후 사용, 첫번째 라인의 초기화 선택 사용)
 * @param - ds 이름
 * @param - select 객체 이름
 * @param - 초기화 시킬 첫번째 줄의 값
 * @param - 초기화 시킬 첫번째 줄의 이름
 */
function fnc_ConstructCommonCode(commonDsName, elementName, constructVal, constructName) {
	var oDataSet= document.getElementById(commonDsName);
	var oSelect = document.getElementById(elementName);
	var oOption = null;
	
	if(constructVal == undefined || constructVal == "") {
		constructVal = "";
	}
	
	if(constructName == undefined || constructName == "") {
		constructName = "선  택";
	}
	
	//option 삭제
	for(i=oSelect.options.length-1; i>=0; i--) {
	    oSelect.remove(i);
	}
	
	// 직종 구분 검색 콤보박스 생성
	for(i = 0; i <= oDataSet.CountRow; i++ ) {
	    oOption       = document.createElement("OPTION");
	    //처음일때 초기화시킴
	    if(i == 0) {
	    	oOption.value = constructVal;
	    	oOption.text  = constructName;
	    } else {
	    	oOption.value = oDataSet.NameValue(i,"CODE");
	    	oOption.text  = oDataSet.NameValue(i,"CODE_NAME");
	    }
	    oSelect.add(oOption);
	}
}

/**
 * 공통 코드의 선택한 이름을 가지고 온다.
 * @param - Common DS 이름
 * @param - 선택한 code 명
 */
function fnc_GetCommonName(commonDsName, code) {
	var oDataSet= document.getElementById(commonDsName);
	
	for(i = 1; i <= oDataSet.CountRow; i++ ) {
		if(code == oDataSet.NameValue(i,"CODE")) {
			return oDataSet.NameValue(i,"CODE_NAME");
		}
	}
	
	return "";
}

/**
 * 해당 Element를 보여주기
 * @param elementName
 */
function fnc_ShowElement(elementName) {
	var oElement = document.getElementById(elementName);
	oElement.style.visibility = "visible";
	oElement.style.position = "static";
	oElement.style.display = "inline";
}

/**
 * 해당 Element를 숨기기
 * @param elementName
 */
function fnc_HiddenElement(elementName) {
	var oElement = document.getElementById(elementName);
	oElement.style.visibility = "hidden";
    oElement.style.position = "absolute";
    oElement.style.display = "none";
}

/**
 * 총 레이어 항목중 선택한 레이어만 보여주기
 * @param oLayerNameList - layer name list
 * @param showLayerName - 선택한 layer name
 */
function fnc_ShowHiddenLayer(oLayerNameList, showLayerName) {
	var layerName = null;
	var oElement = null;
	
	//모든 layer hidden
	for(var i=0; i<oLayerNameList.length; i++) {
		layerName = oLayerNameList[i];
	
	    oElement = document.getElementById(layerName);
	    
		if(oElement == undefined || oElement == null) {
	    	return;
	    }	    
	    
	    oElement.style.visibility = "hidden";
	    oElement.style.position = "absolute";
	    oElement.style.display = "none";
	}
	
	//선택한 layer를 보기
	oElement = document.getElementById(showLayerName);
	oElement.style.visibility = "visible";
	oElement.style.position = "static";
	oElement.style.display = "inline";
}


/**
 * 해당 Element의 Child Node를 모두 제거
 */
function fnc_RemoveChild(element) {
    if(element.hasChildNodes) {
        for(i=element.childNodes.length-1; i>=0; i--) {
            var child = element.childNodes[i];
            element.removeChild(child);
        }
    }
}

/**
 * 대상 DS에 조회한 DS의 정보를 담는다.
 * @param - targetDsName 대상 DS 이름
 * @param - baseDsName 기준 DS 이름
 */
function fnc_BindingCommonDataSet(targetDsName, baseDsName) {
	var targetDs 	= document.getElementById(targetDsName);
	var baseDs 		= document.getElementById(baseDsName);
	
    if(targetDs.CountColumn < 1)
        targetDs.setDataHeader("CODE:STRING, CODE_NAME:STRING");
    
    for(var i=1; i<=baseDs.CountRow; i++) {
        targetDs.AddRow();
        
        //targetDs.NameString(dsCOMM_CODE.RowPosition, "CODE")         = baseDs.NameString(i, "CODE");
        //targetDs.NameString(dsCOMM_CODE.RowPosition, "CODE_NAME")    = baseDs.NameString(i, "CODE_NAME");
    }
}
