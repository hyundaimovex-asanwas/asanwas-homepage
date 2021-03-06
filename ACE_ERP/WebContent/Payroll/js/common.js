/********************************************************************************/
/* 시스템            : GLW (Global Window)
/* 프로그램 아이디   :
/* 소스파일 이름     : common.js
/* 설명              : 공통 스크립트
/* 버전              : 1.0
/* 최초 작성자       : 임정기
/* 최초 작성일자     : 2006-01-17
/* 최근 수정자       :
/* 최근 수정일시     :
/* 최종 수정내용     :
/********************************************************************************/


/* =====================================================================================================
   함수명 : zc_xxxx()
   설  명 : Character, String처리 (날짜,금액은 제외)
========================================================================================================= */

// 해당 폼 객체(formObj)의 입력 필드 중,
// 필수항목의 null 체크, 길이 체크, 주민번호,법인번호, 사업자 번호, 금액 형태의 데이타 정합성을 체크하는 펑션
// 각각의 체크를 통과 못했을때는 각 필드와 이름을 alert()를 통해 보여주고 false를 리턴하고,
// 모든 체크를 통과하면 true를 리턴하면서, "처리중입니다"를 보여주는 팝업창을 호출한다.


function zcCheckForm(formObj){
	var obj = formObj.all;
	var flag = false;
	var msg = "";
	var focusObj;				// focus를 주어야 할 오브젝트
	var alertFlag = false;		// true 이면 alert창을
	var confirmFlag = false;	// true 이면 confirm창을

	for(var i = 0 ; i < obj.length ; i++){

		if(obj.item(i).type=="text" || obj.item(i).type=="textarea"){
			zsDelRLSpace(obj.item(i));
		}

		//  -------------필수 항목 체크---------------//
		if(obj.item(i).notnull != undefined ){

			if(obj.item(i).type=="radio" || obj.item(i).type=="checkbox"){	//체크박스나 라디오 박스라면
				var colObj = document.getElementsByName(obj.item(i).name);
				for(var j = 0 ; j<colObj.length ; j++){	// 체크박스나 라디오 박스에서 체크된 것이 있는지 검사
					if(colObj[j].checked){
						flag = true;
						break;
					}
				}
				if(!flag){	// 필수 항목 누락이 있다면 메시지에 추가
					setErrorFld(obj.item(i), obj.item(i).msgTitle + " 은(는) 필수입력 항목입니다.\r\n");
				}
				flag = false;	// flag 초기화

			}else{	// 그외 input or textarea 라면
				if(obj.item(i).value == ""){	// value가 null이라면
					setErrorFld(obj.item(i), obj.item(i).msgTitle + " 은(는) 필수입력 항목입니다.\r\n");
				}
			}
		}

		//  ------------- 길이 체크---------------//
		if(obj.item(i).correctLen != undefined && obj.item(i).value != ""){
			var str = zsRmString(obj.item(i).value, "-");	// "-" 제거
			if(str.length != obj.item(i).correctLen){	// 올바른 길이가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 " +obj.item(i).correctLen+ "자의 데이타를 입력해야 합니다.\r\n");
			}
		}

		if(obj.item(i).minLen != undefined && obj.item(i).value != ""){
			if(zsGetBytesLength(obj.item(i).value)  < parseInt(obj.item(i).minLen)){
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 " +obj.item(i).minLen+ "자 이상의 데이터를 입력해야 합니다.\r\n");
			}
		}
		
		if(obj.item(i).len != undefined &&  obj.item(i).value != ""){
			
			if(obj.item(i).comma != undefined) {
				var str = obj.item(i).value;
				var arrStr = str.split('.');
				if(arrStr.length > 2) {
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 소수점을 하나만 입력해야 합니다.\r\n");
				}
				
				if(zsGetBytesLength(arrStr[0])  > (parseInt(obj.item(i).len)-parseInt(obj.item(i).comma))) {
					var commalen = (parseInt(obj.item(i).len)-parseInt(obj.item(i).comma));
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 소수점 외에 " +commalen+ "자 이하의 데이터를 입력해야 합니다.\r\n");
				}
		
				if(arrStr.length == 2) {
					if(zsGetBytesLength(arrStr[1])  > parseInt(obj.item(i).comma)) {
						setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 소수점 이하 " +obj.item(i).comma+ "자리의 데이터를 입력해야 합니다.\r\n");
					}
				}
			
			} else {
				if(zsGetBytesLength(obj.item(i).value)  > parseInt(obj.item(i).len)){	// 올바른 길이가 아니라면
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 " +obj.item(i).len+ "자 (한글 " + parseInt(obj.item(i).len/2) +"자) 이하의 데이터를 입력해야 합니다.\r\n");
				}
			}
		}

		// -------------금액인지 체크(숫자, "-", ".", "," 로만 이루어졌는지 체크----------------//
		if(obj.item(i).format =="money" && obj.item(i).value !=""){
			if(!zmIsMoney(obj.item(i))) {		// 올바른 금액형태가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 숫자만 입력해야 합니다.\r\n");
			}
		}
		
		// ------------- 숫자만 체크 (// --------------//
		if(obj.item(i).format =="number" && obj.item(i).value !=""){
			if(!zcIsNum(obj.item(i))) {		// 올바른 숫자형태가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 숫자만 입력해야 합니다.\r\n");
			}
		}

		// -------------이메일인지 체크----------------//
		if(obj.item(i).format =="email" && obj.item(i).value !=""){
			if(!zcIsEmail(obj.item(i))) {		// 올바른 이메일형태가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "이(가) 올바르지 않습니다.\r\n");
			}
		}

		// -------------날짜인지 체크----------------//
		if(obj.item(i).format =="date" && obj.item(i).value !=""){
			if(!zdIsDate(obj.item(i).value)) {		// 올바른 날짜형태가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 날짜만 입력해야 합니다.\r\n");
			}
		}

		// -------------날짜_년월인지 체크----------------//
		if(obj.item(i).format =="dateYM" && obj.item(i).value !=""){
			if(!zdIsDateYM(obj.item(i).value)) {		// 올바른 날짜형태가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "에는 날짜만 입력해야 합니다.\r\n");
			}
		}

		// -------------시간인지 체크----------------//
		if(obj.item(i).format =="time" && obj.item(i).value !=""){
			if(!zdIsTime(obj.item(i).value)) {		// 올바른 시간형태가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "이(가) 올바르지 않습니다.\r\n");
			}
		}

		// -------------주민번호 정합성 체크----------------//
		if(obj.item(i).format =="jumin" && obj.item(i).value !=""){
			if(!zcIsJumin(obj.item(i))) {		// 올바른 주민번호가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "이(가) 올바르지 않습니다.\r\n");
			}
		}

		// -------------법인번호 정합성 체크----------------//
		if(obj.item(i).format =="cono" && obj.item(i).value !=""){
			if(!zcIsBupin(obj.item(i))) {		// 올바른 법인번호가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "이(가) 올바르지 않습니다.\r\n");
			}
		}

		// -------------주민(법인)번호 정합성 체크----------------//
		if(obj.item(i).format =="perid" && obj.item(i).value !=""){
			if(!zcIsPerid(obj.item(i))) {		// 올바른 주민(법인)번호가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "이(가) 올바르지 않습니다.\r\n");
			}
		}

		// -------------사업자번호 정합성 체크----------------//
		if(obj.item(i).format =="resno" && obj.item(i).value !=""){
			if(!zcIsResno(obj.item(i))) {		// 올바른 사업자번호가 아니라면
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "이(가) 올바르지 않습니다.\r\n");
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
					//setErrorFld(obj.item(i), "asp, jsp, php, html, bak, inc, exe, bat, com, htm, bsp 파일은 업로드할 수 없습니다.\r\n");
					setErrorFld(obj.item(i), alertMsg[13] + "\r\n");
					
				}
			}
		}
		*/

	}

	if (alertFlag) {	// alert창을 띄울게 있으면,
		alert(msg);

		if ( focusObj.disabled == false )	focusObj.focus();
		return false;
	/*
	} else if (confirmFlag) {	// confirm창을 띄울게 있으면,
		msg += "처리하시겠습니까 ?";
		if ( confirm(msg) ) return true;

		if ( focusObj.disabled == false )	focusObj.focus();
		return false;
	*/
	}else	// 모든 체크를 통과했다면
		return true;

	//	포커스를 줄 오브젝트 셋팅, alert 메시지 텍스트 추가
	function setErrorFld(obj, str){
		var is_show = 'Y';
		try {
			obj.focus();
		} catch(ee) {
			is_show = 'N';
		}
		
		if(is_show == 'Y') {
			alertFlag = true;
			if(focusObj == undefined)		focusObj = obj;		//focusObj 셋팅
			msg += str;		//메시지 셋팅
		}
	}
}

