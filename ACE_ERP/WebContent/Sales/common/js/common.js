/********************************************************************************/
/* �ý���            : GLW (Global Window)
/* ���α׷� ���̵�   :
/* �ҽ����� �̸�     : common.js
/* ����              : ���� ��ũ��Ʈ
/* ����              : 1.0
/* ���� �ۼ���       : ������
/* ���� �ۼ�����     : 2006-01-17
/* �ֱ� ������       :
/* �ֱ� �����Ͻ�     :
/* ���� ��������     :
/********************************************************************************/


/* =====================================================================================================
   �Լ��� : zc_xxxx()
   ��  �� : Character, Stringó�� (��¥,�ݾ��� ����)
========================================================================================================= */

// �ش� �� ��ü(formObj)�� �Է� �ʵ� ��,
// �ʼ��׸��� null üũ, ���� üũ, �ֹι�ȣ,���ι�ȣ, ����� ��ȣ, �ݾ� ������ ����Ÿ ���ռ��� üũ�ϴ� ���
// ������ üũ�� ��� ���������� �� �ʵ�� �̸��� alert()�� ���� �����ְ� false�� �����ϰ�,
// ��� üũ�� ����ϸ� true�� �����ϸ鼭, "ó�����Դϴ�"�� �����ִ� �˾�â�� ȣ���Ѵ�.


function zcCheckForm(formObj){
	var obj = formObj.all;
	var flag = false;
	var msg = "";
	var focusObj;				// focus�� �־�� �� ������Ʈ
	var alertFlag = false;		// true �̸� alertâ��
	var confirmFlag = false;	// true �̸� confirmâ��

	for(var i = 0 ; i < obj.length ; i++){

		if(obj.item(i).type=="text" || obj.item(i).type=="textarea"){
			zsDelRLSpace(obj.item(i));
		}

		//  -------------�ʼ� �׸� üũ---------------//
		if(obj.item(i).notnull != undefined ){

			if(obj.item(i).type=="radio" || obj.item(i).type=="checkbox"){	//üũ�ڽ��� ���� �ڽ����
				var colObj = document.getElementsByName(obj.item(i).name);
				for(var j = 0 ; j<colObj.length ; j++){	// üũ�ڽ��� ���� �ڽ����� üũ�� ���� �ִ��� �˻�
					if(colObj[j].checked){
						flag = true;
						break;
					}
				}
				if(!flag){	// �ʼ� �׸� ������ �ִٸ� �޽����� �߰�
					setErrorFld(obj.item(i), obj.item(i).msgTitle + " ��(��) �ʼ��Է� �׸��Դϴ�.\r\n");
				}
				flag = false;	// flag �ʱ�ȭ

			}else{	// �׿� input or textarea ���
				if(obj.item(i).value == ""){	// value�� null�̶��
					setErrorFld(obj.item(i), obj.item(i).msgTitle + " ��(��) �ʼ��Է� �׸��Դϴ�.\r\n");
				}
			}
		}

		//  ------------- ���� üũ---------------//
		if(obj.item(i).correctLen != undefined && obj.item(i).value != ""){
			var str = zsRmString(obj.item(i).value, "-");	// "-" ����
			if(str.length != obj.item(i).correctLen){	// �ùٸ� ���̰� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� " +obj.item(i).correctLen+ "���� ����Ÿ�� �Է��ؾ� �մϴ�.\r\n");
			}
		}

		if(obj.item(i).minLen != undefined && obj.item(i).value != ""){
			if(zsGetBytesLength(obj.item(i).value)  < parseInt(obj.item(i).minLen)){
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� " +obj.item(i).minLen+ "�� �̻��� �����͸� �Է��ؾ� �մϴ�.\r\n");
			}
		}
		
		if(obj.item(i).len != undefined &&  obj.item(i).value != ""){
			
			if(obj.item(i).comma != undefined) {
				var str = obj.item(i).value;
				var arrStr = str.split('.');
				if(arrStr.length > 2) {
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� �Ҽ����� �ϳ��� �Է��ؾ� �մϴ�.\r\n");
				}
				
				if(zsGetBytesLength(arrStr[0])  > (parseInt(obj.item(i).len)-parseInt(obj.item(i).comma))) {
					var commalen = (parseInt(obj.item(i).len)-parseInt(obj.item(i).comma));
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� �Ҽ��� �ܿ� " +commalen+ "�� ������ �����͸� �Է��ؾ� �մϴ�.\r\n");
				}
		
				if(arrStr.length == 2) {
					if(zsGetBytesLength(arrStr[1])  > parseInt(obj.item(i).comma)) {
						setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� �Ҽ��� ���� " +obj.item(i).comma+ "�ڸ��� �����͸� �Է��ؾ� �մϴ�.\r\n");
					}
				}
			
			} else {
				if(zsGetBytesLength(obj.item(i).value)  > parseInt(obj.item(i).len)){	// �ùٸ� ���̰� �ƴ϶��
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� " +obj.item(i).len+ "�� (�ѱ� " + parseInt(obj.item(i).len/2) +"��) ������ �����͸� �Է��ؾ� �մϴ�.\r\n");
				}
			}
		}

		// -------------�ݾ����� üũ(����, "-", ".", "," �θ� �̷�������� üũ----------------//
		if(obj.item(i).format =="money" && obj.item(i).value !=""){
			if(!zmIsMoney(obj.item(i))) {		// �ùٸ� �ݾ����°� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� ���ڸ� �Է��ؾ� �մϴ�.\r\n");
			}
		}
		
		// ------------- ���ڸ� üũ (// --------------//
		if(obj.item(i).format =="number" && obj.item(i).value !=""){
			if(!zcIsNum(obj.item(i))) {		// �ùٸ� �������°� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� ���ڸ� �Է��ؾ� �մϴ�.\r\n");
			}
		}

		// -------------�̸������� üũ----------------//
		if(obj.item(i).format =="email" && obj.item(i).value !=""){
			if(!zcIsEmail(obj.item(i))) {		// �ùٸ� �̸������°� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "��(��) �ùٸ��� �ʽ��ϴ�.\r\n");
			}
		}

		// -------------��¥���� üũ----------------//
		if(obj.item(i).format =="date" && obj.item(i).value !=""){
			if(!zdIsDate(obj.item(i).value)) {		// �ùٸ� ��¥���°� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� ��¥�� �Է��ؾ� �մϴ�.\r\n");
			}
		}

		// -------------��¥_������� üũ----------------//
		if(obj.item(i).format =="dateYM" && obj.item(i).value !=""){
			if(!zdIsDateYM(obj.item(i).value)) {		// �ùٸ� ��¥���°� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "���� ��¥�� �Է��ؾ� �մϴ�.\r\n");
			}
		}

		// -------------�ð����� üũ----------------//
		if(obj.item(i).format =="time" && obj.item(i).value !=""){
			if(!zdIsTime(obj.item(i).value)) {		// �ùٸ� �ð����°� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "��(��) �ùٸ��� �ʽ��ϴ�.\r\n");
			}
		}

		// -------------�ֹι�ȣ ���ռ� üũ----------------//
		if(obj.item(i).format =="jumin" && obj.item(i).value !=""){
			if(!zcIsJumin(obj.item(i))) {		// �ùٸ� �ֹι�ȣ�� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "��(��) �ùٸ��� �ʽ��ϴ�.\r\n");
			}
		}

		// -------------���ι�ȣ ���ռ� üũ----------------//
		if(obj.item(i).format =="cono" && obj.item(i).value !=""){
			if(!zcIsBupin(obj.item(i))) {		// �ùٸ� ���ι�ȣ�� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "��(��) �ùٸ��� �ʽ��ϴ�.\r\n");
			}
		}

		// -------------�ֹ�(����)��ȣ ���ռ� üũ----------------//
		if(obj.item(i).format =="perid" && obj.item(i).value !=""){
			if(!zcIsPerid(obj.item(i))) {		// �ùٸ� �ֹ�(����)��ȣ�� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "��(��) �ùٸ��� �ʽ��ϴ�.\r\n");
			}
		}

		// -------------����ڹ�ȣ ���ռ� üũ----------------//
		if(obj.item(i).format =="resno" && obj.item(i).value !=""){
			if(!zcIsResno(obj.item(i))) {		// �ùٸ� ����ڹ�ȣ�� �ƴ϶��
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "��(��) �ùٸ��� �ʽ��ϴ�.\r\n");
			}
		}

		
		// attach file check...		
		/*
		if(obj.item(i).type == "file") {
			var fileExt = '';
			var realfilename = obj.item(i).value;
			if(realfilename.length > 4 && realfilename.indexOf('.')>0) {
				fileExt = realfilename.substring(realfilename.lastIndexOf('.'));
				if( fileExt=='.asp' || fileExt=='.jsp' || fileExt=='.php'
					|| fileExt=='.html' || fileExt=='.bak' || fileExt=='.inc'
					|| fileExt=='.exe' || fileExt=='.bat' || fileExt=='.com'
					|| fileExt=='.htm' || fileExt=='.bsp' ) {
					//setErrorFld(obj.item(i), "asp, jsp, php, html, bak, inc, exe, bat, com, htm, bsp ������ ���ε��� �� �����ϴ�.\r\n");
					setErrorFld(obj.item(i), alertMsg[13] + "\r\n");
					
				}
			}
		}
		*/

	}

	if (alertFlag) {	// alertâ�� ���� ������,
		alert(msg);

		if ( focusObj.disabled == false )	focusObj.focus();
		return false;
	/*
	} else if (confirmFlag) {	// confirmâ�� ���� ������,
		msg += "ó���Ͻðڽ��ϱ� ?";
		if ( confirm(msg) ) return true;

		if ( focusObj.disabled == false )	focusObj.focus();
		return false;
	*/
	}else	// ��� üũ�� ����ߴٸ�
		return true;

	//	��Ŀ���� �� ������Ʈ ����, alert �޽��� �ؽ�Ʈ �߰�
	function setErrorFld(obj, str){
		var is_show = 'Y';
		try {
			obj.focus();
		} catch(ee) {
			is_show = 'N';
		}
		
		if(is_show == 'Y') {
			alertFlag = true;
			if(focusObj == undefined)		focusObj = obj;		//focusObj ����
			msg += str;		//�޽��� ����
		}
	}
}

