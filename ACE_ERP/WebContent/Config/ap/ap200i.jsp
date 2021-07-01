<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 미결함 - 메뉴권한
 * 프로그램ID 	: ap200i
 * J  S  P		: ap200i
 * 서 블 릿		: Ap200I
 * 작 성 자		: 심동현
 * 작 성 일		: 2011-08-31
 * [ 수정일자 ][수정자] 내용
 * [2010-08-20][심동현] 최초 제작.
 * [2010-08-20][심동현] 최초 제작.
 *						서비스요청서 전자결재의 미결함 - 로긴 사용자가 결재할 차례인 문서를 조회
 *						그리드 행을 더블클릭하면 결재 상세 팝 ~ 팝의 상단부= 공통결재모듈, 중단은 결재문서의 정보
 *						 하단은 첨부파일 모듈(이 파일들의 저장경로랑 용량도 문제임)
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
		
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());		

		//쿠키불러오기 시작
		String v_login_name ="";
		String v_login_id = "";
		Cookie cookies[] = request.getCookies();
	     if(cookies != null) {
	          for(int i=0; i<cookies.length; i++){
	               if(cookies[i].getName().equals("vusrid") ) {
	                    v_login_id = cookies[i].getValue() ;	//=> cookie에서 값 추출할때 사용                             
	               }
	               if(cookies[i].getName().equals("vusrnm") ) {
	                    v_login_name = cookies[i].getValue() ;	//=> cookie에서 값 추출할때 사용                             
	               }
	          }
	     } 
		//쿠키불러오기 끝
%>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
		<script language="javascript">
		 var div='';
		// 페이지로딩
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
				
			fnInit();
		} 
		 
		function fnInit() {
			div = 'init';
			
			ds_doc_gu.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AP001&s_item1=Y";
            ds_doc_gu.Reset();	//결재 문서구분
			
		}
		
		// 메인 조회
		function fnSelect() {
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",v_empno="+ sNowEmpno.value
			          + ",v_fr_date=" + getObjectFirst("v_fr_input_date").Text
			          + ",v_to_date=" + getObjectFirst("v_to_input_date").Text
			          + ",v_doc_gu=" + v_doc_gu.ValueOfIndex("detail", v_doc_gu.Index)
			          + ",v_client_sid=" + sClientSid.value
			          + ",v_accept_no=" + getObjectFirst("v_accept_no").Text
						;
						
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_MY%>My400I",
			    "JSP(O:MASTER=ds1)",
			    param);
			   
			tr_post(tr1);
		}
			

		// 적용
		function fnApply() {
			if (ds1.isUpdated ){ 
		        v_job = "I";	
		         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
		
		         ln_TRSetting(tr1, 
		             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
		             "JSP(I:MASTER=ds1,O:msgDS=msgDS)",
		             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
		         tr_post(tr1);
	         }
		}


		/**
	     * 검색조건 대리점  팝업 
	     */
	    function fnSelectClientPopup(dirPath) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	        
	        arrResult = fnClientPop(dirPath,'');
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            sClientNm.value = arrParam[1];
	            sClientSid.value = arrParam[0];
	        } else {
	          sClientNm.value = "";
	          sClientSid.value = "";
	        }               
	    }   

		// 신청서 번호 조회
	    function fnAcceptNoPopup(){
	        v_cust_row = 0;
	        var arrResult   = new Array();
	        arrResult = fnAcceptNoPop("<%=dirPath%>");
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            getObjectFirst("v_accept_sid").value = arrParam[0];
	            getObjectFirst("v_accept_no").Text   = arrParam[1];
	            
	            //fnSelectBound();
	        }
	    }

</script>

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	</script>	
	