// input 필드 객체(obj)의 값이 순수한 영문자("A"-"Z", or "a"-"z") 인지 체크
// 영문이라면 true, 아니라면 false를 리턴
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

//  input 필드 객체(obj)의 값이 영문자("A"-"Z", or "a"-"z") 또는 숫자 이면 true
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


//  input 필드 객체(obj)의 값이 정수(0~9)만 입력하였는지 확인
function zcIsNum(obj) {
	var str = obj.value;
	return zcIsNumStr(obj.value);
}

//	문자열(str)이 (0-9)만으로 이루어졌는지 체크
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
    var deny_pattern = /[^(가-힣)]/;

	if(!deny_pattern.test(obj.value)) {
		//alert(alertMsg[15]);
		obj.focus();
		obj.select();
		return false;
	}

	return true;
}

//  input 필드 객체(obj)의 값이 정수(0~9)만 입력하였는지 확인 +  문자가 있다면 obj 값 초기화
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

//  input 필드의 값이 정수(0~9)만 입력하였는지 확인 +  문자가 있다면 obj 값 초기화
function zcIsStrNumAndInit(str) {
	//var str = obj.value;

	if(zcIsNumStr(str))
		return true;
	else{
		obj.value="";
		return false;
	}
}

//  input 필드 객체(obj)의 값이 정수(0~9), 소수점('.') 이면 true
function zcIsNumDot(obj) {
    var deny_pattern = /[^0-9"."]/;
	var paramValue = obj.value;

	if ( paramValue.substr(0,1) == "-" ) paramValue = paramValue.substr(1,paramValue.length);

	if(deny_pattern.test(paramValue)) {
		//alert(alertMsg[ 8]); // 숫자만 입력해야 합니다.
		alert('숫자만 입력해야 합니다');
		obj.focus();
		obj.select();
		return false;
	}

	return true;
}