// input �ʵ� ��ü(obj)�� ���� ������ ������("A"-"Z", or "a"-"z") ���� üũ
// �����̶�� true, �ƴ϶�� false�� ����
function zcIsAlphaOnly(obj) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
  	for (var i = 0; i < str.length; i++) {
		if (!(  ((str.charAt(i) >= 'a') && (str.charAt(i) <= 'z')) ||	((str.charAt(i) >= 'A') && (str.charAt(i) <= 'Z')) ) ){
         	isValid = false;
			break;
     	}
   }
	return isValid;
}

//  input �ʵ� ��ü(obj)�� ���� ������("A"-"Z", or "a"-"z") �Ǵ� ���� �̸� true
function zcIsAlphaNum( obj ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
   	for (var i = 0; i < str.length; i++)
   	{
      	if (!(((str.charAt(i) >= "0") && (str.charAt(i) <= "9")) ||
      			((str.charAt(i) >= "a") && (str.charAt(i) <= "z")) ||
      			((str.charAt(i) >= "A") && (str.charAt(i) <= "Z"))))
			{
				isValid = false;
				break;
			}
   	}
   	return isValid;
}


//  input �ʵ� ��ü(obj)�� ���� ����(0~9)�� �Է��Ͽ����� Ȯ��
function zcIsNum(obj) {
	var str = obj.value;
	return zcIsNumStr(obj.value);
}

//	���ڿ�(str)�� (0-9)������ �̷�������� üũ
function zcIsNumStr(str) {
	if(zcIsNull(str)) return false;

	var temp = "";
	var n = String(str);
	var len = n.length;
	var pos = 0;
  	var ch = '';

	while (pos < len) {
		ch = n.charAt(pos);
		if ((ch >= '0') && (ch <= '9')) {
			temp = temp + ch;
		}else{
			return false;
		}
		pos = pos + 1;
	}
	return true;
}

function zcNotKorean(obj) {
    var deny_pattern = /[^(��-�R)]/;

	if(!deny_pattern.test(obj.value)) {
		//alert(alertMsg[15]);
		obj.focus();
		obj.select();
		return false;
	}

	return true;
}

//  input �ʵ� ��ü(obj)�� ���� ����(0~9)�� �Է��Ͽ����� Ȯ�� +  ���ڰ� �ִٸ� obj �� �ʱ�ȭ
function zcIsNumAndInit(obj) {
	var str = obj.value;

	if(zcIsNumStr(str))
		return true;
	else{
		obj.value="";
		//obj.focus();
		return false;
	}
}

//  input �ʵ��� ���� ����(0~9)�� �Է��Ͽ����� Ȯ�� +  ���ڰ� �ִٸ� obj �� �ʱ�ȭ
function zcIsStrNumAndInit(str) {
	//var str = obj.value;

	if(zcIsNumStr(str))
		return true;
	else{
		obj.value="";
		return false;
	}
}

//  input �ʵ� ��ü(obj)�� ���� ����(0~9), �Ҽ���('.') �̸� true
function zcIsNumDot(obj) {
    var deny_pattern = /[^0-9"."]/;
	var paramValue = obj.value;

	if ( paramValue.substr(0,1) == "-" ) paramValue = paramValue.substr(1,paramValue.length);

	if(deny_pattern.test(paramValue)) {
		//alert(alertMsg[ 8]); // ���ڸ� �Է��ؾ� �մϴ�.
		alert('���ڸ� �Է��ؾ� �մϴ�');
		obj.focus();
		obj.select();
		return false;
	}

	return true;
}

//  input �ʵ� ��ü(obj)�� ���� ����(0~9), ���̳ʽ�('-'), �Ҽ���('.') �̸� true
function zcIsNumMinusDot( obj ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
	var decCount = 0;		// number of decimal points in the string
	//str += "";

	for (var i = 0; i < str.length; i++) {
		// track number of decimal points
		if (str.charAt(i) == ".")
			decCount++;

	    	if (!((str.charAt(i) >= "0") && (str.charAt(i) <= "9") ||
		      (str.charAt(i) == "-") || (str.charAt(i) == "."))) {
	      	 	isValid = false;
	      	 	break;
		} else if ((str.charAt(i) == "-" && i != 0) ||
			   (str.charAt(i) == "." && str.length == 1) ||
			   (str.charAt(i) == "." && decCount > 1)) {
	       		isValid = false;
	      	 	break;
	        }
   	}
   	return isValid;
}
//  input �ʵ� ��ü(obj)�� ���� ����(0~9), ���̳ʽ�('-'), �Ҽ���(':') �̸� true
function zcIsNumMinusDouble( obj ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
	var decCount = 0;		// number of decimal points in the string
	//str += "";

	for (var i = 0; i < str.length; i++) {
		// track number of decimal points

	    	if (!((str.charAt(i) >= "0") && (str.charAt(i) <= "9") ||
		      (str.charAt(i) == "-") || (str.charAt(i) == ":"))) {
	      	 	isValid = false;
	      	 	break;
		}
   	}
   	return isValid;
}
//  input �ʵ� ��ü(obj)�� ���� ����(0~9)�� �̷�����ٸ� true, allowNegatives�� true�ϰ�� ����(-���Ե� ����)�� true
function zcIsNumMinus( obj, allowNegatives ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
	//str += "";

	if (allowNegatives+"" == "undefined" || allowNegatives+"" == "null")
		allowNegatives = true;

	for (var i = 0; i < str.length; i++) {
	    	if (!((str.charAt(i) >= "0") && (str.charAt(i) <= "9") || (str.charAt(i) == "-"))) {
	       		isValid = false;
	       		break;
		} else if ((str.charAt(i) == "-" && i != 0) ||
					(str.charAt(i) == "-" && !allowNegatives)) {
	       		isValid = false;
	       		break;
	        }
   	}
   	return isValid;
}

//  input �ʵ� ��ü(obj)�� ���� �ùٸ� email�����̸� true
function zcIsEmail( obj ) {
    var deny_pattern = /[^(--a-zA-Z0-9"@.")]/;
    if (deny_pattern.test(obj.value)) return false;

	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//�����̶��

	var isValid = true;
	str += "";

	namestr = str.substring(0, str.indexOf("@"));  // everything before the '@'
	domainstr = str.substring(str.indexOf("@")+1, str.length); // everything after the '@'

	// Rules : @�տ� ���ڰ� �־�� �ϸ�, �����κκп� �ݵ�� "." �� �־�� �ϸ�,
	//				@�� . �� �����ؼ� �� �� ����, ������ ���ڴ� �ݵ�� �����̾�� �Ѵ�.
   	if (zcIsBlank(obj) || (namestr.length == 0) ||
			(domainstr.indexOf(".") <= 0) ||
			(domainstr.indexOf("@") != -1) ||
			!(	(str.charAt(str.length-1) >= 'a' && str.charAt(str.length-1) <= 'z') || (str.charAt(str.length-1) >= 'A' && str.charAt(str.length-1) <= 'Z')	)
	){
			isValid = false;
	}
   	return isValid;
}

//  input �ʵ� ��ü(obj)�� ���� blank�̸� true
function zcIsBlank( obj ) {
	var str = obj.value;
	return zcIsNull(str);
}


// str�� null, undefined, NaN, ����("") �̸� true
function zcIsNull(str) {
 	if (str+"" == "undefined" || str+"" == "NaN" || str+"" == "null" || str+"" == "")
 		return true;
	return false;
}

