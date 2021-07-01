<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>공사>현장관리>작업관리>작업 등록 → 작업일보 전자결재용 
 * J  S  P		 : si110i_h1.jsp
 * 서 블 릿		 : Si110I_h1
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2014-06-13
 * [ 수정일자 ][수정자] 내용
 * [2014-06-13][심동현] 신규 개발 : 기안문서 : 작업일보. 어떤 스타일로 갈 것인가.
 *						전자결재용 스타일시트 만들자
 * [2014-06-30][심동현] 전자결재 관련 액션을 모두 CONFIG. AP200I로 
 *						결재선에 사용자가 있어야 버튼을 보여주는 걸로....
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%> 

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
	String v_dwr_sid = request.getParameter("v_dwr_sid");	//작업일보 index
	String v_status	 = request.getParameter("v_status");	//페이지 작업 구분자 : 상태 010작성중, 011현장결재진행중, 012현장결재완료
	String v_ap_m_sid = request.getParameter("v_ap_m_sid");	//결재마스터 sid : 반려시에는 스냅샷을 찍는게 아니므로 일보 인덱스가 겹친다.
%>
<!-- //body_s.jsp -->
<%@ page import="sales.org.common.request.SmartRequest"%>
<%
	SmartRequest sr = new SmartRequest(request);	
	//로그인 체크 : 2013-12-04 심동현 수정 ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//페이지 이동시 세션ID 체크(이건 웬만한 곳은 하지 말끄나?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//페이지 이동시 세션변수("로긴") 체크
	String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크

%>

