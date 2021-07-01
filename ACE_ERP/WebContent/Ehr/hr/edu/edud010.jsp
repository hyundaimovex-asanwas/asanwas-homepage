	<!--*************************************************************************
	* @source      : edud010.jsp												*
	* @description : 학습제도가이드		    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
	<title>학습제도가이드</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <link href="../../common/css/style.css" rel="stylesheet" type="text/css">
 <link href="../../common/css/general.css" rel="stylesheet" type="text/css">

 <script language=javascript src="../../common/common.js"></script>
 <script language=javascript src="../../common/result.js"></script>
 <script language=javascript src="../../common/input.js"></script>
 <script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

        //Layer ID
        var layerList = new Array(  "tabAIDA001_01"
                                   ,"tabAIDA001_02"
                                   ,"tabAIDA001_03"
                                   ,"tabAIDA001_04"
                                    );
        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {

            ActiveIndex = idx+1;
			fnc_ShowHiddenLayer(layerList, layerList[idx]);
            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=4; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft0"+i).src = "../../images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "../../images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "../../images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "../../images/common/tab25Right.gif";

            //fnc_TabOnClick(ActiveIndex);

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	
        	TabEvent(0);

        }        
        
        
    </script>
</head>



	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<!--  <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onLoad="TabEvent(0)"> -->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<br>
<!-- 탭 사용 컴퍼넌트 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">

            <!-- 탭버튼데이블 시작 -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="150">
                        <!-- 탭오버 -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">교육학점이수제도</td>
                                <td width="6"><img src="../../images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">Cy-learn 선택교육</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="170" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">외부위탁교육</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="170" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft04"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(3)" style="cursor:hand" id="TabBtn04">어학교육</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight04"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

</table>

<hr width="1000" size="5" align="left" color="#97C821">

<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabAIDA001_01" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >


<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>■ 교육학점이수제도(*비상경영기간동안 시행 유보)</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>1. 운영개요</SPAN></P>

<DIV STYLE=''>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 대&nbsp; 상 : 4급이상 전 직원 (4급사원~부장)&nbsp;&nbsp;&nbsp;&nbsp; (단, 교육 수강기회는 전 직원 제공)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 교육과정 : 의무교육 / 선택교육 </SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 학점배점 : 각 과정당 10학점 (매년 1과정이상 수강), 승진시 가감점 반영</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 학점적용기간 : 직급 체류기간 (각 직급1년차 ~ 승진 전년도)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>※ 1년의 산정기간 : 전년 12월1일~당해년 11월30일</SPAN></P>


</DIV>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>2. 교육분류 및 학점인정</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="68" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>구 분</SPAN></P>
	</TD>
	<TD width="351" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>내 용</SPAN></P>
	</TD>
	<TD width="136" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>학점여부</SPAN></P>
	</TD>
	<TD width="121" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>승진 Point</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="2" width="68" height="93" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>의무교육</SPAN></P>
	</TD>
	<TD width="351" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>&nbsp;그룹가치교육</SPAN></P>
	</TD>
	<TD width="136" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>미반영</SPAN></P>
	</TD>
	<TD width="121" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>불참시 감점</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="351" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>&nbsp;계층역량교육</SPAN></P>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>&nbsp;(승진자 / 심화 리더십과정, 신입사원교육)</SPAN></P>
	</TD>
	<TD width="136" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>각10학점</SPAN></P>
	</TD>
	<TD width="121" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>불참시 감점</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="68" height="59" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>선택교육</SPAN></P>
	</TD>
	<TD width="351" height="59" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>&nbsp;직무역량교육</SPAN></P>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>&nbsp;(건설기술자보수/CS역량교육/외부위탁교육 등)</SPAN></P>
	</TD>
	<TD width="136" height="59" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>각10학점</SPAN></P>
	</TD>
	<TD width="121" height="59" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>추가취득시 가점</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="68" height="55" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>기타교육</SPAN></P>
	</TD>
	<TD width="351" height="55" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>&nbsp;사내전문가직무교육, 외부강사 초청특강, </SPAN></P>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"굴림";'>&nbsp;성희롱예방교육, 사내어학강좌 등</SPAN></P>
	</TD>
	<TD width="136" height="55" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>미반영</SPAN></P>
	</TD>
	<TD width="121" height="55" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>미반영</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>3. 직급별 최저이수학점</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD colspan="2" width="122" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>구 분</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>부장</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>부대</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>차장</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>과장</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>대리</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>4사</SPAN></P>
	</TD>
	<TD width="160" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>비고</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="122" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>승진년한</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>-</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>3년</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>4년</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>5년</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>4년</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>4년</SPAN></P>
	</TD>
	<TD width="160" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="122" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>최소이수학점</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>30학점</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>30학점</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>30학점</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>50학점</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>40학점</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>40학점</SPAN></P>
	</TD>
	<TD width="160" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>각 체류기간</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>매년 1과정 이수기준</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="9" width="673" height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="2" width="38" height="91" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>예)</SPAN></P>
	</TD>
	<TD width="84" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>의무교육</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>10학점</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>10학점</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>20학점</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>20학점</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>20학점</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>10학점</SPAN></P>
	</TD>
	<TD width="160" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>승진자/심화 리더십교육</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="84" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>선택교육</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>20학점</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>20학점</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>20학점</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>30학점</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>30학점</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>30학점</SPAN></P>
	</TD>
	<TD width="160" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>&nbsp;※ 직위 체류기간이 6개월 이상인 경우 1년으로 간주</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"한컴바탕";'><BR></SPAN></P>