//  input �ʵ� ��ü(obj)�� ���� �ùٸ� �ֹι�ȣ���� üũ(123456-1234567 ����, 1234561234567 ��� üũ ����)
function zcIsJumin( obj ) {
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//�����̶��

	str = zsRmString(str, "-");	// "-" ����
	var  j=9
	var  id_chk=0

	object =  new Array(13)
	for(var i=0;i < 13;i++) {
		object[i] = str.substring(i,i+1)
	}
	var chkdigit = str.substring(12, 13)
	for(var i=0;i < 12;i++){
	    if( i == 8 )
	    j = 9
	    object[i]=object[i]*j
	    j--
	    id_chk +=object[i]
	}
    if(((id_chk%11 == 0) && (chkdigit == 1)) || ((id_chk%11 ==10)&& (chkdigit ==0))){
         return true;
    }
    else if((id_chk %11 != 0) && (id_chk % 11 != 10 ) && (id_chk % 11 == chkdigit)){
         return true;
    }
    else{
         return false;
    }
}

//  input �ʵ� ��ü(obj)�� ���� �ùٸ� ���ι�ȣ����üũ
function zcIsBupin(obj) {
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//�����̶��

	str = zsRmString(str, "-");	// "-" ����

	var check = 1;
	var no = new Array(13);
	var sum = 0;
	var rem = 0;
	var m = 0;

	m = parseInt(str.charAt(12),10); // ��ȣ�� ������ ���� ���

	for(var i=0; i<12; i++) no[i] = parseInt(str.charAt(i),10); // 1~12���� ���� ���

	for(var i=0; i<12; i++) {
		sum += (check * no[i]);
		check = (check==1) ? 2 : 1;
	}

	rem = sum % 10; // ������ ���ϱ�
	rem = 10 - rem;
	rem = (rem >= 10) ? rem - 10 : rem;

	// ��������°�� 10-rem�� ���� ��
	if(m == rem) return true; // ��Ȯ
	else return false; // ����Ȯ
}

//  input �ʵ� ��ü(obj)�� ���� �ùٸ� �ֹ�(����)��ȣ���� üũ(123456-1234567 ����, 1234561234567 ��� üũ ����)
function zcIsPerid( obj ) {
	if(zcIsJumin(obj) || zcIsBupin(obj))	return true;
    	else  return false;
}

// input �ʵ� ��ü(obj)�� ���� �ùٸ� ����ڵ�Ϲ�ȣ���� üũ
function zcIsResno(obj){
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//�����̶��

	str = zsRmString(str, "-");	// "-" ����

	var check = 0;
	var no = new Array(10);
	var sum = 0;
	var tmpNo = 0;
	var tmpStr = 0;

	for(var i=0; i<10; i++) no[i] = parseInt(str.charAt(i),10); // 1~10���� ���� ���

	for(var i=0; i<10; i++) {
		if((i%3)==0)
			tmpNo = no[i] + 0;
		else if ( (i%3) == 1)
			tmpNo = no[i] * 3;
		else if ( (i%3) == 2)
			tmpNo = no[i] * 7;

		if(i==8)
		{
			tmpNo = no[i] * 5;
			if(tmpNo > 9) {
				tmpStr = tmpNo + "";
				tmpNo = parseInt(tmpStr.charAt(0),10) + parseInt(tmpStr.charAt(1),10);
			}
		}
		sum += tmpNo;
	}
	if( (sum % 10) == 0) return true; // ��Ȯ
	else return false; // ����Ȯ
}

// input �ʵ� ��ü(obj)�� ���� �־��� ����(lengthInt)�� ������ üũ
function zcIsCorrectLen(obj, lengthInt){
	var str = obj.value;
	if(zcIsNull(str)) return false;	//�����̶��

	if( str.length == lengthInt)		// ���ڿ��� ���̿� lengthInt �� ���ٸ�
		return true;
	else return false;
}

// �ּ� ÷���ڷ� �Ѱ� �̻� �����ϰ� �ϱ� ���� ���� ���� ���� üũ
/*
function zcExistFile() {

	if(frmWrite.file1.value=="" && frmWrite.file2.value==""  && frmWrite.file3.value=="" ){
		alert(" ÷�� �ڷḦ ������ �ּ���(�ּ��Ѱ��̻�)");
		return;
	}

	frmWrite.action = "/ComnWeb/jsp/util/SaveFile.jsp";
	frmWrite.submit();
}
*/

