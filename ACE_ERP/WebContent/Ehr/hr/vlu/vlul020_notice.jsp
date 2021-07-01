<!--
***********************************************************************
* @source      : vluk050_notice.jsp
* @description : 평가기간 설정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/11/21      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>평가자안내문(vluk050_notice)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TTTTFFTT';

        var today = '<%=box.get("SESSION_TODAY")%>';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {



        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {


        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {



        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }



        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

        	window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {


        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_EV_RQSTYMD,15,"false","false");      // Grid Style 적용

			document.getElementById("txtEVA_YY_SHR").value = getToday().substring(0,7);

            fnc_DisableElementAll(elementList);
            
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto  onload="fnc_OnLoadProcess();">



<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평가자 안내문</td>
					<td align="right" class="navigator">HOME/인사평가/역량평가/<font color="#000000">평가자 안내문</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->



<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">안내문</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->
<br>
<font color="black" size="3"  face = "굴림"">■  인사평가는 회사의</font>
<font color="blue" size="3"  face = "굴림"">인사정책 방향을 설정하는 기준</font>
<font color="black" size="3"  face = "굴림"">이 됩니다.</font>
<br><font color="black" size="1"  face = "굴림"">  </font><br>
<font color="black" size="3"  face = "굴림"">또한 평가는 </font>
<font color="blue" size="3"  face = "굴림"">업적향상 및 능력 / 역량 향상을 위한 기초자료</font>
<font color="black" size="3"  face = "굴림"">가 되고, </font>
<br><font color="black" size="1"  face = "굴림"">  </font><br>
<font color="black" size="3"  face = "굴림"">직원들의  </font>
<font color="blue" size="3"  face = "굴림"">공정한 처우</font>
<font color="black" size="3"  face = "굴림"">를 위해 꼭 필요한 사안입니다. </font>
<br><font color="black" size="1"  face = "굴림"">  </font><br>
<font color="black" size="3"  face = "굴림"">평가자분의 </font>
<font color="red" size="3"  face = "굴림"">공정</font>
<font color="black" size="3"  face = "굴림"">하고</font>
<font color="red" size="3"  face = "굴림"">객관적인 평가</font>
<font color="black" size="3"  face = "굴림"">를 당부 드리며, </font>
<br><font color="black" size="1"  face = "굴림"">  </font><br>
<font color="black" size="3"  face = "굴림"">평가의 일반적인 오류를 알려드리오니 참고하시기 바랍니다.  </font>
<br>
<br>
<br><br>

<font color="black" size="4"face = "굴림"">■  평가자의  </font>
<font color="blue" size="4" face = "굴림"">일반적 오류</font>
<br><br>
<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" >
          <tr bgcolor="#FFF8EE" height="40" >
            <td width="200" align = "center" >
              <font color="#333333" face="굴림" size = 3><b>평가오류</b></font> 
            </td>
            <td width="500" bgcolor="#FFF8EE" align = "center">
              <font color="#333333" face="굴림" size = 3><b>내&nbsp;용</b></font> 
            </td>
            <td width="300" bgcolor="#FFF8EE" align = "center">
              <font color="#333333" face="굴림" size = 3><b>비&nbsp;고</b></font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="굴림" size = 2><b>현혹효과</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font color="#333333" face="굴림" size = 2>피평가자의 특히 뛰어난 점에 현혹되어 그 사람의 전체를 좋게 평가하는 경우</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="굴림" size = 2>학력, 출신대학, 외모 등</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="굴림" size = 2><b>관대화(가혹화)</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font color="#333333" face="굴림" size = 2>부하직원을 전반적으로 후하게 평가하거나 지나치게 낮게 평가하는 경우</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
               <font color="#333333" face="굴림" size = 2>평가에 대한 두려움, 피평가자 무시, 무능력</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="굴림" size = 2><b>중심(표준)화</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font color="#333333" face="굴림" size = 2>부하 대다수에게 중간 점수를 부여하는 경우</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="굴림" size = 2>평가에 대한 무관심, 평가에 대한 두려움</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="굴림" size = 2><b>논리적 오류</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font color="#333333" face="굴림" size = 2>서로 관련된 것과 같은 고과항목에 같거나 비슷한 평가를 부여하는 경우</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="굴림" size = 2>역량이 높으면 업적도 높게</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font face="굴림" size = 2><b>대비오차</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font face="굴림" size = 2>자신의 능력, 특성과는 반대로 부하를 평가하는 경우</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font face="굴림" size = 2>자신의 장/단점 기준</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font face="굴림" size = 2><b>목적성 평가</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font face="굴림" size = 2>특정한 목적을 가지고 의도적으로 평가하는 경우</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font face="굴림" size = 2>승진, 자기사람 만들기</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font face="굴림" size = 2><b>근접사실 중시</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font face="굴림" size = 2>평가시점에 인접한 사실을 중시하여 평가하는 경우</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font face="굴림" size = 2>최근 업적만 중시</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font face="굴림" size = 2><b>개인적 편견</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font face="굴림" size = 2>속인적, 감정적 요소 등 개인적인 편견으로 평가하는 경우</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font face="굴림" size = 2>동향, 동문, 성별, 평소감정 등</font>
            </td>            
          </tr>              
    
          
    </table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>
