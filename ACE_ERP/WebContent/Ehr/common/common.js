/************************************************************************************************************* *
 * Common Function Ver 0.2
 * Date    : 2004.04.01
 * Author : 최재원
 ***************************************************************************************************************
 * History : 2004/04/10 재설계... fcTagIdParse() 구조 변경 (bug fix)
 ***************************************************************************************************************/
   
var MSG_COM_ERR_001   = "[@]은(는) 변경된 사항이 없습니다.";

var MSG_COM_ERR_002   = "[@]은(는) 필수 입력 항목입니다.";

var MSG_COM_ERR_003   = "해당되는 자료가 존재하지 않습니다.";

var MSG_COM_ERR_004   = "[@]은(는) 공백없이 입력하십시오.";

var MSG_COM_ERR_005   = "[@]은(는) [@]cfValidObject 입력하십시오.";

var MSG_COM_ERR_006   = "[@]은(는) [@]부터 [@]사이로 입력하십시오.";

var MSG_COM_ERR_007   = "[@]은(는) 숫자만을 입력하십시오.";

var MSG_COM_ERR_008   = "[@]은(는) 문자만을 입력하십시오.";

var MSG_COM_ERR_009   = "[@]은(는) 숫자와 문자만을 입력하십시오.(공백제외)";

var MSG_COM_ERR_010   = "[@]은(는) 숫자와 문자만을 입력하십시오.(공백포함)";

var MSG_COM_ERR_011   = "[@]은(는) [@]자 이상으로 입력하십시오.";

var MSG_COM_ERR_012   = "[@]은(는) [@]자 이하로 입력하십시오.";

var MSG_COM_ERR_013   = "[@]은(는) [@] 이상으로 입력하십시오.";

var MSG_COM_ERR_014   = "[@]은(는) [@] 이하로 입력하십시오.";

var MSG_COM_ERR_015   = "[@]은(는) [년도]가 잘못되었습니다.";

var MSG_COM_ERR_016   = "[@]은(는) 유효한 주민등록번호가 아닙니다.";

var MSG_COM_ERR_017   = "[@]은(는) 유효한 사업자등록번호가 아닙니다.";

var MSG_COM_ERR_018   = "[@]은(는) 유효한 날짜가 아닙니다.";

var MSG_COM_ERR_019   = "[@]은(는) [월]이 잘못되었습니다.";

var MSG_COM_ERR_020   = "[@]은(는) [일]이 잘못되었습니다.";

var MSG_COM_ERR_021   = "[@]은(는) [시]가 잘못되었습니다.";

var MSG_COM_ERR_022   = "[@]은(는) [분]이 잘못되었습니다.";

var MSG_COM_ERR_023   = "[@]은(는) [초]가 잘못되었습니다.";

var MSG_COM_ERR_025   = "[@]은(는) [@]년 [@]월 [@]일 이후이어야 합니다.";

var MSG_COM_ERR_024   = "[@]은(는) [@]년 [@]월 [@]일 이전이어야 합니다.";

var MSG_COM_ERR_026   = "[@]은(는) '[@]' 형식이어야 합니다.\n" +

                            "  - # : 문자 혹은 숫자\n" +

                            "  - h, H : 한글(H는 공백포함)\n" +

                            "  - A, Z : 문자(Z는 공백포함)\n" +

                            "  - 0, 9 : 숫자(9는 공백포함)";

var MSG_COM_ERR_027   =  "[@]은(는) [@]자리수만큼 입력하십시오. (한글은 [@]자리수)";

var MSG_COM_ERR_028   =  "[@]은(는) [@]자 이상으로 입력하십시오. (한글은 [@]자 이상)";

var MSG_COM_ERR_029   =  "[@]은(는) [@]자 이하로 입력하십시오. (한글은 [@]자 이하)";

var MSG_COM_ERR_030   =  "[@]은(는) ";

var MSG_COM_ERR_031   =  "[@]의 [@]번째 데이터에서 ";

var MSG_COM_ERR_032   =  "[@]은(는) 중복될 수 없습니다.";

var MSG_COM_ERR_033   =  "[@]은(는) 다음 문자가 올 수 없습니다.\n@";

var MSG_COM_ERR_034   =  "페이지 설정이 잘못되었습니다.";

var MSG_COM_ERR_035   =  "[@]페이지 이상은 출력할 수 없습니다";

var MSG_COM_ERR_036   =  "[@]은(는) 다음 문자만 올 수 있습니다.\n@";

var MSG_COM_ERR_037   =  "[@]은(는) 유효한 이메일 주소가 아닙니다.";

var MSG_COM_ERR_038   =  "유효한 [@]가 아닙니다."

var MSG_COM_ERR_039   =  "시작일자를 종료일자 이전으로 선택[입력]하여 주십시오.";

var MSG_COM_ERR_040   =  "패스워드가 일치하지 않습니다.";

var MSG_COM_ERR_041   =  "[@]은(는) [@]할 수 없습니다.";

var MSG_COM_ERR_042   =  "[@]은(는) 변경된 사항이 있습니다. \n변경사항을 저장 후 [@]을(를) 수행하십시오.";

var MSG_COM_ERR_043	  =  "유효하지 않는 [@] 입니다.\n다시 입력하여주십시요";

var MSG_COM_ERR_045   =  "시작범위는 종료범위보다 작아야 합니다. :@";

var MSG_COM_ERR_046   =  "존재하지 않는 [@]입니다.";

var MSG_COM_ERR_047   =  "오류가 발생하였습니다.\n관리자에게 문의하십시오.";

var MSG_COM_ERR_048   =  "[@]은(는) [@]보다 작아야 합니다.";

var MSG_COM_ERR_049   =  "[@]이(가) 존재하지 않습니다.";

var MSG_COM_ERR_050   =  "오류가 발생하였습니다.\n처음부터 다시 시작하여 주십시오.";

var MSG_COM_ERR_051   =  "[@]을(를) 실패하였습니다.";

var MSG_COM_ERR_052   =  "해당조건의 [@]이(가) 존재하지 않습니다.";

var MSG_COM_ERR_053   =  "[@]이(가) 누락되었습니다.";

var MSG_COM_ERR_054   =  "[@] 생성을 실패하였습니다.";

var MSG_COM_ERR_055   =  "[@]을(를) 확인하여 주십시오.";

var MSG_COM_ERR_056   =  "선택된 [@]이(가) 없습니다.";

var MSG_COM_ERR_057   =  "[@]은(는) [@] 보다 큰 값으로 입력하십시오.";

var MSG_COM_ERR_058   =  "시작시간을 종료시간 이전으로 선택[입력]하여 주십시오.";

var MSG_COM_ERR_059   =  "[@]은(는) 정수부를 [@]자 이하로 입력하십시오.";

var MSG_COM_ERR_060   =  "[@]은(는) 소수부를 [@]자 이하로 입력하십시오."


var GLB_DAYS_IN_MONTH       = [31,28,31,30,31,30,31,31,30,31,30,31];

/** 서버의 날짜를 반환받을 변수 **/
var GLS_SYSTEM_DATE = "";


/*************************************************************************
 *	   HTML테그의 Validation확장 테그를 정의표. & 사용법 Ver 0.1
 *************************************************************************
 *		key =  true; false; 필수입력필드검사
 *		type = ENG : 영문자만 입력받음.
 *				  FENG : 첫문자가 반드시 영문자 +나머지(영문/숫자)
 *				  LENG : 영문자 대문자
 *				  SENG : 영문자 소문자
 *				  NUM : 숫자
 *				  ENUM : 영문+숫자
 *				  KOR : 한글/한자(빈공백포함)
 *				  KORENG : 한글과 영문(빈공백포함)
 *      minLength = X : 최소자릿수
 *      minValue  = X : 최소값
 *      maxLength = X : 최대자릿수
 * <예제>
 * <input type=text id=oTest  name="name"  valid="key=true;type=kor">
 *	위의 예제는 필수입력필드이며, 한글한자만 입력받는경우 사용
 *
 * <input type=text id=oTest  name="name"  valid="key=true;type=eng">
 *	위의 예제는 필수입력필드이며, 영어만 입력받는경우 사용
 *
 * <input type=text id=oTest  name="name"  valid="type=num">
 *	위의 예제는 숫자만 입력받는경우 사용
 *
 *  <input type=text id=oTest  name="name"  valid="type=kor"  maxlength=10>
 *  위의 예제는 한글만 입력받으며, 최대 10자인경우 자동 포커스 이동처리
 *
 *  ※ 각 필드의 maxlength속성에 최대값을 지정해 주면 해당 문자의 길이가 되면
 *      자동으로 다음 입력필드로 포커스 이동이 된다.
 *  ※ 포커스 처리는 필드의 속성이 readonly인가 disable되었는가 모두 판단해서
 *      처리됨.. 오류 안남..
 **************************************************************************/


/**
 * @type   : prototype_function
 * @access : public
 * @desc   : String.split() 와 같지만 여러가지 옵션을 줄 수 있다.
 * <pre>
 *     option list
 *
 *     - i : ignored split
 *         구분자 문자 앞에 "\" 가 붙어있을 때는 구분자로 인식하지 않는다. ('\' 문자를 string으로 표현할 때는 "\\" 로 해야함)
 *             var str = "abc,de\\,fg"
 *             var strArr = str.advancedSplit(",", "i");
 *         위의 예에서 strArr[0]는 "abc", strArr[1]는 "de,fg"가 된다.
 *
 *     - t : trimed split
 *         split 후에 splited string 들을 trim 시킨다.
 *             var str = "abc,  de,fg"
 *             var strArr = str.advancedSplit(",", "t");
 *         위의 예에서 strArr[0]는 "abc", strArr[1]는 "de", strArr[2]는 "fg"가 된다.
 * </pre>
 * 옵션들은 복합적으로 사용될 수 있다.
 * <pre>
 *     var str = "abc,  de\\,fg"
 *     var strArr = str.advancedSplit(",", "it");
 * </pre>
 * 위의 예에서 strArr[0]는 "abc", strArr[1]는 "de,fg"가 된다.
 * @sig    : delim, options
 * @param  : delim   required delimenator
 * @param  : options required 옵션을 나타내는 문자들을 나열한 스트링
 * @return : splited string array.
 * @author : 최재원
 */
String.prototype.advancedSplit = function(delim, options) {
	if (options == null || options.trim() == "") {
		return this.split(delim);
	}
	var optionI = false;
	var optionT = false;
	options = options.trim().toUpperCase();
	for (var i = 0; i < options.length; i++) {
		if (options.charAt(i) == 'I') {
			optionI = true;
		} else if (options.charAt(i) == 'T') {
			optionT = true;
		}
	}
	var arr = new Array();
	var cnt = 0;
	var startIdx = 0;
	var delimIdx = -1;
	var str = this;
	var temp = 0;

	while ( (delimIdx = (str == null) ?
	         -1 : str.indexOf(delim, startIdx)
	        ) != -1
	      ) {
		if (optionI && str.substr(delimIdx - 1, 2) == '\\' + delim) {
			str = str.cut(delimIdx - 1, 1);
			startIdx = delimIdx;
			continue;
		}
		arr[cnt++] = optionT ? str.substring(0, delimIdx).trim() :
		                       str.substring(0, delimIdx);
		str = str.substr(delimIdx + 1);
		startIdx = 0;
	}
	arr[cnt] = (str == null) ? "" : str;
	return arr;
}


/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 cut 메소드를 추가한다. cut 메소드는 스트링의 특정 영역을
 *           잘라낸다.
 * <pre>
 *     var str = "abcde"
 *     str = str.cut(2, 2);
 * </pre>
 * 위의 예에서 str는 "abe"가 된다.
 * @sig    : start, length
 * @param  : start  required start index to cut
 * @param  : length required length to cut
 * @return : cutted String.
 * @author : 최재원
 */
String.prototype.cut = function(start, length) {
    return this.substring(0, start) + this.substr(start + length);
}


/*****************************************************************************
 * 숫자에 1000단위 콤마를 찍는 메소드
 *  usage : "10000.15791".toComma() => 10,000.15791
 *  return  : string type
 *****************************************************************************/
String.prototype.toComma = function() {
	if (isNaN(this))
	{
		return 0;
	}
	var result="";
	quotient = new String(this).substring(0, new String(this).indexOf(".") == -1 ? new String(this).length : new String(this).indexOf("."));
	radix = new String(this).substring(new String(this).indexOf(".") == -1 ? new String(this).length : new String(this).indexOf(".")  );

	if (arguments.length == 1) {
		var idx = arguments[0];
		var rst = 1;
		for (j=1; j <= idx; j++) {
			rst = rst * 10;
		}
		radix = radix * 1;
		radix = radix * rst;
		radix = Math.round(radix);
		radix = radix / rst;
		radix =  new String(radix);
		radix = radix.substring(radix.indexOf("."));
	}

	while(true) {
		var remainder = new String(quotient % 1000);
		if (quotient < 1000) return quotient+radix;
		switch (remainder.length) {
			case 1:
				remainder = "00" + remainder;
				break;
			case 2:
				remainder = "0" + remainder;
				break;
		}
		quotient = parseInt(quotient / 1000);
		result = "," + remainder + result;
		if (quotient < 1000) {
			return result = quotient + result + radix;

		}
	}
	return result;
}


/*****************************************************************************
 * 숫자에 1000단위 콤마를 제거하는 메소드
 *  usage : "10,000.15791".toUnComma() => 10000.15791
 *  return  : number type
 *****************************************************************************/
String.prototype.toUnComma = function() {
	var PATTERN = /\,/gi;
	var result = 	this.replace(PATTERN, "");
	return new Number(result);
}


/*****************************************************************************
 * 숫자에 소숫점이 있는경우 지정한 숫자의 소수점 까지 반올림하여 결과를
 * 반환하는 함수.
 *  usage : "10000.15791".toRound() => 10000.15791
 *              "10000.15791".toRound(3) => 10100.158  : 소숫점 3째자리까지 반올림
 *  return  : number type
 *****************************************************************************/
String.prototype.toRound  = function() {
	quotient = new String(this).substring(0, new String(this).indexOf(".") == -1 ? new String(this).length:new String(this).indexOf("."));
	radix = new String(this).substring(new String(this).indexOf(".") == -1 ? new String(this).length : new String(this).indexOf(".")  );

	if (arguments.length == 1) {
		var idx = arguments[0];
		var rst = 1;
		for (j=1; j <= idx; j++) {
			rst = rst * 10;
		}
		radix = radix * 1;
		radix = radix * rst;
		radix = Math.round(radix);
		radix = radix / rst;
		radix =  new String(radix);
		radix = radix.substring(radix.indexOf("."));
	} else {
		return this;
	}
	if (new Number(radix) == 0)
	{
		return new Number(quotient);
	} else {
		return new Number(quotient + radix);
	}
}

var b_msgViewYn = false;			 // 2가지 이벤트에서 Validation를 수행할때 1번만 수행되게 하는 기능을 위해 넣은 flag

/**
 * 빈공백(캐리지리턴, 탭등을 없애기 위한 trim정규식 패턴
 */
var TRIM_PATTERN = /(^\s*)|(\s*$)/g; // 내용의 값을 빈공백을 trim하기 위한것(앞/뒤)
var ALL_TRIM_PATTERN = /\s*/g;		 // 모든값의 공백을 제거.
var GLB_CALENDAR = new Object();
var GLB_GDS = "";
var GLB_ERR_COLID = "";
var GLB_ERR_ROW = -1;

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


/*************************************************************************
 *  String.replaceStr(p_oldstr, p_newstr)
 *  문자를 대치해줄 메소드.
 *************************************************************************
 * Author    : 최재원
 * Date       : 2004.04.12
 * History   : 최초 작성
 * Desc      : 문자를 대치해줄 메소드.
 * Param    : p_oldstr : replace대상 문자열
 *                p_newstr : replace될 문자열
 * Return    : trimAll()된 문자열
 *************************************************************************/
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
 * cfGetMessage(메시지 코드, 대치될 메시지, ... )
 * 지정된 메시지 코드에 해당하는 메시지에 대치될 메시지를 넣어서 메시지를 출력한다.
 *************************************************************************
 * Author    : 최재원
 * Date      : 2004.12.23
 * History   : 최초 작성
 * Desc      : 지정된 메시지 코드에 해당하는 메시지에 대치될 메시지를 넣어서
 *             메시지를 출력한다.
 * Return    : ls_Msg
 *************************************************************************/
function cfGetMessage(p_MsgCd) {
	// 메시지의 최대 대치될 단어 갯수만큼 설정해야됨 0번째값은 사용하지 않음. 단 삭제하면 안됨
	var lsa_MsgArray = ["","[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]", "[10]"];
	var ls_Msg = p_MsgCd;
	var li_ParamSize = arguments.length;

	for (msgIdx = 1; msgIdx < li_ParamSize; msgIdx++) {
		ls_Msg = ls_Msg.replaceStr(lsa_MsgArray[msgIdx], arguments[msgIdx]);
	}
	return ls_Msg;
}


/*************************************************************************
 *  cfTagIdParseToObj(p_obj)
 * 특정 테그의 ID를 지정하여 해당 테그에 속한 객체를 오브젝트에 저장하는 함수.
 *************************************************************************
 * Author    : 최재원
 * Date       : 2004.04.01/04.11
 * History   : 최초 작성
 * Desc      : p_obj로 지정한 테그의 id값을 기준으로 지정된 오브젝트를 파싱하여
 *                오브젝트 타입에 저장
 * Param    : 오브젝트의 ID (div, span, table, form, body등 각테그의 ID)
 * Return    : 해당 오브젝트ID에 속한 오브젝트 List
 *************************************************************************/
function cfTagIdParseToObj(p_obj) {
	var v_objId = null;					// 해당 레이어의 오브젝트 정보가 저장될 오브젝트.

	v_objId = new Object();		// 오브젝트의 ID가 저장될 오브젝트

	// 지정된 테그의 내용을 파싱하는 for루프
	for (i=0; i < p_obj.all.length; i++) {

		if (p_obj.all[i].tagName.toUpperCase() == "INPUT") {		// INPUT테그로 구성된 값을 파싱.
			switch(p_obj.all[i].type.toUpperCase()) {
					case "BUTTON":
						 break;
					case "RADIO":
						eval("v_objId." + p_obj.all[i].name + "=" + "document.all." + p_obj.all[i].name);
						 break;
					case "HIDDEN":
					case "TEXT":
					case "PASSWORD":
					case "CHECKBOX":
					case "FILE":
					case "COMBO":
						if (arguments.length != 2) {
							// && p_obj.all[i].readOnly == false 제거
							if (p_obj.all[i].disabled == false ) {
								try
								{
									eval("v_objId." + p_obj.all[i].name + "=" + "document.all." + p_obj.all[i].name);

								}
								catch (exception)
								{
									try
									{
										eval("v_objId." + p_obj.all[i].id + "=" + "document.all." + p_obj.all[i].id);
									}
									catch (exception)
									{
									}

									// null
								}

							}
						} else if (arguments[1].toLowerCase() == "readonly") {
							// readonly인경우 [cfSetReadOnly()함수에서 사용]
							if (p_obj.all[i].disabled == false) {
								try {
									eval("v_objId." + p_obj.all[i].name + "=" + "document.all." + p_obj.all[i].name);
								} catch (exception) {
									eval("v_objId." + p_obj.all[i].id + "=" + "document.all." + p_obj.all[i].id);

								}
							}
						} else if (arguments[1].toLowerCase() == "disabled") {
							// disabled된 경우 [cfSetDisable()함수에서 사용]
							try
							{
								eval("v_objId." + p_obj.all[i].name + "=" + "document.all." + p_obj.all[i].name);
							} catch (exception) {
								eval("v_objId." + p_obj.all[i].id + "=" + "document.all." + p_obj.all[i].id);
							}

						}
						break;
			}
		}

		// TEXTAREA테그로 구성된 값을 파싱.
		if (p_obj.all[i].tagName.toUpperCase() == "TEXTAREA") {
			try {
				eval("v_objId." + p_obj.all[i].name + "=" + "document.all." + p_obj.all[i].name);
			} catch (exception) {
				try {
					eval("v_objId." + p_obj.all[i].id + "=" + "document.all." + p_obj.all[i].id);
				} catch (exception) {}

			}

		}

		// SELECT테그로 구성된 값을 파싱.
		if (p_obj.all[i].tagName.toUpperCase() == "SELECT") {
			try {

				eval("v_objId." + p_obj.all[i].name + "=" + "document.all." + p_obj.all[i].name);
			} catch (exception) {
				eval("v_objId." + p_obj.all[i].id + "=" + "document.all." + p_obj.all[i].id);
			}

		}

		// Gauce Object로 구성된 값을 파싱
		if (p_obj.all[i].tagName.toUpperCase() == "OBJECT") {

			switch (p_obj.all[i].classid.toUpperCase()) {
					// 럭스 콤보
					case "CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197":
							//p_obj.all[i].InheritColor = "true";
							//p_obj.all[i].className = "luxeCombo";
							eval("v_objId." + p_obj.all[i].id + "=" + "document.all." + p_obj.all[i].id);
							break;
					// EMEdit
					case "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F":
							eval("v_objId." + p_obj.all[i].id + "=" + "document.all." + p_obj.all[i].id);
							p_obj.all[i].InheritColor = "true";
							p_obj.all[i].className = "em";

							break;
			}
		}
	}
	return v_objId;		// 파싱한 오브젝트를 반환
}



/**
 * @type   : Function
 * @access : public
 * @desc   : 한글을 바이트로 계산해서 반환.
 * @sig    : fcKorToLength(p_value)
 * @return : index
 * @author : 최재원
 */
function cfKorToLength(p_value){
	var byteLength = 0;
	if(p_value == null) return 0;
	var escapeChar;
	var y = 0;

	for(y = 0; y < p_value.length; y++) {
		escapeChar = escape(p_value.charAt(y));
		if (escapeChar.length == 1) {
			byteLength ++;
		} else if (escapeChar.indexOf("%u") != -1) {
			byteLength += 2;	// UNICODE로 설정 바꿈 한글 1자 -> 3 Byte
		} else if (escapeChar.indexOf("%") != -1) {
			byteLength += escapeChar.length/3;
		}
	}
	return byteLength;
}

/*************************************************************************
 * cfValidGauceObject(p_obj, b_exeEvent, p_objId);
 * 가우스 오브젝트의 Validation을 수행.
 *************************************************************************
 * author : 최재원
 * date    : 2005/11/16
 * desc   : 지정한 오브젝트에 Validation를 수행하는 함수.
 * param : p_obj      : Validation를 수행할 오브젝트
 *************************************************************************/
function cfValidGauceObject(p_obj, b_exeEvent, p_objId) {

	// 가우스 오브젝트에 대한 Validation
	switch (p_obj.classid.toUpperCase()) {
			// 럭스 콤보
			case "CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197":
				if(p_obj.ValueOfIndex(p_obj.column, p_obj.index) == "" || p_obj.ValueOfIndex(p_obj.column, p_obj.index) == "000") {
					p_obj.style.backgroundColor = "#f7f7e8";
					alert(cfGetMessage(MSG_0006, p_obj.field, p_obj.field));
					p_obj.focus();
					return false;
				}
				break;
			case "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F":
				if (p_obj.text.trim() == "") {
					p_obj.text = "";
					alert(cfGetMessage(MSG_0006, p_obj.field, p_obj.field));
					p_obj.focus();
					return false;
				}
	}
	return true;
}



function cfGetObjectValue(p_obj) {
	if (p_obj.tagName.toUpperCase() == "OBJECT") {
		switch (p_obj.classid.toUpperCase()) {
				// 럭스 콤보
				case "CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197":
					if(p_obj.ValueOfIndex(p_obj.column, p_obj.index) == "" || p_obj.ValueOfIndex(p_obj.column, p_obj.index) == "000") {
						return "";
					} else {
						return p_obj.ValueOfIndex(p_obj.column, p_obj.index);
					}
					break;
				case "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F":
					if (p_obj.text.trim() == "") {
						return "";
					} else {
						return p_obj.text;
					}
					break;
				default :
					return p_obj.value;
		}
	} else {
		return p_obj.value;
	}
}

/*************************************************************************
 * cfValidObject(p_obj, b_exeEvent);
 * 지정된 오브젝트의 Validation을 수행.
 *************************************************************************
 * author : 최재원
 * date    : 2004/04/07
 * desc   : 지정한 오브젝트에 Validation를 수행하는 함수.
 * param : p_obj      : Validation를 수행할 오브젝트
 *************************************************************************/
var GLB_OR_VALID = false;
var GLB_OR_YN = false;
var GLB_FIELD_LIST = "";
var GLB_FIRST_OBJ = null;
function cfValidObject(p_obj, b_exeEvent, p_objId) {
	// 오브젝트의 valid속성이 지정된 경우 처리.

	// 모든 파일에 대해서 중국어 입력 방지
	/*
	try  {
		if (p_obj.type.toUpperCase() == "FILE") {
			if(!cfUniCodeRange(p_obj.value)) {
				alert(MSG_0020);
				return false;
			}
		}
	}	catch (exception)	{	} */

	if (p_obj.valid != null) {
		var VALID_EXP = p_obj.valid.replace(ALL_TRIM_PATTERN, "");					// Validation검증용 테그 ALL_TRIM처리.

		//if (p_obj.tagName.toUpperCase() != "OBJECT") {
				var temp_value = cfGetObjectValue(p_obj);
				// HTML인 경우 처리.
				var VALID_VALUE = temp_value.replace(TRIM_PATTERN, "");					// Validation해야할 값 TRIM처리.
				VALID_VALUE = VALID_VALUE.replaceStr("-", "");
				var MAX = VALID_VALUE.length;															//  Validation해야할 값의 길이.

				// 여러가지 패턴 정의 : 정규식 패턴
				var FENG_PATTERN = "/(^[a-zA-Z][A-Za-z0-9]{" + (MAX-1) + "})/";		// 첫문자가 반드시 영문자.
				var ENUM_PATTERN = "/[a-zA-Z0-9]{" + MAX + "}/g";					// 영문자 + 숫자
				var FILENAME_PATTERN = "/[\\040\\041\\043-\\051\\053-\\056\\060-\\072\\073\\075\\100-\\176]{" + MAX + "}/g";
				var NUM_PATTERN = "/[0-9]{" + MAX + "}/";							// 숫자
				var ENG_PATTERN = "/[a-zA-Z]{" + MAX + "}/";						// 영문자(대소문자만 허용)
				var LENG_PATTERN = "/[A-Z]{" + MAX + "}/";							// 영문자 대문자
				var SENG_PATTERN = "/[a-z]{" + MAX + "}/";							// 영문자 소문자
				var KOR_PATTERN = "/[^\\041-\\177]{" + MAX + "}/";					// 한글여부
				var KOR_ENG_PATTERN = "/[^\\041-\\054\\056-\\057\\072-\\100\\133-\\140\\173-\\177]{" + MAX + "}/";		// 한글 영문 패턴
				var ZIPCD_PATTERN = "/([0-9]{3})-([0-9]{3})/";									// 우편번호 검증용패턴
				var SSN_PATTERN = "/([0-9]{6})([0-9]{7})/";									// 주민등록번호 검증용 패턴(EMEdit적용으로 의미 없음)
				var DATE_PATTERN = "/([1-9][0-9]{3})([0-1][0-9])([0-3][0-9])/";				// 날짜 검증용 패턴.
		//} else {
		//	return cfValidGauceObject(p_obj, b_exeEvent, p_objId);
		//}

		var valueSplit = VALID_EXP.split(";");
		var PATTERN = "";
		var errorMsg = "";

		for (i=0; i < valueSplit.length; i++) {	// start for #1

			var valid_attribute = valueSplit[i].substring(0, valueSplit[i].indexOf("=")).toUpperCase();				// Valid테그의 속성명.
			var valid_attribute_value = valueSplit[i].substring(valueSplit[i].indexOf("=")+1).toUpperCase();		// Valid테그의 속성값.


			switch(valid_attribute) {	// start switch #2
				case "MAXLENGTH":
						var temp_value = cfGetObjectValue(p_obj);
						if (valid_attribute_value < cfKorToLength(temp_value)) {
							alert(cfGetMessage(MSG_0001, p_obj.field, valid_attribute_value));
							//alert("[" + p_obj.field + "] 는(은) 영문/숫자기준으로 [" + valid_attribute_value + "] 자까지 입력가능합니다.\n다시 입력해주세요");
							p_obj.focus();
							return false;
						}
						break;
				case "MINLENGTH":
						var temp_value = cfGetObjectValue(p_obj);
						if (temp_value.trim() == "") {
							return true;
						} else if (valid_attribute_value > cfKorToLength(temp_value)) {
							alert(cfGetMessage(MSG_0002, p_obj.field, valid_attribute_value));
							//alert("[" + p_obj.field + "] 는(은) 영문/숫자 기준으로 최소 [" + valid_attribute_value + "] 자이상 입력하세요.");
							p_obj.focus();
							return false;
						}
						break;
				case "MINVALUE":
						var temp_value = cfGetObjectValue(p_obj);
						if (valid_attribute_value > temp_value) {
							alert(cfGetMessage(MSG_0003, p_obj.field, valid_attribute_value));
							//alert("[" + p_obj.field + "] 입력값이 [" + valid_attribute_value + "] 이상(이후)이어야 합니다.");
							p_obj.focus();
							return false;
						}
						break;
				case "MAXVALUE":
						var temp_value = cfGetObjectValue(p_obj);
						if (VALID_EXP.toUpperCase().indexOf("NUM") != -1) {
							if (valid_attribute_value*1 < temp_value*1) {
								alert(cfGetMessage(MSG_0021, p_obj.field, valid_attribute_value));
								//alert("[" + p_obj.field + "] 입력값이 [" + valid_attribute_value + "] 이상(이후)이어야 합니다.");
								p_obj.focus();
								return false;
							}
						} else {
							var temp_value = cfGetObjectValue(p_obj);
							if (valid_attribute_value < temp_value) {
								alert(cfGetMessage(MSG_0021, p_obj.field, valid_attribute_value));
								//alert("[" + p_obj.field + "] 입력값이 [" + valid_attribute_value + "] 이상(이후)이어야 합니다.");
								p_obj.focus();
								return false;
							}
						}
						break;
				case "FIXLENGTH":
						var temp_value = cfGetObjectValue(p_obj);
						if (temp_value.trim() == "") {
							go_obj = p_obj;
							return true;
						} else if (valid_attribute_value != cfKorToLength(temp_value.trim())) {
							alert(cfGetMessage(MSG_0004, p_obj.field, valid_attribute_value));
							//alert("[" + p_obj.field + "] 는(은) [" + valid_attribute_value + "] 자리로 입력해주세요.");
							p_obj.focus();
							return false;
						}
						break;
				case "ISNUMBER":
						var temp_value = cfGetObjectValue(p_obj);
						if (isNaN(temp_value)) {
							alert(cfGetMessage(MSG_0005, p_obj.field, valid_attribute_value));
							//alert("[" + p_obj.field + "] 는(은) 숫자로 입력해주세요.");
							p_obj.focus();
							return false;
						}
						break;
				case "KEY":
						if(p_obj.type == "select-multiple") {
							if (p_obj.length == 0) {
								b_msgViewYn = false;
							} else {
								break;
							}
						}

						// 일반 HTML테그 오브젝트
						if (valid_attribute_value == "TRUE" && MAX <= 0 && b_exeEvent != true) {
							if (!b_msgViewYn) {
								p_obj.style.backgroundColor = "#f7f7e8";
								alert(cfGetMessage(MSG_0006, p_obj.field, p_obj.field));
//								alert("[" + p_obj.field +"] 는(은) 필수입력 항목입니다.\n[" + p_obj.field + "] 를(을) 입력해 주세요.");
								p_obj.focus();
								b_msgViewYn = false;
							}
							p_obj.focus();
							return false;
						} else if (valid_attribute_value == "TRUE" && MAX > 0 ) {
							if (p_obj.type == "checkbox" && p_obj.checked == false) {
								p_obj.style.backgroundColor = "#f7f7e8";
								alert(cfGetMessage(MSG_0006, p_obj.field, p_obj.field));
								//alert("[" + p_obj.field +"] 는(은) 필수입력 항목입니다.\n[" + p_obj.field + "] 를(을) 입력해 주세요.");
								p_obj.focus();
								b_msgViewYn = false;
								return false;
							} else if (p_obj.type == "checkbox") {
								break;
							}
							//return true;
						} else if (valid_attribute_value == "OR") {

							GLB_FIELD_LIST += p_obj.field + " ";
							if (GLB_OR_VALID == false) {
								GLB_FIRST_OBJ = p_obj;
							}

							GLB_OR_VALID = true;
							if (MAX > 0 && GLB_OR_YN == false) {
								GLB_OR_YN = true;
							}
						}
						break;
				case "TYPE":
						var b_valid = true;
						switch(valid_attribute_value) {
							case "ENG":
									PATTERN = eval(ENG_PATTERN);
									errorMsg = cfGetMessage(MSG_0007, p_obj.field);
									//errorMsg = "[" + p_obj.field + "]는(은) 영문자만 입력 가능합니다.";
									break;

							case "FENG":
									PATTERN = eval(FENG_PATTERN);
									errorMsg = cfGetMessage(MSG_0008, p_obj.field);
									//errorMsg = "[" + p_obj.field + "]는(은) 첫글자는 반드시 영문자이어야 하며,\n영문자(대/소문자)와 숫자만 사용가능합니다.";
									break;

							case "LENG":
									PATTERN = eval(LENG_PATTERN);
									errorMsg = cfGetMessage(MSG_0009, p_obj.field);
									//errorMsg = "[" + p_obj.field + "]는(은) 대문자만 사용가능합니다.";
									break;

							case "SENG":
									PATTERN = eval(SENG_PATTERN);
									errorMsg = cfGetMessage(MSG_0010, p_obj.field);
									//errorMsg = "[" + p_obj.field + "]는(은) 소문자만 사용가능합니다.";
									break;

							case "NUM":
									var temp_value = cfGetObjectValue(p_obj);
									if(isNaN(temp_value)) {
										PATTERN = eval(NUM_PATTERN);
										errorMsg = cfGetMessage(MSG_0011, p_obj.field);
										alert(errorMsg);
										p_obj.select();
										return false;
									} else {
										b_valid = false;
									}
									break;

							case "ENUM":
									PATTERN = eval(ENUM_PATTERN);
									errorMsg = cfGetMessage(MSG_0012, p_obj.field);
									//errorMsg = "[" + p_obj.field + "]는(은) 영문자(대/소문자)와 숫자만 사용가능합니다.";
									break;

							case "KOR":
									PATTERN = eval(KOR_PATTERN);
									errorMsg = cfGetMessage(MSG_0013, p_obj.field);
									//errorMsg = "[" + p_obj.field + "]는(은) 한글만 사용가능합니다.";
									break;
							case "KORENG":
									PATTERN = eval(KOR_ENG_PATTERN);
									errorMsg = cfGetMessage(MSG_0014, p_obj.field);
									//errorMsg = "[" + p_obj.field + "]는(은) 한글/영문만 사용가능합니다.";
									break;
							case "ZIPCD":
									PATTERN = eval(ZIPCD_PATTERN);
									errorMsg = cfGetMessage(MSG_0015, p_obj.field);
									//errorMsg = "[" + p_obj.field + "]는(은) 우편번호는 000-000와 같은 형식이어야 합니다.";
									break;
							case "DATE":
									var temp_value = cfGetObjectValue(p_obj);
									if (temp_value != "") {
										PATTERN = eval(DATE_PATTERN);
										errorMsg = cfGetMessage(MSG_0016, p_obj.field);
										//errorMsg = "[" + p_obj.field +"] 의 날짜 형식 또는 날짜가 잘못 입력되었습니다.\n날짜는 YYYY-MM-DD와 같은 형식이어야 합니다.";
									} else {
										b_valid = false;
									}
									break;
							case "CSN" :	// 사업자 등록번호
									PATTERN = eval(NUM_PATTERN);
									var temp_value = cfGetObjectValue(p_obj);
									if (!cfCsnValid(temp_value)) {
										errorMsg = cfGetMessage(MSG_0022, p_obj.field);
										alert(errorMsg);
										try {
											p_obj.select();
										} catch (exception) {
											p_obj.focus();
										}
										return false;
									} else {
										b_vaild = false;
									}
									break;
							case "SSN" :	// 주민등록번호
									PATTERN = eval(SSN_PATTERN);
									errorMsg = cfGetMessage(MSG_0025);
									var temp_value = cfGetObjectValue(p_obj);
									if (temp_value.trim() == "" || p_obj.ignore == temp_value.substring(0,6)) {
										b_valid = false;
									} else {
										b_valid = true;
									}

									break;
							case "RANGE":
							case "MONTH_RANGE":
							case "2MONTH_RANGE":
							case "4MONTH_RANGE":
									errorMsg = cfGetMessage(MSG_0017, go_obj.field, p_obj.field);	//errorMsg = "[" + go_obj.field +"] 는 [" + p_obj.field + "] 보다 작아야 합니다.";
									b_valid = false;
									break;


							default:
									b_valid = false;
									break;

							}

							if (b_valid) {	// false : 이외의 조건에 대해서는 검사하지 않음.
								if (!PATTERN.test(VALID_VALUE)) {
									if (!b_msgViewYn) {
										b_msgViewYn = true;
										p_obj.style.backgroundColor = "#f7f7e8";
										p_obj.focus();
										alert(errorMsg)		// 에러 메시지 뿌린다.
										b_msgViewYn = false;
									}

									return false;		// validation에 실패한경우 false반환
								} else {
									var temp_value = cfGetObjectValue(p_obj);
									// 주민등록번호에 대한 Validation수행
									if (valid_attribute_value == "SSN") {
										if (!cfSsnValid(temp_value.replaceStr("-", ""), p_obj)) {
											errorMsg = cfGetMessage(MSG_0025);
											alert(errorMsg);
											try {
												p_obj.select();
											} catch (exception) {
												p_obj.focus();
											}

											return false;
										}
									}


									if (valid_attribute_value == "DATE" && temp_value != "") {
										if (!cfDateExpr(temp_value)) {
											b_msgViewYn = true;
											p_obj.style.backgroundColor = "#f7f7e8";
											p_obj.focus();
											alert(errorMsg);		// 에러 메시지 뿌린다.
											b_msgViewYn = false;
											return false;		// validation에 실패한경우 false반환
										}

										// 현재일 기준으로 특정 기간 제한 Validation
										if (typeof(p_obj.after) != "undefined") {
											var temp = p_obj.current_date.replaceStr('-', '');
											if (cfDateDiff(temp_value.replaceStr('-', ''), temp) > p_obj.after) {
													errorMsg = cfGetMessage(MSG_0024, p_obj.after);
													alert(errorMsg);
													try {
														p_obj.select();
													} catch (exception) {
														p_obj.focus();
													}

													return false;
												}
											} else if (typeof(p_obj.before_date) != "undefined") {
												var temp = p_obj.before_date.replaceStr('-', '');

												if (cfDateDiff(temp, temp_value.replaceStr('-', '')) >= 0 ) {
													errorMsg = cfGetMessage(MSG_0026,  p_obj.field, p_obj.before_date);
													alert(errorMsg);
													try {
														p_obj.select();
													} catch (exception) {
														p_obj.focus();
													}

													return false;
												}
											}
										}
									}
								}



								var temp_value = cfGetObjectValue(p_obj);
								temp_value = temp_value.replaceStr("-", "");

								if (valid_attribute_value == "MONTH_RANGE") {
									var old_value = cfGetObjectValue(go_obj);
									old_value = old_value.replaceStr("-", "");
									if ( (old_value == "" && temp_value == "" ) || (old_value != "" && temp_value != "" )) {
										if (old_value.indexOf(",") == -1) {
											if (old_value > temp_value) {
												alert(errorMsg);
												try {
													p_obj.focus();
												} catch (exception) {
													go_obj.focus();
												}
												b_msgViewYn = false;
												return false;		// validation에 실패한경우 false반환
											}
										} else {
											if (old_value.toUnComma() > temp_value.toUnComma()) {
												try {
													p_obj.focus();
												} catch (exception) {
													go_obj.focus();
												}
												alert(errorMsg);
												b_msgViewYn = false;
												return false;		// validation에 실패한경우 false반환
											}
										}


										if (old_value.substring(0,6) != temp_value.substring(0,6)) {
											alert(cfGetMessage(MSG_0027, go_obj.field, p_obj.field));
											go_obj.focus();
											return false;
										}

									} else if (old_value == "") {
										alert(cfGetMessage(MSG_0019, go_obj.field));
										go_obj.focus();
										return false;
									} else {
										alert(cfGetMessage(MSG_0019, p_obj.field));
										p_obj.focus();
										return false;
									}
								}

								if (valid_attribute_value == "4MONTH_RANGE") {
									var old_value = cfGetObjectValue(go_obj);
									old_value = old_value.replaceStr("-", "");
									if ( (old_value == "" && temp_value == "" ) || (old_value != "" && temp_value != "" )) {
										if (old_value.indexOf(",") == -1) {
											if (old_value > temp_value) {
												alert(errorMsg);
												try {
													p_obj.focus();
												} catch (exception) {
													go_obj.focus();
												}
												b_msgViewYn = false;
												return false;		// validation에 실패한경우 false반환
											}
										} else {
											if (old_value.toUnComma() > temp_value.toUnComma()) {
												try {
													p_obj.focus();
												} catch (exception) {
													go_obj.focus();
												}
												alert(errorMsg);
												b_msgViewYn = false;
												return false;		// validation에 실패한경우 false반환
											}
										}


										var st = old_value;
										var ed = temp_value;
										var sy = st.substring(0,4);
										var ey = ed.substring(0,4);
										var sm = st.substring(4,6);
										var em = ed.substring(4,6);
										var month = ((ey - sy)*12) + (em-sm)+1;
										if (month> 4) {
											alert(cfGetMessage(MSG_0028, go_obj.field, p_obj.field, month));
											go_obj.focus();
											return false;
										}

									} else if (old_value == "") {
										alert(cfGetMessage(MSG_0019, go_obj.field));
										go_obj.focus();
										return false;
									} else {
										alert(cfGetMessage(MSG_0019, p_obj.field));
										p_obj.focus();
										return false;
									}
								}

								if (valid_attribute_value == "2MONTH_RANGE") {
									var old_value = cfGetObjectValue(go_obj);
									old_value = old_value.replaceStr("-", "");
									if ( (old_value == "" && temp_value == "" ) || (old_value != "" && temp_value != "" )) {
										if (old_value.indexOf(",") == -1) {
											if (old_value > temp_value) {
												alert(errorMsg);
												try {
													p_obj.focus();
												} catch (exception) {
													go_obj.focus();
												}
												b_msgViewYn = false;
												return false;		// validation에 실패한경우 false반환
											}
										} else {
											if (old_value.toUnComma() > temp_value.toUnComma()) {
												try {
													p_obj.focus();
												} catch (exception) {
													go_obj.focus();
												}
												alert(errorMsg);
												b_msgViewYn = false;
												return false;		// validation에 실패한경우 false반환
											}
										}


										var st = old_value;
										var ed = temp_value;
										var sy = st.substring(0,4);
										var ey = ed.substring(0,4);
										var sm = st.substring(4,6);
										var em = ed.substring(4,6);
										var month = ((ey - sy)*12) + (em-sm)+1;
										if (month> 2) {
											alert(cfGetMessage(MSG_0029, go_obj.field, p_obj.field, month));
											go_obj.focus();
											return false;
										}

									} else if (old_value == "") {
										alert(cfGetMessage(MSG_0019, go_obj.field));
										go_obj.focus();
										return false;
									} else {
										alert(cfGetMessage(MSG_0019, p_obj.field));
										p_obj.focus();
										return false;
									}
								}

								if (valid_attribute_value == "RANGE") {
									var old_value = cfGetObjectValue(go_obj);
									old_value = old_value.replaceStr("-", "");
									if ( (old_value == "" && temp_value == "" ) || (old_value != "" && temp_value != "" )) {
										if (old_value.indexOf(",") == -1) {
											if (old_value > temp_value) {
												alert(errorMsg);
												try {
													p_obj.focus();
												} catch (exception) {
													go_obj.focus();
												}
												b_msgViewYn = false;
												return false;		// validation에 실패한경우 false반환
											}
										} else {
											if (old_value.toUnComma() > temp_value.toUnComma()) {
												try {
													p_obj.focus();
												} catch (exception) {
													go_obj.focus();
												}
												errorMsg = cfGetMessage(MSG_0026,  p_obj.field, p_obj.before_date);
												alert(errorMsg);
												b_msgViewYn = false;
												return false;		// validation에 실패한경우 false반환
											}
										}

										if (typeof(p_obj.interval) != "undefined") {
											if (p_obj.interval < cfDateDiff(old_value.replaceStr('-', ''), temp_value.replaceStr('-', ''))) {
												alert(cfGetMessage(MSG_0023, go_obj.field, p_obj.field, p_obj.interval));
												return false;
											}
										}
									} else if (old_value == "") {
										alert(cfGetMessage(MSG_0019, go_obj.field));
										go_obj.focus();
										return false;
									} else {
										alert(cfGetMessage(MSG_0019, p_obj.field));
										p_obj.focus();
										return false;
									}
								}
								break;


							//
			}	// end switch #2

		}	// end for #1
		go_obj = p_obj;
		return true;

	} else {

		// RADIO인 경우 처리.
		if (p_obj.length >= 2 && p_obj[0].valid != null) {

			var VALID_EXP = p_obj[0].valid.replace(ALL_TRIM_PATTERN, "");	// Validation검증용 테그 ALL_TRIM처리.
	        var valueSplit = VALID_EXP.split(";");
			var valid_attribute = valueSplit[0].substring(0, valueSplit[0].indexOf("=")).toUpperCase();	// Valid테그의 속성명.
			var valid_attribute_value = valueSplit[0].substring(valueSplit[0].indexOf("=")+1).toUpperCase(); // Valid테그의 속성값.
			if (valid_attribute == "KEY") {
				if (valid_attribute_value == "TRUE") {
					for (i=0; i < p_obj.length; i++) {
						if (p_obj[i].checked == true) {
							return true;
						}
					}
					alert(cfGetMessage(MSG_0018, p_obj[0].field));
					//alert("[" + p_obj[0].field + "] 을(를) 선택해 주십시오.");
					p_obj[0].focus();
					return false;
				}
			}


		}



		// valid옵션이 없는 경우.
		if (p_obj.type=="text") return true;	// 엔터키를 쳤을 경우 true
	}
}