// String�� �޾Ƽ� 0~9 ������ ���ڸ� �������ش�.
function zcReturnTelNo(str) {
	var retStr = "";

 	if (str+"" == "undefined" || str+"" == "NaN" || str+"" == "null" || str+"" == "") return retStr;

	for (var i = 0; i < str.length; i++) {
		if ( (str.charAt(i) >= '0') && (str.charAt(i) <= '9') ) {
			retStr = retStr + str.charAt(i);
		}
	}
	return retStr;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//		�������������� ����� ���� �ִ��� üũ
//			�Լ��� : zcIsChanged() ���� onload �� zcInitData() �Լ��� ȣ��ǰ� var oData = new Array() ; �� ���������� ����Ǿ���
//			��  �� : Form ������ ��������� üũ�Ͽ� submit�� alert�� scriptFormTest.html ���� Ȯ��
///////////////////////////////////////////////////////////////////////////////////////////////////////////
var oData = new Array() ; //���� form �� set �Ǵ� ����Ÿ�� ���� array

//��(diffForm�� ������ �ʵ�)�� ����Ÿ�� �о array�� �����Ѵ�.
/*
function zcInitData(){
	for (i=0;i <document.diffForm.length;i++)
	{

		if(document.diffForm.elements[i].type=='button' || document.diffForm.elements[i].type=='submit'){
		}
		else if (document.diffForm.elements[i].type == 'checkbox'||document.diffForm.elements[i].type == 'radio') {
		    if (document.diffForm.elements[i].checked)
		    oData = oData.concat(document.diffForm.elements[i].value);
		}
		else if (document.diffForm.elements[i].type == 'select-one') {
		    if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				//�Է��ʵ带 String�� ������
				oData = oData.concat(document.diffForm.elements[i].value);
			}
		}
		else if (document.diffForm.elements[i].type == 'textarea') {
		    if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				oData = oData.concat(document.diffForm.elements[i].value);
			}
		}
		else {
			if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				//�Է��ʵ带 String�� ������
				oData = oData.concat(document.diffForm.elements[i].value);
			}
		}
	}
}
*/

/*
//���� �Էµ� ���� submit �� ����� ���� ���Ͽ� ����� �����Ѵ�.
function zcIsChanged(){
var chFlag = false;
var textVal = new Array() ;

	for (i=0;i <document.diffForm.length;i++)
	{

		if(document.diffForm.elements[i].type=='button' || document.diffForm.elements[i].type=='submit'){
		}
		else if (document.diffForm.elements[i].type == 'checkbox'||document.diffForm.elements[i].type == 'radio') {
		    if (document.diffForm.elements[i].checked)
		    textVal = textVal.concat(document.diffForm.elements[i].value);
		}
		else if (document.diffForm.elements[i].type == 'select-one') {
		    if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				//�Է��ʵ带 String�� ������
				textVal = textVal.concat(document.diffForm.elements[i].value);
			}
		}
		else if (document.diffForm.elements[i].type == 'textarea') {
		    if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				textVal = textVal.concat(document.diffForm.elements[i].value);
			}
		}
		else {
			if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				//�Է��ʵ带 String�� ������
				textVal = textVal.concat(document.diffForm.elements[i].value);
			}
		}
	}

	for (j=0;j <textVal.length;j++)
	{
		if (textVal[j] == oData[j])
		{
		}
		else
		{
		chFlag = true
		}
	}
	if (chFlag)
		alert("����� �ʵ尡 �ֽ��ϴ�. ����������\n �����Ͻðڽ��ϱ�?");//submit(); ���� ��ġ!
	else
		alert("����� ������ �����ϴ�.");
}
*/

// DDD ��ȣ�� �־ �´� ��ȣ���� üũ�Ѵ�.
// ddd : DDD��ȣ
// gubun : 'tel'�Ϲ���ȭ, 'mobile'�޴���ȭ
/*
function zcIsDDD(ddd, gubun) {
	if ( gubun == 'tel') {
		if ( ddd=="02"  || ddd=="031"  || ddd=="032" || ddd=="033" || ddd=="041" || ddd=="042" || ddd=="043" || ddd=="051" || ddd=="052" || ddd=="053"  || ddd=="054" || ddd=="055" || ddd=="061" || ddd=="062" || ddd=="063" || ddd=="064" || ddd=="060" || ddd=="080" )
			return true;
		else return false;
	} else if ( gubun == 'mobile') {
		if ( ddd=="010" || ddd=="011"  || ddd=="012" || ddd=="015" || ddd=="016" || ddd=="017" || ddd=="018" || ddd=="019" ) return true;
		else return false;
	} else if ( gubun == 'total') {
		if ( ddd=="02"  || ddd=="031"  || ddd=="032" || ddd=="033" || ddd=="041" || ddd=="042" || ddd=="043" || ddd=="051" || ddd=="052" || ddd=="053"  || ddd=="054" || ddd=="055" || ddd=="061" || ddd=="062" || ddd=="063" || ddd=="064" || ddd=="060" || ddd=="080" ||
		     ddd=="010" || ddd=="011"  || ddd=="012" || ddd=="015" || ddd=="016" || ddd=="017" || ddd=="018" || ddd=="019" )
			return true;
		else return false;
	} else {
		return false;
	}
}
*/



/* =====================================================================================================
   �Լ��� : zd_xxxx()
   ��  �� : ��¥���� ó��
========================================================================================================= */

// format�� ���·� Ŭ���̾�Ʈ pc�� ���� ���ڸ� �����Ѵ�.
// format:  'ymd'(yyyymmdd), 'ymd_f'(yyyy-mm-dd), 'ymdhms'(yyyymmddhhmmss), 'ymdhms_f'(yyyy-mm-dd hh:mm:ss)
function zdGetToday(format) {
	var dNow = new Date();
	var yyyy = "";
	var MM   = "";
	var dd   = "";
	var hh = "";
	var mm   = "";
	var sss   = "";

	yyyy = dNow.getYear();
	MM   = dNow.getMonth()+1;
	dd   = dNow.getDate();
	hh   = dNow.getHours();
	mm   = dNow.getMinutes();
	sss  = dNow.getSeconds();

	yyyy = zdSetZero( yyyy, 4 );
	MM   = zdSetZero( MM,   2 );
	dd   = zdSetZero( dd,   2 );
	hh   = zdSetZero( hh,   2 );
	mm   = zdSetZero( mm,   2 );
	sss  = zdSetZero( sss,  2 );

	if (format == "ymd")
		return (yyyy + MM + dd);
	else if (format == "ymd_f")
		return (yyyy + "-" + MM + "-" + dd);
	else if (format == "ymdhms")
		return (yyyy + MM + dd + hh + mm + sss);
	else if (format == "ymdhms_f")
		return (yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + sss);
}

// ���ڿ�(str)�� ��¥���Ŀ� ���� '-' �����Ͽ� ����
function zdSetDateDashStr(str) {
	//alert(zdIsDate(str));
	if(!zdIsDate(str)){		//�ùٸ� ���°� �ƴ϶��
		return false;
	}
	str = str.substr(0,4)+"-"+str.substr(4,2)+"-"+str.substr(6,2);
	return str;
}

// input �ʵ�(obj)�� ���� ��¥���Ŀ� ����  4��-2��-2�� ���·� �߰��� dash ����(20030101 -> 2003-01-01)
function zdSetDateDash(obj){
	var str = obj.value;
	if(zcIsNull(str)) return;	//�����̶��
	obj.value = zdSetDateDashStr(str);
}

// ���ڿ��� �⵵���� �̸� true
function zdIsYear(str){
	if(zcIsNull(str)) return false;	//�����̶��
	var isValid=false;

	if(zcIsNumStr(str)){
		if(str.length==4 && (str.charAt(0)==1 || str.charAt(0)==2) && (str.charAt(1)==0 || str.charAt(1)==1 ||str.charAt(1)==9)){
			if(str>1000) isValid = true;
			}
	}
	return isValid;
}

//19000909����, 1900-09-09������ ��¥(str)��  �ùٸ� ��¥���� üũ
function zdIsDate(str) {
	if(zcIsNull(str)) return false;	//�����̶��

	var valid = true;
	var msg="";
	str =  zsRmString(str, "-");
	var birth = str;
	var yyyy = birth.substring(0,4);
	var mm = birth.substring(4,6);
	var dd = birth.substring(6,8);

	if ( birth.length != 8 || !zcIsNumStr(birth) ) {
		//alert("�ùٸ� ���������� �ƴմϴ�.\n��) 20040101");
		return false;
	}

	if (!(yyyy.substring(0,2)=="19" || yyyy.substring(0,2)=="20" || yyyy.substring(0,4)=="9999")) {
		//msg+="�� �Է¿���!\n";
		valid= false;
	}

	if (mm > 12 || mm < 1) {
		//msg+="�� �Է¿���! (1~12)\n";
		valid =  false;
	}

	var chkdt = new Date( yyyy, mm-1, dd );
	if( chkdt.getYear() > 1900 && (chkdt.getYear() != yyyy || chkdt.getMonth() != (mm-1) || chkdt.getDate() != dd) ){
		//alert( msg+"��¥�� �Է��� �߸��Ǿ����ϴ�.");
		return false;
	}
	else if( chkdt.getYear() < 1900 && ( chkdt.getYear() != yyyy.substring(2) || chkdt.getMonth() != (mm-1) || chkdt.getDate() != dd )){
		//alert( msg+"��¥�� �Է��� �߸��Ǿ����ϴ�.");
		return false;
	}
	return true;
}


//190009����, 1900-09������ ��¥(str)��  �ùٸ� ������� üũ
function zdIsDateYM(str) {
	if(zcIsNull(str)) return false;	//�����̶��

	var valid = true;
	var msg="";
	var birth = zsRmString(str, "-");
	var yyyy = birth.substring(0,4);
	var mm = birth.substring(4,6);

	if ((zcIsNull(birth) || birth.length != 6) || !zcIsNumStr(birth)) {
		//alert("�ùٸ� ��������� �ƴմϴ�.\n��) 200401");
		return false;
	}

	if (!(yyyy.substring(0,2)=="19" || yyyy.substring(0,2)=="20")) {
		msg+="�� �Է¿���!\n";
		valid= false;
	}

	if (mm > 12 || mm < 1) {
		msg+="�� �Է¿���! (1~12)\n";
		valid =  false;
	}

	if (valid==false) alert(msg);

	return valid;
}

//235959����, 23.59.59������ �ð�(str)��  �ùٸ� �ð����� üũ
function zdIsTime(str) {
	if(zcIsNull(str)) return false;	//�����̶��

	var valid = true;
	var msg="";
	str =  zsRmString(str, ".");
	var time = str;
	var hour 	= time.substring(0,2);
	var minute 	= time.substring(2,4);
	var second 	= time.substring(4,6);

	if ((zcIsNull(time) || time.length != 6) || !zcIsNumStr(time)) {
		alert("�ùٸ� �ð������� �ƴմϴ�.\n��) 235959");
		return false;
	}

	if (hour > 23 || hour < 0) {
		msg+="��(Hour) �Է¿���! (00~23)\n";
		valid= false;
	}

	if (minute > 59 || minute < 0) {
		msg+="��(Minute) �Է¿���! (00~59)\n";
		valid =  false;
	}

	if (second > 59 || second < 0) {
		msg+="��(Second) �Է¿���! (00~59)\n";
		valid =  false;
	}

	if (valid==false) alert(msg);

	return valid;
}

// ���ڿ�(str) �������� üũ
function zdIsLeafYear(str) {
	if(zcIsNull(str)) return false;	//�����̶��
	var YYYY = parseInt(str,10);
	//alert(YYYY);
	if ( ( (YYYY%4 == 0) && (YYYY%100 != 0) ) || (YYYY%400 == 0) ) {
		return true;
	}
	return false;
}





//	Date��ü��  yyyy-mm-dd  hh:mm:ss �� ���ڿ��� �����Ѵ�.
// paramDateTime�� Ÿ���� Date(���尴ü)�̴�.
function zdGetDateTime(paramDateTime)
{
	var myDate = paramDateTime;
	var yy, mm, dd; // ��¥
	var ho, mi, se; // �ð�

	yy=(myDate.getYear()<100) ? "19" + myDate.getYear() : myDate.getYear();
	mm = myDate.getMonth() + 1 ;
	mm = (mm < 10) ? "0" + mm : mm;
	dd = myDate.getDate();
	dd = (dd < 10) ? "0" + dd : dd;

	ho = myDate.getHours();
	mi = myDate.getMinutes();
	se = myDate.getSeconds();

	return (yy + "-" + mm + "-" + dd + " " + zdSetZero(ho,2) + ":" + zdSetZero(mi,2) + ":" + zdSetZero(se,2));
}

 /*---------------------------------------------------------------------------
    �Է��ʵ忡 �Է��ϸ鼭 ��¥ ���� ����� �ֱ�
    ----------------------------------------------------------------------------*/
    function fn_date_format(obj, flag) {
        if (obj.value == null || obj.value == "" ) return;
        ls_val = (obj.value).substring((obj.value).length-1, (obj.value).length);
        //alert("before");
        zcIsNumAndInit(obj);
        str = zsRmObj(obj, '-');
        if (zcIsStrNumAndInit(str) == false) {
            obj.value = (obj.value).substring(0, (obj.value).length-1);
            obj.focus();
            return;    
        }
        ls_num = zsRmObj(obj, '-')
        //alert(ls_num);
        if (ls_num.length > 8) {
            obj.value = (obj.value).substring(0, (obj.value).length-1);
            obj.focus();
            return;    
        }
        if (ls_num.length == 8) {
            if (zdIsDate(ls_num) == false)    {
                obj.value = "";
                obj.focus();
                return;
            }
        }
        if (ls_num.length > 6) {
            obj.value = ls_num.substring(0,4) +flag+ls_num.substring(4,6)+flag+ls_num.substring(6,ls_num.length);
        }
        else if (ls_num.length > 4) {
            obj.value = ls_num.substring(0,4) +flag+ls_num.substring(4,ls_num.length);
        }
    }





// ���ڿ� sVal�� iLen���̰� �ɶ����� sVal�� �տ� "0"�� ���� ���ڿ��� �����Ѵ�. ���ü��ȣ��� �ڸ��� ��ŭ 0�� �ٿ��� ��ȯ, ��¥ ���ڿ��� ���� �Ͽ� ����( 01�� 02��)
// sVal - ���ڿ�
// iLen - ����(integer)
// ��) sVal�� '23'�� iLen�� 5�� �ָ� ���ϰ��� '00023' �̴�.
function zdSetZero(sVal, iLen){
	var sStr = "";
	if (typeof sVal=="object") {
		sStr = sVal.value;
		sStr = zsDelRLSpace(sStr);
	} else	sStr = String(sVal);

	if(zcIsNull(sStr)) return;	//�����̶��

	for (ii = sStr.length; ii < iLen; ii++) {
		sStr =  "0" + sStr;
	}
	return sStr;
}

// �� ��¥�� ���̸� ��(��)���� �����Ѵ�.
// basicDayStr���� compareDayStr�� �� ��¥�� ����
// ��¥ ������ "YYYY-MM-DD" �Ǵ� "YYYYMMDD"�̴�.
function zdGetDifTodayInputday(basicDayStr, compareDayStr) {
	basicDayStr = zsRmString(basicDayStr, '-');		// '-'�� �ִٸ� ����
	compareDayStr = zsRmString(compareDayStr, '-');
	if(!zdIsDate(basicDayStr) ||!zdIsDate(compareDayStr)) return false;		//��¥ ������ �ƴ϶��

	var date1  = new Date(basicDayStr.substring(0,4), basicDayStr.substring(4,6)-1, basicDayStr.substring(6,8) );
	var date2  = new Date(compareDayStr.substring(0,4), compareDayStr.substring(4,6)-1,compareDayStr.substring(6,8));

	return Math.floor(( date1 - date2 )*(1/(1000*60*60*24)));
}

// toDate�� fromDate���� ũ��(�ֱ�����) true ����
function zdIsBig(toDate, fromDate) {
	toDate = zsRmString(toDate, '-');		// '-'�� �ִٸ� ����
	fromDate = zsRmString(fromDate, '-');
	if(!zdIsDate(toDate) ||!zdIsDate(fromDate)) return false;		//��¥ ������ �ƴ϶��
	var fromYear = fromDate.substring(0,4);
	var fromMonth = fromDate.substring(4,6);
	var fromDay = fromDate.substring(6,8);
	var toYear = toDate.substring(0,4);
	var toMonth = toDate.substring(4,6);
	var toDay = toDate.substring(6,8);

	if (toYear > fromYear) return true
	else if (toYear < fromYear) return false

	if (toMonth > fromMonth) return true
	else if (toMonth < fromMonth) return false

	if (toDay > fromDay) return true

	return false
}

//������  - ���� ���� ���̸� �� �� �� �Ѱ��ش�.
/*
function zdDaysBetweenTwoDate(obj){

   	var yr,mo,ayr,amo, ry,rm,r1,r2,r3;            //������ �����մϴ�.


   	yr = obj.syear.value;
   	mo = obj.smonth.value;

   	ayr = obj.ayear.value;
   	amo = obj.amonth.value;
	if (isNaN(yr) || isNaN(mo) || isNaN(ayr) || isNaN(amo)) {
		window.alert("���ڸ� �Է� �ϼ���");
		return;
	}

	if (zcIsNull(yr) || zcIsNull(mo) || zcIsNull(ayr) || zcIsNull(amo) ) {
		window.alert("��¥�� �Է��ϼ���");
		return;
	}

	if (mo<1 || mo>12) {
		window.alert("��ȿ�� ��¥�� �ƴմϴ�");
		return ;
	}
	if (amo<1 || amo>12) {
		window.alert("��ȿ�� ��¥�� �ƴմϴ�");
		return ;
	}

   	r1 = parseInt((ayr - yr),10) ;
   	r2 = parseInt((amo - mo),10) ;
   	r3 = (r1 * 12) + r2

    if (r3 > 11) {
        ry = parseInt((r3/12),10);
        rm = r3%12 ;
    }
    else if (-12<r3< 0 ) {
		ry = 0;
		rm = r3%12 ;
    }
    else if (-12>r3 ) {
		ry = parseInt((r3/12),10);
        rm = r3%12 ;
    }
    else {
    		ry = 0;
		rm = r3 ;
    }
    alert (ry+"��  "+rm+"���� ����");
   	//return(r);	                       //���̸� ��ȯ�մϴ�.
}
*/


/*
//  ���س���� ���� ��� ��� ���� ��¥ ���� ��ȯ�Ѵ�.
function zdGetChangeMonth(obj) {

	var yr,mo,dy,ayr,amo ;

   	yr = obj.bdate.value;
   	mo = obj.bdate1.value;
   	dy = obj.bdate2.value;

   	ayr = obj.bdate3.value;
   	amo = obj.bdate4.value;


    mo = zuToLen2(mo);
    dy = zuToLen2(dy);
    amo = zuToLen2(amo);

    if(amo < 0 || amo > 11) {
    	alert ('1 ~ 11 �� ������ �Է��ϼ���');
    	return;
    }

   	fday = yr;
   	fday += mo;
   	fday += dy;
   	if (!zdIsDate(fday)){
   	   	return ;
	}

   	add = parseInt((ayr * 12),10) + parseInt(amo,10) ;

    var _dateObj = yr +""+mo+""+dy;

    var date_length =  _dateObj.length;

        dateYear  = _dateObj.substring(0, 4);
        dateMonth = parseInt( _dateObj.substring(4, 6) ,10);
        dateDay = _dateObj.substring(6, 8);

       var _dateYear  = dateYear
       var _dateMonth = dateMonth
       var _dateDay   = dateDay

    var add_month_time = 0;

    add_month_time += (zdGetEndOfMonthDay(_dateYear,_dateMonth)-_dateDay)*24*60*60*1000;

    for(var i=1; i < add;i++)
    {
        //alert(getEndOfMonthDay(_dateYear,_dateMonth))
        _dateMonth++;
        if(_dateMonth==13)
        {
          _dateYear ++;
          _dateMonth = 1;
        }
        add_month_time += zdGetEndOfMonthDay(_dateYear,_dateMonth)*24*60*60*1000;
    }

    add_month_time +=_dateDay*24*60*60*1000;


    var addDate = new Date(dateYear,dateMonth-1,dateDay);
    //alert(addDate);

    var newtimems=addDate.getTime()+add_month_time;
    addDate.setTime(newtimems);


    var newYear = addDate.getYear();
    if (newYear < 2000) newYear += 1900; // Y2K fix
    var newMonth = addDate.getMonth()+1;
    var newDay = addDate.getDate();

    alert( newYear.toString()+zuToLen2 (newMonth.toString())+ zuToLen2( newDay.toString()));
}
*/

//��� �Է½� ������ ����
function  zdGetEndOfMonthDay(  yy,  mm )
{

    var max_days=0;

    if (mm == 1)        max_days = 31 ;
    else if (mm == 2) {

        if ((( yy % 4 == 0) && (yy % 100 != 0)) || (yy % 400 == 0))
                        max_days = 29;
        else
                        max_days = 28;
    }
    else if (mm == 3)   max_days = 31;
    else if (mm == 4)   max_days = 30;
    else if (mm == 5)   max_days = 31;
    else if (mm == 6)   max_days = 30;
    else if (mm == 7)   max_days = 31;
    else if (mm == 8)   max_days = 31;
    else if (mm == 9)   max_days = 30;
    else if (mm == 10)  max_days = 31;
    else if (mm == 11)  max_days = 30;
    else if (mm == 12)  max_days = 31;
    else {

        return '';
    }
        return max_days;
}



/* =====================================================================================================
   �Լ��� : zm_xxxx()
   ��  �� : �ݾ� ó��
========================================================================================================= */

//  input �ʵ� ��ü(obj)�� ���� �ݾ�����(����(0~9), ���̳ʽ�('-'), �Ҽ���('.'), �޸�(',') )�̸� true
function zmIsMoney( obj ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
	var decCount = 0;		// number of decimal points in the string

	for (var i = 0; i < str.length; i++) {
		// track number of decimal points
		if (str.charAt(i) == ".") decCount++;

    	if ( !((str.charAt(i) >= "0" && str.charAt(i) <= "9") || str.charAt(i) == "-" || str.charAt(i) == "." || str.charAt(i) ==",")  ) {
      	 	isValid = false;
      	 	break;
		} else if ((str.charAt(i) == "-" && i != 0) ||
			   (str.charAt(i) == "." && str.length == 1) ||
			   (str.charAt(i) == "." && decCount > 1)) {
	       		isValid = false;
	      	 	break;
	    }
   	}
   	return isValid;
}

// input �ʵ� ��ü(obj)�� �ݾ� �Է½�, �ǽð����� 3�ڸ� ���� ,�� ����
// onkeyup�� �̺�Ʈ �߻��� ����� ȣ���Ѵ�!
//  	**CustomTag���� ����ϰ� �����Ƿ� ��� ����(Ư�� �̸�)�� ���Ǹ� ����!
function zmSetCommaRT(obj){
	var str = obj.value;
	var rtVal;

	if( event.keyCode == 37 || event.keyCode == 39 ) return;
	if ( obj.format == 'money' || obj.format == 'moneyDot' || obj.format == 'bigDecimal') rtVal = zmSetMoneyComma(str);
	else if ( obj.format == 'moneyZero' ) 			rtVal = zmSetMoneyZero(str);
	else if ( obj.format == 'millionMoney' ) 		rtVal = zmWon2Million(str);
	else if ( obj.format == 'millionMoneyZero' ) 	rtVal = zmWon2MillionZero(str);
	else if ( obj.format == 'thousandMoney' ) 		rtVal = zmWon2Thousand(str);
	else if ( obj.format == 'thousandMoneyZero' ) 	rtVal = zm_won2ThousandZero(str);

	if(rtVal != str)
		obj.value = rtVal;

}

// �ݾ� ���ڿ�(str)�� �޸�(,) �� ������ ���ְ� �Ǽ� ���ڿ��� ����
function zmDelComma(str){
	if(zcIsNull(str)) return "";		//���� null�̶��
	str = zsRmString(str, ',');				// , ����
	return str;
}

// �ݾ� ���ڿ�(str)�� 3�ڸ����� �޸��߰��� ���ڿ��� ����
function zmSetMoneyComma(str){
	var rtStr;	// ������ ���ڿ�

	//���� null �̳� 0 �̸� blank
	if(zcIsNull(str) ) return "";

	//ù�ڰ� -�϶� -�� ���ݾ����� ó���ϰ� ���߿� -����
	var minus = "";
	if(str.substring(0,1) == "-"){
		rtStr = str.substring(1);		// '-' �� ���� ����
		minus = "-";
	}else								// �׿��� ��� ���
		rtStr = str;

	//�Ҽ��� ������ �պκи� rtStr�� �־�ó���ϰ� �޺κ��� ���� �� �ξ��ٰ� ���߿� ����.
	var belowzero = "";
	if (zmChkDot(rtStr)==true){
		arr = rtStr.split(".");
		rtStr = arr[0];		     	//�Ҽ��� �պκ�
		belowzero = "." + arr[1];   //�Ҽ����� �� �޺κ�
	}

	// �����޸�����
	rtStr = zsRmString(rtStr, ',');

	var len = rtStr.length ;
	var result ="";

	if (len > 1 && str.substring(0,1)=="0") rtStr = rtStr.substring(1); // ù��° 0�� ������ ����

	for (var i=0; i < len;i++){  // ���� ������ �޸� ǥ����
		comma="";
		var schar = rtStr.charAt(i);
		where = len - 1 - i;
		if ((where % 3) == 0 && len > 3 && where != 0) comma = ",";
		result = result +   schar + comma ;
	}
    rtStr = minus + result + belowzero;	// - �� �Ҽ��� ���ϸ� ����

	return rtStr;
}

// �ݾ� ���ڿ�(str)�� 3�ڸ����� �޸��߰��� ���ڿ��� ����
function zmSetMoneyZero(str){
	var rtStr;	// ������ ���ڿ�

	//���� null�̶�� blank
	if ( zcIsNull(str) ) return "";
	//���� 0�̸� �״�� 0
	if ( str=="0" || str=="0.0") return str;

	//ù�ڰ� -�϶� -�� ���ݾ����� ó���ϰ� ���߿� -����
	var minus = "";
	if(str.substring(0,1) == "-"){
		rtStr = str.substring(1);	// '-' �� ���� ����
		minus = "-";
	}else							// �׿��� ��� ���
		rtStr = str;

	//�Ҽ��� ������ �պκи� rtStr�� �־�ó���ϰ� �޺κ��� ���� �� �ξ��ٰ� ���߿� ����.
	var belowzero = "";
	if (zmChkDot(rtStr)==true){
		arr = rtStr.split(".");
		rtStr = arr[0];		     	//�Ҽ��� �պκ�
		belowzero = "." + arr[1];   //�Ҽ����� �� �޺κ�
	}

	// �����޸�����
	rtStr = zsRmString(rtStr, ',');

	var len = rtStr.length ;
	var result ="";

	if (len > 1 && str.substring(0,1)=="0") rtStr = rtStr.substring(1); // ù��° 0�� ������ ����

	for (var i=0; i < len;i++){  // ���� ������ �޸� ǥ����
		comma="";
		var schar = rtStr.charAt(i);
		where = len - 1 - i;
		if ((where % 3) == 0 && len > 3 && where != 0) comma = ",";
		result = result +   schar + comma ;
	}
    rtStr = minus + result + belowzero;	// - �� �Ҽ��� ���ϸ� ����
	return rtStr;
}

// "��"���� �ݾ�(str)�� �޸����� �߰��� "�鸸" ������ ��ȯ�� ���ڿ��� ����(5000900000 => 5,000)
function zmWon2Million(str) {
	//���� null�̶�� blank ����
	if(zcIsNull(str)) return "";

	if (zmChkDot(str)==true){	//�Ҽ��� ���Ϻκ��� ������
		arr = str.split(".");
		str = arr[0];			//�Ҽ��� �պκ�
	}
	var len = str.length;

	if(len > 6){
		var outputDataLen = len - 6; //��� �ݾ��� �ڸ��� : ǥ���ϴ� �ݾ��� ������ �鸸�� �̹Ƿ� 000000�� ���� ���� "��ü����-6"�� �Ѵ�.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3�ڸ����� ","�� �߰��ϴ� ��ũ��Ʈ ȣ��
		}
		return outputData;
	}else{
		return "0"; //�Ѿ�� ����Ÿ�� 6�ڸ� ������ ��� 0 �Ѹ�.
	}
}