//  input 필드 객체(obj)의 값이 정수(0~9), 마이너스('-'), 소수점('.') 이면 true
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
//  input 필드 객체(obj)의 값이 정수(0~9), 마이너스('-'), 소수점(':') 이면 true
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
//  input 필드 객체(obj)의 값이 정수(0~9)로 이루어졌다면 true, allowNegatives가 true일경우 음수(-포함된 정수)도 true
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

//  input 필드 객체(obj)의 값이 올바른 email포맷이면 true
function zcIsEmail( obj ) {
    var deny_pattern = /[^(--a-zA-Z0-9"@.")]/;
    if (deny_pattern.test(obj.value)) return false;

	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//공백이라면

	var isValid = true;
	str += "";

	namestr = str.substring(0, str.indexOf("@"));  // everything before the '@'
	domainstr = str.substring(str.indexOf("@")+1, str.length); // everything after the '@'

	// Rules : @앞에 글자가 있어야 하며, 도메인부분엔 반드시 "." 이 있어야 하며,
	//				@와 . 이 연속해서 올 수 없고, 마지막 글자는 반드시 영문이어야 한다.
   	if (zcIsBlank(obj) || (namestr.length == 0) ||
			(domainstr.indexOf(".") <= 0) ||
			(domainstr.indexOf("@") != -1) ||
			!(	(str.charAt(str.length-1) >= 'a' && str.charAt(str.length-1) <= 'z') || (str.charAt(str.length-1) >= 'A' && str.charAt(str.length-1) <= 'Z')	)
	){
			isValid = false;
	}
   	return isValid;
}

//  input 필드 객체(obj)의 값이 blank이면 true
function zcIsBlank( obj ) {
	var str = obj.value;
	return zcIsNull(str);
}


// str이 null, undefined, NaN, 공백("") 이면 true
function zcIsNull(str) {
 	if (str+"" == "undefined" || str+"" == "NaN" || str+"" == "null" || str+"" == "")
 		return true;
	return false;
}

//  input 필드 객체(obj)의 값이 올바른 주민번호인지 체크(123456-1234567 형태, 1234561234567 모두 체크 가능)
function zcIsJumin( obj ) {
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//공백이라면

	str = zsRmString(str, "-");	// "-" 제거
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

//  input 필드 객체(obj)의 값이 올바른 법인번호인지체크
function zcIsBupin(obj) {
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//공백이라면

	str = zsRmString(str, "-");	// "-" 제거

	var check = 1;
	var no = new Array(13);
	var sum = 0;
	var rem = 0;
	var m = 0;

	m = parseInt(str.charAt(12),10); // 번호의 마지막 숫자 얻기

	for(var i=0; i<12; i++) no[i] = parseInt(str.charAt(i),10); // 1~12까지 숫자 얻기

	for(var i=0; i<12; i++) {
		sum += (check * no[i]);
		check = (check==1) ? 2 : 1;
	}

	rem = sum % 10; // 나머지 구하기
	rem = 10 - rem;
	rem = (rem >= 10) ? rem - 10 : rem;

	// 마지막번째와 10-rem의 값을 비교
	if(m == rem) return true; // 정확
	else return false; // 부정확
}

//  input 필드 객체(obj)의 값이 올바른 주민(법인)번호인지 체크(123456-1234567 형태, 1234561234567 모두 체크 가능)
function zcIsPerid( obj ) {
	if(zcIsJumin(obj) || zcIsBupin(obj))	return true;
    	else  return false;
}

// input 필드 객체(obj)의 값이 올바른 사업자등록번호인지 체크
function zcIsResno(obj){
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//공백이라면

	str = zsRmString(str, "-");	// "-" 제거

	var check = 0;
	var no = new Array(10);
	var sum = 0;
	var tmpNo = 0;
	var tmpStr = 0;

	for(var i=0; i<10; i++) no[i] = parseInt(str.charAt(i),10); // 1~10까지 숫자 얻기

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
	if( (sum % 10) == 0) return true; // 정확
	else return false; // 부정확
}

// input 필드 객체(obj)의 값이 주어진 길이(lengthInt)와 같은지 체크
function zcIsCorrectLen(obj, lengthInt){
	var str = obj.value;
	if(zcIsNull(str)) return false;	//공백이라면

	if( str.length == lengthInt)		// 문자열의 길이와 lengthInt 가 같다면
		return true;
	else return false;
}

// 최소 첨부자료 한개 이상 선택하게 하기 위해 파일 존재 여부 체크
/*
function zcExistFile() {

	if(frmWrite.file1.value=="" && frmWrite.file2.value==""  && frmWrite.file3.value=="" ){
		alert(" 첨부 자료를 선택해 주세요(최소한개이상)");
		return;
	}

	frmWrite.action = "/ComnWeb/jsp/util/SaveFile.jsp";
	frmWrite.submit();
}
*/

// String을 받아서 0~9 까지의 숫자만 리턴해준다.
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
//		수정페이지에서 변경된 것이 있는지 체크
//			함수명 : zcIsChanged() 최초 onload 시 zcInitData() 함수가 호출되고 var oData = new Array() ; 가 전역변수로 선언되야함
//			설  명 : Form 내용중 변경사항을 체크하여 submit시 alert함 scriptFormTest.html 에서 확인
///////////////////////////////////////////////////////////////////////////////////////////////////////////
var oData = new Array() ; //최초 form 에 set 되는 데이타를 읽을 array

//폼(diffForm에 감싸진 필드)의 데이타를 읽어서 array에 저장한다.
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
				//입력필드를 String에 붙이자
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
				//입력필드를 String에 붙이자
				oData = oData.concat(document.diffForm.elements[i].value);
			}
		}
	}
}
*/

