<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>공사관리>거래처 관리>협력회사 관리>협력회사 조회
 * 프로그램ID 	 : PMS/BC010S
 * J  S  P		 : bc010s.jsp
 * 서 블 릿		 : Bc010S
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2013-11-27
 * [ 수정일자 ][수정자] 내용
 * [2013-11-27][심동현] 신규 개발 
 * [2013-12-03][심동현] 새창 버전 테스트
 *						할수만 있따면 js랑 css도 정리를 하면 좋은데욤;;;
 *						1) 로그인 체크
 * [2013-12-04][심동현] head.jsp, body_s.jsp 수정~						
 * [2014-02-20][심동현] 이산가족날.. 화이팅!
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

<!-- HTML 시작-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
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

	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		/* 레이어1 */
		cfStyleGrid(getObjectFirst("gr_1_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_2"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_3"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_4"), "comn");
		/* 레이어2 */
		cfStyleGrid(getObjectFirst("gr_2_1"), "comn");
		/* 레이어3 */
		cfStyleGrid(getObjectFirst("gr_3_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_3_2"), "comn");
		cfStyleGrid(getObjectFirst("gr_3_3"), "comn");
		/* 레이어4 */
		cfStyleGrid(getObjectFirst("gr_4_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_4_2"), "comn");
		/* 레이어5 */
		cfStyleGrid(getObjectFirst("gr_5_1"), "comn1");
		/* 레이어6 */
		cfStyleGrid(getObjectFirst("gr_6_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_6_2"), "comn");
		/* 레이어7 */
		cfStyleGrid(getObjectFirst("gr_7_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_7_2"), "comn");
		cfStyleGrid(getObjectFirst("gr_7_3"), "comn");
		/* 레이어8 */
		cfStyleGrid(getObjectFirst("gr_8_1"), "comn");
		/* 레이어9 */
		cfStyleGrid(getObjectFirst("gr_9_1"), "comn");

		
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";    	
	    ds_in_cstr_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT018&s_item1=Y";
        ds_in_cstr_kind.Reset(); //등록공종
        ds_lic_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT019&s_item1=Y";
        ds_lic_kind.Reset(); //보유면허
        ds_loc_place.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY006&s_item1=Y";
        ds_loc_place.Reset(); //소재지
        ds_credit_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT021&s_item1=Y";
        ds_credit_grd.Reset(); //신용등급
        ds_cashflow_grd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT022&s_item1=Y";
        ds_cashflow_grd.Reset();	//현금흐름
    
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";    	
        var in_yn = "N";

    	if(v_in_yn.checked){
    		in_yn="Y";	//등록된 것만
    	}
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_bp_sid="+ v_bp_sid.value
			+ ",v_in_cstr_kind=" + lc_in_cstr_kind.ValueOfIndex("detail", lc_in_cstr_kind.Index)
			+ ",v_lic_kind=" + lc_lic_kind.ValueOfIndex("detail", lc_lic_kind.Index)
			+ ",v_loc_place=" + lc_loc_place.ValueOfIndex("detail", lc_loc_place.Index)
			+ ",v_cstr_eval_fee_fr=" + eme_cstr_eval_fee_fr.text
			+ ",v_cstr_eval_fee_to=" + eme_cstr_eval_fee_to.text
			+ ",v_credit_grd=" + lc_credit_grd.ValueOfIndex("detail", lc_credit_grd.Index)
			+ ",v_cashflow_grd=" + lc_cashflow_grd.ValueOfIndex("detail", lc_cashflow_grd.Index)
			+ ",v_in_yn=" + in_yn;

        //alert(param);
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010S",
            "JSP(O:DS_DEFAULT=ds_default)",
            param);
           
        tr_post(tr1);
    }    

    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:협력회사_현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("협력회사_현황", "협력회사_현황.xls", 8);        
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
            v_bp_nm.value = arrParam[1];	//NM
            v_bp_sid.value = arrParam[2];	//SID
        } else {
			fnSelBpCleanup();
        }               
    }
    function fnSelBpCleanup(){
        v_bp_nm.value = "";
        v_bp_sid.value  = "";
    }
    
    
    <%// 레이어1 총괄 조회%>
    function fnSelectLayer1(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_bp_sid="+getObjectFirst("ds_default").NameValue(row, "bp_sid");
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010S",
            "JSP(O:DS_1_0=ds_1_0,O:DS_1_1=ds_1_1,O:DS_1_2=ds_1_2,O:DS_1_3=ds_1_3,O:DS_1_4=ds_1_4)",
            v_param);
        tr_post(tr1);
        
        
    }
    
    function fnSelectLayer2(){
    	alert(222);
    }
    function fnSelectLayer3(){
    	alert(333);
    }
    function fnSelectLayer4(){
    	alert(444);
    }
    function fnSelectLayer5(){
    	alert(555);
    }
    function fnSelectLayer6(){
    	alert(666);
    }
    function fnSelectLayer7(){
    	alert(777);
    }
    function fnSelectLayer8(){
    	alert(888);
    }
    function fnSelectLayer9(){
    	alert(999);
    }
    function fnSelectLayer10(){
    	alert(10);
    }
    
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//협력회사 클릭시 레이어1 조회 %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			fnSelectLayer1(Row);
	    }
	</script>
	
	<%//입찰 그리드 더블 클릭시 입찰요약 팝 %>
	<script language=javascript for="gr_1_1" event="OnDblClick(Row, Colid)">
		//v_job="SD";
		
	    if(Row==0) return;
	    alert(Row);
	    /*if(v_default_row==Row){
			return;
		}else{
			fnSelectLayer1(Row);
	    }*/
	</script>
	
	<%//탭 선택시 조회하기 %>
	<script language="javascript" for="gcte_disp" event="onselChanged(index)">
		if (ds_default.CountRow>0) {
			if (index=="2") 		fnSelectLayer2(); 
			else if (index=="3")	fnSelectLayer3();	
			else if (index=="4")	fnSelectLayer4();	
			else if (index=="5")	fnSelectLayer5();  
			else if (index=="6")	fnSelectLayer6();
			else if (index=="7")	fnSelectLayer7();
			else if (index=="8")	fnSelectLayer8();
			else if (index=="9")	fnSelectLayer9();
			
		}
	</script>	