<!-- HTML 시작-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<meta http-equiv="Cache-control" content="no-cache"/>
		<meta http-equiv="Cache-control" content="no-store"/>
		<meta http-equiv="pragma" content="no-cache" />
		<meta name="viewport" content="width=1080" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
	
	<title>전자결재 : 작업일보　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
	</title>
	<%
	/*=============================================================================
				Style Sheet, Common Java Script Link
	=============================================================================*/
	%>		
		<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">
		<link href="<%=dirPath%>/Common/css30/ap_layout.css" rel="stylesheet" type="text/css">	<%//전자결재용용... %>	
		
		<%// 전자결재용 소스 %>
		<script language="javascript" src="<%=dirPath%>/Config/common/js/ap_gauce.js"></script>
    

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	var v_status ="<%=v_status%>";
	<% //페이지로딩 %>
	function fnOnLoad(){
		cfStyleGrid(getObjectFirst("gr_wd"), "approval");
		cfStyleGrid(getObjectFirst("gr_detail1"), "approval");
		cfStyleGrid(getObjectFirst("gr_detail2"), "approval");
		cfStyleGrid(getObjectFirst("gr_detail3"), "approval");
		cfStyleGrid(getObjectFirst("gr_apline"), "apline");
		
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    gr_wd.RowHeight = "80";	//그리드 로우하이트 변경

        ds_gc_wdcode.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI004&s_item1=Y";
        ds_gc_wdcode.Reset();	//작업 구분(일지용) SI004
        ds_gc_bskind.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT001&s_item1=Y";
        ds_gc_bskind.Reset();	//입찰 공종 CT001
        ds_gc_bpjob.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI006&s_item1=Y";
        ds_gc_bpjob.Reset();	//투입인원 직종 SI006
		ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
		ds_gc_aptype.Reset();	// 결재유형 AP005 - 공통모듈쪽 공통코드 읽어오기
		ds_gc_apsts_d.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
		ds_gc_apsts_d.Reset();	// 결재상태_D AP003 - 공통모듈쪽 공통코드 읽어오기

        
        fnSelect();
		
        if(v_status=="010"||v_status=="013"){ // 작성중 또는 부결당한 문서면 상신 모드, 반려시의 결재선은 기안함에서 볼 수 있다.
        	ln_SetDataHeader();	//결재선 헤더
        	btn_apline.style.display="";	//결재선지정
        	btn_new.style.display="";		//상신 버튼
        	btn_ing.style.display="none";		//승인/반려
        }else if(v_status=="011"){	//현장결재진행중이면 승인|반려 모드
        	fnSetApline(""); 			//기 결재선 조회하기~!
        	btn_apline.style.display="none";	//결재선지정
        	btn_new.style.display="none";		//상신 버튼
        	//btn_ing.style.display="";		//이건 결재선을 확인하고 나서 설정
        }else if(v_status=="012"){	//현장결재완료면 완료모드
        	fnSetApline(""); 			//기 결재선 조회하기~!
        	btn_apline.style.display="none";	//결재선지정
        	btn_new.style.display="none";		//상신 버튼
        	btn_ing.style.display="none";		//승인/반송
        }else{
        	fnSetApline(""); 			//기 결재선 조회하기~!
        }
        
    }
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_dwr_sid=<%=v_dwr_sid%>"
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_AP_DWR=ds_ap_dwr,O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            param);
        tr_post(tr1);
    }

    <%// 디테일 그리드 조회%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_dwr_sid=<%=v_dwr_sid%>" ;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            v_param);
        tr_post(tr1);
    }
       		
	<% // 결재선 지정 팝%>
	function fnPopApline() {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;
		var strPos;
		var sApproveLine;
		strURL = "<%=dirPath%>/Config/help/sy040h.jsp";
		strPos = "dialogWidth:620px;dialogHeight:500px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);
		fnSetApline(arrResult);
	}
	
	function fnSetApline(val){
		//alert("받아온 결재선="+val);
		var apline_tot = new Array();
		var apline_row = new Array();

		if(val!=""){
			ds_apline.clearData();	//먼저 지우고
			
			apline_tot=val.split(";");	// 결재선 행별로 나눔
			//alert("실제 결재선 행 + 1개 == "+apline_tot.length);	// 1행이면 2 리턴.. ;가 마지막에 들어가 있으니
			for(i=1;i<apline_tot.length;i++){
				apline_row = apline_tot[i-1].split("/");  // 1행부터
				/*
				alert(apline_row.length);	//
				alert("기본결재선(1) : " + apline_row[0]);	//
				alert("순번 : " + apline_row[1]);	//
				alert("결재유형 : " + apline_row[2]);	//
				alert("사번 : " + apline_row[3]);	//
				alert("이름 : " + apline_row[4]);	//
				alert("직위 : " + apline_row[5]);	//
				alert("부서 : " + apline_row[6]);	//
				alert("내 결재선 SID : " + apline_row[7]);	//
				*/
				
				ds_apline.AddRow();
				ds_apline.NameValue(i, "SEQ") 				= apline_row[1];//순번
				ds_apline.NameValue(i, "AP_TYPE") 			= apline_row[2];//결재유형
				ds_apline.NameValue(i, "ENO_NO")			= apline_row[3];//사번
				ds_apline.NameValue(i, "ENO_NM") 			= apline_row[4];//이름
				ds_apline.NameValue(i, "JOB_NM") 			= apline_row[5];//직위
				ds_apline.NameValue(i, "DPT_NM") 			= apline_row[6];//부서
				if(apline_row[1]==1){
					ds_apline.NameValue(i, "AP_STATUS_D") 	= "2";	//==상신
					
				}else{
					ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==미결
				};
				ds_apline.NameValue(i, "U_DATE") 			= "";
				ds_apline.NameValue(i, "AP_DESC") 			= "";
			}
		}else{
			
	    	v_job="S_AP";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				+ ",v_dwr_sid=<%=v_dwr_sid%>"
				+ ",v_ap_m_sid=<%=v_ap_m_sid%>"	//결재선sid
				;
			
			//이 결재선 조회도 Ap200I.java로 옮기는게 맞을 듯.. -_-
	        ln_TRSetting(tr1, 
	        	"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",	
	            "JSP(O:DS_APLINE=ds_apline)",
	            param);
	        tr_post(tr1);
		}
	} 

	<% //결재선 데이터셋 헤더 %>
	function ln_SetDataHeader(){
		if (ds_apline.countrow<1){
			var s_temp = " SEQ: DECIMAL(5),ENO_NO:STRING(7),AP_TYPE:STRING(10),ENO_NM:STRING(30),"
					   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),AP_STATUS_D:STRING(10), "
					   + " U_DATE:STRING(50), AP_DESC:STRING(100), SID:NUMERIC(10.0) ";
			ds_apline.SetDataHeader(s_temp);
		}
	}

	<% // 상신 - 이것도 Ap200I.java로 %>
	function fnApply_1() {
		if (ds_apline.countrow<1){
			alert("결재선을 지정한 후에 상신 가능합니다.");
			return false;
		}
		v_job="A1";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
            + ",v_dwr_sid=<%=v_dwr_sid%>" ;	
		ln_TRSetting(tr2, 
			"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",
    		"JSP(I:DS_APLINE=ds_apline)",	//여기에 msgDs를 넣었는데 처리를 안하면 tr2.onFail()로 인식한다. 2014-06-27
    		v_param);
		tr_post(tr2);
	}	
	<% // 반송 %>
	function fnApply_2() {
		if (ds_apline.countrow<1){
			alert("결재선 오류입니다. 화면을 새로고침해주세요.");
			return false;
		}
	
		v_job="A2";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2"
            + ",v_dwr_sid=<%=v_dwr_sid%>,"
            + ",v_ap_m_sid="+ ds_apline.NameValue(0, "AP_M_SID");	
		ln_TRSetting(tr2, 
    		"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",
    		"JSP(I:DS_APLINE=ds_apline)",	//
    		v_param);
		tr_post(tr2);
	}
	<% // 승인 %>
	function fnApply_3() {
		if (ds_apline.countrow<1){
			alert("결재선 오류입니다. 화면을 새로고침해주세요.");
			return false;
		}
		v_job="A3";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=3"
            + ",v_dwr_sid=<%=v_dwr_sid%>,"
            + ",v_ap_m_sid="+ ds_apline.NameValue(0, "AP_M_SID");	
		ln_TRSetting(tr2, 
				"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",
	    		"JSP(I:DS_APLINE=ds_apline)",
    		v_param);
		tr_post(tr2);
	}	

	
	<% // 창닫기%>
	function  fnClose(){
		window.close();
		opener.fnSelect();
	}
    </script>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr2" event="OnFail()">
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if((error_msg!="") && (error_msg!=null))
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	
</script>
<script language="javascript" for="tr2" event="OnSuccess()">
	if(v_job=="A1"){
		alert("성공적으로 상신되었습니다.");
		fnClose(); // 창닫기
	}
	if(v_job=="A3"){
		alert("승인 처리되었습니다.");
		fnClose(); // 창닫기
	}
	if(v_job=="A2"){
		alert("반려 처리되었습니다.\n\n[홈>공사>현장>작업 관리>일보 조회]에서 조회 후 재상신해 주세요.");
		//fnClose(); // 창닫기
	}
