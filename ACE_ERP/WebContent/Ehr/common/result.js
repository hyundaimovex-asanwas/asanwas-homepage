/************************************************************************************************************* *਍ഀ
 * Common Function Ver 0.2਍ഀ
 * Date    : 2004.04.01਍ഀ
 * Author : 최재원਍ഀ
 ***************************************************************************************************************਍ഀ
 * History : 2004/04/10 재설계... fcTagIdParse() 구조 변경 (bug fix)਍ഀ
 ***************************************************************************************************************/਍ഀ
   ਍ഀ
਍ഀ
var MSG_COM_ERR_001   = "[@]은(는) 변경된 사항이 없습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_002   = "[@]은(는) 필수 입력 항목입니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_003   = "해당되는 자료가 존재하지 않습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_004   = "[@]은(는) 공백없이 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_005   = "[@]은(는) [@]cfValidObject 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_006   = "[@]은(는) [@]부터 [@]사이로 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_007   = "[@]은(는) 숫자만을 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_008   = "[@]은(는) 문자만을 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_009   = "[@]은(는) 숫자와 문자만을 입력하십시오.(공백제외)";਍ഀ
਍ഀ
var MSG_COM_ERR_010   = "[@]은(는) 숫자와 문자만을 입력하십시오.(공백포함)";਍ഀ
਍ഀ
var MSG_COM_ERR_011   = "[@]은(는) [@]자 이상으로 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_012   = "[@]은(는) [@]자 이하로 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_013   = "[@]은(는) [@] 이상으로 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_014   = "[@]은(는) [@] 이하로 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_015   = "[@]은(는) [년도]가 잘못되었습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_016   = "[@]은(는) 유효한 주민등록번호가 아닙니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_017   = "[@]은(는) 유효한 사업자등록번호가 아닙니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_018   = "[@]은(는) 유효한 날짜가 아닙니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_019   = "[@]은(는) [월]이 잘못되었습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_020   = "[@]은(는) [일]이 잘못되었습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_021   = "[@]은(는) [시]가 잘못되었습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_022   = "[@]은(는) [분]이 잘못되었습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_023   = "[@]은(는) [초]가 잘못되었습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_025   = "[@]은(는) [@]년 [@]월 [@]일 이후이어야 합니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_024   = "[@]은(는) [@]년 [@]월 [@]일 이전이어야 합니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_026   = "[@]은(는) '[@]' 형식이어야 합니다.\n" +਍ഀ
਍ഀ
                            "  - # : 문자 혹은 숫자\n" +਍ഀ
਍ഀ
                            "  - h, H : 한글(H는 공백포함)\n" +਍ഀ
਍ഀ
                            "  - A, Z : 문자(Z는 공백포함)\n" +਍ഀ
਍ഀ
                            "  - 0, 9 : 숫자(9는 공백포함)";਍ഀ
