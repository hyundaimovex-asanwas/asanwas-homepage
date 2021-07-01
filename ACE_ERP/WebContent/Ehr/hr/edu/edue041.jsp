<!--
***********************************************************************
* @source      : edue051.jsp
* @description : 교육신청 결재처리 - 결재세부사항 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/05/29 |  정영식   | 소스이전                                              
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
	<title>결재세부사항</title>
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

	<script language="javascript">


        var dsTemp = window.dialogArguments;
        
		var obj = new String();
		
		obj.app_cmt = "";
		
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			
        	dsT_DI_APPROVAL.ClearData();
        	
            //결재세부사항 조회
            trT_DI_APPROVAL.KeyValue = "SVC(O:SHR=dsT_ED_COURSELIST, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            
            trT_DI_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue041.cmd.EDUE041CMD&S_MODE=SHR&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
            
            trT_DI_APPROVAL.post();
            
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
        	var REQ_NO = dsT_ED_COURSELIST.NameValue(dsT_ED_COURSELIST.RowPosition,"REQ_NO");
        	var ENO_NO = dsT_ED_COURSELIST.NameValue(dsT_ED_COURSELIST.RowPosition,"ENO_NO");
			var row = 1;

        	dsT_DI_APPROVALPRT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue041.cmd.EDUE041CMD"
											        		+"&S_MODE=SHR_PRINT"
											        		+"&REQ_NO="+REQ_NO;
        	dsT_DI_APPROVALPRT.Reset();   			
			
        	dsT_DI_APPROVALPRT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue041.cmd.EDUE041CMD"
											        		+"&S_MODE=SHR_PRINT2"
											        		+"&REQ_NO="+REQ_NO;
        	dsT_DI_APPROVALPRT2.Reset();             
			
			
			
        	dsT_DI_APPROVALPRT3.setDataHeader("ENO_NM1:STRING,DPT_NM1:STRING,JOB_NM1:STRING,APP_STATUS1:STRING,ENO_NM2:STRING,DPT_NM2:STRING,JOB_NM2:STRING,APP_STATUS2:STRING,ENO_NM3:STRING,DPT_NM3:STRING,JOB_NM3:STRING,APP_STATUS3:STRING,ENO_NM4:STRING,DPT_NM4:STRING,JOB_NM4:STRING,APP_STATUS4:STRING,ENO_NM5:STRING,DPT_NM5:STRING,JOB_NM5:STRING,APP_STATUS5:STRING,ENO_NM6:STRING,DPT_NM6:STRING,JOB_NM6:STRING,APP_STATUS6:STRING,ENO_NM7:STRING,DPT_NM7:STRING,JOB_NM7:STRING,APP_STATUS7:STRING,DATE:STRING");
			
        	dsT_DI_APPROVALPRT3.Addrow();            
			
			for(i=1;i<=dsT_DI_APPROVALPRT.countrow;i++){
			
			var nm1 = "ENO_NM"+i;
			var nm2 = "DPT_NM"+i;
			var nm3 = "JOB_NM"+i;
			var nm4 = "APP_STATUS"+i;				
			
			dsT_DI_APPROVALPRT3.namevalue(1,nm1) = dsT_DI_APPROVALPRT.namevalue(i,"ENO_NM");
			dsT_DI_APPROVALPRT3.namevalue(1,nm2) = dsT_DI_APPROVALPRT.namevalue(i,"DPT_NM");				
			dsT_DI_APPROVALPRT3.namevalue(1,nm3) = dsT_DI_APPROVALPRT.namevalue(i,"JOB_NM");
			dsT_DI_APPROVALPRT3.namevalue(1,nm4) = dsT_DI_APPROVALPRT.namevalue(i,"APP_STATUS");						
			
			}            
			
			
			
			for(j=4;j-3<=dsT_DI_APPROVALPRT2.countrow;j++){
			
			var nm1 = "ENO_NM"+j;
			var nm2 = "DPT_NM"+j;
			var nm3 = "JOB_NM"+j;
			var nm4 = "APP_STATUS"+j;				
			
			dsT_DI_APPROVALPRT3.namevalue(1,nm1) = dsT_DI_APPROVALPRT2.namevalue(row,"ENO_NM");
			dsT_DI_APPROVALPRT3.namevalue(1,nm2) = dsT_DI_APPROVALPRT2.namevalue(row,"DPT_NM");				
			dsT_DI_APPROVALPRT3.namevalue(1,nm3) = dsT_DI_APPROVALPRT2.namevalue(row,"JOB_NM");
			dsT_DI_APPROVALPRT3.namevalue(1,nm4) = dsT_DI_APPROVALPRT2.namevalue(row,"APP_STATUS");						
			
			row++;
			
			}		            
			
			
			dsT_DI_APPROVALPRT3.namevalue(1,"DATE") = gcurdate;	
			
			//prompt(this, dsT_ED_BOOKREPORT3.text);
			
			ReportID.Preview();    

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

            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");     // Grid Style 적용
            
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

			// 결재자만 버튼이 활성화
            if(dsTemp.NameValue(1,"ENO_NO")==gusrid){
                fnc_ShowElement("btn_approval");
            }else{
                fnc_HiddenElement("btn_approval");
            }

            var nowDate = getToday().replace("-","").replace("-","");

            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*************************
         * 16. 그리드 변경 처리  *
         ************************/
		function fnc_ChangeGrid() {

		}

        /********************************************
         * 17. 승인, 기각 버튼 처리					*
         ********************************************/
		function fnc_Approval() {

            if (confirm("결재처리를 하시겠습니까?")) {

				dsT_ED_COURSELIST.UserStatus(1) = 1;
				
				dsT_ED_COURSELIST.NameValue(1,"CPT_TAG") = obj.app_cmt;
				
				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_ED_COURSELIST=dsT_ED_COURSELIST)";
				
				trT_DI_APPROVAL.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue041.cmd.EDUE041CMD&S_MODE=SAV&APP_YN=Y&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+obj.app_cmt+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
				
				trT_DI_APPROVAL.post();
				
            }
            
			document.getElementById("btn_approval").style.display = "none";
			
            fnc_SearchList();
            
            window.close();

		}
        
		function fnc_Reject() {

            if (confirm("부결처리를 하시겠습니까?")) {
            	
				if(obj.app_cmt == ""){
					
          			window.showModalDialog("../../hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
          			
          	    }

	            if(obj.app_cmt == ""){
	            	
	                alert("부결 또는 반송사유를 입력후 처리바랍니다.\n \n작업은 취소되었습니다.");
	                
	                return false;
            	}
	            
				dsT_ED_COURSELIST.UserStatus(1) = 1;
				
				dsT_ED_COURSELIST.NameValue(1,"CPT_TAG") = obj.app_cmt;
				
				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_ED_COURSELIST=dsT_ED_COURSELIST)";
				
				trT_DI_APPROVAL.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue041.cmd.EDUE041CMD&S_MODE=SAV&APP_YN=N&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+obj.app_cmt+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
				
				trT_DI_APPROVAL.post();
            }
            
			document.getElementById("btn_approval").style.display = "none";
			
            fnc_SearchList();
            
            window.close();

		}
		function fnc_ShowRemarkPop(){
			showPopupLayer("PopupLayer");
		}
