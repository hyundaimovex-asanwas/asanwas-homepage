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
 * [2013-12-03][심동현] 백업버전
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
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
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
    
    
    
    <%//메인 조회 pr_rv200s_01_plz 호출 %>
    function fnSelect() {
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
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
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
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
        window.status="조회가 완료 되었습니다.";
        
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_in_cstr_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  등록공종 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_lic_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  보유면허 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_loc_place classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  소재지 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_credit_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  신용등급 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_cashflow_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  현금흐름 -->
    <param name="SyncLoad"  value="True">
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='v_bp_nm' id='v_bp_nm' style="width:160px;" class='input01' onkeydown="if(event.keyCode==113) fnSelCoopPopup('<%=dirPath%>');" readOnly="readonly">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelBpCleanup();" alt="값 지우기">
                                        <input type="hidden" name='v_bp_sid' id='v_bp_sid'  style="width:40px;" class='input01' readOnly>
                                    </td>
			                        <td width="70" align="left" class="text">등록공종</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=lc_in_cstr_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_in_cstr_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
			                        <td width="70" align="left" class="text">보유면허</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=lc_lic_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
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
			                            </object>&nbsp;천원&nbsp;~&nbsp;
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
			                            </object>&nbsp;천원
			                                                                                                         
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
                            <param name="Format"            value="
                                 <F> name='순'				ID={CurRow} 		width=30	align=right </F> 
                                 <C> name='협력사코드'		ID='BP_CD'    		width=80 	align=CENTER	Edit=None </C>
                                 <C> name='협력사명'		ID='BP_NM' 			width=100 	align=CENTER	Edit=None </C>
                                 <C> name='사업자등록번호'	ID='BIZREGI_NO'		width=100 	align=left 		Edit=None </C>
                                 <C> name='소재지'  		ID='LOC_PLACE'      width=60 	align=center 	Edit=None editstyle=lookup data='ds_loc_place:detail:detail_nm'</C>
                                 <C> name='등록공종'		ID='IN_CSTR_KIND'	width=80	align=center 	Edit=None editstyle=lookup data='ds_in_cstr_kind:detail:detail_nm'</C>
								<G> name='보유면허①'
                                 <C> name='면허'			ID='LIC_KIND1'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE1'	width=80 	align=right 	Edit=None decao=0</C>
								</G>
								<G> name='보유면허②'
                                 <C> name='면허'			ID='LIC_KIND2'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE2'	width=80 	align=right 	Edit=None decao=0</C>
								</G>
								<G> name='보유면허③'
                                 <C> name='면허'			ID='LIC_KIND3'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE3'	width=80 	align=right 	Edit=None decao=0</C>
								</G>
								 <C> name='신용등급'		ID='CREDIT_GRD'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_credit_grd:detail:detail_nm'</C>
								 <C> name='현금흐름'		ID='CASHFLOW_GRD'  	width=80 	align=center 	Edit=None editstyle=lookup data='ds_cashflow_grd:detail:detail_nm'</C>
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
					<T>divid=layer9 title='신용등급'</T>
					<T>divid=layer10  title='신용평가보고서'</T>

				">
			</OBJECT>
			
			

<!---------[TAB 1] left:200px; 총괄 ----------->
<div id="layer1" style="border:1 solid #333333; position:;">
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
	  	  		<td class="tab21" width="273px">&nbsp;</td>
				<td class="tab11" width="136px" bgcolor="#eeeeee">대표자</td>
	  	  		<td class="tab22" width="273px">&nbsp;</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">등록공종</td>
	  	  		<td class="tab21" >&nbsp;</td>
				<td class="tab11" bgcolor="#eeeeee">소재지</td>
	  	  		<td class="tab22">&nbsp;</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허1</td>
	  	  		<td class="tab21" >&nbsp;</td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허2</td>
	  	  		<td class="tab21" >&nbsp;</td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허3</td>
	  	  		<td class="tab21" >&nbsp;</td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;</td>
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
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="116px" bgcolor="#eeeeee">입찰일자</td>
				<td class="tab11" width="116px" bgcolor="#eeeeee">현장명</td>
	  	  		<td class="tab11" width="116px" bgcolor="#eeeeee">공종</td>
	  	  		<td class="tab11" width="116px" bgcolor="#eeeeee">예산</td>
	  	  		<td class="tab11" width="116px" bgcolor="#eeeeee">입찰금액</td>
	  	  		<td class="tab11" width="116px" bgcolor="#eeeeee">%</td>
	  	  		<td class="tab11" width="116px" bgcolor="#eeeeee">낙찰유무</td>
	  		</tr>
			<tr>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  		</tr>
		</table>
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
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="116px" bgcolor="#eeeeee">계약일자</td>
				<td class="tab11" width="116px" bgcolor="#eeeeee">현장명</td>
	  	  		<td class="tab11" width="116px" bgcolor="#eeeeee">공종</td>
	  	  		<td class="tab11" width="116px" bgcolor="#eeeeee">계약금액</td>
	  	  		<td class="tab11" width="116px" bgcolor="#eeeeee">공사기간</td>
	  	  		<td class="tab11" width="233px" bgcolor="#eeeeee">비고</td>
	  		</tr>
			<tr>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  	  		<td class="tab21" >&nbsp;</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:10px">3. 신용등급</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="110px" bgcolor="#eeeeee">구분</td>
	  	  		<td class="tab21" width="310px">&nbsp;</td>
				<td class="tab11" width="110px" bgcolor="#eeeeee">대표자</td>
	  	  		<td class="tab22" width="310px">&nbsp;</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">등록공종</td>
	  	  		<td class="tab21" >&nbsp;</td>
				<td class="tab11" bgcolor="#eeeeee">소재지</td>
	  	  		<td class="tab22">&nbsp;</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허1</td>
	  	  		<td class="tab21" >&nbsp;</td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허2</td>
	  	  		<td class="tab21" >&nbsp;</td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">보유면허3</td>
	  	  		<td class="tab21" >&nbsp;</td>
				<td class="tab11" bgcolor="#eeeeee">(시평액)</td>
	  	  		<td class="tab22">&nbsp;</td>
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
	
</div>


<!---------[TAB 1] left:200px;기본사항 ----------->
<div id="layer2" style="position:;">
	<table style="border:1 solid #708090; width:845px" cellpadding="0" cellspacing="0">
		<tr>
			<td class="tab11" width="72px" bgcolor="#eeeeee">우편번호</td>
  	  <td class="tab21" width="100px">
				<comment id="__NSID__"><OBJECT id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:5px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="000-000">
						<param name=Enable	      value="false">
						<param name=PromptChar	  value="_">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<img alt=우편번호조회  id='img_search1' name='img_search1' style="position:relative;left:7px;top:2px;cursor:pointer" src='../../Common/img/btn/com_b_search.gif'  onclick="ln_Popup('c')">
			</td>
			<td class="tab11" width="76px" bgcolor="#eeeeee">현주소</td>
  	  <td class="tab22">
				<input type="text" id=txt_caddr01 class="txt11" style="width:350px;" disabled>
			</td>
  	</tr>
		<tr>
			<td class="tab22" width="72px">&nbsp;</td>
  	  <td class="tab21" width="100px">&nbsp;</td>
			<td class="tab11" width="76px" bgcolor="#eeeeee">상세주소</td>
  	  <td class="tab22" width="436px">
				<input type="text" id=txt_caddr02 class="txt11" style="width:350px;" maxlength="70" onBlur="bytelength(this,this.value,70);">
			</td>
  	</tr>

		<tr>
			<td colspan="4">
				<table cellpadding=0 cellspacing=0 border=0>
					<tr>
					  <td class="tab11" width="76px" bgcolor="#eeeeee">연락처</td>
					  <td class="tab22">&nbsp;(TEL)</td>
						<td class="tab22"><input type="text" id=txt_telno class="txt11" style="width:70px;" maxlength="15" onBlur="bytelength(this,this.value,15);"></td>
						<td class="tab22">&nbsp;(사내)</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height=10></tr>
	</table>
	
	 <table style="border:1 solid #708090;border-top-width:0px;width:701px" cellpadding=0 cellspacing=0  border=0>
		<tr>
			<td class="tab11" width="76px" bgcolor="#eeeeee">기타사항</td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">취미</td>
			<td class="tab21" width="130px"><input type="text" id=txt_hobby class="txt11" style="width:100px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td>
			<td class="tab11" bgcolor="#eeeeee">보훈대상</td>
			<td class="tab21">
				<OBJECT id=gclx_mrtdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
						<param name=ComboDataID		value="gcds_mrtdiv">
						<param name=CBDataColumns	value="MINORCD, MINORNM">
						<param name=SearchColumn	value=MINORNM>
						<param name=Sort			value=false>
						<param name=ListExprFormat	value="MINORNM^0^100">
						<param name=BindColumn			value=MINORCD>
				</OBJECT>
			</td>
			<td class="tab11" bgcolor="#eeeeee">구분</td>
			<td class="tab22">
				<OBJECT id=gcra_hitchyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:4px;top:0px;height:20;width:120;cursor:pointer;">
					<param name=Cols     value="2">
	          		<param name=Format   value="Y^예,N^아니오">
        		</OBJECT>
			</td>
		</tr>
		<tr height=10px></tr>
	</table>
</div>




<!---------[TAB 2] 가족사항 그리드----------->
<div id="layer3" style="visibility:hidden; border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_2" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:pointer" onclick="ln_Delete('02')">
				<img name="btn_add_2" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:pointer" onclick="ln_Add('02')">
				<img name="btn_save_2" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:pointer" onclick="ln_Save('02')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:239">
		            <param name=dataid					value=gcds_data02>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=true>
						<param name=AllShowEdit     value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO				ID={CurRow}	HeadAlign=Center HeadBgColor=#B9D4DC Width=26,	align=right </F> 
						'>
			  	</OBJECT>
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>


			
			
			
			</td>
        </tr>        
    </table>

	
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		