</script>

<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="S_AP"&&v_status!="000"){	// 결재선 조회 + 조회모드 아닐 때
		for(i=1;i<=ds_apline.countrow;i++){	//1행부터~
			// 상신 상태가 아니면서 사번이 로긴 사용자와 같은 사람이 있을 때
			if(("2"!=ds_apline.NameValue(i, "AP_STATUS_D"))&&("<%=gusrid%>"==ds_apline.NameValue(i, "ENO_NO"))){
				btn_ing.style.display="";		//승인, 반송 버튼 보이기	
			}
    		
		}
	}
</script>



<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_ap_dwr event="OnLoadCompleted(row)">
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			    ds_ap_dwr.ClearData();
			    ds_wd.ClearData();
			    ds_detail1.ClearData();
			    ds_detail2.ClearData();
			    ds_detail3.ClearData();
			}
		}
    </script>



    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_ap_dwr classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_wd classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_wm_chk classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_apline classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_wdcode classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bskind classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_aptype classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bpjob	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_apsts_d classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>



<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

</head>



<body onLoad="fnOnLoad()">

<!-- table width가 합계 890을 넘지 않도록.. td에 border지정시 사이즈 바깥쪽으로 선두께만큼 플러스임! 
	10 890 10 이렇게 
-->
<table border=0 cellpadding='0' cellspacing='0'>
  <tr>
  	<td width="10">&nbsp;</td>
  	<td width="890" class="t"><br>
	<table border="0" cellpadding="0" cellspacing="0">
	  <tr>
	  	<td class="t" height="70">
	  	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
	  	  <tr>
	  	  	<td width="200" class="l b "><img src="<%=dirPath%>/images/approval/2014start.gif" height="40"	 ><!-- width="299" height="100" --></td>
	  		<td width="490" class="c t bold"><span style="font-size:40px;">공 사 일 지</span><br>
	  			<input type="text" name="site_nm" id="site_nm" class="hidden c" style="width:400px;" readOnly="readonly"></td>
	  		<td width="200" class="r b"><img src="<%=dirPath%>/images/approval/2014dreamit.gif" height="40" ><!-- width="222" height="100"  --></td>
	  	  </tr>
	  	</table>
	  	</td>
	  </tr>
	  <tr>
	  	<td class="t" >
		<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
			<tr height="20px">
				<td width="150px"  bgcolor="#ffffff" rowspan="2" align="center">&nbsp;
					<input type="text" name="w_date_nm" id="w_date_nm" class="hidden c bold" style="width:100px;" readOnly="readonly">
				</td>
				<td width="60px" class="text"  rowspan="2" >날씨</td>
				<td width="110px" bgcolor="#ffffff" rowspan="2" class="c">
					<input type="text" name="wed" id="wed" class="hidden c" style="width:80px;" readOnly="readonly">
				</td>
				<td width="80px" class="text" >최저기온</td>
				<td width="81px" bgcolor="#ffffff" align="center">
					<input type="text" name='TEMP_MIN' id="TEMP_MIN" class="hidden c" style="width:50px;" readOnly="readonly"></td>
				<td width="79px" class="text"  rowspan="2" >공정율</td>
				<td width="60px" class="text" >계획</td>
				<td width="80px" bgcolor="#ffffff" align="center">
					<input type="text" name='RATE_PLAN' id="RATE_PLAN" class="hidden c" style="width:50px;" readOnly="readonly"></td>
				<td width="80px" class="text"  rowspan="2" >대비</td>
				<td width="99px" bgcolor="#ffffff"  rowspan="2"  align="center">
					<input type="text" name='PROG_RATE' id="PROG_RATE" class="hidden c" style="width:74px;" readOnly="readonly"></td>																	
			</tr>

			<tr height="20px">
				<td class="text" >최고기온</td>
				<td bgcolor="#ffffff" align="center">
					<input type="text" name="temp_max" id="temp_max" class="hidden c" style="width:50px;" readOnly="readonly"></td>
				<td class="text" >실적</td>
				<td bgcolor="#ffffff" align="center">
					<input type="text" name='RATE_RESULT' id="RATE_RESULT" class="hidden c" style="width:50px;" readOnly="readonly"></td>
			</tr>
		</table>
	  	</td>
	  </tr>
      <tr>
		<td class="t" style="border-left:1px solid #666666;">
          <object id=gr_wd classid=<%=HDConstant.MxGrid_CLSID_S%> width='889px' height='340px' border="0">
              <param name="DataID"            value="ds_wd">
              <param name="Editable"          value="true">
              <param name="BorderStyle"       value="0">
              <param name="Format"            value="
                   <C> name='구분'		ID='WD_CODE'	width=100 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_wdcode:detail:detail_nm'</C>
                   <C> name='금일작업'	ID='WD_NOW'   	width=386 	align=left	Edit=true  multiline=true</C>
                   <C> name='명일작업'    ID='WD_POST'	width=403 	align=left	Edit=true  multiline=true</C>
           ">
          </object>
		</td>
      </tr>
      <tr>
		<td class="t">
		  <table border="0" cellpadding="0" cellspacing="0">
			<tr>
			  <td class="t" style="border-left:1px solid #666666;">
				<object id=gr_detail1 classid=<%=HDConstant.MxGrid_CLSID_S%> width='316px' height='140px' border='0'>
	                <param name="DataID"            value="ds_detail1">
	                <param name="ColSizing"         value="false">
	                <param name="Editable"          value="true">
	                <param name="SuppressOption"    value="1">
	                <param name="BorderStyle"       value="0">
	                <param name="ViewSummary"       value="1">
	                <param name="Format"            value="
					<G> name='인원'
						<C> name='회사'		ID='BP_NM'  width=80 	align=left  EditStyle=popup sumtext='소계'  </C>
						<C> name='회사sid'	ID='BP_SID' width=80 	align=CENTER  edit=none  show=false suppress=1</C>
						<C> name='입찰sid'	ID='BID_SID' width=80 	align=CENTER  edit=none  show=false</C>
						<C> name='공종'		ID='BID_SITE_KIND'   	width=60 	align=left	Edit=None editstyle=lookup Data='ds_gc_bskind:detail:detail_nm'  suppress=1</C>
						<C> name='직종'		ID='BP_JOB'  width=60 	align=left	Edit=None editstyle=lookup Data='ds_gc_bpjob:detail:detail_nm'</C>
						<C> name='금일'    	ID='NOW_COMMIT'		width=40 	align=right Edit=true decao=0 sumtext=@sum </C>
						<C> name='누계'    	ID='TOT_COMMIT'		width=60 	align=right Edit=None decao=0 sumtext=@sum</C>
					</G>
                 	">
            	</object>   
              </td>
              <td class="t" style="border-left:1px solid #666666;">
            	<object id=gr_detail2 classid=<%=HDConstant.MxGrid_CLSID_S%> width='256px' height='140px' border='0'>
	                <param name="DataID"            value="ds_detail2">
	                <param name="ColSizing"         value="false">
	                <param name="Editable"          value="true">
	                <param name="SuppressOption"    value="1">
	                <param name="BorderStyle"       value="0">
	                <param name="ViewSummary"       value="1">
	                <param name="Format"            value="
					<G> name='장비'
                         <C> name='장비'		ID='ITEM_NM_S'		width=80 	align=left		sumtext='소계'  </C>
                         <C> name='장비SID'		ID='ITEM_SID'		width=80 	align=CENTER edit=none  show=false</C>
                         <C> name='규격'		ID='ITEM_SIZE'   	width=60 	align=CENTER edit=none	Edit=None</C>
                         <C> name='금일'    	ID='NOW_COMMIT'		width=40  	align=right edit=none decao=0  sumtext=@sum</C>
                         <C> name='누계'    	ID='TOT_COMMIT'		width=60 	align=right edit=none decao=0 sumtext=@sum</C>
					</G>
                 	">                             
            	</object>   
              </td>
              <td class="t" style="border-right:1px solid #666666;border-left:1px solid #666666;">
            	<object id=gr_detail3 classid=<%=HDConstant.MxGrid_CLSID_S%> width='314px' height='140px' border='0'>
	                <param name="DataID"            value="ds_detail3">
	                <param name="ColSizing"         value="false">
	                <param name="Editable"          value="true">
	                <param name="SuppressOption"    value="1">
	                <param name="BorderStyle"       value="0">
	                <param name="ViewSummary"       value="1">
	                <param name="Format"            value="
					<G> name='주요자재' 
					<C> name='품명'		ID='ITEM_NM'		width=80 	align=left   EditStyle=popup	sumtext='소계'  </C>
					<C> name='품목SID'	ID='ITEM_SID'		width=80 	align=CENTER	edit=none  show=false</C>
					<C> name='규격'		ID='ITEM_SIZE'   	width=60 	align=CENTER	Edit=None</C>
					<C> name='단위'		ID='ITEM_UNIT'   	width=58 	align=CENTER	Edit=None</C>
					<C> name='금일'    	ID='NOW_COMMIT'		width=40 	align=right	Edit=true decao=0  sumtext=@sum</C>
					<C> name='누계'    	ID='TOT_COMMIT'		width=60 	align=right Edit=None decao=0 sumtext=@sum</C>
					</G>
                 	">                             
				</object>   
			  </td>
			</tr>
		  </table>
		</td>
	  </tr>
	  <tr>
    	<td class="t" style="border:1px solid #666666;">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		  <tr>
			<td width="160px" class="text" style="border-right:1px solid #666666;">본사 요청사항</td>
			<td bgcolor="#ffffff" align="center" >
				<textarea name="remark" id="remark"  class="hidden" style="width:100%;height:52px"></textarea>
			</td>
		</tr>
		</table>
		</td>
	  </tr>
	  <tr>
		<td class="t">
			<!-- 결재 -->
			<table border="0" cellpadding="0" cellspacing="0" align=center>
			  <tr>
				<td height=30 class="l">
					<span id=btn_apline style="display:none;">
				  		<img src="<%=dirPath%>/Sales/images/btn_apline.gif"	align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnPopApline();">
				  	</span>
				</td>
				<td class="r">
					<span id=btn_new style="display:none;">
				    	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif" style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_1();">
				    </span>
				    <span id=btn_ing style="display:none;">
				    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif" style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_3();">
				    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif" style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_2();">
				     </span>
				</td>
			  </tr>
			  <tr>
				<td width=890 colspan=2 style="border:1px solid #666666;">
					<object id=gr_apline classid=<%=HDConstant.MxGrid_CLSID_S%> width='888px' height='120px' border='0'>
						<param name="DataID"		    value="ds_apline">
						<param name="ColSizing"	    value="true">
						<param name="Fillarea"		    value="false">
						<param name="Editable"		    value="true">
						<param name="BorderStyle"	value="0">
						<param name=SortView  		    value="Left">
						<param name="SuppressOption"    value="1">
						<param name="Format" 			value="
						  <C> name='결재SID'   ID='ap_m_sid'   	    width=80	align=left editlimit=5 show=FALSE edit=none    </C>
						  <C> name='순번'     	ID=SEQ		       width=40	align=center editlimit=2 show=true edit=none</C>
						  <C> name='유형'     	ID=AP_TYPE	       width=55	align=center EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm' edit=none</C>
			              <C> name='결재자'    	ID=ENO_NM		   	width=79 	align=center editlimit=50 show=true edit=none</C>
			              <C> name='사번'    	ID=ENO_NO		   	width=80 	align=center editlimit=50 show=false edit=none</C>
			              <C> name='직위'		ID=JOB_NM		    width=90 	align=center editlimit=20 show=true edit=none</C>
			              <C> name='부서'    	ID=DPT_NM	   	    width=180 	align=center editlimit=16 show=true edit=none</C>
			              <C> name='상태'     	ID=AP_STATUS_D	    width=60 	align=center EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm' edit=none</C>
			              <C> name='결재일시'	ID=U_DATE			width=120 	align=center editlimit=50 show=true edit=none</C>
			              <C> name='의견'	    ID=AP_DESC     		width=248	align=center editlimit=200 show=true edit=true</C>
						">
					</object>   
					
				</td>
			  </tr>
			</table>
			
			
			</td>
        </tr>        

	  <tr height="28">
	  	<td class="b c" ><img src="<%=dirPath%>/images/approval/2014ci.gif"	height="24" ></td>
	  </tr>
	</table>  	
  	</td>
  	<td width="10">&nbsp;</td>
  </tr>