</div>
<!-- 탭1 조건 입력 테이블 끝 -->
<div class=page id="tabAIDA001_02" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >


<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>■ Cy-learn 선택교육</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>1. 교육개요</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 교육과정 : 400여개의 다양한 교육 컨텐츠 (역량강화 컨텐츠, 어학강좌, OA 스킬업 강좌 등)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 교육대상 : 전 임직원 (희망자) </SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 교육진행 : 매월</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 지원내용 : 교육비 전액지원(단, 미수료시 익월급여에서 공제)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 수료기준 : 총점 60점 이상, 진도율 80% 이상, 수료평가 응시, 과제물 제출(세부기준은 과목별 링크참조)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>2. 교육강좌</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD colspan="2" width="163" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>교육 과정명</SPAN></P>
	</TD>
	<TD width="389" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>과정 안내</SPAN></P>
	</TD>
	<TD width="106" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>비 고</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="2" width="81" height="88" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>직무역량</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>강화과정</SPAN></P>
	</TD>
	<TD width="82" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>핵심역량</SPAN></P>
	</TD>
	<TD width="389" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>기획력, 창의력, 문제해결,리더십,프리젠테이션 스킬 등 &#160;</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>각 직급별 역량강화를 위한 컨텐츠</SPAN></P>
	</TD>
	<TD width="106" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>100여개 과정</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="82" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>전문역량</SPAN></P>
	</TD>
	<TD width="389" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>건설, 부동산, 마케팅, 영업, 서비스, 기획/인사, 재무,</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>회계 등 직무관련 역량강화를 위한 컨텐츠 </SPAN></P>
	</TD>
	<TD width="106" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>100여개 과정</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="163" height="39" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>어학강좌</SPAN></P>
	</TD>
	<TD width="389" height="39" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>영어, 일어, 중국어 등</SPAN></P>
	</TD>
	<TD width="106" height="39" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>150여개 과정</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="163" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>공통역량 강화과정</SPAN></P>
	</TD>
	<TD width="389" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>OA 스킬 향상을 위한 컨텐츠 (Excel,Word,PPT 등)</SPAN></P>
	</TD>
	<TD width="106" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>50여개 과정</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="4" width="658" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"굴림";'>※ 본 교육은 </SPAN><SPAN STYLE='font-family:"굴림";text-decoration:"underline";'>희망하는 임직원에 한해 실시되는 선택교육</SPAN><SPAN STYLE='font-family:"굴림";'>입니다.</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>3. 신청방법</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;□ 신청방법 : Cy-learn싸이트 접속 후 신청  <a href="http://group.cy-learn.co.kr/"target="_blank">http://group.cy-learn.co.kr </a></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>&nbsp;&nbsp;&nbsp;□ 신청기간 : 매월 1~23일</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"한컴바탕";'><BR></SPAN></P>
</div>

<div class=page id="tabAIDA001_03" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
 <P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>■ 외부위탁교육</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>1. 교육개요</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 교육과정 : 직무능력 향상을 위한 외부교육기관의 교육(직무역량교육, 건실기술자 보수교육 등)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 교육대상 : 전 임직원 (희망자)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 지원내용 : 교육비 전액지원(단, 미수료시 익월급여에서 공제)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>2. 교육내용 : 직무역량교육 등</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 사내전문가 직무교육 : 세무, 회계, 법무, 품질/안전관리, 영업, CS 등</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 건설기술자 보수교육 : 건설기술자 개개인의 업무능력 제고를 위한 교육</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>3. 교육 프로세스</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>인재지원부</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>신청부서</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="3" width="409" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>수강가능여부 검토</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>←</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>외부위탁교육 가능성 협의</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>↓</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>수강가능 승인통보</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>→</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>교육신청서</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>↓</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>신청서 접수/검토</SPAN></P>
	</TD>
	<TD width="44" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>←</SPAN></P>
	</TD>
	<TD width="182" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>신청서 결재/통보</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>↓</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>신청서 결재/승인 통보</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>→</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>교육비처리, 교육실시</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>↓</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>교육비 고용보험환급</SPAN></P>
	</TD>
	<TD width="44" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>←</SPAN></P>
	</TD>
	<TD width="182" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>결과보고, 환급서류 제출</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>↓</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>교육이력관리</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"굴림";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"한컴바탕";'><BR></SPAN></P>
</div>


<div class=page id="tabAIDA001_04" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>■ 어학교육</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 개요 : 임직원의 글로벌 역량강화를 위하여 사내 어학교육 과정을 지원(그룹 통합과정)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 교육대상 : 전 임직원(희망자)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 교육기간 : 3개월(14주), 연간 3개 차수 운영 </SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 모집과정 : 외국어(영어,중국어,일본어)회화 및 토익강좌 </SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 신청방법 : 교육 실시전 별도 수강신청기간 공지</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 지원내용 : 교육비 전액지원(단, 교제비는 개인부담)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"굴림";'>□ 수료기준 : 출석율 70% 이상(미수료시 교육비 익월급여 공제 및 수강제한)</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"한컴바탕";'><BR></SPAN></P></div>


</BODY>
</HTML>