<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_default" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
        
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			//ds_tender.clearall();
			}else{
				fnSelectLayer1(v_default_row);
			}
		}
    </script>

    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_in_cstr_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  등록공종 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_lic_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  보유면허 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_loc_place classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  소재지 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_credit_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  신용등급 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_cashflow_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  현금흐름 -->
    <param name="SyncLoad"  value="True"/>
</object>


<object id=ds_1_0 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 레이어1_0 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_1_1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 레이어1_1 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_1_2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 레이어1_2 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_1_3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 레이어1_3 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_1_4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 레이어1_4 -->
    <param name="SyncLoad"  value="True"/>
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
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

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDsDefault()">
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
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='v_bp_nm' id='v_bp_nm' style="width:160px;" class='input01' onkeydown="if(event.keyCode==113) fnSelCoopPopup('<%=dirPath%>');" readOnly="readonly" value="주초">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelBpCleanup();" alt="값 지우기">
                                        <input type="hidden" name='v_bp_sid' id='v_bp_sid'  style="width:40px;" class='input01' readOnly value="23">
                                    </td>
			                        <td width="70" align="left" class="text">등록공종</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=lc_in_cstr_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 align=absmiddle>
			                                <param name=ComboDataID     value=ds_in_cstr_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
			                        <td width="70" align="left" class="text">보유면허</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=lc_lic_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 align=absmiddle>
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
			                            <object id=lc_loc_place classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_loc_place>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>
			                        </td>                                
			                        <td align="left" class="text">시평액</td>
			                        <td align="left" colspan=3 bgcolor="#ffffff">&nbsp;
			                            <object id=eme_cstr_eval_fee_fr classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
			                            <object id=eme_cstr_eval_fee_to classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
			                            <object id=lc_credit_grd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_credit_grd>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>&nbsp;이상
			                            
			                        </td>
                    				<td align="left" class="text">현금흐름</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id="lc_cashflow_grd" classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align="absmiddle">
			                                <param name=ComboDataID     value=ds_cashflow_grd>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>&nbsp;이상
			                        </td>   			                        
		                			<td align="left" class="text">등록유무</td>
			                        <td align="left" bgcolor="#ffffff" >&nbsp;<input type="checkbox" name="v_in_yn" id="v_in_yn"></td>

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
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                         
                        <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='150px' border='1'>
                            <param name="DataID"            value="ds_default">
                            <param name="ColSizing"         value="true">
                            <param name="Editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="BorderStyle"       value="0">
                            <param name="ViewSummary"       value="0">
                            <param name=SortView  			value="Right">
                            <param name="Format"            value="
                                 <F> name='순'				ID={CurRow} 		width=35	align=right </F> 
                                 <C> name='협력사코드'		ID='BP_CD'    		width=80 	align=CENTER	Edit=None </C>
                                 <C> name='협력사명'		ID='BP_NM' 			width=100 	align=CENTER	Edit=None sort=true</C>
                                 <C> name='사업자등록번호'	ID='BIZREGI_NO'		width=100 	align=left 		Edit=None show=false </C>
                                 <C> name='소재지'  		ID='LOC_PLACE'      width=60 	align=center 	Edit=None editstyle=lookup data='ds_loc_place:detail:detail_nm'</C>
                                 <C> name='등록공종'		ID='IN_CSTR_KIND'	width=80	align=center 	Edit=None editstyle=lookup data='ds_in_cstr_kind:detail:detail_nm'</C>
								<G> name='보유면허①'
                                 <C> name='면허'			ID='LIC_KIND1'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE1'	width=80 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='보유면허②'
                                 <C> name='면허'			ID='LIC_KIND2'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE2'	width=80 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='보유면허③'
                                 <C> name='면허'			ID='LIC_KIND3'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE3'	width=80 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								 <C> name='신용등급'		ID='CREDIT_GRD'   	width=60 	align=center 	Edit=None editstyle=lookup data='ds_credit_grd:detail:detail_nm'</C>
								 <C> name='현금흐름'		ID='CASHFLOW_GRD'  	width=60 	align=center 	Edit=None editstyle=lookup data='ds_cashflow_grd:detail:detail_nm'</C>
								 <C> name='등록'			ID='IN_YN'	 	 	width=50 	align=center 	Edit=None </C>
                         ">                             
                        </object>   
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td colspan='3' valign="top"><br>
			<OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 style="width:800px;height:20px">
				<PARAM NAME="BackColor"					VALUE="#cccccc">
				<PARAM NAME="titleHeight"				VALUE="20px">
	            <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
				<PARAM NAME="Format"						VALUE="
					<T>divid=layer1  title='총괄'</T>
					<T>divid=layer2  title='기업개요'</T>									
					<T>divid=layer3  title='면허 및 시공능력'</T>
					<T>divid=layer4  title='실적(당사)'</T>
					<T>divid=layer5  title='실적(타사)'</T>
					<T>divid=layer6  title='매출/매입처'</T>
					<T>divid=layer7  title='채무불이행'</T>
					<T>divid=layer8  title='재무제표'</T>
					<T>divid=layer9	 title='신용등급'</T>
					<T>divid=layer10  title='신용평가보고서'</T>

				">
			</OBJECT>
			
			