function cfValidLength(p_obj, b_exeEvent, p_objId) {

	// 오브젝트의 valid속성이 지정된 경우 처리.
	// 모든 파일에 대해서 중국어 입력 방지
	try  {
		if (p_obj.type.toUpperCase() == "FILE")
		{
/*
			if(!cfUniCodeRange(p_obj.value)) {
				alert(MSG_0020);
				return false;
			}*/

		}
	}	catch (exception)	{	}

	if (p_obj.valid != null) {
		var VALID_EXP = p_obj.valid.replace(ALL_TRIM_PATTERN, "");					// Validation검증용 테그 ALL_TRIM처리.

		if (p_obj.tagName.toUpperCase() != "OBJECT") {
				// HTML인 경우 처리.
				var VALID_VALUE = p_obj.value.replace(TRIM_PATTERN, "");					// Validation해야할 값 TRIM처리.
				VALID_VALUE = VALID_VALUE.replaceStr("-", "");
				var MAX = VALID_VALUE.length;															//  Validation해야할 값의 길이.
		}

		var valueSplit = VALID_EXP.split(";");
		var PATTERN = "";
		var errorMsg = "";


		for (i=0; i < valueSplit.length; i++) {	// start for #1

			var valid_attribute = valueSplit[i].substring(0, valueSplit[i].indexOf("=")).toUpperCase();				// Valid테그의 속성명.
			var valid_attribute_value = valueSplit[i].substring(valueSplit[i].indexOf("=")+1).toUpperCase();		// Valid테그의 속성값.

			switch(valid_attribute) {	// start switch #2
				case "MAXLENGTH":
						if (valid_attribute_value < cfKorToLength(p_obj.value))
						{
							alert(cfGetMessage(MSG_0001, p_obj.field, valid_attribute_value));
							//alert("[" + p_obj.field + "] 는(은) 영문/숫자기준으로 [" + valid_attribute_value + "] 자까지 입력가능합니다.\n다시 입력해주세요");
							p_obj.focus();
							return false;
						}
						break;

				case "TYPE":
						var b_valid = true;
						switch(valid_attribute_value) {
							case "DATE":
									if (10 < cfKorToLength(p_obj.value))
									{
										alert(cfGetMessage(MSG_0001, p_obj.field, valid_attribute_value));
										//alert("[" + p_obj.field + "] 는(은) 영문/숫자기준으로 [" + valid_attribute_value + "] 자까지 입력가능합니다.\n다시 입력해주세요");
										p_obj.focus();
										return false;
									}
									break;
							default:
									b_valid = false;
									break;

							}
							break;


							//
			}	// end switch #2

		}	// end for #1
		go_obj = p_obj;
		return true;

	} else {
		// valid옵션이 없는 경우.
		if (p_obj.type=="text") return true;	// 엔터키를 쳤을 경우 true
	}
}


/*************************************************************************
 * cfRadioChk(p_obj, p_obj_name);
 * 라디오버튼의 Validation을 수행한다.
 *************************************************************************
 * author : 최재원
 * date    : 2004/04/10
 * desc   : 지정한 라디오 버튼이 체크되어 있는지 Validation를 수행하는 함수.
 * param : p_obj           : Validation를 수행할 오브젝트
 *             p_obj_name : 라디오버튼의 명(name속성)
 *************************************************************************/
function cfRadioChk(p_obj, p_obj_name) {
	var comboObj = new Array();
	var idx = 0;
	var b_return = false;
	for (i in p_obj) {

		if (p_obj[i].type == "radio" ) {
			comboObj[idx++] = p_obj[i];	// 라디오버튼인 경우 해당 라디오 버튼만 골라서 저장.
		}
	}

	for (k=0; k<comboObj.length; k++) {
		if (comboObj[k].name == p_obj_name) {
			if (comboObj[k].checked == true) {
				b_return = true;
				break;	// 하나라도 체크되어있으면 루프를 벗어난다.
			}
		} else {
			b_return = false;
		}
	}
	return b_return;
}


/*************************************************************************
 * cfSetNextFocus(p_objId, p_obj, b_exeEvent)
 * 특정 테그의 ID안에 Valiation결과에 따라 자동으로 포커스 이동 기능의 함수
 *************************************************************************
 * Author    : 최재원
 * Date       : 2004.04.09
 * History   : 최초 작성
 * Desc      : auto focus & validation
 * Param    : p_objId : div/span/form등의 id값
 *                obj : 오브젝트가들어있는 레이어(div/table/span등등)
 *                b_exeEvent : 특정 이벤트에서 이벤트 동작 제어 onblur이벤트에서 false유지해야됨!!
 *                bool : true/false (true:readonly, false:normal)
 *************************************************************************/
function cfSetNextFocus(p_objId, p_obj, b_exeEvent) {
	if (event.keyCode == 9) return;	// 탭키로 포커스 받은 경우 메시지 출력하지 않음.
	var v_obj = cfTagIdParseToObj(p_objId);

	var b_next = false;

	for (i in v_obj) {	// Start For #1

		if (b_next) {
			if (p_obj.type == "radio" && v_obj[i].type != "radio") {
				v_obj[i].focus();
				return;
			} else if (p_obj.type != "radio"){
				v_obj[i].focus();	 // 실질적인 포커스 이동 처리를 한다.
				return;

			}

		}

		if (v_obj[i].id == p_obj.id)	 {	// Start IF #2 : Validation할 객체를 찾으면...

			// 입력필드에서 엔터키를 입력한 경우 처리.
			if (event.keyCode == 13 && p_obj.type == "text") {	// Start IF #1
				b_next= true;
			} else {
				// 오브젝트 타입에 따라 포커스 이동처리
				switch (p_obj.type) {		// Start switch #1
						case "text":
								if (cfValidObject(p_obj, b_exeEvent, p_objId)) b_next = true;
									else b_next = false;

								if (typeof(p_obj.maxLength) != "undefined" && p_obj.maxLength != "2147483647") {
									objLength =  p_obj.maxLength;
								} else if (typeof(p_obj.size) != "undefined") {
									objLength =  p_obj.size;
								}

								if (objLength == p_obj.value.length) {
									b_next = true;
								} else {
									b_next = false;
								}

								break;
						case "radio":

								if (cfValidObject(p_obj, b_exeEvent, p_objId)) {
									b_next = true;
								} else {
									b_next = false;
								}
								break;
						case "select-one":

								if (cfValidObject(p_obj, b_exeEvent, p_objId)) {
									b_next = true;
								} else {
									b_next = false;
								}
								break;
						case "checkbox":
								b_next = true;
								break;
						case "textarea":
								if (cfValidObject(p_obj, b_exeEvent, p_objId)) {
//										b_next = true;
								} else {
									b_next = false;
								}
//									if (event.keyCode == 13) b_next =true;
								break;
						default:
								break;
				}	// End switch #1
			}	// End IF #1
		}	// End IF #2
	} // End for #1

}

/*************************************************************************
 * valid(p_objId);
 *************************************************************************
 * author : 최재원
 * date    : 2004/04/07
 *           2004/12/24 (Multi오브젝트 Validation)
 * desc   : 지정한 오브젝트 id에 속한 오브젝트 Validation를 수행하는 함수.
 * param : p_objId      : (테이블, DIV, SPAN등의 레이어관련 ID) 오브젝트
 *************************************************************************/
var go_obj = null;
function valid(p_objId) {
	GLB_OR_VALID = false;
	GLB_OR_YN = false;
	var v_obj_valid =	cfTagIdParseToObj(p_objId);
	var temp_valid = v_obj_valid;
	if (arguments.length == 2)	{
		// 필드 길이만 체크 (임시저장용)
		for (i in v_obj_valid) {
			if(!temp_valid[i].disabled) {
				if((typeof(temp_valid[i].type) == "undefined")) {
					var obj = temp_valid[i];
					if (obj[0].type == "radio" && obj[0].disabled != true) {

						if(cfValidLength(temp_valid[i], false, p_objId) == false) {
							GLB_FIELD_LIST = "";
							return false;
						}
					} else if (obj[0].type == "textarea") {
						for (x=0; x<obj.length; x++) {
							if(cfValidLength(obj[x], false, p_objId) == false) {
								GLB_FIELD_LIST = "";
								return false;
							}
						}
					}
				} else {
					if(cfValidLength(temp_valid[i], false, p_objId) == false) {
						GLB_FIELD_LIST = "";
						return false;
					}
				}
			}
		}
		return true;	 // 모든 오브젝트에 대한 Validation에 성공한 경우.
	} else {
		// Validation수행.
		for (i in v_obj_valid) {

			if(!temp_valid[i].disabled) {
				if((typeof(temp_valid[i].type) == "undefined")) {
					var obj = temp_valid[i];
					if (obj[0].type == "radio" && obj[0].disabled != true) {

						if(cfValidObject(temp_valid[i], false, p_objId) == false) {
							GLB_FIELD_LIST = "";
							return false;
						}
					} else if (obj[0].type == "textarea" || obj[0].type == "text" || obj[0].type =="select-one") {	// Multi Row Validation
						for (x=0; x<obj.length; x++) {
							if(cfValidObject(obj[x], false, p_objId) == false) {
								GLB_FIELD_LIST = "";
								return false;
							}
						}
					}
				} else {
					if (temp_valid[i].Enable != false) {
						if(cfValidObject(temp_valid[i], false, p_objId) == false) {
							GLB_FIELD_LIST = "";
							return false;
						}
					}
				}

			}
		}
		if (!GLB_OR_YN && GLB_OR_VALID)
		{
			var temp = GLB_FIELD_LIST.trim().replaceStr(" ", ",");
			alert("[" + temp + "] 중에 하나는 반드시 입력하셔야 합니다.");
			GLB_FIRST_OBJ.focus();
			GLB_OR_VALID = false;
			GLB_OR_YN = false;
			GLB_FIELD_LIST = "";
			GLB_FIRST_OBJ = null;
			return false;
		} else {

			GLB_OR_VALID = false;
			GLB_OR_YN = false;
			GLB_FIELD_LIST = "";
			GLB_FIRST_OBJ = null;
		}
		return true;	 // 모든 오브젝트에 대한 Validation에 성공한 경우.
	}
}



/*************************************************************************
 * 특정 테그의 ID를 지정하여 해당 테그에 속한 객체를 ReadOnly로 바꾸는 함수
 * cfSetReadOnly(obj, bool)
 *************************************************************************
 * Author    : 최재원
 * Date       : 2004.04.07
 * History   : 최초 작성
 * Desc      : readonly set function
 * Param    : obj : 오브젝트가들어있는 레이어(div/table/span등등)
 *                bool : true/false (true:readonly, false:normal)
 *************************************************************************/
function cfSetReadOnly(obj, bool) {
	var result = cfTagIdParseToObj(obj, "readonly");
	for (i in result) {
		result[i].readOnly= bool;
	}
}




/*************************************************************************
 * 특정 테그의 ID를 지정하여 해당 테그에 속한 객체를 Disable로 바꾸는 함수
 * cfSetDisable(obj, bool)
 *************************************************************************
 * Author    : 최재원
 * Date       : 2004.04.07
 * History   : 최초 작성
 * Desc      : readonly set function
 * Param    : obj : 오브젝트가들어있는 레이어(div/table/span등등)
 *                bool : true/false (true:readonly, false:normal)
 *************************************************************************/
function cfSetDisable(obj, bool) {
	var result = cfTagIdParseToObj(obj, "disabled");
	for (i in result) {
		result[i].disabled= bool;
		if((typeof(result[i].type) == "undefined")) {

			var obj = result[i];

			for(idx=0; idx<obj.length; idx++) {
				obj[idx].disabled = bool;
			}
		}
	}
}


/*************************************************************************
 * cfSetEvent(p_objId, p_event, p_functionName);
 *************************************************************************
 * author : 최재원
 * date    : 2004/04/06
 * desc   : 지정한 id에 속한 오브젝트에 이벤트를 적용하는 함수
 * param : p_objId    : (테이블, DIV, SPAN등의 레이어관련 ID)
 *             p_event : 적용할 이벤트 (onblur, onkeydown, onkeyup, onclick등등...)
 *************************************************************************/
function cfSetEvent(p_objId, p_event) {
	p_functionName = "cfSetNextFocus()";
	// oFields의 입력필드를 파싱하여 result에 저장.
	var v_obj_event = cfTagIdParseToObj(p_objId);
	var PATTERN = /(\s*)/g;

	p_event = (p_event.replace(PATTERN, "")).toLowerCase();
	v_event = p_event.split(",");
	var p_functionName = p_functionName.replace(PATTERN, "");

	var v_script_true = p_functionName.substring(0, p_functionName.indexOf(")")) + p_objId.id + ", this" + ", true)";
	var v_script_false = p_functionName.substring(0, p_functionName.indexOf(")")) + p_objId.id + ", this" + ", false)";
	for (i in v_obj_event) {
		for (j in v_event) {
			switch(v_obj_event[i].type) {

					case "text":
					case "textarea":
							if (v_event[j] == "onblur") {
								var v_script = "document.all." + v_obj_event[i].id + "." + v_event[j] + "= function() {" + v_script_true + "; }" ;
							} else {
								var v_script = "document.all." + v_obj_event[i].id + "." + v_event[j] + "= function() {" + v_script_false + "; }" ;
							}
							eval(v_script);
							break;

					case "radio":
					case "checkbox":
							if (v_event[j] == "onblur") {
								var v_script = "document.all." + v_obj_event[i].id + "." + "onclick" + "= function() {" + v_script_true + "; }" ;
							} else {
								var v_script = "document.all." + v_obj_event[i].id + "." + "onclick"  + "= function() {" + v_script_false + "; }" ;
							}
							eval(v_script);
							break;
					case "select-one":
							var v_script = "document.all." + v_obj_event[i].id + "." + "onchange"  + "= function() {" + v_script_false + "; }" ;
							eval(v_script);
							break;
					default:
							break;
			}
		}
	}
}

/*************************************************************************
 * cfDateDiff(p_strtYmd, p_endYmd)
 *************************************************************************
 * author : 최재원
 * date    : 2004/04/06
 * desc   : 날짜의 차이를 구하는 함수
 * param : p_strtYmd  : 시작일자 (YYYYMMDD)
 *             p_endYmd : 종료일자 (YYYYMMDD)
 * ex      : var result = cfDateDiff("20031009", "20040410");
 *            두날짜의 차이를 반환 (日)
 *************************************************************************/
function cfDateDiff(p_strtYmd, p_endYmd) {
	var startDate = new Date(p_strtYmd.substring(0,4),p_strtYmd.substring(4,6)-1,p_strtYmd.substring(6,8));

	var endDate = new Date(p_endYmd.substring(0,4),p_endYmd.substring(4,6)-1,p_endYmd.substring(6,8));

	var msec = (endDate-startDate)/1000/60/60/24;

	return msec;
}




/**
 * Init Object
 */
function init(p_objId) {

	var v_obj_valid =	cfTagIdParseToObj(p_objId);
	var temp_valid = v_obj_valid;
	for (i in v_obj_valid) {
		if(init_obj(temp_valid[i], false, p_objId) == false) {
			return false;
		}
	}
	return true;	 // 모든 오브젝트에 대한 Validation에 성공한 경우.
}


/**
 * 특정 폼안에 데이터에 대한 초기 셋팅.
 */
function init_obj(p_obj, b_exeEvent, p_objId) {



	// 오브젝트의 valid속성이 지정된 경우 처리.
	if (p_obj.valid != null) {
		var VALID_EXP = p_obj.valid.replace(ALL_TRIM_PATTERN, "");					// Validation검증용 테그 ALL_TRIM처리.
		var valueSplit = VALID_EXP.split(";");


		for (i=0; i < valueSplit.length; i++) {	// start for #1

			var valid_attribute = valueSplit[i].substring(0, valueSplit[i].indexOf("=")).toUpperCase();
			var valid_attribute_value = valueSplit[i].substring(valueSplit[i].indexOf("=")+1).toUpperCase();
			switch(valid_attribute) {	// start switch #2

				case "KEY":
						if(p_obj.type == "text" || p_obj.type == "password") {
							 p_obj.style.backgroundImage = "url(/common/required.gif)";
							p_obj.style.backgroundColor = "#F2FDD1";
							p_obj.style.backgroundPosition = "top right";
							p_obj.style.backgroundRepeat = "no-repeat";
							/*
							p_obj.style.height = "18px";
							p_obj.style.padding = "2px 0px 0px 3px";
							p_obj.style.border = "1px solid #DCD5C2";
							p_obj.style.fontSize = "11px";
							p_obj.style.textDecoration = "none";
							p_obj.style.margin = "0px";*/
						} else if (p_obj.type == "textarea") {
							 p_obj.style.backgroundImage = "url(/common/required.gif)";
							p_obj.style.backgroundColor = "#F2FDD1";
							p_obj.style.backgroundPosition = "top right";
							p_obj.style.backgroundRepeat = "no-repeat";
							/*
							p_obj.style.padding = "2px 0px 0px 3px";
							p_obj.style.border = "1px solid #DCD5C2";
							p_obj.style.fontSize = "11px";
							p_obj.style.textDecoration = "none";
							p_obj.style.margin = "0px";
							p_obj.style.fontFamily = "Arial, 굴림";
							p_obj.style.fontSize  = "11px";
							p_obj.style.color = "#666666";*/
						} else if (p_obj.type == "select-one") {
							p_obj.className = "input_combobox";
							p_obj.style.backgroundImage = "url(/common/required.gif)";
							p_obj.style.backgroundColor = "#F2FDD1";
							p_obj.style.backgroundPosition = "top right";
							p_obj.style.backgroundRepeat = "no-repeat";
						} else {
							try  {
								switch (p_obj.classid.toUpperCase()) {
										// 럭스 콤보
										case "CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197":
												p_obj.style.backgroundColor = "#F2FDD1";
												p_obj.style.backgroundPosition = "top right";
												p_obj.style.backgroundRepeat = "no-repeat";
												break;
										case "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F":
												p_obj.style.backgroundColor = "#F2FDD1";
												p_obj.style.backgroundPosition = "top right";
												p_obj.style.backgroundRepeat = "no-repeat";
												break;

								}
							}
							catch (exception){}


						}
						break;
				case "TYPE":
						if (valid_attribute_value == "DATE" && p_obj.tagName.toUpperCase() != "OBJECT") {

								p_obj.onblur = function() { p_obj.value = p_obj.value.toDate(p_obj) };
								p_obj.onfocus = function() { temp = p_obj.value;
															 p_obj.value = "";
															 //p_obj.value = temp.replaceStr('', '');
															 p_obj.value = temp.replaceStr('-', '');
															 p_obj.select();
														   };

						} else if (valid_attribute_value == "SSN" && p_obj.tagName.toUpperCase() != "OBJECT") {
							p_obj.onblur = function() { p_obj.value = p_obj.value.toSsn(p_obj) };
							p_obj.onfocus = function() { temp = p_obj.value;
							                             p_obj.value = "";
														 p_obj.value = temp.replaceStr('-', '');
														 p_obj.select();
													   };
						} else if (valid_attribute_value == "ZIPCD" && p_obj.tagName.toUpperCase() != "OBJECT") {
							p_obj.onblur = function() { p_obj.value = p_obj.value.toZipCd(p_obj) };
							p_obj.onfocus = function() { temp = p_obj.value;
							                             p_obj.value = "";
														 p_obj.value = temp.replaceStr('-', '');
														 p_obj.select();
														}
						}
						break;
			}	// end switch #2
		}	// end for #1
		return true;
	} else {
		if ( typeof(p_obj.length) != "undefined" && typeof(p_obj.type) == "undefined") {

			for (io=0; io < p_obj.length ;io++ ) {
				if (p_obj[io].valid != null) {

					var VALID_EXP = p_obj[io].valid.replace(ALL_TRIM_PATTERN, "");					// Validation검증용 테그 ALL_TRIM처리.
					var valueSplit = VALID_EXP.split(";");


					for (i=0; i < valueSplit.length; i++) {	// start for #1

						var valid_attribute = valueSplit[i].substring(0, valueSplit[i].indexOf("=")).toUpperCase();
						var valid_attribute_value = valueSplit[i].substring(valueSplit[i].indexOf("=")+1).toUpperCase();
						switch(valid_attribute) {	// start switch #2

							case "KEY":
									if(p_obj[io].type == "text") {
										// p_obj[io].style.backgroundImage = "url(/common/required.gif)";
										p_obj[io].style.backgroundColor = "#F2FDD1";
										p_obj[io].style.backgroundPosition = "top right";
										p_obj[io].style.backgroundRepeat = "no-repeat";
										/*
										p_obj[io].style.height = "18px";
										p_obj[io].style.padding = "2px 0px 0px 3px";
										p_obj[io].style.border = "1px solid #DCD5C2";
										p_obj[io].style.fontSize = "11px";
										p_obj[io].style.textDecoration = "none";
										p_obj[io].style.margin = "0px";*/
									} else if (p_obj.type == "textarea") {
										// p_obj[io].style.backgroundImage = "url(/common/required.gif)";
										p_obj[io].style.backgroundColor = "#F2FDD1";
										p_obj[io].style.backgroundPosition = "top right";
										p_obj[io].style.backgroundRepeat = "no-repeat";
										/*
										p_obj[io].style.padding = "2px 0px 0px 3px";
										p_obj[io].style.border = "1px solid #DCD5C2";
										p_obj[io].style.fontSize = "11px";
										p_obj[io].style.textDecoration = "none";
										p_obj[io].style.margin = "0px";
										p_obj[io].style.fontFamily = "Arial, 굴림";
										p_obj[io].style.fontSize  = "11px";
										p_obj[io].style.color = "#666666";*/
									} else if (p_obj.type == "select-one") {
										p_obj[io].className = "input_combobox";
										p_obj[io].style.backgroundColor = "#F2FDD1";
										//p_obj[io].style.backgroundImage = "url(/common/required.gif)";
										p_obj[io].style.backgroundPosition = "top right";
										p_obj[io].style.backgroundRepeat = "no-repeat";
									}
									break;
							case "TYPE":
									if (valid_attribute_value == "DATE") {
										p_obj[io].onblur = function() { p_obj[io].value = p_obj[io].value.toDate(p_obj[io]) };
										p_obj[io].onfocus = function() { temp = p_obj[io].value;
																	 p_obj[io].value = "";
																	 p_obj[io].value = temp.replaceStr('-', '');
																	 p_obj[io].focus();
																	 p_obj[io].value +="";
																   };
									}
									break;
						}	// end switch #2
					}
				}	// end for #1
				return true;
			}
		} else {

			if (p_obj.readOnly == true ) {
				try {
					p_obj.InheritColor = true;
					p_obj.ReadOnlyBackColor = "#F1F1F1";
					p_obj.style.backgroundColor = "#F1F1F1";
				} catch (exception) {
					p_obj.style.backgroundColor = "#F1F1F1";
				}
			}


		}
	}
}


/**
 * 날짜 검증용.
 */
function cfDateExpr(p_value) {
	var gs_DateStr = p_value.replaceStr("-","");
	var go_Date = null;
	if (gs_DateStr.length == 8) {//년월일
		go_Date = new Date(gs_DateStr.substring(0,4), gs_DateStr.substring(4,6) -1, gs_DateStr.substring(6,8));
		var tmpYear = go_Date.getYear();
		if (tmpYear < 2000)
		{
			tmpYear = "19" + go_Date.getYear();
		}

		var ls_DateStr = tmpYear + "";

		if (go_Date.getMonth()+1 < 10) {
			ls_DateStr += "0" + (go_Date.getMonth()+1);
		} else {
			ls_DateStr += "" + (go_Date.getMonth()+1);
		}

		if (go_Date.getDate() < 10) {
			ls_DateStr += "0" + go_Date.getDate();
		} else {
			ls_DateStr += "" + go_Date.getDate();
		}

		if (ls_DateStr != gs_DateStr) {
			return false;
		} else {
			return true;
		}
  } else if (gs_DateStr.length == 6) {//년월
    go_Date = new Date(gs_DateStr.substring(0,4), gs_DateStr.substring(4,6) -1);
		var tmpYear = go_Date.getYear();
		if (tmpYear < 2000)
		{
			tmpYear = "19" + go_Date.getYear();
		}

		var ls_DateStr = tmpYear + "";

		if (go_Date.getMonth()+1 < 10) {
			ls_DateStr += "0" + (go_Date.getMonth()+1);
		} else {
			ls_DateStr += "" + (go_Date.getMonth()+1);
		}

		if (ls_DateStr != gs_DateStr) {
			return false;
		} else {
			return true;
		}
	} else {
		return false;
	}
}

String.prototype.toDate = function() {
	p_obj = arguments[0];
	var temp = this.replaceStr("-","");
	if(cfDateExpr(this)) {
	  if(temp.length == 8){//년월일
  		return temp.substring(0,4) + "-" + temp.substring(4,6) + "-" + temp.substring(6,8);
    }else{//년원
      return temp.substring(0,4) + "-" + temp.substring(4,6);
    }
	} else {
	  //alert("[" + p_obj.field +"]" + "의 날짜 형식 또는 날짜가 잘못 입력되었습니다.\n날짜는 YYYY-MM-DD와 같은 형식이어야 합니다.");
	  p_obj.focus();
	  return this;
	}
}


String.prototype.toSsn = function() {
	p_obj = arguments[0];
	var temp = this.replaceStr("-","");
	if(this.length == 13) {
		return temp.substring(0,6) + "-" + temp.substring(6,13);
	} else {
		return this;
	}
}

String.prototype.toCardNo = function() {
	p_obj = arguments[0];
	var temp = this.replaceStr("-","");
	if(this.length == 16) {
		return temp.substring(0,4) + "-" + temp.substring(4,8) + "-" + temp.substring(8,12) + "-" + temp.substring(12,16);
	} else {
		return this;
	}
}


String.prototype.toZipCd = function() {
	p_obj = arguments[0];
	var temp = this.replaceStr("-","");
	if(this.length == 6) {
		return temp.substring(0,3) + "-" + temp.substring(3,6);
	} else {
		return this;
	}
}

/**
 *	화면에 프로그래스바 오브젝트를 생성한다.
 */
