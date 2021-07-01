<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 차량정보등록
 * 프로그램ID   	: CU090I
 * J  S  P    		: cu090i
 * 서 블 릿        	: Cu090I
 * 작 성 자        	: 김영민
 * 작 성 일        	: 2006-06-14
 * 기능정의     	: 차량 등록 관리 (조회 등록 삭제 수정)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2010-02-09][박경국] [보험증서] 파일을 업로드할 수 있도록 수정
 * [2010-04-19][심동현] 파일 업로드를 42번 서버쪽으로 수정.. 킁.. (관리자의 관리때문에)
 * [2015-09-17][심동현] [차량 탑승] 메뉴 이용하면서 기본 운전자를 지정할 필요 없음
 *						근데 면허증은 어디서 받지? 차량 운행 승인 신청에 필요한 건 아니지만, 관리상 필요 → 사업자 등록
 * [2015-10-01][심동현] 통통 일괄 등록에 맞춰 항목 수정
 * [2015-11-11][심동현] 차량 등록번호 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%@ page import="sales.menu.cu.*"%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
                Developer Java Script
=============================================================================*/
%>      
    <script language="javascript">
    var v_job = "H";
    
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  페이지 로딩 
// Parameter    : 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit(); 
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description  : 선조회 
// Parameter    : 
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU017&s_item1=Y";
        ds2.Reset(); //차종1(*)
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU018&s_item1=Y";
        ds3.Reset(); //최초방문여부
        ds_tt_car_type.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU026&s_item1=Y";
        ds_tt_car_type.Reset();	//통통 차량 종류
        ds_tt_gubn.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU027&s_item1=Y";
        ds_tt_gubn.Reset();	//통통 운행 구분
        ds_tt_start.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU029&s_item1=Y";
        ds_tt_start.Reset();	//통통 운행경로 출발지
        
        ds_tt_site.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU030&s_item1=Y";
        ds_tt_site.Reset();	//통통 운행지역
        ds_tt_issue.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU031&s_item1=Y";
        ds_tt_issue.Reset();	//통통 운행증 교부처
        ds_tt_use.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU028&s_item1=Y";
        ds_tt_use.Reset();	//통통 운행용도
        
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    : 
%>
    function fnSelect() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sCarNo="  + getObjectFirst("v_car_no").value + ","
            + "sClientCd="  + getObjectFirst("v_client_cd").value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
            "JSP(O:DEFAULT=ds1)",
            param);
		tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  행추가 (그리드별)
