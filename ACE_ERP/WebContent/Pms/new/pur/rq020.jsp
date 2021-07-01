<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 구매의뢰서 접수
 * 프로그램ID 	 : PMS/Itm
 * J  S  P		 : Itm030.jsp
 * 서 블 릿		 : Rq020
 * 작 성 자		 : 김 도 연
 * 작 성 일		 : 2018-06-26
 * 기능정의		 : 구매의뢰서 접수 list
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

	var v_default_row = 1;
	
    var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

    
    
	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출

		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		
		fnInit();
		
	}
	
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";

	    v_fr_rqst_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,4)+"0101"%>";
        v_to_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

		fnSelect();
        
    }
    
    
    
    <%//메인 조회  %>
    function fnSelect() {
    	
		    v_job="S";

	        var fr_date = v_fr_rqst_date.Text.trim();
	        var to_date = v_to_rqst_date.Text.trim();

	        if(fr_date.length!=8) {
	            alert("요청일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("요청일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}

	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	    			  + ",v_project=" + v_project.value				//프로젝트명 검색
	                  + ",v_frdt=" + fr_date						//시작일
	                  + ",v_todt=" + to_date						//종료일
	                  + ",v_stat="  + v_rqst_status.value;			//처리상태
	    	
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq020",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        

    }    
    

    
    
	<%//승인 %>
	function fnApply(){
		
		v_job = "A";
		
		if (ds_default.IsUpdated) {
			
			  ln_TRSetting(tr1, 
					  
                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq020",
			                "JSP(I:DS_DEFAULT=ds_default)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
			                + ",v_stat=Y" 				//반려 status			                
			                );
			  
			   //prompt(this, ds_default.text);
			  
			   tr_post(tr1);

        }else{
        	
     		alert("승인할 코드를 선택해주시기 바랍니다.");
		
        }
		
		
	 }

	
	
	
	<%//반려 %>
	function fnApplyNo(){
		
		v_job = "A";
		
		if (ds_default.IsUpdated) {
			
			  ln_TRSetting(tr1, 
					  
                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq020",
			                "JSP(I:DS_DEFAULT=ds_default)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
			                + ",v_stat=B" 				//반려 status
			                );
			  
			   //prompt(this, ds_default.text);		   

			   tr_post(tr1);

        }else{
        	
     		alert("승인할 코드를 선택해주시기 바랍니다.");
		
        }
		
		
	 }	

</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<!-- 마우스 이벤트 - 더블클릭 -->
<script language=javascript for=gr_default event="OnDblClick(Row,Colid)">

		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;
		var strPos;
		
		arrParam[0] = ds_default.NameValue(ds_default.rowposition,"NO_MA_REQUEST");			//구매의뢰서 번호
		arrParam[1] = ds_default.NameValue(ds_default.rowposition,"COST_CD");				//Project Code
		arrParam[2] = ds_default.NameValue(ds_default.rowposition,"PLJ_NM");				//Project
		
		strURL = "<%=dirPath%>/Pms/new/pur/rq021.jsp";
		
		strPos = "dialogWidth:1050px;dialogHeight:900px;status:no;scroll:no;resizable:no";
		 
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
		sApproveLine = arrResult; 

</script>	


<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="A"){
		
		alert("성공적으로 처리되었습니다.");
		
		fnSelect();
	}
	
</script>


<script language=JavaScript for=tr1 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	
</script>


	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>

</head>


<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="1000px"> 
    
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">&nbsp;
							<img src="<%=dirPath%>/Sales/images/sendback.gif"			style="cursor:pointer" onClick="fnApplyNo();">&nbsp;
							<img src="<%=dirPath%>/Sales/images/sungin.gif"				style="cursor:pointer" onClick="fnApply();">&nbsp;						

						</td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='1000px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
                    			<tr>
			                        <td align=left class="text"  width="70">요청일자</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        			value="">
			                                <param name=Alignment   			value=1>
			                                <param name=Format      			value="0000-00-00">
			                                <param name=Cursor      			value="iBeam">
			                                <param name=Border      			value="false">      
			                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    			value="false">
			                                <param name=SelectAll   			value="true">
			                                <param name=SelectAllOnClick    	value="true">
			                                <param name=SelectAllOnClickAny   	value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=v_to_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        			value="">
			                                <param name=Alignment   			value=1>
			                                <param name=Format      			value="0000-00-00">
			                                <param name=Cursor      			value="iBeam">
			                                <param name=Border      			value="false">      
			                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    			value="false">
			                                <param name=SelectAll   			value="true">
			                                <param name=SelectAllOnClick    	value="true">
			                                <param name=SelectAllOnClickAny   	value=false>
			                            </object>
			                            <%=HDConstant.COMMENT_END%>                                                                             
			                        </td>
			                        
			                        <td align=center class="text">Project</td>
                        			<td align="left" bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_project' id="v_project" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
			                        
			                        <td align=left class="text">처리상태</td>
									<td align="left" bgcolor="#ffffff" WIDTH="220">&nbsp;
										<select name="v_rqst_status" id="v_rqst_status" onChange="fnSelect();">
											<option value="A">전체</option>
											<option value="R">승인요청</option>
											<option value="Y">승인완료</option>
										</select>		
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
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="1000px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='600px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='CHK'						ID='CHK'    				width=40 	align=CENTER	EditStyle='CheckBox' CheckBoxText=''</C>
                                     <C> name='구매의뢰서번호'			ID='NO_MA_REQUEST'			width=90 	align=CENTER  	mask='XXXXXXXX-XXXX' edit=none</C>
			                     	 <C> name='Code'					ID='COST_CD'				width=60 	align=CENTER 	show=false</C>                 	
			                         <C> name='Project'					ID='PLJ_NM'					width=120 	align=left 		edit=none</C>
			                         <C> name='Contents'				ID='DS_MA_REQUEST'   		width=150 	align=left		edit=none</C>
			                         <C> name='의뢰일자' 				ID='DT_MA_REQUEST'			width=80 	align=CENTER	mask='XXXX-XX-XX'	edit=none</C>
			                         <C> name='의뢰자'					ID='NM_REQUEST' 			width=60 	align=CENTER	edit=none</C>
			                         <C> name='구매근거'				ID='TY_BUYTYPE' 			width=70 	align=CENTER	edit=none show=false</C>
			                         <C> name='구매근거'				ID='DS_BUYTYPE' 			width=70 	align=CENTER	edit=none</C>	
			                         <C> name='거래처'				    ID='VEND_NM' 				width=70 	align=left		edit=none</C>		                         
			                         <C> name='승인일자' 				ID='DT_CONFIRM'				width=80 	align=CENTER	mask='XXXX-XX-XX'	edit=none</C>
			                         <C> name='승인자'					ID='NM_CONFIRM' 			width=60 	align=CENTER	edit=none</C>			                         
			                         <C> name='처리 상태'				ID='TY_APPROVAL'			width=70 	align=CENTER 	edit=none</C>
			                         <C> name='비고'					ID='REMARK'					width=80 	align=left		edit=none</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
    </table>

	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		