function cfCreateBar() {
	var progress = "";
	try	{
		if (tempObj.classid.toUpperCase() == "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB") {	// 데이터셋.
			progress = '<iframe src="../../common/ds.jsp" id=oProgressBar style="position:absolute;visibility:hidden;width:255;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
		} else if (tempObj.classid.toUpperCase() == "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5") { // 트랜젝션 오브젝트.
			if(arguments.length == 2 && arguments[1] == "R") {
				progress = '<iframe src="../../common/ds.jsp" id=oProgressBar style="position:absolute;visibility:hidden;width:255;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
			} else {
				progress = '<iframe src="../../common/tr.jsp" id=oProgressBar style="position:absolute;visibility:hidden;width:255;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
			}

		}
	} catch (exception) {
		progress = '<iframe src="../../common/ds.jsp" id=oProgressBar style="position:absolute;visibility:hidden;width:255;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
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
//window.onload = cfCreateBar;

/**
 * 파일명 한글 및 영문만 허용.
 */
function cfUniCodeRange(p_value) {
	var tempFileName = p_value.substring(p_value.lastIndexOf("\\")+1);
	for (i=0; i<tempFileName.length; i++) {
		if (tempFileName.charCodeAt(i) > 127 && tempFileName.charCodeAt(i) < 44032) {
			return false;
		}
	}
	return true;
}

/**
 * 파일 첨부 숫자를 선택할때 수행되는 함수
 */
function fcFileAttached() {
	var li_FileCnt = document.all.oFileAttachedCnt.value;
	var lo_table = document.all.oFileAttached;

	if (lo_table.rows.length >= li_FileCnt) {	// 선택한 Row보다 li_FileCnt가 작을경우 -->
		// row삭제
		for (i=lo_table.rows.length; i>= li_FileCnt; i--) {
			try {
				lo_table.deleteRow(i);
			} catch(exception) {
			}

		}
	} else if (lo_table.rows.length-1 < li_FileCnt){
		// row추가.
		for (i=lo_table.rows.length; i< li_FileCnt; i++) {
			lo_table.insertRow(i);

			var cell = lo_table.rows[i].insertCell();
			cell.colSpan="2";
			//style='display: none;'
			if ( arguments.length == 0) {
				cell.innerHTML = "<input type=file name='oFileNm" + i + "'  field='Attached File' onkeydown='event.returnValue=false' style='height:17;width:300' class=input_textfield>";
			} else {
				cell.innerHTML = "<input type=file name='oFileNm" + i + "'  field='Attached File' valid='key=true' onkeydown='event.returnValue=false' style='height:17;width:300' class=input_textfield>";
			}

		}
	}
}

/**
 * 사업자 등록 번호 검증
 */
function cfCsnValid(p_csn) {
	var sum = 0;
	var nam = 0;
	var checkDigit = -1;
	var checkArray = [1,3,7,1,3,7,1,3,5];

	for(i=0 ; i < 9 ; i++)
		sum += p_csn.charAt(i) * checkArray[i];

	sum = sum + ((p_csn.charAt(8) * 5 ) / 10);
	nam = Math.floor(sum) % 10;
	checkDigit = ( nam == 0 ) ? 0 : 10 - nam;

	if ( p_csn.charAt(9) != checkDigit) {
		return false;
	}
	return true;
}



/**
 *  파일 다운로드
 */
function cfDownload(p_UploadFileNm, p_OrgFileNm) {
	try	{
		document.all.coDownloadFrm.outerHTML = "";
	} catch (exception) {}

	var result = document.all.coDownloadFrm;
	if (typeof(result) == "undefined") {
		var new_obj = document.createElement("<iframe>");
		new_obj.id = "coDownloadFrm";
		new_obj.width = 0;
		new_obj.height = 0;
		var obj = document.body;
		obj.insertAdjacentElement("afterBegin", new_obj);
	}
	var url = "../../../servlet/DownloadSVL?ACTION=DOWNLOAD&ORG_FILENAME=" + p_UploadFileNm + "&UPD_FILENAME=" + escape(p_OrgFileNm) + "&DUMMY=" + Math.random(1)*10000;
	//alert(url);
	var obj = document.all.coDownloadFrm;
	obj.src=url;
}



/**
 * 첨부파일 입력란 초기화.
 */
function fcRemoveFile(p_obj) {
	p_obj.outerHTML = p_obj.outerHTML;
}


/*************************************************************************
 * cfStyleGrid(oGrid, styleName, features)
 *************************************************************************
 * author : 김석두
 * date   : 2004/06/21
 * desc   : 그리드에 표준 스타일을 적용한다.
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleGrid(Any_Grid, Indicate, Editable, SortGB) {

	Any_Grid.RowHeight            = 22;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 2;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = false;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = true;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = true;        // 컬럼 드레그 드롭 가능
	Any_Grid.DragDropImg          = 1;           // 컬럼 드레그 드롭시 마우스 포인터 변경
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#F7DCBB";   // ROW 헤더 ROW 색갈 변경
	Any_Grid.IndicatorColBkColor  = "#F7DCBB";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#A1A1A1";   // Grid Line Color

	Any_Grid.IndWidth             = Indicate;    // Row Header Width
	Any_Grid.Editable             = Editable;    // Read Only & Row Selection Mode
	Any_Grid.SortView             = SortGB;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "굴림체";    // Grid Font Setting
    Any_Grid.FontSize             = "9";         // Grid Font Size 설정
    Any_Grid.UsingOneClick        = "1";

	for(var i=0; i < Any_Grid.CountColumn; i++) {

		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadColor')   = "#000000";   // Header ForeColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#F7DCBB";   // Header BackColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부
	    //Any_Grid.DefaultColor('BgColor') = "#FEFBF6"; //Grid Default BackGround Color

	}

	Any_Grid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#BAD3FC', TextColor='#989290'</SC>";  // Focus(有) Editable(O) 선택된 Row의 선택된 Column의 Color(#F3FED2)
    Any_Grid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFCF', TextColor='#989290'</SC>";  // Focus(有) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
    Any_Grid.SelectionColor += "<SC>Type='FocusCurCol',  BgColor='#BAD3FC', TextColor='#989290'</SC>";  // Focus(有) Editable(X) 선택된 Row의 선택된 Column의 Color(#F3FED2)
	Any_Grid.SelectionColor += "<SC>Type='FocusCurRow',  BgColor='#FFFFCF', TextColor='#989290'</SC>";  // Focus(有) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.SelectionColor += "<SC>Type='EditCol',      BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(O) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='EditRow',      BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
	Any_Grid.SelectionColor += "<SC>Type='CurCol',       BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(X) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='CurRow',       BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.TitleHeight          = "30";

}

/*************************************************************************
 * cfStyleGrid(oGrid, styleName, features)
 *************************************************************************
 * author : 김석두
 * date   : 2004/06/21
 * desc   : 그리드에 표준 스타일을 적용한다.
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleGrid2(Any_Grid) {

	Any_Grid.RowHeight            = 22;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 2;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = false;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = true;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = false;       // 컬럼 드레그 드롭 가능
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#F7DCBB";   // ROW 헤더 ROW 색갈 변경
	Any_Grid.IndicatorColBkColor  = "#F7DCBB";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#A1A1A1";   // Grid Line Color

	Any_Grid.IndWidth             = 15;         // Row Header Width
	Any_Grid.Editable             = false;      // Read Only & Row Selection Mode
	Any_Grid.SortView             = false;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "굴림체";    // Grid Font Setting
	Any_Grid.FontSize             = "9";         // Grid Font Size 설정

	for(var i=0; i < Any_Grid.CountColumn; i++) {

		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadColor')   = "#000000";   // Header ForeColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#F7DCBB";   // Header BackColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부

	}
	Any_Grid.TitleHeight          = "30";
}

/*************************************************************************
 * cfStyleGrid3(oGrid, styleName, features)
 *************************************************************************
 * author : 김석두
 * date   : 2010/06/21
 * desc   : 그리드에 표준 스타일을 적용한다.
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleGrid3(Any_Grid) {

	Any_Grid.RowHeight            = 100;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 2;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = false;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = true;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = false;       // 컬럼 드레그 드롭 가능
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#cccccc";   // ROW 헤더 ROW 색갈 변경
	Any_Grid.IndicatorColBkColor  = "#cccccc";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#000000";   // Grid Line Color

	Any_Grid.IndWidth             = 0;         // Row Header Width
	Any_Grid.Editable             = true;      // Read Only & Row Selection Mode --
	Any_Grid.SortView             = false;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "굴림체";    // Grid Font Setting
	Any_Grid.FontSize             = "10";         // Grid Font Size 설정

	for(var i=0; i < Any_Grid.CountColumn; i++) {

		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadColor')   = "#001100";   // Header ForeColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#cccccc";   // Header BackColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부

	}

}

/*************************************************************************
 * cfStyleGrid4(oGrid, styleName, features)
 *************************************************************************
 * author : 이동훈
 * date   : 2013/05/29
 * desc   : 그리드에 표준 스타일을 적용한다.
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleGrid4(Any_Grid) {

	Any_Grid.RowHeight            = 45;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 2;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = false;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = true;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = false;       // 컬럼 드레그 드롭 가능
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#AA99FF";   // ROW 헤더 ROW 색갈 변경
	Any_Grid.IndicatorColBkColor  = "#AA99FF";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#A1A1A1";   // Grid Line Color

	Any_Grid.IndWidth             = 15;         // Row Header Width
	Any_Grid.Editable             = true;      // Read Only & Row Selection Mode --
	Any_Grid.SortView             = false;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "굴림체";    // Grid Font Setting
	Any_Grid.FontSize             = "9";         // Grid Font Size 설정

	//for(var i=0; i < Any_Grid.CountColumn; i++) {

		//Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadColor')   = "#001100";   // Header ForeColor
		//Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#AA99FF";   // Header BackColor
		//Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부

	//}

}

/*************************************************************************
 * cfStyleGrid(oGrid, styleName, features)
 *************************************************************************
 * author : 김석두
 * date   : 2004/06/21
 * desc   : 그리드에 표준 스타일을 적용한다.
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleGrid5(Any_Grid, Indicate, Editable, SortGB) {

	Any_Grid.RowHeight            = 22;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 2;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = false;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = true;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = true;        // 컬럼 드레그 드롭 가능
	Any_Grid.DragDropImg          = 1;           // 컬럼 드레그 드롭시 마우스 포인터 변경
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#dae0ee";   // ROW 헤더 ROW 색갈 변경
	Any_Grid.IndicatorColBkColor  = "#dae0ee";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#A1A1A1";   // Grid Line Color

	Any_Grid.IndWidth             = Indicate;    // Row Header Width
	Any_Grid.Editable             = Editable;    // Read Only & Row Selection Mode
	Any_Grid.SortView             = SortGB;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "굴림체";    // Grid Font Setting
    Any_Grid.FontSize             = "9";         // Grid Font Size 설정
    Any_Grid.UsingOneClick        = "1";

	for(var i=0; i < Any_Grid.CountColumn; i++) {

		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadColor')   = "#000000";   // Header ForeColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#dae0ee";   // Header BackColor
		//Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부
	    //Any_Grid.DefaultColor('BgColor') = "#FEFBF6"; //Grid Default BackGround Color

	}

	Any_Grid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#BAD3FC', TextColor='#989290'</SC>";  // Focus(有) Editable(O) 선택된 Row의 선택된 Column의 Color(#F3FED2)
    Any_Grid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFCF', TextColor='#989290'</SC>";  // Focus(有) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
    Any_Grid.SelectionColor += "<SC>Type='FocusCurCol',  BgColor='#BAD3FC', TextColor='#989290'</SC>";  // Focus(有) Editable(X) 선택된 Row의 선택된 Column의 Color(#F3FED2)
	Any_Grid.SelectionColor += "<SC>Type='FocusCurRow',  BgColor='#FFFFCF', TextColor='#989290'</SC>";  // Focus(有) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.SelectionColor += "<SC>Type='EditCol',      BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(O) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='EditRow',      BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
	Any_Grid.SelectionColor += "<SC>Type='CurCol',       BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(X) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='CurRow',       BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.TitleHeight          = "30";

}

/*************************************************************************
 * cfStyleGrid6(oGrid, styleName, features)
 *************************************************************************
 * author : 김석두
 * date   : 2010/06/21
 * desc   : 그리드에 표준 스타일을 적용한다.
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleGrid6(Any_Grid) {

	Any_Grid.RowHeight            = 120;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 4;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = false;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = false;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = false;       // 컬럼 드레그 드롭 가능
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#dae0ee";   // ROW 헤더 ROW 색갈 변경
	Any_Grid.IndicatorColBkColor  = "#dae0ee";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#9EBEC4";   // Grid Line Color

	Any_Grid.IndWidth             = 0;         // Row Header Width
	Any_Grid.Editable             = true;      // Read Only & Row Selection Mode --
	Any_Grid.SortView             = false;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "돋움";    // Grid Font Setting
	Any_Grid.FontSize             = "9";         // Grid Font Size 설정

	for(var i=0; i < Any_Grid.CountColumn; i++) {

		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor')   = "#dae0ee";   // Header ForeColor
//		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#AA99FF";   // Header BackColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부

	}

}



/*************************************************************************
 * cfStyleGrid_New(oGrid, styleName, features)
 *************************************************************************
 * author : 이동훈
 * date   : 2012/04/03
 * desc   : 인사평가 그리드
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid_New(oSampleGD)
 *************************************************************************/
function cfStyleGrid_New(Any_Grid, Indicate, Editable, SortGB) {

	Any_Grid.RowHeight            = 25;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 1;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = false;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = false;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = true;        // 컬럼 드레그 드롭 가능
	Any_Grid.DragDropImg          = 1;           // 컬럼 드레그 드롭시 마우스 포인터 변경
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#dae0ee";   // ROW 헤더 ROW 색깔 변경
	Any_Grid.IndicatorColBkColor  = "#dae0ee";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#9EBEC4";   // Grid Line Color

	Any_Grid.IndWidth             = Indicate;    // Row Header Width
	Any_Grid.Editable             = Editable;    // Read Only & Row Selection Mode
	Any_Grid.SortView             = SortGB;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "돋움";    // Grid Font Setting
    Any_Grid.FontSize             = "9";         // Grid Font Size 설정
    Any_Grid.UsingOneClick        = "1";

	Any_Grid.HeadBorder			  = "4";
	Any_Grid.HeadLineColor		  = "#9EBEC4";	// Head 컬럼 Border 색상변경, 사용하기 위해서는 HeadBorder = "4" 이어야 함;

	for(var i=0; i < Any_Grid.CountColumn; i++) {

		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadColor')   = "#34578c";   // Header ForeColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#dae0ee";   // Header BackColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadFontStyle') = "bold";   // Header Font Sytle
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부
	    //Any_Grid.DefaultColor('BgColor') = "#FEFBF6"; //Grid Default BackGround Color

	}

	//Any_Grid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#d1deeb', TextColor='#000000'</SC>";  // Focus(有) Editable(O) 선택된 Row의 선택된 Column의 Color(#F3FED2)

	Any_Grid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#5A'B1C0', TextColor='#000000'</SC>";  // Focus(有) Editable(O) 선택된 Row의 선택된 Column의 Color(#F3FED2)
	Any_Grid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(有) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
    Any_Grid.SelectionColor += "<SC>Type='FocusCurCol',  BgColor='#d1deeb', TextColor='#000000'</SC>";  // Focus(有) Editable(X) 선택된 Row의 선택된 Column의 Color(#F3FED2)
	Any_Grid.SelectionColor += "<SC>Type='FocusCurRow',  BgColor='#d1deeb', TextColor='#000000'</SC>";  // Focus(有) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.SelectionColor += "<SC>Type='EditCol',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(O) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='EditRow',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
	Any_Grid.SelectionColor += "<SC>Type='CurCol',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(X) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='CurRow',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.TitleHeight          = "30";

}

/*************************************************************************
 * cfStyleGrid_New2(oGrid, styleName, features)
 *************************************************************************
 * author : 이동훈
 * date   : 2016/11/15
 * desc   : 인사평가 그리드
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid_New(oSampleGD)
 *************************************************************************/
function cfStyleGrid_New2(Any_Grid, Indicate, Editable, SortGB) {

	Any_Grid.RowHeight            = 50;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 1;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = false;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = false;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = true;        // 컬럼 드레그 드롭 가능
	Any_Grid.DragDropImg          = 1;           // 컬럼 드레그 드롭시 마우스 포인터 변경
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#dae0ee";   // ROW 헤더 ROW 색깔 변경
	Any_Grid.IndicatorColBkColor  = "#dae0ee";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#9EBEC4";   // Grid Line Color

	Any_Grid.IndWidth             = Indicate;    // Row Header Width
	Any_Grid.Editable             = Editable;    // Read Only & Row Selection Mode
	Any_Grid.SortView             = SortGB;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "돋움";    // Grid Font Setting
    Any_Grid.FontSize             = "9";         // Grid Font Size 설정
    Any_Grid.UsingOneClick        = "1";

	Any_Grid.HeadBorder			  = "4";
	Any_Grid.HeadLineColor		  = "#9EBEC4";	// Head 컬럼 Border 색상변경, 사용하기 위해서는 HeadBorder = "4" 이어야 함;

	for(var i=0; i < Any_Grid.CountColumn; i++) {

		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadColor')   = "#34578c";   // Header ForeColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#dae0ee";   // Header BackColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadFontStyle') = "bold";   // Header Font Sytle
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부
	    //Any_Grid.DefaultColor('BgColor') = "#FEFBF6"; //Grid Default BackGround Color

	}

	//Any_Grid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#d1deeb', TextColor='#000000'</SC>";  // Focus(有) Editable(O) 선택된 Row의 선택된 Column의 Color(#F3FED2)

	Any_Grid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#5A'B1C0', TextColor='#000000'</SC>";  // Focus(有) Editable(O) 선택된 Row의 선택된 Column의 Color(#F3FED2)
	Any_Grid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(有) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
    Any_Grid.SelectionColor += "<SC>Type='FocusCurCol',  BgColor='#d1deeb', TextColor='#000000'</SC>";  // Focus(有) Editable(X) 선택된 Row의 선택된 Column의 Color(#F3FED2)
	Any_Grid.SelectionColor += "<SC>Type='FocusCurRow',  BgColor='#d1deeb', TextColor='#000000'</SC>";  // Focus(有) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.SelectionColor += "<SC>Type='EditCol',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(O) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='EditRow',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
	Any_Grid.SelectionColor += "<SC>Type='CurCol',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(X) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='CurRow',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.TitleHeight          = "30";

}

/*************************************************************************
 * cfStyleGrid(oGrid, styleName, features)
 *************************************************************************
 * author : 김석두
 * date   : 2004/06/21
 * desc   : 그리드에 표준 스타일을 적용한다.
 * param  : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex     : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleGridEis(Any_Grid, Indicate, Editable, SortGB) {

	//Any_Grid.RowHeight            = 22;          // Grid Row Height Setting
	Any_Grid.FillArea             = false;       // True:빈 Row도 그리드 라인 표시 False = 빈 Row 그리드 라인 없음
	Any_Grid.BorderStyle          = 2;           // 그리드 스타일(0:없음 1:라인 2:오목 3:볼록 4:프레임스타일)
	Any_Grid.AutoResizing         = true;        //헤더 더블 클릭시 해당 컬럼 전체 보이게
	Any_Grid.ColSizing            = true;        // 컬럼 사이즈 변경 가능
	Any_Grid.DisableNoHScroll     = true;        // 좌우 스크롤바 항상 보이게
	Any_Grid.DisableNoVScroll     = true;        // 상하 스크롤바 항상 보이게
	Any_Grid.DragDropEnable       = true;        // 컬럼 드레그 드롭 가능
	Any_Grid.DragDropImg          = 1;           // 컬럼 드레그 드롭시 마우스 포인터 변경
	Any_Grid.FocusRect            = false;       // Focus 받을 때 점선으로 표시 않기
	Any_Grid.IndicatorBkColor     = "#f0f0f0";   // ROW 헤더 ROW 색갈 변경
	Any_Grid.IndicatorColBkColor  = "#f0f0f0";   // ROW 헤더 색갈 변경
	Any_Grid.LineColor            = "#A1A1A1";   // Grid Line Color

	Any_Grid.IndWidth             = Indicate;    // Row Header Width
	Any_Grid.Editable             = Editable;    // Read Only & Row Selection Mode
	Any_Grid.SortView             = SortGB;      // Head 컬럼을 통한 Sort 여부

	Any_Grid.FontName             = "굴림체";    // Grid Font Setting
    Any_Grid.FontSize             = "9";         // Grid Font Size 설정
    Any_Grid.UsingOneClick        = "1";

	for(var i=0; i < Any_Grid.CountColumn; i++) {

		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadColor')   = "#000000";   // Header ForeColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i),'HeadBgColor') = "#f0f0f0";   // Header BackColor
		Any_Grid.ColumnProp(Any_Grid.GetColumnID(i), 'Sort')       = true;        //Sort 여부
	    //Any_Grid.DefaultColor('BgColor') = "#FEFBF6"; //Grid Default BackGround Color

	}

	Any_Grid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#BAD3FC', TextColor='#989290'</SC>";  // Focus(有) Editable(O) 선택된 Row의 선택된 Column의 Color(#F3FED2)
    Any_Grid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFCF', TextColor='#989290'</SC>";  // Focus(有) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
    Any_Grid.SelectionColor += "<SC>Type='FocusCurCol',  BgColor='#BAD3FC', TextColor='#989290'</SC>";  // Focus(有) Editable(X) 선택된 Row의 선택된 Column의 Color(#F3FED2)
	Any_Grid.SelectionColor += "<SC>Type='FocusCurRow',  BgColor='#FFFFCF', TextColor='#989290'</SC>";  // Focus(有) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.SelectionColor += "<SC>Type='EditCol',      BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(O) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='EditRow',      BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
	Any_Grid.SelectionColor += "<SC>Type='CurCol',       BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(X) 선택된 Row의 선택된 Column의 Color
	Any_Grid.SelectionColor += "<SC>Type='CurRow',       BgColor='#F3FED2', TextColor='#989290'</SC>";  // Focus(無) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀

	Any_Grid.TitleHeight          = "30";

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
 * @type   : Function
 * @access : public
 * @desc   : 가우스관련 오류가 발생한 경우 에러메시지를 뿌려준다.
 * @sig    : cfErrorMsg()
 * @return : 오류메시지창
 * @author : 최재원
 */
function cfErrorMsg(p_obj, p_returnObj) {
	GLB_GDS = p_obj;

	if (GLB_GDS.ErrorMsg.split("$").length >= 2) {
		window.showModalDialog("../../common/gauce_error.jsp", window.self, "status:no;dialogWidth:546px; dialogHeight:416px;center:yes;dialogHide:yes;help:no" );
	} else {
		if (GLB_GDS.ErrorMsg.indexOf("SESSION_ERROR") != -1) {
			
			alert("오랫동안 사용하지 않으셔서 서버와 연결이 끊겼습니다!\n\n로그인 후 다시 작업하세요!!");
			       
			try{

				frame = window.external.GetFrame(window);
				frame.outerWindow.do_go();

			} catch (e) {
			    
				window.close();
				parent.document.location= '../../index.jsp';

			}

		} else if (GLB_GDS.ErrorMsg.indexOf("COMMON_MSG_TIME_OUT") != -1) {
			var timeStr = GLB_GDS.ErrorMsg.substring(GLB_GDS.ErrorMsg.indexOf("COMMON_MSG_TIME_OUT")+20);
			location.href="../../common/time_error.jsp?S_TIME=" + timeStr.substring(0, timeStr.indexOf(",")) + "&E_TIME=" + timeStr.substring(timeStr.indexOf(",")+1);
		} else if (GLB_GDS.ErrorMsg.indexOf("DSET-50019") != -1) {
			alert(GLB_GDS.ErrorMsg.substring(GLB_GDS.ErrorMsg.indexOf("DSET-50019")+12));
		} else if (GLB_GDS.ErrorMsg.indexOf("DSET-50018") != -1) {
			alert(GLB_GDS.ErrorMsg.substring(GLB_GDS.ErrorMsg.indexOf("DSET-50018")+12));
		} else {
			if (GLB_GDS.ErrorMsg.indexOf("@") != -1) {
				var result = GLB_GDS.ErrorMsg.substring(0, GLB_GDS.ErrorMsg.indexOf("@"));
				result = result.substring(result.indexOf("ERROR_RESULT:")+13);
				GLB_ERROR_ROWPOSITION = result;
				p_returnObj.innerHTML = "<b>" + result + "</b>";
				var msg    = GLB_GDS.ErrorMsg.substring(GLB_GDS.ErrorMsg.indexOf("@")+1);
				alert("[" + (result*1+1) + "]번째 자료 처리중에 오류가 발생했습니다.\n상세오류 내역 : " + msg);
			} else {
				var errMsg = GLB_GDS.ErrorMsg;
				if (errMsg.lastIndexOf(":") != -1) {
					alert(errMsg.substr(errMsg.lastIndexOf(":")+1));
				} else if (errMsg.lastIndexOf("[TRAN") != -1) {
					alert(errMsg.substr(errMsg.lastIndexOf("[TRAN")+13));
				} else if (errMsg.lastIndexOf("[FRAMEWORK-ERROR]") != -1) {
					alert(errMsg.substr(errMsg.lastIndexOf("ERROR]")+7));
				} else {
					alert(errMsg);
				}

			}

		}
	}
}


/**
 * 트랜젝션 / 데이터셋등에서 메시지를 꺼내어 화면에 나타낸다.
 */
function cfSuccessMsg(p_obj, p_returnObj) {

	if (p_obj.ErrorMsg.indexOf("@") != -1)
	{
		var result = p_obj.ErrorMsg.substring(0, p_obj.ErrorMsg.indexOf("@"));
		result = result.substring(result.indexOf("COMPLETE_RESULT:")+16);
		p_returnObj.innerHTML = "<b>" + result + "</b>";
		var msg    = p_obj.ErrorMsg.substring(p_obj.ErrorMsg.indexOf("@")+1);
		alert(msg);
	} else {
		var errMsg = p_obj.ErrorMsg;
		if (errMsg.lastIndexOf(":") != -1) {
			alert(errMsg.substr(errMsg.lastIndexOf(":")+1));
		} else if (errMsg.lastIndexOf("[TRAN") != -1) {
			alert(errMsg.substr(errMsg.lastIndexOf("[TRAN")+13));
		} else {
			alert(errMsg);
		}
	}
}

/*************************************************************************
 * cfShowCalendar(oItem, month, year, format)
 *************************************************************************
 * author : 최재원
 * date    : 2004/06/21
 * desc   : 달력을 뿌려준다.
 * param : oItem  : 달력을 선택했을때 값이 들어갈 오브젝트
 *         month  : 표시할 달력의 월 (생략가능)
 *         year   : 표시할 달력의 년 (생략가능)
 *         foramt : 넘겨받을 값을 포멧 ( yyyymmdd, mmyy, yymm);
 *            두날짜의 차이를 반환 (日)
 *************************************************************************/
function cfShowCalendar(oItem, month, year, format, fnc) {
	var currDate = new Date();

	if (cfIsNull(month)) {
		month = currDate.getMonth() + 1;
	}

	if (cfIsNull(year)) {
		year = currDate.getFullYear();
	}

	if (cfIsNull(format)) {
		format = "YYYY-MM-DD";
	}

	if (oItem.tagName == "OBJECT" &&
		oItem.attributes.classid.nodeValue.toUpperCase() == "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" ) {
		GLB_CALENDAR.eventSrc = oItem;
	} else {
		GLB_CALENDAR.eventSrc = event.srcElement;
	}

	GLB_CALENDAR.oItem = oItem.id;
	GLB_CALENDAR.month = month;
	GLB_CALENDAR.year = year;
	GLB_CALENDAR.format = format;
	GLB_CALENDAR.fnc = fnc;

	var dwn = document.createElement("DOWNLOAD");

	dwn.style.behavior="url(#default#download)";
	dwn.startDownload("/common/calendar.html", cfOnDoneDownLoadCalendar);
}


function cfOnDoneDownLoadCalendar(src) {
	GLB_CALENDAR.popup = window.createPopup();
	GLB_CALENDAR.popup.document.write(src);
	GLB_CALENDAR.popup.document.all("oItem").value = GLB_CALENDAR.oItem;
	GLB_CALENDAR.popup.document.all("oMonth").value = GLB_CALENDAR.month - 1;
	GLB_CALENDAR.popup.document.all("oYear").value = GLB_CALENDAR.year;
	GLB_CALENDAR.popup.document.all("oFormat").value = GLB_CALENDAR.format;
	GLB_CALENDAR.popup.document.all("oRefreshBtn").fireEvent("onclick");
	GLB_CALENDAR.popup.show(0, 0, 198, 211, GLB_CALENDAR.eventSrc);
}

/*************************************************************************
 * cfIsNull(p_value)
 *************************************************************************
 * author : 최재원
 * date    : 2004/06/21
 * desc   : 파라미터로받은 값이 null인지를 판단
 * param : p_value  : 값
 * ex      : var result = cfIsNull(p_addr);
 *            두날짜의 차이를 반환 (日)
 *************************************************************************/
function cfIsNull(value) {
	if (value == null || (typeof(value) == "string" && value.trim() == "")) {
		return true;
	}
	return false;
}


/*************************************************************************
 * cfGetAgencyName(p_AgencyCode, p_AgencyName, p_Form)
 *************************************************************************
 * author : 최재원
 * date    : 2005/10/29
 * desc   : 대리점 코드를 넣어서 대리점 코드명을 반환
 * param : p_AgencyCode 대리점 코드명이 입력되는 오브젝트,
 *         p_AgencyName 대리점명이 입력되는 오브젝트.
 *         p_Form 폼이름
 *************************************************************************/
function cfGetAgencyName(p_AgencyCode, p_AgencyName, p_Form) {
	if (p_AgencyCode.value.length >= 3) {
		try	{
			document.all.coAgencyNameFrm.outerHTML = "";
		} catch (exception) {}
		var result = document.all.coAgencyNameFrm;
		if (typeof(result) == "undefined") {
			var new_obj = document.createElement("<iframe src='/blank.html'>");
			new_obj.id = "coAgencyNameFrm";
			new_obj.width = 0;
			new_obj.height = 0;
			var obj = document.body;
			obj.insertAdjacentElement("afterBegin", new_obj);
		}
		var url = "../../common/agencyName.jsp?AGENCY_CODE=" + p_AgencyCode.value + "&RETURN=" + p_AgencyName.name +"&FORM="+ p_Form + "&DUMMY=" + Math.random(1)*10000;

		var obj = document.all.coAgencyNameFrm;
		obj.src=url;
	} else {
		p_AgencyName.value = "";
	}
}



/**
 * @type   : function
 * @access : public
 * @desc   : 화면상의 입력과 관련된 오브젝트에 대한 유효성 검사를 실시한다. 유효성 검사를 받는 오브젝트들은 "validExp" 라는
 *           속성값을 설정해야 한다. "validExp" 라는 속성은 원래 html 객체에는 정의되어 있지 않은 속성이지만 다른 속성들을
 *           설정하는 것과 같은 방법으로 설정하면 자동으로 해당 오브젝트의 속성으로 인식된다.<br><br>
 *           - 해당 오브젝트에 대한 child 오브젝트들까지도 검사한다. 예를들어, 검사받을 오브젝트들을 &lt;div&gt; 태그로 감싸고
 *             &lt;div&gt; 태그의 id를 파라미터로 준다면 &lt;div&gt; 태그내의 모든 오브젝트들이 자동으로 검사받게 된다. 또,
 *             &lt;table&gt;안에 입력필드들은 &lt;table&gt;의 id를 파라미터로 주면 된다.<br><br>
 *           - 입력값의 앞과 뒤의 공백은 유효성 검사를 하면서 자동으로 trim된다.
 * <pre>
 *    예1)
 *    ...
 *    function fncSave() {
 *        if (<b>cfValidate([oRecevInfo])</b>) {
 *            oDomRegiRecevGTR.post();
 *        }
 *    }
 *    ...
 *
 *    &lt;table <b>id="oRecevInfo"</b> ....&gt;
 *        ...
 *        &lt;object id="oRecevNo" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="50" <b>validExp="접수번호:yes:length=6"</b>&gt;
 *            &lt;param name="Format"    value="000000"&gt;
 *        &lt;/object&gt;
 *        ...
 *    &lt;/table&gt;
 *    ...
 * </pre>
 * validExp 속성값은 정해진 형식에 맞게 작성되어야 하는데 형식은 오브젝트의 종류에 따라 두 가지로 나뉜다.<br>
 * <pre>
 *    1. 일반 오브젝트의 경우 (예1 참조)
 *        "item_name:필수여부:valid_expression"
 *
 *        - "item_name"에는 해당 항목에 대한 이름을 기술한다.
 *        - "필수여부"에는 해당 오브젝트가 필수 항목인지 여부를 yes|true|1 혹은 no|false|0 타입으로 기술한다.
 *        - "valid_expression" 은  cfValidateValue 함수의 설명을 참조하기 바란다.
 *        - 필수항목인지만 체크하려면 "valid_expression" 을 표기하지 않으면 된다.
 *          예)
 *          &lt;object id="oDelivYmd" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="80" <b>validExp="배달일자:yes"</b>&gt;
 *              ...
 *			&lt;/object&gt;
 *        - validExp 내에 임의로 ",", ":", "=", "&", 문자를 사용하고자 한다면 "\\,", "\\:", "\\=", "\\&" 라고 표기해야 한다.<br>
 *
 *
 *    2. 가우스 Grid 오브젝트의 경우
 *        "column_id:item_name:필수여부[:valid_expression[:key]][,column_name:item_name:필수여부[:valid_expression[:key]]]..."
 *
 *        - column_id 에는  Grid와 연결된 DataSet의 실제 컬럼 id 를 적어준다.
 *
 *        - <font color=blue><b>dataName</b></font> 이라는 속성도 기술해 주어야 한다. dataName은 해당 DataSet
 *          을 표현하는 이름을 기술해 주면 된다.
 *
 *        - <font color=blue><b>validFeatures</b></font> 라는 속성은 필요에 따라 기술해 주어야 한다. validFeatures은 Grid Validation
 *          수행시에 필요한 수행조건을 기술해 주는 속성으로써 기술해 주지 않으면 기본 수행조건이 자동으로 적용된다.
 *          표현하는 형식은 <b>validFeatures="수행조건명1=수행조건값1,수행조건명2=수행조건값2, ... 수행조건명n=수행조건값n"</b> 이다.
 *          현재 사용가능한 수행조건은 다음과 같다.
 *
 *          ignoreStatus : 변경사항이 없는 Row 에 대해서도 validation을 수행할지 여부. (yes|true|1 or no|false|0)
 *
 *        예)
 *
 *        cfValidate([oDomRegiRecevGG]);
 *        ...
 *        &ltobject id="oDomRegiRecevGG" classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"
 *           width="174" height="233" style="position:absolute; left:10; top:73;" <b>dataName="배달결과리스트"</b> <b>validFeatures="ignoreStatus=yes"</b>
 *         <b>validExp="regiNo:등기번호:yes:length=13:key,
 *                  sendPrsnZipNo:발송인우편번호:yes:length=6,
 *                  recPrsnZipNo:수취인우편번호:yes:length=6
 *                 "</b>
 *        &gt;
 *
 *        - 만약 item_name을 기술하지 않았을 경우에는 Grid의 column_id에 해당하는 컬럼의 컬럼명으로 자동으로 대체된다.
 *          예) validExp="regiNo::yes:length=13, ..."
 *
 *        - 만약 컬럼이 key컬럼일 경우에는 끝에 "key" 라고 명시해 준다. "key" 라고 명시해 주면 다른 Row와 데이터가 중복되었을 때
 *          에러를 발생시킨다. key컬럼이 여럿일 경우에는 key컬럼들을 묶어서 하나의 key로 인식하기 때문에 key컬럼중에 하나만
 *          중복이 되지 않아도 전체가 중복되지 않은 것으로 처리된다. key컬럼들을 믂어서 처리하지 않고 key컬럼별로 개별적인
 *          중복체크를 원할 경우에는 "singleKey" 라고 명시하면 된다.
 *          단, key를 명시해 줄 경우에는 valid_expression 을 반드시 기입해 주고 기입해 줄 내용이 없더라도
 *          ':' 을 삽입해야 한다.
 *          예) validExp="regiNo:등기번호:yes::key, ...
 *
 *        - 나머지는 1의 경우와 같다.
 * </pre>
 * @sig    : objArr
 * @param  : objectArr required 유효성검사를 하고자 하는 오브젝트들의 Array.
 * @return : boolean. 유효성 여부.
 * @author : 최재원
 */
function cfValidate(obj) {
	if (cfIsNull(obj)) {
		return;
	}

	var objArr;
	var oElement;
	var validYN = false;
	if (obj.length == null) {
		objArr = new Array(1);
		objArr[0] = obj;
	} else {
		objArr = obj;
	}
	for (var objArrIdx = 0; objArrIdx < objArr.length; objArrIdx++) {
		oElement = objArr[objArrIdx];
		switch (oElement.tagName) {
			case "TABLE":
			case "DIV":
			case "FIELDSET":
				for (var i = 0; i < oElement.all.length; i++) {
					if (!cfValidateElement(oElement.all[i])) {
						return false;
					}
				}
				break;
			default:
				if (!cfValidateElement(oElement)) {
					return false;
			}
		}
	}
	return true;
}




/**
 * @type   : function
 * @access : private
 * @desc   : 가우스와 html 의 모든 오브젝트에 대해 유효성 검사를 한다.
 * @sig    : oElement
 * @param  : oElement required 검사 대상 Element.
 * @return : boolean. 유효성 여부.
 * @author : 최재원
 */
function cfValidateElement(oElement) {
	if (oElement.tagName == "OBJECT" &&
	    oElement.attributes.classid.nodeValue.toUpperCase() == "CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B"
	   ) {
		return cfValidateGrid(oElement);
	} else {

		return cfValidateItem(oElement);
	}
}



/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 Grid에 대해 유효성 검사를 한다. 유효성 검사를 위해서는 Grid의 DataId에 지정된 DataSet에 validExp 속성이
 *           지정되어 있어야 한다. 지정방법은 cfValidate 함수에 대한 설명을 참조하기 바란다. (내부적으로는 Grid를 검사하는 것이 아니라
 *           Grid의 DataId에 지정된 DataSet에 대한 유효성 검사이다.)
 * @sig    : oGrid[, row[, colId]]
 * @param  : oGrid required 검사 대상 Grid.
 * @param  : row   optional 검사하고자 하는 row 번호
 * @param  : colId optional 검사하고자 하는 컬럼의 id
 * @return : boolean. 유효성 여부.
 * @author : 최재원
 */
function cfValidateGrid(oGrid, row, colId) {

	if (cfIsNull(oGrid.validExp)) {
		return true;
	}
	var dataName = oGrid.dataName;
	var validFeatures = oGrid.validFeatures;
	var oDataSet = document.all(oGrid.DataId);
	var gridValidExp = new covGridValidExp(oGrid);
	var errMsg = "";
	var featureNames  = ["ignoreStatus"];
	var featureValues = [false];
	var featureTypes  = ["boolean"];
	if (validFeatures != null) {
		cfParseFeature(validFeatures, featureNames, featureValues, featureTypes);
	}
	var ignoreStatus = featureValues[0];
	if (!gridValidExp.validate(row, colId, ignoreStatus)) {
		if (typeof(gridValidExp.errColId) != "undefined")
		{
			GLB_ERR_COLID = gridValidExp.errColId;
			GLB_ERR_ROW = gridValidExp.errRow;
		}

		alert(new coMessage().getMsg("[@]의 [@]번째 데이터에서 ", [dataName, String(gridValidExp.errRow)]) +
		      new coMessage().getMsg(gridValidExp.errMsg, [gridValidExp.errItemName])
		     );
//		oDataSet.RowPosition = gridValidExp.errRow;  // 이순간 또다시 CanRowPosChange 이벤트가 발생하여 무한루프에 빠진다.
        if (oGrid.MultiRowSelect == false) {  // Grid의 MultiRowSelect 속성이 false일 경우에는 RowMark, MarkRows가
        	oGrid.MultiRowSelect = true;      // 지정한 row에 제대로 Marking을 하지 못한다. 따라서...
    		oDataSet.ClearAllMark();
    		oDataSet.RowMark(gridValidExp.errRow) = 1;
    		oGrid.SetColumn(gridValidExp.errColId);
    		oGrid.Focus();
            oGrid.MultiRowSelect = false;
        } else {
    		oDataSet.ClearAllMark();
    		oDataSet.RowMark(gridValidExp.errRow) = 1;
    		oGrid.SetColumn(gridValidExp.errColId);
    		oGrid.Focus();
        }
		return false;
	} else {
		GLB_ERR_COLID = "";
	}
	return true;
}



///////////////////////////// covGridValidExp /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : Grid에 대한 유효성검사 표현식
 * @sig    : oGrid
 * @param  : oGrid required 검사대상 Grid
 * @author : 최재원
 */
function covGridValidExp(oGrid) {
    // data;
    this.oGrid = oGrid;
    this.columnValidExps = new Array();
	this.errMsg;
	this.errRow;
	this.errColId;
	this.errItemName = "";

    // method
    this.parse = covGridValidExp_parse;
    this.validate = covGridValidExp_validate;

    // initialize
    this.parse();
}


/**
 * @type   : method
 * @access : public
 * @object : covGridValidExp
 * @desc   : valid expression을 parsing한다.
 */
function covGridValidExp_parse() {
	if (cfIsNull(this.oGrid) || cfIsNull(this.oGrid.validExp)) {
		return;
	}

	var columns = this.oGrid.validExp.trim().advancedSplit(",", "it");

	for (var i = 0; i < columns.length; i++) {
    	this.columnValidExps[i] = new covColumnValidExp(columns[i], this.oGrid);
	}
}


/**
 * @type   : method
 * @access : public
 * @object : covGridValidExp
 * @desc   : validation을 수행한다.
 * @sig    : [row[, colId[, ignoreStatus]]]
 * @param  : row optional 검사대상 Grid의 특정 row 번호
 * @param  : colId optional 검사대상 Grid의 특정 컬럼의 id
 * @param  : ignoreStatus optional Grid 검사시 row status에 상관없이 모두 검사할 것인지의 여부.
 */
function covGridValidExp_validate(row, colId, ignoreStatus) {
	var oDataSet = document.all(this.oGrid.DataId);
	if (oDataSet == null ||
	    oDataSet.tagName != "OBJECT" ||
	    oDataSet.attributes.classid.nodeValue.toUpperCase() !== "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" ||
	    oDataSet.CountRow < 1
	   ) {
	   	return true;
	}

	var startIdx;
	var endIdx;
	var nestedStartIdx;
	var nestedEndIdx;
	var keyColValidExps = new Array();
	var singleKeyColValidExps = new Array();

	// 키컬럼 추출
	var keyColCnt = 0;
	var singleKeyColCnt = 0;
	for (var i = 0; i < this.columnValidExps.length; i++) {
		if (this.columnValidExps[i].property == "KEY") {
			keyColValidExps[keyColCnt++] = this.columnValidExps[i];
		} else if (this.columnValidExps[i].property == "SINGLEKEY") {
			singleKeyColValidExps[singleKeyColCnt++] = this.columnValidExps[i];
		}
	}
	if (row != null) {
		startIdx = row;
		endIdx = row;
	} else {
		startIdx = 1;
		endIdx = oDataSet.CountRow - 1;
	}
	// 중복키 체크
	if (keyColValidExps.length > 0 || singleKeyColValidExps.length > 0) {
		var isEqual;
		for (var i = startIdx; i <= endIdx; i++) {
			if (row != null) {
				nestedStartIdx = 1;
			} else {
				nestedStartIdx = i + 1;
			}
			for (j = nestedStartIdx; j <= oDataSet.CountRow; j++) {
				if (i == j) {
					continue;
				}
				// 일반키컬럼 검사.
				{
					isEqual = true;
					for (var k = 0; k < keyColValidExps.length; k++) {
						if (oDataSet.NameValue(i, keyColValidExps[k].colId) !=
						    oDataSet.NameValue(j, keyColValidExps[k].colId)
						   ) {
						   	isEqual = false;
							GLB_ERR_COLID = "";
							GLB_ERR_ROW = -1;
						   	break;
						} else {
							GLB_ERR_COLID = keyColValidExps[k].colId;
							GLB_ERR_ROW = j;
						}
					}
					if (isEqual) {

						this.errMsg = cfGetMsg( "[@]은(는) 중복될 수 없습니다.", ["@"]);

						if (row != null) {
							this.errRow = row;  // row를 지정하였을 때는 해당 row에 대한 error로 간주
						} else {
							this.errRow = j; // row지정이 없으면 중복된 두개의 데이터중 순서상 나중에 있는 row를 error로 간주
						}
						for (var k = 0; k < keyColValidExps.length; k++) {
							this.errItemName = this.errItemName + keyColValidExps[k].itemValidExp.itemName + ", ";
						}
						this.errItemName = this.errItemName.substring(0, this.errItemName.lastIndexOf(","));
						return false;
					}
				}
				// 싱글키컬럼 검사.
				for (var k = 0; k < singleKeyColValidExps.length; k++) {
					if (oDataSet.NameValue(i, singleKeyColValidExps[k].colId) ==
					    oDataSet.NameValue(j, singleKeyColValidExps[k].colId)
					   ) {
						this.errMsg = cfGetMsg(MSG_COM_ERR_032, ["@"]);
						if (row != null) {
							this.errRow = row;  // row를 지정하였을 때는 해당 row에 대한 error로 간주
						} else {
							this.errRow = j; // row지정이 없으면 중복된 두개의 데이터중 순서상 나중에 있는 row를 error로 간주
						}
						this.errItemName = singleKeyColValidExps[k].itemValidExp.itemName;
						return false;
					}
				}
			}
		}
	}
	if (row != null) {
		startIdx = row;
		endIdx = row;
	} else {
		startIdx = 1;
		endIdx = oDataSet.CountRow;
	}

	// validation 수행
	for (var i = startIdx; i <= endIdx; i++) {
		if (ignoreStatus || oDataSet.RowStatus(i) != 0) {
			for (var j = 0; j < this.columnValidExps.length; j++) {
				columnValidExp = this.columnValidExps[j];
				if (!columnValidExp.validate(oDataSet, i)) {
					this.errMsg = columnValidExp.errMsg;
					this.errRow = i;
					this.errColId = columnValidExp.colId;
					this.errItemName = columnValidExp.errItemName;
					return false;
				}
			}
		}
	}
	return true;
}





