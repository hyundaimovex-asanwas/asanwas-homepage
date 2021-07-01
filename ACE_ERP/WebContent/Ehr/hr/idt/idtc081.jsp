<!--
*****************************************************
* @source      : idtc020.jsp
* @description : 주간업무등록 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/11/30      이동훈        최초작성
*-------------+-----------+--------------------------+
*****************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
    String prmENO_NO    = request.getParameter("ENO_NO");
	String prmWEEK_NO   = request.getParameter("WEEK_NO");
%>

<html>
<head>
<title>주간업무등록</title>
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


        
    	var today = gcurdate;        
        var dsTemp = window.dialogArguments;
        var selectRow = 0;
        var count = 0;

        
        var ENO_NO    = "<%=prmENO_NO %>";     //사번
        var WEEK_NO   = "<%=prmWEEK_NO %>";    //사번


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	fnc_Clear();

        	
            dsT_WF_WORKFORM.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc080.cmd.IDTC080CMD"
																			                + "&S_MODE=SHR_DTL"
																			                + "&WEEK_NO="+WEEK_NO
            																				+ "&ENO_NO="+ENO_NO;

            dsT_WF_WORKFORM.Reset();			

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

            //이곳에 해당 코딩을 입력 하세요

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

            return true;
            
        }

        

        
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  	*
         *******************************************/
        function fnc_OnLoadProcess() {
   	
        	

            document.getElementById("txtWEEK_NO").value = WEEK_NO;  
            document.getElementById("txtENO_NO").value = ENO_NO;
            fnc_GetNm();
            

			document.getElementById("txtENO_NO").className = "input_ReadOnly";
		  	document.getElementById("txtENO_NO").readOnly = true;	  		
			document.getElementById("txtENO_NM").className = "input_ReadOnly";
		  	document.getElementById("txtENO_NM").readOnly = true;
		  	document.getElementById("ImgEnoNo").style.display = "none";
	

			cfStyleGrid_New(form1.grdT_WF_WORKFORM, 0, "true", "true");    	

			form1.grdT_WF_WORKFORM.RowHeight = 140;          // Grid Row Height Setting
			form1.grdT_WF_WORKFORM.TitleHeight = "30";

    		fnc_SearchList();

        }





        function fnc_SetGrdHeight() {
        	
        	var height = 0;

			height = (dsT_WF_WORKFORM.CountRow * 200) + 20;

			if(height < 420) { // 최소 높이 300px
				height = 420;
			}
			
			form1.grdT_WF_WORKFORM.style.height = height;

         
        }


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
            fnc_SearchList();

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM','txtENO_NO');
	            fnc_SearchList();
	    }                
        

            
	    
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                           |
    | 2. 이름은 ds_ + 주요 테이블명(T_WF_WORKFORM)          |
    | 3. 사용되는 Table List(T_WF_WORKFORM)             |
    +----------------------------------------------->
    <Object ID="dsT_WF_WORKFORM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <Object ID="dsT_DI_WEEK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                |
    | 2. 이름은 tr_ + 주요 테이블명(T_WF_WORKFORM)          |
    | 3. 사용되는 Table List(T_WF_WORKFORM)             |
    +----------------------------------------------->
    <Object ID ="trT_WF_WORKFORM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     	Value="toinb_dataid4">
            <Param Name=KeyValue    	Value="tr01(I:SAV=dsT_WF_WORKFORM)">
    </Object>



    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부                    *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_WF_WORKFORM Event="OnLoadCompleted(iCount)">

    </Script>
    


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
     <Script For=dsT_WF_WORKFORM Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);


    </Script>




    <!-----------------------------------------------------+
    | 그리드의 ROW를 더블클릭 시 처리  	   						   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_WF_WORKFORM event="OnDblClick(row,colid)">
	
		if(row < 1) {
			
			return;
			
		} else {

			
            if(row == '1' || row == '4'){

            	alert("입력하실 수 없습니다");
            	
    			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL1","Edit") = "None";
    			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL2","Edit") = "None";
    			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL3","Edit") = "None";    			
    			
      		}else{
      			
      			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL1","Edit") = "True";
      			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL2","Edit") = "True";
      			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL3","Edit") = "True";      			
      			
      		}
            

		}
		
	</script>



    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_WF_WORKFORM event="OnSuccess()">

    	alert("정상적으로 처리되었습니다.");
        fnc_SearchList();

        
    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_WF_WORKFORM event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_EVL_APPROVAL event="OnSuccess()">

    	fnc_OnLoadProcess();

    </script>





<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- form 시작 -->
<form name="form1">

	
<!-- power Search테이블 시작 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" class="blueTable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>

                    <td class="padding2423">

                        <input type="hidden"  id=txtWEEK_NO name="txtWEEK_NO" size="2"  readonly class="input_ReadOnly" />
                    </td>                         
                    <td align="right" class="searchState" width="70">사원번호&nbsp;</td>
                    <td class="padding2423">
						<input type="text" id="txtENO_NO" name="txtENO_NO" size="7"  maxlength="7"  class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" /><input type="text" style="display:none" />
						<input type="text" id="txtENO_NM" name="txtENO_NM" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" /><input type="text" style="display:none" />
						<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"style="cursor:hand;">
                    	<input type="hidden" id="hidEMPL_DPT_CD">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- power Search테이블 끝 -->		
		
<br>	
	
<!-- 내용 조회 그리드 테이블 시작-->

<table>
    <tr align="center">
        <td>
        	<comment id="__NSID__">
				<object	id="grdT_WF_WORKFORM" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:600px" border="0">
						<param name="DataID"				value="dsT_WF_WORKFORM">
               			<param name="ViewHeader" 			value="true">
                        <param name="EdiTABLE"              value="true">	
						<param name="VIEWSUMMARY"			value=0>                            
               			<param name="HeadBoarder"  			value="true">
						<param name="Format"				value="
							<C> id='CET_NO'				width=90   	name='NO'			align=center 	suppress=1</C>
							<C> id='PLAN_EXE'			width=50    name='구분'			align=center 	Value={Decode(PLAN_EXE,'PLAN','계획','EXE','결과')} BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='WORK_DETAIL1'		width=220	name='수주영업'		align=left		wordwrap=word 		Multiline=true edit=true BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='WORK_DETAIL2'		width=220	name='실행/정산'		align=left		wordwrap=word 		Multiline=true edit=true BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='WORK_DETAIL3'		width=220	name='기타'			align=left		wordwrap=word 		Multiline=true edit=true BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='FEED_BACK'			width=180	name='의견'			align=left		wordwrap=word 		Multiline=true edit=none BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='STAT'				width=40	name='상태'			align=left		show = false 		BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>							
					">
				</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>

<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>



