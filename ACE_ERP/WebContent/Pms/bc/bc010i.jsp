<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>공사관리>거래처 관리>협력회사 관리>협력회사 등록
 * 프로그램ID 	 : PMS/BC010I
 * J  S  P		 : bc010i.jsp
 * 서 블 릿		 : Bc010I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2013-11-27
 * [ 수정일자 ][수정자] 내용
 * [2013-11-27][심동현] 신규 개발 
 * [2013-11-28][심동현] 스크립트를 넣어야 합니다. 수정/저장 테스트 완료
 *****************************************************************************/

 ///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
    var v_job = ""; 	//Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
    var v_job1 = ""; 	//Transaction Job의 속성변수. 신규인지 그냥 수정인지 구분하려궁

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_credit"), "comn");
		cfStyleGrid(getObjectFirst("gr_cashflow"), "comn");
		cfStyleGrid(getObjectFirst("gr_lic"), "comn");
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    sc_ds_in_cstr_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT018&s_item1=Y";
        sc_ds_in_cstr_kind.Reset(); //검색조건/등록공종

        ds_lic_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT019&s_item1=Y";
        ds_lic_kind.Reset(); //보유면허

        sc_ds_loc_place.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY006&s_item1=Y";
        sc_ds_loc_place.Reset(); //검색조건/소재지

        ds_credit_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT021&s_item1=Y";
        ds_credit_grd.Reset(); //신용등급

        ds_cashflow_grd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT022&s_item1=Y";
        ds_cashflow_grd.Reset();	//현금흐름
        
        ds_in_cstr_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT018&s_item1=Y";
        ds_in_cstr_kind.Reset(); //등록공종
        ds_in_yn.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_in_yn.Reset(); //등록여부
        ds_loc_place.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY006&s_item1=Y";
        ds_loc_place.Reset(); //소재지
        ds_rcmd_man.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT006&s_item1=Y";
        ds_rcmd_man.Reset();	//추천부서

		//데이터셋 헤더 초기화 = 빈 조회
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
			+ ",v_bp_sid=-1"
			+ ",v_in_cstr_kind="
			+ ",v_lic_kind="
			+ ",v_loc_place="
			+ ",v_cstr_eval_fee_fr=0"
			+ ",v_cstr_eval_fee_to=0"
			+ ",v_credit_grd="
			+ ",v_cashflow_grd="
			+ ",v_in_yn=";
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010I",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_GR_CREDIT=ds_gr_credit,O:DS_GR_CASHFLOW=ds_gr_cashflow,O:DS_GR_LIC=ds_gr_lic)",
            param);
           
        tr_post(tr1);
    }
    
    
    
    <%//메인 조회  %>
    function fnSelect() {
		if (ds_default.IsUpdated){	//}	 || ds_tender.IsUpdated) {
			alert("수정중인 행인 있습니다.");
		} else {
			v_job="S";
			var in_yn = "N";
	    	if(sc_v_in_yn.checked){
	    		in_yn="Y";	//등록된 것만
	    	}
		    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				+ ",v_bp_sid="+ sc_v_bp_sid.value
				+ ",v_in_cstr_kind=" + sc_lc_in_cstr_kind.ValueOfIndex("detail", sc_lc_in_cstr_kind.Index)
				+ ",v_lic_kind=" + sc_lc_lic_kind.ValueOfIndex("detail", sc_lc_lic_kind.Index)
				+ ",v_loc_place=" + sc_lc_loc_place.ValueOfIndex("detail", sc_lc_loc_place.Index)
				+ ",v_cstr_eval_fee_fr=" + sc_eme_cstr_eval_fee_fr.text
				+ ",v_cstr_eval_fee_to=" + sc_eme_cstr_eval_fee_to.text
				+ ",v_credit_grd=" + sc_lc_credit_grd.ValueOfIndex("detail", sc_lc_credit_grd.Index)
				+ ",v_cashflow_grd=" + sc_lc_cashflow_grd.ValueOfIndex("detail", sc_lc_cashflow_grd.Index)
				+ ",v_in_yn=" + in_yn;

	        //alert(param);
	        
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010I",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
		};
    }    

    <%// 디테일 그리드 조회%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_bp_sid="+getObjectFirst("ds_default").NameValue(row, "bp_sid");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010I",
            "JSP(O:DS_GR_CREDIT=ds_gr_credit,O:DS_GR_CASHFLOW=ds_gr_cashflow,O:DS_GR_LIC=ds_gr_lic)",
            v_param);
        tr_post(tr2);
    }
    
	<%//저장 %>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_default.RowPosition;
		
		if (ds_default.IsUpdated || ds_gr_lic.IsUpdated || ds_gr_credit.IsUpdated || ds_gr_cashflow.IsUpdated) {
			if(ln_Chk()){
				//ds_lic 저장하기 위해 새로 정렬
				var data_str = ds_gr_lic.ExportData(1, ds_gr_lic.CountRow, false);
				ds_gr_lic.DeleteAll();
				ds_gr_lic.ImportData(data_str);
				ds_gr_lic.SortExpr = "-cstr_eval_fee";
				ds_gr_lic.Sort();	
				
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010I",
                "JSP(I:DS_DEFAULT=ds_default)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
        	}
		}else {
     		alert("업데이트된 행이 없습니다.");
	 	}
	}
	<%// 입력값 체크 %>
	function ln_Chk() {
		var row1=ds_default.countrow;
		//var row2=ds_tender.countrow;

		for(i=1;i<=row1;i++) {
			if(ds_default.namevalue(i,"bizregi_no").length<10) {
				alert("사업자 등록 번호를 입력해 주십시오");
				v_bizregi_no.focus();
				return;
			}
			if(ds_default.namevalue(i,"bp_nm")=="") {
				alert("협력사명을 입력해 주십시오");
				v_bp_nm.focus();
				return;
			}
		}
		return true;
	}

	<%//협력사 팝%>
    function fnSelCoopPopup(dirPath) {
        v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnCtCoopPop(dirPath);
   
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            sc_v_bp_nm.value = arrParam[1];	//NM
            sc_v_bp_sid.value = arrParam[2];	//SID
        } else {
			fnSelBpCleanup();
        }               
    }
    function fnSelBpCleanup(){
        sc_v_bp_nm.value = "";
        sc_v_bp_sid.value  = "";
    }



	<%// 마스터 신규 %>
	function fnAddRowDsDefault(){
		if (ds_default.IsUpdated || ds_gr_lic.IsUpdated || ds_gr_credit.IsUpdated || ds_gr_cashflow.IsUpdated) {
			alert("수정중인 행이 있으면 신규 협력사정보를 생성할 수 없습니다.");
			return;
		}else {
			v_job1="N";
			ds_default.addrow();
				ds_gr_credit.cleardata();
				ds_gr_cashflow.cleardata();
				ds_gr_lic.cleardata();
			lc_in_cstr_kind.index = 0;
			lc_in_yn.index = 1;
			lc_loc_place.index = 0;
			lc_rcmd_man.index = 0;
			v_in_date.value= "<%=DateUtil.getCurrentDate(8)%>";
			v_bizregi_no.focus();
			
			return;
		}
	}

	<%// 마스터 삭제 %>
	function fnDeleteRowDsDefault() {
		if(ds_default.IsUpdated) {
			alert("수정중인 작업이 있어 삭제할 수 없습니다.");
			return;
		}else {
			ds_default.DeleteRow(ds_default.RowPosition);
		};
	};

	<%//디테일-신용등급 행추가 %>
	function fnAddRowDs21() {
		if (ds_default.namevalue(ds_default.rowposition,"bp_sid") == undefined || ds_default.namevalue(ds_default.rowposition,"bp_sid") == "" || ds_default.namevalue(ds_default.rowposition,"bp_sid") == 0 ) {
			alert("협력사 기본정보를 조회/저장 후 추가해 주세요.");
		} else {
			ds_gr_credit.addrow();
			ds_gr_credit.namevalue(ds_gr_credit.RowPosition, "BP_SID") = ds_gr_credit.namevalue(ds_default.rowposition,"BP_SID");
			msgTxt.innerHTML="신용등급 행이 삽입되었습니다.";
		}
	}
	<%//디테일-신용등급 행삭제 %>
	function fnDeleteRowDs21(){
		ds_gr_credit.deleterow(ds_gr_credit.rowposition);
		msgTxt.innerHTML="신용등급 행이 삭제되었습니다.";
	}
	<%//디테일-현금흐름 행추가 %>
	function fnAddRowDs22() {
		if (ds_default.namevalue(ds_default.rowposition,"bp_sid") == undefined || ds_default.namevalue(ds_default.rowposition,"bp_sid") == "" || ds_default.namevalue(ds_default.rowposition,"bp_sid") == 0 ) {
			alert("협력사 기본정보를 조회/저장 후 추가해 주세요.");
		} else {
			ds_gr_cashflow.addrow();
			ds_gr_cashflow.namevalue(ds_gr_cashflow.RowPosition, "BP_SID") = ds_default.namevalue(ds_default.rowposition,"BP_SID");
			msgTxt.innerHTML="현금흐름 행이 삽입되었습니다.";
		}
	}
	<%//디테일-현금흐름 행삭제 %>
	function fnDeleteRowDs22(){
		ds_gr_cashflow.deleterow(ds_gr_cashflow.rowposition);
		msgTxt.innerHTML="현금흐름 행이 삭제되었습니다.";
	}
	<%//디테일-면허 행추가 %>
	function fnAddRowDs23() {
		if (ds_default.namevalue(ds_default.rowposition,"bp_sid") == undefined || ds_default.namevalue(ds_default.rowposition,"bp_sid") == "" || ds_default.namevalue(ds_default.rowposition,"bp_sid") == 0 ) {
			alert("협력사 기본정보를 조회/저장 후 추가해 주세요.");
		} else {
			ds_gr_lic.addrow();
			ds_gr_lic.namevalue(ds_gr_lic.RowPosition, "BP_SID") = ds_default.namevalue(ds_default.rowposition,"BP_SID");
			msgTxt.innerHTML="보유면허 행이 삽입되었습니다.";
		}
	}
	<%//디테일-면허 행삭제 %>
	function fnDeleteRowDs23(){
		ds_gr_lic.deleterow(ds_gr_lic.rowposition);
		msgTxt.innerHTML="보유면허 행이 삭제되었습니다.";
	}	
	<%// 그리드 수정 취소 %>
	function fnCancel() {
        ds_default.undoall();
        ds_gr_lic.undoall();
        ds_gr_credit.undoall();
        ds_gr_cashflow.undoall();
		msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
		return;		
	}