// "��"���� �ݾ�(str)�� �޸����� �߰��� "�鸸" ������ ��ȯ�� ���ڿ��� ����(5000900000 => 5,000)
function zmWon2MillionZero(str) {
	//���� null�̶�� 0 ����
	if(zcIsNull(str)) return "0";

	if (zmChkDot(str)==true){          //�Ҽ��� ���Ϻκ��� ������
		arr = str.split(".");
		str = arr[0];		     //�Ҽ��� �պκ�
	}
	var len = str.length;

	if(len > 6){
		var outputDataLen = len - 6; //��� �ݾ��� �ڸ��� : ǥ���ϴ� �ݾ��� ������ �鸸�� �̹Ƿ� 000000�� ���� ���� "��ü����-6"�� �Ѵ�.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3�ڸ����� ","�� �߰��ϴ� ��ũ��Ʈ ȣ��
		}
		return outputData;
	}else{
		return "0"; //�Ѿ�� ����Ÿ�� 6�ڸ� ������ ��� 0 �Ѹ�.
	}
}

// "��"���� �ݾ�(str)�� �޸����� �߰��� "õ" ������ ��ȯ�� ���ڿ��� ����(5000900900 => 5,000,900)
function zmWon2Thousand(str) {
	//���� null�̶�� blank ����
	if(zcIsNull(str)) return "";

	if (zmChkDot(str)==true){          //�Ҽ��� ���Ϻκ��� ������
		arr = str.split(".");
		str = arr[0];		     //�Ҽ��� �պκ�
	}
	var len = str.length;

	if(len > 3){
		var outputDataLen = len - 3; //��� �ݾ��� �ڸ��� : ǥ���ϴ� �ݾ��� ������ �鸸�� �̹Ƿ� 000000�� ���� ���� "��ü����-6"�� �Ѵ�.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3�ڸ����� ","�� �߰��ϴ� ��ũ��Ʈ ȣ��
		}
		return outputData;
	}else{
		return "0"; //�Ѿ�� ����Ÿ�� 3�ڸ� ������ ��� 0 �Ѹ�.
	}
}