//----------------------------------------------
function closePopupLayer(name){
 if(document.all[name].style.display==""){
  document.all[name].style.display="none"
 }
}
function showPopupLayer(name){
 if(document.all[name].style.display=="none"){
  document.all[name].style.display=""
 }
}

isIE=document.all;
isNN=!document.all&&document.getElementById;
isN4=document.layers;
isHot=false;

function ddInit(e){
  topDog=isIE ? "BODY" : "HTML";
  whichDog=isIE ? document.all.PopupLayer : document.getElementById("PopupLayer");
  hotDog=isIE ? event.srcElement : e.target;
  while (hotDog.id!="PopupLayer"&&hotDog.tagName!=topDog){
    hotDog=isIE ? hotDog.parentElement : hotDog.parentNode;
  }
  if (hotDog.id=="PopupLayer"){
    offsetx=isIE ? event.clientX : e.clientX;
    offsety=isIE ? event.clientY : e.clientY;
    nowX=parseInt(whichDog.style.left);
    nowY=parseInt(whichDog.style.top);
    ddEnabled=true;
    document.onmousemove=dd;
  }
}

function dd(e){
  if (!ddEnabled) return;
  whichDog.style.left=isIE ? nowX+event.clientX-offsetx : nowX+e.clientX-offsetx;
  whichDog.style.top=isIE ? nowY+event.clientY-offsety : nowY+e.clientY-offsety;
  return false;
}

		// Link
		function fnc_SiteTag(){
			var siteTag = document.getElementById("txtSITE_TAG").value;
			if(siteTag == ""){
				return;
			}
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
		}