/*
//최초 입력된 값과 submit 시 변경된 값을 비교하여 결과를 리턴한다.
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
				//입력필드를 String에 붙이자
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
				//입력필드를 String에 붙이자
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
		alert("변경된 필드가 있습니다. 수정사항을\n 변경하시겠습니까?");//submit(); 으로 대치!
	else
		alert("변경된 사항이 없습니다.");
}
*/

// DDD 번호를 넣어서 맞는 번호인지 체크한다.
// ddd : DDD번호
// gubun : 'tel'일반전화, 'mobile'휴대전화
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
   함수명 : zd_xxxx()
   설  명 : 날짜관련 처리
========================================================================================================= */

// format의 형태로 클라이언트 pc의 현재 날자를 리턴한다.
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

// 문자열(str)을 날짜형식에 의해 '-' 삽입하여 리턴
function zdSetDateDashStr(str) {
	//alert(zdIsDate(str));
	if(!zdIsDate(str)){		//올바른 형태가 아니라면
		return false;
	}
	str = str.substr(0,4)+"-"+str.substr(4,2)+"-"+str.substr(6,2);
	return str;
}

// input 필드(obj)의 값을 날짜형식에 의해  4자-2자-2자 형태로 중간에 dash 삽입(20030101 -> 2003-01-01)
function zdSetDateDash(obj){
	var str = obj.value;
	if(zcIsNull(str)) return;	//공백이라면
	obj.value = zdSetDateDashStr(str);
}

// 문자열이 년도형태 이면 true
function zdIsYear(str){
	if(zcIsNull(str)) return false;	//공백이라면
	var isValid=false;

	if(zcIsNumStr(str)){
		if(str.length==4 && (str.charAt(0)==1 || str.charAt(0)==2) && (str.charAt(1)==0 || str.charAt(1)==1 ||str.charAt(1)==9)){
			if(str>1000) isValid = true;
			}
	}
	return isValid;
}

//19000909형태, 1900-09-09형태의 날짜(str)가  올바른 날짜인지 체크
function zdIsDate(str) {
	if(zcIsNull(str)) return false;	//공백이라면

	var valid = true;
	var msg="";
	str =  zsRmString(str, "-");
	var birth = str;
	var yyyy = birth.substring(0,4);
	var mm = birth.substring(4,6);
	var dd = birth.substring(6,8);

	if ( birth.length != 8 || !zcIsNumStr(birth) ) {
		//alert("올바른 일자형식이 아닙니다.\n예) 20040101");
		return false;
	}

	if (!(yyyy.substring(0,2)=="19" || yyyy.substring(0,2)=="20" || yyyy.substring(0,4)=="9999")) {
		//msg+="년 입력오류!\n";
		valid= false;
	}

	if (mm > 12 || mm < 1) {
		//msg+="월 입력오류! (1~12)\n";
		valid =  false;
	}

	var chkdt = new Date( yyyy, mm-1, dd );
	if( chkdt.getYear() > 1900 && (chkdt.getYear() != yyyy || chkdt.getMonth() != (mm-1) || chkdt.getDate() != dd) ){
		//alert( msg+"날짜의 입력이 잘못되었습니다.");
		return false;
	}
	else if( chkdt.getYear() < 1900 && ( chkdt.getYear() != yyyy.substring(2) || chkdt.getMonth() != (mm-1) || chkdt.getDate() != dd )){
		//alert( msg+"날짜의 입력이 잘못되었습니다.");
		return false;
	}
	return true;
}


//190009형태, 1900-09형태의 날짜(str)가  올바른 년월인지 체크
function zdIsDateYM(str) {
	if(zcIsNull(str)) return false;	//공백이라면

	var valid = true;
	var msg="";
	var birth = zsRmString(str, "-");
	var yyyy = birth.substring(0,4);
	var mm = birth.substring(4,6);

	if ((zcIsNull(birth) || birth.length != 6) || !zcIsNumStr(birth)) {
		//alert("올바른 년월형식이 아닙니다.\n예) 200401");
		return false;
	}

	if (!(yyyy.substring(0,2)=="19" || yyyy.substring(0,2)=="20")) {
		msg+="년 입력오류!\n";
		valid= false;
	}

	if (mm > 12 || mm < 1) {
		msg+="월 입력오류! (1~12)\n";
		valid =  false;
	}

	if (valid==false) alert(msg);

	return valid;
}

//235959형태, 23.59.59형태의 시간(str)이  올바른 시간인지 체크
function zdIsTime(str) {
	if(zcIsNull(str)) return false;	//공백이라면

	var valid = true;
	var msg="";
	str =  zsRmString(str, ".");
	var time = str;
	var hour 	= time.substring(0,2);
	var minute 	= time.substring(2,4);
	var second 	= time.substring(4,6);

	if ((zcIsNull(time) || time.length != 6) || !zcIsNumStr(time)) {
		alert("올바른 시간형식이 아닙니다.\n예) 235959");
		return false;
	}

	if (hour > 23 || hour < 0) {
		msg+="시(Hour) 입력오류! (00~23)\n";
		valid= false;
	}

	if (minute > 59 || minute < 0) {
		msg+="분(Minute) 입력오류! (00~59)\n";
		valid =  false;
	}

	if (second > 59 || second < 0) {
		msg+="초(Second) 입력오류! (00~59)\n";
		valid =  false;
	}

	if (valid==false) alert(msg);

	return valid;
}