///////////////////////////// covColumnValidExp /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : Grid의 컬럼 유효성 검사 표현식
 * @sig    : expression, oGrid
 * @param  : expression required valid expression string.
 * @param  : oGrid      required 검사대상 Grid 오브젝트
 * @author : 최재원
 */
function covColumnValidExp(expression, oGrid) {
    // data;
    this.colId;
    this.errMsg = "";
    this.errRow = -1;
    this.errItemName = "";
    this.itemValidExp;
    this.property = "NORMAL";  // NORMAL, KEY, SINGLEKEY 속성이 있다.

    // method
    this.parse    = covColumnValidExp_parse;
    this.validate = covColumnValidExp_validate;

    // initialize
    this.parse(expression, oGrid);
}



/**
 * @type   : method
 * @access : public
 * @object : covColumnValidExp
 * @desc   : valid expression을 parsing한다.
 * @sig    : expression, oGrid
 * @param  : expression required valid expression string.
 * @param  : oGrid      required 검사대상 Grid 오브젝트
 */
function covColumnValidExp_parse(expression, oGrid) {
	var index = -1;
	var expArr = expression.advancedSplit(":", "i");
	if (expArr.length < 3) {
		return;
	}
	var itemName = null;
	this.colId = expArr[0].trim();
	if (new coGridFormat(oGrid.Format).existsColumn(this.colId)) {
		itemName = oGrid.ColumnProp(this.colId, "Name");
	}

	this.itemValidExp = new covItemValidExp(expArr[1] + ":" + expArr[2] + ":" + expArr[3], itemName);
	if (!cfIsNull(expArr[4]) && expArr[4].toUpperCase().trim() == "KEY") {
		this.property = "KEY";
	} else if (!cfIsNull(expArr[4]) && expArr[4].toUpperCase().trim() == "SINGLEKEY") {
		this.property = "SINGLEKEY";
	}
}



/**
 * @type   : method
 * @access : public
 * @object : covColumnValidExp
 * @desc   : validation을 수행한다.
 * @sig    : oDataSet, row
 * @param  : oDataSet required 검사대상 DataSet
 * @param  : row required 검사대상 DataSet의 특정 row 번호
 */
function covColumnValidExp_validate(oDataSet, row) {
	if (oDataSet == null ||
	    oDataSet.tagName != "OBJECT" ||
	    oDataSet.attributes.classid.nodeValue.toUpperCase() !== "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" ||
	    oDataSet.CountRow < 1
	   ) {
	   	return true;
	}

	var startIdx = 1;
	var endIdx = oDataSet.CountRow;
	var value;
	var rowYN = false;

	if (row != null) {
		startIdx = row;
		endIdx = row;
		rowYN = true;
	}

	for (var i = startIdx; i <= endIdx; i++) {
		value = (oDataSet.NameValue(i, this.colId) == null) ? null : oDataSet.NameString(i, this.colId).trim();  // DataSet의 data를 trim 시킨다.

		if (this.itemValidExp != null && !this.itemValidExp.validate(value)) {
			this.errMsg = this.itemValidExp.errMsg;
			this.errRow = i;
			this.errItemName = this.itemValidExp.itemName;
			return false;
		}
	}
	return true;
}


///////////////////////////// coGridFormat /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : Grid Format을 파싱한 후 정보를 저장한다.
 * @author : 최재원
 */
function coGridFormat(format) {
	this.format = format;
	this.columns = new Array();
	// method
	this.existsColumn = coGridFormat_existsColumn;
	this.parse  = coGridFormat_parse;

	// initialize
	this.parse();
}

/**
 * @type   : method
 * @access : parse
 * @object : coGridFormat
 * @desc   : 파싱한다.
 */
function coGridFormat_parse() {
	var tagRE = /<(fc|c|g|fg|x|fx)>/i;
	var colAttrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;
	var gFormat = this.format;
	var tagMatch;
	var colAttrData;
	var colAttrMatch;
	var colAttrName;
    var colAttrValue;
	var colCnt = 0;

	while ((tagMatch = gFormat.match(tagRE)) != null) {
		this.columns[colCnt] = new coGridColumn();
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {
			colAttrName = colAttrMatch[1].toUpperCase();
			colAttrValue = colAttrMatch[2];
			this.columns[colCnt].setAttribute(colAttrName, colAttrValue);
			colAttrData = colAttrData.substr(colAttrMatch.lastIndex);
		}

		gFormat = gFormat.substr(tagMatch.lastIndex);
		colCnt++;
	}
}


/**
 * @type   : method
 * @access : public
 * @object : coGridFormat
 * @desc   : Grid에 선언된 컬럼들 중에서 특정 colid를 가진 컬럼이 존재하는지를 알려준다.
 * @sig    : colId
 * @param  : colId required 속성명
 * @return : 컬럼 존재여부
 */
function coGridFormat_existsColumn(colId) {
	for (var i = 0; i < this.columns.length; i++) {
		if (this.columns[i].hasAttribute("ID") &&
		    this.columns[i].getAttribute("ID") == colId) {
			return true;
		}
	}

	return false;
}



///////////////////////////// coGridColumn /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : Grid 에 선언된 컬럼정보를 담고있는 객체이다.
 * @author : 최재원
 */
function coGridColumn() {
	this.attrNames = new Array();
	this.attrValues = new Array();
	this.attrCnt = 0;

	// method
	this.hasAttribute = coGridColumn_hasAttribute;
	this.setAttribute = coGridColumn_setAttribute;
	this.getAttribute = coGridColumn_getAttribute
}


/**
 * @type   : method
 * @access : public
 * @object : coGridColumn
 * @desc   : 컬럼에 특정 속성이 정의되어 있는지 알려준다.
 * @sig    : attrName
 * @param  : attrName required 속성명
 * @return : 속성 존재여부
 */
function coGridColumn_hasAttribute(attrName) {
	for (var i = 0; i < this.attrCnt; i++) {

	if (attrName.toUpperCase() == this.attrNames[i].toUpperCase()) {
			return true;
		}
	}

	return false;
}


/**
 * @type   : method
 * @access : public
 * @object : coGridColumn
 * @desc   : 컬럼에 새로운 속성을 추가한다.
 * @sig    : attrName, attrValue
 * @param  : attrName required 속성명
 * @param  : attrValue required 속성값
 * @return : 속성 존재여부
 */
function coGridColumn_setAttribute(attrName, attrValue) {
	this.attrNames[this.attrCnt]  = attrName.toUpperCase();
	this.attrValues[this.attrCnt] = attrValue;
	this.attrCnt++;
}


/**
 * @type   : method
 * @access : public
 * @object : coGridColumn
 * @desc   : 컬럼의 특정 속성값을 알려준다.
 * @sig    : attrName
 * @param  : attrName required 속성명
 * @return : 속성값
 */
function coGridColumn_getAttribute(attrName) {
	for (var i = 0; i < this.attrCnt; i++) {
		if (this.attrNames[i] == attrName) {

		return this.attrValues[i];
		}
	}
}



///////////////////////////// covItemValidExp /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 유효성 검사에 대한 표현(expression)을 객체화 하였다.
 *             - expression 형식<br>
 *               항목이름:필수항목여부:유효성항목<br>
 *               예) "접수번호:yes:length=6"
 *             - 유효성 항목 형식
 *               유효성항목명=유효값[&유효성항목명=유효값]..
 *               예) "length=13&ssn"
 * @sig    : expression, itemName
 * @param  : expression required valid expression string.
 * @param  : itemName   required 아이템명
 * @author : 최재원
 */
function covItemValidExp(expression, itemName) {
    // data;
    this.itemName;
    this.required;
    this.valueValidExp;

    // method
    this.parse = covItemValidExp_parse;
    this.validate = covItemValidExp_validate;

    // initialize
    this.parse(expression, itemName);
}



/**
 * @type   : method
 * @access : public
 * @object : covItemValidExp
 * @desc   : valid expression을 parsing한다.
 * @sig    : expression, itemName
 * @param  : expression required valid expression string.
 * @param  : itemName   required 아이템명
 */
function covItemValidExp_parse(expression, itemName) {
	if (cfIsNull(expression)) {
		return;
	}
	var columns = expression.advancedSplit(":", "i");

	if (cfIsNull(columns[1])) {
		return;
	}

	if (cfIsNull(columns[0])) {
		if (!cfIsNull(itemName)) {
			this.itemName = itemName.trim();
		} else {
			return;
		}
	} else {
		this.itemName = columns[0].trim();
	}

	this.required = (columns[1].trim().toUpperCase() == "YES" ||
	                 columns[1].trim().toUpperCase() == "TRUE" ||
	                 columns[1].trim() == "1"
	                ) ? true : false;
	if ((columns[2]) != null) {
		this.valueValidExp = new covValueValidExp(columns[2].trim());
	}
}



/**
 * @type   : method
 * @access : public
 * @object : covItemValidExp
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 검사할 값
 */
function covItemValidExp_validate(value) {
	// 표현식에 필수항목들(아이템명, 필수여부)을 기술하지 않을 경우는 표현식이 없다고 간주.
	if (cfIsNull(this.itemName) || cfIsNull(this.required)) {
		return true;
	}

	if (this.required && cfIsNull(value)) {
		this.errMsg = "[@]은(는) 필수 입력 항목입니다.";
		return false;
	}

	if (!this.required && cfIsNull(value)) {
		return true;
	}

	if (this.valueValidExp == null) {
		return true;
	}

	if (!this.valueValidExp.validate(value)) {
		this.errMsg = this.valueValidExp.errMsg;
		return false;
	}
	return true;
}



//-------------------------- 유효성 검사를 위한 객체 선언 -----------------------------//

/*
 * @Validator 객체의 구조
 *   - 속성 : exception,   -> validity의 sub속성이다. validity가 true면 exception은 무조건 false이고
 *                            validity가 false인 경우 false의 원인이 exception인지 여부를 알려준다.
 *                            exception은 사용자 입력에 대한 실제 validation과는 무관한 에러를 의미한다.
 *                            true/false 중 하나.
 *            message,     -> 오류메세지를 담고 있다.
 *            validity,    -> 유효성검사결과를 담고 있다. true/false 중 하나.
 *            value        -> 유효성 검사 대상 값.
 *
 *   - 메소드 : validate() -> 유효성 검사를 수행한다.
 *                            유효할 경우, validity를 true로하고 true를 return하고
 *                            유효하지 않을 경우,  validity를 false로하고 false를 return하고
 *                            message에 오류메세지를 기술한다.
 *                            exception의 경우는 exception을 true로 하고 message에 메세지를 기술한다.
 *
 *   - 추가시 할일 :
 *     1) validator객체를 정의한다.
 *     2) covValidExp 객체의 getValidators 메소드에 validator객체를 등록한다.
 */


///////////////////////////// covValueValidExp /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 유형 검사에 대한 표현(expression)을 객체화 하였다.
 *             - expression 형식<br>
 *               항목이름:필수항목여부:유효성항목<br>
 *               예) "접수번호:yes:length=6"
 *             - 유효성 항목 형식
 *               유효성항목명=유효값[&유효성항목명=유효값]..
 *               예) "length=13&ssn"
 * @sig    : expression
 * @param  : expression required valid expression string.
 * @author : 최재원
 */
function covValueValidExp(expression) {
    // data;
    this.validItems = new Array();
    this.errMsg = "";

    // method
    this.init = covValueValidExp_init;
    this.parse = covValueValidExp_parse;
    this.validate = covValueValidExp_validate;
    // initialize
    this.init(expression);
}

/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : 초기화를 수행한다.
 * @sig    : expression
 * @param  : expression required valid expression string.
 * @author : 최재원
 */
function covValueValidExp_init(expression) {
	this.parse(expression);
}



/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : covValidExp 객체의 parse 메소드.
 *           valid expression을 parsing한다.
 * @sig    : expression
 * @param  : expression required valid expression string.
 */
function covValueValidExp_parse(expression) {
	if (cfIsNull(expression)) {
		return;
	}
	var validItemExps = expression.advancedSplit("&", "i");
	var validItem;

	for (var i = 0; i < validItemExps.length; i++) {
		validItemPair = validItemExps[i].trim().advancedSplit("=", "i");
		validItem = new Object();
		validItem.name  = validItemPair[0].trim();
		validItem.value = validItemPair[1];  // parsedExp[1] 은 존재하지 않을 수도 있지만 자바스크립트에서는
		this.validItems[i] = validItem;      // 이런 경우 "undefined" 라는 값을 리턴한다.
	}
}



/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 검사대상값
 */
function covValueValidExp_validate(value) {
	var validators = new Array();
	var count = 0;

	for (var i = 0; i < this.validItems.length; i++) {
		switch (this.validItems[i].name) {
			case "length" :
				validators[count++] = new covLengthValidator(this.validItems[i].value);
				break;
			case "byteLength" :
				validators[count++] = new covByteLengthValidator(this.validItems[i].value);
				break;
			case "minLength" :
				validators[count++] = new covMinLengthValidator(this.validItems[i].value);
				break;
			case "minByteLength" :
				validators[count++] = new covMinByteLengthValidator(this.validItems[i].value);
				break;
			case "maxLength" :
				validators[count++] = new covMaxLengthValidator(this.validItems[i].value);
				break;
			case "maxByteLength" :
				validators[count++] = new covMaxByteLengthValidator(this.validItems[i].value);
				break;
			case "number" :
				validators[count++] = new covNumberValidator(this.validItems[i].value);
				break;
			case "minNumber" :
				validators[count++] = new covMinNumberValidator(this.validItems[i].value);
				break;
			case "maxNumber" :
				validators[count++] = new covMaxNumberValidator(this.validItems[i].value);
				break;
			case "inNumber" :
				validators[count++] = new covInNumberValidator(this.validItems[i].value);
				break;
			case "minDate" :
				validators[count++] = new covMinDateValidator(this.validItems[i].value);
				break;
			case "maxDate" :
				validators[count++] = new covMaxDateValidator(this.validItems[i].value);
				break;
			case "format" :
				validators[count++] = new covFormatValidator(this.validItems[i].value);
				break;
			case "ssn" :
				validators[count++] = new covSsnValidator(this.validItems[i].value);
				break;
			case "csn" :
				validators[count++] = new covCsnValidator(this.validItems[i].value);
				break;
			case "filterIn" :
				validators[count++] = new covFilterInValidator(this.validItems[i].value);
				break;
			case "filterOut" :
				validators[count++] = new covFilterOutValidator(this.validItems[i].value);
				break;
			case "email" :
				validators[count++] = new covEmailValidator(this.validItems[i].value);
				break;
			case "date" :
				validators[count++] = new covDateValidator(this.validItems[i].value);
				break;
			default :
				break;
		}
	}

	for (var i = 0; i < validators.length; i++) {
		if (!validators[i].validate(value)) {
			this.errMsg = validators[i].message;
			return false;
		}
	}
	return true;
}




/**
 * @type   : function
 * @access : public
 * @desc   : 화면상의 입력과 관련된 오브젝트에 대한 유효성 검사를 실시한다. 유효성 검사를 받는 오브젝트들은 "validExp" 라는
 *           속성값을 설정해야 한다. "validExp" 라는 속성은 원래 html 객체에는 정의되어 있지 않은 속성이지만 다른 속성들을
 *           설정하는 것과 같은 방법으로 설정하면 자동으로 해당 오브젝트의 속성으로 인식된다.<br><br>
 *           - 해당 오브젝트에 대한 child 오브젝트들까지도 검사한다. 예를들어, 검사받을 오브젝트들을 &lt;div&gt; 태그로 감싸고
 *             &lt;div&gt; 태그의 id를 파라미터로 준다면 &lt;div&gt; 태그내의 모든 오브젝트들이 자동으로 검사받게 된다. 또,
 *             &lt;table&gt;안에 입력필드들은 &lt;table&gt;의 id를 파라미터로 주면 된다.<br><br>
 *           - 입력값의 앞과 뒤의 공백은 유효성 검사를 하면서 자동으로 trim된다.
 * <pre>
 *    예1)
 *    ...
 *    function fncSave() {
 *        if (<b>cfValidate([oRecevInfo])</b>) {
 *            oDomRegiRecevGTR.post();
 *        }
 *    }
 *    ...
 *
 *    &lt;table <b>id="oRecevInfo"</b> ....&gt;
 *        ...
 *        &lt;object id="oRecevNo" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="50" <b>validExp="접수번호:yes:length=6"</b>&gt;
 *            &lt;param name="Format"    value="000000"&gt;
 *        &lt;/object&gt;
 *        ...
 *    &lt;/table&gt;
 *    ...
 * </pre>
 * validExp 속성값은 정해진 형식에 맞게 작성되어야 하는데 형식은 오브젝트의 종류에 따라 두 가지로 나뉜다.<br>
 * <pre>
 *    1. 일반 오브젝트의 경우 (예1 참조)
 *        "item_name:필수여부:valid_expression"
 *
 *        - "item_name"에는 해당 항목에 대한 이름을 기술한다.
 *        - "필수여부"에는 해당 오브젝트가 필수 항목인지 여부를 yes|true|1 혹은 no|false|0 타입으로 기술한다.
 *        - "valid_expression" 은  cfValidateValue 함수의 설명을 참조하기 바란다.
 *        - 필수항목인지만 체크하려면 "valid_expression" 을 표기하지 않으면 된다.
 *          예)
 *          &lt;object id="oDelivYmd" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="80" <b>validExp="배달일자:yes"</b>&gt;
 *              ...
 *			&lt;/object&gt;
 *        - validExp 내에 임의로 ",", ":", "=", "&", 문자를 사용하고자 한다면 "\\,", "\\:", "\\=", "\\&" 라고 표기해야 한다.<br>
 *
 *
 *    2. 가우스 Grid 오브젝트의 경우
 *        "column_id:item_name:필수여부[:valid_expression[:key]][,column_name:item_name:필수여부[:valid_expression[:key]]]..."
 *
 *        - column_id 에는  Grid와 연결된 DataSet의 실제 컬럼 id 를 적어준다.
 *
 *        - <font color=blue><b>dataName</b></font> 이라는 속성도 기술해 주어야 한다. dataName은 해당 DataSet
 *          을 표현하는 이름을 기술해 주면 된다.
 *
 *        - <font color=blue><b>validFeatures</b></font> 라는 속성은 필요에 따라 기술해 주어야 한다. validFeatures은 Grid Validation
 *          수행시에 필요한 수행조건을 기술해 주는 속성으로써 기술해 주지 않으면 기본 수행조건이 자동으로 적용된다.
 *          표현하는 형식은 <b>validFeatures="수행조건명1=수행조건값1,수행조건명2=수행조건값2, ... 수행조건명n=수행조건값n"</b> 이다.
 *          현재 사용가능한 수행조건은 다음과 같다.
 *
 *          ignoreStatus : 변경사항이 없는 Row 에 대해서도 validation을 수행할지 여부. (yes|true|1 or no|false|0)
 *
 *        예)
 *
 *        cfValidate([oDomRegiRecevGG]);
 *        ...
 *        &ltobject id="oDomRegiRecevGG" classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"
 *           width="174" height="233" style="position:absolute; left:10; top:73;" <b>dataName="배달결과리스트"</b> <b>validFeatures="ignoreStatus=yes"</b>
 *         <b>validExp="regiNo:등기번호:yes:length=13:key,
 *                  sendPrsnZipNo:발송인우편번호:yes:length=6,
 *                  recPrsnZipNo:수취인우편번호:yes:length=6
 *                 "</b>
 *        &gt;
 *
 *        - 만약 item_name을 기술하지 않았을 경우에는 Grid의 column_id에 해당하는 컬럼의 컬럼명으로 자동으로 대체된다.
 *          예) validExp="regiNo::yes:length=13, ..."
 *
 *        - 만약 컬럼이 key컬럼일 경우에는 끝에 "key" 라고 명시해 준다. "key" 라고 명시해 주면 다른 Row와 데이터가 중복되었을 때
 *          에러를 발생시킨다. key컬럼이 여럿일 경우에는 key컬럼들을 묶어서 하나의 key로 인식하기 때문에 key컬럼중에 하나만
 *          중복이 되지 않아도 전체가 중복되지 않은 것으로 처리된다. key컬럼들을 믂어서 처리하지 않고 key컬럼별로 개별적인
 *          중복체크를 원할 경우에는 "singleKey" 라고 명시하면 된다.
 *          단, key를 명시해 줄 경우에는 valid_expression 을 반드시 기입해 주고 기입해 줄 내용이 없더라도
 *          ':' 을 삽입해야 한다.
 *          예) validExp="regiNo:등기번호:yes::key, ...
 *
 *        - 나머지는 1의 경우와 같다.
 * </pre>
 * @sig    : objArr
 * @param  : objectArr required 유효성검사를 하고자 하는 오브젝트들의 Array.
 * @return : boolean. 유효성 여부.
 * @author : 최재원
 */
function cfValidate(obj) {
	if (cfIsNull(obj)) {
		return;
	}

	var objArr;
	var oElement;
	var validYN = false;
	if (obj.length == null) {
		objArr = new Array(1);
		objArr[0] = obj;
	} else {
		objArr = obj;
	}
	for (var objArrIdx = 0; objArrIdx < objArr.length; objArrIdx++) {
		oElement = objArr[objArrIdx];
		switch (oElement.tagName) {
			case "TABLE":
			case "DIV":
			case "FIELDSET":
				for (var i = 0; i < oElement.all.length; i++) {
					if (!cfValidateElement(oElement.all[i])) {
						return false;
					}
				}
				break;
			default:
				if (!cfValidateElement(oElement)) {
					return false;
			}
		}
	}
	return true;
}



/**
 * @type   : object
 * @obj    : coMessage
 * @access : private
 * @desc   : 메세지를 관리하는 객체이다.
 * @author : 최재원
 */
function coMessage() {
	// method
	this.getMsg = coMessage_getMsg;
}


/**
 * @type   : method
 * @access : private
 * @object : coMessage
 * @desc   : 공통메세지에 정의된 메세지를 치환하여 알려준다.
 * @sig    : message[, paramArray]
 * @param  : message    required common.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다.)
 * @return : 치환된 메세지 스트링
 */
function coMessage_getMsg(message, paramArray) {
	if (cfIsNull(message)) {
		return null;
	}

	var index = 0;
	var re = /@/g;
	var count = 0;

	if (paramArray == null) {
		return message;
	}

	while ( (index = message.indexOf("@", index)) != -1) {
		if (paramArray[count] == null) {
			paramArray[count] = "";
		}

		message = message.substr(0, index) + String(paramArray[count]) +
		          message.substring(index + 1);

		index = index + String(paramArray[count++]).length;
	}
	return message;

}



///////////////////////////// covLengthValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'length' 항목에 대한 validator. 값이 지정된 길이를 가지고 있는지 검사한다.
 * @param  : length required 유효한 기준길이.
 * @author : 최재원
 */
function covLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covLengthValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covLengthValidator_validate(value) {
	if (value.length != this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_005, ["@", String(this.length)]);
		return false;
	}
	this.validity = true;
	return true;
}



///////////////////////////// covByteLengthValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'byteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이를 가지고 있는지 검사한다.
 * @param  : length required 유효한 기준길이.
 * @author : 최재원
 */
function covByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covByteLengthValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covByteLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covByteLengthValidator_validate(value) {
	if (cfGetByteLength(value) != this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_027, ["@", String(this.length), String(Math.floor(this.length / 2))]);
		return false;
	}

	this.validity = true;
	return true;
}



///////////////////////////// covMinLengthValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'minLength' 항목에 대한 validator. 값이 지정된 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.
 * @author : 최재원
 */
function covMinLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMinLengthValidator_validate;
}


/**
 * @type   : method
 * @access : public
 * @object : covMinLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinLengthValidator_validate(value) {
	if (value.length < this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_011, ["@", String(this.length)]);
		return false;
	}
	this.validity = true;
	return true;
}



///////////////////////////// covMinByteLengthValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'minByteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.
 * @author : 최재원
 */
function covMinByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMinByteLengthValidator_validate;
}


/**
 * @type   : method
 * @access : public
 * @object : covMinByteLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinByteLengthValidator_validate(value) {
	if (cfGetByteLength(value) < this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_028, ["@", String(this.length), String(Math.floor(this.length / 2))]);
		return false;
	}

	this.validity = true;
	return true;
}


///////////////////////////// covMaxLengthValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'maxLength' 항목에 대한 validator. 값이 지정된 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.
 * @author : 최재원
 */
function covMaxLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMaxLengthValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covMaxLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxLengthValidator_validate(value) {
	if (value.length > this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_012, ["@", String(this.length)]);
		return false;
	}
	this.validity = true;
	return true;
}


///////////////////////////// covMaxByteLengthValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'maxByteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이 이하인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.
 * @author : 최재원
 */
function covMaxByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMaxByteLengthValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covMaxByteLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxByteLengthValidator_validate(value) {
	if (cfGetByteLength(value) > this.length) {
		this.message = new coMessage().getMsg("[@]은(는) [@]자 이하로 입력하십시오. (한글은 [@]자 이하)", ["@", String(this.length), String(Math.floor(this.length / 2))]);
		return false;
	}

	this.validity = true;
	return true;
}



///////////////////////////// covNumberValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'number' 항목에 대한 validator. 값이 숫자인지를 검사한다. 또한 format을 지정하였을 경우에는 format에 맞는지 검사한다.
 * <pre>
 *     "number" 로 지정시 : 숫자인지 체크
 *     "number=(5.2)" 로 지정시 : 숫자이면서 정수부 5자리 이하, 소수부 2자리 이하인지를 체크
 * </pre>
 * @author : 최재원
 */
function covNumberValidator(format) {
    // data;
	re = /\(\s*(\d+)\s*.\s*(\d+)\s*\)/;
	this.iLength;
	this.dLength;
	this.message = "";
	this.validity = false;

    // method
    this.validate = covNumberValidator_validate;

	// initialize
	{
		if (cfIsNull(format)) {
			return;
		}
		r = format.match(re);

		if (r == null) {
			return;
		}

		this.iLength = Number(r[1]);
		this.dLength = Number(r[2]);
	}
}



/**
 * @type   : method
 * @access : public
 * @object : covNumberValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covNumberValidator_validate(value) {

	if (isNaN(value)) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);
		return false;
	} else if (!cfIsNull(this.iLength)) {
		var strValue = String(value);
		var idx = strValue.indexOf('.');
		var iNumStr = strValue.substr(0, idx);
		var dNumStr = strValue.substr(idx + 1);


		if (iNumStr.length > this.iLength) {
			this.message = new coMessage().getMsg(MSG_COM_ERR_059, ["@", String(this.iLength)]);
			return false;
		} else if (dNumStr.length > this.dLength) {
			this.message = new coMessage().getMsg(MSG_COM_ERR_060, ["@", String(this.dLength)]);
			return false;
		}
	}
	this.validity = true;
	return true;
}



///////////////////////////// covMinNumberValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'minNumber' 항목에 대한 validator. 값이 지정된 최소값을 넘는지를 검사한다.
 * @sig    : minNumber
 * @param  : minNumber required 유효한 기준 최소값.
 * @author : 최재원
 */
function covMinNumberValidator(minNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.minNumber = minNumber;

    // method
    this.validate = covMinNumberValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covMinNumberValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinNumberValidator_validate(value) {

	// 기준값이 숫자가 아닌경우 무조건 true;
	if (isNaN(this.minNumber)) {
		this.validity = true;
		return true;
	}


	if (isNaN(value)) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);
		return false;
	}

	this.minNumber = Number(this.minNumber);
	value          = Number(value);

	if (value < this.minNumber) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_013, ["@", String(this.minNumber)]);
		return false;
	}
	this.validity = true;
	return true;
}



///////////////////////////// covMaxNumberValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'maxNumber' 항목에 대한 validator. 값이 지정된 최대값을 넘지 않는지를 검사한다.
 * @sig    : maxNumber
 * @param  : maxNumber 유효한 기준 최대값.
 * @author : 최재원
 */
function covMaxNumberValidator(maxNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.maxNumber = (maxNumber == null) ? "" : maxNumber.trim();
    // method
    this.validate = covMaxNumberValidator_validate;
}


/**
 * @type   : method
 * @access : public
 * @object : covMaxNumberValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxNumberValidator_validate(value) {
	// 기준값이 숫자가 아닌경우 무조건 true;
	if (isNaN(this.maxNumber)) {
		this.validity = true;
		return true;
	}

	if (isNaN(value)) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);
		return false;
	}
	this.maxNumber = Number(this.maxNumber);
	value          = Number(value);

	if (value > this.maxNumber) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_014, ["@", String(this.maxNumber)]);
		return false;
	}
	this.validity = true;
	return true;
}





///////////////////////////// covInNumberValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'inNumber' 항목에 대한 validator. 값이 지정된 범위 내의 값인지를 검사한다.
 * @sig    : inNumber
 * @param  : inNumber required 숫자의 범위를 나타내는 스트링. 예) "1~100"
 * @author : 최재원
 */
function covInNumberValidator(inNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.minNumber;
    this.maxNumber;

    // method
    this.validate = covInNumberValidator_validate;

    // initialize
	this.minNumber = inNumber.substring(0, inNumber.indexOf("~"));
	this.maxNumber = inNumber.substr(inNumber.indexOf("~") + 1);
	this.minNumber = (this.minNumber == null) ? "" : this.minNumber.trim();
	this.maxNumber = (this.maxNumber == null) ? "" : this.maxNumber.trim();
}



/**
 * @type   : method
 * @access : public
 * @object : covInNumberValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covInNumberValidator_validate(value) {
	// 기준값이 숫자가 아닌경우 무조건 true;
	if (isNaN(this.minNumber) || isNaN(this.maxNumber)) {
		this.validity = true;
		return true;
	}

	if (isNaN(value)) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);
		return false;
	}

	this.minNumber = Number(this.minNumber);
	this.maxNumber = Number(this.maxNumber);
	value     = Number(value);

	if (value < this.minNumber || value > this.maxNumber) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_006, ["@", String(this.minNumber), String(this.maxNumber)]);
		return false;
	}
	this.validity = true;
	return true;
}



///////////////////////////// covMinDateValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'minDate' 항목에 대한 validator. 값이 지정된 날짜를 넘는지를 검사한다.
 *           'YYYYMMDD' 형식으로 날짜를 표기해야 한다.
 *             예) minDate=20020315
 * @sig    : minDate
 * @param  : minDate required 유효한 기준 최소값.
 * @author : 최재원
 */
function covMinDateValidator(minDate) {
    // data;
    this.message = "";
    this.validity = false;
    this.minDate = minDate;

    // method
    this.validate = covMinDateValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covMinDateValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinDateValidator_validate(value) {
	if (!(new covDateValidator("YYYYMMDD").validate(value))) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_018, ["@"]);
		return false;
	}

	if (value < this.minDate) {
		var msgParams = new Array(4);
		msgParams[0] = "@";
		msgParams[1] = this.minDate.substring(0,4);
		msgParams[2] = this.minDate.substring(4,5) == "0" ? this.minDate.substring(5,6) : this.minDate.substring(4,6);
		msgParams[3] = this.minDate.substring(6,7) == "0" ? this.minDate.substring(7,8) : this.minDate.substring(6,8)
		this.message = new coMessage().getMsg(MSG_COM_ERR_025, msgParams);
		return false;
	}
	this.validity = true;
	return true;
}



///////////////////////////// covMaxDateValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'maxDate' 항목에 대한 validator. 값이 지정된 최대값을 넘지 않는지를 검사한다.
 * @sig    : maxDate
 * @param  : maxDate required 유효한 최대날짜값.
 * @author : 최재원
 */
function covMaxDateValidator(maxDate) {
    // data;
    this.message = "";
    this.validity = false;
    this.maxDate = maxDate;

    // method
    this.validate = covMaxDateValidator_validate;

}



/**
 * @type   : method
 * @access : public
 * @object : covMaxDateValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxDateValidator_validate(value) {

	if (!(new covDateValidator("YYYYMMDD").validate(value))) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_018, ["@"]);
		return false;
	}

	if (value > this.maxDate) {
		var msgParams = new Array(4);
		msgParams[0] = "@";
		msgParams[1] = this.maxDate.substring(0,4);
		msgParams[2] = this.maxDate.substring(4,5) == "0" ? this.maxDate.substring(5,6) : this.maxDate.substring(4,6);
		msgParams[3] = this.maxDate.substring(6,7) == "0" ? this.maxDate.substring(7,8) : this.maxDate.substring(6,8)
		this.message = new coMessage().getMsg(MSG_COM_ERR_024, msgParams);
		return false;
	}
	this.validity = true;
	return true;
}



///////////////////////////// covFormatValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'format' 항목에 대한 validator. 값이 마스크로 표현된 형식과 일치하는지 검사한다.
 *             - format characters
 *               #    : 문자와 숫자
 *               h, H : 한글 (H는 공백포함)
 *               A, Z : 문자 (Z는 공백포함)
 *               0, 9 : 숫자 (9는 공백포함)
 * @sig    : format
 * @param  : format required 포멧 스트링.
 * @author : 최재원
 */
function covFormatValidator(format) {
    // data;
    this.message  = "";
    this.validity = false;
    this.format   = format

    // method
    this.validate = covFormatValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covFormatValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covFormatValidator_validate(value) {
	if (value.length != this.format.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
		return false;
	}

	for (var i = 0; i < this.format.length; i++) {
		switch(this.format.charAt(i)) {
			case 'h' :
				var cCode = value.charCodeAt(i);
				if ( (value.charAt(i) == " ") ||
				     !((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))
				   ) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case 'H' :
				var cCode = value.charCodeAt(i);
				if ( (value.charAt(i) != " ") &&
				     !((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))
				   ) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case '0' :
				if (isNaN(value.charAt(i)) || value.charAt(i) == " ") {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case '9' :
				if (isNaN(value.charAt(i))) {
					if (value.charAt(i) != " ") {
						this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
						return false;
					}
				}
				break;

			case 'A' :
				if ( (value.charAt(i) == " ") || !isNaN(value.charAt(i)) ) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case 'Z' :
				if ( (value.charAt(i) != " ") && !isNaN(value.charAt(i)) ) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case '#' :
				break;
			default :
				if (value.charAt(i) != this.format.charAt(i)) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;
		}
	}

	this.validity = true;
	return true;
}



///////////////////////////// covSsnValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'ssn' 항목에 대한 validator. 입력된 주민등록번호가 유효한지 검사한다.
 * @author : 최재원
 */
function covSsnValidator() {
    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covSsnValidator_validate;

}



/**
 * @type   : method
 * @access : public
 * @object : covSsnValidator
 * @desc   : validation을 수행한다.
 * @sig    : ssn
 * @param  : ssn required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covSsnValidator_validate(ssn) {
	if ( ssn == null || ssn.trim().length != 13 || isNaN(ssn) )  {
		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);
		return false;
	}

	var jNum1 = ssn.substr(0, 6);
	var jNum2 = ssn.substr(6);

	/*

	  잘못된 생년월일을 검사합니다.
	  2000년도부터 성구별 번호가 바뀌였슴으로 구별수가 2보다 작다면
	  1900년도 생이되고 2보다 크다면 2000년도 이상생이 됩니다.
	  단 1800년도 생은 계산에서 제외합니다.

	*/
	if(jNum2.charAt(0) == "1"
	        || jNum2.charAt(0) == "2"
	        || jNum2.charAt(0) == "5"
	        || jNum2.charAt(0) == "6")
	    bYear = "19";   
	else
	    bYear = "20";

	// 주민번호의 앞에서 2자리를 이어서 4자리의 생년을 저장합니다.
	bYear += jNum1.substr(0, 2);

	// 달을 구합니다. 1을 뺀것은 자바스크립트에서는 1월을 0으로 표기하기 때문입니다.
	bMonth = jNum1.substr(2, 2) - 1;
	bDate = jNum1.substr(4, 2);
	bSum = new Date(bYear, bMonth, bDate);

	// 생년월일의 타당성을 검사하여 거짓이 있을시 에러메세지를 나타냄
	if ( bSum.getYear() % 100 != jNum1.substr(0, 2) || bSum.getMonth() != bMonth || bSum.getDate() != bDate) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);
		return false;
	}

	total = 0;
	temp = new Array(13);

	for (i = 1; i <= 6; i++) {
		temp[i] = jNum1.charAt(i-1);
	}

	for (i = 7; i <= 13; i++) {
		temp[i] = jNum2.charAt(i-7);
	}

	for (i = 1; i <= 12; i++) {
		k = i + 1;
		// 각 수와 곱할 수를 뽑아냅니다. 곱수가 만일 10보다 크거나 같다면 계산식에 의해 2로 다시 시작하게 됩니다.
		if(k >= 10) k = k % 10 + 2;
		// 각 자리수와 계산수를 곱한값을 변수 total에 누적합산시킵니다.
		total = total + (temp[i] * k);
	}

	// 마지막 계산식을 변수 last_num에 대입합니다.
	last_num = (11- (total % 11)) % 10;

	// laster_num이 주민번호의마지막수와 같은면 참을 틀리면 외국인쪽으로 반환합니다. 2012.3.16 이동훈 수정
	if(last_num != temp[13]) {

		return cfFgnValid(ssn);

		//this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);
		//return false;
	}
	this.validity = true;
	return true;
}



///////////////////////////// covCsnValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 'csn' 항목에 대한 validator. 입력된 사업자등록번호가 유효한지 검사한다.
 * @author : 최재원
 */
function covCsnValidator() {

    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covCsnValidator_validate;

}



