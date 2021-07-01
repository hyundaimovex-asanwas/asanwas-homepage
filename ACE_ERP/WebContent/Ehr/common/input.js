/*****************************************************
* @source      : input.js
* @description : �Է°��� UTIL�� ����
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/24      ����ȣ                   �����ۼ�
*****************************************************/

//��ȿ�� �˻翡 ����ϴ� �޼���
var Message = "��(��) �Է��ϼ���";

/**
 * �Է�â�� ���¸�(�����)���� ���� ��Ų��.
 * @param oElementList - ���°��� �����ų �׸� ����Ʈ
 * @param oExceptionList - oElementList�߿��� �˻縦 ���� ���� �׸�� 
 */
function fnc_EnableElementAll(oElementList, oExceptionList) {    
	var oElementName = null;           
    for(i=0; i<oElementList.length; i++) {
    	oElementName = oElementList[i];
        //���ܻ����� �˻��Ͽ� ���ܿ� �ش��ϸ� �ٽ� ó������
		if(!isNotException(oElementName, oExceptionList)) {
			continue;
		}    
        fnc_ChangeStateElement(true, oElementName);
    }                         

}

/**
 * �Է�â�� ���¸�(������)���� ���� ��Ų��.
 * @param oElementList - ���°��� �����ų �׸� ����Ʈ
 * @param oExceptionList - oElementList�߿��� �˻縦 ���� ���� �׸�� 
 */
function fnc_DisableElementAll(oElementList, oExceptionList) {   
	
	var oElementName = null;                        
	
    for(i=0; i<oElementList.length; i++) {
    	
    	oElementName = oElementList[i];
        //���ܻ����� �˻��Ͽ� ���ܿ� �ش��ϸ� �ٽ� ó������

		if(!isNotException(oElementName, oExceptionList)) {
			continue;
		}    

        fnc_ChangeStateElement(false, oElementName);
   
    }            
    
}

/**
 * ���� �׸��� ���°��� ���� ��Ų��.
 * @param isEnable - ���� disable ��ų���� ���� ���� boolean
 * @param elementName - �����ų ������Ʈ �̸�
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
    
    //�Է½�ų �� ����
    if(isEnable) {
        bindClassName = "";
        bindStatus = false;
    } else {
        bindClassName = "input_ReadOnly";
        bindStatus = true;
    }
    
    //�Է�â�϶�
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
       	
       	//�� �� �Է�â��
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
   	//�� ��
    else {
        oElement.disabled = bindStatus;
   	}           
    
    
}

/**
 * �Է�â�� ������ ����.
 * @param oElementList - ���� �׸� ����Ʈ
 * @param oExceptionList - oElementList�߿��� �˻縦 ���� ���� �׸�� 
 * @param defaultVal - ������ ��ﶧ DEFAULT�� ���� ����
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
        
	        //���ܻ����� �˻��Ͽ� ���ܿ� �ش��ϸ� �ٽ� ó������
			if(!isNotException(oElementName, oExceptionList)) {
				continue;
			}
        
            oElement = document.getElementById(oElementName);
            
	       	if(oElement == undefined) {
	       		alert("["+oElementName+"] Element �� ã�� �� �����ϴ�.");
	       		return;
	       	}            
            
			//�׸� �� ��������
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
 * ��ȿ�� �˻� ���� �׸����� �ƴ��� üũ
 * @param elementName - �˻��� ������Ʈ �̸�
 * @param oExceptionList - ���� �׸��� ���ǵǾ� �ִ� List
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
 * ��ȿ�� �˻縦 �Ѵ�.
 * @param oElementList - Input, Select Element �̸����� ������ �ִ� List
 * @param oElementMsgList - ���� Msg���� ������ �ִ� List (oElementList�� ũ�Ⱑ ���ƾ� ��)
 * @param oExceptionList - oElementList�߿��� �˻縦 ���� ���� �׸��
 */