<!---------[TAB 1] 총괄 ----------->
<div id="layer1" style="border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
<script language='javascript'> 
    function showEcreCert(u, p, i, k, c) {
        if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
		
    	//alert(getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO"));
        var link ='http://www.esrm.co.kr/esrm/SrmplusLogin?u='+ u +'&p='+ p +'&i='+ getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO") +'&k='+ k +'&c=7&m=3&g=2';
        var features ='height=768, width=1024, status=no, scrollbars=auto, resizable=yes';
        window.open(link, 'watchwin', features); 
    } 
</script>
<%
	//이크레더블 인증서 보기?
        // u : 인코딩된 사용자 아이디
        // p : 인코딩된 사용자 암호
        // i : 협력업체사업자번호 - 본사사업자번호
	    // k : 협력업체법인번호
        // c : 암호화방법
        //      1(암호화안함), 2(base64), 3:(128bit,시스템이 java일 경우에만), 7:(128bit, 인증정보 고정, 사업자번호암호화 X)
        // m : 통합인증서 기본 섹션 
        //      1(업체검색), 2(Watch메인), 3(전자인증서메인), 4(건설실적메인), 5(거래위험메인), 8(IT실적메인)
        // g : 고정파라미터

		String u ="2d2d424547494e204349504845522d2d313131310000000b3030303030303030cbdd77ad19cf5c1558642438a796c668e7c9c69e0c6d37758967171a01138e5c89170074853f9d0c500916f7e1699e9330302d2d454e44204349504845522d2d";	// 메일내용에 있는 아이디
		String p ="2d2d424547494e204349504845522d2d31313131000000043030303030303030ac976e9b5772c9c9347c8fe124537fcb02d4f647ae0d9ead209c0b4788690ea4eb4f8af8a3cce9beb5e58115a79e352a30302d2d454e44204349504845522d2d";	// 메일내용에 있는 암호
		String i ="";	// 협력업체사업자번호
		String k ="";	// 협력업체법인번호

