<!--
***********************************************************************
* @source      : vluo011.jsp
* @description : 목표설정 승인/부결PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/02/13      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>목표설정 승인</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/style_new.css" rel="stylesheet" type="text/css">	
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var year    = "2018";
        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO = document.getElementById("txtENO_NO").value;
        	var GOAL_SEQ = document.getElementById("txtGOAL_SEQ").value;
        	
            dsT_EVL_GOALLIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo010.cmd.VLUO010CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ="+GOAL_SEQ;
            dsT_EVL_GOALLIST.Reset();

            if(dsT_EVL_GOALLIST.NameValue(1,"APP_STATUS") == "Y"){
            	
            	alert("이미 승인처리되었습니다.");
            	fnc_display("n");
            	
            }else if(dsT_EVL_GOALLIST.NameValue(1,"APP_STATUS") == "S"){
            	
            	alert("아직 저장상태입니다.\n\n팀원이 상신을 해야 결재하실 수 있습니다.");
            	fnc_display("n");

            }           

            //fnc_SetGrdHeight();

          
        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {


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


        }
 

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {


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

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  			*
         *******************************************/
        function fnc_OnLoadProcess() {

			var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
			var GOAL_SEQ = "<%=request.getParameter("GOAL_SEQ") %>";
			
            document.getElementById("txtEVL_YYYY").value = year;
            document.getElementById("txtENO_NO").value = ENO_NO;
            document.getElementById("txtGOAL_SEQ").value = GOAL_SEQ;            
            fnc_GetNm();
            		
			cfStyleGrid_New(grdT_EVL_GOALLIST_01, 0, "false", "false");
			grdT_EVL_GOALLIST_01.RowHeight = 100;          // Grid Row Height Setting
			grdT_EVL_GOALLIST_01.TitleHeight = "40";
			
    		fnc_SearchList();

        }



        /*****************************************************
         * 결재 status Y:승인, N:부결                             *
         ****************************************************/

        function fnc_Approval(yn) {

 			var ENO_NO 	= document.getElementById("txtENO_NO").value;
 			var GOAL_SEQ 	= document.getElementById("txtGOAL_SEQ").value;
        	var kind = "";

        	if(yn == "Y") {
	        	kind = "승인";
			} else {
	        	kind = "부결";
			}
        	if (!confirm(kind+" 처리를 하시겠습니까?")) return;


			dsT_EVL_GOALLIST.UserStatus(1) = 1; //결재 갱신을 위한 설정		
				
			trT_EVL_APPROVAL.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST)";
	        trT_EVL_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo010.cmd.VLUO010CMD&S_MODE=UPT_02&EVL_YYYY="+year+"&ENO_NO="+ENO_NO+"&STATUS="+yn+"&GOAL_SEQ="+GOAL_SEQ;
	        trT_EVL_APPROVAL.post();

			alert(kind + "하였습니다.");

			// 결재 후 창 닫힘
			window.close();

        }
        
   
		// display
        function fnc_display(yn) {

        	if(yn == "n") {
	        	document.getElementById("btnApproval").style.display = "none";
				document.getElementById("btnReject").style.display = "none";

			} else {
				document.getElementById("btnApproval").style.display = "";
				document.getElementById("btnReject").style.display = "";

			}
     	
        }

        function fnc_SetGrdHeight() {
        	
        	var height = 0;

			height = (dsT_EVL_GOALLIST.CountRow * 100) + 20;
			
			if(height < 420) { // 최소 높이 400px
				height = 420;
			}
			
            grdT_EVL_GOALLIST_01.style.height = height;
            
        }

        function fnc_GetNm() {
        	
            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
            
            return true;

	    }
        
        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_GOALLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_GOALLIST Event="OnLoadCompleted(iCount)">


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
     <Script For=dsT_EVL_GOALLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-- 트랜젝션 성공. -->
    <script for=trT_EVL_GOALLIST event="OnSuccess()">

        fnc_SearchList();

    </script>


    <!--트랜젝션 실패 -->
    <script for=trT_EVL_GOALLIST event="OnFail()">

        cfErrorMsg(this);

    </script>




<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<div class="evl_container"><!-- evl_container 시작-->