function fnc_CheckElement(oElementList, oElementMsgList, oExceptionList) {
	var oElement = null;
	var oElementName = null;
	var oElementValue = null;
	var oElementMsg = null;
	
	for(j=0; j<oElementList.length; j++) {
       	oElementName = oElementList[j];
       
     	//���ܻ����� �˻��Ͽ� ���ܿ� �ش��ϸ� �ٽ� ó������
		if(!isNotException(oElementName, oExceptionList)) {
			continue;
		}
       
       	oElement 		= document.getElementById(oElementName);
       	oElementMsg 	= oElementMsgList[j];      	//�׸� �޼��� ��������
       	
       	if(oElement == undefined) {
       		alert("["+oElementName+"] Element �� ã�� �� �����ϴ�.");
       		return;
       	}
       	
       	//�׸� �� ��������
       	if(oElement.nodeName.toLowerCase() == "object" 
       			&& oElement.classid == "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F") {
			oElementValue 	= oElement.text;
		} else {
			oElementValue 	= oElement.value;
		}
       
       	//���� ������
       	if(oElementValue == null || oElementValue.trim() == "" || oElementValue.trim() == "0") {
           	alert(oElementMsg+Message+oElementValue);
           	oElement.focus();
           	return false;
       	}
   	} 
   	return true;
}

/**
 * ��ȿ�� �˻縦 �Ѵ�.
 * @param oDataSet - GauceDataSet ��ü
 * @param oElementList - Input, Select Element �̸����� ������ �ִ� List
 * @param oElementMsgList - ���� Msg���� ������ �ִ� List (oElementList�� ũ�Ⱑ ���ƾ� ��)
 * @param oExceptionList - oElementList�߿��� �˻縦 ���� ���� �׸��
 */
