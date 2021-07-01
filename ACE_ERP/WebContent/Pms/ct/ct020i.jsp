<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 선수금등록(도급계약)
 * 프로그램ID 	: CT020 (코드는 대문자)
 * J  S  P		: ct020 (jsp파일명은 소문자로 한다 )
 * 서 블 릿		: Ct020
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-07-28
 * 기능정의	: 선수금등록(도급계약) 등록/조회/관리
 * 수정내용	: 신규
 * [수  정   일  자][수정자] 내용
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
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	
	<script language="javascript">
	
		get_cookdata();
		var gs_userid = gusrid;
		var gs_fdcode = gfdcode;
		var v_default_row = 1;

	   	/*
	 	 * 페이지 로딩
	 	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			fnInit();
			cfStyleGrid(getObjectFirst("gr1"), "comn");	//선수금등록(도급계약) 메인
		}

		/*
		 * 초기화 작업
		 */
		function fnInit(){ 
		
		    //데이터셋 헤더 초기화 = 빈 조회
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct020I",
	            "JSP(O:DS1=ds1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
	        
		}

		/*
		 * 데이터셋 헤더 설정 (메인)
		 */	
		/*
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				+
				"site_sid:INT,site_cd:STRING,site_nm:STRING,site_joint_nm:STRING,site_main_nm:STRING,site_attr1_nm:STRING,site_attr2_nm:STRING,site_joint:STRING,site_main:STRING,site_attr1:STRING,site_attr2:STRING,orderer_sid:INT,vend_cd:STRING,orderer_nm:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}
		*/
		
		/*
		 * 선수금등록(도급계약) 메인조회
		 */
		function fnSelect(){   
		
			if(getObjectFirst("v_site_nm").value.trim()==""){
                alert("현장명 <%=HDConstant.A_MSG_MUST_INPUT%>");
                //getObjectFirst("v_site_nm").Focus();
                return;
            }
            
			if (ds1.IsUpdated) {
				alert("수정중인 행인 있습니다.");
			} else {
					    //gr1.ReDraw = "False";
				        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                    + ",dsType=1"  
				                    + ",v_site_sid="+ v_site_sid.value
									+ ",v_site_seq_ct=" + v_site_seq_ct.value
									; 
						//alert(v_param);
				        ln_TRSetting(tr1, 
				            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct020I",
				            "JSP(O:DS1=ds1)",
				            v_param);
				        tr_post(tr1);
			}
		} 
		
		/*
		 * 선수금등록(도급계약)  삭제 
		 * 삭제 액션시 바로 적용
		 */
		function fnDeleteRowDs1() {			
		
			if (confirm("입력하신 사항을 삭제하시겠습니까?")) {
				ds1.deleterow(ds1.rowposition);
				fnApply();
				window.status="선수금등록(도급계약) 메인행이 삭제되었습니다.";
			
				return;
			}
		}

		/*
		 * 적용
		 * 
		 */
		function fnApply(){
		
			var row=ds1.countRow;
			
			if(getObjectFirst("amt_ac_tot").value.trim()==""){
                alert("선수금 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
            if(getObjectFirst("date_rqst").text.trim()==""){
                alert("청구일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
			
			if (ds1.IsUpdated) {
				if(ln_Chk()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_CT%>Ct020I",
	                "JSP(I:DS1=ds1)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
	                //prompt('ds1',ds1.text);
            		tr_post(tr1);
            	}
			}else {
         		alert("업데이트된 행이 없습니다.");
		 	}
		}

		/*
		 * 취소 
		 * 도급계약, 공동수급, 도급계약변경
		 */
		function fnCancel(){
		
			if(ds1.IsUpdated) {
				ds1.undoall();
			}
			window.status="데이터 변경이 취소되었습니다.";
			return;
		}

		/*
		 * 엑셀 
		 */
		/*
		function fnExcelGr1(){
			gr2.runexcel("공통코드관리");
		}
		*/
		
		<%//현장 팝%>
	    function fnSelSitePopup(dirPath) {
	        v_cust_row = 0;
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	
	        
	        arrResult = fnCtSitePop(dirPath);
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            //v_coop_cd.value = arrParam[0];	//CD
	            v_site_nm.value = arrParam[1];	//NM
	            v_site_sid.value = arrParam[2];	//SID
	        } else {
				fnSelSiteCleanup();
	        }               
	    }
	    
		/*
		 * 입력값 체크 
		 */
		function ln_Chk() {
			
			var row1=ds1.countrow;
			for(i=1;i<=row1;i++) {
				if(ds1.namevalue(i,"site_seq_ct")=="") {
					alert("계약차수를 입력해 주십시오");
					site_seq_ct.focus();
					return;
				}
			}		
			return true;
		}
		
	     function fnSelSiteCleanup(){
	        v_site_nm.value = "";
	        v_site_sid.value  = "";
  		 }
   
</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--선수금 등록(도급계약)-->
	<param name="SyncLoad" 	value="true">
</object>
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--계약차수-->
	<param name="SyncLoad" 	value="false">
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
<%=HDConstant.COMMENT_END%>
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
		<!-- 
			마스터 작업 완료
		-->
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="작업이 성공적으로 완료되었습니다.";
		</script>
		<!-- 
			마스터 작업 에러
		-->
		<script language="javascript" for="tr1" event="onfail()">
			window.status="작업이 성공적으로 완료되지 못했습니다.";
		</script>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' width="845px"> 
 	<tr>
    	<td align='right'>
        	<table border='0' cellpadding='0' cellspacing='0' width='845px'>
            	<tr>
                	<td height='25px' align='right'>
                        <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" 	onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" 	onClick="fnApply();">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"   onclick="fnCancel()">
                    </td>
              </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width='845px'>
            <table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
            	<tr>
                	<td align="center" class="text" width="100">현장명</td>
                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSiteCleanup();" alt="값 지우기">
                    </td>
                    <td align="center" class="text" width="100">계약차수</td>
                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="txt_head" name='v_site_seq_ct' id="v_site_seq_ct" style="width:200px;" class="textbox"  onkeydown="if(event.keyCode==113) fnCtOrdererPopup('<%=dirPath%>');" >
                    </td>
                </tr>					
			</table>
		</td>
	</tr>
	<tr height="15">
		<td></td>
	</tr>	
	<tr>
		<td>
			<table  width="845px"  cellpadding="0" cellspacing="0">
				<tr>
					<td valign='top' colspan="0"  align="left">
						<table width=290px; border="0" cellpadding="0" cellspacing="0" >
							<tr>
								<td align="left" valign="top" width=290px; >
									<%=HDConstant.COMMENT_START%>
									<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=290px; height:300px" border="1">
										<param name="DataID"				value="ds1">
										<param name="BorderStyle"   	value="0">
										<param name="Fillarea"			value="true">
										<param name="ColSizing"     	value="true">
										<param name="IndWidth"     		value="0">
										<param name="editable"      		value="true">
										<param name="ViewSummary"       value="1">
										<param name="LineColor" 		value="#dddddd">
										<param name="Format"		value="  
										
											<C> name='선수금sid' 	ID='ac_sid' 	Width=70  align=left editlimit=100	SumText='총' decao=0</C>
											<C> name='현장sid'  		ID='site_sid'  	Width=70  align=left editlimit=50	decao=0</C>			
											<C> name='계약차수' 		ID='site_seq_ct'    	width=80   align=CENTER	decao=0</C>
											<C> name='계약일자' 		ID='date_ct'    		width=90 	align=CENTER	</C>
											<C> name='계약금'			ID='amt_ct_tot'    	width=120 	align=CENTER	Edit=None decao=0	SumText=@count</C>
											<C> name='선수율'			ID='rate_ac'    		width=80 	align=CENTER	Edit=None decao=0</C>
											<C> name='수령횟수' 		ID='seq_ac'   	width=60   align=CENTER	decao=0</C>											
											<C> name='선수금총액'	ID='amt_ac_tot'    	width=120 	align=CENTER	Edit=None decao=0</C>
											<C> name='선수금공급가'		ID='amt_ac'    width=80 	align=CENTER	Edit=None decao=0</C>
											<C> name='선수금부가세' 		ID='amt_ac_vat'    		width=80 	align=CENTER	decao=0</C>
											<C> name='요청일자' 				ID='date_rqst'    			width=60 	align=CENTER	</C>
											<C> name='입금일자' 				ID='date_rcv'  		  	width=60 	align=CENTER	</C>
											<C> name='참고' 					ID='remarks' 			   	width=100 	align=CENTER	</C>
                                         ">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
							</tr>
						</table>
					</td>
					<td width=55px;></td>
					<td valign='top' colspan="0"  align="left">
						<table width="500px" border="0" cellpadding="0" cellspacing="1" >
							<tr>
								<td width='500px'height='96px' valign='top' align="left" >
									<table border='0' cellpadding='0' cellspacing='1' width='500px' height='96px' bgcolor="#666666">
										<tr>
											<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">계약금</td>
					                        <td height="24px"  colspan="1"	bgcolor="#FFFFFF" align=left>&nbsp;
												<input id="amt_ct_tot" type="text" class="input01"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,10);">
											</td>
					                        <td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">선수율</td>
					                        <td height="24px"  colspan="1"	bgcolor="#FFFFFF" align=left>&nbsp;
												<input id="rate_ac" type="text" class="input01"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,10);">
											</td>
										</tr>
										<tr>
											<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">선수금</td>
											<td  height="24px"  colspan="3"  bgcolor="#FFFFFF" align="left">&nbsp;
												<input id="amt_ac_tot" type="text" class="textbox"   size="20" value="" maxlength="100" onBlur="bytelength(this,this.value,100);">
											</td>
										</tr>
										<tr>
											<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">공급가액</td>
					                        <td height="24px"  colspan="1"	bgcolor="#FFFFFF" align=left>&nbsp;
												<input id="amt_ac" type="text" class="input01"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,10);">
											</td>
					                        <td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">부가세</td>
					                        <td height="24px"  colspan="1"	bgcolor="#FFFFFF" align=left>&nbsp;
												<input id="amt_ac_vat" type="text" class="input01"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,10);">
											</td>
										</tr>
										<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">청구일자</td>
					                    <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=date_rqst classid=<%=HDConstant.CT_EMEDIT_CLSID%> width=150 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:128px; height:17px;">
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
				                            <%=HDConstant.COMMENT_END%>&nbsp;&nbsp;                                                                             
				                        </td>
										<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">입금일자</td>
					                    <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=date_rcv classid=<%=HDConstant.CT_EMEDIT_CLSID%> width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:128px; height:17px;">
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
				                            <%=HDConstant.COMMENT_END%>&nbsp;&nbsp;                                                                             
				                        </td>
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
<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>	
<%=HDConstant.COMMENT_START%>
        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=ac_sid 	 	    	Ctrl=ac_sid		 	       Param=value </C>
                    <C>Col=site_sid 	 	    	Ctrl=site_sid	 	       Param=value </C>
                    <C>Col=seq_ct		   	  	Ctrl=seq_ct			       Param=value </C>
                    <C>Col=date_ct 		  	  	Ctrl=date_ct		       Param=value </C>                    
                    <C>Col=amt_ct_tot     	    Ctrl=amt_ct_tot            Param=value </C>
                    <C>Col=rate_ac	 		    Ctrl=rate_ac	   		   Param=value </C>
                    <C>Col=seq_ac  	        Ctrl=seq_ac	           Param=value </C>
                    <C>Col=amt_ac_tot 	    Ctrl=amt_ac_tot           Param=value </C>
                    <C>Col=amt_ac	    	 	Ctrl=amt_ac	    	   Param=value </C>
                    <C>Col=amt_ac_vat 		Ctrl=amt_ac_vat          Param=value </C>
                    <C>Col=date_rqst    	    Ctrl=date_rqst	 	       Param=text </C>
                    <C>Col=date_rcv		    Ctrl=date_rcv		       Param=text </C>
                    <C>Col=remarks	   	        Ctrl=remarks	           Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%> 
		<input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		