%>

	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 개요</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(단위:천원)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="136px" bgcolor="#eeeeee">협력사명</td>
	  	  		<td class="tab21" width="273px">&nbsp;<input type="text" name='l1_v_bp_nm' id='l1_v_bp_nm' style="width:220px;" class='hidden' readOnly="readonly">
	  	  			<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="showEcreCert('<%=u%>','<%=p%>','<%=i%>','<%=k%>','3')" alt="이크레더블 신용평가보고서"></td>
				<td class="tab11" width="136px" bgcolor="#eeeeee">대표자</td>
	  	  		<td class="tab22" width="273px">&nbsp;<input type="text" name='l1_v_exc_man' id='l1_v_exc_man' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">등록공종</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l1_v_in_cstr_kind_nm' id='l1_v_in_cstr_kind_nm' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">소재지</td>
	  	  		<td class="tab22">&nbsp;<input type="text" name='l1_v_loc_place' id='l1_v_loc_place' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허1</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l1_v_LIC_KIND1' id='l1_v_LIC_KIND1' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;
					<object id=l1_v_CSTR_EVAL_FEE1 classid=<%=HDConstant.CT_EMEDIT_CLSID%> class="hidden" style= "position:relative;left:0px;top:4px;width:200px; height:17px;">
						<param name=Text        value="">
						<param name=Alignment   value=2>
						<param name=Format      value="">
						<param name=Cursor      value="iBeam">
						<param name=Border      value="false">      
						<param name=InheritColor      value="true">                                                                                                                                                                                                             
						<param name=ReadOnly    value="true">
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>			                                
                    </object>	  	  		
				</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허2</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l1_v_LIC_KIND2' id='l1_v_LIC_KIND2' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;
					<object id=l1_v_CSTR_EVAL_FEE2 classid=<%=HDConstant.CT_EMEDIT_CLSID%> class="hidden" style= "position:relative;left:0px;top:4px;width:200px; height:17px;">
						<param name=Text        value="">
						<param name=Alignment   value=2>
						<param name=Format      value="">
						<param name=Cursor      value="iBeam">
						<param name=Border      value="false">      
						<param name=InheritColor      value="true">                                                                                                                                                                                                             
						<param name=ReadOnly    value="true">
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>			                                
                    </object>
				</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허3</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l1_v_LIC_KIND3' id='l1_v_LIC_KIND3' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;
					<object id=l1_v_CSTR_EVAL_FEE3 classid=<%=HDConstant.CT_EMEDIT_CLSID%> class="hidden" style= "position:relative;left:0px;top:4px;width:200px; height:17px;">
						<param name=Text        value="">
						<param name=Alignment   value=2>
						<param name=Format      value="">
						<param name=Cursor      value="iBeam">
						<param name=Border      value="false">      
						<param name=InheritColor      value="true">                                                                                                                                                                                                             
						<param name=ReadOnly    value="true">
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>			                                
                    </object>
	  	  		</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. 입찰 및 공사 실적</td>
	  </tr>
	  <tr>
	  	<td style="padding-left:20px">1) 입찰</td>
	  </tr>	  
	  <tr>
	  	<td align="right" style="padding-right:10px">(단위:천원, 부가세 별도)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_1_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- 총괄/입찰 -->
				<param name="DataID"            value="ds_1_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='순'			ID={CurRow} 		width=30	align=right </F> 
					<C> name='입찰일자'		ID='bid_day'    	width=96 	align=CENTER	Edit=None mask='XXXX-XX-XX' </C>
					<C> name='현장명'		ID='site_nm' 		width=116 	align=CENTER	Edit=None </C>
					<C> name='공종'			ID='ct_kind'		width=116	align=center 	Edit=None </C>
					<C> name='예산(천원)'	ID='act_amt'    	width=116	align=right 	edit=none decao=0 </C>
					<C> name='입찰가(천원)'	ID='bid_amt'    	width=116 	align=right 	edit=none decao=0 </C>
					<C> name='예산(%)'		ID='bid_amt_pct2'	width=96 	align=right 	edit=none decao=1 </C>
					<C> name='결과'			ID='RESULT_CP' 		width=66 	align=CENTER	edit=none </C>
					<C> name='순위' 		ID='SEQ'    		width=50 	align=CENTER	 </C>
					<C> name='bid' 			ID='BID_SID'   		width=40 	align=CENTER	edit=none show=false </C>					
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:20px">2) 계약</td>
	  </tr>	  
	  <tr>
	  	<td align="right" style="padding-right:10px">(단위:천원, 부가세 별도)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_1_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- 총괄/계약 -->
				<param name="DataID"            value="ds_1_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="true">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='순'			ID={CurRow} 		width=30	align=right </F> 
					<C> name='계약일자'		ID='bid_day'    	width=96 	align=CENTER	Edit=None mask='XXXX-XX-XX' </C>
					<C> name='현장명'		ID='site_nm' 		width=116 	align=CENTER	Edit=None </C>
					<C> name='공종'			ID='ct_kind'		width=116	align=center 	Edit=None </C>
					<C> name='계약금액'		ID='act_amt'    	width=116	align=right 	edit=none decao=0 </C>
					<C> name='공사기간'		ID='bid_amt'    	width=160 	align=right 	edit=none </C>
					<C> name='비고'			ID='bid_amt_pct2'	width=168 	align=right 	edit=none </C>
					<C> name='bid' 			ID='BID_SID'   		width=40 	align=CENTER	edit=none show=false </C>					
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:10px">3. 신용 등급 및 현금흐름 등급</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">	
		<table style="border:0 solid #708090; width:823px" cellpadding="0" cellspacing="0">
		  <tr>
			<td>
                <object id="gr_1_3" classid=<%=HDConstant.CT_GRID_CLSID%> width='400px' height='90px' border='1'>
                    <param name="DataID"            value="ds_1_3">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='년도' 		ID='bp_yymm'   		width=120 	align=CENTER	show=true </C>
                         <C> name='신용등급'	ID='credit_grd'    	width=80 	align=CENTER	editstyle=lookup Data='ds_credit_grd:detail:detail_nm'</C>
                         <C> name='bp_sid' 		ID='bp_sid'   		width=60 	align=CENTER	edit=none show=false </C>
                 ">
                </object>   
			</td>
			<td>
            <td valign="top"  width="160px">
                <object id="gr_1_4" classid=<%=HDConstant.CT_GRID_CLSID%> width='400px' height='90px' border='1'>
                    <param name="DataID"            value="ds_1_4">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='년도' 		ID='bp_yymm'   		width=120 	align=CENTER	show=true </C>
                         <C> name='현금흐름'	ID='cashflow_grd'	width=80 	align=CENTER	editstyle=lookup Data='ds_cashflow_grd:detail:detail_nm'</C>
                         <C> name='bp_sid' 		ID='bp_sid'   		width=60 	align=CENTER	edit=none show=false </C>
                 ">
                </object>
			</td>   
		  </tr>
		</table>
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:10px">4. 기타 (채무불이행 정보 등)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px"></td>
	  </tr>
	</table>
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_1_0">
	             <param name=BindInfo    value="
					<C>Col=bp_nm	    Ctrl=l1_v_bp_nm				Param=Value </C>
					<C>Col=exc_man	    Ctrl=l1_v_exc_man			Param=Value </C>
					<C>Col=in_cstr_kind_nm	Ctrl=l1_v_in_cstr_kind_nm	Param=Value </C>
					<C>Col=loc_place    Ctrl=l1_v_loc_place			Param=Value </C>
					<C>Col=lic1			Ctrl=l1_v_LIC_KIND1			Param=Value </C>
					<C>Col=fee1			Ctrl=l1_v_CSTR_EVAL_FEE1	Param=text </C>
					<C>Col=lic2			Ctrl=l1_v_LIC_KIND2			Param=Value </C>
					<C>Col=fee2			Ctrl=l1_v_CSTR_EVAL_FEE2	Param=text </C>
					<C>Col=lic3      	Ctrl=l1_v_LIC_KIND3			Param=Value </C>
					<C>Col=fee3			Ctrl=l1_v_CSTR_EVAL_FEE3	Param=text </C>
	              ">
	      </object>
	<br>
