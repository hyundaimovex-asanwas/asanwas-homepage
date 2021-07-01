<!--
***********************************************************************
* @source      : sagb091.jsp
* @description : 결재세부사항 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>결재세부사항(sagb091)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<script language="javascript">

		var btnList = 'FFFFFFFT';
        var param = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        
            trT_CP_NIGHTDUTY.KeyValue = "shr(O:dsT_DI_APPROVAL=dsT_DI_APPROVAL, O:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY)";
            trT_CP_NIGHTDUTY.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb091.cmd.SAGB091CMD"
                                        + "&S_MODE=SHR"
                                        + "&PIS_YM="    +param.gun_ymd
                                        + "&DPT_CD="    +param.gun_dpt
                                        + "&SEQ_NO="    +param.seq_no
                                        + "&GRP_NO="    +param.grp_no
                                        + "&SAGB="      +param.sagb;
            trT_CP_NIGHTDUTY.post();

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
            fnc_HiddenElement("imgApproval");
            fnc_HiddenElement("imgRejection");
        
            

			cfStyleGrid(form1.grdT_CP_NIGHTDUTY,0,"false","false");      // Grid Style 적용

            //해당년월에 따라 그리드 컬럼명이 바뀐다.            
            fnc_ChangeGrid();

            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
		
			fnc_HotKey_Process(btnList, event.keyCode);
			
		}




        /**
         * 그리드 변경 처리
         */
        function fnc_ChangeGrid() {
        
            //입력데이터는 전달 데이터이므로 전달을 표시해야 함
            var PIS_YM_SHR= param.gun_ymd;
            var preDate   = new Date(PIS_YM_SHR.substring(0,4), PIS_YM_SHR.substring(5,7)-2, "01");
            var prePIS_YY = preDate.getFullYear();
            var prePIS_MM = lpad((preDate.getMonth()+1),2,"0");
            var lastDay   = fnc_covNumber(fnc_Lastday(prePIS_YY, prePIS_MM));

            grdFormat = "<FC> id={currow}       width=30    name='NO'           align=center                               </FC>" 
                      + "<FC> id='DPT_NM'       width=80    name='소속'           align=left      Edit=none   leftMargin='10'</FC>" 
                      + "<FC> id='JOB_NM'       width=50    name='직위'           align=left      Edit=none   leftMargin='10'</FC>" 
                      + "<FC> id='ENO_NO'       width=60    name='사번'           align=center    Edit=none                  </FC>" 
                      + "<FC> id='ENO_NM'       width=60    name='성명'           align=center    Edit=none                  </FC>" 
                      + "<C> id='PIS_YM'        width=70    name='해당년월'     align=center    Edit=none                  </C>"  
                      + "<C> id='DUTY_CNT'      width=70    name='당직일수'     align=right     Edit=none                  </C>"  
                      + "<C> id='DUTY_AMT'      width=70    name='당직수당'     align=right     Edit=none                  </C>"  
                      + "<C> id='REMARK'        width=100   name='비고'           align=left      Edit=none                  </C>"  
                      + "<G> name='"+prePIS_YY+"년 "+prePIS_MM+"월 신청일' HeadBgColor='#F7DCBB'";
                      
            for(var i=1; i<=lastDay; i++) 
                grdFormat+= "    <C> id='AT"+i+"_CD'    width=20    name='"+i+"'    align=center    Edit=none   bgcolor={Decode(AT"+i+"_CD,'Y','#F2AC47','#FEEFEF')}     </C>" 

            grdFormat+= "</G>";
                                            
            form1.grdT_CP_NIGHTDUTY.Format = grdFormat;

            //첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_CP_NIGHTDUTY,15,"true","false");      // Grid Style 적용

        }



        /**
         * 처리 버튼
         */
        function fnc_Append(app_yn) {
            
            if (dsT_DI_APPROVAL.CountRow < 1) {
                alert("처리할 자료가 없습니다!");
                document.getElementById("resultMessage").innerText = "* 처리할 자료가 없습니다!";
                return;
            }
            
            //결재정보 변경
            if(param.gunc == "020") {
            
                var text = "[소속:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PDPT_NM")+", "
                         + "해당년월:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "GUN_YMD")+", "
                         + "상신자:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PENO_NM")+"] "
                         + "의 자료를 "+(app_yn == "Y" ? "결재" : "부결")+" 하시겠습니까?";
                if (!confirm(text)) return;
            
            
                dsT_DI_APPROVAL.NameString(1, "APP_TAG") = app_yn;
            } else {
            
                var text = "[소속:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PDPT_NM")+", "
                         + "해당년월:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "GUN_YMD")+"] "
                         + "의 자료를 "+(app_yn == "Y" ? "결재" : "부결")+" 하시겠습니까?";
                if (!confirm(text)) return;
                
                
                for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++)
                    dsT_DI_APPROVAL.NameString(i, "APP_TAG") = app_yn;
            }
            
            
            trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb090.cmd.SAGB090CMD&S_MODE=SAV";
            trT_DI_APPROVAL.post();
        }
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_NIGHTDUTY)		   |
    | 3. 사용되는 Table List(T_CP_NIGHTDUTY) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CP_NIGHTDUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
    
    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_NIGHTDUTY)		   |
    | 3. 사용되는 Table List(T_CP_NIGHTDUTY)			       |
    +------------------------------------------------------>
	<Object ID="trT_CP_NIGHTDUTY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
    
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_APPROVAL)		   |
    | 3. 사용되는 Table List(T_DI_APPROVAL)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

  	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if(iCount > 0) {
            var today   = fnc_covNumber(getToday());
    
            //CHECK_DATE!!!
            
            //결재기간
            var appFrom = fnc_covNumber(param.gun_ymd+"11");
            var appTo   = fnc_covNumber(param.gun_ymd+"15");
            
            var app_yn  = dsT_DI_APPROVAL.NameString(1, "PAPP_YN");
            
            
            //오늘이 결재기간이면
            /*
            test test test
            if(appFrom <= today
                    && today <= appTo) {
            */
                //상신일때
                if(app_yn == "R") {
                    fnc_ShowElement("imgApproval");
                    fnc_ShowElement("imgRejection");
                }
            /*
            test test test
            }
            */
        }
        
    </Script>


	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    
	<Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("처리가 완료 되었습니다.");
        window.close();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--**************************************************************************************
*                                       												 *
*	BODY START																			 *
*                                       												 *
***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">결재세부사항</td>
					<td align="right" class="navigator">HOME/근태관리/휴일근무/휴일근무결재처리/<font color="#000000">결재세부사항</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
                <img src="/images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
                <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
			<!-- 조회 상태 테이블 시작 -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조회 상태 테이블 끝 -->
			</td>
		</tr>
    </table>
        
    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    	<tr>
    		<td style="padding-top:2px;" colspan="2">
    		<table border="0" cellspacing="0" cellpadding="0">
    			<tr align="center">
    				<td>
    				<comment id="__NSID__">
    				<object id="grdT_CP_NIGHTDUTY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
    					<param name="DataID" value="dsT_CP_NIGHTDUTY">
    					<param name="Editable" value="false">
    					<param name="DragDropEnable" value="true">
    					<param name="SortView" value="Left">
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