</script>

<%
/*=============================================================================
			GRID Components Event Scripts
=============================================================================*/
%>
	<%//협력사 선택시 신평사 연동정보 불러오기 %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		if (ds_default.IsUpdated || ds_gr_credit.IsUpdated) {
			alert("수정중인  작업이 있을 경우에는 조회를 할수 없습니다!");
			return false;
		} else {
		    //var row2=ds_tender.countrow;
		    if(Row==0) return;
		    if(v_default_row==Row){
				return;
			}else{
				fnSelectDetail(Row);
		    }
		};
	</script>
	





<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
		//fnSelectDetail(v_default_row);
		
		if(v_job1=="N"){	//신규 저장일 때는 데이터셋 지우기
			ds_default.ClearData();
			ds_gr_lic.ClearData();
			ds_gr_credit.ClearData();
			ds_gr_cashflow.ClearData();
		}
	}

</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			//ds_tender.clearall();
			}else{
				fnSelectDetail(v_default_row);
			}
		}
	</script>
	
	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 	<!-- 기본검색 그리드 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_gr_lic classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  보유면허 그리드-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gr_credit classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  신용등급 그리드-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gr_cashflow classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  현금흐름 그리드-->
    <param name="SyncLoad"  value="True">
</object>

<object id=sc_ds_in_cstr_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  검색조건/등록공종 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_lic_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  보유면허 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=sc_ds_loc_place classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  검색조건/소재지 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_credit_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  신용등급 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_cashflow_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  현금흐름 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_in_cstr_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  등록공종 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_in_yn classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  등록공종 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_loc_place classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  소재지 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rcmd_man classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 추천부서 -->
    <param name="SyncLoad"  value="True">
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"  onClick="fnAddRowDsDefault()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand"  onclick="fnCancel()">
							<!-- <img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:hand" onClick="fnDeleteRowDsDefault()" > -->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
                                    <td width="70" align="center" class="text">협력사명</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='sc_v_bp_nm' id='sc_v_bp_nm' style="width:160px;" class='input01' onkeydown="if(event.keyCode==113) fnSelCoopPopup('<%=dirPath%>');" readOnly="readonly">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelBpCleanup();" alt="값 지우기">
                                        <input type="hidden" name='sc_v_bp_sid' id='sc_v_bp_sid'  style="width:40px;" class='input01' readOnly>
                                    </td>
			                        <td width="70" align="left" class="text">등록공종</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=sc_lc_in_cstr_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=sc_ds_in_cstr_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
			                        <td width="70" align="left" class="text">보유면허</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=sc_lc_lic_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_lic_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
                    			</tr>
                                <tr>
			                        <td align="left" class="text">소재지</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=sc_lc_loc_place classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=sc_ds_loc_place>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>
			                        </td>                                
			                        <td align="left" class="text">시평액</td>
			                        <td align="left" colspan=3 bgcolor="#ffffff">&nbsp;
			                            <object id=sc_eme_cstr_eval_fee_fr classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=Format      value="">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
											<param name=Numeric		value="true">
											<param name=IsComma   	value=true>			                                
			                            </object>&nbsp;<span style="position:relative;top:4px;">억원</span>&nbsp;~&nbsp;
			                            <object id=sc_eme_cstr_eval_fee_to classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=Format      value="">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
											<param name=Numeric		value="true">
											<param name=IsComma   	value=true>
			                            </object>&nbsp;<span style="position:relative;top:4px;">억원</span>
			                                                                                                         
			                        </td>
                                </tr>
                    			

	                    		<tr>
			                        <td align="left" class="text">신용등급</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=sc_lc_credit_grd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_credit_grd>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>&nbsp;이상
			                            
			                        </td>
                    				<td align="left" class="text">현금흐름</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id="sc_lc_cashflow_grd" classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align="absmiddle">
			                                <param name=ComboDataID     value=ds_cashflow_grd>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>&nbsp;이상
			                        </td>   			                        
		                			<td align="left" class="text">등록유무</td>
			                        <td align="left" bgcolor="#ffffff" >&nbsp;<input type="checkbox" name="sc_v_in_yn" id="sc_v_in_yn"></td>

			             		</tr>
			           		</table>                    	
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="300px">
                            
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='181px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="0">
                                <param name="Format"            value="
									<FC> name='순'			ID={CurRow} 		width=30	align=right </FC>
									<C> name='협력사코드'	ID='BP_CD'    		width=80 	align=CENTER	Edit=None </C>
									<C> name='협력사명'		ID='BP_NM' 			width=170 	align=CENTER	Edit=None </C>
								">
                            </object>   
                            

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">협력사코드</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_bp_cd' id='v_bp_cd' style="width:90px;" class='input01' readOnly="readonly">  
									</td>
									<td width="120px" class="boardt02">등록공종</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;
			                            <object id=lc_in_cstr_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_in_cstr_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>									
									</td>
								</tr>
								<tr height="21px">
									<td class="boardt02">사업자등록번호</td>
									<td bgcolor='#ffffff'>&nbsp;
			                            <object id=v_bizregi_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="000-00-00000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
									</td>
		                			<td align="left" class="text">등록유무</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=lc_in_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_in_yn>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
								</tr>
								<tr height="21px">
									<td class="text">협력사명</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_bp_nm' id='v_bp_nm'  maxlength="25" style="width:120px;" class='textbox' >
									</td>
									<td class="text">대표자</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_exc_man' id='v_exc_man'  maxlength="10" style="width:120px;" class='textbox' >

									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">개업년월일</td>
									<td bgcolor='#ffffff'>&nbsp;
			                            <object id=v_built_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>  
									</td>
									<td class="text">사업장 소재지</td>
									<td bgcolor='#ffffff'>&nbsp;
			                            <object id=lc_loc_place classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_loc_place>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>
			                        </td>

								</tr>

								<tr height="21px">
									<td class="text">전화</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_phone_no' id='v_phone_no' style="width:120px;" maxlength="19" class='textbox' >
									</td>
									<td width="120px" class="text">팩스</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_fax_no' id='v_fax_no' style="width:120px;"  maxlength="19" class='textbox' >
									</td>
								</tr>								
								<tr height="21px">
                                    <td align="center" class="text">추천</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
			                            <object id=lc_rcmd_man classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_rcmd_man>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>                                    
                                    </td>
									<td class="text">등록일</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_in_date' id='v_in_date' style="width:90px;" class='input01' readOnly="readonly">
									</td>                                    								
								</tr>
								<tr height="21px">
                                    <td align="center" class="text">참고사항</td>
                                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_remark' id='v_remark'  maxlength="50" style="width:382px;" class='textbox' >
                                    </td>
								</tr>
							</table>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td>
				<table width="849px" border=0>
		          <!-- <tr>
		            <td align=right>
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs21()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs21()" >
					</td>
					<td></td>
		            <td align=right>
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs22()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs22()" >
					</td>
					<td></td>
		            <td align=right>
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs23()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs23()" >
					</td>
		          </tr> -->
		          <tr>
		            <td valign="top" width="200px">
		                <object id="gr_credit" classid=<%=HDConstant.CT_GRID_CLSID%> width='200px' height='150px' border='1'>
		                    <param name="DataID"            value="ds_gr_credit">
		                    <param name="ColSizing"         value="true">
		                    <param name="Editable"          value="FALSE">
		                    <param name="SuppressOption"    value="1">
		                    <param name="BorderStyle"       value="0">
		                    <param name="Format"            value="
		                         <C> name='기준년도' 	ID='bp_yymm'   		width=70 	align=CENTER	show=true </C>
		                         <C> name='신용등급'	ID='credit_grd'    	width=60 	align=CENTER	editstyle=lookup Data='ds_credit_grd:detail:detail_nm'</C>
		                         <C> name='신평사' 		ID='company'   		width=50 	align=CENTER	show=true </C>
		                         <C> name='bp_sid' 		ID='bp_sid'   		width=60 	align=CENTER	edit=none show=false </C>
		                 ">                             
		                </object>   
					</td>
					<td></td>
		            <td valign="top"  width="200px">
		                <object id="gr_cashflow" classid=<%=HDConstant.CT_GRID_CLSID%> width='200px' height='150px' border='1'>
		                    <param name="DataID"            value="ds_gr_cashflow">
		                    <param name="ColSizing"         value="true">
		                    <param name="Editable"          value="FALSE">
		                    <param name="SuppressOption"    value="1">
		                    <param name="BorderStyle"       value="0">
		                    <param name="Format"            value="
		                         <C> name='기준년도' 	ID='bp_yymm'   		width=70 	align=CENTER	show=true </C>
		                         <C> name='현금흐름'	ID='cashflow_grd'	width=60 	align=CENTER	editstyle=lookup Data='ds_cashflow_grd:detail:detail_nm'</C>
		                         <C> name='신평사' 		ID='company'   		width=50 	align=CENTER	show=true </C>
		                         <C> name='bp_sid' 		ID='bp_sid'   		width=60 	align=CENTER	edit=none show=false </C>
		                 ">                             
		                </object>   
					</td>
					<td></td>
		            <td valign="top"  width="340px">
		                <object id="gr_lic" classid=<%=HDConstant.CT_GRID_CLSID%> width='340px' height='150px' border='1'>
		                    <param name="DataID"            value="ds_gr_lic">
		                    <param name="ColSizing"         value="true">
		                    <param name="Editable"          value="FALSE">
		                    <param name="SuppressOption"    value="1">
		                    <param name="BorderStyle"       value="0">
		                    <param name="Format"            value="
		                         <C> name='면허'			ID='LIC_KIND' 		width=130 	align=CENTER	editstyle=lookup Data='ds_lic_kind:detail:detail_nm'</C>
		                         <C> name='시평액(천원)'	ID='CSTR_EVAL_FEE'	width=100	align=right		decao=0 </C>
		                         <C> name='기준년도'		ID='BASE_YEAR'	width=70	align=center	</C>
		                         
		                 ">                             
		                </object>   
					</td>
		          </tr>		          
				</table>
  
			</td>
        </tr>
        <tr>
			<td>※ 하단의 3개 GRID 정보(신용등급, 현금흐름, 면허순위)는 신용평가사와 연동해 자동으로 불러옵니다.<BR>
			　 신용평가사 : E = Ecredible 이크레더블, N = Nicednb 나이스디앤비
			</td>
        </tr>
        
    </table>

	
	
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
	
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_default">
	             <param name=BindInfo    value="
					<C>Col=bp_cd	      	Ctrl=v_bp_cd			Param=Value </C>
					<C>Col=in_cstr_kind		Ctrl=lc_in_cstr_kind	Param=BindColVal </C>
					<C>Col=bizregi_no      	Ctrl=v_bizregi_no		Param=Text </C>
					<C>Col=in_yn	      	Ctrl=lc_in_yn			Param=BindColVal </C>
					<C>Col=bp_nm	      	Ctrl=v_bp_nm			Param=Value </C>
					<C>Col=exc_man	      	Ctrl=v_exc_man			Param=Value </C>
					<C>Col=built_date      	Ctrl=v_built_date		Param=Text </C>
					<C>Col=loc_place      	Ctrl=lc_loc_place		Param=BindColVal </C>
					<C>Col=phone_no     	Ctrl=v_phone_no			Param=Value </C>
					<C>Col=fax_no     		Ctrl=v_fax_no			Param=Value </C>
					<C>Col=rcmd_man      	Ctrl=lc_rcmd_man		Param=BindColVal </C>
					<C>Col=in_date        	Ctrl=v_in_date			Param=Value </C>
					<C>Col=remark	      	Ctrl=v_remark			Param=Value </C>
	              ">
	      </object>
	 
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		