</div>


<!---------[TAB 2] 기업개요 ----------->
<div id="layer2" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 개요</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="136px" bgcolor="#eeeeee">협력사명</td>
	  	  		<td class="tab21" width="273px">&nbsp;<input type="text" name='l2_v_bp_nm' id='l2_v_bp_nm' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" width="136px" bgcolor="#eeeeee">대표자</td>
	  	  		<td class="tab22" width="273px">&nbsp;<input type="text" name='l2_v_exc_man' id='l2_v_exc_man' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">사업자번호</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l2_v_in_cstr_kind' id='l2_v_in_cstr_kind' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">법인번호</td>
	  	  		<td class="tab22">&nbsp;<input type="text" name='l2_v_loc_place' id='l2_v_loc_place' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">설립일자</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l2_v_LIC_KIND1' id='l2_v_LIC_KIND1' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">종업원수</td>
	  	  		<td class="tab22">&nbsp;	
				</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">주소</td>
	  	  		<td class="tab22" colspan="3">&nbsp;</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. 경영현황</td>
	  </tr>
	  <tr>
	  	<td style="padding-left:20px">1) 대표자</td>
	  </tr>	  
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="136px" bgcolor="#eeeeee">성명</td>
	  	  		<td class="tab21" width="273px">&nbsp;<input type="text" name='l2_v_bp_nm' id='l2_v_bp_nm' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" width="136px" bgcolor="#eeeeee">생년월일</td>
	  	  		<td class="tab22" width="273px">&nbsp;<input type="text" name='l2_v_exc_man' id='l2_v_exc_man' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">주  소</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l2_v_in_cstr_kind' id='l2_v_in_cstr_kind' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">최종 출신교</td>
	  	  		<td class="tab22">&nbsp;<input type="text" name='l2_v_loc_place' id='l2_v_loc_place' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">주요경력</td>
	  	  		<td class="tab22" colspan="3"><br><br><br>&nbsp;</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:20px">2) 주주구성</td>
	  </tr>	  
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_2_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- -->
				<param name="DataID"            value="ds_2_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='순'						ID={CurRow} 		width=30	align=right </F> 
					<C> name='주주명'					ID='bid_day'    	width=250 	align=CENTER	Edit=None </C>
					<C> name='경영 실천자와의 관계'		ID='site_nm' 		width=250 	align=CENTER	Edit=None </C>
					<C> name='소유주식 비율(%)'			ID='ct_kind'		width=250	align=center 	Edit=None </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 3] 면허 및 시공능력 ----------->