/**
 * @type   : method
 * @access : public
 * @object : covCsnValidator
 * @desc   : validation을 수행한다.
 * @sig    : csn
 * @param  : csn required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covCsnValidator_validate(csn) {

	if ( csn == null || csn.length != 10 || isNaN(csn) )  {
		this.message = new coMessage().getMsg(MSG_COM_ERR_017, ["@"]);
		return false;
	}

	var sum = 0;
	var nam = 0;
	var checkDigit = -1;
	var checkArray = [1,3,7,1,3,7,1,3,5];

	for(i=0 ; i < 9 ; i++)
		sum += csn.charAt(i) * checkArray[i];

	sum = sum + ((csn.charAt(8) * 5 ) / 10);
	nam = Math.floor(sum) % 10;
	checkDigit = ( nam == 0 ) ? 0 : 10 - nam;

	if ( csn.charAt(9) != checkDigit) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_017, ["@"]);
		return false;
	}
	this.validity = true;
	return true;

}



///////////////////////////// covFilterInValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 지정된 문자 이외에 다른 문자가 들어있을 경우 유효하지 않은 것으로 판단한다.
 *           특정 문자들에 대한 특수문자가 아래에 나와있다.<br>
 * <pre>
 *         ;    - \;
 *         한글 - \h
 *         영문 - \a
 *         숫자 - \n
 * </pre>
 * @sig    : fStr
 * @param  : fStr required filter에 대한 표현
 * @author : 최재원
 */

function covFilterInValidator(fStr) {
    // data;
    this.message = "";
    this.validity = false;
    this.fStrArr = fStr.advancedSplit(";", "i");

    for (var i = 0; i < this.fStrArr.length; i++) {
    	if (this.fStrArr[i] == "\\h") {
    		this.fStrArr[i] = "한글";
    	} else if (this.fStrArr[i] == "\\a") {
    		this.fStrArr[i] = "영문";
    	} else if (this.fStrArr[i] == "\\n") {
    		this.fStrArr[i] = "숫자";
    	}
    }

    // method
    this.validate = covFilterInValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covFilterInValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covFilterInValidator_validate(value) {
	var isIn = false;
	var c
	var cCode;

	for (var i = 0; i < value.length; i++) {
		isIn = false;
		c = value.charAt(i);
		cCode = value.charCodeAt(i);

		for (var j = 0; j < this.fStrArr.length; j++) {
			if (this.fStrArr[j] == "한글" &&
			    ((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))
			   ) {
				isIn = true;
			} else if ( this.fStrArr[j] == "영문" &&
			            ((0x61 <= cCode && cCode <= 0x7A) || (0x41 <= cCode && cCode <= 0x5A))
			          ) {
				isIn = true;
			} else if (this.fStrArr[j] == "숫자" && !isNaN(c)) {
				isIn = true;
			} else if (this.fStrArr[j] == c) {
				isIn = true;
			}
		}

		if (!isIn) {
			this.message = new coMessage().getMsg(MSG_COM_ERR_036, ["@", this.fStrArr.toString()]);
			return false;
		}
	}

	this.validity = true;
	return true;

}



///////////////////////////// covFilterOutValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 지정된 스트링들이 들어있을 경우 유효하지 않은것으로 판단한다.
 *           분리자는 ";"를 사용한다. ";" 혹은 ";"문자가 들어간 스트링을 필터링하려 할 경우는
 *           "\\;"라고 표기해야 한다.
 * @sig    : fStr
 * @param  : fStr required filter에 대한 표현
 * @author : 최재원
 */
function covFilterOutValidator(fStr) {
    // data;
    this.message = "";
    this.validity = false;
    this.fStrArr = fStr.advancedSplit(";", "i");
    // method
    this.validate = covFilterOutValidator_validate;

}



/**
 * @type   : method
 * @access : public
 * @object : covFilterValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covFilterOutValidator_validate(value) {
	for (var i = 0; i < this.fStrArr.length; i++) {
		if (value.indexOf(this.fStrArr[i]) != -1) {
			this.message = new coMessage().getMsg(MSG_COM_ERR_033, ["@", "사용할수 없는 문자 : " + this.fStrArr.toString()]);
			return false;
		}
	}
	this.validity = true;
	return true;
}



///////////////////////////// covEmailValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 입력값이 email 형식에 적합한지를 검사한다.
 * @author : 최재원
 */
function covEmailValidator() {
    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covEmailValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covEmailValidator
 * @des   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */

function covEmailValidator_validate(value) {
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;

	if (value.search(format) == -1) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_037, ["@"]);
		return false;
	}

	this.validity = true;
	return true;

}



///////////////////////////// covDateValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 값이 Date형식인지를 검사한다.
 *
 *            format문자 :  YYYY,  -> 4자리 년도
 *                          YY,    -> 2자리 년도. 2000년 이후.
 *                          MM,    -> 2자리 숫자의 달.
 *                          DD,    -> 2자리 숫자의 일.
 *                          hh,    -> 2자리 숫자의 시간. 12시 기준
 *                          HH,    -> 2자리 숫자의 시간. 24시 기준
 *                          mm,    -> 2자리 숫자의 분.
 *                          ss     -> 2자리 숫자의 초.
 *
 *            예)
 *                'YYYYMMDD' -> '20020328'
 *                'YYYY/MM/DD' -> '2002/03/28'
 *                'Today : YY-MM-DD' -> 'Today : 02-03-28'
 *
 *            참고)
 *                  format문자가 중복해서 나오더라도 처음 나온 문자에 대해서만
 *                  format문자로 인식된다. YYYY와 YY, hh와 HH 도 중복으로 본다.
 *                  날짜는 년,월이 존재할 때만 정확히 체크하고 만일 년, 월이 없다면
 *                  1 ~ 31 사이인지만 체크한다.
 *
 * @sig    : dateExp
 * @param  : dateExp required Date Format expression.
 *             예) 2002년 3월 12일 -> "YYYY-MM-DD"(Date Format Expression) -> "2002-03-12"
 * @author : 최재원
 */

function covDateValidator(dateExp) {

    // data;
    this.message = "";
    this.validity = false;
    this.dateExp = dateExp;
    this.year = null;
    this.month = null;

    // method
    this.validate = covDateValidator_validate;
    this.checkLength = covDateValidator_checkLength;
    this.checkYear = covDateValidator_checkYear;
    this.checkMonth = covDateValidator_checkMonth;
    this.checkDay = covDateValidator_checkDay;
    this.checkHour = covDateValidator_checkHour;
    this.checkMin = covDateValidator_checkMin;
    this.checkSec = covDateValidator_checkSec;
    this.checkRest = covDateValidator_checkRest;

}



/**
 * @type   : method
 * @access : public
 * @object : covDateValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 검사대상이 되는 Date 스트링 값.
 * @return : boolean - 유효성 여부
 */

function covDateValidator_validate(value) {

	this.value = value;
	if ( this.checkLength(value) &&
		 this.checkYear(value) &&
		 this.checkMonth(value) &&
		 this.checkDay(value) &&
		 this.checkHour(value) &&
		 this.checkMin(value) &&
		 this.checkSec(value) &&
		 this.checkRest(value)
	   ) {
		this.validity = true;
		return true;
	} else {
		this.validity = false;
		return false;
	}
}



function covDateValidator_checkLength() {
	if (this.value.length == this.dateExp.length) {
		return true;
	} else {
		this.message = new coMessage().getMsg(MSG_COM_ERR_005, ["@", String(this.dateExp.length)]);
		return false;
	}
}



function covDateValidator_checkYear() {

	var index = -1;

	if ( (index = this.dateExp.indexOf("YYYY")) != -1 ) {
		subValue = this.value.substr(index, 4);
		if ( !isNaN(subValue) &&
			 (subValue > 0)
		   ) {
			this.dateExp = this.dateExp.cut(index, 4);
			this.value = this.value.cut(index, 4);
			this.year = subValue;
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_015, ["@"]);
			return false;
		}
	}

	if ( (index = this.dateExp.indexOf("YY")) != -1 ) {
		subValue = "20" + this.value.substr(index, 2);
		if ( !isNaN(subValue) &&
			 (subValue > 0)
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			this.year = subValue;
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_015, ["@"]);
			return false;
		}
	}
	return true;

}



function covDateValidator_checkMonth() {

	var index = -1;

	if ( (index = this.dateExp.indexOf("MM")) != -1 ) {
		subValue = this.value.substr(index, 2);
		if ( !isNaN(subValue) &&
		     (subValue > 0) &&
		     (subValue <= 12)

		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			this.month = subValue;
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_019, ["@"]);
			return false;
		}
	}
	return true;

}



function covDateValidator_checkDay() {
	var index = -1;
	var days = 0;

	if ( (index = this.dateExp.indexOf("DD")) != -1 ) {
		if ( (this.year != null) && (this.month != null) ) {
			days = (this.month != 2) ? GLB_DAYS_IN_MONTH[this.month-1] : (( (this.year % 4) == 0 && (this.year % 100) != 0 || (this.year % 400) == 0 ) ? 29 : 28 );
		} else {
			days = 31;
		}

		subValue = this.value.substr(index, 2);

		if ( (!isNaN(subValue)) &&
		     (subValue > 0) &&
		     (subValue <= days)
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_020, ["@"]);
			return false;
		}

	}
	return true;

}



function covDateValidator_checkHour() {

	var index = -1;

	if ( (index = this.dateExp.indexOf("hh")) != -1 ) {
		subValue = this.value.substr(index, 2);

		if ( !isNaN(subValue) &&
		     (subValue >= 0) &&
		     (subValue <= 12)

		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			return true;

		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_021, ["@"]);
			return false;

		}

	}


	if ( (index = this.dateExp.indexOf("HH")) != -1 ) {

		subValue = this.value.substr(index, 2);

		if ( !isNaN(subValue) &&
		     (subValue >= 0) &&
		     (subValue < 24)

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_021, ["@"]);

			return false;

		}
	}

	return true;

}



function covDateValidator_checkMin() {

	var index = -1;

	if ( (index = this.dateExp.indexOf("mm")) != -1 ) {

		subValue = this.value.substr(index, 2);

		if ( !isNaN(subValue) &&

		     (subValue >= 0) &&

		     (subValue < 60 )

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			this.month = subValue;

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_022, ["@"]);

			return false;

		}

	}

	return true;

}



function covDateValidator_checkSec() {

	var index = -1;

	if ( (index = this.dateExp.indexOf("ss")) != -1 ) {

		subValue = this.value.substr(index, 2);

		if ( (!isNaN(subValue)) &&

		     (subValue >= 0) &&

		     (subValue < 60 )

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			this.month = subValue;

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_023, ["@"]);

			return false;

		}

	}
	return true;
}



function covDateValidator_checkRest() {

	if (this.value == this.dateExp) {

		return true;

	}
	return false;

}





///////////////////////////// covNullValidator /////////////////////////////

/**
 * @type   : object
 * @access : private
 * @desc   : 무조건 valid한 결과를 가진 validator.
 * @author : 최재원
 */

function covNullValidator() {
    // data;
    this.message = "";
    this.validity = true;

    // method
    this.validate = covNullValidator_validate;
}



/**
 * @type   : method
 * @access : public
 * @object : covNullValidator
 * @desc   : validation을 수행한다.
 * @return : boolean - 무조건 true.
 */

function covNullValidator_validate() {

	this.message = new coMessage().getMsg(MSG_COM_INF_007);

	return true;

}




/**
 * @type   : function
 * @access : public
 * @desc   : 그리드 상에서 enter를 key를 치는 경우 tab 처럼 옆으로 아래로 이동한다.
 *                 이동의 기준은 edit가능한 칼럼 단위로 이동한다.
 *                 그리드의 onkeypress event에서 호출 하면 된다. (keycode 13이면 enter 키이다.)
 * @sig       : oGrid
 * @param  : oGrid enter key 처리할 그리드 object id
 * @return :
 * <pre>
 *     사용예)
 *     oGrid : object id
 *     <script language=JavaScript for=oGrid event=OnKeyPress(kcode)>
 * 		if ( kcode == '13' ) // key code 13은 enter key
 *			cfGridEnterKey(oGrid);
 *     </script>
 * </pre>
 * @author : 최재원
 */
function cfGridEnterKey(oGrid) {
	TempGDS = document.createElement("<OBJECT>");
	TempGDS.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
	TempGDS.id = "TempGDS";


	for (var j = 0; j < document.all.length; j++) {
		if (document.all[j].tagName == "HEAD") {
			document.all[j].insertAdjacentElement("beforeEnd", TempGDS);
			break;
		}
	}

	curDataSet  = document.all(oGrid.DataID);

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
	var newFormat ="";

	// Grid Format String 을 파싱하여 컬럼별로 Style 과 관련된 속성을 삽입한다.
	while ((tagMatch = gFormat.match(tagRE)) != null) {
		var gridColid ="";
		var editstyle ="";
		var showFalse ="";

		// 사용자가 지정한 컬럼 속성에 따른 처리
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {
			colAttrName = colAttrMatch[1].toUpperCase();

			if ( colAttrName == "ID" ){
				gridColid = colAttrMatch[2].toUpperCase();
			} else if  ( colAttrName == "EDIT" ){
				editstyle = colAttrMatch[2].toUpperCase();
			} else if ( colAttrName == "SHOW" ){
				showFalse = colAttrMatch[2].toUpperCase();
			}
			colAttrData = colAttrData.substr(colAttrMatch.lastIndex);
		}

		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));
		gFormat = gFormat.substr(tagMatch.lastIndex);

		curColIndex   = curDataSet.ColumnIndex(gridColid);  		//column id에 해당하는 index값
		curColProp	  = curDataSet.ColumnProp(curColIndex);     // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(변경안됨)
		tagName = tagMatch[1].trim().toUpperCase();

		if ( tagName =='C' || tagName =='FC' ){
			if ( editstyle != "NONE" && curColProp != "2" && showFalse != "FALSE" ){
				newFormat = newFormat + gridColid+',';
			}
		}
	}

	TempGDS.setdataheader(newFormat);	//그리드 format에 해당하는 칼럼 순서로 temp의 데이터 셋을 생성한다.
															 		//데이터셋과 그리드의 칼럼 순서가 불일치...

	var currColumn    = oGrid.GetColumn();
	var currColummIdx = TempGDS.ColumnIndex(currColumn);  //현재선택된 칼럼의 index
	var CurrRowNoChg  = 'Y';

	for (var i = 1; i <= TempGDS.CountColumn; i++) {
		colId      = TempGDS.ColumnID(i);	      //column id
		colIndex   = TempGDS.ColumnIndex(colId);  //column id에 해당하는 index값
		colProp	   = TempGDS.ColumnProp(i);       // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(변경안됨)
		editStatus = oGrid.ColumnProp(colId,"edit");

		if ( currColummIdx < colIndex ) {
			oGrid.focus();
			oGrid.SetColumn(colId);
			return;
		}
	}

	//enter event 마지막 row인경우는 다음 row로 이동한다.
	if ( CurrRowNoChg == 'Y' ){
		curDataSet.RowPosition =  curDataSet.RowPosition + 1;
		for (var i = 1; i <= TempGDS.CountColumn; i++) {
			colId      = TempGDS.ColumnID(i);	      //column id
			colIndex   = TempGDS.ColumnIndex(colId);  //column id에 해당하는 index값
			colProp	   = TempGDS.ColumnProp(i);       // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(변경안됨)
			editStatus = oGrid.ColumnProp(colId,"edit");
			oGrid.focus();
			oGrid.SetColumn(colId);
			return;
		}
	}
}


/**
 * @type   : function
 * @access : public
 * @desc   : 공통메세지에 정의된 메세지를 리턴한다.
 * <pre>
 * // 공통 메세지 영역
 * var MSG_NO_CHANGED        = "변경된 사항이 없습니다.";
 * var MSG_SUCCESS_LOGIN     = "@님 안녕하세요?";
 * ...
 * var message1 = cfGetMsg(MSG_NO_CHANGED);
 * var message2 = cfGetMsg(MSG_SUCCESS_LOGIN, ["홍길동"]);
 * </pre>
 * 위의 예에서 message2 의 값은 "홍길동님 안녕하세요?" 가 된다.
 * @sig    : msgId[, paramArray]
 * @param  : msgId      required common.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 데이터 Array. Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다. 치환될 데이터는 [] 사이에 콤마를 구분자로 하여 기술하면 Array 로 인식된다.
 * @return : 치환된 메세지 스트링
 * @author : 최재원
 */
function cfGetMsg(msgId, paramArray) {
	return new coMessage().getMsg(msgId, paramArray);
}




/**
 * 첨부파일 삭제
 */
function cfDeleteFile(p_FileNm, p_CaseId, p_Status) {
	if (!confirm("유첨을 삭제하시겠습니까?")) return;
	oHiddenFrame.location.href = "/servlet/JspChannelSVL?cmd=taxlaw.bpm.cmd.DeleteAttachedFileCMD&FILE_CASE_ID=" + p_CaseId + "&STATUS=" + p_Status + "&FILE_NM=" + p_FileNm;
	f.oFileNm.style.display = "";
	try
	{
		f.oFileDeleteBtn.style.display="";
	}
	catch (exception)
	{
	}

	oFileLink.style.display = "none";
	f.oDeleteFileBtn.style.display = "none";
}


/**
 * 가맹점 코드로 가맹점 명을 불러오는 함수.
 */
function cfGetRtlCdNm(p_RtlCd, p_RtlCdNm) {
	if (p_RtlCd.value.length >= 3) {
		if (document.all("coRtlCdGDS") == null) {
			dataSet = document.createElement("<OBJECT>");
			dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
			dataSet.id = "coRtlCdGDS";
			dataSet.SyncLoad = "true";

			for (var i = 0; i < document.all.length; i++) {
				if (document.all[i].tagName == "HEAD") {
					document.all[i].insertAdjacentElement("beforeEnd", dataSet);
					break;
				}
			}
		} else {
			dataSet = document.all("coRtlCdGDS");
		}
		var svl =  "/servlet/GauceChannelSVL?cmd=kicc.easyoffice.cm.util.cmd.RetrieveRtlCdNmCMD&RTL_CD=" + p_RtlCd.value.toUpperCase();
		dataSet.DataId = svl;
		dataSet.Reset();
		if (dataSet.countrow > 0)	{
			p_RtlCdNm.value = dataSet.NameValue(1,"COMPANY_NAME");
			p_RtlCd.value = dataSet.NameValue(1,"COMPANY_CODE");
		} else {
			p_RtlCdNm.value = "";
		}
	} else {
		p_RtlCdNm.value = "";
	}

}


/**
 * 대리점코드와 딜러코드로 영업자코드명을 불러오는 함수
 */
function cfGetBusAndManCdNm(p_AgencyCd, p_BusAndManCd, p_BusAndManCdNm) {
	if (p_AgencyCd.value.length < 3) {
		alert("[대리점] 코드를 입력해 주세요.");
		p_AgencyCd.focus();
		return;
	}
	if (p_BusAndManCd.value.length >= 3) {
		if (document.all("coBusAndManGDS") == null) {
			dataSet = document.createElement("<OBJECT>");
			dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
			dataSet.id = "coBusAndManGDS";
			dataSet.SyncLoad = "true";

			for (var i = 0; i < document.all.length; i++) {
				if (document.all[i].tagName == "HEAD") {
					document.all[i].insertAdjacentElement("beforeEnd", dataSet);
					break;
				}
			}
		} else {
			dataSet = document.all("coBusAndManGDS");
		}
		var svl =  "/servlet/GauceChannelSVL?cmd=kicc.easyoffice.cm.util.cmd.RetrieveBusAndManCdNmCMD" +
			       "&SELLER_CODE=" + p_BusAndManCd.value.toUpperCase() +
			       "&AGENCY_CODE=" + p_AgencyCd.value.toUpperCase();
		dataSet.DataId = svl;
		dataSet.Reset();
		if (dataSet.countrow > 0)	{
			p_BusAndManCdNm.value = dataSet.NameValue(1,"NAME");
			// p_BusAndManCd.value = dataSet.NameValue(1,"CODE");
		} else {
			p_BusAndManCdNm.value = "";
		}
	} else {
		p_BusAndManCdNm.value = "";
	}

}

/**
 * CCMS_REPORT의 소구분 코드를 생성하여 반환
 */
function cfGetCcmsReportSmallDivCd(p_TeamCd, p_GubunCd, p_SmallDivCd) {

	if (document.all("coCcmsReportSmallDivCdGDS") == null) {
		dataSet = document.createElement("<OBJECT>");
		dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
		dataSet.id = "coCcmsReportSmallDivCdGDS";
		dataSet.SyncLoad = "true";

		for (var i = 0; i < document.all.length; i++) {
			if (document.all[i].tagName == "HEAD") {
				document.all[i].insertAdjacentElement("beforeEnd", dataSet);
				break;
			}
		}
	} else {
		dataSet = document.all("coCcmsReportSmallDivCdGDS");
	}
	var svl =  "/servlet/GauceChannelSVL?cmd=kicc.easyoffice.cm.util.cmd.RetrieveCcmsReportSmallDivCdCMD" +
			   "&TEAM_CODE=" + p_TeamCd +
			   "&GUBUN_CODE=" + p_GubunCd;
	dataSet.DataId = svl;
	dataSet.Reset();
	if (dataSet.countrow > 0)	{
		p_SmallDivCd.value = dataSet.NameValue(1,"CODE");
	} else {
		p_SmallDivCd.value = "";
	}
}


/**
 * 대리점/딜러코드로 딜러명을 반환.
 */
function cfGetDealerNm(p_AgencyCd, p_DealerCd, p_DealerCdNm) {
	if (p_AgencyCd.value.length < 3) {
		alert("[대리점] 코드를 입력해 주세요.");
		p_AgencyCd.focus();
		return;
	}
	if (p_DealerCd.value.length >= 3) {
		if (document.all("coDealerNmGDS") == null) {
			dataSet = document.createElement("<OBJECT>");
			dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
			dataSet.id = "coDealerNmGDS";
			dataSet.SyncLoad = "true";

			for (var i = 0; i < document.all.length; i++) {
				if (document.all[i].tagName == "HEAD") {
					document.all[i].insertAdjacentElement("beforeEnd", dataSet);
					break;
				}
			}
		} else {
			dataSet = document.all("coDealerNmGDS");
		}
		var svl =  "/servlet/GauceChannelSVL?cmd=kicc.easyoffice.cm.util.cmd.RetrieveDealerNmCMD" +
				   "&AGENCY_CODE=" + p_AgencyCd.value +
				   "&DEALER_CODE=" + p_DealerCd.value;
		dataSet.DataId = svl;
		dataSet.Reset();
		if (dataSet.countrow > 0)	{
			p_DealerCdNm.value = dataSet.NameValue(1,"NAME");
		} else {
			p_DealerCdNm.value = "";
		}
	} else {
		p_DealerCdNm.value = "";
	}
}

/**
 * 회선코드를 가지고 회선명, Protocol, 현상태, 확인 사항을 조회한다.


 p_LineCode    --라인코드
 p_LineName    --라인명
 p_Protocol    --Protocol
 p_StatCode    --현상태
 p_StatComment --확인사항(사용무)


 */
function cfGetLineCdNm(p_LineCode, p_LineName, p_Protocol, p_StatCode) {
	if (p_LineCode.value.length >= 5) {
		if (document.all("coLineCodeGDS") == null) {
			dataSet = document.createElement("<OBJECT>");
			dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
			dataSet.id = "coLineCodeGDS";
			dataSet.SyncLoad = "true";

			for (var i = 0; i < document.all.length; i++) {
				if (document.all[i].tagName == "HEAD") {
					document.all[i].insertAdjacentElement("beforeEnd", dataSet);
					break;
				}
			}
		} else {
			dataSet = document.all("coLineCodeGDS");
		}
		var svl =  "/servlet/GauceChannelSVL?cmd=kicc.easyoffice.cm.util.cmd.RetrieveLineCdNmCMD&LINE_CODE=" + p_LineCode.value.toUpperCase();

		dataSet.DataId = svl;
		dataSet.Reset();
		if (dataSet.countrow > 0)	{
			p_LineCode.value = dataSet.NameValue(1,"LINE_CODE");
			p_LineName.value = dataSet.NameValue(1,"LINE_NAME");
			p_Protocol.Index = p_Protocol.IndexOfColumn("CODE", dataSet.NameValue(1,"PROTOCOL"));
			//p_StatCode.Index = p_StatCode.IndexOfColumn("CODE", dataSet.NameValue(1,"STAT_CODE"));

			p_LineName.disabled = true;
			p_Protocol.Enable   = false;

		} else {
			p_LineName.value = "";

			p_LineName.disabled = false;
			p_Protocol.Enable   = true;
		}
	} else {
		p_LineName.value = "";

		p_LineName.disabled = false;
		p_Protocol.Enable   = true;
	}

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
			 case 4:
				      colProp = "NOTNULL";
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


var GLS_USER_ID = false;		// 성공일때 USER_ID 반환, 실패시 false

/**
 * 프로그램에서 사용자 인증이 추가적으로 필요할때 사용.
 */
function cfUserAuth(param) {
	if (document.all("coLogin") == null) {
		progress = '<iframe src="../../common/login_sub.jsp?FUNCTION=' + param + '&DUMMY=' + Math.random(1)*10000 + '" id=coLogin style="position:absolute;width:225;height:50;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';

		for (var i = 0; i < document.all.length; i++) {
			if (document.all[i].tagName.toUpperCase() == "BODY") {
				document.all[i].insertAdjacentHTML("beforeEnd", progress);
				break;
			}
		}
		document.all.coLogin.style.zIndex = 0;
		document.all.coLogin.style.left = 360;
		document.all.coLogin.style.top = 247;

	} else {
		document.all("coLogin").src = "../../common/login_sub.jsp?FUNCTION=" + param;
	}

	document.all.coLogin.style.display = "";

}


/**
 * 영문 대문자 인지 여부 검사.
 */
function cfEngYn(p_value) {
	var ENG_PATTERN = "/[A-Z]{" + p_value.length + "}/";
	var PATTERN = eval(ENG_PATTERN);
	return PATTERN.test(p_value);
}



/**
 * 가우스 X차트에 대한 초기화를 수행한다.
 * 차트 초기화에 사용되는 파라미터는 아래와 같다.
 * @param : p_ChartObj       X차트 오브젝트
 * @param : p_title          차트 제목
 * @param : p_3dChartYn      3D차트여부 true/false
 * @param : p_YaxisMaxValue  Y축 최대값
 * @param : p_YaxisMinValue  Y축 최소값
 * @param : p_YaxisInc       Y축 증가값
 * @param : p_Legend         범례표시 여부 (true표시/false숨김)
 */
function cfInitChart( p_ChartObj, p_title, p_3dChartYn, p_YaxisMaxValue, p_YaxisMinValue, p_YaxisInc, p_Legend ) {

	p_ChartObj.RemoveAllSeries();									// Series들을 클리어 한다

	// 차트 배경 환경 셋팅
	p_ChartObj.Panel.Color = p_ChartObj.ToOLEColor("white");		// 판넬의 배경색을 지정한다.
	p_ChartObj.Panel.BevelInner = 0;
	p_ChartObj.Panel.BevelOuter = 0;
	p_ChartObj.Panel.BorderStyle = 0;								// 차트 Layout 선을 나타내거나 감춘다 (0:hidden, 1:view)
	p_ChartObj.Aspect.View3D = p_3dChartYn;							// 3D차트 여부를 설정한다.
	p_ChartObj.Frame.Visible = false;								// 프레임을 보이거나 감춘다 (true: view, false: hidden)

	// 타이틀 입력
	p_ChartObj.Header.Text.Clear();									// 타이틀 삭제
	p_ChartObj.Header.Font.Size = 8;								// 타이틀 폰트 크기
	p_ChartObj.Header.Font.Bold = true;
	p_ChartObj.Header.Font.Color = p_ChartObj.ToOLEColor("blue");	// Header의 Text의 색깔지정
	p_ChartObj.Header.Text.Add (p_title);		// 타이틀 지정

	// X축 설정
	p_ChartObj.Axis.Bottom.GridPen.visible = false;					// Y축 그리드 선 표시 여부
	p_ChartObj.Axis.Bottom.AxisPen.width =1;						// Y축 선 두게
	p_ChartObj.Axis.Left.GridPen.visible = true;					// X축 그리드 선 표시 여부
	p_ChartObj.Axis.Left.AxisPen.width = 1;							// X축 선 두게

	p_ChartObj.Axis.Bottom.TickLength = 3;
	p_ChartObj.Axis.Bottom.MinorTickLength = 2;
	p_ChartObj.Axis.Bottom.Labels.Font.Size = 7;
	p_ChartObj.Axis.Left.TickLength = 2;
	p_ChartObj.Axis.Left.MinorTickLength = 0;

	// Y축 설정
	p_ChartObj.Axis.Left.Automatic= false;							// Y축 간격 자동으로 설정
	p_ChartObj.Axis.Left.Increment = p_YaxisInc;					// 증가치
	p_ChartObj.Axis.Left.Maximum = p_YaxisMaxValue;					// Y축 최대값
	p_ChartObj.Axis.Left.Minimum = p_YaxisMinValue;					// Y축 최소값
//	p_ChartObj.Axis.Left.Labels.Style = 0;							// Y축 스타일

	// 범례 설정
	p_ChartObj.Legend.Visible = p_Legend;							// 범례 표시 여부
	p_ChartObj.Legend.Alignment = 10;
	p_ChartObj.Legend.Customposition = false;
	p_ChartObj.Legend.Left = 115;
	p_ChartObj.Legend.Top = 5;
	p_ChartObj.Legend.TextStyle = 1;
	p_ChartObj.Legend.FontSeriesColor = false;
	p_ChartObj.Legend.Symbol.Continuous = false;
	p_ChartObj.Legend.Symbol.Width = 20;
	p_ChartObj.Legend.Font.Size = 8;
	p_ChartObj.Legend.ShadowSize = 1;
	p_ChartObj.Legend.Frame.Visible = true;
}


/**
  * 가우스 X차트 오브젝트에 차트를 추가한다.
  * - 차트 종류에 따라서 아래와 같이 사용한다.

  * @param : p_ChartObj			추가하고자 하는 XChart Object
  * @param : p_DataId           XChart에 지정하는 DataID(데이터셋)
  * @param : p_ChartType		차트 종류를 지정한다 [0:LINE,  1:BAR, 3:AREA,  4:POINT,  5:PIE]
  * @param : p_XaxisValue		X축에 적용되는 값을 지정한다. (데이터셋 컬럼ID)
  * @param : p_YaxisValue		차트에 적용되는 값을 지정한다. (데이터셋 컬럼ID)
  * @param : p_RemarkTitle		범례에 표시되는 이름
  * @param : p_YaxisName		Y축 제목 지정 (적용되는 차트의 맨 마지막 이름이 최종 표시된다)
  * @param : p_Color            해당 그래프(Series)에 적용하는 색상
  * @param : p_Stype            Series의 라인 종류를 지정한다
  * @param : p_Mark             각 포인트별로 값을 표시여부 p_Marks = true/false : default : false;
  * @param : p_Pointerstyle     각 Series별로 Pointer 모양을 바꾼다. ( p_Pointerstyle = 0 default 1;)
  *   cfAddSeriesOne( oKiccBankListGC, oKiccBankListGDS.id, 1, "BANK_NAME", "TEST_COL2", "전월 실적", "금액", "green" , 0 , 1);
  *   cfAddSeriesOne( oKiccBankListGC, oKiccBankListGDS.id, 1, "BANK_NAME", "TEST_COL2", "전월 실적", "금액", "green" , 0, 1 );
*/
function cfAddSeriesOne(  p_ChartObj,
	                      p_DataId,
						  p_ChartType,
						  p_XaxisValue,
						  p_YaxisValue,
						  p_RemarkTitle,
						  p_YaxisName,
						  p_Color,
						  p_Stype,
						  p_Mark,
						  p_ColorEachPoint,
						  p_Pointerstyle) {


	p_ChartObj.Tools.Clear();
	//Y축 타이틀 직접 지정(위치변경 등) 방법
	idx = p_ChartObj.Tools.Add(10);
	p_ChartObj.Tools.Items(idx).Active = true;
	p_ChartObj.Tools.Items(idx).asAnnotation.Shape.ShadowSize = 0;				// 그림자 제거
	p_ChartObj.Tools.Items(idx).asAnnotation.Shape.CustomPosition = true;		// Y축 타이틀 위치 수동 지정 사용여부
	p_ChartObj.Tools.Items(idx).asAnnotation.Shape.Left = 5;
	p_ChartObj.Tools.Items(idx).asAnnotation.Shape.Top = 5;
	p_ChartObj.Tools.Items(idx).asAnnotation.Shape.Transparent = true;			// Y축 타이틀 상자 표시여부
	p_ChartObj.Tools.Items(idx).asAnnotation.Shape.Font.Size = 8;
	p_ChartObj.Tools.Items(idx).asAnnotation.Text = p_YaxisName;

	if ((p_RemarkTitle == null)||(p_RemarkTitle == "undefined")) return;
	if ((p_Pointerstyle == null)||(p_Pointerstyle == "undefined")){ p_Pointerstyle=1;}


	//Series를 추가한다
	var idx = p_ChartObj.AddSeries(p_ChartType);

	//Series의 종류와 상관없이 주는 속성들이다
	p_ChartObj.Series(idx).DataID = p_DataId;
	p_ChartObj.Series(idx).Title = p_RemarkTitle;
	p_ChartObj.Series(idx).YValueColumn = p_YaxisValue;
	p_ChartObj.Series(idx).LabelColumn   = p_XaxisValue;
	p_ChartObj.Series(idx).color = p_ChartObj.ToOLEColor(p_Color);

	// 차트의 각 포인트의 값 표시여부.
	if (typeof(p_Mark) == "undefined")	{
		p_Mark = false;
	}
	p_ChartObj.Series(idx).Marks.visible = p_Mark;								// 해당 그래프 상단에 값 표시여부

	p_ChartObj.Series(idx).Marks.style = 0;										// 해당 그래프 상단의 값 지정
	//p_ChartObj.Series(idx).Format.visible = true;

	try	{
		// 각 값에 자동으로 Color부여
		if (typeof(p_ColorEachPoint) == "undefined")	{
			p_ColorEachPoint = false;
		}
		p_ChartObj.Series(idx).ColorEachPoint = p_ColorEachPoint;
	} catch (exception)	{}


	if (p_ChartType == 0) {												/* 선 그래프 */
		p_ChartObj.Series(idx).asLine.Pointer.visible = true;			// 연결되는 Line의 Pointer를 보이게 하며
		p_ChartObj.Series(idx).asLine.Pointer.style = p_Pointerstyle;				// Pointer의 모양을 Setting
		p_ChartObj.Series(idx).asLine.Pointer.VerticalSize= 2;			// Pointer의 크기Setting
		p_ChartObj.Series(idx).asLine.Pointer.HorizontalSize = 2;		// Pointer의 크기Setting
	//	p_ChartObj.Series(idx).VerticalAxis = 1;
		p_ChartObj.Series(idx).asLine.Stacked = 1;
		p_ChartObj.Series(idx).asLine.LinePen.Style = p_Stype;
		p_ChartObj.Series(idx).asLine.LinePen.Width = 1;				// 라인의 굵기결정
		p_ChartObj.Series(idx).Depth = 5;
	} else if (p_ChartType == 1) {										/* 막대 그래프 */
		p_ChartObj.Series(idx).asBar.AutoBarSize = true;				// 바의 넓이를 자동으로 지정한다.
	//  p_ChartObj.Series(idx).asBar.BarWidth = 10;						// 바의 넓이를 지정한다.

		p_ChartObj.Series(idx).asBar.BarStyle =0;						// 바의 스타일을 지정한다. (0~7)
	} else if (p_ChartType == 3) {										/* Area그래프 */
		p_ChartObj.Series(idx).asArea.AreaBrush = 0;					// 영역을 채울 브러시를 지정한다

	} else if (p_ChartType == 4) {										/* Point그래프 */
		p_ChartObj.Series(idx).asPoint.Pointer.Style = 7;				// 포인트 스타일

	} else if (p_ChartType == 5) {										/* 파이 그래프 */
		p_ChartObj.Series(idx).asPie.AngleSize = 360;
		p_ChartObj.Series(idx).asPie.ExplodeBiggest = 10;
	}
	p_ChartObj.reset();

}


/**
 * 주민등록번호 검증용
 * 올바른 주민등록번호 : true. 잘못된 주민등록번호 : false
 */
function cfSsnValid(ssn, p_obj) {
	if ( ssn == null || ssn.trim().length != 13 || isNaN(ssn) )  {
		return false;
	}

	var jNum1 = ssn.substr(0, 6);
	if (p_obj.ignore == jNum1)	{
		return true;		// 주민등록번호
	}
	var jNum2 = ssn.substr(6);

	/*

	  잘못된 생년월일을 검사합니다.
	  2000년도부터 성구별 번호가 바뀌였슴으로 구별수가 2보다 작다면
	  1900년도 생이되고 2보다 크다면 2000년도 이상생이 됩니다.
	  단 1800년도 생은 계산에서 제외합니다.

	*/
	bYear = (jNum2.charAt(0) <= "2") ? "19" : "20";

	// 주민번호의 앞에서 2자리를 이어서 4자리의 생년을 저장합니다.
	bYear += jNum1.substr(0, 2);

	// 달을 구합니다. 1을 뺀것은 자바스크립트에서는 1월을 0으로 표기하기 때문입니다.
	bMonth = jNum1.substr(2, 2) - 1;
	bDate = jNum1.substr(4, 2);
	bSum = new Date(bYear, bMonth, bDate);

	// 생년월일의 타당성을 검사하여 거짓이 있을시 에러메세지를 나타냄
	if ( bSum.getYear() % 100 != jNum1.substr(0, 2) || bSum.getMonth() != bMonth || bSum.getDate() != bDate) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);
		return false;
	}

	total = 0;
	temp = new Array(13);

	for (i = 1; i <= 6; i++) {
		temp[i] = jNum1.charAt(i-1);
	}

	for (i = 7; i <= 13; i++) {
		temp[i] = jNum2.charAt(i-7);
	}

	for (i = 1; i <= 12; i++) {
		k = i + 1;
		// 각 수와 곱할 수를 뽑아냅니다. 곱수가 만일 10보다 크거나 같다면 계산식에 의해 2로 다시 시작하게 됩니다.
		if(k >= 10) k = k % 10 + 2;
		// 각 자리수와 계산수를 곱한값을 변수 total에 누적합산시킵니다.
		total = total + (temp[i] * k);
	}

	// 마지막 계산식을 변수 last_num에 대입합니다.
	last_num = (11- (total % 11)) % 10;

	// laster_num이 주민번호의마지막수와 같은면 참을 틀리면 거짓을 반환합니다.
	if(last_num != temp[13]) {
		// 주민등록번호 검증 실패시 외국인 번호인지 검사.
		return cfFgnValid(ssn);
	}
	this.validity = true;
	return true;
}

/**
 * 외국인 번호 검증용 함수.
 */