਍ഀ
var MSG_COM_ERR_027   =  "[@]은(는) [@]자리수만큼 입력하십시오. (한글은 [@]자리수)";਍ഀ
਍ഀ
var MSG_COM_ERR_028   =  "[@]은(는) [@]자 이상으로 입력하십시오. (한글은 [@]자 이상)";਍ഀ
਍ഀ
var MSG_COM_ERR_029   =  "[@]은(는) [@]자 이하로 입력하십시오. (한글은 [@]자 이하)";਍ഀ
਍ഀ
var MSG_COM_ERR_030   =  "[@]은(는) ";਍ഀ
਍ഀ
var MSG_COM_ERR_031   =  "[@]의 [@]번째 데이터에서 ";਍ഀ
਍ഀ
var MSG_COM_ERR_032   =  "[@]은(는) 중복될 수 없습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_033   =  "[@]은(는) 다음 문자가 올 수 없습니다.\n@";਍ഀ
਍ഀ
var MSG_COM_ERR_034   =  "페이지 설정이 잘못되었습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_035   =  "[@]페이지 이상은 출력할 수 없습니다";਍ഀ
਍ഀ
var MSG_COM_ERR_036   =  "[@]은(는) 다음 문자만 올 수 있습니다.\n@";਍ഀ
਍ഀ
var MSG_COM_ERR_037   =  "[@]은(는) 유효한 이메일 주소가 아닙니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_038   =  "유효한 [@]가 아닙니다."਍ഀ
਍ഀ
var MSG_COM_ERR_039   =  "시작일자를 종료일자 이전으로 선택[입력]하여 주십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_040   =  "패스워드가 일치하지 않습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_041   =  "[@]은(는) [@]할 수 없습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_042   =  "[@]은(는) 변경된 사항이 있습니다. \n변경사항을 저장 후 [@]을(를) 수행하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_043	  =  "유효하지 않는 [@] 입니다.\n다시 입력하여주십시요";਍ഀ
਍ഀ
var MSG_COM_ERR_045   =  "시작범위는 종료범위보다 작아야 합니다. :@";਍ഀ
਍ഀ
var MSG_COM_ERR_046   =  "존재하지 않는 [@]입니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_047   =  "오류가 발생하였습니다.\n관리자에게 문의하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_048   =  "[@]은(는) [@]보다 작아야 합니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_049   =  "[@]이(가) 존재하지 않습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_050   =  "오류가 발생하였습니다.\n처음부터 다시 시작하여 주십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_051   =  "[@]을(를) 실패하였습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_052   =  "해당조건의 [@]이(가) 존재하지 않습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_053   =  "[@]이(가) 누락되었습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_054   =  "[@] 생성을 실패하였습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_055   =  "[@]을(를) 확인하여 주십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_056   =  "선택된 [@]이(가) 없습니다.";਍ഀ
਍ഀ
var MSG_COM_ERR_057   =  "[@]은(는) [@] 보다 큰 값으로 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_058   =  "시작시간을 종료시간 이전으로 선택[입력]하여 주십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_059   =  "[@]은(는) 정수부를 [@]자 이하로 입력하십시오.";਍ഀ
਍ഀ
var MSG_COM_ERR_060   =  "[@]은(는) 소수부를 [@]자 이하로 입력하십시오."਍ഀ
਍ഀ
਍ഀ
਍ഀ
	/*਍ഀ
	' ------------------------------------------------------------------਍ഀ
	' Function    : fc_chk_byte(aro_name,ari_max)਍ഀ
	' Description : 입력한 글자수를 체크਍ഀ
	' Argument    : Object Name(글자수를 제한할 컨트롤)਍ഀ
	' Return      :਍ഀ
	' ------------------------------------------------------------------਍ഀ
	*/਍ഀ
	function fc_chk_byte(aro_name,ari_max)਍ഀ
	{਍ഀ
਍ഀ
	   var ls_str     = aro_name.value; // 이벤트가 일어난 컨트롤의 value 값਍ഀ
	   var li_str_len = ls_str.length;  // 전체길이਍ഀ
਍ഀ
	   // 변수초기화਍ഀ
	   var li_max      = ari_max; // 제한할 글자수 크기਍ഀ
	   var i           = 0;  // for문에 사용਍ഀ
	   var li_byte     = 0;  // 한글일경우는 2 그밗에는 1을 더함਍ഀ
	   var li_len      = 0;  // substring하기 위해서 사용਍ഀ
	   var ls_one_char = ""; // 한글자씩 검사한다਍ഀ
	   var ls_str2     = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다.਍ഀ
਍ഀ
	   for(i=0; i< li_str_len; i++)਍ഀ
	   {਍ഀ
		  // 한글자추출਍ഀ
		  ls_one_char = ls_str.charAt(i);਍ഀ
਍ഀ
		  // 한글이면 2를 더한다.਍ഀ
		  if (escape(ls_one_char).length > 4)਍ഀ
		  {਍ഀ
			 li_byte += 2;਍ഀ
		  }਍ഀ
		  // 그밗의 경우는 1을 더한다.਍ഀ
		  else਍ഀ
		  {਍ഀ
			 li_byte++;਍ഀ
		  }਍ഀ
਍ഀ
		  // 전체 크기가 li_max를 넘지않으면਍ഀ
		  if(li_byte <= li_max)਍ഀ
		  {਍ഀ
			 li_len = i + 1;਍ഀ
		  }਍ഀ
	   }਍ഀ
਍ഀ
	   // 전체길이를 초과하면਍ഀ
	   if(li_byte > li_max)਍ഀ
	   {਍ഀ
		  alert( li_max + "Byte를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. ");਍ഀ
		  ls_str2 = ls_str.substr(0, li_len);਍ഀ
		  aro_name.value = ls_str2;਍ഀ
਍ഀ
	   }਍ഀ
	   aro_name.focus();਍ഀ
	}਍ഀ
਍ഀ
	//  우편번호, 주소 조회용 팝업਍ഀ
਍ഀ
	function fnc_Message(MessageCTL, MessageID, iCNT) {਍ഀ
਍ഀ
		var Message_Text = "";਍ഀ
਍ഀ
		switch (MessageID) {਍ഀ
			਍ഀ
			case "MSG_01":਍ഀ
				Message_Text = "* 작업을 완료 하였습니다!";਍ഀ
				break;਍ഀ
			case "MSG_02":਍ഀ
				Message_Text = "* 검색하신 조건의 자료가 없습니다!";਍ഀ
				break;਍ഀ
			case "MSG_03":਍ഀ
				Message_Text = "* " + iCNT + "건의 자료가 조회 되었습니다!";਍ഀ
				break;਍ഀ
			case "MSG_04":਍ഀ
				Message_Text = "* 저장 할 자료가 없습니다!";਍ഀ
				break;਍ഀ
			case "MSG_05":਍ഀ
				Message_Text = "* 삭제 할 자료가 없습니다!";਍ഀ
				break;਍ഀ
			case "MSG_06":਍ഀ
				Message_Text = "* 해당 년도 이외의 자료는 저장 및 수정이 불가합니다!";਍ഀ
				break;਍ഀ
			case "MSG_07":਍ഀ
				Message_Text = "* 해당년도 이외의 자료는 신규 생성 할 수 없습니다!";਍ഀ
				break;਍ഀ
			case "MSG_08":਍ഀ
				Message_Text = "* 해당년도 이외의 자료는 삭제 할 수 없습니다!";਍ഀ
				break;਍ഀ
		}਍ഀ
	਍ഀ
		MessageCTL.innerText = Message_Text;਍ഀ
਍ഀ
	}਍ഀ
਍ഀ
	// 화면 종료시 자료 저장 여부 조회਍ഀ
	function fnc_ExitQuestion() {਍ഀ
਍ഀ
		if (confirm("변경(수정)된 자료가 있습니다. \n\n확인을 누르시면 변경된 자료는 저장되지 않고 종료 됩니다.")) {਍ഀ
			return true;਍ഀ
		} else {਍ഀ
			return false;਍ഀ
		}਍ഀ
	}਍ഀ
਍ഀ
਍ഀ
	// 화면 초기화시 자료 저장 여부 조회਍ഀ
	function fnc_ClearQuestion() {਍ഀ
਍ഀ
		if (confirm("변경(수정)된 자료가 있습니다. \n\n그래도 초기화를 하시겠습니까?")) {਍ഀ
			return true;਍ഀ
		} else {਍ഀ
			return false;਍ഀ
		}਍ഀ
	}਍ഀ