<div id="layer3" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 보유 면허</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(단위:천원)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_3_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- -->
				<param name="DataID"            value="ds_3_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='순'				ID={CurRow} 		width=30	align=right </F> 
					<C> name='면허명'			ID='bid_day'    	width=200 	align=CENTER	Edit=None </C>
					<C> name='면허번호'			ID='site_nm' 		width=180 	align=CENTER	Edit=None </C>
					<C> name='면허 등록일시'	ID='ct_kind'		width=180	align=center 	Edit=None </C>
					<C> name='시평액'			ID='ct_kind'		width=200	align=center 	Edit=None </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 보유 면허</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(단위:천원)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_3_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- -->
				<param name="DataID"            value="ds_3_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='순'				ID={CurRow} 		width=30	align=right </F>
					<C> name='기준연도'			ID='bid_day'    	width=100 	align=CENTER	Edit=None </C>
					<C> name='면허명'			ID='site_nm' 		width=150 	align=CENTER	Edit=None </C>
					<C> name='시평액'			ID='ct_kind'		width=100	align=center 	Edit=None </C>
				  <G> name='지역순위'
					<C> name='순위'				ID='ct_kind'		width=70	align=center 	Edit=None </C>
					<C> name='업체명'			ID='ct_kind'		width=140	align=center 	Edit=None </C>
				  </g>
				  <G> name='전국순위'
					<C> name='순위'				ID='ct_kind'		width=70	align=center 	Edit=None </C>
					<C> name='업체명'			ID='ct_kind'		width=140	align=center 	Edit=None </C>
				  </g>

				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">3. 건설공사 실적 현황</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(단위:천원)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_3_3 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- -->
				<param name="DataID"            value="ds_3_3">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='순'				ID={CurRow} 		width=30	align=right </F> 
					<C> name='기준연도'			ID='bid_day'    	width=100 	align=CENTER	Edit=None </C>
					<C> name='면허명'			ID='site_nm' 		width=150 	align=CENTER	Edit=None </C>
				  <G> name='계약액'
					<C> name='건수'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='금액'			ID='ct_kind'		width=180	align=center 	Edit=None </C>
				  </g>
				  <G> name='기성액'
					<C> name='건수'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='금액'			ID='ct_kind'		width=180	align=center 	Edit=None </C>
				  </g>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 4] 실적(당사)----------->