// 문자열(str) 윤년인지 체크
function zdIsLeafYear(str) {
	if(zcIsNull(str)) return false;	//공백이라면
	var YYYY = parseInt(str,10);
	//alert(YYYY);
	if ( ( (YYYY%4 == 0) && (YYYY%100 != 0) ) || (YYYY%400 == 0) ) {
		return true;
	}
	return false;
}





//	Date객체를  yyyy-mm-dd  hh:mm:ss 의 문자열로 리턴한다.
// paramDateTime의 타입은 Date(내장객체)이다.
function zdGetDateTime(paramDateTime)
{
	var myDate = paramDateTime;
	var yy, mm, dd; // 날짜
	var ho, mi, se; // 시간

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
    입력필드에 입력하면서 날짜 형식 만들어 주기
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





// 문자열 sVal을 iLen길이가 될때까지 sVal의 앞에 "0"을 붙인 문자열을 리턴한다. 기업체번호등에서 자리수 만큼 0을 붙여서 반환, 날짜 문자열의 월과 일에 쓰임( 01월 02일)
// sVal - 문자열
// iLen - 길이(integer)
// 예) sVal에 '23'을 iLen에 5를 주면 리턴값은 '00023' 이다.
function zdSetZero(sVal, iLen){
	var sStr = "";
	if (typeof sVal=="object") {
		sStr = sVal.value;
		sStr = zsDelRLSpace(sStr);
	} else	sStr = String(sVal);

	if(zcIsNull(sStr)) return;	//공백이라면

	for (ii = sStr.length; ii < iLen; ii++) {
		sStr =  "0" + sStr;
	}
	return sStr;
}

// 두 날짜의 차이를 날(日)수로 리턴한다.
// basicDayStr에서 compareDayStr을 뺀 날짜수 리턴
// 날짜 형식은 "YYYY-MM-DD" 또는 "YYYYMMDD"이다.
function zdGetDifTodayInputday(basicDayStr, compareDayStr) {
	basicDayStr = zsRmString(basicDayStr, '-');		// '-'가 있다면 제거
	compareDayStr = zsRmString(compareDayStr, '-');
	if(!zdIsDate(basicDayStr) ||!zdIsDate(compareDayStr)) return false;		//날짜 형식이 아니라면

	var date1  = new Date(basicDayStr.substring(0,4), basicDayStr.substring(4,6)-1, basicDayStr.substring(6,8) );
	var date2  = new Date(compareDayStr.substring(0,4), compareDayStr.substring(4,6)-1,compareDayStr.substring(6,8));

	return Math.floor(( date1 - date2 )*(1/(1000*60*60*24)));
}

// toDate가 fromDate보다 크면(최근일자) true 리턴
function zdIsBig(toDate, fromDate) {
	toDate = zsRmString(toDate, '-');		// '-'가 있다면 제거
	fromDate = zsRmString(fromDate, '-');
	if(!zdIsDate(toDate) ||!zdIsDate(fromDate)) return false;		//날짜 형식이 아니라면
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

//기준일  - 비교일 에서 차이를 년 월 로 넘겨준다.
/*
function zdDaysBetweenTwoDate(obj){

   	var yr,mo,ayr,amo, ry,rm,r1,r2,r3;            //변수를 선언합니다.


   	yr = obj.syear.value;
   	mo = obj.smonth.value;

   	ayr = obj.ayear.value;
   	amo = obj.amonth.value;
	if (isNaN(yr) || isNaN(mo) || isNaN(ayr) || isNaN(amo)) {
		window.alert("숫자만 입력 하세요");
		return;
	}

	if (zcIsNull(yr) || zcIsNull(mo) || zcIsNull(ayr) || zcIsNull(amo) ) {
		window.alert("날짜를 입력하세요");
		return;
	}

	if (mo<1 || mo>12) {
		window.alert("유효한 날짜가 아닙니다");
		return ;
	}
	if (amo<1 || amo>12) {
		window.alert("유효한 날짜가 아닙니다");
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
    alert (ry+"년  "+rm+"개월 차이");
   	//return(r);	                       //차이를 반환합니다.
}
*/


/*
//  기준년월일 에서 몇년 몇개월 후의 날짜 값을 반환한다.
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
    	alert ('1 ~ 11 월 까지만 입력하세요');
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

//년월 입력시 마지막 일자
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
   함수명 : zm_xxxx()
   설  명 : 금액 처리
========================================================================================================= */

//  input 필드 객체(obj)의 값이 금액형태(정수(0~9), 마이너스('-'), 소수점('.'), 콤마(',') )이면 true
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

// input 필드 객체(obj)에 금액 입력시, 실시간으로 3자리 마다 ,를 삽입
// onkeyup에 이벤트 발생시 펑션을 호출한다!
//  	**CustomTag에서 사용하고 있으므로 펑션 변경(특히 이름)에 주의를 요함!
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

// 금액 문자열(str)에 콤마(,) 가 있으면 없애고 실수 문자열을 리턴
function zmDelComma(str){
	if(zcIsNull(str)) return "";		//값이 null이라면
	str = zsRmString(str, ',');				// , 제거
	return str;
}

// 금액 문자열(str)에 3자리마다 콤마추가한 문자열을 리턴
function zmSetMoneyComma(str){
	var rtStr;	// 리턴할 문자열

	//값이 null 이나 0 이면 blank
	if(zcIsNull(str) ) return "";

	//첫자가 -일때 -를 뺀금액으로 처리하고 나중에 -붙임
	var minus = "";
	if(str.substring(0,1) == "-"){
		rtStr = str.substring(1);		// '-' 뺀 문자 저장
		minus = "-";
	}else								// 그외의 모든 경우
		rtStr = str;

	//소수점 있을때 앞부분만 rtStr에 넣어처리하고 뒷부분은 따로 떼 두었다가 나중에 붙임.
	var belowzero = "";
	if (zmChkDot(rtStr)==true){
		arr = rtStr.split(".");
		rtStr = arr[0];		     	//소수점 앞부분
		belowzero = "." + arr[1];   //소수점과 그 뒷부분
	}

	// 기존콤마제거
	rtStr = zsRmString(rtStr, ',');

	var len = rtStr.length ;
	var result ="";

	if (len > 1 && str.substring(0,1)=="0") rtStr = rtStr.substring(1); // 첫번째 0이 있으면 제거

	for (var i=0; i < len;i++){  // 이제 실제로 콤마 표시함
		comma="";
		var schar = rtStr.charAt(i);
		where = len - 1 - i;
		if ((where % 3) == 0 && len > 3 && where != 0) comma = ",";
		result = result +   schar + comma ;
	}
    rtStr = minus + result + belowzero;	// - 와 소수점 이하를 붙임

	return rtStr;
}

// 금액 문자열(str)에 3자리마다 콤마추가한 문자열을 리턴
function zmSetMoneyZero(str){
	var rtStr;	// 리턴할 문자열

	//값이 null이라면 blank
	if ( zcIsNull(str) ) return "";
	//값이 0이면 그대로 0
	if ( str=="0" || str=="0.0") return str;

	//첫자가 -일때 -를 뺀금액으로 처리하고 나중에 -붙임
	var minus = "";
	if(str.substring(0,1) == "-"){
		rtStr = str.substring(1);	// '-' 뺀 문자 저장
		minus = "-";
	}else							// 그외의 모든 경우
		rtStr = str;

	//소수점 있을때 앞부분만 rtStr에 넣어처리하고 뒷부분은 따로 떼 두었다가 나중에 붙임.
	var belowzero = "";
	if (zmChkDot(rtStr)==true){
		arr = rtStr.split(".");
		rtStr = arr[0];		     	//소수점 앞부분
		belowzero = "." + arr[1];   //소수점과 그 뒷부분
	}

	// 기존콤마제거
	rtStr = zsRmString(rtStr, ',');

	var len = rtStr.length ;
	var result ="";

	if (len > 1 && str.substring(0,1)=="0") rtStr = rtStr.substring(1); // 첫번째 0이 있으면 제거

	for (var i=0; i < len;i++){  // 이제 실제로 콤마 표시함
		comma="";
		var schar = rtStr.charAt(i);
		where = len - 1 - i;
		if ((where % 3) == 0 && len > 3 && where != 0) comma = ",";
		result = result +   schar + comma ;
	}
    rtStr = minus + result + belowzero;	// - 와 소수점 이하를 붙임
	return rtStr;
}

// "원"단위 금액(str)을 콤마까지 추가한 "백만" 단위로 변환한 문자열을 리턴(5000900000 => 5,000)
function zmWon2Million(str) {
	//값이 null이라면 blank 리턴
	if(zcIsNull(str)) return "";

	if (zmChkDot(str)==true){	//소수점 이하부분은 삭제함
		arr = str.split(".");
		str = arr[0];			//소수점 앞부분
	}
	var len = str.length;

	if(len > 6){
		var outputDataLen = len - 6; //출력 금액의 자리수 : 표현하는 금액의 단위가 백만원 이므로 000000을 빼기 위해 "전체길이-6"을 한다.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3자리마다 ","를 추가하는 스크립트 호출
		}
		return outputData;
	}else{
		return "0"; //넘어온 데이타가 6자리 이하일 경우 0 뿌림.
	}
}

// "원"단위 금액(str)을 콤마까지 추가한 "백만" 단위로 변환한 문자열을 리턴(5000900000 => 5,000)
function zmWon2MillionZero(str) {
	//값이 null이라면 0 리턴
	if(zcIsNull(str)) return "0";

	if (zmChkDot(str)==true){          //소수점 이하부분은 삭제함
		arr = str.split(".");
		str = arr[0];		     //소수점 앞부분
	}
	var len = str.length;

	if(len > 6){
		var outputDataLen = len - 6; //출력 금액의 자리수 : 표현하는 금액의 단위가 백만원 이므로 000000을 빼기 위해 "전체길이-6"을 한다.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3자리마다 ","를 추가하는 스크립트 호출
		}
		return outputData;
	}else{
		return "0"; //넘어온 데이타가 6자리 이하일 경우 0 뿌림.
	}
}