<%
/****************************************************************************
			가우스 컴포넌트 이벤트 스크립트
******************************************************************************/
%>
<script language=javascript for=gr1 event="OnDblClick(Row,Colid)">
    if(Row==0) return;
	var apURL ="../help/my400h.jsp?ap_m_sid="+ds1.namevalue(Row,"ap_m_sid");
   	window.open(apURL,"ap_doc_service","width=720,height=585,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
</script>
	
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>


<object id=ds_doc_gu classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  결제순번 -->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td style="padding-bottom:6px" align=right>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	onclick="fnSelect()">&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<table border='0' cellpadding='0' cellspacing='1' bgcolor='#666666' width=845>
							  <tr>
								<td align="center" width="70px" height="30px" class="text" >결재자</td>
								<td width=160 align="left"  bgcolor="#ffffff">&nbsp;
		                            <input type="text" name='sNowEmpnm' id='sNowEmpnm' value='<%=v_login_name%>' size='8' readonly='readonly'  class='boardt04'>
		                            <input type="text" name='sNowEmpno' id='sNowEmpno' value='<%=v_login_id%>' size='7' readonly='readonly'  class='boardt04'>
								</td>
								 <td width="70px" height="25px" class="text">등록일자</td>
	                             <td width=260 align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=v_fr_input_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
		                            </object>&nbsp;~&nbsp;
		                            <object id=v_to_input_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
		                            <%=HDConstant.COMMENT_END%> 
                                </td>
                                <td align=left class="text" width="60">문서구분</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_doc_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
                                    	<param name=ComboDataID     value=ds_doc_gu>
                                    	<param name=ListExprFormat  value="detail_nm^0^70">                                        
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
				              </tr>
							</table>
							<table border='0' cellpadding='0' cellspacing='1' bgcolor='#666666' width=845>
							  <tr>
								<td align="center" width="70px" height="30px" class="text" >대리점</td>
								<td width=160 align="left"  bgcolor="#ffffff">&nbsp;
		                            <input type="text" name='sClientNm' id='sClientNm' value='' size='16' readonly='readonly'  class='textbox'>
		                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
		                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
								</td>
								 <td width="70px" height="25px" class="text">신청서번호</td>
	                             <td width=160 align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
	                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
	                                        <param name=Format      value="00000000000000">
	                                        <param name=Alignment   value=1>
	                                        <param name=ClipMode    value=true>
	                                        <param name=Border      value=false>
	                                        <param name=SelectAll   value=true>
	                                        <param name=SelectAllOnClick      value=true>
	                                        <param name=SelectAllOnClickAny   value=false>
	                                    </object>
                                <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                              </td>

                              <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								<%=HDConstant.COMMENT_END%>
                              </td>

				            </tr>					              
						  </table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              <C> name='결재SID'    	ID='ap_m_sid'   	width=80	align=left editlimit=5 show=FALSE edit=none</C>
									  <C> name='문서구분'     	ID='doc_gu'       	width=60	align=center show=FALSE </C>
						              <C> name='문서구분'    	ID='doc_gu_nm'   	width=70 	align=center editlimit=50 show=true suppress=1 edit=none</C>
						              <C> name='문서번호'		ID='doc_no'   		width=100 	align=left editlimit=20 show=true edit=none</C>
						              <C> name='진행상태'    	ID='ap_status_m'   	width=60 	align=center editlimit=16 show=FALSE edit=none</C>
						              <C> name='진행상태'     	ID='ap_status_m_nm'	width=60 	align=center editlimit=30 show=true edit=none</C>
						              <G> name='최종결재자'
						              	<C> name='사번' 		ID='l_empno'     	width=60 	align=center editlimit=30 show=true edit=none</C>
						             	<C> name='성명'  	  	ID='l_empnm'   		width=60 	align=center editlimit=30 show=true edit=none</C>
									  </G>
						              <C> name='총 결재선'      ID='cnt_all_ap'     width=60 	align=center editlimit=50 show=false edit=none</C>
						              <C> name='미결 갯수'   	ID='cnt_not_ap'  	width=60 	align=center editlimit=61 show=false edit=none</C>
						              <G> name='기안자'
							          	<C> name='사번'  		ID='i_empno'    	width=60 	align=center editlimit=10 show=true edit=none</C>
							            <C> name='성명'     	ID='i_empnm'       	width=60 	align=center editlimit=10 show=true edit=none</C>
									  </G>
						              <C> name='기안일시' 		ID='i_date' 		width=80 	align=left editlimit=10 show=true edit=none</C>
						              <C> name='의견 수'    	ID='cnt_desc'   	width=50	align=center editlimit=14 show=true edit=none</C>
						              <C> name='대리점'     	ID='client_nm'		width=100 	align=left editlimit=30 show=true edit=none</C>
						              <C> name='신청서번호'    	ID='accept_no'		width=100 	align=center editlimit=30 show=true edit=none mask='XXXXX-XXXXXXXXX'</C>
						              <G> name='수정자'
							          	<C> name='사번'     	ID='u_empno'     	width=60 	align=center editlimit=10 show=false edit=none</C>
						              	<C> name='성명' 		ID='u_empnm' 		width=60 	align=center editlimit=12 show=false edit=none</C>
									  </G>
               					">
							</object>   
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>

			</td>
		</tr>

		<tr>
			<td>※ 미결함 : 자신이 결재할 문서가 조회됩니다.<br>
			※ 
			</td>
		</tr>

	</table>
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