function cfFgnValid(reg_no) {
    var sum = 0;
    var odd = 0;

    buf = new Array(13);
    for (i = 0; i < 13; i++) buf[i] = parseInt(reg_no.charAt(i));

    odd = buf[7]*10 + buf[8];

    if (odd%2 != 0) {
      return false;
    }

    if ((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9)) {
      return false;
    }

    multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
    for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);

    sum=11-(sum%11);

    if (sum>=10) sum-=10;

    sum += 2;

    if (sum>=10) sum-=10;

    if ( sum != buf[12]) {
        return false;
    }
    else {
        return true;
    }
}


/**
 * 팝업창으로 부터 우편번호 검색하여 넣는 경우
 * @date : 2005/11/23
 * @user : 최재원
 * ex) cfZipCd('폼이름', '우편번호 입력 필드명', '주소1 입력 필드명', '주소2 입력 필드명');
 *     cfZipCd('폼이름', '우편번호 입력 필드명', '주소1 입력 필드명', '주소2 입력 필드명', '주소3 입력 필드명', '주소4 입력 focus');
 *     cfZipCd('폼이름', '우편번호 입력 필드명', '전체주소 입력 필드명');
 *     /pilot/object_template.jsp 참고.
 */
function cfZipCd() {
	if (arguments.length == 4) {
		MM_openBrWindow2("../../common/zipcd.jsp?TYPE=TYPE1&FORM=" + arguments[0] + "&ZIPCD=" + arguments[1] + "&ADDR1=" + arguments[2] + "&ADDR2=" + arguments[3], "zipcd", 397, 340);
	} else if (arguments.length == 6) {
		MM_openBrWindow2("../../common/zipcd.jsp?TYPE=TYPE3&FORM=" + arguments[0] + "&ZIPCD=" + arguments[1] + "&ADDR1=" + arguments[2] + "&ADDR2=" + arguments[3] + "&ADDR3=" + arguments[4] + "&ADDR4=" + arguments[5], "zipcd", 397, 340);
	} else {
		MM_openBrWindow2("../../common/zipcd.jsp?TYPE=TYPE2&FORM=" + arguments[0] + "&ZIPCD=" + arguments[1] + "&ADDR1=" + arguments[2], "zipcd", 397, 340);
	}
}

/**
 * 입력필드에서 사용되는 우편번호 검색 기능
 * 우편번호 -> 주소 반환 :: 건수가 1건일 경우 바로 입력란에 뿌려주고, 2건 이상인 경우 팝업이 나타난다.
 * @date : 2005/11/23
 * @user : 최재원
 * ex) cfZipCdFromEdit(this.value, '폼이름', '우편번호 입력 필드명', '주소1 입력 필드명', '주소2 입력 필드명');
 *     cfZipCd('폼이름', '우편번호 입력 필드명', '주소1 입력 필드명', '주소2 입력 필드명', '주소3 입력 필드명', '주소4 입력 focus');
 *     cfZipCdFromEdit(this.value, '폼이름', '우편번호 입력 필드명', '전체주소 입력 필드명');
 */
function cfZipCdFromEdit() {
	if (arguments[0].length >= 6) {
		if (document.all("coZipCdListGDS") == null) {
			dataSet = document.createElement("<OBJECT>");
			dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
			dataSet.id = "coZipCdListGDS";
			dataSet.SyncLoad = "true";

			for (var i = 0; i < document.all.length; i++) {
				if (document.all[i].tagName == "HEAD") {
					document.all[i].insertAdjacentElement("beforeEnd", dataSet);
					break;
				}
			}
		} else {
			dataSet = document.all("coZipCdListGDS");
		}
		var svl = "/servlet/GauceChannelSVL?cmd=kicc.easyoffice.cm.util.cmd.RetrieveZipCdListCMD&KEY=01&KEYWORD=" + arguments[0];
		dataSet.DataId = svl;
		dataSet.Reset();
		if (dataSet.countrow == 1)	{
			if(arguments.length == 5) {
				try {
					// form이 없는 경우
					eval(arguments[2] + ".value = '" + dataSet.NameValue(1,"ZIP_CODE").replaceStr("-", "") + "'");
					eval(arguments[3] + ".value = '" + dataSet.NameValue(1,"STATE") + " ' + '" + dataSet.NameValue(1,"CITY") + "'");
					eval(arguments[4] + ".focus()");
					eval(arguments[4] + ".value = '" + dataSet.NameValue(1,"DONG") + "'");
				} catch (exception) {
					// form이 있는 경우
					eval(arguments[1] + "." + arguments[2] + ".value = '" + dataSet.NameValue(1,"ZIP_CODE").replaceStr("-", "") + "'");
					eval(arguments[1] + "." + arguments[3] + ".value = '" + dataSet.NameValue(1,"STATE") + "' + '" + dataSet.NameValue(1,"CITY") + "'");
					eval(arguments[1] + "." + arguments[4] + ".focus()");
					eval(arguments[1] + "." + arguments[4] + ".value = '" + dataSet.NameValue(1,"DONG") + "'");
				}
			} else if (arguments.length == 4) {
				try {
					// form이 없는 경우
					eval(arguments[2] + ".value = '" + dataSet.NameValue(1,"ZIP_CODE").replaceStr("-", "") + "'");
					eval(arguments[3] + ".focus()");
					eval(arguments[3] + ".value = '" + dataSet.NameValue(1,"STATE") + " ' + '" + dataSet.NameValue(1,"CITY") + " ' + '" + dataSet.NameValue(1,"DONG") + "'");
				} catch (exception) {
					// form이 있는 경우
					eval(arguments[1] + "." + arguments[2] + ".value = '" + dataSet.NameValue(1,"ZIP_CODE").replaceStr("-", "") + "'");
					eval(arguments[1] + "." + arguments[3] + ".focus()");
					eval(arguments[1] + "." + arguments[3] + ".value = '" + dataSet.NameValue(1,"STATE") + " ' + '" + dataSet.NameValue(1,"CITY") + " ' + '" + dataSet.NameValue(1,"DONG") + "'");

				}
			} else if (arguments.length == 7) {
				try {
					// form이 없는 경우  this. form, post, 1, 2, 3, 4-focus
					eval(arguments[2] + ".value = '" + dataSet.NameValue(1,"ZIP_CODE").replaceStr("-", "") + "'");
					eval(arguments[6] + ".focus()");
					eval(arguments[3] + ".value = '" + dataSet.NameValue(1,"STATE") + "'");
					eval(arguments[4] + ".value = '" + dataSet.NameValue(1,"CITY") + "'");
					eval(arguments[5] + ".value = '" + dataSet.NameValue(1,"DONG") + "'");
				} catch (exception) {
					// form이 있는 경우
					eval(arguments[1] + "." + arguments[2] + ".value = '" + dataSet.NameValue(1,"ZIP_CODE").replaceStr("-", "") + "'");
					eval(arguments[1] + "." + arguments[6] + ".focus()");
					eval(arguments[1] + "." + arguments[3] + ".value = '" + dataSet.NameValue(1,"STATE") + "'");
					eval(arguments[1] + "." + arguments[4] + ".value = '" + dataSet.NameValue(1,"CITY") + "'");
					eval(arguments[1] + "." + arguments[5] + ".value = '" + dataSet.NameValue(1,"DONG") + "'");

				}
			}
			coZipCdListGDS.cleardata();
		} else if (dataSet.countrow > 1)	{
			if(arguments.length == 5) {
				cfZipCd(arguments[1], arguments[2], arguments[3], arguments[4]);
			} else if (arguments.length == 4) {
				cfZipCd(arguments[1], arguments[2], arguments[3]);
			} else if (arguments.length == 7) {
				cfZipCd(arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]);
			}
		}
	} else {
		if(arguments.length == 5) {
			try {
				// form이 없는 경우
				eval(arguments[3] + ".value = ''");
				eval(arguments[4] + ".value = ''");
			} catch (exception) {
				// form이 있는 경우
				eval(arguments[1] + "." + arguments[3] + ".value = ''");
				eval(arguments[1] + "." + arguments[4] + ".value = ''");
			}
		} else if (arguments.length == 4) {
			try {
				// form이 없는 경우
				eval(arguments[3] + ".value = ''");
			} catch (exception) {
				// form이 있는 경우
				eval(arguments[1] + "." + arguments[3] + ".value = ''");

			}
		}else if (arguments.length == 7) {
			try {
				// form이 없는 경우
				eval(arguments[3] + ".value = ''");
				eval(arguments[4] + ".value = ''");
				eval(arguments[5] + ".value = ''");
				eval(arguments[6] + ".value = ''");
			} catch (exception) {
				// form이 있는 경우
				eval(arguments[1] + "." + arguments[3] + ".value = ''");
				eval(arguments[1] + "." + arguments[4] + ".value = ''");
				eval(arguments[1] + "." + arguments[5] + ".value = ''");
				eval(arguments[1] + "." + arguments[6] + ".value = ''");
			}
		}

	}
}
/*************************************************************************
 * cfStyleGrid(oGrid, styleName, features)
 *************************************************************************
 * author : 이상훈
 * date    : 2005/11/24
 * desc   : 그리드에 CCMS REPORT 전용 스타일을 적용한다.
 * param : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex      : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleds009Grid(oGrid, styleName, indicate) {

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

	var indWidth    = 0;
	var rowHeight   = 16;
	var titleHeight = 16;

			fontSize         = "11px";
			fontFamily       = "Tahoma";

			// 컬럼 공통 속성
			sumColor         = "#000000";
			sumBgColor       = "#FAE9BD";	// Summary
			subColor         = "#000000";
			subBgColor       = "#FBF5D8";

			// 컬럼별 속성
			CHeadColor       = "#000000";	// C컬럼 헤더 폰트 색상
			CHeadBgColor     = "#E4E0D5";	// C컬럼 헤더 색상
			FCHeadColor      = "#000000";	// FC컬럼 헤더 폰트 색상
			FCHeadBgColor    = "#E4E0D5";	// FC컬럼 헤더 색상
			GHeadColor       = "#000000";	// G컬럼 헤더 폰트 색상
			GHeadBgColor     = "#D4CFC9";	// G컬럼 헤더 색상
			FGHeadColor      = "#000000";	// FG컬럼 헤더 폰트 색상
			FGHeadBgColor    = "#D4CFC9";	// FG컬럼 헤더 색상
			XHeadColor       = "#000000";	// X컬럼 헤더 폰트 색상
			XHeadBgColor     = "#D3CDC1";	// X컬럼 헤더 색상.
			FXHeadColor      = "#000000";	// FX컬럼 헤더 폰트 색상
			FXHeadBgColor    = "#D3CDC1";	// FX컬럼 헤더 색상


	// Grid 속성 설정
	{
		oGrid.RowHeight = rowHeight;
		oGrid.TitleHeight = titleHeight;
		if (indicate == true)
		{
			oGrid.IndWidth = 0;		// indwidth 0
		} else {
			oGrid.IndWidth = 0;		// indwidth 0
		}

		oGrid.style.fontSize    = fontSize;
		oGrid.style.fontFamily  = fontFamily;
		oGrid.FillArea = true;
		oGrid.BorderStyle = 1;
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
			case "FC" :
				headAlign = "Center";
				headColor= FCHeadColor;
				headBgColor= FCHeadBgColor;
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

}


/**
 * 특정 ID안에 속한 오브젝트를 Disable/Enable하는 함수.
 * @author : 최재원
 * @date   : 2005/11/28
 * @use    : cfDisable(오브젝트 ID, boolean)
 */
function cfDisable(p_id, p_bool) {
	for (i=0; i<p_id.all.length ; i++)	{
		try {
			if ( p_id.all[i].classid.toUpperCase() == "CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197" ||
				 p_id.all[i].classid.toUpperCase() == "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F" ) {
				// 럭스 콤보
				p_id.all[i].enable = !p_bool;
			} else {
				if ( p_id.all[i].tagName.toUpperCase() == "INPUT" ||
					 p_id.all[i].tagName.toUpperCase() == "SELECT" ||
					 p_id.all[i].tagName.toUpperCase() == "TEXTAREA" ) {
					p_id.all[i].disabled = p_bool;
				}
			}

		} catch (exception) {
				if ( p_id.all[i].tagName.toUpperCase() == "INPUT" ||
					 p_id.all[i].tagName.toUpperCase() == "SELECT" ||
					 p_id.all[i].tagName.toUpperCase() == "TEXTAREA" ) {
					p_id.all[i].disabled = p_bool;
				}
		}
	}
}


/**
 * FTP서버로 부터 파일을 다운로드 한다.
 * @author : 최재원
 * @date   : 2005/11/28
 * @use    : cfFtpDownload(FTP서버ID, 파일명)
 */
function cfFtpDownload(p_Ftp, p_OrgFileNm) {
	try	{
		document.all.coFtpDownloadFrm.outerHTML = "";
	} catch (exception) {}
	var result = document.all.coFtpDownloadFrm;
	if (typeof(result) == "undefined") {
		var new_obj = document.createElement("<iframe src='/blank.html'>");
		new_obj.id = "coFtpDownloadFrm";
		new_obj.width = 0;
		new_obj.height = 0;
		var obj = document.body;
		obj.insertAdjacentElement("afterBegin", new_obj);
	}

	var url = "/servlet/DownloadSVL?ACTION=FTP_DOWNLOAD&FTP=" + p_Ftp + "&FILE_NM=" + p_OrgFileNm + "&DUMMY=" + Math.random(1)*10000;
	var obj = document.all.coFtpDownloadFrm;
	obj.src=url;
}

/*************************************************************************
 * cfStyleGrid(oGrid, styleName, features)
 *************************************************************************
 * author : 이상훈
 * date    : 2005/11/24
 * desc   : 그리드에 CCMS REPORT 전용 스타일을 적용한다.
 * param : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex      : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleds008Grid(oGrid, styleName, indicate) {

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

	var indWidth    = 0;
	var rowHeight   = 13;
	var titleHeight = 16;

			fontSize         = "11px";
			fontFamily       = "Tahoma";

			// 컬럼 공통 속성
			sumColor         = "#000000";
			sumBgColor       = "#FAE9BD";	// Summary
			subColor         = "#000000";
			subBgColor       = "#FBF5D8";

			// 컬럼별 속성
			CHeadColor       = "#000000";	// C컬럼 헤더 폰트 색상
			CHeadBgColor     = "#E4E0D5";	// C컬럼 헤더 색상
			FCHeadColor      = "#000000";	// FC컬럼 헤더 폰트 색상
			FCHeadBgColor    = "#E4E0D5";	// FC컬럼 헤더 색상
			GHeadColor       = "#000000";	// G컬럼 헤더 폰트 색상
			GHeadBgColor     = "#D4CFC9";	// G컬럼 헤더 색상
			FGHeadColor      = "#000000";	// FG컬럼 헤더 폰트 색상
			FGHeadBgColor    = "#D4CFC9";	// FG컬럼 헤더 색상
			XHeadColor       = "#000000";	// X컬럼 헤더 폰트 색상
			XHeadBgColor     = "#D3CDC1";	// X컬럼 헤더 색상.
			FXHeadColor      = "#000000";	// FX컬럼 헤더 폰트 색상
			FXHeadBgColor    = "#D3CDC1";	// FX컬럼 헤더 색상


	// Grid 속성 설정
	{
		oGrid.RowHeight = rowHeight;
		oGrid.TitleHeight = titleHeight;
		if (indicate == true)
		{
			oGrid.IndWidth = 0;		// indwidth 0
		} else {
			oGrid.IndWidth = 0;		// indwidth 0
		}

		oGrid.style.fontSize    = fontSize;
		oGrid.style.fontFamily  = fontFamily;
		oGrid.FillArea = true;
		oGrid.BorderStyle = 1;
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
			case "FC" :
				headAlign = "Center";
				headColor= FCHeadColor;
				headBgColor= FCHeadBgColor;
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
	/*
	switch(styleName) {
			case "comn" :
				// Focus가 있고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
				oGrid.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#FFFFFF', TextColor='Black'</SC>";

				// Focus가 있고 Editable이 아닌 상태에서, 선택된 Row에서 선택된 Cell을 제외한 다른셀
				oGrid.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFFF', TextColor='Black'</SC>";

				// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
				oGrid.SelectionColor += "<SC>Type='EditCol', BgColor='#FFFFFF', TextColor='navy'</SC>";

				// Focus가 없고고 Editable인 상태에서, 선택된 Row에서 선택된 Cell을 제외한 나머지 Cell들
				oGrid.SelectionColor += "<SC>Type='EditRow', BgColor='#FFFFFF', TextColor='Black'</SC>";

				// Focus가 있고 MultiSelect일 때 선택된 Row(Mark된 Row)의 Cell들(현재 Row ? 가장 마지막에 선택된 Row ? 제외)
				oGrid.SelectionColor += "<SC>Type='FocusCurCol', BgColor='Black', TextColor='Black'</SC>";

				// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell
				oGrid.SelectionColor += "<SC>Type='CurCol', BgColor='#FFFFFF', TextColor='Goldk'</SC>";

				// Focus가 없고 Editable인 상태에서, 선택된 Row에서 선택된 Cell을 제외한 나머지 Cell들 (포커스 상태에서 선택된 ROW)
				oGrid.SelectionColor += "<SC>Type='FocusCurRow', BgColor='#FFFFFF', TextColor='Black'</SC>";

				// Focus가 없고 Editable이 아닌 상태에서, 선택된 Row에서 선택된 Cell (포커스 떠난 상태의 선택된 ROW)
				oGrid.SelectionColor += "<SC>Type='CurRow', BgColor='#FFFFFF', TextColor='black'</SC>";

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
		*/
}


/*************************************************************************
 * cfStyleTab(oTab, styleName)
 *************************************************************************
 * author : 최재원
 * date    : 2004/07/12
 * desc   : 탭에 표준 스타일을 적용한다.
 * param : styleName  : 스타일명 (생략하면 표준스타일 적용)
 * ex      : cfStyleGrid(oSampleGD)
 *************************************************************************/
function cfStyleTab(oTab) {
	var backColor;
	var textColor;
	var disableBackColor;
	var disableTextColor;
	backColor = "#3B71A0";
	textColor = "#FFFFFF";
	disableBackColor = "#6CA0CE";
	disableTextColor = "#FFFFFF";

	oTab.style.fontSize = "9pt";
	oTab.BackColor = backColor;
	oTab.TextColor = textColor;
	oTab.DisableBackColor = disableBackColor;
	oTab.DisableTextColor = disableTextColor;
}

/**
 * 지정한 날짜를 입력 받아서 지정된 날짜 만큼 이전 이후 날짜를 구하는 함수
 * @date   : 2005/1208
 * @author : 최재원
 * @param  : pType  - 0: YYYYMMDD, 1: YYYY-MM-DD, 2: YYYY-MM-DD (요일) 3: YYYY/MM/DD (요일)
 */
function cfGetDate(pDateStr, pInterval, pType) {
	var WEEK = ["일", "월", "화", "수", "목", "금", "토" ];
	var dateObj = new Date(pDateStr.substring(0,4), pDateStr.substring(4,6) -1, pDateStr.substring(6,8));

	var dateReturn = new Date(dateObj.getTime() + (86400000*pInterval));

	if (pType == "0" || typeof(pType) == "undefined" || pType == "")	{
		return dateReturn.getYear() + "" + (dateReturn.getMonth()+1 < 10 ? "0" + (dateReturn.getMonth()+1) : (dateReturn.getMonth()+1)) + "" + (dateReturn.getDate()+1 < 10 ? "0" + (dateReturn.getDate()+1) : (dateReturn.getDate()+1));
	} else if (pType == "1") {
		return dateReturn.getYear() + "-" + (dateReturn.getMonth()+1 < 10 ? "0" + (dateReturn.getMonth()+1) : (dateReturn.getMonth()+1)) + "-" + (dateReturn.getDate() < 10 ? "0" + (dateReturn.getDate()) : (dateReturn.getDate()));
	} else if (pType == "2") {
		return dateReturn.getYear() + "-" + (dateReturn.getMonth()+1 < 10 ? "0" + (dateReturn.getMonth()+1) : (dateReturn.getMonth()+1)) + "-" + (dateReturn.getDate() < 10 ? "0" + (dateReturn.getDate()) : (dateReturn.getDate())) + " (" + WEEK[dateReturn.getDay()] + ")";
	} else if (pType == "3") {
		return dateReturn.getYear() + "/" + (dateReturn.getMonth()+1 < 10 ? "0" + (dateReturn.getMonth()+1) : (dateReturn.getMonth()+1)) + "/" + (dateReturn.getDate() < 10 ? "0" + (dateReturn.getDate()) : (dateReturn.getDate())) + " (" + WEEK[dateReturn.getDay()] + ")";
	} else {
		return dateReturn.getYear() + "" + (dateReturn.getMonth()+1 < 10 ? "0" + (dateReturn.getMonth()+1) : (dateReturn.getMonth()+1)) + "" + (dateReturn.getDate()+1 < 10 ? "0" + (dateReturn.getDate()+1) : (dateReturn.getDate()+1));
	}
	return dateReturn;
}

/**
 * 엑셀 다운로드시 Confirm메시지및 로그 테스트
 */
function cfCreateExcelLog(p_Gds, p_PgmId) {
	if (p_Gds.countrow == 0) {
		alert("Excel 다운로드할 데이터가 없습니다.");
		return false;
	}
	if (!confirm("Excel 다운로드 하시겠습니까?\nExcel 다운로드시 서버에 다운로드 기록을 저장합니다.")) return false;

	var result = document.all.coCreateExcelLogFrm;
	if (typeof(result) == "undefined") {
		var new_obj = document.createElement("<iframe src='/blank.html'>");
		var obj = document.body;
		new_obj.id = "coCreateExcelLogFrm";
		obj.insertAdjacentElement("afterBegin", new_obj);
	}
	var frmObj = document.all.coCreateExcelLogFrm;
	frmObj.outerHTML = "<iframe name=coCreateExcelLogFrm width=0 height=0 style=position:absolute;  src='/blank.html'></iframe>";

	var result = document.all.coCreateExcelLogForm;
	if (typeof(result) == "undefined") {
		var new_obj = document.createElement("<form>");
		new_obj.id = "coCreateExcelLogForm";
		new_obj.name = "coCreateExcelLogForm";
		new_obj.method = "post";
		new_obj.action = "/servlet/JspChannelSVL?cmd=kicc.easyoffice.cm.util.cmd.CreateExcelLogCMD";
		var obj = document.body;
		obj.insertAdjacentElement("afterBegin", new_obj);
	}
	var formObj = document.all.coCreateExcelLogForm;
	formObj.style.position = "absolute";
	formObj.innerHTML = "<input type=text name=SQL_LOG style='display:none'><input type=text name=PROGRAM_ID style='display:none'>";
	document.all.SQL_LOG.value = p_Gds.NameValue(1,"SQL_LOG");
	document.all.PROGRAM_ID.value = p_PgmId;
	formObj.action = "/servlet/JspChannelSVL?cmd=kicc.easyoffice.cm.util.cmd.CreateExcelLogCMD";
	formObj.target = "coCreateExcelLogFrm";
	formObj.submit();
	return true;
}

/**
 * 팝업창으로 부터 단말기정보를 검색하여 넣는경우
 * @date : 2005/12/15
 * @user : 김웅렬
 */
var g_Return_SaupNo, g_Return_TrmlId, g_Return_Sangho;
function cfTidInfo()
{
      g_RetVal = showModalDialog("../../common/searchTid.jsp","trmlinfo","status:no; scroll=yes;dialogWidth:622px; dialogHeight:400px");
      if (g_RetVal != "" && g_RetVal != null)
	  {
		var List = new Array();
			List = g_RetVal.split("|");

		  g_Return_SaupNo=List[0];
		  g_Return_TrmlId=List[1];
		  g_Return_Sangho=List[2];
	  }else{
		  g_Return_SaupNo="";
		  g_Return_TrmlId="";
		  g_Return_Sangho="";
	  }
}

/**
 * 팝업창으로 부터 단말기정보를 검색하여 넣는경우(권한별 대리점/딜러 조회조건이 필요없을경우)
 * @date : 2005/12/29
 * @user : 김웅렬
 */
function cfTidInfoForTrmlInfo()
{
      g_RetVal = showModalDialog("../../common/searchTid.jsp?gbn=T","trmlinfo","status:no; scroll=yes;dialogWidth:622px; dialogHeight:400px");
      if (g_RetVal != "" && g_RetVal != null)
	  {
		var List = new Array();
			List = g_RetVal.split("|");

		  g_Return_SaupNo=List[0];
		  g_Return_TrmlId=List[1];
		  g_Return_Sangho=List[2];
	  }else{
		  g_Return_SaupNo="";
		  g_Return_TrmlId="";
		  g_Return_Sangho="";
	  }
}

/**
 * BODY화면에서 BODY로 화면 전환하기 위한함수 (링크)
 */
function cfLinkMenu(p_link) {
	top.oTopMenuFrame.cfGetLinkMenu(p_link);
}

/**
 * 팝업창으로 부터 대리점정보를 검색하여 넣는경우
 * @date : 2005/12/19
 * @user : 김웅렬
 */
var g_Return_AgencyCode, g_Return_AgencyName
function cfAgentInfo()
{
      g_RetVal = showModalDialog("../../common/searchAgent.jsp","agentinfo","status:no; scroll=yes;dialogWidth:422px; dialogHeight:375px");
      if (g_RetVal != "" && g_RetVal != null)
	  {
		var List = new Array();
			List = g_RetVal.split("|");

		  g_Return_AgencyCode=List[0];
		  g_Return_AgencyName=List[1];
	  }else{
		  g_Return_AgencyCode="";
		  g_Return_AgencyName="";
	  }
}

function cfWinOpen(URL,winName,width,height)
{
	var w, strop
	strop = "width=" + width + ",height=" + height +
			",left=" + (screen.width/2 - width/2) + ",top=" + (screen.height/2 - height/2) +
			",scrollbars=0,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0";
    window.open(URL,winName,strop);
}

/**
 * 조회된 내역을 엑셀로 조회
 * @date : 2005/12/20
 * @user : 김웅렬
 */
 GLB_EXCEL_OBJ = "";
 GLB_EXCEL_TITLE = "";
function ln_Excel(obj,title){
	var tbgd_Excel=

    obj.SetExcelTitle(0, "");
	GLB_EXCEL_OBJ = obj;
	GLB_EXCEL_TITLE = title;
	TitleText = "value:" + title + ";font-face:굴림체;font-size:30pt;font-color:black;font-bold;font-underline;bgcolor:#CCFFCC;align: center;line-color:#C0C0C0;line-width:0.5pt;skiprow:1;";
	obj.SetExcelTitle(1, TitleText);
	var today = new Date();
	var day = today.getDay();
	var week;
	if (day==0) {week="일요일";}
	else if (day==1) {week="월요일";}
	else if (day==2) {week="화요일";}
	else if (day==3) {week="수요일";}
	else if (day==4) {week="목요일";}
	else if (day==5) {week="금요일";}
	else if (day==6) {week="토요일";}
	var hour = today.getHours();
	if (hour>12) {hour="오후 "+(hour-12);}
  else {hour="오전 "+hour;}
  var minute = today.getMinutes();
  var second = today.getSeconds();

	var ymd = today.getYear() +"년 "+ (today.getMonth() + 1) +"월 "+ today.getDate() + "일"
  var hms = hour + "시 " + minute + "분 " +  second + "초";
  TitleText = "value : 출력일자 : " + ymd + " ("+ week + ")";
  TitleText+= "\n" + hms;
	TitleText+= "; font-face: '굴림체';font-size: 12pt;font-color:#336600;font-italic;bgcolor:#ffffff;align:right;line-color: #C0C0C0;line-width:0.5pt;skiprow: 1;";
	obj.SetExcelTitle(1, TitleText);

	var g_Excelfile_type ="0";
	g_Excelfile_type = ln_Excel_file();
}

/**
 * 엑셀저장을 위해 선택팝업을 띄움
 * @date : 2005/12/20
 * @user : 김웅렬
 */
 function ln_Excel_file()
 {

       var g_RetVal;
       var g_PrmVal;
       var g_PrmVal = "" + "|" + "";
	  cfWinOpen("/common/p_Excel.html", "excel", 294, 122);
    	//g_RetVal = window.showModalDialog("/common/p_Excel.html", g_PrmVal, "unadorned:off;help:off; dialogHide:off;resizable:off;status:off;dialogWidth:302px; dialogHeight:150px;");
		//return g_RetVal;

 }

function cfGetCookie(name) {
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen) { //while open
	var j = i + alen;
	if (document.cookie.substring(i, j) == arg) {
		return document.cookie.substring(j);
	}
	i = document.cookie.indexOf(" ", i) + 1;
	if (i == 0) break;
	} //while close
	return null;
}

function cfSetCookies(p_name, p_value) {
    var when=new Date();
    when.setDate(when.getDate()+1);
    when.setHours(0);
    when.setMinutes(0);
    when.setSeconds(0);
    document.cookie = p_name + "=" + p_value + ";expires="+when.toGMTString()+";path=/";
}


function __ShowEmbedObject(obj) {
	document.write( obj.text );
	obj.id = "";
}

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_nbGroup(event, grpName) { //v3.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : args[i+1];
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    if ((nbArr = document[grpName]) != null)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = args[i+1];
      nbArr[nbArr.length] = img;
  } }
}

//날짜가 올바르게 들어갔는지 체크
//onblur="cfCheckDate(this);"
function cfCheckDate(){
	p_obj = arguments[0];
	if(p_obj.value.trim() != ""){//아무것도 않넣었다면 체크하지 않는다.
  	p_obj.value = p_obj.value.toDate(p_obj);
 	}
}

//숫자와 '-'(하이픈) 만 들어가도록 체크
//onkeypress="cfCheckNumber();"
function cfCheckNumber(){
	if((event.keyCode < 48)||(event.keyCode > 57)){
		if(event.keyCode != 45){
			event.returnValue=false;
		}
	}
}

//정수 만 들어가도록 체크
//onkeypress="cfCheckNumber2();"
function cfCheckNumber2(){
	if((event.keyCode < 48)||(event.keyCode > 57)){
		event.returnValue=false;
	}
}

//숫자와 '.'(마침표) 만 들어가도록 체크
//onkeypress="cfCheckNumber3();"
function cfCheckNumber3(){
	if((event.keyCode < 48)||(event.keyCode > 57)){
		if(event.keyCode != 46){
			event.returnValue=false;
		}
	}
}

//숫자와 '/'(슬러시) 만 들어가도록 체크
//onkeypress="cfCheckNumber4();"
function cfCheckNumber4(){
	if((event.keyCode < 48)||(event.keyCode > 57)){
		if(event.keyCode != 47){
			event.returnValue=false;
		}
	}
}

//날짜를 체크하여 자동으로 '-'(하이픈) 삽입
//onkeyup="cfDateHyphen(this);"
function cfDateHyphen(target){
  var maxlen = target.getAttribute("Maxlength");
 
  if(maxlen == 7){
  	switch (target.value.length){
  		case 4:
  			target.value +=  "-";
  			break;
  	}
 	}else{
  	switch (target.value.length){
  		case 4:
  			target.value +=  "-";
  			break;
  		case 7:
  			target.value +=  "-";
  			break;
  	}
  }
}

//주민번호를 체크하여 자동으로 '-'(하이픈) 삽입
//onkeyup="cfCetNoHyphen(this);"
function cfCetNoHyphen(target){

  switch (target.value.length){
  	case 6:
  		target.value +=  "-";
  		break;
  }
}

//사업자등록번호를 체크하여 자동으로 '-'(하이픈) 삽입
//onkeyup="cfComNoHyphen(this);"
function cfComNoHyphen(target){

  switch (target.value.length){
	case 3:
  		target.value +=  "-";
  		break;
  	case 6:
  		target.value +=  "-";
  		break;
  }
}

// 특정 문자를 제거하여 return한다.
function removeChar( inputVal, delChar ) {
	var inputStr = inputVal.toString();
	var str = '' ;
	for( var i=0; i<inputStr.length; i++ ) {
		if( inputStr.charAt(i) == delChar ) continue ;
		str += inputStr.charAt(i) ;
	}
	return str;
}

//서버 시간 가져 오기 위하여
function cfXmlHttpStatus(parameters) {
	
	var request = cfGetXmlHttpRequest();    
	
	/** Call back 함수 **/
	request.onreadystatechange = function() {			// 처리상태 변경 발생시 수행되는 이벤트 call back함수
		if (request.readyState == 4) {						// 서버 처리 완료
			if (request.status == 200) {                
				GLS_SYSTEM_DATE =  request.responseText;
			} else {
				var exceptShow = "상태 코드: " + xmlHttp.status;
				exceptShow += ",  비정상으로 종료되었습니다.";
				alert(exceptShow);
			}
       }
	}

	if (parameters == "" || parameters == null){
		parameters = "YYYYMMDD";
	}
          
	request.open("POST", "/servlet/JspChannelSVL?cmd=com.shift.gef.support.utility.GetServerDate&FORMAT=" + parameters, false);  

	request.send(null);								//	서버로 요청

}

/**
 * XmlHttpRequest 생성
 **/
function cfGetXmlHttpRequest() {
	var reqHttp;   
	if (window.ActiveXObject) {  // IE인 경우
		try {
           reqHttp = new ActiveXObject("Msxml2.XMLHTTP");
       } catch (e) {
           try {
               reqHttp =  new ActiveXObject("Microsoft.XMLHTTP");
           } catch (e1) {               
               reqHttp =  null;
           }
       }
	} else if (window.XMLHttpRequest){  // IE 이외의 브라우져
		try {
           reqHttp =  new XMLHttpRequest();
		} catch (e) {
           reqHttp =  null;
		}
	}
	if (reqHttp == null)  {
		alert("지원되지 않는 브라우져입니다."); 
	}
	return reqHttp;
}


//오늘날짜 리턴
function getToday() {

	cfXmlHttpStatus('YYYY-MM-DD');		// 서버의 시간을 가지고오는 부분	call back 형태로 받아야 되기 때문에 부모 함수의 리턴값을 알수가 없음.

	return GLS_SYSTEM_DATE;

}

/**
 * 오늘날짜의 배열을 리턴 한다.
 * [0] year, [1] month, [2] day
 */
function getTodayArray() {
	return getToday().split("-");;
}

/**
 * 이번달의 첫날짜를 반환
 */
function getStrDate() {
    return getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
}

/**
 * 이번달의 마지막날짜를 반환
 */
function getEndDate() {
    return getTodayArray()[0]+"-"+getTodayArray()[1]+"-"+fnc_Lastday(getTodayArray()[0], getTodayArray()[1]);
}





//target : 텍스트박스 또는 문자열
//target이 텍스트박스일때 : 키 이벤트가 발생할때 해당 텍스트박스에 포멧형식으로 문자를 입력하게 한다.
//target이 문자열일대 : 해당 문자열을 포멧형식으로 리턴한다.
//fmt : 문자및 숫자를 표현할 형식
//ex) formatStr("123456789","3-4-2") ==> 3자리이후에,4자리이후,2자리이후에 "-" 넣기 Result : 123-4567-89
function formatStr(target,fmt,gubun){
	var i, si, kk;
	var sp;
	var tStr;
	var g;

	if(gubun == undefined){
		g = fmt.substr(1,1);
	}else{
		if(gubun == ""){
			g = "-";
		}else{
			g = gubun;
		}
	}

	if(fmt.indexOf(g) == -1){
		return;
	}

	sp = fmt.split(g);


	if(typeof(target) == "object"){
		si = 0;
		for(i = 0; i < sp.length; i++){
			si += parseFloat(sp[i]);
			if(si == target.value.length){
				if(i == sp.length-1 && si == target.value.length){
					//event.keyCode = 9;
				}else{
					target.value += g;
				}
				return;
			}
			si += 1;
		}
	}else{
		tStr = "";
		kk = 0;
		for(i = 0; i < sp.length; i++){
			kk += getNum(sp[i]);
		}
		if(kk < target.length){
			return target;//포맷형식에 맞지 않는 문자가 온경우 그냥 리턴한다.
		}

		kk = 0;
		for(i = 0; i < sp.length; i++){
			if(i != 0)
				kk += getNum(sp[i-1]);

			for(si = 0; si < getNum(sp[i]); si++)
				tStr += target.substr(kk + si,1);

			if(i != sp.length - 1)
				tStr += g;
		}

		return tStr;
	}
}

//콤마를 입력한다.
//onkeyup="formatTextfield(this)"
var oldv="";
function formatTextfield(tx)
{
if(oldv==tx.value) return;
oldv=tx.value;
tx.value=formatNumber(oldv);
}

// 콤마를 입력한다.
function formatNumber(s)
{
	var pos, i;
	var s2 = "", s3 = "", s4 = "";

	s += "";

	if(s.charAt(0) == "-") s2 = "-";//"-"가 있는지 검사해서 임시저장

	pos = s.lastIndexOf(".");//소수점 이하의 문자를 임시저장
	if(pos != -1){
		s3 = s.substr(pos);
		s = s.substr(0,pos); //소수점이하는 제거.
	}

	for(i=0;i<s.length;i++)//숫자형에 필요한 문자만 골라냄
		if(s.charAt(i) >= "0" && s.charAt(i) <= "9")
			s4 += s.charAt(i);

	//콤마를 넣어준다.
	i = s4.length-3;
	while(i > 0) {
		s4 = s4.substr(0,i) + "," + s4.substr(i);
		i-=3;
	}

	//입력시점의 표현
	if(s2 == "" && s4 == "") s4 = "0";
	if(s2 != "" && s3 != "" && s4 == "") s4 = "0";
	if(s4.substring(0,1) == "0" && s4.length > 1)
		s4 = s4.substring(1,s4.length);

	return s2 + s4 + s3;
}

//Select 년도 가져오기(현재날짜를 기준으로 4년전, 1년후 )
function getSelYy(p_obj) {	//p_obj : select obj  id
	var year = getToday().substring(0,4);
	var oOption;

	for(var i=0 ; i<6 ; i++) {

		oOption = document.createElement("OPTION");
		oOption.text = year-4+i;
		oOption.value = year-4+i;

		document.getElementById(p_obj).add(oOption);
	}
	document.getElementById(p_obj)[4].selected = true;
}

//Select 년도 가져오기(현재날짜를 기준으로 4년전)
function getSelYy2(p_obj) {	//p_obj : select obj  id
	var year = getToday().substring(0,4);
	var oOption;

	for(var i=0 ; i<4 ; i++) {

		oOption = document.createElement("OPTION");
     	oOption.text = year-i;
	 	oOption.value = year-i;

		document.getElementById(p_obj).add(oOption);
	}
	document.getElementById(p_obj)[0].selected = true;  

/**	for(var i=0 ; i<6 ; i++) {

		oOption = document.createElement("OPTION");
		oOption.text = year-4+i;
		oOption.value = year-4+i;

		document.getElementById(p_obj).add(oOption);
	}
	document.getElementById(p_obj)[4].selected = true;   **/

}

//날짜기간체크
function cfCheckDateTerm(p_obj,p_stdt,p_endt) {
	if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
		if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
			alert("시작일자가 종료일자보다 큽니다.");
			document.getElementById(p_obj).value = '';
		}
	}
}

//년도기간체크
function cfCheckYearTerm(p_obj,p_stdt,p_endt) {
	if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
		if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
			alert("시작년도가 종료년도보다 큽니다.");
			return false;
		}
	}
	return true;
}