// "원"단위 금액(str)을 콤마까지 추가한 "천" 단위로 변환한 문자열을 리턴(5000900900 => 5,000,900)
function zmWon2Thousand(str) {
	//값이 null이라면 blank 리턴
	if(zcIsNull(str)) return "";

	if (zmChkDot(str)==true){          //소수점 이하부분은 삭제함
		arr = str.split(".");
		str = arr[0];		     //소수점 앞부분
	}
	var len = str.length;

	if(len > 3){
		var outputDataLen = len - 3; //출력 금액의 자리수 : 표현하는 금액의 단위가 백만원 이므로 000000을 빼기 위해 "전체길이-6"을 한다.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3자리마다 ","를 추가하는 스크립트 호출
		}
		return outputData;
	}else{
		return "0"; //넘어온 데이타가 3자리 이하일 경우 0 뿌림.
	}
}

// "원"단위 금액(str)을 콤마까지 추가한 "천" 단위로 변환한 문자열을 리턴(5000900900 => 5,000,900)
function zm_won2ThousandZero(str) {
	//값이 null이라면 0 리턴
	if(zcIsNull(str)) return "0";

	if (zmChkDot(str)==true){          //소수점 이하부분은 삭제함
		arr = str.split(".");
		str = arr[0];		     //소수점 앞부분
	}
	var len = str.length;

	if(len > 3){
		var outputDataLen = len - 3; //출력 금액의 자리수 : 표현하는 금액의 단위가 백만원 이므로 000000을 빼기 위해 "전체길이-6"을 한다.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3자리마다 ","를 추가하는 스크립트 호출
		}
		return outputData;
	}else{
		return "0"; //넘어온 데이타가 3자리 이하일 경우 0 뿌림.
	}
}

