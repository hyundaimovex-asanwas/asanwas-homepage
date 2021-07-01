<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 픔명등록
 * 프로그램ID   : PU030I
 * J  S  P      : pu030i
 * 서 블 릿        : Pu030I
 * 작 성 자        : 박경국
 * 작 성 일        : 2011-11-10
 * [수  정   일  자][수정자] 내용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    
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
       
        // 페이지로딩
        function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

            cfStyleGrid(getObjectFirst("gr2"), "comn");
            fnInit(); 
        } 
        
        // 초기작업, Header 설정 , 지역
        function fnInit() {
		        //트리조회
		        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
                        + ",dsType=1";
                        
		         ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu030I",
	                "JSP(O:DS1=ds1)",
	                v_param);
	            tr_post(tr1);
	            //gr1.Reset();
	    }
        
        //ds2조회
        function fnSelect(e){
        
	        if (ds2.isUpdated ) { 
				alert("수정중인 행이 있습니다."); 
				return;
			}
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        
            gr1.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_code_no=" + e;
			//alert(v_param);
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu030I",
                "JSP(O:DS2=ds2)",
                v_param);
            tr_post(tr1);
        }
         //조회
        function fnSelect2(){
        
	        if (ds2.isUpdated ) { 
				alert("수정중인 행이 있습니다."); 
				return;
			}
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        
            gr1.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=2"
                        + ",v_item_nm=" + sItemNm.value;
			//alert(v_param);
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu030I_01",
                "JSP(O:DS2=ds2)",
                v_param);
            tr_post(tr1);
        }
		
		//ds2저장
        function fnApply(){
            if(ds2.IsUpdated==false){
                alert("변경된 내역이 없습니다.");
                return;
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                        + ",dsType=1";
                        
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu030I",
                "JSP(I:DS2=ds2,O:RESULT=ds_result)",
                v_param);
            tr_post(tr_save);
           //s fnSelect('2');
        }

	    //행추가
		function fnAddRow() {
			ds2.addrow();
		}

		//행삭제
		function fnDeleteRow() {
			ds2.deleterow(ds2.rowposition);
		}
		//취소
		function fnCancel() {
			if (ds2.IsUpdated ) {
				ds2.undoall();
				window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
			}
		}
	
    </script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr_save" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
</script>

<script language=javascript for=ds1 event="OnLoadCompleted(Row)">
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
    gr1.ReDraw = "True";
</script>

<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(Row==0) return;
    
    var v_result_msg = "";
    for(var i=1; i<=ds_result.CountRow; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_result_msg += ds_result.NameValue(i, "MSG")+"\n"
        }
    }
    if(v_result_msg!="")
        alert(v_result_msg);
</script>

<script language=JavaScript for=v_fr_date event=OnKillFocus()>
   if( v_fr_date.Modified == true )
		v_to_date.text = v_fr_date.text;
</script>		


<script language="javascript" for="gr1" event="onClick()">
	
	var tree_level=gr1.ItemLevel;
	
		if(tree_level=="3"){
		//alert(tree_level);
		var e = ds1.namevalue(ds1.rowposition,"CODE_NO");
		fnSelect(e);
	}
	return;

</script>
<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="True">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="True">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s08.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 
        <tr>
            <td>
				 <table border='0' cellpadding="0" cellspacing="0"  width='845px'>
                    <tr>
                   		<td align="center" width="100px" class="text">품명</td>
						<td align="center" bgcolor="#ffffff"><input type="text" name="sItemNm" value="" size="15" maxlength="10" class="textbox" onkeydown="if(event.keyCode==13) fnSelect2();"></td>
                        <td height='25px' align='right'>
			                        <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand"  onclick="fnSelect2()">
			            			<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:hand" onClick="fnAddRow()" >
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand"onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand" onclick="fnCancel()">
			            			<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand" onClick="fnDeleteRow()" >			
			            			<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	onClick="fnExcel()">		<!-- 엑셀 -->																																					
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'></td>
        </tr> 
        <tr>
            <td width="845" valign=top>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                    <tr>
                        <td width=300>
                           <%=HDConstant.COMMENT_START%>
                            <object id=gr1 classid=<%=HDConstant.CT_TREEVIEW_CLSID%> width='300px' height='420px' border='1'>
                                <param name="DataID"            value="ds1">
                                <param name=TextColumn	value="CODE_NM">
								<param name=LevelColumn	value="Level">
								<param name=TypeColumn		value="Type">
							</object>    
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td width=50>
                        </td>
                        <td width=520>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='520px' height='420px' border='1'>
                                <param name="DataID"            value="ds2">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
                                <param name="ViewSummary"		value="1">
                                <param name="Format"            value="
									<C> name='품명'     	ID='ITEM_NM'       width=150 align=center  	SumText='합계' </C>
									<C> name='규격'  	ID='ITEM_SIZE'     width=150 align=right 		</C>
									<C> name='단위'    	ID='ITEM_UNIT'  	Width=60 align=Center 	SumText=@count</C>
									<C> name='분류' 		ID='ITEM_KIND'	width=60 align=center 	SumText='개'</C>
									<C> name='상위코드' 		ID='CODE_NO'		width=80 align=center 	show=true</C>
									<C> name='ITEM_SID' 		ID='ITEM_SID'		width=100 align=center 	show=false</C>
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