<div id="layer4" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 입찰 참여 현황</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(단위:천원)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">
			<object id=gr_4_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='140px' border='1'><!-- 총괄/입찰 -->
				<param name="DataID"            value="ds_4_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name=SortView  			value="Right">
				<param name="Format"            value="
					<C> name='입찰일자' 	ID='BID_DAY'    	width=80 	align=CENTER	Edit=None suppress=1 sort=true</C>
					<C> name='구분'			ID='CT_GUBN' 		width=40 	align=CENTER	Edit=None suppress=2 sumtext='총'  sumtextalign='right'</C>
					<C> name='현장명'		ID='SITE_NM'       	width=120 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'	sort=true</C>
					<C> name='공종'  		ID='CT_KIND'      	width=60 	align=left 		Edit=None suppress=4 sumtext='건' sumtextalign='left' 		sort=true</C>
					<C> name='업체명'		ID='COOP_NM'		width=80	align=left 		Edit=None sort=true</C>
					<C> name='예산'    	    ID='ACT_AMT'   		width=80 	align=right 	Edit=None suppress=5 decao=0	sort=true</C>
					<C> name='예가'    	    ID='ACT_AMT_HA'   	width=60 	align=right 	Edit=None suppress=6 decao=0	sort=true</C>
					<C> name='입찰금액'		ID='BID_AMT'    	width=80 	align=right 	Edit=None decao=0	sort=true</C>
					<C> name='예산(%)'		ID='BID_AMT_PCT2'	width=50 	align=right 	Edit=None dec=1	</C>
					<C> name='예가(%)'		ID='BID_AMT_PCT1'	width=50 	align=right 	Edit=None dec=1</C>
					<C> name='순위'			ID='SEQ'	 	    width=60 	align=center	Edit=None sort=true</C>
					<C> name='업체수'		ID='COOP_CNT' 	    width=40 	align=center	Edit=None</C>
					<C> name='결과'   		ID='RESULT_CP'		width=60 	align=CENTER	Edit=None sort=true</C>
					<C> name='추천부서'		ID='RECO_DEPT'      width=70 	align=left 		Edit=None sort=true</C>
					<C> name='비고'   		ID='REMARK'         width=160 	align=LEFT		Edit=None</C>
				">       
			</object> 	   		
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. 계약 현황</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">(단위:천원, 부가세 별도)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_4_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='140px' border='1'>
				<param name="DataID"            value="ds_4_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name=SortView  			value="Right">
				<param name="Format"            value="
					<C> name='구분'			ID='CT_GUBN' 		width=40 	align=CENTER	Edit=None suppress=2 sumtext='총'  sumtextalign='right'</C>
					<C> name='차수'			ID='site_nm' 		width=50 	align=CENTER	Edit=None </C>
					<C> name='현장명'		ID='SITE_NM'       	width=160 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right' sort=true</C>
					<C> name='공종'			ID='ct_kind'		width=110	align=center 	Edit=None </C>
					<C> name='계약금액'		ID='act_amt'    	width=116	align=right 	edit=none decao=0 sort=true</C>
					<C> name='공사기간'		ID='bid_amt'    	width=146 	align=right 	edit=none decao=0 sort=true</C>
					<C> name='비고'   		ID='REMARK'         width=180 	align=LEFT		Edit=None</C>
				">       
			</object> 	  	
 
		</td>
	  </tr>
	</table>
<br>
</div>

<!---------[TAB 5] 실적(타사)----------->
<div id="layer5" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 실적</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(단위:천원)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_5_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='220px' border='1'><!-- -->
				<param name="DataID"            value="ds_5_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='순'				ID={CurRow} 		width=30	align=right </F> 
					<C> name='면허명'			ID='site_nm' 		width=100 	align=CENTER	Edit=None </C>
					<C> name='지역'				ID='bid_day'    	width=60 	align=CENTER	Edit=None </C>
					<C> name='공사명'			ID='SITE_NM'       	width=160 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right' sort=true</C>
					<C> name='발주자'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='원청사'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='당년도\\계약액'	ID='ct_kind'		width=100	align=center 	Edit=None </C>
					<C> name='당년도\\기성액'	ID='ct_kind'		width=100	align=center 	Edit=None </C>
					<C> name='준공년도'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 6] 매출/매입처----------->