// 금액에 소수점 있는지 체크. 존재한다면 true, 없다면 false
function zmChkDot(str){
	for (var i=0; i< str.length; i++) {
		if(str.charAt(i) == "." )	return true;
	}
	return false;
}


/* =====================================================================================================
   함수명 : zs_xxxx()
   설  명 : Character, String, number 처리(체크/계산은 제외 - check.js에 포함)
========================================================================================================= */

/**
 *  입력된 스트링의 바이트수를 리턴한다.
 *  @val       : 길이를 체크할 스트링
 */
function zsGetBytesLength(val) {
    // 입력받은 문자열을 escape() 를 이용하여 변환한다.
    // 변환한 문자열 중 유니코드(한글 등)는 공통적으로 %uxxxx로 변환된다.
    var temp_estr = escape(val);
    var s_index   = 0;
    var e_index   = 0;
    var temp_str  = "";
    var cnt       = 0;

    // 문자열 중에서 유니코드를 찾아 제거하면서 갯수를 센다.
    while ((e_index = temp_estr.indexOf("%u", s_index)) >= 0)  // 제거할 문자열이 존재한다면
    {
      temp_str += temp_estr.substring(s_index, e_index);
      s_index = e_index + 6;
      cnt ++;
    }

    temp_str += temp_estr.substring(s_index);

    temp_str = unescape(temp_str);  // 원래 문자열로 바꾼다.

    // 유니코드는 2바이트 씩 계산하고 나머지는 1바이트씩 계산한다.
    
    return ((cnt * 2) + temp_str.length) + "";
    
    //return ((cnt * 3) + temp_str.length) + "";
}

/**
 *  입력된 스트링의 바이트수를 체크하여 한계치보다 크면
 *  alert 메세지를 띄운다.
 *  onkeypress 이벤트에 적용한다.
 *  @obj       : 길이를 체크할 객체
 *  @limitLen  : 최대길이
 *  @msgFlag   : alert 메세지 출력여부
 */
function zsGetBytesLengthRT(obj, limitLen, msgFlag) {
    var val = obj.value;
    var leng = zsGetBytesLength(val);
    var result = true;
    var msg = '';

    // 최대길이와 현재 스트링의 바이트수가 같으면.
    if (leng == limitLen) {
        msg = "더 이상 입력하실 수 없습니다.\n\n" +
              "입력하실 수 있는 최대 문자열 길이가 이미 입력되었습니다.";
        result = false;
    }

    if (msgFlag) alert(msg);
    event.returnValue = result;
}

/**
 *  입력된 스트링의 바이트수를 체크하여 한계치보다 크면
 *  alert 메세지를 띄운다.
 *  onblur 이벤트에 적용한다.
 *  @obj       : 길이를 체크할 객체
 *  @limitLen  : 최대길이
 *  @msgFlag   : alert 메세지 출력여부
 */
function zsGetBytesLengthRTBlur(obj, limitLen, msgFlag) {
    var val = obj.value;
    var leng = zsGetBytesLength(val);
    var result = true;
    var msg = '';

    if (leng > limitLen) {
        msg = "입력하실 수 있는 최대 문자열 길이를 초과하였습니다.\n\n" +
              "최대 입력가능 문자열 길이 => " + limitLen + "\n" +
              "입력하신 문자열 길이 => " + leng;
        result = false;
    }

    if (!result) {
        if (msgFlag) alert(msg);
        obj.focus();
    }
}

