<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	 : 홈>공사관리>거래처 관리>협력회사 관리>협력회사 조회
 * 프로그램ID 	 : PMS/BC010S
 * J  S  P		 : bc010s_h1.jsp
 * 서 블 릿		 : Bc010S
 * 작 성 자		 : 심동현
 * [ 수정일자 ][수정자] 내용
 * [2014-04-16][심동현] 1 협력회사의 총괄정보 VIEW 페이지 
 *****************************************************************************/

%>
<%@ page import="pms.common.HDConstant"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();

	// 협력사 sid
	String v_bp_sid = request.getParameter("i");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <title>협력회사 정보보기</title>
        <jsp:include page="/Pms/common/include/head.jsp"/>

<script language="javascript">
	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		cfStyleGrid(getObjectFirst("gr_1_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_2"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_3"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_4"), "comn");
		
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

        fnSelectLayer1();
    }
    
    <%// 협력사 총괄 조회%>
    function fnSelectLayer1() {
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_bp_sid=<%=v_bp_sid%>";
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010S",
            "JSP(O:DS_1_0=ds_1_0,O:DS_1_1=ds_1_1,O:DS_1_2=ds_1_2,O:DS_1_3=ds_1_3,O:DS_1_4=ds_1_4)",
            v_param);
        tr_post(tr1);
    }
    

    function fnClose() {
        window.close();
    }    
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
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
</head>
    
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

   
    <table border="0" cellpadding="0" cellspacing="0" width="845px"> 
        <tr>
            <td height='30px' align='right' style="padding-right:11px">
				<img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:pointer;" onClick="fnClose()">
            </td>
        </tr>
	  <tr >
	  	<td style="padding-top:4px; padding-left:11px">1. 개요</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(단위:천원)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="136px" bgcolor="#eeeeee">협력사명</td>
	  	  		<td class="tab21" width="273px">&nbsp;<input type="text" name='l1_v_bp_nm' id='l1_v_bp_nm' style="width:220px;" class='hidden' readOnly="readonly"></td>
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
			<object id=gr_1_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='120px' border='1'><!-- 총괄/입찰 -->
				<param name="DataID"            value="ds_1_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='순'			ID={CurRow} 		width=30	align=right </F> 
					<C> name='입찰일자'		ID='bid_day'    	width=96 	align=CENTER	Edit=None mask='XXXX-XX-XX' </C>
					<C> name='현장명'		ID='site_nm' 		width=184 	align=left		Edit=None </C>
					<C> name='공종'			ID='ct_kind'		width=116	align=center 	Edit=None </C>
					<C> name='예산(천원)'	ID='act_amt'    	width=90	align=right 	edit=none decao=0 </C>
					<C> name='입찰가(천원)'	ID='bid_amt'    	width=90 	align=right 	edit=none decao=0 </C>
					<C> name='예산(%)'		ID='bid_amt_pct2'	width=80 	align=right 	edit=none decao=1 </C>
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
			<object id=gr_1_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='120px' border='1'><!-- 총괄/계약 -->
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
                    <param name="Editable"          value="false">
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
			<td>
            <td valign="top"  width="160px">
                <object id="gr_1_4" classid=<%=HDConstant.CT_GRID_CLSID%> width='400px' height='90px' border='1'>
                    <param name="DataID"            value="ds_1_4">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="false">
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

			
			
			
			</td>
        </tr>        
    </table>

	
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
</body>
<!-- BODY END -->
</html>