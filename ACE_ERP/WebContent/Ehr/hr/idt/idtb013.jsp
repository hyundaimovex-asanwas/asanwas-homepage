<!--
***********************************************************************
* @source      : idtb013.jsp
* @description : 근로계약서 - 계약직 그외 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2018/01/02      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>근로계약서</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <link href="../../common/css/style.css" rel="stylesheet" type="text/css">
 <link href="../../common/css/general.css" rel="stylesheet" type="text/css">

 <script language=javascript src="../../common/common.js"></script>
 <script language=javascript src="../../common/result.js"></script>
 <script language=javascript src="../../common/input.js"></script>
 <script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기


        var today = getToday();
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD";
        var params = null;
        var strPis_yy="2019";

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {


           dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code040.cmd.CODE040CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&PIS_YY="+strPis_yy;
           
           //prompt('',dsT_CM_PERSON.DataId);
           
           dsT_CM_PERSON.Reset();

        }



        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
        	
            if(!fnc_SaveItemCheck()) {
            	
            	return;
            
            }

            if(confirm("본인의 연봉을 확인하였으며, 이에 대해 비밀을 유지하겠습니다.")){
            	
	            document.getElementById("txtSIGN_NM").value =document.getElementById("txtENO_NM").value;

	            //패스워드변경, count초기화
	            trT_CM_PERSON.KeyValue = "tr01(I:dsT_CM_PERSON=dsT_CM_PERSON)";
	            
	            trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code040.cmd.CODE040CMD&S_MODE=SAV&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&PIS_YY="+strPis_yy+"&SIGN_NM="+document.getElementById("txtENO_NM").value+"&CON_YMD="+document.getElementById("gcemCON_YMD").text;
	            //prompt('',dsT_CM_PERSON.text);

	            trT_CM_PERSON.post();
	         }
          }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {
        	
        	gcrp_print9.Preview();

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {

        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {


        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {

        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }



        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {
        	
			if(document.getElementById("txtSIGN_NM").value!=""){
				
			    alert("이미 서명을 하였습니다.");
			    
				return false;
				
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {

            //사번을 로그인한 사번으로 설정한 다음 기본정보를 가져온다.

           document.getElementById("txtENO_NO_SHR").value = gusrid;
           document.getElementById("txtENO_NM_SHR").value = gusrnm;


           if(gusrid != "6060002" &&  gusrid != "2030007" && gusrid != "2070020" && gusrid != "6180001"){ 

	         	fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	         	fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	         	fnc_ChangeStateElement(false, "ImgEnoNo");

			  }

			document.getElementById("txtSIGN_NM").disabled = true;
			document.getElementById("txtSIGN_NM").className = "input_ReadOnly";           
			document.getElementById("txtSIGN_YMD").disabled = true;
			document.getElementById("txtSIGN_YMD").className = "input_ReadOnly";             
					
			
			fnc_SearchList();

        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * 기타 함수              *
         ********************************************/
        //예외 항목들
        var oExceptionList = new Array(  );

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
        	
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

        }
         /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */

        function fnc_GetNm() {
        	 
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','1','0');

        }

        function fnc_Getcd() {
        	
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');
        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                    |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)           |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)           |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>

    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                  *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>


    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {

        }
    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>

    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


    <!-----------------------------------------------------+
    | Transaction Successful 처리                          |
    +------------------------------------------------------>


    <script for=trT_CM_PERSON event="OnSuccess()">
    
       // fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("정상적으로 서명 처리 되었습니다.");
        
        fnc_SearchList();
        
    </script>


    <!-----------------------------------------------------+
    | Transaction Failure 처리                             |
    +------------------------------------------------------>

    <script for=trT_CM_PERSON event="OnFail()">
    
          cfErrorMsg(this);
          
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- 캘린더 프레임-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form 시작 -->
    <form name="form1">


    <!-- 버튼 테이블 시작 -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr class="blueTable">
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="1000" border="1" cellspacing="0" cellpadding="0">
        <tr>
          <td>
          <br>&nbsp;&nbsp;현대아산(주)(이하“갑”이라 함)와 근로자 <input id="txtENO_NM" name="txtENO_NM" size="6"  style="ime-mode:disabled">(이하“을”이라 함)(은)는 자유의사에 따라 다음과 같이 근로계약을 체결한다. 
          <br>&nbsp;&nbsp;<strong>제1조【 근로계약기간】</strong>
          <br>&nbsp;&nbsp;① 근로계약기간은  <input >년 <input >월 <input >일부터 <input >년 <input >월 <input >일까지 (<input id="txtMONTH" name="txtMONTH" size="6"  style="ime-mode:disabled">개월)로 하며, 계약기간이 만료되어 연장되지 아니할 경우
          <br>&nbsp;&nbsp;근로계약은 자동으로 종료된다. 또한, 계약기간 도중 '을'이 담당하고 있는 업무가 종료될 경우, 계약기간 만료 전이라도 본 계약은 당연히 종료된다.
          <br>&nbsp;&nbsp;② '갑'을 '을'에 대해 입사일로부터 3개월간 시용(試用) 기간을 둔다. 시용기간 중 또는 시용기간이 만료된 자로서, 계속근로가 부적당하다고 인정되는 경우 
          <br>&nbsp;&nbsp;'갑'은 본 계약을 해지할 수 있다.<br>
          
          <br>&nbsp;&nbsp;<strong>제2조【 근로장소】 </strong>
          <br>&nbsp;&nbsp;'갑'이 지정한 (<input id="txtWPLACE_NM" name="txtWPLACE_NM" size="15" >)(으)로 하며, '갑'의 경영상 사정 또는 인사상 정책에 의하여 변경할 수 있다.<br>
          
          <br>&nbsp;&nbsp;<strong>제3조【 직종 및 호칭】 </strong>
          <br>&nbsp;&nbsp;'을'은 직종:<input id="txtJOB_NM" name="txtJOB_NM" size="10" >, 호칭:<input id="txtPOS_NM" name="txtPOS_NM" size="15" >으로 하며, 직종과 직위는 경영상의 필요 및 '을'의 업무능력 및 성과 등을 감안하여 취업규칙에 따라 변경할 수 있다.<br>
          
          <br>&nbsp;&nbsp;<strong>제4조【 담당업무】 </strong>
          <br>&nbsp;&nbsp;'을'의 담당업무는 '갑'이 정한 업무(<input id="txtWORK_NM" name="txtWORK_NM" size="15" >) 및 그에 부수된 업무로 하며, '갑'은 업무상 필요에 따라 이를 변경할 수 있다. '을'은 이에 대하여 이의가 없으며, 
          <br>&nbsp;&nbsp;계약내용을 현저히 이탈하지 않는 한 이를 준수하여야 한다.
          
          <br>&nbsp;&nbsp;<strong>제5조【 근무일 및 휴일】</strong>
          <br>&nbsp;&nbsp;근무일은 주 6일 근무를 원칙으로 하며, 주휴일 및 취업규칙에서 정한 날을 휴일로 한다.<br>
          
          <br>&nbsp;&nbsp;<strong>제6조【 근로시간 및 휴게시간】</strong>
          <br>&nbsp;&nbsp;근로시간은 휴게시간을 제외하고 1일 8시간으로 한다.
          <br>&nbsp;&nbsp;① 소정근로시간은 유급 주휴일을 포함하여 월 209시간으로 함.
          <br>&nbsp;&nbsp;② 시업 및 종업시각은 사업장 단위로 정하여 시행 함. 
          <br>&nbsp;&nbsp;③ 휴게시간은 점심시간 1시간으로 함.
          <br>&nbsp;&nbsp;④ '갑'은 특별한 사정이 있을 경우 근무시간을 조정할 수 있으며, 또한 연장, 야간, 휴일근로를 명할 수 있음.<br>
          
          <br>&nbsp;&nbsp;<strong>제7조【 입금】</strong>
          <br>&nbsp;&nbsp;'갑'은 '을'의 근로에 대한 대가로 회사내규에 정한 바에 따라 임금을 매월 25일에 지급하며, 임금의 세부내역은 급여규정 및 별도 연봉계약서에서 정한 바에 따른다.<br>
          
          <br>&nbsp;&nbsp;<strong>제8조【 연차유급휴가】</strong>
          <br>&nbsp;&nbsp;'갑'은 근로기준법에서 정하는 바에 따라 '을'에게 연차유급휴가를 부여한다.<br>
          
          <br>&nbsp;&nbsp;<strong>제9조【 계약해지】</strong>
          <br>&nbsp;&nbsp;'갑'과 '을'은 본 계약 또는 근로기준법 및 취업규칙을 위반하거나 의무를 이행하지 아니한 때, 당사자는 계약을 해지할 수 있다.<br>
          
          <br>&nbsp;&nbsp;<strong>제10조【 불가항력】</strong>
          <br>&nbsp;&nbsp;'갑'이 추진하고 있는 사업의 특수성을 고려하여, '갑'의 귀책사유 없이 사업이 중단되거나, 직무가 중단되어 계약을 이행하지 못할 경우에 근로계약은 자동 해지된다.<br>
          
          <br>&nbsp;&nbsp;<strong>제11조【 근로계약서의 교부】</strong>
          <br>&nbsp;&nbsp;'갑'은 근로계약을 체결함과 동시에 본 계약서를 사본하여 '을'의 교부요구와 관계없이 '을'에게 교부한다.<br>
          
          <br>&nbsp;&nbsp;<strong>제12조【 기타】</strong>
          <br>&nbsp;&nbsp;이 계약서에 정함이 없는 사항은 '갑'이 정한 제 규정 및 내부 지침에 따르기로 하며, 이 외에 정함이 없는 사항은 근로기준법령에 의한다.<br>
          
           
           </td>
          </tr>
          <tr>
          <td style="text-align:center;height:40px"><nobr>&nbsp;&nbsp;계약일자 : <comment id="__NSID__">
          			  	<object id="gcemCON_YMD" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:10px;" >
							<param name=Alignment				value=0>
							<param name=Border					value=false>
							<param name=FORMAT					value="YYYY년MM월DD일">
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script><nobr>  <br></td>
          </tr>
        
	</table>
	<!-- 조건 입력 테이블 끝 -->

	</form>
    <!-- form 끝 -->





<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N
------------------------------------------------------------------------------>
<OBJECT id=gcrp_print9  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_CM_PERSON">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_CM_PERSON">
	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='근로계약서' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='문체부 바탕체' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='따라 다음과 같이 근로계약을 체결한다.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제1조【근로계약기간】' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=868, top=278, right=1045, bottom=315, align='left', face='바탕', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='현대아산(주) (이하 “갑”이라 함)와 근로자 ' ,left=69 ,top=278 ,right=868 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(이하 “을”이라 함)(은)는 자유의사에 ' ,left=1114 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 근로계약기간은' ,left=69 ,top=452 ,right=397 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD_1', left=405, top=452, right=730, bottom=489, align='left' ,mask='XXXX년XX월XX일', face='바탕', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='② \'갑\'을 \'을\'에 대해 입사일로부터 3개월간 시용(試用) 기간을 둔다. 시용기간 중 또는 ' ,left=69 ,top=492 ,right=1884 ,bottom=529 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='할 수 있다.' ,left=108 ,top=572 ,right=1884 ,bottom=609 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시용기간이 만료된 자로서, 계속근로가 부적당하다고 인정되는 경우 \'갑\'은 본 계약을 해지' ,left=108 ,top=532 ,right=1884 ,bottom=569 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'갑\'이 지정한 (' ,left=69 ,top=677 ,right=370 ,bottom=714 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='할 수 있다.' ,left=69 ,top=717 ,right=370 ,bottom=754 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')(으)로 하며, \'갑\'의 경영상 사정 또는 인사상 정책에 의하여 변경' ,left=619 ,top=677 ,right=1881 ,bottom=714 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제2조【근로장소】' ,left=69 ,top=632 ,right=1884 ,bottom=669 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='으로 하며, 직종과 호칭은 경영상의 필요 및' ,left=968 ,top=826 ,right=1881 ,bottom=863 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', 호칭:' ,left=561 ,top=826 ,right=704 ,bottom=863 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'을\'은 직종:' ,left=69 ,top=826 ,right=304 ,bottom=863 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제3조【직종 및 호칭】' ,left=69 ,top=781 ,right=1884 ,bottom=818 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'을\'의 업무능력 및 성과 등을 감안하여 취업규칙에 따라 변경할 수 있다.' ,left=69 ,top=865 ,right=1884 ,bottom=902 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='업무상 필요에 따라 이를 변경할 수 있다. \'을\'은 이에 대하여 이의가 없으며, 계약내용을' ,left=66 ,top=1013 ,right=1881 ,bottom=1050 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제4조【담당업무】' ,left=66 ,top=929 ,right=1881 ,bottom=966 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'을\'의 담당업무는 \'갑\'이 정한 업무(' ,left=66 ,top=974 ,right=786 ,bottom=1011 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=') 및 그에 부수된 업무로 하며, \'갑\'은' ,left=1167 ,top=974 ,right=1884 ,bottom=1011 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제12조【기타】' ,left=66 ,top=2252 ,right=1881 ,bottom=2289 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이 계약서에 정함이 없는 사항은 \'갑\'이 정한 제 규정 및 내부 지침에 따르기로 하며, ' ,left=66 ,top=2297 ,right=1881 ,bottom=2334 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이 외에 정함이 없는 사항은 근로기준법령에 의한다.' ,left=66 ,top=2336 ,right=1881 ,bottom=2373 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제11조【근로계약서의 교부】' ,left=66 ,top=2101 ,right=1881 ,bottom=2138 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'갑\'은 근로계약을 체결함과 동시에 본 계약서를 사본하여 \'을\'의 교부요구와 관계없이' ,left=66 ,top=2146 ,right=1881 ,bottom=2183 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='을에게 교부한다.' ,left=66 ,top=2185 ,right=1881 ,bottom=2223 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제10조【불가항력】' ,left=66 ,top=1947 ,right=1881 ,bottom=1984 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'갑\'이 추진하고 있는 사업의 특수성을 고려하여, \'갑\'의 귀책사유 없이 사업이 중단되거나, ' ,left=66 ,top=1992 ,right=1881 ,bottom=2029 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직무가 중단되어 계약을 이행하지 못할 경우에 근로계약은 자동 해지된다.' ,left=66 ,top=2032 ,right=1881 ,bottom=2069 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제9조【계약해지】' ,left=66 ,top=1797 ,right=1881 ,bottom=1834 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'갑\'과 \'을\'은 본 계약 또는 근로기준법 및 취업규칙을 위반하거나 의무를 이행하지 아니한 때,' ,left=66 ,top=1842 ,right=1881 ,bottom=1879 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당사자는 계약을 해지할 수 있다.' ,left=66 ,top=1881 ,right=1881 ,bottom=1918 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'갑\'은 근로기준법에서 정하는 바에 따라 \'을\'에게 연차유급휴가를 부여한다.' ,left=66 ,top=1728 ,right=1881 ,bottom=1765 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제8조【연차유급휴가】' ,left=66 ,top=1683 ,right=1881 ,bottom=1720 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제7조【임금】' ,left=66 ,top=1535 ,right=1881 ,bottom=1572 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'갑\'은 \'을\'의 근로에 대한 대가로 회사내규에 정한 바에 따라 임금을 매월 25일에 지급하며,' ,left=66 ,top=1580 ,right=1881 ,bottom=1617 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임금의 세부내역은 급여규정 및 별도 연봉계약서에서 정한 바에 따른다.' ,left=66 ,top=1619 ,right=1881 ,bottom=1656 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2477 ,right=1013 ,bottom=2651</I>
	<T>id='(인)' ,left=870 ,top=2662 ,right=942 ,bottom=2709 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=868 ,top=2535 ,right=939 ,bottom=2582 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대표이사   배  국  환' ,left=447 ,top=2543 ,right=831 ,bottom=2580 ,align='left' ,face='바탕' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='서울특별시 종로구 율곡로 194 현대아산(주)' ,left=447 ,top=2482 ,right=1299 ,bottom=2519 ,align='left' ,face='바탕' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(을)' ,left=79 ,top=2617 ,right=167 ,bottom=2654 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :' ,left=235 ,top=2614 ,right=429 ,bottom=2651 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성    명 :' ,left=235 ,top=2670 ,right=429 ,bottom=2717 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성    명 :' ,left=235 ,top=2543 ,right=434 ,bottom=2580 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(갑)' ,left=77 ,top=2484 ,right=161 ,bottom=2521 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :  ' ,left=238 ,top=2484 ,right=437 ,bottom=2521 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계약일자 :          년     월     일' ,left=74 ,top=2410 ,right=1881 ,bottom=2447 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부터' ,left=733 ,top=452 ,right=831 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개월)' ,left=1781 ,top=450 ,right=1879 ,bottom=487 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='까지' ,left=1318 ,top=452 ,right=1416 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현저히 이탈하지 않는 한 이를 준수하여야 한다.' ,left=66 ,top=1053 ,right=1881 ,bottom=1090 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로시간은 휴게시간을 제외하고 1일 8시간으로 한다.' ,left=66 ,top=1281 ,right=1881 ,bottom=1318 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제6조【근로시간 및 휴게시간】' ,left=66 ,top=1236 ,right=1881 ,bottom=1273 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 소정근로시간은 유급 주휴일을 포함하여 월 209시간으로 함.' ,left=66 ,top=1320 ,right=1881 ,bottom=1357 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 시업 및 종업시각은 사업장 단위로 정하여 시행함.' ,left=66 ,top=1360 ,right=1881 ,bottom=1397 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 휴게시간은 점심시간 1시간으로 함.' ,left=66 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='④ \'갑\'은 특별한 사정이 있을 경우 근무시간을 조정할 수 있으며, 또한 연장, 야간, 휴일' ,left=66 ,top=1439 ,right=1881 ,bottom=1476 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로를 명할 수 있음.' ,left=111 ,top=1479 ,right=1881 ,bottom=1516 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무일은 주 6일 근무를 원칙으로 하며, 주휴일 및 취업규칙에서 정한 날을 휴일로 한다.' ,left=66 ,top=1180 ,right=1881 ,bottom=1217 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제5조【근무일 및 휴일】' ,left=66 ,top=1135 ,right=1881 ,bottom=1172 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='JOB_NM', left=302, top=826, right=558, bottom=863, align='left', face='바탕', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='POS_NM', left=699, top=826, right=955, bottom=863, align='left', face='바탕', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WORK_NM', left=778, top=974, right=1164, bottom=1011, align='left', face='바탕', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>





   ">
</OBJECT>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->

<object id="bndT_CM_CONTRACT_EM" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_CONTRACT_EM">
    <Param Name="BindInfo", Value='

		 <C>Col=SID            Ctrl=txtSID           Param=value   </C>
		 <C>Col=CD_GBN         Ctrl=txtCD_GBN        Param=text   </C>
		 <C>Col=ENO_NM         Ctrl=txtENO_NM        Param=text   </C>
		 <C>Col=FROM_YMD       Ctrl=txtFROM_YMD      Param=text   </C>
		 <C>Col=TO_YMD         Ctrl=txtTO_YMD        Param=text   </C>
		 <C>Col=MONTH          Ctrl=txtMONTH         Param=text   </C>
		 <C>Col=PROJECT_NM     Ctrl=txtPROJECT_NM    Param=text    </C>
		 <C>Col=PRO_FROM       Ctrl=txtPRO_FROM      Param=text    </C>
		 <C>Col=PRO_TO         Ctrl=txtPRO_TO        Param=text    </C>
		 <C>Col=WPLACE_NM      Ctrl=txtWPLACE_NM     Param=text    </C>
		 <C>Col=JOB_NM         Ctrl=txtJOB_NM        Param=text    </C>
		 <C>Col=POS_NM         Ctrl=txtPOS_NM        Param=text    </C>
		 <C>Col=WORK_NM        Ctrl=txtWORK_NM       Param=text    </C>
		 

    '>
</object>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