// "��"���� �ݾ�(str)�� �޸����� �߰��� "õ" ������ ��ȯ�� ���ڿ��� ����(5000900900 => 5,000,900)
function zm_won2ThousandZero(str) {
	//���� null�̶�� 0 ����
	if(zcIsNull(str)) return "0";

	if (zmChkDot(str)==true){          //�Ҽ��� ���Ϻκ��� ������
		arr = str.split(".");
		str = arr[0];		     //�Ҽ��� �պκ�
	}
	var len = str.length;

	if(len > 3){
		var outputDataLen = len - 3; //��� �ݾ��� �ڸ��� : ǥ���ϴ� �ݾ��� ������ �鸸�� �̹Ƿ� 000000�� ���� ���� "��ü����-6"�� �Ѵ�.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3�ڸ����� ","�� �߰��ϴ� ��ũ��Ʈ ȣ��
		}
		return outputData;
	}else{
		return "0"; //�Ѿ�� ����Ÿ�� 3�ڸ� ������ ��� 0 �Ѹ�.
	}
}

// �ݾ׿� �Ҽ��� �ִ��� üũ. �����Ѵٸ� true, ���ٸ� false
function zmChkDot(str){
	for (var i=0; i< str.length; i++) {
		if(str.charAt(i) == "." )	return true;
	}
	return false;
}