//MaxLengh 체크
function cfCheckLength(p_obj,p_fname,p_clength) {
	var clength = cfKorToLength(document.getElementById(p_obj).value);
	if( document.getElementById(p_obj).value != '' ) {
		if( clength > p_clength ) {
			alert("["+p_fname+"] 는(은) 영문/숫자 기준으로 ["+p_clength+"]자까지 입력가능합니다.\n다시 입력해주세요.");
			document.getElementById(p_obj).focus();
			return false;
		}
	}
	return true;
}

//숫자만 입력할 수 있도록 체크한다.
//onkeypress="cfNumberCheck();"
function cfNumberCheck() {
	if(!((event.keyCode > 47)&&(event.keyCode < 58))){
		event.returnValue=false;
	}
}

//lpad : 해당값을 넣고 자리수만큼 원하는문자를 왼쪽에서부터 채워준다
function lpad(src, len, padStr){
     var retStr = "";
     var padCnt = Number(len) - String(src).length;
     for(var i=0;i<padCnt;i++){
      retStr += String(padStr);
     }
     return retStr+src;
}

//rpad : 해당값을 넣고 자리수만큼 원하는문자를 오른쪽에서부터 채워준다
function rpad(src, len, padStr){
     var retStr = "";
     var padCnt = Number(len) - String(src).length;
     for(var i=0;i<padCnt;i++){
      retStr += String(padStr);
     }
     return src+retStr;
}

	//각 폼의 단축키 처리
	function fnc_HotKey_Process(btnList, KeyCode) {

		if (KeyCode>=112&&KeyCode<=123) {
		   event.keyCode = 0;
		   event.cancelBubble = true;
		   event.returnValue = false;

      var flag = "true";
      
      var pframe;
      try {pframe = window.external.GetFrame(window);}
      catch(e){
        //alert(window.name);alert("frame 초기화 실패");
        var flag ="false"
      }
      
      if(flag == "true"){
        var topFrame = pframe.opener.opener.frame.Provider("top");
      }
      
			var btn_function = new Array();
			var i;

			for (i = 0; i < 8; i++) {

				btn_function[i] = btnList.substring(i,1+i)

			}

		}


		//조회-F2 저장-F3 삭제-F4 취소-F5 출력-F6 신규-F7 창닫기-F8 엑셀-F9 처리-F11 바로가기-F12
		switch (KeyCode) {

			case 113:  //F2 Key : 조회
				if (btn_function[0]=='T') fnc_SearchList();
				break;
			case 118:  //F7 Key : 신규
				if (btn_function[1]=='T') fnc_AddNew();
				break;
			case 114:  //F3 Key : 저장
				if (btn_function[2]=='T') fnc_Save();
				break;
			case 116: //F5 Key : 취소
				if (btn_function[3]=='T') fnc_Clear();
				break;
			case 120: //F9 Key : 엑셀
				if (btn_function[4]=='T') fnc_ToExcel();
				break;
			case 117:  //F6 Key : 출력
				if (btn_function[5]=='T') fnc_Print();
				break;
			case 115:  //F4 Key : 삭제
				if (btn_function[6]=='T') fnc_Delete();
				break;
			case 119:  //F8 Key : 종료
				if (btn_function[7]=='T') fnc_Exit();
				break;
			case 123:  //F12 Key : 바로가기는 btn_function 상관없이 실행
        topFrame.fnc_ChangeMenu();
				break;
		}

	}


		//  사원정보 조회용 팝업이다. 넘겨주는 arguments의 개수는 왼쪽에서부터 차례대로 1개이상 필요하다,
		//  ctrl_01 : 사번
		//  ctrl_02 : 이름
		//  ctrl_03 : 부서코드
		//  ctrl_04 : 부서명
		//  ctrl_05 : 직위코드
		//  ctrl_06 : 직위명
		function fnc_emplPopup(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06,ctrl_07) {
			var obj = new String();
			
			if (ctrl_02 != undefined && ctrl_02 != '') {
				obj.eno_nm = document.getElementById(ctrl_02).value;
			}
			else {
				obj.eno_nm = '';
			}
			
			
			// 재직자
			if(ctrl_07 == undefined || ctrl_07 == "0"){
				obj.gbn = "0";
			}
			// 퇴사자
			else if (ctrl_07 == "1") {
				obj.gbn = "1";
			}
			// 재직/퇴사자 전체
			else if (ctrl_07 == "2") {
				obj.gbn = "2";
			}

			window.showModalDialog("../../common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(ctrl_01 != undefined && ctrl_01 != '' && obj.eno_no.trim() != ""){
  			document.getElementById(ctrl_01).value = obj.eno_no;
 			}
			if(ctrl_02 != undefined && ctrl_02 != '' && obj.eno_nm.trim() != ""){
 				document.getElementById(ctrl_02).value = obj.eno_nm;
			}
			if(ctrl_03 != undefined && ctrl_03 != '' && obj.dpt_cd.trim() != ""){
 				document.getElementById(ctrl_03).value = obj.dpt_cd;
			}
			if(ctrl_04 != undefined && ctrl_04 != '' && obj.dpt_nm.trim() != ""){
  			document.getElementById(ctrl_04).value = obj.dpt_nm;
 			}
			if(ctrl_05 != undefined && ctrl_05 != '' && obj.job_cd.trim() != ""){
 				document.getElementById(ctrl_05).value = obj.job_cd;
			}
			if(ctrl_06 != undefined && ctrl_06 != '' && obj.job_nm.trim() != ""){
  			document.getElementById(ctrl_06).value = obj.job_nm;
 			}
			if(ctrl_07 != undefined && ctrl_07 != '' && obj.gbn.trim() != ""){
  			document.getElementById(ctrl_07).value = obj.gbn;
 			}

 			
 			return obj;

		}

		//  사원정보 조회용 팝업이다. 넘겨주는 arguments의 개수는 왼쪽에서부터 차례대로 1개이상 필요하다,
		//  ctrl_01 : 사번
		//  ctrl_02 : 이름
		//  ctrl_03 : 부서코드
		//  ctrl_04 : 부서명
		//  ctrl_05 : 직위코드
		//  ctrl_06 : 직위명
		function fnc_empl2Popup(ctrl_01,ctrl_02,ctrl_03) {
			var obj = new String();
			
			if (ctrl_02 != undefined) {
				obj.eno_nm = document.getElementById(ctrl_02).value;
			}
			else {
				obj.eno_nm = '';
			}
			
			if(ctrl_03 == undefined || ctrl_03 == "0"){
				// 재직자만
				obj.shr_kind = "SHR_01";
			}else if(ctrl_03 == "1"){
				// 재직/퇴사자 모두 포함
				obj.shr_kind = "SHR_02";
			}

			window.showModalDialog("../../common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(ctrl_01 != undefined && obj.eno_no.trim() != ""){
  			document.getElementById(ctrl_01).value = obj.eno_no;
 			}
			if(ctrl_02 != undefined && obj.eno_nm.trim() != ""){
 				document.getElementById(ctrl_02).value = obj.eno_nm;
			}
			
			return obj;
			
		}

		//  사원정보 조회용 팝업이다. 넘겨주는 arguments의 개수는 왼쪽에서부터 차례대로 1개이상 필요하다,
		//  ctrl_01 : 사번
		//  ctrl_02 : 이름
		//  ctrl_03 : 부서코드
		//  ctrl_04 : 부서명
		//  ctrl_05 : 직위코드
		//  ctrl_06 : 직위명
		function fnc_empl3Popup(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06,ctrl_07) {
			var obj = new String();
			
			if (ctrl_02 != undefined) {
				obj.eno_nm = document.getElementById(ctrl_02).value;
			}
			else {
				obj.eno_nm = '';
			}

			// 재직자
			if(ctrl_07 == undefined || ctrl_07 == "0"){
				obj.gbn = "0";
			}
			// 퇴사자
			else if (ctrl_07 == "1") {
				obj.gbn = "1";
			}
			// 재직/퇴사자 전체
			else if (ctrl_07 == "2") {
				obj.gbn = "2";
			}

			window.showModalDialog("../../common/popup/empl3.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(ctrl_01 != undefined && ctrl_01 != '' && obj.eno_no.trim() != ""){
  			document.getElementById(ctrl_01).value = obj.eno_no;
 			}
			if(ctrl_02 != undefined && ctrl_02 != '' && obj.eno_nm.trim() != ""){
 				document.getElementById(ctrl_02).value = obj.eno_nm;
			}
			if(ctrl_03 != undefined && ctrl_03 != '' && obj.dpt_cd.trim() != ""){
 				document.getElementById(ctrl_03).value = obj.dpt_cd;
			}
			if(ctrl_04 != undefined && ctrl_04 != '' && obj.dpt_nm.trim() != ""){
  			document.getElementById(ctrl_04).value = obj.dpt_nm;
 			}
			if(ctrl_05 != undefined && ctrl_05 != '' && obj.job_cd.trim() != ""){
 				document.getElementById(ctrl_05).value = obj.job_cd;
			}
			if(ctrl_06 != undefined && ctrl_06 != '' && obj.job_nm.trim() != ""){
  			document.getElementById(ctrl_06).value = obj.job_nm;
 			}
 			
 			return obj;

		}

		//  사원정보 조회용 팝업이다. 넘겨주는 arguments의 개수는 왼쪽에서부터 차례대로 1개이상 필요하다,(리턴 후 화면단에서 사용)
		//  ctrl_01 : 사번
		//  ctrl_02 : 이름
		//  ctrl_03 : 부서코드
		//  ctrl_04 : 부서명
		//  ctrl_05 : 직위코드
		//  ctrl_06 : 직위명
		function fnc_emplPopupReturn() {
			var obj = new String();
			
			obj.eno_nm = '';

			window.showModalDialog("../../common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			return obj;
		}


        /**
         * 소속, KPI, 본부, 팀, 지점의 코드를 조회한다.
         * @param - ctrl_01 : 리턴받을 코드명
         * @param - ctrl_02 : 리턴받을 코드네임명
         * @param - ctrl_03 : 타이틀명
         * @param - ctrl_04 : cd_gbn 코드명
         * @param - ctrl_05 : 상위 부서 코드
         */
		function fnc_commnmPopup(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05) {

			var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
			obj.title = ctrl_03;
			obj.gbn = ctrl_04;
			
			if (ctrl_05 != undefined) {
				obj.up_cd = document.getElementById(ctrl_05).value;
			}
			else {
				obj.up_cd = "";
			}

			window.showModalDialog("../../common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.comm_cd != '' && obj.comm_nm != ''){
				document.getElementById(ctrl_01).value = obj.comm_cd;
				document.getElementById(ctrl_02).value = obj.comm_nm;
			    
				// 근태담당자등록 페이지에서 사용(그리드 활성화)
				if ( document.form1.grdT_CM_EMPLIST )
				{
					document.form1.grdT_CM_EMPLIST.Enable = 'true'; 
				}
			}

			if( document.getElementById(ctrl_01).readOnly != true && document.getElementById(ctrl_01).disabled != true && ctrl_04 == 'KPI' )
				document.getElementById(ctrl_01).focus();
				
		}

        /**
         * T_CM_COMMON(공통코드) 조회용 팝업 (부서 및 본부는 제외)
         * @param - ctrl_01 : 리턴받을 코드명
         * @param - ctrl_02 : 리턴받을 코드네임명
         * @param - ctrl_03 : 타이틀명
         * @param - ctrl_04 : cd_gbn 코드명
         * @param - ctrl_05 : 기준코드 gbn2_tag 사용 유무(Y/N)(20070313추가)
         * @param - ctrl_06 : 직종에 따른 코드구분(20070704추가)
         */
        function fnc_commonCodePopup(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06) {

            var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
            obj.title   = ctrl_03;
            obj.cd_gbn  = ctrl_04;

            //값이 없으면 N으로 셋팅
            if(ctrl_05 == undefined || ctrl_05.trim() == ""){
                obj.gbn2_tag = "N";
            }else{
                obj.gbn2_tag = ctrl_05;
            }
             
            //값이 없거나 공백이면 전체
            if(ctrl_06 == undefined){
                obj.occ_cd = "";
            }else{
                obj.occ_cd = ctrl_06;
            }

            window.showModalDialog("../../common/popup/commnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.comm_cd != '' && obj.comm_nm != ''){
                document.getElementById(ctrl_01).value = obj.comm_cd;
                document.getElementById(ctrl_02).value = obj.comm_nm;
            }

        }


		//    T_CM_COMMON(공통코드) 조회용 팝업(조회된 코드와 코드명을 Object로 리턴)

		function fnc_commonCodePopupReturn(ctrl_01,ctrl_02) {

			var obj = new String();

			obj.title = ctrl_01;
			obj.cd_gbn = ctrl_02;

			window.showModalDialog("../../common/popup/commnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.comm_cd != '' && obj.comm_nm != ''){
				return obj;
			}

		}
		

		// 과정코드(T_CM_COMMON, Q1) 조회용 팝업

		function fnc_eduCodePopup() {
      
			var obj = new String();
			window.showModalDialog("../../common/popup/education.jsp", obj, "dialogWidth:500px; dialogHeight:525px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
      		return obj;//return edu_cd, seq_no, Str_ymd, end_ymd, int_nam, place_cd, place_nm, cpt_pnt
      
		}
		
		// 과정코드(T_ED_COURSELIST) 조회용 팝업
		function fnc_eduCodeSearchPopup(ctrl_01, ctrl_02) {
      
			var obj = new String();

            obj.edu_cd = document.getElementById(ctrl_01).value;
            obj.edu_nm = document.getElementById(ctrl_02).value;

            window.showModalDialog("../../common/popup/eduCode.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.edu_cd != '' && obj.edu_nm != ''){
                document.getElementById(ctrl_01).value = obj.edu_cd;
                document.getElementById(ctrl_02).value = obj.edu_nm;
            }
      
		}
		
        //  우편번호, 주소 조회용 팝업

		function fnc_postPopup(ctrl_01,ctrl_02) {

			var obj = new String();

			window.showModalDialog("../../common/popup/post.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.zipcode != '' && obj.address_org != ''){
				document.getElementById(ctrl_01).value = obj.zipcode
				document.getElementById(ctrl_02).value = obj.address_org;
			}

		}


		//  부서 조회, 선택용 팝업
		//  ctrl_01 : DataSet

		function fnc_selectDPT(ctrl_01) {

			var url = "../../common/popup/dptsel.jsp";
			
			window.showModalDialog(url, ctrl_01, "dialogWidth:700px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

			return ctrl_01;

		}
		
		
		//  달성도배점정보 팝업

		function fnc_achpntPopup(evl_yy, gubun) {

			var obj = new String();
			
			window.showModalDialog("../../common/popup/achpnt.jsp?GUBUN="+gubun+"&EVL_YY="+evl_yy, obj, "dialogWidth:870px; dialogHeight:340px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		}
		
		//  강사정보 조회용 팝업이다. 넘겨주는 arguments의 개수는 왼쪽에서부터 차례대로 1개이상 필요하다,
		//  ctrl_01 : 주민번호
		//  ctrl_02 : 강사명
		function fnc_lctrPopup(ctrl_01,ctrl_02) {
			var obj = new String();
			
			window.showModalDialog("../../common/popup/lctr.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(ctrl_01 != undefined && obj.cet_no.trim() != ""){
  			document.getElementById(ctrl_01).value = obj.cet_no;
 			}
			if(ctrl_02 != undefined && obj.eno_nm.trim() != ""){
 				document.getElementById(ctrl_02).value = obj.eno_nm;
			}
		}

	/**
	 * 공통구분/관련코드로 관련코드명을 읽어옴
     * p_CdGbn      : cd_gbn 코드명
     * p_CommCd     : 코드명
     * p_CommNm     : 리턴받을 코드네임명
     * p_UpCd       : 리턴받을 상위부서코드
     * p_Gbn2Tag    : 기준코드 gbn2_tag 사용 유무(Y/N)(미구현)
     * p_OccCd      : 직종에 따른 코드구분(미구현)
	 */
	function fnc_GetCommNm(p_CdGbn, p_CommCd, p_CommNm, p_UpCd, p_Gbn2Tag, p_OccCd) {
		var svl = "";
		var upcommcd = "";
		
		if (document.getElementById(p_CommCd).value.trim() == "") {
			document.getElementById(p_CommNm).value = "";
			return;
		}

	    // 팀코드에 대한 팀명을 가져오는 경우
		if(p_CdGbn == "A6") {
			if (p_UpCd != undefined && p_UpCd != "") {
				// 해당 부서의 팀명을 가져오려는 경우
				upcommcd = document.getElementById(p_UpCd).value;
			} else {
			    upcommcd = "";
		    }
	    } else {
		    upcommcd = "";
	    }

		if (document.getElementById(p_CommCd).value.length >= 1) {
			if (document.all("coCommNmGDS") == null) {
				dataSet = document.createElement("<OBJECT>");
				dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
				dataSet.id = "coCommNmGDS";
				dataSet.SyncLoad = "true";
	
				for (var i = 0; i < document.all.length; i++) {
					if (document.all[i].tagName == "HEAD") {
						document.all[i].insertAdjacentElement("beforeEnd", dataSet);
						break;
					}
				}
			} else {
				dataSet = document.all("coCommNmGDS");
			}
			
		    svl = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.commnm.cmd.COMMNMCMD&S_MODE=SHR" +
		          "&CD_GBN=" + p_CdGbn + 
		          "&COMM_CD=" + document.getElementById(p_CommCd).value + 
		          "&UP_CD=" + upcommcd;

			dataSet.DataId = svl;
			dataSet.Reset();
			
			if (dataSet.countrow > 0)	{
				// 부서코드에 대한 부서명과 해당본부코드를 가져오는 경우
                if(p_CdGbn == "A4" && p_UpCd != undefined && p_UpCd != "") {
        	        document.getElementById(p_CommNm).value = dataSet.NameValue(1,"COMM_NM");
        	        document.getElementById(p_UpCd).value   = dataSet.NameValue(1,"UP_CD");
                } else {
        		    document.getElementById(p_CommNm).value = dataSet.NameValue(1,"COMM_NM");
    		    }
		    
			} else {
				document.getElementById(p_CommCd).value = "";
				document.getElementById(p_CommNm).value = "";
			}
		}
	}
	
	
	

    /**
     * 공통구분/관련코드로 관련코드명을 읽어옴
     * p_CdGbn      : cd_gbn 코드명
     * p_CommCd     : 코드명
     * p_CommNm     : 리턴받을 코드네임명
     * p_UpCd       : 리턴받을 상위부서코드
     * p_Gbn2Tag    : 기준코드 gbn2_tag 사용 유무(Y/N)(미구현)
     * p_OccCd      : 직종에 따른 코드구분(미구현)
     */
    function fnc_GetCommCd(p_CdGbn, p_CommCd, p_CommNm, p_UpCd, p_Gbn2Tag, p_OccCd) {
        var svl         = "";
        var upcommcd    = "";
        
        if (document.getElementById(p_CommNm).value.trim() == "") {
            document.getElementById(p_CommCd).value = "";
            return;
        }

        // 팀코드에 대한 팀명을 가져오는 경우
        if(p_CdGbn == "A6") {
            if (p_UpCd != undefined && p_UpCd != "") {
                // 해당 부서의 팀명을 가져오려는 경우
                upcommcd = document.getElementById(p_UpCd).value;
            } else {
                upcommcd = "";
            }
        } else {
            upcommcd = "";
        }

        if (document.all("coCommNmGDS") == null) {
            dataSet = document.createElement("<OBJECT>");
            dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
            dataSet.id = "coCommNmGDS";
            dataSet.SyncLoad = "true";

            for (var i = 0; i < document.all.length; i++) {
                if (document.all[i].tagName == "HEAD") {
                    document.all[i].insertAdjacentElement("beforeEnd", dataSet);
                    break;
                }
            }
        } else {
            dataSet = document.all("coCommNmGDS");
        }
        
        svl = "/servlet/GauceChannelSVL?cmd=common.commnm.cmd.COMMNMCMD&S_MODE=SHR" +
              "&CD_GBN=" + p_CdGbn + 
              "&COMM_CD=" + document.getElementById(p_CommNm).value + 
              "&UP_CD=" + upcommcd;

        dataSet.DataId = svl;
        dataSet.Reset();

        
        if (dataSet.countrow == 1)    {
            
            // 부서코드에 대한 부서명과 해당본부코드를 가져오는 경우
            if(p_CdGbn == "A4" && p_UpCd != undefined && p_UpCd != "") {
                document.getElementById(p_CommCd).value = dataSet.NameValue(1,"COMM_CD");
                document.getElementById(p_CommNm).value = dataSet.NameValue(1,"COMM_NM");
                
                document.getElementById(p_UpCd).value   = dataSet.NameValue(1,"UP_CD");
            } else {
                document.getElementById(p_CommCd).value = dataSet.NameValue(1,"COMM_CD");
                document.getElementById(p_CommNm).value = dataSet.NameValue(1,"COMM_NM");
            }
            
        }   
        //코드가 1 이상 나왔을 경우 팝업으로 선택하게
        else if (dataSet.countrow > 1) {
            if      (p_CdGbn == "A4") 
                fnc_commnmPopup(    p_CommCd, p_CommNm, '소속', 'DEPT');
            else if (p_CdGbn == "B2") 
                fnc_commnmPopup(    p_CommCd, p_CommNm, '본부', 'HEAD');
            else if (p_CdGbn == "A6") 
                fnc_commnmPopup(    p_CommCd, p_CommNm, '팀'  , 'TEAM');
            else
                fnc_commonCodePopup(p_CommCd, p_CommNm, ''    , p_CdGbn);
           
        } else {
        
            document.getElementById(p_CommCd).value = "";
            document.getElementById(p_CommNm).value = "";
            
        }

    }
	
	 /**
	 * 해당 소속의 부문을 가져온다.
   * p_DptCd : 소속 코드명
   * p_PartCd : 리턴받을 코드명
   * p_PartNm : 리턴받을 코드네임명
	 */
	function fnc_GetPartNm(p_DptCd, p_PartCd, p_PartNm) {
		var svl = "";

		if (document.getElementById(p_DptCd).value.trim() == "") {
		  document.getElementById(p_PartCd).value = "";
			document.getElementById(p_PartNm).value = "";
			return;
		}

		if (document.getElementById(p_DptCd).value.length >= 1) {
			if (document.all("coPartNmGDS") == null) {
				dataSet = document.createElement("<OBJECT>");
				dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
				dataSet.id = "coPartNmGDS";
				dataSet.SyncLoad = "true";
	
				for (var i = 0; i < document.all.length; i++) {
					if (document.all[i].tagName == "HEAD") {
						document.all[i].insertAdjacentElement("beforeEnd", dataSet);
						break;
					}
				}
			} else {
				dataSet = document.all("coPartNmGDS");
			}
			
		    svl = "/servlet/GauceChannelSVL?cmd=common.commnm.cmd.COMMNMCMD&S_MODE=SHR_07" +
		          "&CD_GBN=A4" + 
		          "&DPT_CD=" + document.getElementById(p_DptCd).value;

			dataSet.DataId = svl;
			dataSet.Reset();
			
			if (dataSet.countrow > 0)	{
  		  document.getElementById(p_PartCd).value = dataSet.NameValue(1,"PART_CD");
  		  document.getElementById(p_PartNm).value = dataSet.NameValue(1,"PART_NM");  		  
			} else {
				document.getElementById(p_PartCd).value = "";
				document.getElementById(p_PartNm).value = "";				
			}
		}
	}
	
	

	/**
	 * 사번으로 사원의 성명을 읽어옴
	 */
	function fnc_GetEnoNm(p_EnoNo, p_EnoNm, p_Gbn, p_RetCd) {                                  
		var obj = new String();                                                            
		var svl = "";                                                                      
		var shr_kind = "";                                                                 
		                                                                                   
		// p_Gbn 값   - "0" : 정규직직원, "1" : 전체(EMPLIST), "2" : 파견사원              
		// p_RetCd 값 - "0" : 전체, 1 : 재직자만                                           
		                                                                                   
		if (document.getElementById(p_EnoNo).value.trim() == "") {                         
			if (p_EnoNm != undefined && p_EnoNm != '') {                                                    
			    document.getElementById(p_EnoNm).value = "";                               
			    return;                                                                    
		    }                                                                              
		    else {		                                                                   
			    obj.eno_no   = "";                                                         
		        obj.eno_nm   = "";                                                         
		        obj.hirg_ymd = "";                                                         
		        obj.dpa_ymd  = "";                                                         
		        obj.occ_cd   = "";                                                         
		        obj.occ_nm   = "";                                                         
		        obj.head_cd  = "";                                                         
		        obj.head_nm  = "";                                                         
		        obj.dpt_cd   = "";                                                         
		        obj.dpt_nm   = "";                                                         
		        obj.job_cd   = "";                                                         
		        obj.job_nm   = "";                                                         
		        obj.hob_cd   = "";                                                         
		        obj.hob_nm   = "";                                                         
		        obj.cet_no   = "";                                                         
		        obj.hir_ymd  = "";                                                         
		        obj.ret_ymd  = "";   
		        obj.retp_ymd = "";
		        obj.mid_ymd1 = "";                                                         
		        obj.mid_ymd2 = "";                                                         
		        obj.mid_ymd3 = "";         
		        obj.mf_tag   = "";        
		        obj.acc_no   = "";                                        
		                                                                                   
		        return obj;                                                                
	        }                                                                              
		}                                                                                  
		                                                                                   
		if(p_Gbn == undefined) {                                                           
			p_Gbn = "0";                                                                   
		}                                                                                  
                                                                                           
		if(p_RetCd == undefined) {                                                         
			p_RetCd = "0";                                                                 
		}                                                                                  
                                                                                           
		if (document.getElementById(p_EnoNo).value.length >= 1) {                          
			if (document.all("coEnoNmGDS") == null) {                                      
				dataSet = document.createElement("<OBJECT>");                              
				dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";            
				dataSet.id = "coEnoNmGDS";                                                 
				dataSet.SyncLoad = "true";                                                 
	                                                                                       
				for (var i = 0; i < document.all.length; i++) {                            
					if (document.all[i].tagName == "HEAD") {                               
						document.all[i].insertAdjacentElement("beforeEnd", dataSet);       
						break;                                                             
					}                                                                      
				}                                                                          
			} else {                                                                       
				dataSet = document.all("coEnoNmGDS");                                      
			}                                                                              
			                                                                               
		    svl = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.enonm.cmd.ENONMCMD&S_MODE=SHR" +    
		          "&GBN=" + p_Gbn +                                                        
		          "&ENO_NO=" + document.getElementById(p_EnoNo).value +                    
		          "&RET_CD=" + p_RetCd;                                                    
		                                                                                   
			dataSet.DataId = svl;                                                          
			dataSet.Reset();                                                               
			                                                                               
			if (dataSet.countrow > 0) {                                                    
				                                                                           
				if (p_EnoNm != undefined && p_EnoNm != '') {                                                
					document.getElementById(p_EnoNm).value = dataSet.NameValue(1,"ENO_NM");
				}                                                                          
				else {                                                                     
					obj.eno_no   = dataSet.NameValue(1, "ENO_NO");                         
					obj.eno_nm   = dataSet.NameValue(1, "ENO_NM");                         
					obj.hirg_ymd = dataSet.NameValue(1, "HIRG_YMD");                       
					obj.dpa_ymd  = dataSet.NameValue(1, "DPA_YMD");                        
					obj.occ_cd   = dataSet.NameValue(1, "OCC_CD");                         
					obj.occ_nm   = dataSet.NameValue(1, "OCC_NM");                         
					obj.head_cd  = dataSet.NameValue(1, "HEAD_CD");                        
					obj.head_nm  = dataSet.NameValue(1, "HEAD_NM");                        
					obj.dpt_cd   = dataSet.NameValue(1, "DPT_CD");                         
					obj.dpt_nm   = dataSet.NameValue(1, "DPT_NM");                         
					obj.job_cd   = dataSet.NameValue(1, "JOB_CD");                         
					obj.job_nm   = dataSet.NameValue(1, "JOB_NM");                         
					obj.hob_cd   = dataSet.NameValue(1, "HOB_CD");                         
					obj.hob_nm   = dataSet.NameValue(1, "HOB_NM");                         
					obj.cet_no   = dataSet.NameValue(1, "CET_NO");                         
					obj.hir_ymd  = dataSet.NameValue(1, "HIR_YMD");                        
					obj.ret_ymd  = dataSet.NameValue(1, "RET_YMD");                        
					obj.ram_ymd  = dataSet.NameValue(1, "RAM_YMD");                       
					obj.ram_ymd2 = dataSet.NameValue(1, "RAM_YMD2");                       
					obj.ram_ymd3 = dataSet.NameValue(1, "RAM_YMD3"); 
					obj.mf_tag   = dataSet.NameValue(1, "MF_TAG");                       
					obj.acc_no   = dataSet.NameValue(1, "ACC_NO");                       
                                                                                           
					return obj;                                                            
				}                                                                          
			} else {                                                                       
				if (p_EnoNm != undefined && p_EnoNm != '') {                                                
					document.getElementById(p_EnoNm).value = "";                           
				}                                                                          
				else {                                                                     
					obj.eno_no   = '';                                                     
					obj.eno_nm   = '';                                                     
					obj.hirg_ymd = '';                                                     
					obj.dpa_ymd  = '';                                                     
					obj.occ_cd   = '';                                                     
					obj.occ_nm   = '';                                                     
					obj.head_cd  = '';                                                     
					obj.head_nm  = '';                                                     
					obj.dpt_cd   = '';                                                     
					obj.dpt_nm   = '';                                                     
					obj.job_cd   = '';                                                     
					obj.job_nm   = '';                                                     
					obj.hob_cd   = '';                                                     
					obj.hob_nm   = '';                                                     
					obj.cet_no   = '';                                                     
					obj.hir_ymd  = '';                                                     
					obj.ret_ymd  = ''; 
					obj.mf_tag   = '';                                                    
					obj.acc_no   = '';                                                    
                                                                                           
					return obj;                                                            
				}                                                                          
			}                                                                              
		}                                                                                                                                                           
	}                                                                                      
	
	/**
	 * 성명으로 해당 사번을 읽어옴
	 */
	function fnc_GetEnoNo(p_EnoNm, p_EnoNo, p_Gbn, p_RetCd, p_Yn) {
		var obj = new String();
		var svl = "";
		var shr_kind = "";
		
		// p_Gbn 값   - "0" : 정규직직원, "1" : 전체(EMPLIST), "2" : 파견사원
		// p_RetCd 값 - "0" : 전체, 1 : 재직자만
		
		if (document.getElementById(p_EnoNm).value.trim() == "") {
		    document.getElementById(p_EnoNo).value = "";
		    return;
		}
		
		if(p_Gbn == undefined) {
			p_Gbn = "0";
		}

		if(p_RetCd == undefined) {
			p_RetCd = "0";
		}

		if (document.getElementById(p_EnoNm).value.length >= 1) {
			if (document.all("coEnoNmGDS") == null) {
				dataSet = document.createElement("<OBJECT>");
				dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
				dataSet.id = "coEnoNmGDS";
				dataSet.SyncLoad = "true";
	
				for (var i = 0; i < document.all.length; i++) {
					if (document.all[i].tagName == "HEAD") {
						document.all[i].insertAdjacentElement("beforeEnd", dataSet);
						break;
					}
				}
			} else {
				dataSet = document.all("coEnoNmGDS");
			}
			
		    svl = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.enonm.cmd.ENONMCMD&S_MODE=SHR_01" +
		          "&GBN=" + p_Gbn + 
		          "&ENO_NM=" + document.getElementById(p_EnoNm).value + 
		          "&RET_CD=" + p_RetCd;
		          
			dataSet.DataId = svl;
			dataSet.Reset();
			
			if (dataSet.countrow > 0) {
				
				if (dataSet.countrow == 1) {
					document.getElementById(p_EnoNo).value = dataSet.NameValue(1,"ENO_NO");
				}
				else {
					
					if (p_Gbn == "0") {
						// 정규직 전체
						if (p_RetCd == "0") {
							fnc_emplPopup(p_EnoNo, p_EnoNm,'','','','',"2");
						}
						// 정규직 재직자
						else if (p_RetCd == "1") {
							fnc_emplPopup(p_EnoNo, p_EnoNm);
						}
					}
					else if (p_Gbn == "1") {
						// 전체
						if (p_RetCd == "0" ) {
							fnc_empl2Popup(p_EnoNo, p_EnoNm, "1");
						}
						// 재직자만
						else {
							fnc_empl2Popup(p_EnoNo, p_EnoNm, "0");
						}
					}
					else if (p_Gbn == "2") {
						// 파견사원 전체
						if (p_RetCd == "0") {
							fnc_empl3Popup(p_EnoNo, p_EnoNm,'','','','',"2");
						}
						// 파견사원 재직자
						else if (p_RetCd == "1") {
							fnc_empl3Popup(p_EnoNo, p_EnoNm);
						}
					}
				}
			} else {
				document.getElementById(p_EnoNo).value = "";
			}
		}

		// 추출해온 사번으로 다른 정보를 보고 싶다면.
		if(p_Yn == "Y") {
			return fnc_GetEnoNm(p_EnoNo);
		}
		
		return;
	}
	
	/**
	 * 레벨에 해당하는 직무코드/명 가져오기 (DataSet)
	 */
	function fnc_GetDutyCd(p_Gbn, p_Level) {
		var svl = "";
		
		if (p_Level.length >= 1) {
			if (document.all("coDutyNmGDS") == null) {
				dataSet = document.createElement("<OBJECT>");
				dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
				dataSet.id = "coDutyNmGDS";
				dataSet.SyncLoad = "true";
	
				for (var i = 0; i < document.all.length; i++) {
					if (document.all[i].tagName == "HEAD") {
						document.all[i].insertAdjacentElement("beforeEnd", dataSet);
						break;
					}
				}
			} else {
				dataSet = document.all("coDutyNmGDS");
			}
			
		    svl = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.commnm.cmd.COMMNMCMD&S_MODE=SHR" +
		          "&CD_GBN=" + p_Gbn + 
		          "&COMM_CD=" + p_Level;
		          
			dataSet.DataId = svl;
			dataSet.Reset();
			
			return dataSet;

		}
	}
	
	/**
	 * 직급 DataSet (Gbn2_Tag  사용)
	 */
	function fnc_GetJobCd() {
		var svl = "";

		if (document.all("coJobNmGDS") == null) {
			dataSet = document.createElement("<OBJECT>");
			dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
			dataSet.id = "coJobNmGDS";
			dataSet.SyncLoad = "true";
	    
			for (var i = 0; i < document.all.length; i++) {
				if (document.all[i].tagName == "HEAD") {
					document.all[i].insertAdjacentElement("beforeEnd", dataSet);
					break;
				}
			}
		} else {
			dataSet = document.all("coJobNmGDS");
		}
		
		svl = "../../../servlet/GauceChannelSVL?cmd=common.popup.commnm.cmd.COMMNMCMD&S_MODE=SHR_03&CD_GBN=A2";
		         
		dataSet.DataId = svl;
		dataSet.Reset();
		
		return dataSet;

	}
	
	/*
	' ------------------------------------------------------------------
	' Function    : fc_chk_byte(aro_name,ari_max)
	' Description : 입력한 글자수를 체크
	' Argument    : Object Name(글자수를 제한할 컨트롤)
	' Return      :
	' ------------------------------------------------------------------
	*/
	function fc_chk_byte(aro_name,ari_max)
	{

	   var ls_str     = aro_name.value; // 이벤트가 일어난 컨트롤의 value 값
	   var li_str_len = ls_str.length;  // 전체길이

	   // 변수초기화
	   var li_max      = ari_max; // 제한할 글자수 크기
	   var i           = 0;  // for문에 사용
	   var li_byte     = 0;  // 한글일경우는 2 그밗에는 1을 더함
	   var li_len      = 0;  // substring하기 위해서 사용
	   var ls_one_char = ""; // 한글자씩 검사한다
	   var ls_str2     = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다.

	   for(i=0; i< li_str_len; i++)
	   {
		  // 한글자추출
		  ls_one_char = ls_str.charAt(i);

		  // 한글이면 2를 더한다.
		  if (escape(ls_one_char).length > 4)
		  {
			 li_byte += 2;
		  }
		  // 그밗의 경우는 1을 더한다.
		  else
		  {
			 li_byte++;
		  }

		  // 전체 크기가 li_max를 넘지않으면
		  if(li_byte <= li_max)
		  {
			 li_len = i + 1;
		  }
	   }

	   // 전체길이를 초과하면
	   if(li_byte > li_max)
	   {
		  alert( li_max + "Byte를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. ");
		  ls_str2 = ls_str.substr(0, li_len);
		  aro_name.value = ls_str2;

	   }
	   aro_name.focus();
	}

	//  우편번호, 주소 조회용 팝업

	function fnc_Message(MessageCTL, MessageID, iCNT) {

		var Message_Text = "";

		switch (MessageID) {
			
			case "MSG_01":
				Message_Text = "* 작업을 완료 하였습니다!";
				break;
			case "MSG_02":
				Message_Text = "* 검색하신 조건의 자료가 없습니다!";
				break;
			case "MSG_03":
				Message_Text = "* " + iCNT + "건의 자료가 조회 되었습니다!";
				break;
			case "MSG_04":
				Message_Text = "* 저장 할 자료가 없습니다!";
				break;
			case "MSG_05":
				Message_Text = "* 삭제 할 자료가 없습니다!";
				break;
			case "MSG_06":
				Message_Text = "* 해당 년도 이외의 자료는 저장 및 수정이 불가합니다!";
				break;
			case "MSG_07":
				Message_Text = "* 해당년도 이외의 자료는 신규 생성 할 수 없습니다!";
				break;
			case "MSG_08":
				Message_Text = "* 해당년도 이외의 자료는 삭제 할 수 없습니다!";
				break;
		}
	
		MessageCTL.innerText = Message_Text;

	}

	// 화면 종료시 자료 저장 여부 조회
	function fnc_ExitQuestion() {

		if (confirm("변경(수정)된 자료가 있습니다. \n\n확인을 누르시면 변경된 자료는 저장되지 않고 종료 됩니다.")) {
			return true;
		} else {
			return false;
		}
	}


	// 화면 초기화시 자료 저장 여부 조회
	function fnc_ClearQuestion() {

		if (confirm("변경(수정)된 자료가 있습니다. \n\n그래도 초기화를 하시겠습니까?")) {
			return true;
		} else {
			return false;
		}
	}

	
	function fnc_GetMSG(MessageID) {

		var Message_Text = "";

		switch (MessageID) {

			case "MSG_01":
				Message_Text = "현재년도 이외의 자료는 저장 및 수정할 수 없습니다.";
				break;
			case "MSG_02":
				Message_Text = "저장할 자료가 없습니다.";
				break;
			case "MSG_03":
				Message_Text = "저장을 완료하였습니다.";
				break;
			case "MSG_04":
				Message_Text = "건의 자료가 조회되었습니다.";
				break;
			case "MSG_05":
				Message_Text = "삭제할 자료가 없습니다.";
				break;
			case "MSG_06":
				Message_Text = "년도 자료가 없습니다.";
				break;
			case "MSG_07":
				Message_Text = "년도 자료가 조회되었습니다.";
				break;
			case "MSG_08":
				Message_Text = "검색하신 조건의 자료가 없습니다.";
				break;
			case "MSG_09":
				Message_Text = "엑셀로 변환할 자료가 없습니다.";
				break;
			case "MSG_10":
				Message_Text = "현재년도 이외의 자료는 삭제할 수 없습니다.";
				break;
			case "MSG_11":
				Message_Text = "작업을 완료하였습니다.";
				break;
			case "MSG_12":
				Message_Text = "조회 후 작업이 가능합니다.";
				break;
			case "MSG_13":
				Message_Text = "해당년도 자료를 먼저 조회해 주세요.";
				break;
			case "MSG_14":
				Message_Text = "상신이 완료되었습니다.";
				break;
			case "MSG_15":
				Message_Text = "해당하는 피평가자가 없습니다.";
				break;
			case "MSG_16":
				Message_Text = "명의 피평가자가 조회되었습니다.";
				break;
			case "MSG_17":
				Message_Text = "상신할 자료가 없습니다.";
				break;
			case "MSG_18":
				Message_Text = "최종승인된 목표가 없습니다. 목표수정은 최종승인된 자료가 있어야 가능합니다.";
				break;

		}

		return Message_Text;
	}	

	/*=============================================================================* 
	 * 입력값이 숫자인지를 확인한다 
	 * param : sVal 입력스트링 
	 * return : Boolean True이면 숫자값 
	 *============================================================================*/ 
	function fnc_isNumber(sVal)
	{    
	  if(sVal.length < 1)
	  { 
		return false;
	  }

	  for(i=0; i<sVal.length; i++) 
	  {
		iBit = parseInt(sVal.substring(i,i+1));     //문자(Char)를 숫자로 변경
		if(('0' < iBit) || ('9' > iBit)) 
		{
		  //alert(i+':'+iBit+':'+'Mun');
		}
		else 
		{
		  return false;
		} 
	  }
	  return true;
	}
	
    /**
     * 날짜 형식 유효성 체크 (필드명)
     */ 
    function fnc_CheckDate(obj, fldnm) {
        if (obj.value == '') return;
        
        if(!cfDateExpr(obj.value)) {

            if (fldnm != "" && fldnm != undefined) {
                alert(fldnm + ' 은(는) 날짜형식에 맞지 않습니다.');
            }
            else {
                alert('날짜형식에 맞지 않습니다.');
            }
            obj.focus();
            
            return false;
        }
        
        return true;
    }
    
    /**
     * 날짜 형식 유효성 체크 (값)
     */ 
    function fnc_CheckDate2(val, fldnm) {
        if (val == '') return;
        
        if(!cfDateExpr(val)) {

            if (fldnm != "" && fldnm != undefined) {
                alert(fldnm + ' 은(는) 날짜형식에 맞지 않습니다.');
            }
            else {
                alert('날짜형식에 맞지 않습니다.');
            }
            
            return false;
        }
        
        return true;
    }
    
	/**                                                                           
	 * 해당 년월의 마지막 날짜를 가지고 온다.                                     
	 * @param calyear                                                             
	 * @param calmonth                                                            
	 */                                                                           
	function fnc_Lastday(calyear, calmonth) {                                     
	     var monthDays = new Array(31, 28, 31, 30, 31, 30, 31, 31,30, 31, 30, 31);
	     if (((calyear % 4 == 0) && (calyear % 100 != 0)) || (calyear % 400 == 0))
	          monthDays[1] = 29;                                                  
	                                                                              
	     var nDays = monthDays[calmonth - 1];                                     
	     return nDays;                                                            
	}        
	
    /**
     * 넘어온 문자열을 숫자만 뽑아서 반환
     * 소수점 처리 하지못함
     * @param str - 검사할 값
     */
    function fnc_covNumber(str){ 
        str = new String(str);
        
        var covStr = "";
        var mark = "";
        var strIdx = 0;
        
    	if(str == undefined || str == null || str == "" || str.length < 1) { 
    		return 0;
      	}
      	
      	if(str.charAt(idx) == '-') {
      	    mark = '-';
      	    strIdx = 1;
      	}
         
        for(var idx=strIdx; idx < str.length; idx++){
    		if(str.charAt(idx) >= '0' && str.charAt(idx) <= '9'){
    		    if(covStr.length == 0 && str.charAt(idx) == '0')
    		        continue;
           		covStr += str.charAt(idx);
          	}
       	}
        
        if(covStr.length < 1) { 
    		return 0;
      	} else {
      	    return parseInt(mark+covStr);
      	}
    }
    
    /**
     * 주어진 자리수만큼 소수점에서 절삭한다.
     */
    
    function Trunc(src, len){
     
      return Math.floor(src * Math.pow(10, len)) / Math.pow(10, len);
    
    }
    

    /**
     * 시작일 과 종료일을 비교
     * @param fromDateName - 시작일 input Element Name
     * @param toDateName - 종료일 input Element Name
     */
    function fnc_compareFromTo(fromDateName, toDateName) {
        var fromDate    = document.getElementById(fromDateName);
        var toDate      = document.getElementById(toDateName);
        
        var fromVal     = fnc_covNumber(fromDate.value);
        var toVal       = fnc_covNumber(toDate.value);
    
        if(fromVal != 0 && toVal != 0 && fromVal > toVal) {
            alert("기간의 종료년월이 시작년월보다 작습니다!\n종료년월은 시작년월보다 반드시 커야 합니다!");
            toDate.value = "";
			toDate.focus();
        }
    } 
    
    /**
     * 메세지를 팝업으로 보여준다.
     * @param : resultMsg
     */
    function fnc_ShowError(resultMsg) {
        window.showModalDialog("../../common/comm_error.jsp", resultMsg, "status:no;dialogWidth:566px; dialogHeight:375px;center:yes;dialogHide:yes;help:no");
    }   
    
    /**
     * 메세지를 팝업으로 보여준다.
     * @param : resultTitle
     * @param : resultMsg
     */
    function fnc_ShowPopup(resultTitle, resultMsg) {
        var obj = new String();
        
        obj.title = resultTitle;
        obj.message = resultMsg;
        
        window.showModalDialog("../../common/comm_popup.jsp", obj, "status:no;dialogWidth:566px; dialogHeight:375px;center:yes;dialogHide:yes;help:no");
    }
  
    /**
     * 날짜 계산
     * @param : gbn  - M(월), D(일)                           
     * @param : ymd  - 년월일                                 
     * @param : num  - 계산할 일자 (년도는 반드시 4자리로 입력)
     */
    function addDate(gbn, ymd, num) {
      
        ymd     = ymd.replace("-", "").replace("-", "");
        yyyy    = ymd.substring(0,4);
        mm      = ymd.substring(4,6);
        dd      = ymd.substring(6,8);
        
        var oDate ="";

     	if(!cfDateExpr(ymd)) return oDate;
	
        if(gbn == "D"){
            dd = dd*1 + num*1; 
            mm--; // 월은 0~11 이므로 하나 빼준다
            
            oDate = new Date(yyyy, mm, dd) // 계산된 날짜 객체 생성 (객체에서 자동 계산)
            oDate = oDate.getFullYear()+"-"+lpad((oDate.getMonth()+1),2,"0")+"-"+lpad(oDate.getDate(),2,"0");
        
        } else if(gbn == "M"){
            var cDate;
            var cYear;
            var cMonth;
            var cDay;
            
            mm = mm*1 + ((num*1)-1); // 월은 0~11 이므로 하나 빼준다
            
            cDate = new Date(yyyy, mm, dd) // 계산된 날짜 객체 생성 (객체에서 자동 계산)
            
            cYear = cDate.getFullYear(); // 계산된 년도 할당
            cMonth = cDate.getMonth(); // 계산된 월 할당
            cDay = cDate.getDate(); // 계산된 일자 할당
            
            oDate = (dd == cDay) ? cDate : new Date(cYear, cMonth, 0); // 넘어간 월의 첫쨋날 에서 하루를 뺀 날짜 객체를 생성한다.
            oDate = oDate.getFullYear()+"-"+lpad((oDate.getMonth()+1),2,"0")+"-"+lpad(oDate.getDate(),2,"0");
        } else {
            oDate = "";
        }
        
        return oDate;
    }



    function datechange(txt, format, mode){
		var objTxt = document.all[txt];
		
		switch (format)	
		{
			case "yyyymmdd":
				if(mode == "next"){								
					objTxt.value = next_day(objTxt.value);
				}else{
					objTxt.value = prev_day(objTxt.value);
				}
				break;
			case "yyyymm": 
				if(mode == "next"){								
					objTxt.value = next_month(objTxt.value);
				}else{
					objTxt.value = prev_month(objTxt.value);
				}
				break;
			case "yyyy":
				if(mode == "next"){
					if(objTxt.value.length == 0){
					}else{
						objTxt.value = parseFloat(objTxt.value) + 1;
					}
				}else{
					if(objTxt.value.length == 0){
					}else{
						objTxt.value = parseFloat(objTxt.value) - 1;
					}
				}
				break;
		}
			
		return false;
	
	}
	
	function next_month(txt){
		if(txt.length < 6){
			return txt;
		}
		
		var n = txt.split("-");
		var dt = new Date(n[0], parseFloat(n[1])-1,1); 
		dt.setMonth(parseFloat(n[1]));
		
		var yyyy = "" + dt.getFullYear();
		var mm = "" + (dt.getMonth() +1);
  		
		mm = lpad(mm,2,'0');
		
		return yyyy + "-" + mm;					
	}

	function prev_month(txt){
		if(txt.length < 6){
			return txt;
		}
		
		var n = txt.split("-");
		var dt = new Date(n[0], parseFloat(n[1])-1,1); 
		dt.setMonth(parseFloat(n[1])-2);
		
		var yyyy = "" + dt.getFullYear();
		var mm = "" + (dt.getMonth() +1);

		mm = lpad(mm,2,'0');
		
		return yyyy + "-" + mm;
	}
	
	
	/**
	 * 문자자열에서 유효한 날짜값을 반환한다.
	 * @param - dateName 날짜 문자열이거나 날짜 element id 이름
	 */
    function fnc_GetDataStr(dateStr) {
        
        if(dateStr == undefined) {
            dateStr     = getToday();
        } else if(document.getElementById(dateStr) != undefined){
            dateStr     = document.getElementById(dateStr).value;
        }

        dateStr = ""+fnc_covNumber(dateStr);
        
        if(dateStr.length == 6)
            dateStr = dateStr + fnc_Lastday(dateStr.substr(0, 4), dateStr.substr(5, 2));
        else if(dateStr.length == 4)
            dateStr = dateStr + "1231";
        else if(dateStr.length != 8)
            dateStr = getToday().replace(/-/g, "");
        
        return dateStr;
    }

    /**
     * 사번으로 사원의 정보(Object)를 읽어옴
     * @param p_EnoNo - 사번
     * @param p_DptCd - 부서
     * @param - p_GbnCd     - '' : 전체, '1' : 정규직원, '2' : 파견사원, '3' : 근태사원
     * @param - p_RetCd     - '' : 전체, '1' : 재직자만, '2' : 퇴사자만, '3' : 입사자만
     * @param - p_StrYmd    - 기준시작일
     * @param - p_EndYmd    - 기준종료일
     */
    function fnc_GetApprover(p_EnoNo, p_DptCd, p_GbnCd, p_RetCd, p_StrYmd, p_EndYmd) {
        var obj = new String();
        
        if(p_DptCd == undefined) {
            p_DptCd = "";    
        }            
        // 정규직만
        if(p_GbnCd == undefined) {    
            p_GbnCd = "1";       
        }
        // 재직자만
        if(p_RetCd == undefined) {    
            p_RetCd = "1";       
        }
        // 날짜가 있는지 여부 체크
        p_StrYmd = fnc_GetDataStr(p_StrYmd);
        p_EndYmd = fnc_GetDataStr(p_EndYmd);
        
        obj.eno_no  = p_EnoNo;
        obj.dpt_cd  = p_DptCd;
        obj.gbn_cd  = p_GbnCd;
        obj.ret_cd  = p_RetCd;
        obj.str_ymd = p_StrYmd;
        obj.end_ymd = p_EndYmd;
        
        window.showModalDialog("../../common/popup/approver.jsp", obj, "dialogWidth:500px; dialogHeight:490px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        
        return obj;                                                                           
    }
    
    
    /**
     * 사번으로 결재선 조회한다. DS로 리컨값을 받는다.
     * @param p_EnoNo - 사번
     * @param p_DptCd - 부서
     * @param - p_GbnCd     - '' : 전체, '1' : 정규직원, '2' : 파견사원, '3' : 근태사원
     * @param - p_RetCd     - '' : 전체, '1' : 재직자만, '2' : 퇴사자만, '3' : 입사자만
     * @param - p_StrYmd    - 기준시작일
     * @param - p_EndYmd    - 기준종료일
     */
    function fnc_GetApproverDS(dataSet, p_DptCd, p_GbnCd, p_RetCd, p_StrYmd, p_EndYmd) {

        if(p_DptCd == undefined) {
            p_DptCd = "";    
        } 
        // 정규직만
        if(p_GbnCd == undefined) {    
            p_GbnCd = "1";       
        }
        // 재직자만
        if(p_RetCd == undefined) {    
            p_RetCd = "1";       
        }
        // 날짜가 있는지 여부 체크
        p_StrYmd = fnc_GetDataStr(p_StrYmd);
        p_EndYmd = fnc_GetDataStr(p_EndYmd);
              
              
        //파라미터
        var paraVal = "&DPT_CD="  + p_DptCd  + 
                      "&GBN_CD="  + p_GbnCd  + 
                      "&RET_CD="  + p_RetCd  +
                      "&STR_YMD=" + p_StrYmd +
                      "&END_YMD=" + p_EndYmd ;
        
        window.showModalDialog("../../common/popup/approver_ds.jsp?"+paraVal, dataSet, "dialogWidth:500px; dialogHeight:625px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        

        return dataSet;
    }   
    


    /**
     * 사번으로 결재선 조회한다. DS로 리컨값을 받는다.
     * @param p_EnoNo - 사번
     * @param p_DptCd - 부서
     * @param - p_GbnCd     - '' : 전체, '1' : 정규직원, '2' : 파견사원, '3' : 근태사원
     * @param - p_RetCd     - '' : 전체, '1' : 재직자만, '2' : 퇴사자만, '3' : 입사자만
     * @param - p_StrYmd    - 기준시작일
     * @param - p_EndYmd    - 기준종료일
	 * @param - p_AppNum    - 결재자숫자
	 * @param - p_GunGbn    - 근태구분
     */
    function fnc_GetDiApproverDS(dataSet, p_EnoNo, p_DptCd, p_GbnCd, p_RetCd, p_StrYmd, p_EndYmd, p_AppNum, p_GunGbn, p_Cost) {

        if(p_DptCd == undefined) {
            p_DptCd = "";    
        } 
        // 정규직만
        if(p_GbnCd == undefined) {    
            p_GbnCd = "1";       
        }
        // 재직자만
        if(p_RetCd == undefined) {    
            p_RetCd = "1";       
        }
        // 날짜가 있는지 여부 체크
        p_StrYmd = fnc_GetDataStr(p_StrYmd);
        p_EndYmd = fnc_GetDataStr(p_EndYmd);
              
              
        //파라미터
        var paraVal = "&DPT_CD="  + p_DptCd  + 
                      "&GBN_CD="  + p_GbnCd  + 
                      "&RET_CD="  + p_RetCd  +
                      "&STR_YMD=" + p_StrYmd +
                      "&END_YMD=" + p_EndYmd +
                      "&APP_NUM=" + p_AppNum +
                      "&GUN_GBN=" + p_GunGbn +
					  "&EDU_CST=" + p_Cost   +
                      "&ENO_NO=" + p_EnoNo ;
        
        window.showModalDialog("../../common/popup/di_approver.jsp?"+paraVal, dataSet, "dialogWidth:500px; dialogHeight:625px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        

        return dataSet;
    }   



    /**
     * 사번으로 해당 성명을 읽어옴 (공통으로 통일시킴)
     * @param - p_EnoNo_nm  - 사번 Element Name
     * @param - p_EnoNm_nm  - 성명 Element Name
     * @param - p_DptCd_nm  - 제한을 걸 부서코드 (비어 있으면 모든 부서)
     * @param - p_GbnCd     - '' : 전체, '1' : 정규직원, '2' : 파견사원, '3' : 근태사원
     * @param - p_RetCd     - '' : 전체, '1' : 재직자만, '2' : 퇴사자만, '3' : 입사자만
     * @param - p_StrYmd    - 기준시작일
     * @param - p_EndYmd    - 기준종료일
     */
    function fnc_GetCommonEnoNm(p_EnoNo_nm, p_EnoNm_nm, p_DptCd_nm, p_GbnCd, p_RetCd, p_StrYmd, p_EndYmd) {
        var dataSet;
        var svl = "";
        var p_DptCd;
        
        //사번이 없으면 return
        if (document.getElementById(p_EnoNo_nm).value.trim() == "") {
            document.getElementById(p_EnoNo_nm).value = "";
            if(p_EnoNm_nm != undefined
                    && p_EnoNm_nm != ""
                    && document.getElementById(p_EnoNm_nm) != undefined){
                document.getElementById(p_EnoNm_nm).value = "";
            }
            return;
        }
        
        // 부서코드
        if (p_DptCd_nm == undefined 
                || p_DptCd_nm == ""
                || document.getElementById(p_DptCd_nm) == undefined ) {
            p_DptCd = "";
        } else {
            p_DptCd = document.getElementById(p_DptCd_nm).value;
        }

        // 정규직만
        if(p_GbnCd == undefined) {    
            p_GbnCd = "1";       
        }
        // 재직자만
        if(p_RetCd == undefined) {    
            p_RetCd = "1";       
        }
        // 날짜가 있는지 여부 체크
        p_StrYmd = fnc_GetDataStr(p_StrYmd);
        p_EndYmd = fnc_GetDataStr(p_EndYmd);


        //임시 DataSet을 만듬
        if (document.all("coEnoNmGDS") == null) {
            dataSet = document.createElement("<OBJECT>");
            dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
            dataSet.id = "coEnoNmGDS";
            dataSet.SyncLoad = "true";

            for (var i = 0; i < document.all.length; i++) {
                if (document.all[i].tagName == "HEAD") {
                    document.all[i].insertAdjacentElement("beforeEnd", dataSet);
                    break;
                }
            }
        } else {
            dataSet = document.all("coEnoNmGDS");
        }
        
        
        //성명 조회
        svl = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR00" +
              "&ENO_NO="  + document.getElementById(p_EnoNo_nm).value + 
              "&DPT_CD="  + p_DptCd + 
              "&GBN_CD="  + p_GbnCd  + 
              "&RET_CD="  + p_RetCd  +
              "&STR_YMD=" + p_StrYmd +
              "&END_YMD=" + p_EndYmd ;
              
        dataSet.DataId = svl;
        dataSet.Reset();
        
        
        //반환할 개체
        var obj = new String();
        obj.eno_no  = "";
        obj.eno_nm  = "";
        obj.occ_cd  = "";
        obj.occ_nm  = "";
        obj.dpt_cd  = "";
        obj.dpt_nm  = "";
        obj.job_cd  = "";
        obj.job_nm  = "";
        obj.head_cd = "";
        obj.head_nm = "";
        obj.cet_no  = "";
        obj.mf_tag  = "";
        
        obj.hirg_ymd = '';
        obj.hir_ymd  = '';
        obj.ret_ymd  = '';
        obj.ram_ymd  = '';
        obj.ram_ymd2 = '';
        obj.ram_ymd3 = '';
        obj.dpa_ymd  = '';
        
        obj.retp_ymd = "";
        obj.mid_ymd1 = '';
        obj.mid_ymd2 = '';
        obj.mid_ymd3 = '';
        
        obj.hirr_ymd = '';

		obj.duty_cd = '';
		obj.duty_nm = '';

		obj.head_tag = '';
        
        
        //조회되는 건수가  하나면 그걸로 성명을 조회하고 아니면 팝업을 띄움
        if (dataSet.countrow == 1) {
            document.getElementById(p_EnoNo_nm).value = dataSet.NameValue(1,"ENO_NO");
            
            if(p_EnoNm_nm != undefined
                    && p_EnoNm_nm != ""
                    && document.getElementById(p_EnoNm_nm) != undefined 
                    && dataSet.NameValue(1,"ENO_NM") != ""){
                document.getElementById(p_EnoNm_nm).value = dataSet.NameValue(1,"ENO_NM");
            }
            
            obj.eno_no   = dataSet.NameValue(1,'ENO_NO');
            obj.eno_nm   = dataSet.NameValue(1,'ENO_NM');
            obj.occ_cd   = dataSet.NameValue(1,'OCC_CD');
            obj.occ_nm   = dataSet.NameValue(1,'OCC_NM');
            obj.dpt_cd   = dataSet.NameValue(1,'DPT_CD');
            obj.dpt_nm   = dataSet.NameValue(1,'DPT_NM');
            obj.job_cd   = dataSet.NameValue(1,'JOB_CD');
            obj.job_nm   = dataSet.NameValue(1,'JOB_NM');
            obj.head_cd  = dataSet.NameValue(1,'HEAD_CD');
            obj.head_nm  = dataSet.NameValue(1,'HEAD_NM');
            obj.cet_no   = dataSet.NameValue(1,'CET_NO');
            obj.mf_tag   = dataSet.NameValue(1,'MF_TAG');
            
            obj.hirg_ymd = dataSet.NameValue(1,'HIRG_YMD');
            obj.hir_ymd  = dataSet.NameValue(1,'HIR_YMD' );
            obj.ret_ymd  = dataSet.NameValue(1,'RET_YMD' );
            obj.ram_ymd  = dataSet.NameValue(1,'RAM_YMD' );
            obj.ram_ymd2 = dataSet.NameValue(1,'RAM_YMD2');
            obj.ram_ymd3 = dataSet.NameValue(1,'RAM_YMD3');
            obj.dpa_ymd  = dataSet.NameValue(1,'DPA_YMD' );
            
            obj.retp_ymd = dataSet.NameValue(1,'RETP_YMD');
            obj.mid_ymd1 = dataSet.NameValue(1,'MID_YMD1');
            obj.mid_ymd2 = dataSet.NameValue(1,'MID_YMD2');
            obj.mid_ymd3 = dataSet.NameValue(1,'MID_YMD3');
            
            obj.hirr_ymd = dataSet.NameValue(1,'HIRR_YMD');
            
            obj.duty_cd = dataSet.NameValue(1,'DUTY_CD');
            obj.duty_nm = dataSet.NameValue(1,'DUTY_NM');

			obj.head_tag = dataSet.NameValue(1,'HEAD_TAG');
            
        } else {
            document.getElementById(p_EnoNo_nm).value = "";
            if(p_EnoNm_nm != undefined
                    && p_EnoNm_nm != ""
                    && document.getElementById(p_EnoNm_nm) != undefined){
                document.getElementById(p_EnoNm_nm).value = "";
            }
        }
        
        return obj;
    }

	/**
	 * 성명으로 해당 사번을 읽어옴 (공통으로 통일시킴)
	 * @param - p_EnoNo_nm  - 사번 Element Name
     * @param - p_EnoNm_nm  - 성명 Element Name
     * @param - p_DptCd_nm  - 제한을 걸 부서코드 (비어 있으면 모든 부서)
	 * @param - p_GbnCd     - '' : 전체, '1' : 정규직원, '2' : 파견사원, '3' : 근태사원
     * @param - p_RetCd     - '' : 전체, '1' : 재직자만, '2' : 퇴사자만, '3' : 입사자만
     * @param - p_StrYmd    - 기준시작일
     * @param - p_EndYmd    - 기준종료일
	 */
	function fnc_GetCommonEnoNo(p_EnoNo_nm, p_EnoNm_nm, p_DptCd_nm, p_GbnCd, p_RetCd, p_StrYmd, p_EndYmd) {
        var dataSet;
		var svl = "";

        //성명이 없으면 return
		if (document.getElementById(p_EnoNm_nm).value.trim() == "") {
		    document.getElementById(p_EnoNo_nm).value = "";
		    return;
		}

        // 부서코드
        if (p_DptCd_nm == undefined 
                || p_DptCd_nm == ""
                || document.getElementById(p_DptCd_nm) == undefined ) {
            p_DptCd = "";
        } else {
            p_DptCd = document.getElementById(p_DptCd_nm).value;
        }

		
        // 정규직만
		if(p_GbnCd == undefined) {    
			p_GbnCd = "1";       
		}
        // 재직자만
		if(p_RetCd == undefined) {    
			p_RetCd = "1";       
		}

        // 날짜가 있는지 여부 체크
        p_StrYmd = fnc_GetDataStr(p_StrYmd);
        p_EndYmd = fnc_GetDataStr(p_EndYmd);


        //임시 DataSet을 만듬
		if (document.all("coEnoNmGDS") == null) {
			dataSet = document.createElement("<OBJECT>");
			dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
			dataSet.id = "coEnoNmGDS";
			dataSet.SyncLoad = "true";

			for (var i = 0; i < document.all.length; i++) {
				if (document.all[i].tagName == "HEAD") {
					document.all[i].insertAdjacentElement("beforeEnd", dataSet);
					break;
				}
			}
		} else {
			dataSet = document.all("coEnoNmGDS");
		}
		
        
        //성명 조회
	    svl = "../../../servlet/GauceChannelSVL?cmd=common.empl.cmd.EMPLCMD&S_MODE=SHR" +
	          "&ENO_NO="  + document.getElementById(p_EnoNm_nm).value + 
	          "&DPT_CD="  + p_DptCd  +    //document.getElementById(p_DptCd_nm).value + 
              "&GBN_CD="  + p_GbnCd  + 
	          "&RET_CD="  + p_RetCd  +
	          "&STR_YMD=" + p_StrYmd +
	          "&END_YMD=" + p_EndYmd ;
              
		dataSet.DataId = svl;
		dataSet.Reset();
		
        
        //조회되는 건수가  하나면 그걸로 성명을 조회하고 아니면 팝업을 띄움
		if (dataSet.countrow > 0) {
			if (dataSet.countrow == 1) {
                document.getElementById(p_EnoNo_nm).value = dataSet.NameValue(1,"ENO_NO");
                document.getElementById(p_EnoNm_nm).value = dataSet.NameValue(1,"ENO_NM");
			}
			else {
				fnc_CommonEmpPopup(p_EnoNo_nm, p_EnoNm_nm, p_DptCd_nm, p_GbnCd, p_RetCd, p_StrYmd, p_EndYmd);
			}
		} 
        else {
			document.getElementById(p_EnoNo_nm).value = "";
            document.getElementById(p_EnoNm_nm).value = "";
		}
		
		return;
	}
    
    
	/**
	 * 성명으로 해당 사번을 읽어옴 (공통으로 통일시킴)
     * @param - p_EnoNo_nm  - 사번 Element Name
	 * @param - p_EnoNm_nm  - 성명 Element Name
     * @param - p_DptCd_nm  - 제한을 걸 부서코드 (비어 있으면 모든 부서)
	 * @param - p_GbnCd     - '' : 전체, '1' : 정규직원, '2' : 파견사원, '3' : 근태사원
     * @param - p_RetCd     - '' : 전체, '1' : 재직자만, '2' : 퇴사자만, '3' : 입사자만
     * @param - p_StrYmd    - 기준시작일
     * @param - p_EndYmd    - 기준종료일
	 */
    function fnc_CommonEmpPopup(p_EnoNo_nm, p_EnoNm_nm , p_DptCd_nm, p_GbnCd, p_RetCd, p_StrYmd, p_EndYmd) {
        var obj = new String();

        // 정규직만
		if(p_GbnCd == undefined) {    
			p_GbnCd = "1";       
		}

        // 재직자만
		if(p_RetCd == undefined) {    
			p_RetCd = "1";       
		}

        // 날짜가 있는지 여부 체크
        p_StrYmd = fnc_GetDataStr(p_StrYmd);
        p_EndYmd = fnc_GetDataStr(p_EndYmd);
     
        obj.eno_no  = '';
        obj.eno_nm  = p_EnoNm_nm == undefined ? "" : document.getElementById(p_EnoNm_nm).value;
        obj.dpt_cd  = p_DptCd_nm == undefined ? "" : document.getElementById(p_DptCd_nm).value;
        obj.gbn_cd  = p_GbnCd;
        obj.ret_cd  = p_RetCd;
        obj.str_ymd = p_StrYmd;
        obj.end_ymd = p_EndYmd;
        
        window.showModalDialog("../../common/popup/commonEmpl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        
        if(p_EnoNo_nm != undefined
                && p_EnoNo_nm != ""
                && document.getElementById(p_EnoNo_nm) != undefined 
                && obj.eno_no.trim() != ""){
            document.getElementById(p_EnoNo_nm).value = obj.eno_no;
        }
        if(p_EnoNm_nm != undefined
                && p_EnoNm_nm != ""
                && document.getElementById(p_EnoNm_nm) != undefined 
                && obj.eno_nm.trim() != ""){
            document.getElementById(p_EnoNm_nm).value = obj.eno_nm;
        }
        
        return obj;
    }
    


   

    /**
     * 사번으로 해당 정보를 읽어 옴
     * @param - p_EnoNo - 사번을 가지고 옴
     */
    function fnc_GetCommonEnoObj(p_EnoNo) {
        var dataSet;
        var svl = "";
        var p_DptCd;
        
        
        //사번이 없으면 return
        if (p_EnoNo.trim() == "") {
            return;
        }
        
        p_DptCd  = "";
        p_GbnCd  = "";
        p_RetCd  = "";
        p_StrYmd = getToday().replace(/-/g, "");
        p_EndYmd = getToday().replace(/-/g, "");



        //임시 DataSet을 만듬
        if (document.all("coEnoNmGDS") == null) {
            dataSet = document.createElement("<OBJECT>");
            dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
            dataSet.id = "coEnoNmGDS";
            dataSet.SyncLoad = "true";

            for (var i = 0; i < document.all.length; i++) {
                if (document.all[i].tagName == "HEAD") {
                    document.all[i].insertAdjacentElement("beforeEnd", dataSet);
                    break;
                }
            }
        } else {
            dataSet = document.all("coEnoNmGDS");
        }
        
        
        //성명 조회
        svl = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR" +
																              "&ENO_NO="  + p_EnoNo + 
																              "&DPT_CD="  + p_DptCd + 
																              "&GBN_CD="  + p_GbnCd  + 
																              "&RET_CD="  + p_RetCd  +
																              "&STR_YMD=" + p_StrYmd +
																              "&END_YMD=" + p_EndYmd ;
              
        dataSet.DataId = svl;
        dataSet.Reset();
        
        
        //반환할 개체
        var obj = new String();
        obj.eno_no  = "";
        obj.eno_nm  = "";
        obj.occ_cd  = "";
        obj.occ_nm  = "";
        obj.dpt_cd  = "";
        obj.dpt_nm  = "";
        obj.job_cd  = "";
        obj.job_nm  = "";
        obj.head_cd = "";
        obj.head_nm = "";
        obj.cet_no  = "";
        obj.mf_tag  = "";
        
        obj.hirg_ymd = '';
        obj.hir_ymd  = '';
        obj.ret_ymd  = '';
        obj.ram_ymd  = '';
        obj.ram_ymd2 = '';
        obj.ram_ymd3 = '';
        obj.dpa_ymd  = '';
        
        obj.retp_ymd = "";
        obj.mid_ymd1 = '';
        obj.mid_ymd2 = '';
        obj.mid_ymd3 = '';
        
        obj.hirr_ymd = '';

        
        
        //조회되는 건수가  하나면 그걸로 성명을 조회
        if (dataSet.countrow == 1) {
            
            obj.eno_no   = dataSet.NameValue(1,'ENO_NO');
            obj.eno_nm   = dataSet.NameValue(1,'ENO_NM');
            obj.occ_cd   = dataSet.NameValue(1,'OCC_CD');
            obj.occ_nm   = dataSet.NameValue(1,'OCC_NM');
            obj.dpt_cd   = dataSet.NameValue(1,'DPT_CD');
            obj.dpt_nm   = dataSet.NameValue(1,'DPT_NM');
            obj.job_cd   = dataSet.NameValue(1,'JOB_CD');
            obj.job_nm   = dataSet.NameValue(1,'JOB_NM');
            obj.head_cd  = dataSet.NameValue(1,'HEAD_CD');
            obj.head_nm  = dataSet.NameValue(1,'HEAD_NM');
            obj.cet_no   = dataSet.NameValue(1,'CET_NO');
            obj.mf_tag   = dataSet.NameValue(1,'MF_TAG');
            
            obj.hirg_ymd = dataSet.NameValue(1,'HIRG_YMD');
            obj.hir_ymd  = dataSet.NameValue(1,'HIR_YMD' );
            obj.ret_ymd  = dataSet.NameValue(1,'RET_YMD' );
            obj.ram_ymd  = dataSet.NameValue(1,'RAM_YMD' );
            obj.ram_ymd2 = dataSet.NameValue(1,'RAM_YMD2');
            obj.ram_ymd3 = dataSet.NameValue(1,'RAM_YMD3');
            obj.dpa_ymd  = dataSet.NameValue(1,'DPA_YMD' );
            
            obj.retp_ymd = dataSet.NameValue(1,'RETP_YMD');
            obj.mid_ymd1 = dataSet.NameValue(1,'MID_YMD1');
            obj.mid_ymd2 = dataSet.NameValue(1,'MID_YMD2');
            obj.mid_ymd3 = dataSet.NameValue(1,'MID_YMD3');
            
            obj.hirr_ymd = dataSet.NameValue(1,'HIRR_YMD');
            
        }
        
        return obj;
    }

    

    /**
     * 사번으로 해당 정보를 읽어 옴
     * @param - p_EnoNo - 사번을 가지고 옴
     */
    function fnc_GetCommonEnoObj_DH(p_EnoNo) {
        var dataSet;
        var svl = "";
        var p_DptCd;
        
        
        //사번이 없으면 return
        if (p_EnoNo.trim() == "") {
            return;
        }
        
        p_DptCd  = "";
        p_GbnCd  = "";
        p_RetCd  = "";
        p_StrYmd = getToday().replace(/-/g, "");
        p_EndYmd = getToday().replace(/-/g, "");



        //임시 DataSet을 만듬
        if (document.all("coEnoNmGDS") == null) {
            dataSet = document.createElement("<OBJECT>");
            dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
            dataSet.id = "coEnoNmGDS";
            dataSet.SyncLoad = "true";

            for (var i = 0; i < document.all.length; i++) {
                if (document.all[i].tagName == "HEAD") {
                    document.all[i].insertAdjacentElement("beforeEnd", dataSet);
                    break;
                }
            }
        } else {
            dataSet = document.all("coEnoNmGDS");
        }
        
        
        //성명 조회
        svl = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR_DH" +
																              "&ENO_NO="  + p_EnoNo + 
																              "&DPT_CD="  + p_DptCd + 
																              "&GBN_CD="  + p_GbnCd  + 
																              "&RET_CD="  + p_RetCd  +
																              "&STR_YMD=" + p_StrYmd +
																              "&END_YMD=" + p_EndYmd ;
              
        dataSet.DataId = svl;
        dataSet.Reset();
        
        
        //반환할 개체
        var obj = new String();
        obj.eno_no  = "";
        obj.eno_nm  = "";
        obj.occ_cd  = "";
        obj.occ_nm  = "";
        obj.dpt_cd  = "";
        obj.dpt_nm  = "";
        obj.job_cd  = "";
        obj.job_nm  = "";
        obj.head_cd = "";
        obj.head_nm = "";
        obj.cet_no  = "";
        obj.mf_tag  = "";
        
        obj.hirg_ymd = '';
        obj.hir_ymd  = '';
        obj.ret_ymd  = '';
        obj.ram_ymd  = '';
        obj.ram_ymd2 = '';
        obj.ram_ymd3 = '';
        obj.dpa_ymd  = '';
        
        obj.retp_ymd = "";
        obj.mid_ymd1 = '';
        obj.mid_ymd2 = '';
        obj.mid_ymd3 = '';
        
        obj.hirr_ymd = '';

        
        
        //조회되는 건수가  하나면 그걸로 성명을 조회
        if (dataSet.countrow == 1) {
            
            obj.eno_no   = dataSet.NameValue(1,'ENO_NO');
            obj.eno_nm   = dataSet.NameValue(1,'ENO_NM');
            obj.occ_cd   = dataSet.NameValue(1,'OCC_CD');
            obj.occ_nm   = dataSet.NameValue(1,'OCC_NM');
            obj.dpt_cd   = dataSet.NameValue(1,'DPT_CD');
            obj.dpt_nm   = dataSet.NameValue(1,'DPT_NM');
            obj.job_cd   = dataSet.NameValue(1,'JOB_CD');
            obj.job_nm   = dataSet.NameValue(1,'JOB_NM');
            obj.head_cd  = dataSet.NameValue(1,'HEAD_CD');
            obj.head_nm  = dataSet.NameValue(1,'HEAD_NM');
            obj.cet_no   = dataSet.NameValue(1,'CET_NO');
            obj.mf_tag   = dataSet.NameValue(1,'MF_TAG');
            
            obj.hirg_ymd = dataSet.NameValue(1,'HIRG_YMD');
            obj.hir_ymd  = dataSet.NameValue(1,'HIR_YMD' );
            obj.ret_ymd  = dataSet.NameValue(1,'RET_YMD' );
            obj.ram_ymd  = dataSet.NameValue(1,'RAM_YMD' );
            obj.ram_ymd2 = dataSet.NameValue(1,'RAM_YMD2');
            obj.ram_ymd3 = dataSet.NameValue(1,'RAM_YMD3');
            obj.dpa_ymd  = dataSet.NameValue(1,'DPA_YMD' );
            
            obj.retp_ymd = dataSet.NameValue(1,'RETP_YMD');
            obj.mid_ymd1 = dataSet.NameValue(1,'MID_YMD1');
            obj.mid_ymd2 = dataSet.NameValue(1,'MID_YMD2');
            obj.mid_ymd3 = dataSet.NameValue(1,'MID_YMD3');
            
            obj.hirr_ymd = dataSet.NameValue(1,'HIRR_YMD');
            
        }
        
        return obj;
    }
    
    
/*
			function KeyEventHandle()
		{
		if(
		( event.ctrlKey == true && ( event.keyCode == 78 || event.keyCode == 82 ) ) ||
		( event.keyCode >= 112 && event.keyCode <= 123 ))
		{
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
		}
		}
		document.onkeydown=KeyEventHandle;
		document.onkeyup=KeyEventHandle;



		 function clickIE(){
		 if (document.all) {(message);return false;}
		  }
		 function clickNS(e){
		  if (document.layers||(document.getElementByld&!document.all)){
		  if (e.witch==2||e.which==3){(messae);return false;}}}
		  if (document.layers){
		   document.captureEvents(Event.MOUSEDOWN);
		   document.onmousedown=clickNS;
		   }
		  else{
		   document.onmouseup=clickNS;
		   document.oncontextmenu=clickIE;
		   }
		   document.oncontextmenu=new Function("return false")
*/		 
    