<br>

	<div class="btn_group_right" ><!-- btn_group 시작-->
		<ul class="list">
			<li><a href="#"><img id="btnApproval" 	name="btnApproval" 	src="../../images/button/btn_ApprovalOn.gif" onmouseover="this.src='../../images/button/btn_ApprovalOver.gif'" 	onmouseout="this.src='../../images/button/btn_ApprovalOn.gif'" alt="승인" onclick="fnc_Approval('Y');" /></a></li>
			<li><a href="#"><img id="btnReject" 	name="btnReject" 	src="../../images/button/btn_RejectionOn.gif" onmouseover="this.src='../../images/button/btn_RejectionOver.gif'" onmouseout="this.src='../../images/button/btn_RejectionOn.gif'" alt="부결" onclick="fnc_Approval('S');" /></a></li>
		</ul>
	</div><!-- //btn_group 끝-->


	<div class="inquiry"><!-- inquiry 시작-->
		<form action="" method="post" >
			<fieldset>
				<legend>목표설정</legend>
					<p>해당년도 :
					<span>
						<input type="text" id=txtEVL_YYYY name="txtEVL_YYYY" size="4" readonly class="input_ReadOnly" />
					</span>
					&nbsp;&nbsp;성명 :
					<span>
						<input type="text" id="txtENO_NO" name="txtENO_NO" size="10" maxlength="10" class="input_ReadOnly" readonly /><input type="text" style="display:none" />
						<input type="text" id="txtENO_NM" name="txtENO_NM" size="10" maxlength="10" class="input_ReadOnly" readonly /><input type="text" style="display:none" />				
					</span>
					&nbsp;&nbsp;차수 :
					<span>
						<input type="text" id="txtGOAL_SEQ" name="txtGOAL_SEQ" size="5" maxlength="5" class="input_ReadOnly" readonly /><input type="text" style="display:none" />
					</span>					
					</p>
			</fieldset>
		</form>
	</div><!-- // inquiry 끝-->


		
	<!-- 내용 조회 그리드 테이블 시작
	<table  summary="목표설정" class="evl_table">
	<caption>목표설정</caption>
			<colgroup>
				<col width="50px" />
				<col width="150px" />
				<col width="500px" />
				<col width="200px" />
				<col width="90px" />	
				<col width="20px" />												
			</colgroup>
			<thead>
				<tr>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">NO</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">중점추진과제</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">세부목표 달성수준<BR>(평가기준/측정방법)</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">목표</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">가중치<BR>(100%)</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;"> </th>

				</tr>		
			</thead>
			<tbody>
	<tr>
	<td colspan="6">
	<div style="width:1000px; height:400px; overflow-y:auto;">
		<table style='font:11px "돋움",Dotum,"굴림",Gulim,Verdana,Arial,sans-serif; color:#555; color:#454e69; font-weight:normal;'>
		    <tr align="center">
		        <td>
		        	<comment id="__NSID__">
						<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:400px;">
							<param name="DataID"				value="dsT_EVL_GOALLIST">
		                	<param name=HiddenVScroll 			value="false">
		                	<param name=HiddenHScroll 			value="false">
	                		<param name=ViewHeader 				value="false">
							<param name="Format"				value="
								<C> id={currow}			width=48   	name='NO'			align=center </C>
								<C> id='CATEGORY'		width=150	name='중점추진과제'	align=center	wordwrap=word Multiline=true </C>
								<C> id='FORMULA'		width=500	name='세부목표'		align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET'		width=200	name='달성기한'		align=center	wordwrap=word Multiline=true </C>
								<C> id='WEIGHT'			width=100	name='가중치'			align=center	wordwrap=word Multiline=true </C>																														
							">
						</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
		        </td>	        
		    </tr>
		</table>
	</div>
	</td>
	</tr>
	</table>	
-->


<!-- 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr >
	        <td>
				<comment id="__NSID__">
					<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:535px;">
						<param name="DataID"					value="dsT_EVL_GOALLIST">
						<param name=HiddenHScroll 				value="false">
						<param name=HiddenVScroll 				value="false">
						<param name="Format"					value="
								<C> id={currow}			width=48   	name='NO'											align=center </C>
								<C> id='GOAL_SEQ'		width=150	name='GOAL_SEQ'										align=center	show=false </C>
								<C> id='CATEGORY'		width=150	name='중점추진과제'									align=center	wordwrap=word Multiline=true </C>
								<C> id='FORMULA'		width=400	name='세부목표 달성수준\\(평가기준/측정방법)'		align=left		wordwrap=word Multiline=true </C>
			                <G> name='목표' 			BgColor='#dae0ee'	
								<C> id='GOALSET_HALF'	width=100	name='상반기목표'									align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET_10'		width=100	name='10월목표'										align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET'		width=100	name='연간목표'										align=left		wordwrap=word Multiline=true </C>
							</G>	
								<C> id='WEIGHT'			width=80	name='가중치'										align=center	 Edit=none</C>		
						">
					</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
	        </td>
	    </tr>
	</table>
<!-- 그리드 테이블 끝-->




</div><!-- //evl_container 끝 -->


</body>
</html>