// Parameter    : 
%>
    function fnAddRow() {
		ds1.AddRow();
		if(ds1.CountRow>0){	//조회한게 있으면 1행의 협력업체를 그대로 -20150917
			//alert(1);
			getObjectFirst("client_cd").value = ds1.NameValue(1, "CLIENT_CD");
			getObjectFirst("client_nm").value = ds1.NameValue(1, "CLIENT_NM");
			ds1.NameValue(ds1.RowPosition, "CLIENT_SID") = ds1.NameValue(1, "CLIENT_SID");
		}
        fnScreenDisplay();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  행삭제 (그리드별)
// Parameter    : 
%>
    function fnDeleteRow() {
        ds1.DeleteRow(ds1.RowPosition);
		fnScreenDisplay();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  적용 
// Parameter    : 
%>
    function fnApply() {
        if (ds1.IsUpdated) {
            for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.NameValue(i, "CAR_NO")==""){
                    alert("차량등록번호<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_no").focus();
                    return;
                }
                if(ds1.NameValue(i, "TT_CAR_TYPE")==""){
                    alert("차종 <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirs("tt_car_type").focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_NM")==""){
                    alert("차명 <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_nm").focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_FORM")==""){
                    alert("형식<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_form").focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_YEAR")==""){
                    alert("년식<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_year").Focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_CC")==""){
                    alert("배기량 <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_cc").Focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_PERSONS")==""){
                    alert("승차인원 <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_persons").Focus();
                    return;
                }


                if(ds1.NameValue(i, "NORTH_YN")==""){
                    alert("최초방문여부 <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("north_yn").focus();
                    return;
                }
            }
            
            //alert(rate_tt_car_kg.text);
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
                "JSP(I:REGIST=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
        }else
            alert("변경된 내역이 없습니다.");
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
    function fnCancel() {
        ds1.undoall();
        window. status="데이터 변경이 취소되었습니다.";
        fnScreenDisplay();
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  운전면허 팝업
%>
    function fnDrivePop() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnDriveInfoPop("<%=dirPath%>");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_drive_no.value = arrParam[0];
            
        } else {
            v_drive_no.value = "";
            
        }               
    }

    function fnDrivePop1() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnDriveInfoPop("<%=dirPath%>");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            drive_no.value = arrParam[0];
            cust_nm.value = arrParam[1];
        } else {
            drive_no.value = "";
            cust_nm.value = "";
        }               
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  협력업체팝업
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
        }               
    }
    
    function fnClientFind1() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "CLIENT_SID") = arrParam[0];
            client_nm.value = arrParam[1];
            client_cd.value = arrParam[2];
        } else {
            if(getObjectFirst("ds1").RowStatus(getObjectFirst("ds1").RowPosition)==1){
                getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "CLIENT_SID") = 0;
                client_nm.value = "";
                client_cd.value = "";
            }
        }               
    }
    function fnClientFindTT() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "TT_CLIENT_SID") = arrParam[0];
            tt_client_nm.value = arrParam[1];
            
        } else {
            if(getObjectFirst("ds1").RowStatus(getObjectFirst("ds1").RowPosition)==1){
                getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "TT_CLIENT_SID") = 0;
                ttclient_nm.value = "";
            }
        }               
    }    
    

    //화면 기능 제어
    function fnScreenDisplay(){
        if(ds1.CountRow>0){
            //if(ds1.RowStatus(ds1.RowPosition) == "1")	//행추가 시에만 수정 가능하게 였나보다.
                getObjectFirst("car_no").readOnly = false;
            //else 
                //getObjectFirst("car_no").readOnly = true;

            getObjectFirst("car_nm").readOnly       = false;
            getObjectFirst("rate_tt_car_kg").Enable      = "True";
            getObjectFirst("tt_car_type").Enable    = "True";            
            getObjectFirst("car_persons").Enable    = "True";
            getObjectFirst("tt_client_img").style.display = "inline";	// 차량 소속 찾기 버튼
            getObjectFirst("tt_bgndate").Enable     = "True";
            getObjectFirst("tt_enddate").Enable     = "True";
            getObjectFirst("tt_gubn").Enable       	= "True";
            getObjectFirst("tt_count").Enable       = "True";
            getObjectFirst("tt_start").Enable       = "True";
            getObjectFirst("tt_site").Enable       	= "True";
            getObjectFirst("tt_issue").Enable       = "True";
            getObjectFirst("tt_use").Enable     	= "True";
            getObjectFirst("tt_cf_bgndate").Enable     = "True";
            getObjectFirst("tt_cf_enddate").Enable     = "True";
            
            
            getObjectFirst("car_form").readOnly     = false;
            getObjectFirst("car_year").Enable       = "True";
            getObjectFirst("car_cc").Enable         = "True";
            //getObjectFirst("max_kg").Enable         = "True";
            getObjectFirst("car_dno").readOnly      = false;
            getObjectFirst("north_yn").Enable       = "True";
            //getObjectFirst("car_type_cd").Enable    = "True";
            getObjectFirst("client_img").style.display = "inline";	// 협력업체 찾기 버튼
        } else {

            getObjectFirst("car_no").readOnly       = true;
            getObjectFirst("car_nm").readOnly       = true;
            getObjectFirst("rate_tt_car_kg").Enable      = "False";
            getObjectFirst("tt_car_type").Enable    = "False";            
            getObjectFirst("car_persons").Enable    = "False";
            getObjectFirst("tt_client_img").style.display = "none";	// 차량 소속 찾기 버튼
            getObjectFirst("tt_bgndate").Enable     = "False";
            getObjectFirst("tt_enddate").Enable     = "False";
            getObjectFirst("tt_gubn").Enable       	= "False";
            getObjectFirst("tt_count").Enable       = "False";
            getObjectFirst("tt_start").Enable       = "False";
            getObjectFirst("tt_site").Enable       	= "False";
            getObjectFirst("tt_issue").Enable       = "False";
            getObjectFirst("tt_use").Enable     	= "False";
            getObjectFirst("tt_cf_bgndate").Enable     = "False";
            getObjectFirst("tt_cf_enddate").Enable     = "False";
            
            getObjectFirst("car_form").readOnly     = true;
            getObjectFirst("car_year").Enable       = "False";
            getObjectFirst("car_cc").Enable         = "False";
            //getObjectFirst("max_kg").Enable         = "False";
            getObjectFirst("car_dno").readOnly      = true;
            getObjectFirst("north_yn").Enable       = "False";
            //getObjectFirst("car_type_cd").Enable    = "False";
            getObjectFirst("client_img").style.display = "none";	// 협력업체 찾기 버튼
        }
    }


	//2010-04-19 차량등록증 업로드창 ------------------------------------------
	function fnUploadPop_carLcs(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/carLcs_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}

	//2010-04-19 보험증서 업로드창 ------------------------------------------
	function fnUploadPop_carIns(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/carIns_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}
	    
    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
        photo.src  = "<%=HDConstant.PIC_PATH_CAR%>"+ds1.NameValue(Row,"car_no")+".JPG";
        photo2.src = "<%=HDConstant.PIC_PATH_CAR%>"+ds1.NameValue(Row,"car_no")+"_보험.JPG";
        
	</script>


