<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	     : 프로그램 정보
 * 프로그램ID 	 : 
 * J  S  P		 : cm010i(left_menu)
 * 서 블 릿		 : 
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2007-07-24
 * 기능정의		 : 메뉴 트리 
 * 수정내용		 :
 * 수 정 자		 : 
 * 최종수정일자        : 
 * TODO			 : 
 * TODO			 :    
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	
%>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
	/*
	 * 데이타셋 헤더 설정
	 */
	function fnSetHeader_tree(){
		if (ds_tree.countrow < 1){
			var s_temp1 = "TREE_LV:INT,TREE_ID:STRING,TREE_IDX:INT,TREE_NM:STRING,TREE_TYPE:INT,TREE_SEQ:INT,TREE_FILE:STRING";
			ds_tree.SetDataHeader(s_temp1);
		}	
	}
	/*
	 * 선조회
	 */
	function fnInit_tree(){
		fnSetHeader_tree();

        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1";
        ln_TRSetting(tr_tree, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm010I",
        "JSP(O:DEFAULT=ds_tree)",
        param);
        tr_post(tr_tree);
	}
    </script>

	<script language=JavaScript for=tb_TreeView event=OnClick()>
	//left click event
		alert("tb_TreeView.ItemText");
		alert(ds_tree.namevalue(ds_tree.rowposition,"TREE_ID"));	
	</script>
	
	<script language=JavaScript for=tb_TreeView event=OnDblClick()>
	//left double click event
		alert("dblclick");
		//txt_text2.value=tb_TreeView2.ItemText;	
	</script>
	
	<script language=JavaScript for=tb_TreeView event=OnRClick()>
	//right click event
		alert("R click");
		alert(ds_tree.namevalue(ds_tree.rowposition,"TREE_FILE"));			
	</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_tree classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr_tree" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%>
<object id=tb_TreeView classid=CLSID:4401B994-DD33-11D2-B539-006097ADB678 style="border:1 solid #708090; WIDTH: 100%; HEIGHT: 90%;font-size:9pt"> 
	<param name=DataID			value="ds_tree">
	<param name=TextColumn		value="TREE_NM">
	<param name=TypeColumn		value="TREE_Type">
	<param name=LevelColumn		value="TREE_LV">
	<param name=BorderStyle  	value="0">
	<param name=HasLines      	value="false"> 
	<param name="UseImage"		value="true">
	<param name="ItemEnable"    value="Enable">
	<param name="SingleExpand"  value="true">
</object>
<%=HDConstant.COMMENT_END%>