</table>

<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
	
	     <object id=bn1 classid=<%=HDConstant.MxBinder_CLASSID%>>
	             <param name="DataId" value="ds_ap_dwr">
	             <param name=BindInfo    value="
					<C>Col=SITE_SID    		Ctrl=site_sid		Param=Value </C>
					<C>Col=SITE_NM       	Ctrl=site_nm       Param=Value </C>
					<C>Col=W_DATE_NM		Ctrl=w_date_nm     Param=Value </C>
					<C>Col=WED      		Ctrl=wed			Param=Value </C>
					<C>Col=TEMP_MAX       	Ctrl=TEMP_MAX      Param=Value </C>
					<C>Col=TEMP_MIN        	Ctrl=TEMP_MIN       Param=Value </C>
					<C>Col=RATE_PLAN		Ctrl=RATE_PLAN  	Param=Value </C>
					<C>Col=RATE_RESULT		Ctrl=RATE_RESULT    Param=Value </C>
					<C>Col=PROG_RATE	    Ctrl=PROG_RATE     Param=Value </C>
					<C>Col=MAN_PRE       	Ctrl=man_pre       Param=Text </C>
					<C>Col=MACHINE_PRE      Ctrl=machine_pre   Param=Text </C>
					<C>Col=MAN_NOW     		Ctrl=man_now   Param=Text </C>
					<C>Col=MACHINE_NOW  	Ctrl=machine_now    Param=Text </C>
					<C>Col=W_PRE        	Ctrl=w_pre        Param=Value </C>
					<C>Col=W_NOW    		Ctrl=w_now    	Param=Value </C>
					<C>Col=W_REMARK   		Ctrl=w_remark	Param=Value </C>
					<C>Col=REMARK   		Ctrl=remark		Param=Value </C>
	              ">
	      </object>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
</body>
</html>

		