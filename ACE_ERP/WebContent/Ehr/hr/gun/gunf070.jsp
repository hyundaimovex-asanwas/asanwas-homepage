<!--
*****************************************************
* @source       : gunf070.jsp
* @description : 직원별 근무제 관리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/12/20      이동훈        최초 작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>직원별 근무제 관리</title>
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
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;	//소속				
			
			var eno_no = document.form1.txtENO_NO_SHR.value;	//사번


			dsT_DI_WORKSTYLE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf070.cmd.GUNF070CMD&S_MODE=SHR&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
			
			//prompt(this,dsT_DI_WORKSTYLE.dataid );
			
			dsT_DI_WORKSTYLE.reset();
			

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


			if(!fnc_SaveItemCheck()) return;	//유효성 체크

			trT_DI_WORKSTYLE.KeyValue = "tr01(I:dsT_DI_WORKSTYLE=dsT_DI_WORKSTYLE)";
			trT_DI_WORKSTYLE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf070.cmd.GUNF070CMD&S_MODE=SAV";
			
			//prompt(this, dsT_DI_WORKSTYLE.text);
			
			trT_DI_WORKSTYLE.post();
			

			fnc_SearchList();        	
        	
        	

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
            if (dsT_DI_WORKSTYLE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_WORKSTYLE.GridToExcel("직원별 근무제 현황", '', 225);

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
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			//이곳에 해당 코딩을 입력 하세요
            if (!dsT_DI_WORKSTYLE.IsUpdated ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

            return true;	
        	
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//cfStyleGrid_New(form1.grdT_DI_WORKSTYLE,15,"false","true");      // Grid Style 적용
			cfStyleGrid_New(form1.grdT_DI_WORKSTYLE,0,"true","true");
			
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

        

        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_WORKSTYLE                 |
    | 3. Table List : T_DI_WORKSTYLE             |
    +----------------------------------------------->
    <Object ID="dsT_DI_WORKSTYLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    
    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_WORKSTYLE)|
    | 3. 사용되는 Table List(T_DI_WORKSTYLE)	        |
    +--------------------------------------------------->
    <Object ID ="trT_DI_WORKSTYLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_WORKSTYLE.focus();
        }

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_WORKSTYLE event="OnDblClick(row,colid)">

	    curRowPosition = dsT_DI_WORKSTYLE.RowPosition;
	
		if(row < 1) {
			
			return;
			
		} else {
	
	        var url = "../../hr/gun/gunf071.jsp?ENO_NO="+dsT_DI_WORKSTYLE.NameString(row, "ENO_NO");
	               
	   		cfWinOpen(url,"근무형태",1100,600);
	  
		}
		
	</script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_WORKSTYLE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_WORKSTYLE event="OnFail()">
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>	        
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
                                <col width="200"></col>
                                <col width="80"></col>                             
                                <col width="*"></col>
                            </colgroup>
                            <tr>
					            <td align="right" class="blueBold">소 속&nbsp;</td>
								<td class="padding2423"><input name=txtDPT_CD_SHR size="6"  maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
									<input id=txtDPT_NM_SHR size="10">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image30" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
								</td>


                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="if(event.keyCode==13){fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9" onkeypress="if(event.keyCode==13){fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', '', '');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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
						<object	id="grdT_DI_WORKSTYLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:520px;">
							<param name="DataID"				value="dsT_DI_WORKSTYLE">
							<param name="EdiTABLE"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=30			name=''					Edit=None	align=center			value={String(Currow)}		</C>
								<C> id='HEAD_NM'		width=110			name='본부'				Edit=None	align=center			suppress=1 </C>								
								<C> id='DPT_NM'			width=120			name='소속'				Edit=None	align=left				suppress=2 </C>
								<C> id='TEAM_NM'		width=190			name='파트/현장'			Edit=None	align=left				</C>								
								<C> id='JOB_NM'			width=80			name='직위'				Edit=None	align=center			BgColor={Decode(JOB_OCC,'1','#FFFFFF','#F2FF92')} </C>
								<C> id='ENO_NO'			width=80			name='사번'				Edit=None	align=center			BgColor={Decode(JOB_OCC,'1','#FFFFFF','#F2FF92')} </C>
								<C> id='ENO_NM'			width=80			name='성명'				Edit=None	align=center			BgColor={Decode(JOB_OCC,'1','#FFFFFF','#F2FF92')} </C>
								<C> id='GBN_NM'			width=80			name='근무지'				Edit=None	align=center			BgColor={Decode(JOB_OCC,'1','#FFFFFF','#F2FF92')} </C>
								<C> id='JOB_OCC'		width=200			name='근무형태'			align=center			EditStyle=Combo Data='1:기본근무,3:탄력근무(고/도/인),5:탄력근무' BgColor={Decode(JOB_OCC,'1','#FFFFFF','#F2FF92')} </C>
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
<font size=3 color=blue face = "돋움" bold=10>* 성명을 DBclick 하시면 History 조회가 가능합니다.</font>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