/* =====================================================================================================
   �Լ��� : zs_xxxx()
   ��  �� : Character, String, number ó��(üũ/����� ���� - check.js�� ����)
========================================================================================================= */

/**
 *  �Էµ� ��Ʈ���� ����Ʈ���� �����Ѵ�.
 *  @val       : ���̸� üũ�� ��Ʈ��
 */
function zsGetBytesLength(val) {
    // �Է¹��� ���ڿ��� escape() �� �̿��Ͽ� ��ȯ�Ѵ�.
    // ��ȯ�� ���ڿ� �� �����ڵ�(�ѱ� ��)�� ���������� %uxxxx�� ��ȯ�ȴ�.
    var temp_estr = escape(val);
    var s_index   = 0;
    var e_index   = 0;
    var temp_str  = "";
    var cnt       = 0;

    // ���ڿ� �߿��� �����ڵ带 ã�� �����ϸ鼭 ������ ����.
    while ((e_index = temp_estr.indexOf("%u", s_index)) >= 0)  // ������ ���ڿ��� �����Ѵٸ�
    {
      temp_str += temp_estr.substring(s_index, e_index);
      s_index = e_index + 6;
      cnt ++;
    }

    temp_str += temp_estr.substring(s_index);

    temp_str = unescape(temp_str);  // ���� ���ڿ��� �ٲ۴�.

    // �����ڵ�� 2����Ʈ �� ����ϰ� �������� 1����Ʈ�� ����Ѵ�.
    
    return ((cnt * 2) + temp_str.length) + "";
    
    //return ((cnt * 3) + temp_str.length) + "";
}

/**
 *  �Էµ� ��Ʈ���� ����Ʈ���� üũ�Ͽ� �Ѱ�ġ���� ũ��
 *  alert �޼����� ����.
 *  onkeypress �̺�Ʈ�� �����Ѵ�.
 *  @obj       : ���̸� üũ�� ��ü
 *  @limitLen  : �ִ����
 *  @msgFlag   : alert �޼��� ��¿���
 */
function zsGetBytesLengthRT(obj, limitLen, msgFlag) {
    var val = obj.value;
    var leng = zsGetBytesLength(val);
    var result = true;
    var msg = '';

    // �ִ���̿� ���� ��Ʈ���� ����Ʈ���� ������.
    if (leng == limitLen) {
        msg = "�� �̻� �Է��Ͻ� �� �����ϴ�.\n\n" +
              "�Է��Ͻ� �� �ִ� �ִ� ���ڿ� ���̰� �̹� �ԷµǾ����ϴ�.";
        result = false;
    }

    if (msgFlag) alert(msg);
    event.returnValue = result;
}

/**
 *  �Էµ� ��Ʈ���� ����Ʈ���� üũ�Ͽ� �Ѱ�ġ���� ũ��
 *  alert �޼����� ����.
 *  onblur �̺�Ʈ�� �����Ѵ�.
 *  @obj       : ���̸� üũ�� ��ü
 *  @limitLen  : �ִ����
 *  @msgFlag   : alert �޼��� ��¿���
 */
function zsGetBytesLengthRTBlur(obj, limitLen, msgFlag) {
    var val = obj.value;
    var leng = zsGetBytesLength(val);
    var result = true;
    var msg = '';

    if (leng > limitLen) {
        msg = "�Է��Ͻ� �� �ִ� �ִ� ���ڿ� ���̸� �ʰ��Ͽ����ϴ�.\n\n" +
              "�ִ� �Է°��� ���ڿ� ���� => " + limitLen + "\n" +
              "�Է��Ͻ� ���ڿ� ���� => " + leng;
        result = false;
    }

    if (!result) {
        if (msgFlag) alert(msg);
        obj.focus();
    }
}

/**
 *  �ش� textarea�� ���μ��� �����մϴ�.
 *  @sourceObject  textarea ��ü
 *  @columnSize    �� line���� ������ �÷� ������
 *
 *  @columnSize �� �Էµ��� ������ �ش� ��ü�� cols�Ӽ����� ����մϴ�.
 */
function zsGetLineCount(sourceObject, columnSize) {
    var sourceString = sourceObject.value;
    var colSize = (arguments.length == 1) ? (new Number(sourceObject.cols)) : columnSize;
    var strArr = sourceString.split('\r\n');
    var arrCnt = strArr.length;
    var tempLeng = 0;
    var tempMod  = 0;
    var append = 0;
    var result = 0;

    for (var i=0; i<arrCnt; i++) {
        append = 0;
        tempLeng = zsGetBytesLength(strArr[i]);

        // �� �����϶�
        if (tempLeng == 0) {
            append = 1;
        }
        else {
            if ((tempLeng % colSize) > 0) append = 1;
            append = append + Math.floor(tempLeng / colSize);
        }
        result = result + append;
    }

    return result;
}

// input �ʵ� ��ü�� ��(obj)����  Ư������(org)�� rep���ڷ� ��ȯ
function zsChgChar(obj,orgStr,repStr){
	str = obj.value;
	re = new RegExp(orgStr, "g");
	obj.value = str.replace(re, repStr);
}

// ����ü ���ڿ��� �ִ� ���������̼�(")�� ��Ŭ�����̼�(')���� �����Ѵ�.
function zsDouble2SingleQuatForm(formObj) {
	var len=formObj.elements.length;
	var i=0;

	for ( i=0; i<len; i++ ) {
		formObj.elements[i].value = top.zsDouble2SingleQuat(formObj.elements[i].value);
	}
}
// ���������̼�(")�� ��Ŭ�����̼�(')���� �����Ѵ�.
function zsDouble2SingleQuat(Str) {
	while (true) {
	   if ( Str.indexOf("\"") < 0)
	      break;
	   Str = Str.replace("\"", "'");
	}
	return Str;
}



// RealTime���� ����ڰ� ���ڸ� �Է��ϴ¼��� .(dot)�� �߰��� �ٷ� �߰�
//	onkeyup �̺�Ʈ�� ȣ���ϵ��� �Ѵ�!
// gubun : dash �������� ������ ���ڿ�
//	"time":�ð�(��.��.��)
//				*** CustomTag���� ����ϰ� �����Ƿ� ��� ����(Ư�� ��Ǹ�� gubun)�� ���Ǹ� ����!
function zsSetDotRT(obj, gubun) {
	if ( gubun == "time" && (!(event.keyCode == 8 || event.keyCode <= 46)) ) zsSetDot(obj, gubun);
}

// RealTime�� �ƴѰ�쿡 ���� .(dot)�� �߰��� �߰����ش�
function zsSetDot(obj, gubun) {
	obj.value = zsSetDotStr(obj.value, gubun);
}

// RealTime�� �ƴѰ�쿡 ���� .(dot)�� �߰��� �߰��� ���ڿ��� ����
function zsSetDotStr(str, gubun) {
	var retStr = str;
	data = str.toUpperCase();
	data_1 = zsRmString(data, ".");	// "." ����

	// �ð� 2��.2��.2�� ���·� �߰��� .(dot) ����
	if (gubun == "time") {
		if (data.length > 8) {
			retStr = data_1.substring(0,2) + "." + data_1.substring(2,4) + "." + data_1.substring(4,6);
		} else if (data.length > 5) {
			if (data.substring(2,3)=="." && data.substring(4,5)==".") return str;
			else retStr = data_1.substring(0,2) + "." + data_1.substring(2,4) + "." + data_1.substring(4,6);
		} else if (data.length > 2) {
			if (data.substring(2,3)==".") return str;
			else retStr = data_1.substring(0,2) + "." + data_1.substring(2);
		}
	}

	return retStr;
}




// str�� ���ڿ��� rmChar�� Ư�� ���ڸ� ������ ���ڿ��� ����.
//	rmChar�� ���� 1�� ����
function zsRmString(str, rmChar){
	//null�� �ִٸ�
	if(zcIsNull(str) || zcIsNull(rmChar)) return false;

	// ���ڸ��� rmChar���� üũ
	if(rmChar.length != 1){
		alert("[��ũ��Ʈ ��� ����]\r\n rmStr���� 1�ڸ��� ���ڸ� �� �� �ֽ��ϴ�.");
		return;
	}
	var len = str.length;
	var rtValue = "";

	for(var i =0 ; i < len ; i++){
		if(str.charAt(i) != rmChar && str.charAt(i) != " "){
			rtValue += str.charAt(i);
		}
	}
	return rtValue;
}

// obj�� value ���ڿ��� rmChar�� Ư�� ���ڸ� ������ ���ڿ��� ����.
//	rmChar�� ���� 1�� ����
function zsRmObj(obj, rmChar){
	str = obj.value;
	//null�� �ִٸ�
	if(zcIsNull(str) || zcIsNull(rmChar)) return false;

	// ���ڸ��� rmChar���� üũ
	if(rmChar.length != 1){
		alert("[��ũ��Ʈ ��� ����]\r\n rmStr���� 1�ڸ��� ���ڸ� �� �� �ֽ��ϴ�.");
		return;
	}
	var len = str.length;
	var rtValue = "";

	for(var i =0 ; i < len ; i++){
		if(str.charAt(i) != rmChar && str.charAt(i) != " "){
			rtValue += str.charAt(i);
		}
	}
	return rtValue;
}