document.onmousedown=ddInit;
document.onmouseup=Function("ddEnabled=false");


//----------------------------------------------
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet									|
    | 2. 이름은 ds_ + 주요 테이블명		   						|
    | 3. 사용되는 Table List              			 	   |
    |                    dsT_ED_COURSELIST 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_APPROVAL)			 	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


	<Object ID="dsT_DI_APPROVALPRT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
	<Object ID="dsT_DI_APPROVALPRT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
	<Object ID="dsT_DI_APPROVALPRT3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>		
    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_APPROVAL)	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 			   |
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
	<Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

            document.getElementById("txtORD_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "REQ_NO");
            document.getElementById("txtENO_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_NM");
            document.getElementById("txtDPT_CD").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_DPT_CD");
            document.getElementById("txtDPT_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_DPT_NM");
            document.getElementById("txtJOB_CD").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_JOB_CD");
            document.getElementById("txtJOB_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_JOB_NM");

            document.getElementById("txtEDU_CD").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_CD");
            document.getElementById("txtEDU_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_NM");
            document.getElementById("txtEDU_GBN_NM").innerText  = dsT_ED_COURSELIST.NameValue(1, "EDU_GBN_NM");
            document.getElementById("txtMNGER_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "MNGER_NM");
            document.getElementById("txtFIELD_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "FIELD_NM");
            document.getElementById("txtSHAPE_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "SHAPE_NM");
            document.getElementById("txtGOAL_TAG").innerText    = dsT_ED_COURSELIST.NameValue(1, "GOAL_TAG");
            document.getElementById("txtCONTENT_TXT").innerText = dsT_ED_COURSELIST.NameValue(1, "CONTENT_TXT");
            document.getElementById("txtEFFECT_TAG").innerText  = dsT_ED_COURSELIST.NameValue(1, "EFFECT_TAG");
            document.getElementById("txtOBJ_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "OBJ_TAG");
            document.getElementById("txtCPT_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "CPT_TAG");
            document.getElementById("txtINT_NAM").innerText     = dsT_ED_COURSELIST.NameValue(1, "INT_NAM");
            document.getElementById("txtFIX_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "FIX_NO");
            document.getElementById("txtDAY_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "DAY_NO");
            document.getElementById("txtTIME_NO").innerText     = dsT_ED_COURSELIST.NameValue(1, "TIME_NO");
            document.getElementById("txtCOST_AMT").innerText    = dsT_ED_COURSELIST.NameValue(1, "COST_AMT");
            document.getElementById("txtCOST_NM").innerText     = dsT_ED_COURSELIST.NameValue(1, "COST_NM");
            document.getElementById("txtINS_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "INS_NM");
            document.getElementById("txtRTN_AMT").innerText     = dsT_ED_COURSELIST.NameValue(1, "RTN_AMT");
            document.getElementById("txtPLACE_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "PLACE_NM");
            document.getElementById("txtCPT_PNT").innerText     = dsT_ED_COURSELIST.NameValue(1, "CPT_PNT");
            document.getElementById("txtSITE_TAG").innerText    = dsT_ED_COURSELIST.NameValue(1, "SITE_TAG");

            document.getElementById("txtENT_TERM").innerText    = dsT_ED_COURSELIST.NameValue(1, "ENT_TERM");
            document.getElementById("txtEDU_TERM").innerText    = dsT_ED_COURSELIST.NameValue(1, "EDU_TERM");

        }

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
	
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

		document.getElementById("btn_approval").style.display = "none";
		
        var eno_no = "";
		var app_yn = "";

                for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
                	
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");		//결재자
                    
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");		//결재여부

			            //해당 결재자 의견입력 준비.
					if(eno_no ==gusrid &&  app_yn == "" ){
						
						document.getElementById("btn_approval").style.display = "";
						
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "의견입력";
						
						break;
						
					}
                }

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){


		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		
		window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
		
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "의견입력" ){

		window.showModalDialog("../../hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		if(obj.app_cmt != undefined){
			document.getElementById("txtREMARK").innerText = obj.app_cmt;
		}

	}
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
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">교육신청 결재처리 - 결재세부사항</td>
					<td align="right" class="navigator">HOME/기초정보/통합결재/<font color="#000000">교육신청 결재처리 - 결재세부사항</font></td>
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
                <span id="btn_approval" style="display:none">

	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)">  <img src="../../images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Approval();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)">  <img src="../../images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reject();"></a>
                </span>
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"    ><img src="../../images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- 조건 입력 테이블 시작 -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="100"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="blueBold">품의번호</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="blueBold">소속</td>
								<td class="padding2423">
									<input type="hidden" id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="blueBold">직위</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="blueBold">상신자</td>
								<td class="padding2423">
									<input type="hidden" id="txtENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
        </td>
        <td width="30">&nbsp;</td>
        <td>
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:110px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
								<C> id='REQ_NO'		width=40	name='등록번호'	align=center	show=false</C>
								<C> id='ENO_NO'		width=100	name='사번'			align=center	show=false</C>
            					<C> id='SEQ_NO'		width=50	name='구분'			align=center	Value={IF (SEQ_NO > '90','승인', '결재')}</C>
								<C> id='ENO_NM'		width=70	name='결재자'		align=center	</C>
								<C> id='JOB_NM'		width=60	name='직위'			align=center	</C>
                                <C> id='DPT_NM'		width=100	name='부서'			align=left		</C>
								<C> id='APP_YN'		width=160	name='결재상태'	align=left		Value={DECODE(APP_YN,'Y','승인','N','부결','미결')&' '&APP_YMD} </C>
								<C> id='REMARK1'		width=87	name='의견'			align=center 	Color='Blue'	</C>
							">
							<param name="wmode" value="transparent" >
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<br>
<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">과정코드</td>
                    <td class="padding2423" >
                        <span id="txtEDU_CD" name="txtEDU_CD" ></span>
                    </td>
                    <td align="center" class="blueBold">과정명</td>
                    <td class="padding2423">
                        <span id="txtEDU_NM" name="txtEDU_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육구분</td>
                    <td class="padding2423" >
                        <span id="txtEDU_GBN_NM" name="txtEDU_GBN_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">교육주관</td>
                    <td class="padding2423" >
                        <span id="txtMNGER_NM" name="txtMNGER_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육분야</td>
                    <td class="padding2423" >
                        <span id="txtFIELD_NM" name="txtFIELD_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">교육형태</td>
                    <td class="padding2423" >
                        <span id="txtSHAPE_NM" name="txtSHAPE_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육목표</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtGOAL_TAG" name="txtGOAL_TAG"  ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">신청기간</td>
                    <td class="padding2423" >
                        <span id="txtENT_TERM" name="txtENT_TERM" ></span>
                    </td>
                    <td align="center" class="blueBold">교육기간</td>
                    <td class="padding2423" >
                        <span id="txtEDU_TERM" name="txtEDU_TERM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육내용</td>
                    <td class="padding2423" colspan="3" >
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="112" rows="10" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">기대효과</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtEFFECT_TAG" name="txtEFFECT_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육대상</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtOBJ_TAG" name="txtOBJ_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">수료기준</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtCPT_TAG" name="txtCPT_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육기관</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtINT_NAM" name="txtINT_NAM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육정원</td>
                    <td class="padding2423" >
                        <span id="txtFIX_NO" name="txtFIX_NO" ></span>&nbsp;명
                    </td>
                    <td align="center" class="blueBold">교육시간</td>
                    <td class="padding2423" >
                        <span id="txtTIME_NO" name="txtTIME_NO" ></span>&nbsp;시간
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육일수</td>
                    <td class="padding2423" >
                        <span id="txtDAY_NO" name="txtDAY_NO" ></span>&nbsp;일
                    </td>
                    <td align="center" class="blueBold">교육비용</td>
                    <td class="padding2423" >
                        <span id="txtCOST_AMT" name="txtCOST_AMT" ></span>&nbsp;원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">비용부담</td>
                    <td class="padding2423" >
                        <span id="txtCOST_NM" name="txtCOST_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">고용보험</td>
                    <td class="padding2423" >
                        <span id="txtINS_NM" name="txtINS_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">환급금액</td>
                    <td class="padding2423" >
                        <span id="txtRTN_AMT" name="txtRTN_AMT" ></span>&nbsp;원
                    </td>
                    <td align="center" class="blueBold">교육장소</td>
                    <td class="padding2423" >
                        <span id="txtPLACE_NM" name="txtPLACE_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">이수점수</td>
                    <td class="padding2423" >
                        <span id="txtCPT_PNT" name="txtCPT_PNT" ></span>&nbsp;점
                    </td>
                    <td align="center" class="blueBold">참고사이트</td>
                    <td class="padding2423" >
                      <!--  <span id="txtSITE_TAG" name="txtSITE_TAG" ></span> -->
                         http://<input id="txtSITE_TAG"  name="txtSITE_TAG" size="30" maxlength="300" >&nbsp;<input type="button" value="연결" size="6" align="right" onClick="fnc_SiteTag()">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->
	</form>
	<!-- form 끝 -->

</body>
<!-- new popup start -->
<div id="PopupLayer" style="position:absolute; left:200px; top:185px; z-index:10000; width:300px; height:180px; display:none ;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="3" bgcolor="dbdbdb">
  <tr>
    <td bgcolor="#FFFFFF" style="padding:1 1 1 1" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="45" bgcolor="#408080">&nbsp;&nbsp;
		<span style="font-weight: bold"><font style='color:#FFFFFF;font-size:15px;font-face:돋움'>부결사유입력</font></span>
		</td>
		<td width="50" bgcolor="#408080" align="center">
		<a href="#" onClick="closePopupLayer('PopupLayer');return false"><font color=#ffffff face=arial  style="text-decoration:none">닫기</font></a>
		</td>
      </tr>
      </table>
      <table width="100%" border="0" cellspacing="30" cellpadding="0">
        <tr>
          <td><textarea id="txtREMARK"  name="txtREMARK" cols="50" rows="5"></textarea></td>
        </tr>
      </table>
      <table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="d3e3dd" height="26">
        <tr height='26'>
          <form name="form" id="form">
            <td width="15"></td>
            <td align="center"><a href="#" onClick="fnc_Reject();return false"><font color=#000000 face=arial  style="text-decoration:none">확인</font></a>
            <td width="15"></td>
          </form>
        </tr>
      </table></td>
  </tr>
</table>
</div>
<!-- new popup end -->
</html>



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 교육신청서 ####
------------------------------------------------------------------------------>

<OBJECT id=ReportID  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="dsT_ED_COURSELIST">
	<param name="DetailDataID"	    				value="dsT_ED_COURSELIST">
	<PARAM NAME="PaperSize"							VALUE="A4">
	<PARAM NAME="LandScape"							VALUE="0">
  	<PARAM NAME="PrintSetupDlgFlag" 				VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="120">
	<PARAM NAME="Format" 								VALUE="
	
<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=133
	<R>id='교육신청내역.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132, DetailDataID='dsT_ED_COURSELIST'	
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=1828 ,face='Tahoma' ,size=10 ,penwidth=1
	<I>id='../../../Common/img/2015slg.jpg' ,left=450 ,top=140 ,right=778 ,bottom=257</I>
	<L> left=21 ,top=415 ,right=1942 ,bottom=415 </L>
	<L> left=21 ,top=331 ,right=1942 ,bottom=331 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='ENO_DPT_NM', left=381, top=434, right=997, bottom=492, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQ_NO', left=384, top=347, right=992, bottom=405, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=21 ,top=333 ,right=21 ,bottom=497 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='성명' ,left=1048 ,top=431 ,right=1304 ,bottom=489 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직 위' ,left=1048 ,top=349 ,right=1304 ,bottom=407 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_JOB_NM', left=1318, top=349, right=1934, bottom=407, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=1318, top=431, right=1934, bottom=489, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=21 ,top=497 ,right=1942 ,bottom=497 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1945 ,top=331 ,right=1945 ,bottom=495 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1310 ,top=333 ,right=1310 ,bottom=497 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=26 ,top=656 ,right=1947 ,bottom=656 </L>
	<L> left=24 ,top=566 ,right=1945 ,bottom=566 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=566 ,right=26 ,bottom=1807 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='과정코드' ,left=45 ,top=582 ,right=352 ,bottom=640 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1947 ,top=566 ,right=1947 ,bottom=1807 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=743 ,right=1947 ,bottom=743 </L>
	<T>id='교육주관' ,left=1061 ,top=675 ,right=1299 ,bottom=733 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='과정명' ,left=1056 ,top=587 ,right=1296 ,bottom=646 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육구분' ,left=48 ,top=677 ,right=347 ,bottom=736 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육분야' ,left=48 ,top=759 ,right=347 ,bottom=818 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육형태' ,left=1061 ,top=757 ,right=1299 ,bottom=815 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신청기간' ,left=45 ,top=841 ,right=344 ,bottom=900 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=831 ,right=1945 ,bottom=831 </L>
	<T>id='교육기간' ,left=1058 ,top=844 ,right=1296 ,bottom=902 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=918 ,right=1947 ,bottom=918 </L>
	<L> left=1310 ,top=566 ,right=1310 ,bottom=921 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=26 ,top=1013 ,right=1947 ,bottom=1013 </L>
	<T>id='교육목표' ,left=50 ,top=939 ,right=349 ,bottom=997 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=1222 ,right=1947 ,bottom=1222 </L>
	<T>id='교육내용' ,left=48 ,top=1080 ,right=347 ,bottom=1138 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기대효과' ,left=45 ,top=1238 ,right=344 ,bottom=1296 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=1307 ,right=1947 ,bottom=1307 </L>
	<L> left=26 ,top=1392 ,right=1947 ,bottom=1392 </L>
	<L> left=24 ,top=1476 ,right=1945 ,bottom=1476 </L>
	<L> left=24 ,top=1561 ,right=1945 ,bottom=1561 </L>
	<T>id='교육대상' ,left=48 ,top=1323 ,right=347 ,bottom=1381 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수료기준' ,left=50 ,top=1408 ,right=349 ,bottom=1466 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육기관' ,left=50 ,top=1490 ,right=349 ,bottom=1548 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육시간' ,left=48 ,top=1577 ,right=347 ,bottom=1635 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1037 ,top=566 ,right=1037 ,bottom=921 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='교육일수' ,left=50 ,top=1656 ,right=349 ,bottom=1715 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=1646 ,right=1945 ,bottom=1646 </L>
	<T>id='교육장소' ,left=48 ,top=1733 ,right=347 ,bottom=1791 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=360 ,top=564 ,right=360 ,bottom=1804 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=24 ,top=1725 ,right=1945 ,bottom=1725 </L>
	<L> left=26 ,top=1807 ,right=1947 ,bottom=1807 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='교육비용' ,left=1061 ,top=1577 ,right=1315 ,bottom=1635 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1331 ,top=1564 ,right=1331 ,bottom=1807 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1050 ,top=1564 ,right=1050 ,bottom=1807 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='교육신청서' ,left=807 ,top=138 ,right=1357 ,bottom=267 ,face='Tahoma' ,size=30 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1035 ,top=333 ,right=1035 ,bottom=497 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=360 ,top=333 ,right=360 ,bottom=497 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='소 속' ,left=69 ,top=429 ,right=325 ,bottom=487 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='품의번호' ,left=69 ,top=347 ,right=325 ,bottom=405 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EDU_CD', left=376, top=582, right=992, bottom=640, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EDU_NM', left=1320, top=587, right=1937, bottom=646, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MNGER_NM', left=1323, top=675, right=1939, bottom=733, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EDU_GBN_NM', left=373, top=675, right=990, bottom=733, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FIELD_NM', left=376, top=759, right=992, bottom=818, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHAPE_NM', left=1323, top=759, right=1939, bottom=818, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EDU_TERM', left=1320, top=847, right=1937, bottom=905, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENT_TERM', left=376, top=844, right=992, bottom=902, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GOAL_TAG', left=376, top=939, right=1939, bottom=997, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CONTENT_TXT', left=378, top=1029, right=1934, bottom=1207, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true ,CRFlag=true</C>
	<C>id='EFFECT_TAG', left=373, top=1238, right=1934, bottom=1296, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='OBJ_TAG', left=376, top=1323, right=1931, bottom=1381, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CPT_TAG', left=376, top=1405, right=1931, bottom=1463, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLACE_NM', left=376, top=1736, right=992, bottom=1794, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INT_NAM', left=378, top=1492, right=1931, bottom=1550, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DAY_NO', left=376, top=1659, right=574, bottom=1717, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TIME_NO', left=376, top=1577, right=572, bottom=1635, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='시간' ,left=579 ,top=1577 ,right=685 ,bottom=1635 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일' ,left=582 ,top=1659 ,right=688 ,bottom=1717 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COST_AMT', left=1341, top=1577, right=1635, bottom=1635, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='원' ,left=1640 ,top=1577 ,right=1746 ,bottom=1635 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RTN_AMT', left=1344, top=1656, right=1640, bottom=1715, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='원' ,left=1646 ,top=1656 ,right=1752 ,bottom=1715 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='INS_NM', left=1344, top=1736, right=1752, bottom=1794, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='환급금액' ,left=1066 ,top=1656 ,right=1312 ,bottom=1715 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=1061 ,top=1736 ,right=1315 ,bottom=1794 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>




	</R>
</A>






<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=133
	<R>id='현황.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='dsT_DI_APPROVALPRT3'
<B>id=Tail ,left=0,top=0 ,right=2000 ,bottom=868 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='* 품의 부서' ,left=32 ,top=32 ,right=524 ,bottom=116 ,align='left' ,face='Tahoma' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='* 확인 부서' ,left=1040 ,top=32 ,right=1532 ,bottom=116 ,align='left' ,face='Tahoma' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=929 ,top=127 ,right=26 ,bottom=127 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=926 ,top=206 ,right=24 ,bottom=206 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=280 ,right=929 ,bottom=280 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=360 ,right=929 ,bottom=360 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=437 ,right=929 ,bottom=437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=929 ,top=127 ,right=929 ,bottom=437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=161 ,top=127 ,right=161 ,bottom=434 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=333 ,top=130 ,right=333 ,bottom=437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=492 ,top=130 ,right=492 ,bottom=437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='결재자' ,left=32 ,top=138 ,right=159 ,bottom=201 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직 위' ,left=167 ,top=138 ,right=331 ,bottom=201 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부 서' ,left=336 ,top=138 ,right=489 ,bottom=201 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결 재 상 태' ,left=497 ,top=138 ,right=923 ,bottom=201 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1942 ,top=124 ,right=1040 ,bottom=124 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1040 ,top=204 ,right=1942 ,bottom=204 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1040 ,top=278 ,right=1942 ,bottom=278 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1040 ,top=434 ,right=1942 ,bottom=434 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1175 ,top=124 ,right=1175 ,bottom=431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1347 ,top=127 ,right=1347 ,bottom=434 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1505 ,top=127 ,right=1505 ,bottom=434 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='결재자' ,left=1045 ,top=135 ,right=1172 ,bottom=198 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직 위' ,left=1180 ,top=135 ,right=1344 ,bottom=198 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부 서' ,left=1349 ,top=135 ,right=1503 ,bottom=198 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결 재 상 태' ,left=1511 ,top=135 ,right=1937 ,bottom=198 ,face='Tahoma' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1040 ,top=124 ,right=1040 ,bottom=431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1942 ,top=124 ,right=1942 ,bottom=431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1040 ,top=357 ,right=1942 ,bottom=357 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='APP_STATUS1', left=497, top=212, right=923, bottom=275, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS2', left=497, top=288, right=923, bottom=352, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS3', left=497, top=368, right=923, bottom=431, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM1', left=339, top=212, right=487, bottom=275, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM2', left=339, top=288, right=487, bottom=352, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM3', left=339, top=368, right=487, bottom=431, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM1', left=167, top=212, right=325, bottom=275, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM2', left=167, top=288, right=325, bottom=352, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM3', left=169, top=368, right=328, bottom=431, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM1', left=32, top=212, right=156, bottom=275, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM2', left=32, top=288, right=156, bottom=352, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM3', left=32, top=368, right=156, bottom=431, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM4', left=1045, top=209, right=1169, bottom=273, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM4', left=1183, top=209, right=1341, bottom=273, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM4', left=1352, top=209, right=1500, bottom=273, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM5', left=1045, top=286, right=1169, bottom=349, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM5', left=1183, top=286, right=1341, bottom=349, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM5', left=1352, top=286, right=1500, bottom=349, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM6', left=1045, top=365, right=1169, bottom=429, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM6', left=1183, top=365, right=1341, bottom=429, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM6', left=1352, top=365, right=1500, bottom=429, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS4', left=1511, top=209, right=1937, bottom=273, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS5', left=1511, top=286, right=1937, bottom=349, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS6', left=1511, top=362, right=1937, bottom=426, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=26 ,top=127 ,right=26 ,bottom=439 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='상기와 같이 교육을 신청합니다.' ,left=233 ,top=593 ,right=1783 ,bottom=677 ,face='Tahoma' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/hd_ci_1.jpg' ,left=516 ,top=730 ,right=656 ,bottom=847</I>
	<C>id='DATE', left=746, top=683, right=1172, bottom=746, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='현 대 아 산 주 식 회 사' ,left=659 ,top=759 ,right=1643 ,bottom=844 ,align='left' ,face='Tahoma' ,size=25 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	</R>
</A>


">
</OBJECT>



