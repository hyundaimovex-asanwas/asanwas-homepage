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
 * [2013-10-30][박경국] 13 재구성-실행 이전
 * [2014-04-14][심동현] 아이템 단축명 추가
 *						그 외 소스 살짝 정리
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

    //java.util.Calendar date = java.util.Calendar.getInstance();
    //java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
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
       
    	var gs_userid = gusrid;
		var gs_fdcode = gfdcode;
		var v_default_row = 1;
		var v_job ;
		
        // 페이지로딩
        function fnOnLoad(tree_idx){
        	fnInit_tree(tree_idx);	//트리초기화 호출
        	fnInit();
        	//alert("!");
        	cfStyleGrid(getObjectFirst("gr2"), "comn");
        } 
        
        // 초기작업, Header 설정 , 지역
        function fnInit() {
		        //트리조회
		        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
                        + ",dsType=1";
                 //alert(v_param);      
		         ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu030I",
	                "JSP(O:DS1=ds1,O:DS2=ds2)",
	                v_param);
	            tr_post(tr1);
	            //gr1.Reset();
	    }
        
        //ds2조회
        function fnSelect(e){
        	v_job = "S";
	        if (ds2.isUpdated ) { 
				alert("수정중인 행이 있습니다."); 
				return;
			}
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
         //품명 검색 조회
        function fnSelect2(){
        	v_job = "S2";
        	if (sItemNm.value != null && sItemNm.value != "" && sItemNm.value.length >0 ) {
			} else {
				alert("품명 검색조건을 입력해 주세요!");
				return;
			}
             
	        if (ds2.isUpdated ) { 
				alert("수정중인 행이 있습니다."); 
				return;
			}
	         
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        
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
            //alert(v_param);          
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu030I",
                "JSP(I:DS2=ds2)",
                v_param);
            tr_post(tr_save);
           //s fnSelect('2');
        }

	    //행추가
		function fnAddRow() {
			ds2.addrow();
			ds2.namevalue(ds2.rowposition,"CODE_NO") = ds1.namevalue(ds1.rowposition,"CODE_NO");
			
		}

		//행삭제
		function fnDeleteRow() {
			ds2.deleterow(ds2.rowposition);
		}
		//취소
		function fnCancel() {
			if (ds2.IsUpdated ) {
				ds2.undoall();
				msgTxt.innerHTML="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
			}
		}
		<%//액셀 다운로드 %>
	    function fnExcel() {
	        if(ds2.CountRow==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        }
	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").SetExcelTitle(1, "value:품목; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr2").GridToExcel("품목", "품목.xls", 8);        
	    }
	</script>

	<script language="javascript" for="tr1" event="onsuccess()">
			//alert("tr1 성공");
			msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
			
	</script>

	<script language="javascript" for="tr1" event="onfail()">
			//alert("tr1 실패");
			alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
			msgTxt.innerHTML="작업이 성공적으로 완료되지 못했습니다.";
	</script>

	<script language="javascript" for="tr_save" event="onsuccess()">
		msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
		if(v_job=="S2"){
			fnSelect2();
		}
		if(v_job=="S"){
			var e = ds1.namevalue(ds1.rowposition,"CODE_NO");
			fnSelect(e);	
		}
	</script>

	<script language="javascript" for="tr_save" event="onfail()">
			//alert("tr1 실패");
			alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
			msgTxt.innerHTML="작업이 성공적으로 완료되지 못했습니다.";
	</script>

<script language="javascript" for="v_fr_date" event="OnKillFocus()">
   if( v_fr_date.Modified == true )
		v_to_date.text = v_fr_date.text;
</script>		


<script language="javascript" for="gr1" event="onClick()">
	var tree_level=gr1.ItemLevel;
	//alert(tree_level);
		if(tree_level=="3"){
			//alert("3");
		var e = ds1.namevalue(ds1.rowposition,"CODE_NO");
		fnSelect(e);
	}
</script>
<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
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

</head>
<jsp:include page="/Common/sys/body_s08.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0' width="100%"> 
        <tr>
            <td>
				 <table border='0' cellpadding="0" cellspacing="0"  width='845px'>
                    <tr>
                   		<td align="center" width="100px" class="text">품명</td>
						<td align="center" bgcolor="#ffffff"><input type="text" name="sItemNm" value="" size="15" maxlength="10" class="textbox" onkeydown="if(event.keyCode==13) fnSelect2();"></td>
                        <td height='25px' align='right'>
			                        <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer"  onclick="fnSelect2()">
			            			<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:pointer" onClick="fnAddRow()" >
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer"onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer" onclick="fnCancel()">
			            			<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:pointer" onClick="fnDeleteRow()" >			
			            			<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	onClick="fnExcel()">		<!-- 엑셀 -->																																					
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr> 
        <tr>
            <td valign=top>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                    <tr>
                        <td width=300>
                           
                            <object id=gr1 classid=<%=HDConstant.CT_TREEVIEW_CLSID%> width="300px" height="420px" border="1">
                                <param name="DataID"    value="ds1">
                                <param name=TextColumn	value="CODE_NM">
								<param name=LevelColumn	value="ITEM_LEVEl">
								<param name=TypeColumn		value="Type">
							</object>    
                            
                        </td>
                        <td width=20></td>
                        <td >
                            
                            <object id=gr2 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:670px; height:420px" border="1">
                                <param name="DataID"            value="ds2">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
                                <param name="ViewSummary"		value="1">
                                <param name="Format"            value="
                                	<C> name='품번'     ID='ITEM_SID'      width=50 align=right decao=0 SumText='총'  edit=none</C>
									<C> name='품명'     ID='ITEM_NM'       width=150 align=left SumText=@count SumTextAlign=center</C>
									<C> name='단축명'   ID='ITEM_NM_S'     width=70  align=left SumText='개'</C>
									<C> name='규격'  	ID='ITEM_SIZE'     width=150 align=left		</C>
									<C> name='단위'    	ID='ITEM_UNIT'  	Width=70 align=Center 	</C>
									<C> name='분류' 		ID='ITEM_KIND'	width=70 align=center 	</C>
									<C> name='상위코드' ID='CODE_NO'		width=80 align=center 	show=true</C>
									<C> name='ITEM_SID' ID='ITEM_SID'		width=100 align=center 	show=false</C>
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