<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  작업성공
%>
        <script language="javascript" for="tr1" event="onsuccess()">
            msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
            
            fnScreenDisplay();
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  작업실패
%>
    <script language="javascript" for="tr1" event="OnSuccess()">
        msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
        

        var info_cnt = tr1.SrvErrCount("INFO");
        var info_msg = "";
        for(var i=0; i<info_cnt; i++){
            info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
        }
        if(info_msg!="") 
            alert("============= 안내 메시지=============\n\n" + info_msg);
        
        fnScreenDisplay();           
    </script>
    
    <script language="javascript" for="tr1" event="OnFail()">
        msgTxt.innerHTML="작업이 성공적으로 완료되지 못했습니다.";
        
        
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert("서버로부터 다음과 같은 오류 메시지를 출력했습니다.\n\n" + error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
        
        fnScreenDisplay();    
    </script>
<%
/*=============================================================================
            DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  조회중 
%>
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
            msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
             
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  조회완료
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  조회중 에러 
%>      
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            alert(" 조회중 에러가 발생했습니다 : " + ds1.ErrorMsg );
            msgTxt.innerHTML="조회가 완료 되었습니다.";
            
        </script>
        


<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_tt_car_type classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_gubn classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_start classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_site classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_issue classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

    
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


	<table width="1002px" border="0" cellspacing="0" cellpadding="0">
	  <tr>
        <td align="right" height="30px">
			<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;" onclick="fnSelect()">
			<img src="<%=dirPath%>/Sales/images/plus.gif"    style="cursor:pointer;" onClick="fnAddRow()" >
			<img src="<%=dirPath%>/Sales/images/minus.gif"   style="cursor:pointer;" onClick="fnDeleteRow()" >
			<img src="<%=dirPath%>/Sales/images/save.gif"    style="cursor:pointer;" onClick="fnApply()">
			<img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:pointer;" onClick="fnCancel()">
        </td>
      </tr>
    
	  <tr>
        <td>
            <table  width="1002px" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                <tr>
                    <td width="150px" height="30px" class="text">협력업체 코드 | 명</td>
                    <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
                        <input type="text" name="v_client_cd" size="6" maxlength="5" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();">
                        <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="협력업체코드를 조회합니다." align='absmiddle' onClick="fnClientFind()">
                        <input type="text" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                    </td>

                    <td width="100px" height="30px" class="text">차량등록번호</td>
                    <td align="left" bgcolor="#ffffff">&nbsp;
                        <input type=text name=v_car_no size="20" maxlength="20" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();">
                    </td>
                </tr>
            </table>
        </td>
	  </tr>

      <tr>
        <td height="10px"></td>
      </tr>

      <tr>
        <td width="100%" colspan="6">

			<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
              <tr>
				<td WIDTH="350px" valign="top">
		             <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width:350px; height:420px" border="1">
		                 <param name="DataID"            value="ds1">
		                 <param name="BorderStyle"       value="0">
		                 <param name="ColSizing"         value="true">
		                 <param name="editable"          value="false">
		                 <param name="SuppressOption"    value="1">
		                 <param name="SortView"  		 value="Right">
		                 <param name="ViewSummary"  	 value="1">
		                 <param name="Format"            value=" 
		                     <C>name='협력사명'    	 ID='CLIENT_NM' Width=80   align=Left	sort=true suppress='1' SumText='총' SumTextAlign='right' </C>
		                     <C>name='차량등록번호'	 ID='CAR_NO'     Width=90   align=Left	sort=true SumText=@count SumTextAlign='right' </C>
		                     <C>name='차종'  		 ID='TT_CAR_TYPE'	 Width=70 	 align=Left	sort=true SumText='대' SumTextAlign='left' editstyle=lookup data= 'ds_tt_car_type:DETAIL:DETAIL_NM' </C>
		                     <C>name='차명'      	 ID='CAR_NM'     Width=90    align=Left sort=true </C>
		                 ">
		             </object>
				</td>
                <td width="5px"></td>
                <td valign="top"><!-- 파일업로드부분... -->
					<table border="0" cellpadding="0" cellspacing="1" width="103px" bgcolor="#666666">
					  <tr bgcolor="#ffffff">
						<td align=center height='25px' class='boardt02' onclick="fnUploadPop_carLcs()" style="cursor:pointer">[차량등록증]</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center><img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="103px"></td>
					  </tr>
					  <tr bgcolor="#ffffff"><td height=26></td></tr>
					  <tr bgcolor="#ffffff">
						<td align=center height='25px' class='boardt02' onclick="fnUploadPop_carIns()" style="cursor:pointer">[보험증서]</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center ><img id="photo2" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="103px"></td>
					  </tr>
					  <tr bgcolor="#ffffff"><td height=25></td></tr>
					</table>
				</td>
				<td width="5px"></td>
                <td width="530px" valign="top" >
                
                
                    <table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666">
                        <tr bgcolor="#ffffff">
                            <td colspan=4 class='boardt02'>통통 - 운행승인신청</td>
                        </tr>

                        <tr bgcolor="#ffffff">
                            <td width='130px' height='30px'  class='boardt02'>차량등록번호(*)</td>
                            <td align='absmiddle'>&nbsp;<input type=text name="car_no" size=20 id="car_no" maxlength="28" class="textbox" OnKeyUp="cfLengthCheck(this, 28);" readOnly>
                            </td>
                            <td width='100px' height='30px'  class='boardt02'>차량 명칭(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;<input type=text name=car_nm id=car_nm size=18 maxlength=30 class="textbox" OnKeyUp="cfLengthCheck(this, 30);" readOnly>
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>적재중량(톤)(*)  </td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=rate_tt_car_kg classid=<%=HDConstant.CT_EMEDIT_CLSID%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:17px;">
									<param name=Text        value="">
	                                <param name=Alignment   value=2>
	                                <param name=VAlign	    value=1>
	                                <param name=Numeric  	value="true">
	                                	<param name=MaxLength	value=3>
										<param name=MaxDecimalPlace	value=1>
	                                <param name=Border      value="false">      
	                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
	                                <param name=ReadOnly    value="false">
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false">			                    </object>&nbsp;Ton
                            </td>
                            <td height='30px'  class='boardt02'>차량 종류(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=tt_car_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_car_type>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                        </tr>
                        <tr>
                            <td width='130px' height='30px'  class='boardt02'>승차정원(명)(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=car_persons classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='17px' width='40px' align='absmiddle' class='textbox'>            
                                    <param name=Enable      value=False>
                                    <param name=MaxLength	value=2>
                                    <param name=Alignment   value=2>
	                                <param name=VAlign	    value=2>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false">
                                </object>
                                &nbsp;명
                            </td>
                            <td height='30px'  class='boardt02'>차량소속(*)  </td>
                            <td bgcolor='#ffffff'>&nbsp;<input type="text" name="tt_client_nm" id="tt_client_nm" size="15" class="input01" readonly  onkeydown="if(event.keyCode==13) fnClientFindTT();">
								<img id="tt_client_img" src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="협력업체 정보를 조회합니다." align='absmiddle' onClick="fnClientFindTT()">
                                <input type=hidden name=tt_client_sid id=tt_client_sid size=16 maxlength=18  readOnly>
                            </td>

                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>운행기간(*)  </td>
                            <td colspan=3 bgcolor='#ffffff'>&nbsp;
		                        <object id=tt_bgndate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=90 align=center class="textbox">
		                           <param name=Text value="">
		                           <param name=Alignment value=1>
		                           <param name=Format value="0000-00-00">
		                           <param name=Cursor value="iBeam">
		                           <param name=Border value="0">
		                           <param name=InheritColor value="true">
		                           <param name=ReadOnly value="false">
		                           <param name=SelectAll value="true">
		                           <param name=SelectAllOnClick value="true">
		                           <param name=SelectAllOnClickAny value="false">
		                        </object>&nbsp;~&nbsp; 
		                        <object id=tt_enddate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=90 align=center class="textbox">
		                           <param name=Text value="">
		                           <param name=Alignment value=1>
		                           <param name=Format value="0000-00-00">
		                           <param name=Cursor value="iBeam">
		                           <param name=Border value="0">
		                           <param name=InheritColor value="true">
		                           <param name=ReadOnly value="false">
		                           <param name=SelectAll value="true">
		                           <param name=SelectAllOnClick value="true">
		                           <param name=SelectAllOnClickAny value="false">
		                        </object>
                            </td>
                        </tr>
    
                        <tr>
                            <td height='30px'  class='boardt02'>운행구분(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_gubn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_gubn>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                            <td height='30px'  class='boardt02'>운행횟수(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=tt_count classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='17px' width='40px' align='absmiddle' class='textbox'>            
                                    <param name=Enable      value=False>
                                    <param name=MaxLength	value=2>
                                    <param name=Alignment   value=2>
	                                <param name=VAlign	    value=2>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false">
                                </object>
                                &nbsp;회
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>운행경로-출발지(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_start classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_start>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                            <td height='30px'  class='boardt02'>운행지역(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_site classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_site>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>차량운행증교부처(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_issue classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_issue>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                            <td height='30px'  class='boardt02'>운행용도(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_use>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^120">
                                </object>
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>승인 기간</td>
                            <td colspan=3 bgcolor='#ffffff'>&nbsp;
		                        <object id=tt_cf_bgndate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=90 align=center class="textbox">
		                           <param name=Text value="">
		                           <param name=Alignment value=1>
		                           <param name=Format value="0000-00-00">
		                           <param name=Cursor value="iBeam">
		                           <param name=Border value="0">
		                           <param name=InheritColor value="true">
		                           <param name=ReadOnly value="false">
		                           <param name=SelectAll value="true">
		                           <param name=SelectAllOnClick value="true">
		                           <param name=SelectAllOnClickAny value="false">
		                        </object>&nbsp;~&nbsp; 
		                        <object id=tt_cf_enddate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=90 align=center class="textbox">
		                           <param name=Text value="">
		                           <param name=Alignment value=1>
		                           <param name=Format value="0000-00-00">
		                           <param name=Cursor value="iBeam">
		                           <param name=Border value="0">
		                           <param name=InheritColor value="true">
		                           <param name=ReadOnly value="false">
		                           <param name=SelectAll value="true">
		                           <param name=SelectAllOnClick value="true">
		                           <param name=SelectAllOnClickAny value="false">
		                        </object>
                            </td>
                        </tr>
                        
                        <tr bgcolor="#ffffff">
                            <td colspan=4 class='boardt02'>ERP - 차량등록정보</td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>형식(*)</td>
                            <td bgcolor='#ffffff'>
                            	&nbsp;<input type=text name=car_form id=car_form size=20 maxlength=18 class="textbox" OnKeyUp="cfLengthCheck(this, 18);" readOnly>
                            </td>
                            <td height='30px'  class='boardt02'>&nbsp;연식(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=car_year classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                                    <param name=Enable      value=False>
                                    <param name=MaxLength	value=4>
                                    <param name=Alignment   value=2>
	                                <param name=VAlign	    value=2>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false"> 
                                </object>
                                &nbsp;년식
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>최초방문여부(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=north_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds3>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^150">
                                </object>
                            </td>
                            <td height='30px' class='boardt02'>&nbsp;배기량(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=car_cc classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                                    <param name=Enable      value=False>
                                    <param name=MaxLength	value=5>
                                    <param name=Alignment   value=2>
	                                <param name=VAlign	    value=2>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false">                                    
                                </object>
                                &nbsp;CC
                            </td>
                        </tr>
                        <tr>
                            <td width='130px' height='30px'  class='boardt02'>차대번호</td>
                            <td colspan=3 bgcolor='#ffffff'>
                            	&nbsp;<input type=text name=car_dno id=car_dno size=20 maxlength=28 class="textbox" OnKeyUp="cfLengthCheck(this, 28);" readOnly>
                                * 건설기계는 필수
                            </td>
                        </tr>
                        <!-- <tr>
                            <td width='130px' height='30px'  class='boardt02'>운전면허번호</td>
                            <td align="left" bgcolor="#ffffff">&nbsp;&nbsp;
                                <input type="text" name="drive_no" id="drive_no" size="15" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                <img id="cust_img" src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="운전면허번호를 조회합니다." align='absmiddle' onClick="fnDrivePop1()">
                                <input type="text" name="cust_nm" id="cust_nm" size="10" class="input01" readonly>
                            </td>
                        </tr>-->
                        <tr>
                            <td width='130px' height='30px'  class='boardt02'>협력업체(*)</td>
                            <td colspan=3 align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="client_cd" id="client_cd" size="10" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);" onkeydown="if(event.keyCode==13) fnClientFind1();">
                                <img id="client_img" src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="협력업체 정보를 조회합니다." align='absmiddle' onClick="fnClientFind1()">
                                <input type="text" name="client_nm" id="client_nm" size="15" class="input01" readonly>
                            </td>
                        </tr>
                    </table>

				</td>
			  </tr>
        	</table>
		</td>
      </tr>
      <tr>
		<td>※ 코드, 차량등록번호 란에서 Enter키 누르면 바로 조회합니다.<br>
		※ (*)항목은 필수 입력 항목입니다. (문의 = 출입담당자 김주현 과장, 조경래사원)
     
		</td>
      </tr>
	</table>
<%
/*=============================================================================
            Bind 선언
=============================================================================*/
%>

     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
                <C>Col=CAR_NO         Ctrl=car_no        Param=value</C>
                <C>Col=TT_CAR_TYPE    Ctrl=tt_car_type   Param=value</C>
                <C>Col=CAR_NM         Ctrl=car_nm        Param=value</C>
                <C>Col=CAR_FORM       Ctrl=car_form      Param=value</C>
                <C>Col=CAR_YEAR       Ctrl=car_year      Param=Text</C>
                <C>Col=CAR_CC         Ctrl=car_cc        Param=Text</C>
                <C>Col=CAR_PERSONS    Ctrl=car_persons   Param=Text</C>
                <C>Col=CAR_DNO        Ctrl=car_dno       Param=value</C>
                <C>Col=NORTH_YN       Ctrl=north_yn      Param=BindColVal</C>
                <C>Col=CUST_NM        Ctrl=cust_nm       Param=value</C>
                <C>Col=CLIENT_CD      Ctrl=client_cd     Param=value</C>
                <C>Col=CLIENT_NM      Ctrl=client_nm     Param=value</C>

                
                <C>Col=TT_CAR_TYPE		Ctrl=tt_car_type	Param=BindColVal</C>
                <C>Col=RATE_TT_CAR_KG	Ctrl=rate_tt_car_kg		Param=Text</C>
				<C>Col=TT_GUBN			Ctrl=tt_gubn		Param=BindColVal</C>
                <C>Col=TT_BGNDATE		Ctrl=tt_bgndate		Param=Text</C>
                <C>Col=TT_ENDDATE		Ctrl=tt_enddate		Param=Text</C>
                <C>Col=TT_CLIENT_SID    Ctrl=tt_client_sid	Param=value</C>
                <C>Col=TT_CLIENT_NM		Ctrl=tt_client_nm	Param=value</C>
                <C>Col=TT_CAR_TYPE		Ctrl=tt_car_type	Param=BindColVal</C>
                <C>Col=TT_COUNT		    Ctrl=tt_count		Param=Text</C>
                <C>Col=TT_USE			Ctrl=tt_use			Param=BindColVal</C>
                <C>Col=TT_START			Ctrl=tt_start		Param=BindColVal</C>
                <C>Col=TT_SITE			Ctrl=tt_site		Param=BindColVal</C>
                <C>Col=TT_ISSUE			Ctrl=tt_issue		Param=BindColVal</C>
				<C>Col=TT_CF_BGNDATE	Ctrl=tt_cf_bgndate		Param=Text</C>
                <C>Col=TT_CF_ENDDATE	Ctrl=tt_cf_enddate		Param=Text</C>
             ">
      </object>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


