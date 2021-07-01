<!--
*****************************************************
* @source       : gunf040.jsp
* @description : 팀별 근무 현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/01/15      이동훈        최초 작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>팀별 근무 현황</title>
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


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {



			//검색조건
			var pis_yyyy = document.form1.txtPIS_YYYY.value.replaceStr("-","");	//기준일
			
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;	//소속				

			dsT_DI_OVERTIMEWORK.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf040.cmd.GUNF040CMD&S_MODE=SHR&PIS_YYYY="+pis_yyyy+"&DPT_CD="+dpt_cd;
			
			//prompt(this,dsT_DI_OVERTIMEWORK.dataid );
			
			dsT_DI_OVERTIMEWORK.reset();
			

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

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
            if (dsT_DI_OVERTIMEWORK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_OVERTIMEWORK.GridToExcel("기간별 근무 현황", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

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
        function fnc_SearchItemCheck(year) {

			//이곳에 해당 코딩을 입력 하세요

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

			cfStyleGrid_New(form1.grdT_DI_OVERTIMEWORK,15,"false","true");      // Grid Style 적용

			document.getElementById("txtPIS_YYYY").value = gcurdate.substring(0,4);	

			fnc_SearchInfo();
			
			//document.getElementById("txtDPT_CD_SHR").value = dsVI_T_PERSON.NameValue(1,"DPT_CD");			
			//document.getElementById("txtDPT_NM_SHR").value = dsVI_T_PERSON.NameValue(1,"DPT_NM");

			
			
			if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070019" || gusrid == "2070020"){ 
				
				    fnc_ChangeStateElement(true, "ImageDPT");
			    	fnc_ChangeStateElement(true, "txtDPT_CD_SHR");
			    	fnc_ChangeStateElement(true, "txtDPT_NM_SHR");				


		    }else{
	
		            fnc_ChangeStateElement(false, "ImageDPT");
		            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
		            fnc_ChangeStateElement(false, "txtDPT_NM_SHR");		    	
		    	
  
			}
			
			
			fnc_SearchList();
			
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


		
	    function fnc_GetNm() {
               fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
               //fnc_SearchList();
        }

        function fnc_Getcd() {
               fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
               //fnc_SearchList();
        }

        
        
        
 		/********************************************
         * 로그인한 사원에 해당하는 사원정보 조회   *
         ********************************************/
        function fnc_SearchInfo(){
 			
            var ENO_NO_SHR = gusrid;

			dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf040.cmd.GUNF040CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO_SHR;
			dsVI_T_PERSON.reset();
			
        }
        
        
        

        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_OVERTIMEWORK                 |
    | 3. Table List : T_DI_OVERTIMEWORK             |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_OVERTIMEWORK)|
    | 3. 사용되는 Table List(T_DI_OVERTIMEWORK)	        |
    +--------------------------------------------------->
    <Object ID ="trT_DI_OVERTIMEWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut     value=2000000>
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_OVERTIMEWORK Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_OVERTIMEWORK.focus();
        }

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_OVERTIMEWORK Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_OVERTIMEWORK event="OnDblClick(row,colid)">

	    curRowPosition = dsT_DI_OVERTIMEWORK.RowPosition;
	    
	    
	    var mm = colid.substring(09,11);
	    
	    
	    
		if(row < 1) {
			
			return;
			
		} else {
	
	        var url = "../../hr/gun/gunf041.jsp?ENO_NO="+dsT_DI_OVERTIMEWORK.NameString(row, "ENO_NO") + "&YYYY="+document.getElementById("txtPIS_YYYY").value + "&MONTH="+mm;
	               
	        //alert(url);
	        
	   		cfWinOpen(url,"근무형태",1100,600);
	  
		}
		
	</script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_OVERTIMEWORK Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_OVERTIMEWORK event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_OVERTIMEWORK event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- 캘린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
   	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="50"></col>
                                <col width="100"></col>
                                <col width="50"></col>                                  
                                <col width="*"></col>
                            </colgroup>
                            <tr>

								<td class="searchState" align="right">년도&nbsp;</td>
								<td class="padding2423" align="left">
									<input type="text" id="txtPIS_YYYY" size="4" maxlength="4" >
								</td>

					            <td align="right" class="blueBold">소 속&nbsp;</td>
								<td class="padding2423">
									<input name=txtDPT_CD_SHR size="6"  maxlength="6" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
									<input id=txtDPT_NM_SHR size="10">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImageDPT','','../../images/button/btn_HelpOver.gif',1)">
									<img src="../../images/button/btn_HelpOn.gif" name="ImageDPT" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
								</td>

                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom" class="searchState" width="66%" height="20"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERTIMEWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:520px;">
							<param name="DataID"				value="dsT_DI_OVERTIMEWORK">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=25	name=''			align=center			value={String(Currow)}		</C>
								

								<C> id='HEAD_NM'		width=80	name='본부'		align=center			suppress=1</C>								
								<C> id='DPT_NM'			width=80	name='소속'		align=left				suppress=2</C>
								<C> id='JOB_NM'			width=70	name='직위'		align=center			</C>
								<C> id='ENO_NO'			width=50	name='사번'		align=center			</C>
								<C> id='ENO_NM'			width=60	name='성명'		align=center			</C>


								 
								
								<C> id='WRK_TIME_01'	width=50	name='1월'		align=center			BgColor={IF(WRK_TIME_01 >= 200,'#FF1111',IF(WRK_TIME_01 >= 190,'#FF7E7E',IF(WRK_TIME_01 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_02'	width=50	name='2월'		align=center			BgColor={IF(WRK_TIME_02 >= 200,'#FF1111',IF(WRK_TIME_02 >= 190,'#FF7E7E',IF(WRK_TIME_02 >= 180,'#FFC6C6','FFFFFF')))}</C>								
								<C> id='WRK_TIME_03'	width=50	name='3월'		align=center			BgColor={IF(WRK_TIME_03 >= 200,'#FF1111',IF(WRK_TIME_03 >= 190,'#FF7E7E',IF(WRK_TIME_03 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_04'	width=50	name='4월'		align=center			BgColor={IF(WRK_TIME_04 >= 200,'#FF1111',IF(WRK_TIME_04 >= 190,'#FF7E7E',IF(WRK_TIME_04 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_05'	width=50	name='5월'		align=center			BgColor={IF(WRK_TIME_05 >= 200,'#FF1111',IF(WRK_TIME_05 >= 190,'#FF7E7E',IF(WRK_TIME_05 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_06'	width=50	name='6월'		align=center			BgColor={IF(WRK_TIME_06 >= 200,'#FF1111',IF(WRK_TIME_06 >= 190,'#FF7E7E',IF(WRK_TIME_06 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_07'	width=50	name='7월'		align=center			BgColor={IF(WRK_TIME_07 >= 200,'#FF1111',IF(WRK_TIME_07 >= 190,'#FF7E7E',IF(WRK_TIME_07 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_08'	width=50	name='8월'		align=center			BgColor={IF(WRK_TIME_08 >= 200,'#FF1111',IF(WRK_TIME_08 >= 190,'#FF7E7E',IF(WRK_TIME_08 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_09'	width=50	name='9월'		align=center			BgColor={IF(WRK_TIME_09 >= 200,'#FF1111',IF(WRK_TIME_09 >= 190,'#FF7E7E',IF(WRK_TIME_09 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_10'	width=50	name='10월'		align=center			BgColor={IF(WRK_TIME_10 >= 200,'#FF1111',IF(WRK_TIME_10 >= 190,'#FF7E7E',IF(WRK_TIME_10 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_11'	width=50	name='11월'		align=center			BgColor={IF(WRK_TIME_11 >= 200,'#FF1111',IF(WRK_TIME_11 >= 190,'#FF7E7E',IF(WRK_TIME_11 >= 180,'#FFC6C6','FFFFFF')))}</C>
								<C> id='WRK_TIME_12'	width=50	name='12월'		align=center			BgColor={IF(WRK_TIME_12 >= 200,'#FF1111',IF(WRK_TIME_12 >= 190,'#FF7E7E',IF(WRK_TIME_12 >= 180,'#FFC6C6','FFFFFF')))}</C>								
								
							">
							
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<BR>
<font size=3 color=blue face = "돋움" bold=10></font>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

