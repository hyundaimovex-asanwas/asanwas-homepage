	<!--*************************************************************************
	* @source      : aida001.jsp												*
	* @description : 복리후생안내		    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>복리후생안내(aida001.jsp)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

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

                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";

            //fnc_TabOnClick(ActiveIndex);

        }

    </script>
</head>



	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onLoad="TabEvent(0)">
	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">복리후생안내</td>
					<td align="right" class="navigator">HOME/복리후생/경공조금/<font color="#000000">복리후생안내</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->
<br>
<br>
<!-- 탭 사용 컴퍼넌트 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">

            <!-- 탭버튼데이블 시작 -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="180">
                        <!-- 탭오버 -->
                        <table width="180" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">경조금 지급 기준</td>
                                <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">공조금 지급기준</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">학자금 지급기준</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft04"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(3)" style="cursor:hand" id="TabBtn04">복지카드 제도안내</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight04"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

</table>

<hr width="800" size="5" align="left" color="#97C821">

<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabAIDA001_01" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:20.0pt;font-family:"새굴림";font-weight:"bold";text-decoration:"underline";line-height:160%;'>경조금 지급 기준</SPAN></P>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD rowspan="2" colspan="2" width="218" height="44" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>구 분</SPAN></P>
	</TD>
	<TD colspan="2" width="247" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>경조비</SPAN></P>
	</TD>
	<TD rowspan="2" width="53" height="44" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>휴가</SPAN></P>
	</TD>
	<TD rowspan="2" width="53" height="44" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>화환</SPAN></P>
	</TD>
	<TD rowspan="2" width="104" height="44" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>비고</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>지급기준</SPAN></P>
	</TD>
	<TD width="126" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>금 액</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="7" width="86" height="172" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>&nbsp;결혼 </SPAN></P>
	</TD>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>본인</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:double #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>7일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'>-</P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>자녀</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'>-</P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>형제자매</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="53" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2일</SPAN></P>
	</TD>
	<TD width="53" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="104" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>◁</SPAN><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>배우자 포함</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="86" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>&nbsp;출산 </SPAN></P>
	</TD>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>1년 이상 근속</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'>-</P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>100,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="4" width="86" height="99" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>회갑 / 칠순</SPAN></P>
	</TD>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>부모</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'>-</P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>배우자의 부모</SPAN></P>
	</TD>
	<TD colspan="2" width="247" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부모와 동일</SPAN></P>
	</TD>
	<TD width="53" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2일</SPAN></P>
	</TD>
	<TD width="53" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="104" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'>-</P>
	</TD>
</TR>
<TR>
	<TD rowspan="23" width="86" height="567" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>사망</SPAN></P>
	</TD>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>본인</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>2,000,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁용품지원 ○</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁인원지원 ○</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>배우자</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>7일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁용품지원 ○</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁인원지원 ○</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>700,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>부모</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>7일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁용품지원 ○</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁인원지원 ○</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>700,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>배우자의 부모</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>5일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁용품지원 ○</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁인원지원 ×</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>700,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>자녀</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>7일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁용품지원 ○</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁인원지원 ○</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>700,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>형제자매</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>700,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>4일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>-</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>배우자의 형제자매</SPAN></P>
	</TD>
	<TD colspan="2" width="247" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>형제자매와 동일</SPAN></P>
	</TD>
	<TD width="53" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>4일</SPAN></P>
	</TD>
	<TD width="53" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="104" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>-</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="132" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>조부모</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>상무보 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>4일</SPAN></P>
	</TD>
	<TD rowspan="3" width="53" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>●</SPAN></P>
	</TD>
	<TD rowspan="3" width="104" height="74" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁용품지원 ○</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>◁인원지원 ×</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부대 이상</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>차장 이하</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>외조부모</SPAN></P>
	</TD>
	<TD width="122" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="126" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;- </SPAN></P>
	</TD>
	<TD width="53" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2일</SPAN></P>
	</TD>
	<TD width="53" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="104" height="25" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"새굴림";line-height:160%;'>-</SPAN></P>
	</TD>
</TR>
</TABLE></P>

</div>
<!-- 탭1 조건 입력 테이블 끝 -->
<div class=page id="tabAIDA001_02" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >


<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:20.0pt;font-family:"새굴림";font-weight:"bold";text-decoration:"underline";line-height:160%;'>공조금 지급 기준</SPAN></P>
<P CLASS=HStyle0>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD rowspan="2" colspan="2" width="221" height="44" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>구 분</SPAN></P>
	</TD>
	<TD colspan="2" width="198" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>임원공조부조금</SPAN></P>
	</TD>
	<TD colspan="2" width="198" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>직원공조부조금</SPAN></P>
	</TD>
	<TD rowspan="2" width="64" height="44" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>비고</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>지급기준</SPAN></P>
	</TD>
	<TD width="99" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>금 액</SPAN></P>
	</TD>
	<TD width="99" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>지급기준</SPAN></P>
	</TD>
	<TD width="99" height="22" valign="middle" bgcolor="#c0c0c0" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:double #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"새굴림";font-weight:"bold";line-height:160%;'>금 액</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="4" width="90" height="127" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>&nbsp;결혼 </SPAN></P>
	</TD>
	<TD rowspan="3" width="132" height="95" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>본인</SPAN></P>
	</TD>
	<TD rowspan="3" width="99" height="95" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD rowspan="3" width="99" height="95" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:double #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>100,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="3" width="64" height="95" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:double #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2-5년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>5년 이상</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>자녀</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="90" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>&nbsp;출산 </SPAN></P>
	</TD>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>1년 이상 근속</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>100,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="3" width="90" height="95" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>회갑 / 칠순</SPAN></P>
	</TD>
	<TD rowspan="2" width="132" height="64" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>부모</SPAN></P>
	</TD>
	<TD rowspan="2" width="99" height="64" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD rowspan="2" width="99" height="64" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>100,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="2" width="64" height="64" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>2년 이상</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>배우자의 부모</SPAN></P>
	</TD>
	<TD colspan="2" width="198" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부모와 동일</SPAN></P>
	</TD>
	<TD colspan="2" width="198" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>부모와 동일</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="9" width="90" height="286" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>사망</SPAN></P>
	</TD>
	<TD rowspan="4" width="132" height="127" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>본인</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>5년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>5년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>700,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="4" width="64" height="127" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>10년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>3,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>10년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>15년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>5,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>15년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>2,500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>15년 이상</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>7,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>15년 이상</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>3,500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>배우자</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>부모</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>배우자의 부모</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>자녀</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>조부모</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="5" width="90" height="159" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>퇴직</SPAN></P>
	</TD>
	<TD rowspan="5" width="132" height="159" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>1-3년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>700,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>3-5년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>150,000&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="5" width="64" height="159" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>3-7년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,200,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>5-10년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>7-10년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>2,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>10-15년 미만</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>10년 이상</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>3,000,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>15-20년</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,000,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="198" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0>&nbsp;</P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>20년 이상</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>1,500,000&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="90" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>재해위로금</SPAN></P>
	</TD>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>본인</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>200,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>100,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0>&nbsp;</P>
	</TD>
</TR>
<TR>
	<TD width="90" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>상병</SPAN></P>
	</TD>
	<TD width="132" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";font-weight:"bold";'>본인</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>500,000&nbsp;</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"새굴림";'>-</SPAN></P>
	</TD>
	<TD width="99" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:8.0pt;text-align:right;'><SPAN STYLE='font-family:"새굴림";'>300,000&nbsp;</SPAN></P>
	</TD>
	<TD width="64" height="32" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.7pt;border-bottom:solid #000000 0.7pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0>&nbsp;</P>
	</TD>
</TR>
</TABLE></P>
</div>

<div class=page id="tabAIDA001_03" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
 <P CLASS=HStyle0 STYLE='line-height:130%;'><SPAN STYLE='font-size:15.0pt;font-family:"가는각진제목체";font-weight:"bold";color:#0000ff;line-height:130%;'>&nbsp;&nbsp;&nbsp;&nbsp;자 녀&nbsp; 학 자 금&nbsp; 지 원&nbsp; 안 내</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1) 대 상: 1년이상 근속한 정규직(별정직) 직원</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-family:"가는각진제목체";'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* 계약직 → 정규직 전환 직원: 전환일 기준 1년이상인 직원</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2) 지원금액(2자녀에 한하여 지급)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="78" height="28" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>구분</SPAN></P>
	</TD>
	<TD width="108" height="28" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>지원항목</SPAN></P>
	</TD>
	<TD width="77" height="28" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>지원자녀</SPAN></P>
	</TD>
	<TD width="148" height="28" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>한도액[분(반)기]</SPAN></P>
	</TD>
	<TD width="85" height="28" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>지급방법</SPAN></P>
	</TD>
	<TD width="74" height="28" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>비고</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="78" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>중학교</SPAN></P>
	</TD>
	<TD width="108" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>학교운영지원비</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>(실비)</SPAN></P>
	</TD>
	<TD width="77" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>2명</SPAN></P>
	</TD>
	<TD width="148" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>최대 75,000원 / 분기</SPAN></P>
	</TD>
	<TD rowspan="3" width="85" height="107" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>급여</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>지급시 포함</SPAN></P>
	</TD>
	<TD width="74" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="78" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>고등학교</SPAN></P>
	</TD>
	<TD width="108" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>학교운영지원비</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>수업료(실비)</SPAN></P>
	</TD>
	<TD width="77" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>2명</SPAN></P>
	</TD>
	<TD width="148" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>최대 500,000원 / 분기</SPAN></P>
	</TD>
	<TD width="74" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="78" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>대학교</SPAN></P>
	</TD>
	<TD width="108" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>등록금</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>(실비)</SPAN></P>
	</TD>
	<TD width="77" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>1명</SPAN></P>
	</TD>
	<TD width="148" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>최대 2,500,000원 / 학기</SPAN></P>
	</TD>
	<TD width="74" height="36" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>&nbsp;</SPAN></P>
	</TD>