<div id="layer6" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 개요</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_6_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='220px' border='1'><!-- -->
				<param name="DataID"            value="ds_6_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='업체명'		ID='site_nm' 		width=160 	align=CENTER	Edit=None </C>
					<C> name='대표이사'		ID='bid_day'    	width=100 	align=CENTER	Edit=None </C>
					<C> name='거래품목'		ID='SITE_NM'       	width=160 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right' sort=true</C>
					<C> name='비중(%)'		ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='비고'			ID='ct_kind'		width=280	align=center 	Edit=None </C>
				">
			</object>
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. 입찰 및 공사 실적</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_6_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='290px' border='1'><!-- -->
				<param name="DataID"            value="ds_6_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='업체명'		ID='site_nm' 		width=160 	align=CENTER	Edit=None </C>
					<C> name='대표이사'		ID='bid_day'    	width=100 	align=CENTER	Edit=None </C>
					<C> name='거래품목'		ID='SITE_NM'       	width=160 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right' sort=true</C>
					<C> name='비중(%)'		ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='비고'			ID='ct_kind'		width=280	align=center 	Edit=None </C>
				">
			</object>
		</td>
	  </tr>	  
	</table>
	<br>
</div>

<!---------[TAB 7] 채무불이행----------->
<div id="layer7" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 채무불이행</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(단위:천원)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_7_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- 총괄/입찰 -->
				<param name="DataID"            value="ds_7_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='구분'			ID='bid_day'    	width=396 	align=CENTER	Edit=None </C>
					<C> name='건수'			ID='site_nm' 		width=106 	align=CENTER	Edit=None </C>
					<C> name='금액'			ID='act_amt'    	width=126	align=right 	edit=none decao=0 </C>
					<C> name='최종수정일'	ID='bid_amt'    	width=166 	align=right 	edit=none decao=0 </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. 행정처분</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_7_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- 총괄/입찰 -->
				<param name="DataID"            value="ds_7_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='구분'			ID='bid_day'    	width=201 	align=CENTER	Edit=None </C>
					<C> name='건수'			ID='site_nm' 		width=100 	align=CENTER	Edit=None </C>
					<C> name='내용'			ID='bid_amt'    	width=500 	align=right 	edit=none decao=0 </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:10px">3. 소송정보</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_7_3 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- 총괄/입찰 -->
				<param name="DataID"            value="ds_7_3">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='구분'			ID='bid_day'    	width=201 	align=CENTER	Edit=None </C>
					<C> name='건수'			ID='site_nm' 		width=100 	align=CENTER	Edit=None </C>
					<C> name='내용'			ID='bid_amt'    	width=500 	align=right 	edit=none decao=0 </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 8] 재무제표----------->
<div id="layer8" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 요약 대차대조표</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_8_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='390px' border='1'><!-- 총괄/입찰 -->
				<param name="DataID"            value="ds_8_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='과목'			ID='bid_day'    	width=320 	align=CENTER	Edit=None </C>
				  <G> name='금액(백만원)'
					<C> name='2011'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='2012'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='2013'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
				  </g>
				  <G> name='구성비(%)'
					<C> name='2011'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='2012'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='2013'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
				  </g>
				">       
			</object> 	  	
		</td>
	  </tr>
	  
	</table>
	<br>
</div>

<!---------[TAB 9] 신용등급 ----------->
<div id="layer9" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 개요</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_9_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='190px' border='1'><!-- 총괄/입찰 -->
				<param name="DataID"            value="ds_9_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='결산기준일'		ID='bid_day'    	width=160 	align=CENTER	Edit=None </C>
					<C> name='신용등급'			ID='ct_kind'		width=160	align=center 	Edit=None </C>
					<C> name='현금흐름등급'		ID='ct_kind'		width=160	align=center 	Edit=None </C>
					<C> name='등급평가일'		ID='ct_kind'		width=160	align=center 	Edit=None </C>
					<C> name='유효기간'			ID='ct_kind'		width=160	align=center 	Edit=None </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 10] 신용평가보고서----------->
<div id="layer10" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. 개요</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="50%">이크레더블</td>
	  	  		<td class="tab11" width="50%">나이스디앤비</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	</table>
	<br>
</div>

			
			
			
			</td>
        </tr>        
    </table>

	
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		