/**
 *  해당 textarea의 라인수를 리턴합니다.
 *  @sourceObject  textarea 객체
 *  @columnSize    한 line으로 간주할 컬럼 사이즈
 *
 *  @columnSize 가 입력되지 않으면 해당 객체의 cols속성값을 사용합니다.
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

        // 빈 라인일때
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

// input 필드 객체의 값(obj)에서  특정문자(org)를 rep문자로 변환
function zsChgChar(obj,orgStr,repStr){
	str = obj.value;
	re = new RegExp(orgStr, "g");
	obj.value = str.replace(re, repStr);
}

// 폼전체 문자열에 있는 더블쿼테이션(")을 싱클쿼테이션(')으로 변경한다.
function zsDouble2SingleQuatForm(formObj) {
	var len=formObj.elements.length;
	var i=0;

	for ( i=0; i<len; i++ ) {
		formObj.elements[i].value = top.zsDouble2SingleQuat(formObj.elements[i].value);
	}
}
// 더블쿼테이션(")을 싱클쿼테이션(')으로 변경한다.
function zsDouble2SingleQuat(Str) {
	while (true) {
	   if ( Str.indexOf("\"") < 0)
	      break;
	   Str = Str.replace("\"", "'");
	}
	return Str;
}



// RealTime으로 사용자가 숫자를 입력하는순간 .(dot)를 중간에 바로 추가
//	onkeyup 이벤트에 호출하도록 한다!
// gubun : dash 삽입패턴 구분자 문자열
//	"time":시간(시.분.초)
//				*** CustomTag에서 사용하고 있으므로 펑션 변경(특히 펑션명과 gubun)에 주의를 요함!
function zsSetDotRT(obj, gubun) {
	if ( gubun == "time" && (!(event.keyCode == 8 || event.keyCode <= 46)) ) zsSetDot(obj, gubun);
}

// RealTime이 아닌경우에 대해 .(dot)를 중간에 추가해준다
function zsSetDot(obj, gubun) {
	obj.value = zsSetDotStr(obj.value, gubun);
}

// RealTime이 아닌경우에 대해 .(dot)를 중간에 추가한 문자열을 리턴
function zsSetDotStr(str, gubun) {
	var retStr = str;
	data = str.toUpperCase();
	data_1 = zsRmString(data, ".");	// "." 제거

	// 시간 2자.2자.2자 형태로 중간에 .(dot) 삽입
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




// str의 문자열중 rmChar의 특정 문자만 삭제한 문자열을 리턴.
//	rmChar는 길이 1의 문자
function zsRmString(str, rmChar){
	//null이 있다면
	if(zcIsNull(str) || zcIsNull(rmChar)) return false;

	// 한자리의 rmChar인지 체크
	if(rmChar.length != 1){
		alert("[스크립트 사용 오류]\r\n rmStr에는 1자리의 문자만 올 수 있습니다.");
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

// obj의 value 문자열중 rmChar의 특정 문자만 삭제한 문자열을 리턴.
//	rmChar는 길이 1의 문자
function zsRmObj(obj, rmChar){
	str = obj.value;
	//null이 있다면
	if(zcIsNull(str) || zcIsNull(rmChar)) return false;

	// 한자리의 rmChar인지 체크
	if(rmChar.length != 1){
		alert("[스크립트 사용 오류]\r\n rmStr에는 1자리의 문자만 올 수 있습니다.");
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

// input 필드 객체의 값(obj)에서  양쪽 스페이스들 제거
function zsDelRLSpace(obj) {
		str = zsDelLSpace( obj );
		str = zsDelRSpace( obj );
}

// input 필드 객체의 값(obj)에서  왼쪽스페이스들 제거
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

// input 필드 객체의 값(obj)에서 오른쪽 스페이스들 제거
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
   함수명 : zu_xxxx() , 이미지처리부분은 제외 MM_xxxx
   설  명 : 유틸성 스크립트 펑션
========================================================================================================= */

// 오직 숫자만 입력가능하게 만드는 펑션.(onkeypress 이벤트에 호출한다)
function zuInputNumRT(obj){
	var keycode = event.keyCode;

	if( !((48 <= keycode && keycode <=57) || keycode == 13 || keycode == 45) )
		event.keyCode = 0;		// 이벤트 cancel
}

// 폼객체(formObj) 내에 있는 text(read only제외) 박스, radio , single select box 값을 초기화시킨다.
// readonly도 초기화 button skip hidden textarea 초기화 처리 - 2004.08.17
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
	window.defaultStatus = "준비(Ready)";
}

//페이지 모든 입력필드들을 disabled 시킨다.
//bln : boolean type (true비활성,false 활성)
function zuMakeDisable(bln) {
	for (var i=0;i <document.transform.length;i++){
    	document.transform.elements[i].disabled=bln;
    }
}

// 1자리 숫자에 0붙여서 2자리 반환
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
                //~$@#'_- ., + 삭제
                var eng = new String("!%^&()={}[]|?><");
                var t = new String(target);                             
                var tempStr;
                for(i=0;i<t.length;i++) {
                        tempStr = t.substring(i,i+1);
                        //34(") 39(') 92(\)
                        if(eng.indexOf(tempStr) >= 0 || tempStr.charCodeAt(0) ==
 34 || tempStr.charCodeAt(0) == 92) {                                
                             //alert(alertMsg[16]);//"특수문자는 사용할 수 없습니다."
                             alert('특수문자는 사용할 수 없습니다.');
                             return false;
                        }
                }
                return true;
}

// 객체의 존재 유무 return
function chkExist( args ){
	if( args != "undefined" &&  args != "NaN" &&  args != null )
		return true;
	else
		return false;
}


// checkbox의 전체 선택시 전체 변경
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