</TR>
</TABLE><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp; </SPAN><SPAN STYLE='font-size:6.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;예시) 대학생 자녀 2명 → 대학생 자녀 1명만 지원(5백만원/年)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;대학생 자녀 1명 / (중)고등학교 자녀1명 → 대학생 자녀 1명만 지원(5백만원/年)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(중)고등학생 자녀2명 → 한도내 전액 지원</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3) 제출자료</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-. 학자금 신청서 / 납입 내역을 증빙할 수 있는 영수증 또는 자동이체통장사본(본인 및</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;배우자 명의) 및 사본 및 이체내역이 있는 페이지</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-size:6.0pt;font-family:"가는각진제목체";line-height:100%;'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;line-height:100%;'><SPAN STYLE='font-family:"가는각진제목체";font-weight:"bold";'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* 기숙사비, 교재비, 급식비 등은 지원 대상 아님</SPAN></P>
</div>

<div class=page id="tabAIDA001_04" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:16.0pt;font-family:"휴먼명조,한컴돋움";letter-spacing:-3.2pt;font-weight:"bold";text-decoration:"underline";line-height:100%;'>복지카드 사용 안내</SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:14.0pt;font-family:"휴먼명조,한컴돋움";font-weight:"bold";line-height:100%;'>1. 개 요</SPAN></P>

<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="50" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>구분</SPAN></P>
	</TD>
	<TD width="150" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>카드명</SPAN></P>
	</TD>
	<TD width="70" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>운영사</SPAN></P>
	</TD>
	<TD width="200" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>차감신청방식</SPAN></P>
	</TD>
	<TD width="200" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>환급일</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="50" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>내용</SPAN></P>
	</TD>
	<TD width="150" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>우리 Family Card<br>(개인카드)</SPAN></P>
	</TD>
	<TD width="70" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>Ezwel</SPAN></P>
	</TD>
	<TD width="200" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>선택차감 or 일괄차감[택일]</SPAN></P>
	</TD>
	<TD width="200" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>매월 末 마감후 익월 11일</SPAN></P>
	</TD>
</TR>
</TABLE><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp; </SPAN><SPAN STYLE='font-size:6.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.0pt;font-family:"휴먼명조,한컴돋움";font-weight:"bold";line-height:100%;'>2. Point 지급기준</SPAN></P>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="50" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>구분</SPAN></P>
	</TD>
	<TD width="100" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>부장(대)</SPAN></P>
	</TD>
	<TD width="100" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>차장</SPAN></P>
	</TD>
	<TD width="100" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>과장</SPAN></P>
	</TD>
	<TD width="100" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>대리</SPAN></P>
	</TD>
	<TD width="100" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>4사</SPAN></P>
	</TD>
	<TD width="100" height="30" valign="middle" bgcolor="#aeaeae" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>5사이하</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="50" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>금액</SPAN></P>
	</TD>
	<TD width="100" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>1,600,000</SPAN></P>
	</TD>
	<TD width="100" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>1,300,000</SPAN></P>
	</TD>
	<TD width="100" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>1,150,000</SPAN></P>
	</TD>
	<TD width="100" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>1,000,000</SPAN></P>
	</TD>
	<TD width="100" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>850,000</SPAN></P>
	</TD>
	<TD width="100" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:9.0pt;font-family:"가는각진제목체";line-height:160%;'>700,000</SPAN></P>
	</TD>
</TR>
</TABLE><SPAN STYLE='font-size:11.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp; </SPAN><SPAN STYLE='font-size:6.0pt;font-family:"가는각진제목체";line-height:100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.0pt;font-family:"휴먼명조,한컴돋움";font-weight:"bold";line-height:100%;'>3. 운영기준</SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>&nbsp;&#8226; 지급대상 : 전 임&#8231;직원 </SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>&nbsp;&#8226; 지급방법 : 年 2회 지급 </SPAN><SPAN STYLE='font-size:10.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>[상반기(1월), 하반기(7월)]</SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>&nbsp;&#8226; 신규 입사 직원 지급기준 : 일할 계산 적용 지급</SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>&nbsp;&#8226; 중도 퇴사 직원 지급기준 : 잔여 금액, 당해 년말까지 사용 가능</SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>&nbsp;&#8226; 복지시스템(Ezwel)이용방법 : http://hdasan.ezwel.com 접속후 Log-in [그룹웨어  LINK]</SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>&nbsp;&#8226; 선택차감방식 : 복지카드 사용후(오프라인) Ezwel 시스템에 접속하여 차감항목 직접 신청</SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>&nbsp;&#8226; 일괄차감방식 : 보유 복지카드 금액 우선 결제(별도 차감신청 절차 無)</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>&nbsp;&#8226; 미사용 잔여 Point : 차년도 이월</SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;font-family:"휴먼명조,한컴돋움";line-height:100%;'>※ 기타 복지카드 이용관련 문의 : 총무팀(☎3706,3924)]</SPAN></P>

</div>

</BODY>
</HTML>
