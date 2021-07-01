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
 * [2014-04-16][심동현] 페이지 스타일을 변경
 *						하단 탭을 제외하고 목록 형식에서 더블클릭 → 총괄페이지 띄우기~?
 *	샘플 : 주조 sid=23
 * [2014-04-29][심동현] 협력사 통계 추가
 * [2014-05-02][심동현] 만료일자 추가, 오늘날짜랑 비교??
 * [2014-06-05][심동현] 미평가거나 유효하지 않은 애들만 검색조건 추가
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
	
	//오늘 날짜 추가
	String v_todate = DateUtil.getCurrentDate(8);
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
        
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_bp_sid="+ v_bp_sid.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010S",
            "JSP(O:DS_CNT=ds_cnt)",
            param);
           
        tr_post(tr1);        
    
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";    	
        var in_yn = "N";	//협력회사 등록유무
        var yet_only_yn = "N";	//미등록 회사만 선택 유무

    	if(v_in_yn.checked){
    		in_yn="Y";	//등록된 것만
    	}
    	if(v_yet_only_yn.checked){
    		yet_only_yn="Y";	//미등록 상태인 회사만
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
			+ ",v_in_yn=" + in_yn
			+ ",v_yet_only_yn=" + yet_only_yn;

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
    

    //이크레더블 인증서보기
    function showEcreCert(u, p, i, k, c,Row) {
        if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
		
    	//alert(getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO"));
        var link ='http://www.esrm.co.kr/esrm/SrmplusLogin?u='+ u +'&p='+ p +'&i='+ getObjectFirst("ds_default").NameValue(Row, "BIZREGI_NO") +'&k='+ k +'&c=7&m=3&g=2';
        var features ='height=768, width=1024, status=no, scrollbars=auto, resizable=yes';
        window.open(link, 'watchwin', features); 
    } 
  	//나이스디앤비 인증서보기
    function showNiceCert(Row) {
        if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        var link ='http://clip.nice.co.kr/rep_nclip/rep_DLink/rep_Link_hdasan2.jsp?bz_ins_no='+ getObjectFirst("ds_default").NameValue(Row, "BIZREGI_NO") +'&';
		var width = 830;
		var height = 700;
		posx = (screen.width - width) / 2 - 1;
		posy = (screen.height - height) / 2 - 1;
        var features ='toolbar=no,location=no,locationbar=no,personalbar=no,directories=no,status=no,statusbar=no,menubar=no,titlebar=no,scrollbars=yes,resizable=no,menu=no,width=' + width + ',height=' + height + ',left=' + posx + ',top=' + posy;
        window.open(link, 'nicewin', features); 
        
  	}
  	
    //협력사 총괄 정보 보기
    function showBPDetail(Row) {
        if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
		
    	//alert(getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO"));
        var link ='bc010s_h1.jsp?i='+ getObjectFirst("ds_default").NameValue(Row, "BP_SID") +'&';
        var features ='height=768, width=900, status=yes, scrollbars=auto, resizable=yes';
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

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//협력회사 클릭시 레이어1 조회 %>
	<script language=javascript for="gr_default" event="OnDblClick(Row, Colid)">
		v_job="SD";
		
	    if(Row==0){
	    	return;
		}else{
			if(Colid=="ECRE_YN"){
				showEcreCert('<%=u%>','<%=p%>','<%=i%>','<%=k%>','3',Row);
			}else if(Colid=="NICEDNB_YN"){
				showNiceCert(Row);
			}else{
				showBPDetail(Row);
			}		
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
<object id=ds_cnt classid=<%=HDConstant.CT_DATASET_CLSID%>> 
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




<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
            <td>
                <table border='0' cellpadding="0" cellspacing="0" WIDTH="1045px">
                    <tr>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='820px'>
                    			<tr>
                                    <td width="70" align="center" class="text">협력사명</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='v_bp_nm' id='v_bp_nm' style="width:160px;" class='input01' onkeydown="if(event.keyCode==113) fnSelCoopPopup('<%=dirPath%>');" readOnly="readonly" value="">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelBpCleanup();" alt="값 지우기">
                                        <input type="hidden" name='v_bp_sid' id='v_bp_sid'  style="width:40px;" class='input01' readOnly value="">
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
			                        <td align="left" bgcolor="#ffffff" >&nbsp;<input type="checkbox" name="v_in_yn" id="v_in_yn">
			                        &nbsp;
			                        무효&nbsp;<input type="checkbox" name="v_yet_only_yn" id="v_yet_only_yn">
			                        
			                        </td>

			             		</tr>
			           		</table>
			           	</td>
			           	<TD WIDTH="10"></TD>
                    	<td ALIGN="RIGHT">
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" WIDTH="200">
                    			<tr>
                                    <td width="50" align="center" class="text">전체</td>
                                    <td width="50"  bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_all' id='c_all' style="width:40px;text-align:right;" class='hidden' readOnly="readonly"></td>
									<td width="50" align="center" class="text">양쪽</td>
                                    <td width="50"  bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_both' id='c_both' style="width:40px;text-align:right;" class='hidden' readOnly="readonly"></td>                                    
								</tr>
                    			<tr>
                                    <td align="center" class="text" rowspan="2"><b>미등록</b></td>
                                    <td rowspan="2" bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_none' id='c_none' style="width:40px;text-align:right;font-weight:bold;" class='hidden' readOnly="readonly"></td>
									<td align="center" class="text">Ecre</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_ecre' id='c_ecre' style="width:40px;text-align:right;" class='hidden' readOnly="readonly"></td>                                    
								</tr>
                    			<tr>
									<td align="center" class="text">Nice</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_nice' id='c_nice' style="width:40px;text-align:right;" class='hidden' readOnly="readonly"></td>                                    
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
			  <table  border='0' cellpadding='0' cellspacing='0'>
				<tr>
				  <td valign='top'>

					<object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1165px' height='500px' border='1'>
						<param name="DataID"            value="ds_default">
						<param name="ColSizing"         value="true">
						<param name="Editable"          value="true">
						<param name="SuppressOption"    value="1">
						<param name="BorderStyle"       value="0">
						<param name="ViewSummary"       value="0">
						<param name=SortView  			value="Right">
						<param name="Format"            value="
                                 <C> name='순'				ID={CurRow} 		width=35	align=right </C> 
                                 <C> name='협력사코드'		ID='BP_CD'    		width=80 	align=CENTER	Edit=None </C>
                                 <C> name='협력사명'		ID='BP_NM' 			width=90 	align=left		Edit=None sort=true</C>
                                 <C> name='사업자등록번호'	ID='BIZREGI_NO'		width=100 	align=left 		Edit=None show=false </C>
                                 <C> name='소재지'  		ID='LOC_PLACE'      width=44 	align=center 	Edit=None editstyle=lookup data='ds_loc_place:detail:detail_nm'</C>
                                 <C> name='등록공종'		ID='IN_CSTR_KIND'	width=70	align=center 	Edit=None editstyle=lookup data='ds_in_cstr_kind:detail:detail_nm'</C>
								<G> name='보유면허①'
                                 <C> name='면허'			ID='LIC_KIND1'   	width=80 	align=left	 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE1'	width=70 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='보유면허②'
                                 <C> name='면허'			ID='LIC_KIND2'   	width=80 	align=left  	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE2'	width=70 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='보유면허③'
                                 <C> name='면허'			ID='LIC_KIND3'   	width=70 	align=left  	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='시평액'    	    ID='CSTR_EVAL_FEE3'	width=60 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='신평사'
								 <C> name='Ecre'		ID='ECRE_YN'   		width=40 	align=center 	Edit=None bgColor={IF(ECRE_YN='Y','#FFFF00','#FFFFFF')} </C>
								 <C> name='Nice'		ID='NICEDNB_YN'  	width=40 	align=center 	Edit=None bgColor={IF(NICEDNB_YN='Y','#FFFF00','#FFFFFF')} </C>
								</G>
								<G> name='만료일자'
								 <C> name='Ecre'		ID='EXP_DATE_ECRE'  width=60 	align=center 	Edit=None bgColor={IF(ECRE_YN='Y',IF(EXP_DATE_ECRE<'<%=v_todate%>','#ffcccc','#99ff66'),'#FFFFFF') } </C> 
								 <C> name='Nice'		ID='EXP_DATE_NICE' 	width=60 	align=center 	Edit=None bgColor={IF(NICEDNB_YN='Y',IF(EXP_DATE_NICE<'<%=v_todate%>','#ffcccc','#99ff66'),'#FFFFFF') } </C>
								</G>
								<G> name='신용등급'
								 <C> name='Ecre'		ID='CREDIT_GRD_E'   width=40 	align=center 	Edit=None editstyle=lookup data='ds_credit_grd:detail:detail_nm'</C>
								 <C> name='Nice'		ID='CREDIT_GRD_N'  	width=40 	align=center 	Edit=None editstyle=lookup data='ds_credit_grd:detail:detail_nm'</C>
								</G>
								<G> name='현금흐름'
								 <C> name='Ecre'		ID='CASHFLOW_GRD_E'   	width=40 	align=center 	Edit=None editstyle=lookup data='ds_cashflow_grd:detail:detail_nm'</C>
								 <C> name='Nice'		ID='CASHFLOW_GRD_N'  	width=40 	align=center 	Edit=None editstyle=lookup data='ds_cashflow_grd:detail:detail_nm'</C>
								</G>
								 <C> name='등록\\유무'		ID='IN_YN'	 	 	width=40 	align=center 	Edit=None bgColor={IF(IN_YN='Y','#FFFF00','#FFFFFF')} </C>
                         ">                             
                        </object>   
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
			<td><br>※ GRID를 더블클릭하면 협력사 총괄정보 창이 팝업됩니다.<BR>
			　 신평사 Ecre, Nice 컬럼에서 노랑색 Y를 더블클릭함현 신용평가사 제공 창이 팝업됩니다.
			</td>
        </tr>
    </table>

<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
<object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	<param name="DataId" value="ds_cnt">
	<param name=BindInfo    value="
		<C>Col=c_all	Ctrl=c_all	Param=Value </C>
		<C>Col=c_both	Ctrl=c_both	Param=Value </C>
		<C>Col=c_nice	Ctrl=c_nice	Param=Value </C>
		<C>Col=c_ecre	Ctrl=c_ecre	Param=Value </C>
		<C>Col=c_none	Ctrl=c_none	Param=Value </C>
	">
</object>
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		