// input �ʵ� ��ü�� ��(obj)����  ���� �����̽��� ����
function zsDelRLSpace(obj) {
		str = zsDelLSpace( obj );
		str = zsDelRSpace( obj );
}

// input �ʵ� ��ü�� ��(obj)����  ���ʽ����̽��� ����
function zsDelLSpace(obj) {
	var str = obj.value;

	if(str != ""){
		var iLen = str.length;
		var idx = 0;
		for(idx=0 ; idx<iLen; idx++)
		{
			if(str.charAt(idx)!=' ') break;
		}
		obj.value = str.substring(idx, iLen);
	}
}

// input �ʵ� ��ü�� ��(obj)���� ������ �����̽��� ����
function zsDelRSpace(obj) {
	var str = obj.value;

	if(str != ""){
		var iLen = str.length;
		var idx = 0;
		for(idx=iLen-1 ; idx>=0; idx--)
		{
			if(str.charAt(idx)!=' ') break;
		}
		obj.value = str.substring( 0,idx+1 );
	}
}

function zsRLTrim(str) {
	str = zsLTrim(str);
	str = zsRTrim(str);
	return str;
}
function zsLTrim(str) {
	if (str == "") return "";

	var iLen = str.length;
	var idx = 0;
	for(idx=0 ; idx<iLen; idx++)
	{
		if(str.charAt(idx)!=' ') break;
	}
	return str.substring(idx, iLen);

}
function zsRTrim(str) {
	if (str == "") return "";

	var iLen = str.length;
	var idx = 0;
	for(idx=iLen-1 ; idx>=0; idx--)
	{
		if(str.charAt(idx)!=' ') break;
	}
	return str.substring( 0,idx+1 );
}


/* =====================================================================================================
   �Լ��� : zu_xxxx() , �̹���ó���κ��� ���� MM_xxxx
   ��  �� : ��ƿ�� ��ũ��Ʈ ���
========================================================================================================= */

// ���� ���ڸ� �Է°����ϰ� ����� ���.(onkeypress �̺�Ʈ�� ȣ���Ѵ�)
function zuInputNumRT(obj){
	var keycode = event.keyCode;

	if( !((48 <= keycode && keycode <=57) || keycode == 13 || keycode == 45) )
		event.keyCode = 0;		// �̺�Ʈ cancel
}

// ����ü(formObj) ���� �ִ� text(read only����) �ڽ�, radio , single select box ���� �ʱ�ȭ��Ų��.
// readonly�� �ʱ�ȭ button skip hidden textarea �ʱ�ȭ ó�� - 2004.08.17
function zuClearTRS(formObj){
	var len=formObj.elements.length;
	var i=0;
	var message="";
	for(i=0;i<len;i++){
		if( formObj.elements[i].tagName=="INPUT" ) {
			//if(formObj.elements[i].type=="text" && !formObj.elements[i].readOnly) formObj.elements[i].value="";
			if(formObj.elements[i].type=="text" || formObj.elements[i].type == "hidden" ) formObj.elements[i].value="";
			else if(formObj.elements[i].type=="select-one") formObj.elements[i].selectedIndex=0;
			else if(formObj.elements[i].type=="radio") formObj.elements[i].checked=false;
			else if(formObj.elements[i].type=="button") continue;
		} else if( formObj.elements[i].tagName=="TEXTAREA" ) {
			formObj.elements[i].innerText="";
		} else if( formObj.elements[i].tagName=="SELECT" ) {
			formObj.elements[i].selectedIndex=0;
			//formObj.elements[i].value="";
		}
	}
	window.defaultStatus = "�غ�(Ready)";
}

//������ ��� �Է��ʵ���� disabled ��Ų��.
//bln : boolean type (true��Ȱ��,false Ȱ��)
function zuMakeDisable(bln) {
	for (var i=0;i <document.transform.length;i++){
    	document.transform.elements[i].disabled=bln;
    }
}

// 1�ڸ� ���ڿ� 0�ٿ��� 2�ڸ� ��ȯ
function zuToLen2  ( nums ) {
        var num=0;

        if ( nums >= 1 && nums <=9 )
            num = '0' + nums;
        else
            num=nums;
        return num;
    }


function setCalDate(targetName, returnStr) {
    eval(targetName).value = returnStr;
}


function calPopForCMon(name, target){
    dateName = target;
    var dateVal = name.value;

    if(dateVal == "")
    {
        callCalPop(name, target);
    }
    else
    {
        var chk = zdIsDate(dateVal, 'YYYY-MM-DD');
        if(!chk) {

			var dNow = new Date();
			var yyyy = dNow.getYear();
			var MM   = dNow.getMonth()+1;
			if(MM < 10) MM = '0' + MM;
			var dd   = dNow.getDate();
			name.value = yyyy + '-' + MM + '-' + dd;

            callCalPopForCMon(name, target, yyyy, MM, dd);
        } else {
        	//callCalPopForCMon(name, target, dateVal.substring(0,4), dateVal.substring(5,7), dateVal.substring(8));
        	dateVal = zsRmString(dateVal, "-");
        	callCalPopForCMon(name, target, dateVal.substring(0,4), dateVal.substring(4,6), dateVal.substring(6));
        }
    }
}

function checkSpecial(target) {
                //~$@#'_- ., + ����
                var eng = new String("!%^&()={}[]|?><");
                var t = new String(target);                             
                var tempStr;
                for(i=0;i<t.length;i++) {
                        tempStr = t.substring(i,i+1);
                        //34(") 39(') 92(\)
                        if(eng.indexOf(tempStr) >= 0 || tempStr.charCodeAt(0) ==
 34 || tempStr.charCodeAt(0) == 92) {                                
                             //alert(alertMsg[16]);//"Ư�����ڴ� ����� �� �����ϴ�."
                             alert('Ư�����ڴ� ����� �� �����ϴ�.');
                             return false;
                        }
                }
                return true;
}

// ��ü�� ���� ���� return
function chkExist( args ){
	if( args != "undefined" &&  args != "NaN" &&  args != null )
		return true;
	else
		return false;
}


// checkbox�� ��ü ���ý� ��ü ����
function allChk(arg_str){
	var chk = "";

    if( chkExist(arg_str) ){
		if( chkExist(arg_str.length) ){
			var len = arg_str.length;

			for( i = 0 ; i < len; i ++){
				if( arg_str[i].checked == true ){
      	  	    	chk = "YES";
      	  	    	break;
      	  	    }
			}

			if( chk == "YES" ){
				for( i = 0 ; i < len; i ++){
					arg_str[i].checked = false;
				}
			}else{
				for( i = 0 ; i < len; i ++){
					arg_str[i].checked = true;
				}
			}
		}else{
			if( arg_str.checked == true ){
      		    arg_str.checked = false;
      		}else{
      			arg_str.checked = true;
      		}
		}
    }
}


	function print_view(image) {
		var imgwin = window.open("", 'wall', 'scrollbars=yes, status=no, toolbar=no, resizable=0, location=no, menu=no, width=100, height=100');
		imgwin.focus();
		imgwin.document.open();
		imgwin.document.write("<html>\n");
		imgwin.document.write("<head>\n");
		imgwin.document.write("<title></title>\n");
		imgwin.document.write("<sc"+"ript>\n");
		imgwin.document.write("function resize() {\n");
		imgwin.document.write("pic = document.il;\n");
		imgwin.document.write("if(eval(pic).height) { var name = navigator.appName\n");
		imgwin.document.write(" if(name == 'Microsoft Internet Explorer'){ myHeight = eval(pic).height + 49; myWidth = eval(pic).width + 27;\n");
		imgwin.document.write(" } else { myHeight = eval(pic).height + 9; myWidth = eval(pic).width; }\n");
		imgwin.document.write(" clearTimeout();\n");
		imgwin.document.write(" var height = screen.height;\n");
		imgwin.document.write(" var width = screen.width;\n  ");
		imgwin.document.write(" var leftpos = width / 2 - myWidth / 2;\n");
		imgwin.document.write(" var toppos = height / 2 - myHeight / 2; \n");
		imgwin.document.write(" if( leftpos < 0) leftpos = 0; \n ");
		imgwin.document.write(" if( toppos < 0) toppos = 0; \n ");
		imgwin.document.write(" self.moveTo(leftpos, toppos);\n");
		imgwin.document.write(" self.resizeTo(myWidth, myHeight);\n");
		imgwin.document.write("} else setTimeOut(resize(), 100);}\n");
		imgwin.document.write("</sc"+"ript>\n");
		
		imgwin.document.write("</head>\n");
		imgwin.document.write('<body topmargin="0" leftmargin="0" marginheight="0" bottommargin="0" rightmargin="0" marginwidth="0" bgcolor="#FFFFFF">\n');
		
		imgwin.document.write("<img border=0 src="+image+" xwidth=100 xheight=9 name=il onload='resize();' onClick='javascript:window.close();' style='cursor:hand;'><br>\n");
		imgwin.document.write("</body>\n");
		imgwin.document.close();
	}