function fnc_CheckDataSetElement(oDataSet, oElementList, oElementMsgList, oExceptionList) {
	var oElement = null;
	var oElementName = null;
	var type = null;
	var oElementValue = null;
	var oElementMsg = null;
	var saveStatus = null;

	//ds�� ���Ե� row ������ ������
    for(i=1; i<=oDataSet.CountRow; i++){
        //ds �Է� Ÿ���� insert ���� update������ ������
        //1:Insert
        //3:Update
        saveStatus = oDataSet.RowStatus(i);

		//�Է»��°� insert, update �϶� �׿� �׸�� ����
        if(saveStatus == 1 || saveStatus == 3) {
		    for(j=0; j<oElementList.length; j++) {
		        oElementName = oElementList[j];
		        
		        //���ܻ����� �˻��Ͽ� ���ܿ� �ش��ϸ� �ٽ� ó������
				if(!isNotException(oElementName, oExceptionList)) {
					continue;
				}
				
				type = oElementName.substr(0, 3).toLowerCase();
				if(type == "txt" || type == "cmb" || type == "med" || type == "chk") {
					oElement = document.getElementById(oElementName);
			        oElementValue = oDataSet.NameString(i, oElementName.substring(3));    //�׸� �� ��������
			        oElementMsg = oElementMsgList[j];                       //�׸� �޼��� ��������
			        
			        //���� ������
			        if(oElementValue == null || oElementValue.trim() == "" || oElementValue.trim() == "0") {
			            alert(i+" "+oElementMsg+Message+oElementValue);
			            oDataSet.RowPosition = i;
			            oElement.focus();
			            return false;
			        }
				}
		        else {
		        	oElementValue = oDataSet.NameString(i, oElementName);   //�׸� �� ��������
			        oElementMsg = oElementMsgList[j];                       //�׸� �޼��� ��������
			        
			        //���� ������
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
 * input Element, select Element ���� �ʱ�ȭ ��Ŵ
 * @param oExceptionList - �ʱ�ȭ ��Ű�� ���� �ʵ� �̸�
 */
function fnc_ClearInputFieldAll(oExceptionList) {
    //���� �ʱ�ȭ
    fnc_ClearInputField("input", oExceptionList);
    fnc_ClearInputField("select", oExceptionList);
}

/**
 * input Element, select Element ���� �ʱ�ȭ ��Ŵ
 * @param TagName - �ʱ�ȭ ��ų Element Tag �̸�
 * @param oExceptionList - �ʱ�ȭ ��Ű�� ���� �ʵ� �̸�
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

			//���ܻ����� �˻��Ͽ� ���ܿ� �ش��ϸ� �ٽ� ó������
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
 * ���������� �ƴ��� ����
 * @param chkVal - �˻��� ��
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
 * radio Element�� �ش� ���� check �Ѵ�.
 * @param elementName - �ش� Element Name
 * @param checkValue - check �� ��
 */
function fnc_CheckedElement(elementName, checkValue) {
	var oElementList = document.getElementsByName(elementName);
	var oElement = null;
	
	for(var i=0; i<oElementList.length; i++) {
		oElement = oElementList[i];
		
		//�ش� Element�� ���� ���ٸ� checked
		if(oElement.value == checkValue) {
			oElement.checked = true;
		}
	}
}

/**
 * check�� radio Element�� �ش� ���� �����´�.
 * @param elementName - �ش� Element Name 
 */
function fnc_GetCheckedValue(elementName) {
	var oElementList = document.getElementsByName(elementName);
	var oElement = null;
	
	for(var i=0; i<oElementList.length; i++) {
		oElement = oElementList[i];
		
		//���� �Ǿ� �ִٸ� ���õ� �� ��ȯ
		if(oElement.checked) {
			return oElement.value;
		}
	}	
	
	return "";
}

/**
 * �ش�Ǵ� DataSet ��ü ���� Target Object�� ���ε� ��Ŵ
 * @param oDataSet - GauceDataSet ��ü
 * @param elementName - select Object ��ü �̸�
 */
function fnc_BindingCommonCode(oDataSet, elementName) {
	var oSelect = document.getElementById(elementName);
	var oOption = null;
	
	//ù��° ������ ������ ��� option ����
	for(i=oSelect.options.length-1; i>0; i--) {
	    oSelect.remove(i);
	}
	
	// ���� ���� �˻� �޺��ڽ� ����
	for(i = 1; i <= oDataSet.CountRow; i++ ) {
	    oOption       = document.createElement("OPTION");
	    oOption.value = oDataSet.NameValue(i,"CODE");
	    oOption.text  = oDataSet.NameValue(i,"CODE_NAME");
	    oSelect.add(oOption);
	}	
}

/**
 * �ش�Ǵ� DataSet ��ü�� ���ε� ��Ű�� �ʱ�ȭ ��Ų��.
 * (fnc_BindingCommonCode �� ������ - ds�� ��ü�� �����ʰ� �Լ������� ��ȸ �� ���, ù��° ������ �ʱ�ȭ ���� ���)
 * @param - ds �̸�
 * @param - select ��ü �̸�
 * @param - �ʱ�ȭ ��ų ù��° ���� ��
 * @param - �ʱ�ȭ ��ų ù��° ���� �̸�
 */
function fnc_ConstructCommonCode(commonDsName, elementName, constructVal, constructName) {
	var oDataSet= document.getElementById(commonDsName);
	var oSelect = document.getElementById(elementName);
	var oOption = null;
	
	if(constructVal == undefined || constructVal == "") {
		constructVal = "";
	}
	
	if(constructName == undefined || constructName == "") {
		constructName = "��  ��";
	}
	
	//option ����
	for(i=oSelect.options.length-1; i>=0; i--) {
	    oSelect.remove(i);
	}
	
	// ���� ���� �˻� �޺��ڽ� ����
	for(i = 0; i <= oDataSet.CountRow; i++ ) {
	    oOption       = document.createElement("OPTION");
	    //ó���϶� �ʱ�ȭ��Ŵ
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
 * ���� �ڵ��� ������ �̸��� ������ �´�.
 * @param - Common DS �̸�
 * @param - ������ code ��
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
 * �ش� Element�� �����ֱ�
 * @param elementName
 */
function fnc_ShowElement(elementName) {
	var oElement = document.getElementById(elementName);
	oElement.style.visibility = "visible";
	oElement.style.position = "static";
	oElement.style.display = "inline";
}

/**
 * �ش� Element�� �����
 * @param elementName
 */
function fnc_HiddenElement(elementName) {
	var oElement = document.getElementById(elementName);
	oElement.style.visibility = "hidden";
    oElement.style.position = "absolute";
    oElement.style.display = "none";
}

/**
 * �� ���̾� �׸��� ������ ���̾ �����ֱ�
 * @param oLayerNameList - layer name list
 * @param showLayerName - ������ layer name
 */
function fnc_ShowHiddenLayer(oLayerNameList, showLayerName) {
	var layerName = null;
	var oElement = null;
	
	//��� layer hidden
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
	
	//������ layer�� ����
	oElement = document.getElementById(showLayerName);
	oElement.style.visibility = "visible";
	oElement.style.position = "static";
	oElement.style.display = "inline";
}


/**
 * �ش� Element�� Child Node�� ��� ����
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
 * ��� DS�� ��ȸ�� DS�� ������ ��´�.
 * @param - targetDsName ��� DS �̸�
 * @param - baseDsName ���� DS �̸�
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
