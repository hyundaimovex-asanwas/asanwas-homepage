<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>PMS>기준정보 관리>프로젝트 관리>프로젝트 코드 관리
 * 프로그램ID 	 : PMS/SY200I
 * J  S  P		 : sy200i.jsp, GAUCE5.x
 * 서 블 릿		 : Sy200I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2015-08-20
 * [ 수정일자 ][수정자] 내용
 * [2015-08-20][심동현] 회계팀 관리자용, 전체 프로젝트 현황 조회
 *						
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
%>

<!-- HTML 시작 : doctype를 html5로-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	var menuWin;	//새창 띄우기용.
	var v_todt = "<%=DateUtil.getCurrentDate(8)%>";
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_pl"), "comn");	//project list
		cfStyleGrid(getObjectFirst("gr_apline"), "comn");
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
        ds_gc_useyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY010&s_item1=Y";
        ds_gc_useyn.Reset();	//사용여부 YN (SY010)(전체+ : dsType=4)
        ds_gc_prop1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY201&s_item1=Y";
        ds_gc_prop1.Reset();	//사업구분1 (SY201)(전체+ : dsType=4)
        ds_gc_prop2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY202&s_item1=Y";
        ds_gc_prop2.Reset();	//사업구분2 (SY202)(전체+ : dsType=4)
        
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy200I",
            "JSP(O:DS_PL=ds_pl)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
