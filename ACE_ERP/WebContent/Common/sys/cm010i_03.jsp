<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���α׷� ����
 * ���α׷�ID 	 : Common Menu
 * J  S  P		 : cm010i.jsp ���� �޴� Ʈ����
 * �� �� ��		 : Cm010I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2007-07-24
 * �������		 : �޴� Ʈ�� 
 *				      Ʈ�������� ������ leaf�� Ŭ���ϸ� �̵�, ��Ŭ���ϸ� ��â
 * [��  ��   ��  ��][������] ����
 * [2007-09-07][�ɵ���] ��ũ�� ��ũ��Ʈ �߰��ϱ�
 * [2007-09-11][�ɵ���] ��Ŭ���̺�Ʈ, �޴���, ��θ� ��ũ��Ʈ �Ϸ�
 * [2007-09-12][�ɵ���] ��Ŭ���̺�Ʈ �Ϸ�.
 * [2013-10-21][�ɵ���] 13 �籸��-���� ����
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
	/* Ʈ�� ����Ÿ�� ��� ���� */
	function fnSetHeader_tree(){
		if (ds_tree.countrow < 1){
			var s_temp1 = "TREE_LV:INT,TREE_ID:STRING,TREE_IDX:INT,TREE_NM:STRING,TREE_TYPE:INT,TREE_SEQ:INT,TREE_FILE:STRING";
			ds_tree.SetDataHeader(s_temp1);
		}	
	}

	/* Ʈ�� ��ȸ */
	function fnInit_tree(tree_idx){
		fnSetHeader_tree();	

		//�޴�Ʈ�� ��ȸ�ϱ�
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
   	     	+ "tree_idx=" + tree_idx;	//���õ� �޴� idx�� ������.
        ln_TRSetting(tr_tree, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm011I_03",
        	"JSP(O:DEFAULT=ds_tree)",
       		param);
        tr_post(tr_tree);

		//�޴�Ʈ�� ��ġ��
		if(tree_idx==0){	//�ʱ� �ε���ȭ���� ���
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
    	
    	//�޴�����
    	fnSetTitle(tree_idx);
	}

	/* �޴�Ʈ�� ��ȸ�ϱ� */
	function fnSetTitle(tree_idx){
		if(tree_idx==0){	//�ʱ� �ε���ȭ���� ���
			menu_title.innerHTML = "����";
			menu_full.innerHTML = "Ȩ>�ý��ۼ���>���� ";
			document.title = "���ۡ�����������������������������������������������������������������������������������";
		} else{
	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	   	     	+ "tree_idx=" + tree_idx;	//���õ� �޴� idx�� ������.
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
		
		if(lev=='4'){	//4���� �϶��� ȭ�� �̵�.
			//document.location.href="<%=dirPath%>/" + fileName + ".jsp?idx=" + idx;
			moveMove("<%=dirPath%>/" + fileName + ".jsp","idx="+idx);
		}
	</script>
	
	<script language=JavaScript for=tb_TreeView event=OnRClick()>
	//right click event : ������ư ��â 
		var fileName = ds_tree.namevalue(ds_tree.rowposition,"TREE_FILE");
		var lev      = ds_tree.namevalue(ds_tree.rowposition,"TREE_LV");
		var idx      = ds_tree.namevalue(ds_tree.rowposition,"TREE_IDX");
		
		if(lev=='4'){	//4���� �϶��� ȭ�� �̵�.
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
			DataSet Components(DS) ����
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
	document.title = ds_title.namevalue(ds_title.rowposition,"MENU_NM")+"������������������������������������������������������������������������������������";
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
