<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>PMS>법인카드>카드 관리>카드 현황
 * 프로그램ID 	 : PMS/CC110I
 * J  S  P		 : cc110i.jsp, GAUCE5.x
 * 서 블 릿		 : Cc110I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2015-08-05
 * [ 수정일자 ][수정자] 내용
 * [2015-08-05][심동현] 재무팀 관리자용, 전체 카드 현황 조회
 *						BCAS 카드 현황과 조인해서 미등록카드는 표시해주자
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
		
		cfStyleGrid(getObjectFirst("gr_cl"), "comn");	//card list
		cfStyleGrid(getObjectFirst("gr_coa"), "comn");	//card operating author

		fnInit();
	}
	
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
	    
	    //v_frdt.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
	    
        ds_gc_cardspec.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC011&s_item1=Y";
        ds_gc_cardspec.Reset();	//카드 종류
        ds_gc_cadiv.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC012&s_item1=Y";
        ds_gc_cadiv.Reset();	//카드 구분
        ds_gc_useyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY010&s_item1=Y";
        ds_gc_useyn.Reset();	//사용여부 YN (SY010)(전체+ : dsType=4)
        ds_gc_cabank.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CC013&s_item1=Y";
        ds_gc_cabank.Reset();	//카드 결제은행(3자리)

        ds_gc_bc1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CC001&s_item1=Y";
        ds_gc_bc1.Reset();	//bc 카드종류구분
        ds_gc_bc2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CC002&s_item1=Y";
        ds_gc_bc2.Reset();	//bc 카드세부구분
        ds_gc_bc3.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CC003&s_item1=Y";
        ds_gc_bc3.Reset();	//bc 이동구분
        
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
            "JSP(O:DS_CL=ds_cl)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	
    	v_job="S";
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_cardspec=" + lc_gc_cardspec.ValueOfIndex("detail", lc_gc_cardspec.Index)	//종류
			+ ",v_cadiv=" + lc_gc_cadiv.ValueOfIndex("detail", lc_gc_cadiv.Index)	//구분
			+ ",v_mgr_no=" + v_mgr_no.value	//처리자 사번
			+ ",v_useyn=" + lc_gc_useyn.ValueOfIndex("detail", lc_gc_useyn.Index)	//사용여부
			+ ",v_card_num=" + v_card_num.value	//카드번호
			;
		//alert(param);
		
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
            "JSP(O:DS_CL=ds_cl)",
            param);

        tr_post(tr1);
        
    }

    
    
    <%// 디테일 - 카드별 처리 권한%>
    function fnSelectDetail(row) {
    	
        if(row!=v_default_row){
    		v_default_row = row;//이번에 디테일을 조회하는 row를 담아두고 감
        }
        
	        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
	                    + ",v_ca_sid="+ ds_cl.namevalue(row,"CA_SID");
			ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
	            "JSP(O:DS_COA=ds_coa)",
	            v_param);
			
	        tr_post(tr2);
	        
    }    
    
    
    
    <%//처리권한 행추가%>
    function fnAddRowDt1(){
    	
		ds_coa.addrow();
		
		ds_coa.namevalue(ds_coa.RowPosition, "ca_sid") = ds_cl.namevalue(ds_cl.RowPosition,"CA_SID");
		ds_coa.namevalue(ds_coa.RowPosition, "canbr") = ds_cl.namevalue(ds_cl.RowPosition,"CANBR");
		
		msgTxt.innerHTML="[처리권한] 행이 삽입되었습니다.";		
		
    }    
    
    
    
    <%//처리권한 행삭제%>
    function fnDelRowDt1(){
    	
		ds_coa.deleterow(ds_coa.RowPosition);
		
		ds_coa.namevalue(ds_coa.RowPosition, "ca_sid") = ds_cl.namevalue(ds_cl.RowPosition,"CA_SID");
		ds_coa.namevalue(ds_coa.RowPosition, "canbr") = ds_cl.namevalue(ds_cl.RowPosition,"CANBR");
		
		msgTxt.innerHTML="[처리권한] 행이 삭제되었습니다.";		
		
    }   
    
    

	<%//저장 %>
	function fnApply(){
		
		v_job = "A";
		
		v_default_row = ds_cl.RowPosition;
		
		if (ds_cl.IsUpdated || ds_coa.IsUpdated) {
			
			if(ln_Chk()){
				
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
                "JSP(I:DS_CL=ds_cl,I:DS_COA=ds_coa)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	);
			  
			  //prompt(this, ds_coa.text);
			  
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
    		ds_cl.namevalue(row, "CADEPTCD") = arrParam[4]; //부서코드
    		ds_cl.namevalue(row, "DPT_NM") = arrParam[2];	//부서명
    		ds_cl.namevalue(row, "CAEMPNO") = arrParam[1];	//보유자 사번
    		ds_cl.namevalue(row, "EMP_NM") = arrParam[0];	//카드 보유자
    		
        } else {
        	
    		ds_cl.namevalue(row, "CADEPTCD") = ""; //부서코드
    		ds_cl.namevalue(row, "DPT_NM") = '';	//부서명
    		ds_cl.namevalue(row, "CAEMPNO") = "";	//보유자 사번
    		ds_cl.namevalue(row, "EMP_NM") = "미등록";	//카드 보유자
    		
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
    		ds_cl.namevalue(row, "VEND_NM") = arrParam[1];	//거래처명
    		ds_cl.namevalue(row, "VEND_CD") = arrParam[0];	//거래처코드
    		
        } else {
        	
        	ds_cl.namevalue(row, "VEND_NM") = "";	//거래처명
    		ds_cl.namevalue(row, "VEND_CD") = "";	//거래처코드
    		
        }               
    	
    }
    
    
    
    
    function fnEmpNoCleanup(){
    	
        v_mgr_no.value = "";
        
        v_mgr_nm.value  = "";
        
    }
    
    
    
    
    function fnCardNoCleanup(){
    	
    	v_card_num.value = "";
    	
    	v_card_num.focus();
    	
    }

    
    
    
	<%//액셀 다운하기%>
    function fnExcelDsDefault() {
    	
        if(ds_cl.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        
        getObjectFirst("gr_cl").SetExcelTitle(0, "");
        getObjectFirst("gr_cl").SetExcelTitle(1, "value:법인카드 현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_cl").GridToExcel("법인카드 현황", v_todt+"_법인카드_현황.xls", 8);     
        
    }

    
    </script>
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>



	<%//마스터 그리드 OnClick %>
	<script language="javascript"  for=gr_cl event=OnClick(Row,Colid)>
	
	
		if(Colid=="JOB_SEL") {
			
			if(ds_cl.namevalue(Row,"EMP_NM")=="미등록"){
				
				//erp카드정보가 없는 경우. BCAS정보를 복사해서 기본정보를 만들어준다.
				ds_cl.namevalue(Row, "CACARDSPEC") = "004";											//카드\\종류
				
				if(ds_cl.namevalue(Row,"CardDetailGubun")="1"){										// 지정 → 개인명, 공용 → 법인명. 디폴트. 예외도 있음.
					ds_cl.namevalue(Row,"CADIV") = "2";												//카드구분
				}else{
					ds_cl.namevalue(Row,"CADIV") = "1";
				}
				
				ds_cl.namevalue(Row, "CANBR") = ds_cl.namevalue(Row,"CardNumber");					//카드번호
				ds_cl.namevalue(Row, "CAUSEYYMM") = ds_cl.namevalue(Row,"CardExpiredDate");			//유효기간
				ds_cl.namevalue(Row, "CAISSYYMM") = ds_cl.namevalue(Row,"SENDDATE").substring(0,6);	//발급년월
				ds_cl.namevalue(Row, "CASTTDAT") = ds_cl.namevalue(Row,"AccountDate");				//결제일자
				ds_cl.namevalue(Row, "CAACCBANK") = "0"+ds_cl.namevalue(Row,"AccountBank");			//은행코드
				ds_cl.namevalue(Row, "CABANKNO") = ds_cl.namevalue(Row,"AccountNumber");			//결제계좌
				ds_cl.namevalue(Row, "CACUST") = ds_cl.namevalue(Row,"MemberKrName");				//회원명 -> 예금주
				ds_cl.namevalue(Row, "USE_TAG") = "Y"; 												//사용여부
				
				
			}else{//erp카드정보가 있는 경우
				alert("미등록 카드만 체크할 수 있습니다.");
				ds_cl.undo(Row);//해당 DataSet의 Row를 원래값(=Original Data)로 복원시킨다.
			}
		}else{
			fnSelectDetail(Row);
			//row.value = ds_cul.RowPosition;			
		}
			
	</script>




	<%//마스터 : 팝업  %>	
	<script language=JavaScript for=gr_cl event=OnPopup(row,colid,data)>
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
		//fnSelect(); // 디테일들 조회하기
	}
	
</script>




<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

    <script language="JavaScript"  for="ds_cl" event="OnLoadStarted()" >
    
        msgTxt.innerHTML="데이타 조회중입니다. 잠시만 기다려 주십시오.";
        
    </script>
 
 
    <script language=JavaScript  for=ds_cl event="OnLoadCompleted(row)">
    
        msgTxt.innerHTML="조회가 완료 되었습니다.";
        
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			    ds_cul.ClearData();
			    ds_coa.ClearData();
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

<object id=ds_cl classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_coa classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_cardspec classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_cadiv classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_useyn classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_cabank classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
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
            <td>
                <table border='0' cellpadding='0' cellspacing='0' width='1050px'>
                    <tr>
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
            <td>
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1050px'>
           			<tr>
                        <td align="left" class="text" width="90">카드 종류</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_cardspec classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=60 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_cardspec>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^40">
                            </object>
                        </td>                                
                        <td align="left" class="text" width="90">구분</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_cadiv classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=80 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_cadiv>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
                            </object>
                                                        
                        </td>                                
                        <td align="center" class="text" width="90">보유자</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01' readOnly="readonly" value="">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:60px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                        </td>
                        <td align="left" class="text" width="90">사용 여부</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>                   
                        </td>                                
					</tr>

           			<tr>
                        <td align="center" class="text" width="90">카드번호</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_card_num' id="v_card_num" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnCardNoCleanup();" alt="값 지우기">
                        </td>
                        <td colspan=6 bgcolor="#ffffff">&nbsp;</td>
					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <object id=gr_cl classid=<%=HDConstant.MxGrid_CLSID_S%> width='1050px' height='250px' border='1'>
                    <param name="DataID"            value="ds_cl">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="ColSizing"         value="true">
                    <param name="SuppressOption"    value="1">
					<Param Name="UsingOneClick"     value="1">
					<param name="ViewSummary"       value="1">
					<Param Name="SortView"     value="Right">                    
                    <param name="Format"            value="
						<C> name='Chk'          	ID='JOB_SEL'   	 	 Width=30   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False </C>
						<C> name='카드\\종류'   	ID='CACARDSPEC'   	 width=50 	align=CENTER	editstyle=lookup Data='ds_gc_cardspec:detail:detail_nm' SumText='총' </C>
						<C> name='구분'   		 	ID='CADIV'   		 width=50 	align=CENTER	editstyle=lookup Data='ds_gc_cadiv:detail:detail_nm' SumText=@count </C>
                        <C> name='관리부서'	 		ID='DPT_NM'   		 width=100 	align=left  edit=none SumText='개' </C>
                        <C> name='카드\\보유자' 	ID='EMP_NM'   		 width=70 	align=CENTER EditStyle=popup bgColor={IF(EMP_NM='미등록','#ffcccc','#FFFFFF') }</C>
                        <C> name='카드번호'	 		ID={IF(EMP_NM='미등록',CardNumber, CANBR) }  width=140 	align=left	edit=none mask='XXXX-XXXX-XXXX-XXXX' bgColor={IF(EMP_NM='미등록','#ffcccc','#FFFFFF') } </C>
                        <C> name='유효\\기간'	 	ID='CAUSEYYMM'	 	 width=60 	align=CENTER edit=none mask='XXXX/XX'</C>
                        <C> name='사용'				ID='USE_TAG'   	 	width=40 	align=center	 bgColor={IF(USE_TAG='N','#ffcccc','#FFFFFF') }	editstyle=lookup Data='ds_gc_useyn:detail:detail_nm'</C>
                        <C> name='폐기일자'			ID='DSUDT'   	 	width=70 	align=center	 bgColor={IF(USE_TAG='N','#ffcccc','#FFFFFF') }</C>                        
                        <C> name='한도'   	     	ID='CAMAX'			 width=70 	align=right	 decao=0  </C>
                        <C> name='비고'			 	ID='CAETC'   		 width=60 	align=left	 </C>
                        <C> name='발급\\년월'		ID='CAISSYYMM'   	width=60 	align=center mask='XXXX/XX'</C>
                        <C> name='결제일'			ID='CASTTDAT'    	width=50 	align=center </C>
                        <C> name='결제\\은행'		ID='CAACCBANK'   	width=50 	align=center editstyle=lookup Data='ds_gc_cabank:detail:detail_nm' </C>
                        <C> name='결제계좌'			ID='CABANKNO'    	width=100 	align=left	</C>
                        <C> name='예금주'			ID='CACUST'   	 	width=120 	align=left	</C>
                        <C> name='(회계)\\거래처'	ID='VEND_NM'   	 	width=120 	align=left	EditStyle=popup </C>

					  <G> name='카드정보 (BC제공)'
						<C> name='구분1'   			ID='CARDGUBUN'   	 width=50 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_bc1:detail:detail_nm' </C>
						<C> name='구분2'   			ID='CardDetailGubun' width=40 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_bc2:detail:detail_nm' </C>
						<C> name='카드번호'			ID='CardNumber'  	 width=140 	align=left		edit=none mask='XXXX-XXXX-XXXX-XXXX' </C>
						<C> name='회원명'			ID='MemberKrName'	 width=80 	align=left		edit=none </C>
						<C> name='유효기간'			ID='CardExpiredDate' width=70 	align=CENTER 	edit=none </C>
						<C> name='이동'   			ID='InfoGubun'   	 width=70 	align=left		editstyle=lookup Data='ds_gc_bc3:detail:detail_nm' bgColor={IF(InfoGubun='3','#ffff00','#FFFFFF') }</C>
						<C> name='결제일'			ID='AccountDate'   	 width=50 	align=CENTER	edit=none </C>
                        <C> name='은행'				ID='AccountBank'   	 width=50 	align=CENTER	edit=none </C>
                        <C> name='결제계좌'			ID='AccountNumber'   width=90 	align=left		edit=none </C>
                        <C> name='전송일자'			ID='SENDDATE'   	 width=70 	align=center	edit=none </C>
					  </G>
                 ">                             
                </object>                        

            </td>
        </tr>
        <tr>
            <td valign="top"><br>
            	<table border=0>
				  <tr>
					<td></td>
					<td height='21px' align='right'>
						<img src="<%=dirPath%>/Sales/images/minus.gif"	style="cursor:pointer" onClick="fnDelRowDt1()" >					
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt1()" >
    				</td>
				  </tr>            	
            	  <tr>
            	  	<td width=240 class="t"><h3>처리 권한 위임</h3>
            	  	처리자는 카드 사용현황 메뉴에서<br>
            	  	위임받은 모든 카드의 사용현황을<br>
            	  	확인할 수 있습니다.</td>
            	  	<td width=520>
		                <object id=gr_coa classid=<%=HDConstant.MxGrid_CLSID_S%> width='800px' height='300px' border='1'>
		                    <param name="DataID"            value="ds_coa">
		                    <param name="Editable"          value="true">
		                    <param name="BorderStyle"       value="0">
		                    <param name="SuppressOption"    value="1">
		                    <param name="Format"            value="
		                    	<C> name='No'		 ID='{CurRow}'	 width=30 	align=center    edit=none</C>
		                        <C> name='카드번호'	 ID='CANBR'		 width=200  align=center    edit=none mask='XXXX-XXXX-XXXX-XXXX' suppress='1' </C>
		                        <C> name='시작일자'	 ID='BGNDATE'	 width=150 	align=center	 mask='XXXX-XX-XX' </C>
		                        <C> name='종료일자'	 ID='ENDDATE'	 width=150 	align=center	 mask='XXXX-XX-XX' </C>
		                        <C> name='처리자'	 ID='MGR_NM'	 width=120 	align=CENTER	EditStyle=popup </C>
		                        <C> name='사번'		 ID='MGR_NO'	 width=120 	align=CENTER	edit=none </C>
		                 ">                             
		                </object>                        
            	  	</td>
            	  </tr>
            	</table>
            </td>
        </tr>

    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		