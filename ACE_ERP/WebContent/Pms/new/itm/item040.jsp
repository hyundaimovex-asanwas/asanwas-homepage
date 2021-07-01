<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 품목코드 이력조회
 * 프로그램ID 	 : PMS/Itm
 * J  S  P		 : Itm040.jsp
 * 서 블 릿		 : Itm040
 * 작 성 자		 : 이 동 훈
 * 작 성 일		 : 2018-06-12
 * 기능정의		 : 품목코드 이력조회
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

		fnSelect();
        
    }
    
    <%//메인 조회  %>
    function fnSelect() {

		    v_job="S";


	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  		+ ",v_item=" + v_item.value						//품목코드명;
	    	
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm040",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        

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

<script language="javascript" for="tr1" event="OnSuccess()">


</script>


<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
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
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
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
			                        <td align=left class="text"  width="100">품목코드</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;
                                       <input type="text" name='v_item' id="v_item" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">                               
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
									 <C> name='No'			ID='{CurRow}'		 	width=50 	align=CENTER	edit=none   </C>
                                     <C> name='Code'		ID='CD_ITEM'    		width=150 	align=CENTER	Edit=None 	suppress='1'</C>
                                     <C> name='코드명' 		ID='DS_KSITEM'    		width=300 	align=CENTER	Edit=None 	suppress='2'</C>                                                              
                                     <C> name='적용일자'	ID='DT_APPLY' 			width=150 	align=CENTER	Edit=None	mask = 'XXXX-XX-XX'</C>
                                     <C> name='변경전단가'	ID='AMT_ITEM_BEFORE'    width=150 	align=CENTER	Edit=None 	DECAO=0</C>
                                     <C> name='변경후단가'	ID='AMT_ITEM_AFTER'    	width=150 	align=CENTER	Edit=None 	DECAO=0</C>
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