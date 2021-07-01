<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 프로그램 정보
 * 프로그램ID 	 : Common Menu
 * J  S  P		 : cm010i.jsp 좌측 메뉴 트리용
 * 서 블 릿		 : Cm010I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2007-07-24
 * 기능정의		 : 메뉴 트리 
 *				      트리구조의 마지막 leaf를 클릭하면 이동, 우클릭하면 새창
 * [수  정   일  자][수정자] 내용
 * [2007-09-07][심동현] 링크용 스크립트 추가하기
 * [2007-09-11][심동현] 좌클릭이벤트, 메뉴명, 경로명 스크립트 완료
 * [2007-09-12][심동현] 우클릭이벤트 완료.
 * [2013-10-21][심동현] 13 재구성-실행 이전
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
%>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
	/* 트리 데이타셋 헤더 설정 */
	function fnSetHeader_tree(){
		if (ds_tree.countrow < 1){
			var s_temp1 = "TREE_LV:INT,TREE_ID:STRING,TREE_IDX:INT,TREE_NM:STRING,TREE_TYPE:INT,TREE_SEQ:INT,TREE_FILE:STRING";
			ds_tree.SetDataHeader(s_temp1);
		}	
	}

	/* 트리 조회 */
	function fnInit_tree(tree_idx){
		fnSetHeader_tree();	

		//메뉴트리 조회하기
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
   	     	+ "tree_idx=" + tree_idx;	//선택된 메뉴 idx를 던진다.
        ln_TRSetting(tr_tree, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm011I_03",
        	"JSP(O:DEFAULT=ds_tree)",
       		param);
        tr_post(tr_tree);

		//메뉴트리 펼치기
		if(tree_idx==0){	//초기 인덱스화면인 경우
       		//tb_TreeView.Expand(0);
       		tb_TreeView.ExpandLevel = "1";
       		
		} else{
	    	for (i = 1; i <= ds_tree.countrow; i++) {
	    		if(tree_idx == ds_tree.namevalue(i,"TREE_IDX")) {
		       		tb_TreeView.Expand(i);
		       		break;
	    		};
	    	};
		};	//		if(tree_idx=0){
    	
    	//메뉴명세팅
    	fnSetTitle(tree_idx);
	}

	/* 메뉴트리 조회하기 */
	function fnSetTitle(tree_idx){
		if(tree_idx==0){	//초기 인덱스화면인 경우
			menu_title.innerHTML = "시작";
			menu_full.innerHTML = "홈>시스템설정>시작 ";
			document.title = "시작　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
		} else{
	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	   	     	+ "tree_idx=" + tree_idx;	//선택된 메뉴 idx를 던진다.
	        ln_TRSetting(tr_title, 
	            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm011I_03",
	        	"JSP(O:TITLE=ds_title)",
	       		param);
	        tr_post(tr_title);
	    };
	}	
    </script>

	<script language=JavaScript for=tb_TreeView event=OnClick()>
	//left click event
		var fileName = ds_tree.namevalue(ds_tree.rowposition,"TREE_FILE");
		var lev      = ds_tree.namevalue(ds_tree.rowposition,"TREE_LV");
		var idx      = ds_tree.namevalue(ds_tree.rowposition,"TREE_IDX");
		
		if(lev=='4'){	//4레벨 일때만 화면 이동.
			//document.location.href="<%=dirPath%>/" + fileName + ".jsp?idx=" + idx;
			moveMove("<%=dirPath%>/" + fileName + ".jsp","idx="+idx);
		}
	</script>
	
	<script language=JavaScript for=tb_TreeView event=OnRClick()>
	//right click event : 우측버튼 새창 
		var fileName = ds_tree.namevalue(ds_tree.rowposition,"TREE_FILE");
		var lev      = ds_tree.namevalue(ds_tree.rowposition,"TREE_LV");
		var idx      = ds_tree.namevalue(ds_tree.rowposition,"TREE_IDX");
		
		if(lev=='4'){	//4레벨 일때만 화면 이동.
			//window.open("<%=dirPath%>/" + fileName + ".jsp?idx=" + idx, "_blank", "fullscreen=yes");
			moveMoveN("<%=dirPath%>/" + fileName + ".jsp","idx="+idx);
		}

	</script>

	<script language=JavaScript for=tb_TreeView event=OnDblClick()>
		//left double click event
		//alert("dblclick");
		//txt_text2.value=tb_TreeView2.ItemText;	
	</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

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

<object id=ds_title classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr_title" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


<script language=JavaScript  for=ds_title event="OnLoadCompleted(row)">
//	alert(ds_title.namevalue(ds_title.rowposition,"MENU_NM"));
//	alert(ds_title.namevalue(ds_title.rowposition,"FULL_DIR_NM"));	
	menu_title.innerHTML = ds_title.namevalue(ds_title.rowposition,"MENU_NM");
	menu_full.innerHTML = ds_title.namevalue(ds_title.rowposition,"FULL_DIR_NM");
	document.title = ds_title.namevalue(ds_title.rowposition,"MENU_NM")+"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
</script>




<object id=tb_TreeView classid=CLSID:4401B994-DD33-11D2-B539-006097ADB678 style="border:0 solid #708090; WIDTH: 100%; HEIGHT: 90%;font-size:9pt"> 
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