//			+ ",v_cardspec=" + lc_gc_cardspec.ValueOfIndex("detail", lc_gc_cardspec.Index)	//종류
//			+ ",v_cadiv=" + lc_gc_cadiv.ValueOfIndex("detail", lc_gc_cadiv.Index)	//구분
//			+ ",v_mgr_no=" + v_mgr_no.value	//처리자 사번
//			+ ",v_useyn=" + lc_gc_useyn.ValueOfIndex("detail", lc_gc_useyn.Index)	//사용여부
//			+ ",v_card_num=" + v_card_num.value	//카드번호
			;
		alert(param);
		
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy200I",
            "JSP(O:DS_PL=ds_pl)",
            param);
        tr_post(tr1);
    }


	<%//저장 %>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_pl.RowPosition;
		
		if (ds_pl.IsUpdated || ds_coa.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
                "JSP(I:ds_pl=ds_pl,I:DS_COA=ds_coa)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	);
        		tr_post(tr1);
        	}
		}else {
     		alert("업데이트된 행이 없습니다.");
	 	}
	}
	<%// 입력값 체크 %>
	function ln_Chk() {
		var row1=ds_coa.countrow;
		for(i=1;i<=row1;i++) {
			if(ds_coa.namevalue(i,"BGNDATE")=="") {
				alert("처리권한의 시작일자를 입력해 주십시오");
				return;
			}else if (ds_coa.namevalue(i,"ENDDATE")=="") {			
				alert("처리권한의 시작일자를 입력해 주십시오");
				return;
			}else if (ds_coa.namevalue(i,"MGR_NO")=="") {			
				alert("처리권한의 처리자를 입력해 주십시오");
				return;
			}
		}		
		return true;
	}    
    
    
 
	<%//직원 팝- 조회 조건%>
    function fnEmpNoPopup(dirPath){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
        } else {
			fnEmpNoCleanup();
        }               
    }
	<%//직원 팝- 카드 보유자 / 카드 그리드%>
    function fnEmpNoPopup1(dirPath, row){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		ds_pl.namevalue(row, "CADEPTCD") = arrParam[4]; //부서코드
    		ds_pl.namevalue(row, "DPT_NM") = arrParam[2];	//부서명
    		ds_pl.namevalue(row, "CAEMPNO") = arrParam[1];	//보유자 사번
    		ds_pl.namevalue(row, "EMP_NM") = arrParam[0];	//카드 보유자
        } else {
    		ds_pl.namevalue(row, "CADEPTCD") = ""; //부서코드
    		ds_pl.namevalue(row, "DPT_NM") = '';	//부서명
    		ds_pl.namevalue(row, "CAEMPNO") = "";	//보유자 사번
    		ds_pl.namevalue(row, "EMP_NM") = "미등록";	//카드 보유자
        }               
    }
    <%//직원 팝- 처리권한 그리드%>
    function fnEmpNoPopup2(dirPath, row){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		ds_coa.namevalue(row, "MGR_NO") = arrParam[1]; 
    		ds_coa.namevalue(row, "MGR_NM") = arrParam[0];
        } else {
    		ds_coa.namevalue(row, "MGR_NO") = ""; 
    		ds_coa.namevalue(row, "MGR_NM") = "";

        }               
    }
	<%//거래처 검색 팝- 카드의 회계 거래처%>
    function fnVenderPopup(dirPath, row){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/gczm_vender_popup.jsp";
    	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);

    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		ds_pl.namevalue(row, "VEND_NM") = arrParam[1];	//거래처명
    		ds_pl.namevalue(row, "VEND_CD") = arrParam[0];	//거래처코드
        } else {
        	ds_pl.namevalue(row, "VEND_NM") = "";	//거래처명
    		ds_pl.namevalue(row, "VEND_CD") = "";	//거래처코드
        }               
    }
    
    
    
    
    function fnEmpNoCleanup(){
        v_mgr_no.value = "";
        v_mgr_nm.value  = "";
    }
    
    function fnCardNoCleanup(){
    	v_card_num.value = "";
    }

    
	<%//액셀 다운하기%>
    function fnExcelDsDefault() {
        if(ds_pl.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_pl").SetExcelTitle(0, "");
        getObjectFirst("gr_pl").SetExcelTitle(1, "value:법인카드 현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_pl").GridToExcel("법인카드 현황", v_todt+"_법인카드_현황.xls", 8);        
    }

    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//마스터 그리드 OnClick %>
	<script language="javascript"  for=gr_pl event=OnClick(Row,Colid)>
		if(Colid=="JOB_SEL") {
			if(ds_pl.namevalue(Row,"EMP_NM")=="미등록"){
				//erp카드정보가 없는 경우. BCAS정보를 복사해서 기본정보를 만들어준다.
				ds_pl.namevalue(Row, "CACARDSPEC") = "004";											//카드\\종류
				if(ds_pl.namevalue(Row,"CardDetailGubun")="1"){		// 지정 → 개인명, 공용 → 법인명. 디폴트. 예외도 있음.
					ds_pl.namevalue(Row,"CADIV") = "2";												//카드구분
				}else{
					ds_pl.namevalue(Row,"CADIV") = "1";
				}
				ds_pl.namevalue(Row, "CANBR") = ds_pl.namevalue(Row,"CardNumber");					//카드번호
				ds_pl.namevalue(Row, "CAUSEYYMM") = ds_pl.namevalue(Row,"CardExpiredDate");			//유효기간
				ds_pl.namevalue(Row, "CAISSYYMM") = ds_pl.namevalue(Row,"SENDDATE").substring(0,6);	//발급년월
				ds_pl.namevalue(Row, "CASTTDAT") = ds_pl.namevalue(Row,"AccountDate");				//결제일자
				ds_pl.namevalue(Row, "CAACCBANK") = "0"+ds_pl.namevalue(Row,"AccountBank");			//은행코드
				ds_pl.namevalue(Row, "CABANKNO") = ds_pl.namevalue(Row,"AccountNumber");			//결제계좌
				ds_pl.namevalue(Row, "CACUST") = ds_pl.namevalue(Row,"MemberKrName");				//회원명 -> 예금주
				ds_pl.namevalue(Row, "USE_TAG") = "Y"; 												//사용여부
				
				
			}else{//erp카드정보가 있는 경우
				alert("미등록 카드만 체크할 수 있습니다.");
				ds_pl.undo(Row);//해당 DataSet의 Row를 원래값(=Original Data)로 복원시킨다.
			}
		}else{
			//fnSelectDetail(Row);
			//row.value = ds_cul.RowPosition;			
		}
			
	</script>



	<%//마스터 : 팝업  %>	
	<script language=JavaScript for=gr_pl event=OnPopup(row,colid,data)>
		if(colid=="EMP_NM") {
			//alert(row);
			fnEmpNoPopup1('<%=dirPath%>', row);
		}
		if(colid=="VEND_NM") {
			//alert(row);
			fnVenderPopup('<%=dirPath%>', row);
		}
		

	</script>
	
	<%//디테일1 : 처리 권한 그리드 / 처리자~! %>	
	<script language=JavaScript for=gr_coa event=OnPopup(row,colid,data)>
		if(colid=="MGR_NM") {
			//alert(row);
			fnEmpNoPopup2('<%=dirPath%>', row);
		}
	</script>
	
		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
//		fnSelect(); // 디테일들 조회하기
	}
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_pl" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_pl event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			    ds_cul.ClearData();
			    ds_coa.ClearData();
			}else{
				//fnSelectDetail(v_default_row);
			}
		}

	</script>
    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_pl classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_useyn classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_prop1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_prop2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bc1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bc2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bc3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
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

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->


