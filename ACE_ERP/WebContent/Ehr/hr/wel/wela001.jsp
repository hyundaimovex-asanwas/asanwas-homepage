	<!--*************************************************************************
	* @source      : wela001.jsp												*
	* @description : 복리후생안내		                                        *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2014/07/01            이동훈         	        최초작성					*	
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>복리후생안내</title>
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
    *	자바스크립트 함수 선언부분  														 *
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
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">복리후생안내</td>
					<td align="right" class="navigator">HOME/복리후생/<font color="#000000">복리후생안내</font></td>
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
                                <td width="6"><img src="../../images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">경공조금 지급 기준</td>
                                <td width="6"><img src="../../images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">학자금 지급기준</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">복지카드 제도안내</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft04"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(3)" style="cursor:hand" id="TabBtn04">블룸비스타 숙박권</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight04"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

</table>

<hr width="800" size="5" align="left" color="#97C821">

<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabAIDA001_01" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<table>
 <tr>
   <td>
  		<img src="../../images/common/11.jpg" width="720" height="1512">
  </td>
 </tr>
</table>

</div>

<!-- 탭2 조건 입력 테이블 시작 -->
<div class=page id="tabAIDA001_02" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<table>
 <tr>
   <td>
  		<img src="../../images/common/22.jpg" width="720" height="794">
  </td>
 </tr>
</table>

</div>


<!-- 탭3 조건 입력 테이블 시작 -->
<div class=page id="tabAIDA001_03" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<table>
 <tr>
   <td>
  		<img src="../../images/common/33.jpg" width="720" height="1512">
  </td>
 </tr>
</table>

</div>



<!-- 탭4 조건 입력 테이블 시작 -->
<div class=page id="tabAIDA001_04" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<table>
 <tr>
   <td>
  		<img src="../../images/common/44.jpg" width="720" height="869">
  </td>
 </tr>
</table>

</div>


</BODY>
</HTML>
