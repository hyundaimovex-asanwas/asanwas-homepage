<!--
    ************************************************************************************
    * @Source         : educ020.jsp                                                    *
    * @Description    : 년도별교육이력 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  김학수   | 최초작성                                               *
     *-------------+-----------+--------------------------------------------------------+
    * 2015/05/11  |  정영식   | 소스이전작업                                          *
    *************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>

    <head>
    <title>나의년도별교육이력</title>
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

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'T' + 'F' + 'T';

        var edu_cd      = '';
        var edu_nm      = '';
        var seq_no      = '';
        var eno_no      = '';
        var str_ymd     = '';
        var edu_autho   = '';

        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	var PIS_YY = document.getElementById("txtYEAR_SHR").value;//년도
        	
        	var ENO_NO = document.getElementById("txtENO_NO_SHR").value;//학습자 사번

            if(PIS_YY == ""){
        		alert("해당년도를 입력하세요.");
                document.getElementById("txtYEAR_SHR").focus();
                return false;
        	}

        	if(ENO_NO == ""){
        		alert("사번을 입력하세요.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

        	if(ENO_NO.trim() != "" && document.getElementById("txtENO_NM_SHR").value.trim() == ""){
        		alert("사번이 잘못되었습니다.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}


        	trT_CM_EDUCATION.KeyValue = "SVL(O:dsT_CM_EDUCATION_01=dsT_CM_EDUCATION_01, "+
        	                                "O:dsT_CM_EDUCATION_02=dsT_CM_EDUCATION_02, "+
        	                                "O:dsT_ED_LCTRHIST_03=dsT_ED_LCTRHIST_03, "+
        	                                "O:dsT_CM_EDUCATION_04=dsT_CM_EDUCATION_04)";
        	
			trT_CM_EDUCATION.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.c.educ012.cmd.EDUC012CMD&S_MODE=SHR&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO;
			
			trT_CM_EDUCATION.Post();

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

            //이곳에 해당 코딩을 입력 하세요

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

        	var PIS_YY = document.getElementById("txtYEAR_SHR").value;//년도
        	var ENO_NO = document.getElementById("txtENO_NO_SHR").value;//학습자 사번

            if(PIS_YY == ""){
        		alert("해당년도를 입력하세요.");
                document.getElementById("txtYEAR_SHR").focus();
                return false;
        	}

        	if(ENO_NO == ""){
        		alert("사번을 입력하세요.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

        	if(ENO_NO.trim() != "" && document.getElementById("txtENO_NM_SHR").value.trim() == ""){
        		alert("사번이 잘못되었습니다.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

            var url = "../../hr/edu/educ020_PV.jsp?eno_no="+ENO_NO+"&str_ymd="+PIS_YY;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CM_EDUCATION_01.CountRow < 1 && dsT_CM_EDUCATION_02.CountRow < 1 && dsT_ED_LCTRHIST_03.CountRow < 1 && dsT_CM_EDUCATION_04.CountRow < 1) {
            	
                alert("엑셀로 변환할 자료가 없습니다!");
                
                return;
                
            }


            if(dsT_CM_EDUCATION_01.CountRow > 0){
              // form1.grdT_CM_EDUCATION_01.GridToExcel("교육점수현황", "C:\\educ020.xls", 1+4);
                form1.grdT_CM_EDUCATION_01.SaveExcel("교육점수현황", true, true, false, "C:\\educ020.xls");
            }
            
            if(dsT_CM_EDUCATION_04.CountRow > 0){
                form1.grdT_CM_EDUCATION_04.GridToExcel("사외교육이력", "C:\\educ020.xls", 1+32);
            }
            if(dsT_ED_LCTRHIST_03.CountRow > 0){
                form1.grdT_ED_LCTRHIST_03.GridToExcel("사내강의이력",  "C:\\educ020.xls", 1+32);
            }
            if(dsT_CM_EDUCATION_02.CountRow > 0){
                form1.grdT_CM_EDUCATION_02.GridToExcel("사내교육이력", "C:\\educ020.xls", 1+32);
            }

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

            dsT_CM_EDUCATION_01.ClearData();
            dsT_CM_EDUCATION_02.ClearData();
            dsT_ED_LCTRHIST_03.ClearData();
            dsT_CM_EDUCATION_04.ClearData();

            document.getElementById("txtYEAR_SHR").focus();


        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

   			cfStyleGrid_New(form1.grdT_CM_EDUCATION_01,0,"false","false");      // Grid Style 적용
   			
			form1.grdT_CM_EDUCATION_01.HiddenHScroll  = true;
			form1.grdT_CM_EDUCATION_01.HiddenVScroll  = true;
			form1.grdT_CM_EDUCATION_01.DisableNoHScroll = false;
			form1.grdT_CM_EDUCATION_01.DisableNoVScroll = false;

			cfStyleGrid_New(form1.grdT_CM_EDUCATION_02,0,"false","false");      // Grid Style 적용
			cfStyleGrid_New(form1.grdT_ED_LCTRHIST_03,0,"false","false");      // Grid Style 적용
			cfStyleGrid_New(form1.grdT_CM_EDUCATION_04,0,"false","false");      // Grid Style 적용


            document.getElementById("txtYEAR_SHR").value = gcurdate.substr(0,4);
            document.getElementById("txtYEAR_SHR").focus();


            if (opener != null){
            	
                document.getElementById("txtENO_NO_SHR").value = opener.eno_no;
                document.getElementById("txtENO_NM_SHR").value = opener.eno_nm;
                
            } else {
            	
                document.getElementById("txtENO_NO_SHR").value = gusrid;
                document.getElementById("txtENO_NM_SHR").value = gusrnm;
                
            }
            
            //이전시 적용
        	if(gusrid != "6060002" && gusrid != "6070001"  && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2180001" ){ 
        		
        		 //관리자가 아니면 다른 사번으로 조회가 되지 않게 
        		 fnc_ChangeStateElement(false, "txtENO_NO_SHR");
                 fnc_ChangeStateElement(false, "txtENO_NM_SHR");
                 fnc_ChangeStateElement(false, "ImgEnoNoShr");
                 
                 //소속부서담당자이거나 일반사용자의 경우 자신의 부서에서만 검색이 가능
                 document.getElementById("hidEMPL_DPT_CD").value = gdeptcd;
                 
        	}
        		
        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

           if (opener != null){

                window.close();

            } else {

            	window.close();
                
            }

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EMPLIST)   |
    | 3. 사용되는 Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->

	<Object ID="dsT_CM_EDUCATION_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_LCTRHIST_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadCompleted(iCount)">
    </Script>




    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>



    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>
<!-- <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();"> -->



<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
			                	<col width="100"></col>
			                    <col width="120"></col>
			                    <col width="90"></col>
			                    <col width=""></col>
			                </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423">

                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtYEAR_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'next');" src="../../images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'prev');" src="../../images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>

                                </td>
                                <td align="right" class="searchState">사원번호&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>교육점수현황</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:86px;">
						<param name="DataID" value="dsT_CM_EDUCATION_01">
						<param name="Format"				value="
							<G> name='학점합계'  HeadBgColor='#dae0ee'
								<C> id='JOB_POINT'				width='120'		name='목표학점'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_TOT'		width='120'		name='취득학점'			align='right'	Edit=none</C>
							</G>
							
							<G> name='사내교육'  HeadBgColor='#dae0ee'
								<C> id='CPT_PNT_AA1'		width='120'		name='필수'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_AB1'		width='120'		name='선택'			align='right'	Edit=none</C>
							</G>
							
                            <C> id='CPT_PNT_LCT'            width='120'      name='사내강의'     align='right'   Edit=none</C>
                            
							<G> name='사외교육'  HeadBgColor='#dae0ee'
								<C> id='CPT_PNT_AA2'		width='120'		name='필수'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_AB2'		width='120'		name='선택'			align='right'	Edit=none</C>
							</G>
							
							<C> id='CPT_PNT_EXP'				width='120'		name='예외학점'		align='right'	Edit=none</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>사내교육이력</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:130px;">
						<param name="DataID" value="dsT_CM_EDUCATION_02">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='40'		name='NO'				align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='260'		name='과정명'			align='left'				Edit=none				</C>
								<C> id='SEQ_NO'		    width='100'		name='차수'				align='center'		Edit=none				</C>
								<C> id='LCT_TIME'		width='100'		name='교육시간'		align='right'			Edit=none				</C>
								<C> id='EDU_YMD'		width='160'		name='교육일정'		align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='100'		name='형태'				align='center'		Edit=none				</C>
								<C> id='EDU_TAG'		width='100'		name='결과'				align='center'		Edit=none				</C>
								<C> id='CPT_PNT'        width='100'		name='학점'				align='right'			Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>사내강의이력</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_LCTRHIST_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:130px;">
						<param name="DataID" value="dsT_ED_LCTRHIST_03">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='40'		name='NO'				align='center'		value={String(Currow)}	</C>
								<C> id='LCT_TAG'		width='260'		name='강의명'			align='left'				Edit=none				</C>
								<C> id='LCT_TIME'		width='70'		name='강의시간'		align='right'			Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='강의일정'		align='center'		Edit=none				</C>
								<C> id='EDU_NM'			width='150'		name='과정명'			align='left'				Edit=none				</C>
								<C> id='SEQ_NO'		    width='100'		name='차수'				align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='형태'				align='center'		Edit=none				</C>
								<C> id='CPT_PNT'		width='100'		name='학점'				align='right'			Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>사외교육이력</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:130px;">
						<param name="DataID" value="dsT_CM_EDUCATION_04">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='40'		name='NO'				align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='260'		name='과정명'			align='left'				Edit=none				</C>
								<C> id='LCT_TIME'		width='100'		name='교육시간'		align='right'			Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='교육일정'		align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='100'		name='형태'				align='center'		Edit=none				</C>
								<C> id='INT_NAM'		width='110'		name='교육기관'		align='left'				Edit=none				</C>
								<C> id='PLACE_NM'		width='100'		name='교육장소'		align='left'				Edit=none				</C>
								<C> id='CPT_PNT'        width='100'		name='학점'				align='right'			Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<!-- 내용 조회 그리드 데이블 끝-->

	</form>
	<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