<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0' width='890px'>
                    <tr>
			     		<td align=left >
							
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" 	onClick="fnApply();">							
							<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:pointer" onclick="fnExcelDsDefault()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>
                        <td align="center" class="text" width="90">프로젝트명</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_card_num' id="v_card_num" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnCardNoCleanup();" alt="값 지우기">
                        </td>
                        <td align="center" class="text" width="90">손익센터</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=120 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
                        <td align="left" class="text" width="90">상태</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_cardspec classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^40">
                            </object>
                        </td>                                
                        <td align="left" class="text" width="90">사용 여부</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=60 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>                                
					</tr>
           			<tr>
                        <td align="center" class="text" width="90">사업구분1</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=120 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_prop1>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
                        <td align="center" class="text" width="90">사업구분2</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=120 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_prop2>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
                        <td align="center" class="text" width="90">영업 대표</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01' readOnly="readonly" value="">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:60px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                        </td>
                        <td align="center" class="text" width="90">작성자</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01' readOnly="readonly" value="">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:60px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                        </td>

					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <object id=gr_pl classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='140px' border='1'>
                    <param name="DataID"            value="ds_pl">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
					<Param Name="UsingOneClick"     value="1">
					<param name="ViewSummary"       value="1">
					<Param Name="SortView"     value="Right">                    
                    <param name="Format"            value="
						<C> name='Chk'          ID='JOB_SEL'    	Width=30   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False </C>
						<C> name='상태'   		 ID='CACARDSPEC' 	width=40 	align=CENTER	editstyle=lookup Data='ds_gc_useyn:detail:detail_nm' SumText='총' </C>
						<C> name='프로젝트'   	 ID='PLJ_NM'   	 	width=180 	align=left	SumText=@count </C>
						<C> name='구분1'   		 ID='PROP1' 		width=40 	align=CENTER	editstyle=lookup Data='ds_gc_prop1:detail:detail_nm' SumText='건' </C>
						<C> name='구분2'   		 ID='PROP2' 		width=70 	align=LEFT		editstyle=lookup Data='ds_gc_prop2:detail:detail_nm' </C>
                        <C> name='원가코드'		 ID='COST_CD'    	width=60 	align=center </C>
                        <C> name='손익센터'		 ID='PL_DEPT_NM'	width=100 	align=left  edit=none  </C>
                        <C> name='예상시작일'	 ID='CTRT_BGNDATE'  width=70 	align=center mask='XXXX-XX-XX'</C>
                        <C> name='예상종료일'	 ID='CTRT_ENDDATE'  width=70 	align=center mask='XXXX-XX-XX'</C>
                        <C> name='예상발주처'	 ID='ORDER_COMP_NM'  width=100 	align=left  </C>
                        <C> name='영업대표명'	 ID='EXC_NM'   width=70 	align=center </C>
                        <C> name='예상수주액'    ID='WIN_FEE'	 width=80 	align=right	 decao=0  </C>
                        <C> name='ERP코드'		 ID='PLJ_CD'    width=90 	align=left </C>
                        <C> name='사용'			 ID='USE_YN'    width=40 	align=center </C>
                        
                        <C> name='예상수주일'	 ID='WIN_DATE'  width=70 	align=center mask='XXXX-XX-XX'</C>
                        <C> name='PM명'			 ID='PM_NM'   width=70 	align=center </C>
                        <C> name='예상원가'      ID='COST_FEE'	 width=80 	align=right	 decao=0  </C>
                        <C> name='폐기일자'		 ID='DSU_DATE'  width=70 	align=center mask='XXXX-XX-XX'</C>
                        <C> name='출력순서'		 ID='PRINT_SEQ'   width=70 	align=center </C>
                        <C> name='특이사항'		 ID='NOTE'   width=70 	align=center </C>
                        
					">                             
                </object>                        

            </td>
        </tr>
		<tr height='6px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
            <!-- 뷰 화면 -->        

                <table  border='0' cellpadding='0' cellspacing='0'>
					<tr height="26px">
			            <td  class="b bold">■ 프로젝트 개요</td>
			        </tr>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >프로젝트명</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >프로젝트코드</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >사업구분1</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >사업구분2</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >손익센터</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >예상수주일</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>								
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >예상 시작일</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >예상 종료일</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >예상 발주처</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >비고</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >영업대표</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >PM</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								
							</table>
						</td>
					</tr>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >예상 수주액</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >예상 원가</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
			            <td><br>
			            <table border="0" cellpadding="0" cellspacing="0">
			              <tr>
			            	<td class="t bold" width="650">■ 결재선
								<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">			            	
								  	<tr><!-- 결재선 -->
										<td>
											<object id=gr_apline classid=<%=HDConstant.MxGrid_CLSID_S%> width='648px' height='140px' border='0'>
												<param name="DataID"		    value="ds_apline">
												<param name="ColSizing"	    value="true">
												<param name="Fillarea"		    value="false">
												<param name="Editable"		    value="true">
												<param name="BorderStyle"	value="0">
												<param name=SortView  		    value="Left">
												<param name="SuppressOption"    value="1">
												<param name="Format" 			value="
												  <C> name='결재SID'   ID='ap_m_sid'   	    width=80	align=left editlimit=5 show=FALSE edit=none    </C>
												  <C> name='순번'     	ID=SEQ		       width=35	align=center editlimit=2 show=true edit=none</C>
												  <C> name='유형'     	ID=AP_TYPE	       width=45	align=center EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm' edit=none</C>
									              <C> name='결재자'    	ID=ENO_NM		   	width=59 	align=center editlimit=50 show=true edit=none</C>
									              <C> name='사번'    	ID=ENO_NO		   	width=80 	align=center editlimit=50 show=false edit=none</C>
									              <C> name='직위'		ID=JOB_NM		    width=60 	align=center editlimit=20 show=true edit=none</C>
									              <C> name='부서'    	ID=DPT_NM	   	    width=100 	align=center editlimit=16 show=true edit=none</C>
									              <C> name='상태'     	ID=AP_STATUS_D	    width=40 	align=center EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm' edit=none</C>
									              <C> name='결재일시'	ID=U_DATE			width=100 	align=center editlimit=50 show=true edit=none</C>
									              <C> name='의견'	    ID=AP_DESC     		width=208	align=center editlimit=200 show=true edit=true</C>
												">
											</object>   
											
										</td>
									</tr>
								</table>
			              	</td>
			              	<td class="t bold" width="350">　■ 첨부파일
								<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
									<tr height="20px">
										<td width="60px" class="c" bgcolor="#eeeeee">계획</td>
										<td width="272px" bgcolor="#ffffff" align="center">
				                            <object id=RATE_PLAN classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:16px;" tabindex="5">
				                                <param name=Text        value="">
				                                <param name=Alignment   value=2>
				                                <param name=VAlign	    value=1>
				                                <param name=Numeric  	value="true">
				                                	<param name=MaxLength	value=3>
													<param name=MaxDecimalPlace	value=2>
				                                <param name=Border      value="false">      
				                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
				                                <param name=ReadOnly    value="false">
				                                <param name=SelectAll   value="true">
				                                <param name=SelectAllOnClick    value="true">
				                                <param name=SelectAllOnClickAny   value="false">
				                            </object>&nbsp;%
				                         </td>
									</tr>
									<tr height="120px">
										<td  class="c" bgcolor="#eeeeee" >첨부<br>파일</td>
										<td bgcolor="#ffffff" align="center">
				                            <object id=RATE_RESULT classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:17px;" tabindex="6">
				                                <param name=Text        value="">
				                                <param name=Alignment   value=2>
				                                <param name=VAlign	    value=1>
				                                <param name=Numeric  	value="true">
				                                	<param name=MaxLength	value=3>
													<param name=MaxDecimalPlace	value=2>
				                                <param name=Border      value="false">      
				                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
				                                <param name=ReadOnly    value="false">
				                                <param name=SelectAll   value="true">
				                                <param name=SelectAllOnClick    value="true">
				                                <param name=SelectAllOnClickAny   value="false">
				                            </object>&nbsp;%</td>								
									</tr>
								</table>

			              	</td>
			              </tr>
			            </table>
			            </td>
			        </tr>
				</table>
			</td>
		</tr>
        
    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		