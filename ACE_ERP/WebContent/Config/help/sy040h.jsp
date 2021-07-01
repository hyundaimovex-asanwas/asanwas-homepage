<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ���缱 ����
 * ���α׷�ID   : SY040H
 * J  S  P      : Common/help/sy040h
 * �� �� ��        : Sy040h
 * �� �� ��        : ���ϳ�
 * �� �� ��        : 2010-09-06
 * [ �������� ][������] ����
 * [2014-06-17][�ɵ���] �۾��Ϻ� �ϸ鼭 ���� ���� ���� �Űܼ� ����
 *						�� ��� DB�� ASNHR�� ����, ���ν��� COMMON���� ����
 *						�� �̸� �˻��� Ʈ�� ��ġ��
 *						�� ����Ʈ���� ������� �μ����� ���� �ֱ�, �� �μ����� ������ ǥ�õǱ�.
 *						�� �ø��� ������ ���� ���
 * [2014-06-18][�ɵ���] �� UI ����
 * [2014-07-01][�ɵ���] �� ���缱 ���� �׽�Ʈ
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="config.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

    //�α��� üũ : 2013-12-04 �ɵ��� ���� ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String gusrpos	= (String)session.getAttribute("vusrpos");	//������ �̵��� ���Ǻ���("�α�") üũ
	String gusrip	= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ

	// (ssID + ���������ǰ� + IP) ��
	if(!gusrpos.equals("Tadaima") ){
	//���� �Բ� ���� ȭ������ 
		%>
		<script language="javascript">
		alert("�ð��� �����Ǿ� �ڵ� �α׾ƿ��Ǿ��ų�\n���� ������ �ƴմϴ�.\n\n���� �α��� ���ּ���.");
		window.close();	//â���� ����(2013-12-04)
		</script>
		<%
		return;
	}
	//�α��� üũ �� ///////////////////////////////////////////////////////////////////////////////////////
%>
<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<meta http-equiv="Cache-control" content="no-cache"/>
		<meta http-equiv="Cache-control" content="no-store"/>
		<meta http-equiv="pragma" content="no-cache" />
		<meta name="viewport" content="width=1080" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
	
	<title>���ڰ��� : ���缱 ������������������������������������������������������������������������������������������������������������������������������
	</title>
	
	<%
	/*=============================================================================
				Style Sheet, Common Java Script Link
	=============================================================================*/
	%>		
	<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">
	<link href="<%=dirPath%>/Common/css30/ap_layout.css" rel="stylesheet" type="text/css">  <%//���ڰ�����... %>	
	<%// ���ڰ���� �ҽ� %>
	<script language="javascript" src="<%=dirPath%>/Config/common/js/ap_gauce.js"></script>
    
<%
/****************************************************************************
                ����� ��ũ��Ʈ
******************************************************************************/
%>      
	<script language="javascript">
		function cfLengthCheck(targetObj, maxLength) {
		    var len = 0;
		    var newtext = "";
		    for(var i=0 ; i < targetObj.value.length; i++) {
		        var c = escape(targetObj.value.charAt(i));
	
		        if ( c.length == 1 ) len ++;
		        else if ( c.indexOf("%u") != -1 ) len += 2;
		        else if ( c.indexOf("%") != -1 ) len += c.length/3;
	
		        if( len <= maxLength ) newtext += unescape(c);
		    }
	
		    if ( len > maxLength ) {
		        targetObj.value = newtext;
		        targetObj.focus();
		        return false;
		    }
		}

		var  gusrid  	="<%=(String)session.getAttribute("vusrid")%>";
		var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";
		var  gcurdate	="<%=(String)session.getAttribute("vcurdate")%>";
		var  gdeptcd	="<%=(String)session.getAttribute("vdeptcd")%>";
		var v_default_row = 1;
		var sApproveLine;

		
		
		
		<% //�������ε�%>
		function fnOnLoad(){
			cfStyleGrid(getObjectFirst("gr_master"), "approval");
			cfStyleGrid(getObjectFirst("gr_detail"), "apline");
			fnInit(); 					//�ʱ�ȭ �۾�
			ln_tree(gdeptcd);			// ���� Ʈ�� ��ġ��
			fnTreeOnlick(gdeptcd,"3");	// �α� ����� �μ��� ��ȸ
			fnMyApline(); 				// �� ���缱 ���� ��ȸ : �̰� ���� �ʰ� �ҷ��� ���� �μ��� ������ �޾ƿ� �� �ֽ��ϴ�.
			
		} 
        
        <% //�ʱ��۾� : �����ڵ�, ����Ʈ�� %> 
		function fnInit() {    
			ln_SetDataHeader();			// ���缱 ��� ����
			ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
			ds_gc_aptype.Reset();	//�������� AP005

			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1";
			ln_TRSetting(tr1,
	        	"<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H", 
	        	"JSP(O:DS_ORG_TREE=ds_org_tree)",
	       		param);
	        tr_post(tr1);
		}
		
		<% //���� ���缱(luxcombo) ��ȸ%>
		function fnMyApline() {				
			v_job = "S";         
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1" ;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	            "JSP(O:DS_MY_APLINE=ds_my_apline)",
	            param);
	        tr_post(tr2);  	        	        
	     }
	    
	    <% // �� ���缱 �޺� ����� �ҷ�����%>
	    function fnSelect2(){
	        v_job = "S";         
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
			    + "v_sid=" + lc_apline.BindColVal;
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
			    "JSP(O:DS_APLINE=ds_apline)",
			    param);
			tr_post(tr2);  
				       
	    }
		
	    <% // Ʈ�� Ŭ���� �ش� �μ��� ��ȸ %>
		function fnTreeOnlick(dptcd,dptlv){					
	        v_job = "S";         
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
	        	+ "v_dept_lv =" + dptlv + ","    
	        	+ "v_dept_cd =" + dptcd ;       
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	            "JSP(O:DS_EMPLIST=ds_emplist)",
	            param);
	        tr_post(tr1);
	        			
		}

		<% //�μ�����ȸ - �̸� �˻�%>
	    function fnSelect(){  
	        v_job = "emplist";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "v_cust_nm=" + v_cust_nm.value;       
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	            "JSP(O:DS_EMPLIST=ds_emplist)",
	            param);
	        tr_post(tr2);	       
	    }		
		
	    <% //���缱 �����ͼ� ��� %>
		function ln_SetDataHeader(){
			if (ds_apline.countrow<1){
				var s_temp = " CREATE_YN:STRING(1),DUMMY:DECIMAL(1),SEQ: DECIMAL(5),ENO_NO:STRING(7),APPROVE_TYPE:STRING(10),ENO_NM:STRING(30),"
						   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),SID:NUMERIC(10.0) ";
				ds_apline.SetDataHeader(s_temp);
			}
		}

		<% //�޴�Ʈ�� ��ġ�� %>
		function ln_tree(dptcd){
			if(dptcd=="undefined"){	//�ʱ� �ε���ȭ���� ���
	       		TreeView_org.Expand(0);
			} else{
		    	for (i = 1; i <= ds_org_tree.countrow; i++) {
		    		if(dptcd == ds_org_tree.namevalue(i,"DEPTCD")) {
			       		TreeView_org.Expand(i);
		    		};
		    	};
			};
		}
		
		<% //���缱 �����, ���� ���� %>
		function ln_add_seq(){
			for(i=1;i<=ds_apline.CountRow;i++){
	      		ds_apline.namevalue(i,"DUMMY") = 1;	//���� �÷��� 1�� ���� ==>> ������Ʈ���� ��.
	      	}     

	        for(k=1;k<=ds_apline.CountRow;k++){
				ds_apline.NameValue(k, "SEQ") =  ds_apline.CountRow-k+1 ;	//���������� �������� ����
			}	
		}
		
		<% // ���缱 �ʱ�ȭ : ���=�α��λ���ڷ� ���� %>
		function fnInitApline(){;
			ds_apline.ClearData();
			ds_apline.AddRow();
			ds_apline.NameValue(1, "APPROVE_TYPE") = 1;
			ds_apline.NameValue(1, "SEQ") = 1;
			ds_apline.NameValue(1, "ENO_NO")    	= gusrid;
	    	for (i = 1; i <= ds_emplist.countrow; i++) {
	    		if(gusrid == ds_emplist.NameValue(i, "ENO_NO")) {
	    			ds_apline.NameValue(1, "ENO_NM")     	= ds_emplist.NameValue(i, "ENO_NM");
	    		    ds_apline.NameValue(1, "JOB_NM")      	= ds_emplist.NameValue(i, "JOB_NM");
	    		    ds_apline.NameValue(1, "DPT_NM")       	= ds_emplist.NameValue(i, "DPT_NM");
	    		};
	    	};
		};		

		<% // ���缱 ��� %>
	    function fnCancel(){    
	        ds_apline.UndoAll();
	        fnInitApline();    
	    }
	    
		<% // ���缱 �����%>
		function fnAplineDel() {
			ds_apline.DeleteRow(ds_apline.RowPosition);	
		} 

		<% // ���缱 �� �ø���%>
		function fnAplineUp() {
			var nowPos = ds_apline.RowPosition; 
			var newRowPos;
			var oldRowPos;
			
			if(nowPos > 1){//1����ū���̾�� �ö�� �ڸ� ����
				newRowPos = nowPos - 1;
				ds_apline.InsertRow(newRowPos);	// ������ 1�� �� �࿡�� �μ�Ʈ�ο�
				oldRowPos = nowPos + 1;			// ���� ���� +1 �ڸ��� �и���. 
				ds_apline.NameValue(newRowPos, "APPROVE_TYPE") = ds_apline.NameValue(oldRowPos, "APPROVE_TYPE");
				ds_apline.NameValue(newRowPos, "ENO_NO") = ds_apline.NameValue(oldRowPos, "ENO_NO");
			    ds_apline.NameValue(newRowPos, "ENO_NM") = ds_apline.NameValue(oldRowPos, "ENO_NM");
			    ds_apline.NameValue(newRowPos, "JOB_NM") = ds_apline.NameValue(oldRowPos, "JOB_NM");
			    ds_apline.NameValue(newRowPos, "DPT_NM") = ds_apline.NameValue(oldRowPos, "DPT_NM");
			    ds_apline.DeleteRow(oldRowPos);	// ���� �� ����
			    ln_add_seq();
			}else{
				return false;
			}
		} 		
		

		<% // ���缱 �� ������%>
		function fnAplineDown() {
			var nowPos = ds_apline.RowPosition;
			var totRow = ds_apline.countrow;
			var newRowPos;
			newRowPos = nowPos + 2;	// �� �ڸ��� �ٴ�����
			
			if(newRowPos > totRow){ // ���� ���� ���ڸ��� //totRow�� ���� �ʾƾ� ������ �ڸ� ����
				ds_apline.AddRow();	// ���� �߰�
				ds_apline.NameValue(newRowPos, "APPROVE_TYPE") = ds_apline.NameValue(nowPos, "APPROVE_TYPE");
				ds_apline.NameValue(newRowPos, "ENO_NO") = ds_apline.NameValue(nowPos, "ENO_NO");
			    ds_apline.NameValue(newRowPos, "ENO_NM") = ds_apline.NameValue(nowPos, "ENO_NM");
			    ds_apline.NameValue(newRowPos, "JOB_NM") = ds_apline.NameValue(nowPos, "JOB_NM");
			    ds_apline.NameValue(newRowPos, "DPT_NM") = ds_apline.NameValue(nowPos, "DPT_NM");
			    ds_apline.DeleteRow(nowPos);	// ���� �� ����
			    ln_add_seq();
			}else if(newRowPos <= totRow){ // ���� ���� ���ڸ��� //totRow�� ���� �ʾƾ� ������ �ڸ� ����
				ds_apline.InsertRow(newRowPos);	// �� �ڸ����� �μ�Ʈ�ο�;
				ds_apline.NameValue(newRowPos, "APPROVE_TYPE") = ds_apline.NameValue(nowPos, "APPROVE_TYPE");
				ds_apline.NameValue(newRowPos, "ENO_NO") = ds_apline.NameValue(nowPos, "ENO_NO");
			    ds_apline.NameValue(newRowPos, "ENO_NM") = ds_apline.NameValue(nowPos, "ENO_NM");
			    ds_apline.NameValue(newRowPos, "JOB_NM") = ds_apline.NameValue(nowPos, "JOB_NM");
			    ds_apline.NameValue(newRowPos, "DPT_NM") = ds_apline.NameValue(nowPos, "DPT_NM");
			    ds_apline.DeleteRow(nowPos);	// ���� �� ����
			    ln_add_seq();
			}else{
				return false;
			}
		} 			
		
						
		<% 
		// Description 	:  �˾�â �ݱ�
		// Parameter 	: A - ����
		%>			
		function fnClose(p){	
			var returnValue;
			var returnValue2="";
			if (p=="A") {
				if(ds_apline.countrow>0){
					for(i=1;i<=ds_apline.countrow;i++){
						//alert("::"+ds_apline.namevalue(i,"APPROVE_TYPE")+"::");
						if(ds_apline.namevalue(i,"APPROVE_TYPE")==""){
							alert("���� ������ ������ �ּ���."); 
							return false;
						}
						if(ds_apline.namevalue(i,"ENO_NO")==""){
							alert("�����ڸ� ������ �ּ���."); 
							return false;
						}
						
						returnValue = "1" + "/" 
							+ ds_apline.namevalue(i,"SEQ")  + "/" 
							+ ds_apline.namevalue(i,"APPROVE_TYPE")  + "/" 
							+ ds_apline.namevalue(i,"ENO_NO")  + "/"
							+ ds_apline.namevalue(i,"ENO_NM")  + "/"
							+ ds_apline.namevalue(i,"JOB_NM")+"/"
							+ ds_apline.namevalue(i,"DPT_NM")+"/"
							+ ds_apline.namevalue(i,"SID")+";"  
				   		returnValue2 =    returnValue2 + returnValue;            
					                   	 	
		
					}
					//alert(returnValue2);
					window.returnValue = 	returnValue2 ;			
					window.close();
				}else{
					alert("�ݿ��� ���缱�� �����ϴ�. ���缱�� �������ּ���.");
				}
			} else {	//��� �ݱ�
				window.close();
			}
		}

    

	
		<% //�� ���缱 ���� %>      
		function fnSave(){
			if (ds_apline.isUpdated ){  		
  			 	if (v_app_nm.value==""){
  		 			alert("���ΰ��缱���� �Է����ּ���");
  		 			return false;
  		 		}
				for(var i=1; i<=ds_apline.CountRow; i++){
					if(ds_apline.namevalue(i,"APPROVE_TYPE")==""){
						alert("���� ������ ������ �ּ���."); 
						ds_apline.RowPosition = i;
						return;
					}
	         	}
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	     				+ "v_app_nm=" + v_app_nm.value+","
	     				+ "v_sid=" + lc_apline.BindColVal;  
	     	
				ln_TRSetting(tr_save,
				        "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
						"JSP(I:DS1=ds_apline)",
						param);
				tr_post(tr_save);
				fnMyApline();
	 		}else{
				alert("����� ���缱�� �����ϴ�.\n\n���缱�� ���� ����� �ּ���.");
	 		}
		}
		
		<% //�� ���缱 ���� %>
		function fnCorrect(){
			for(var i=1; i<=ds_apline.CountRow; i++){
				if(ds_apline.namevalue(i,"APPROVE_TYPE")==""){
					alert("���� ������ ������ �ּ���."); 
					ds_apline.RowPosition = i;
					return;
				}
         	}

			// �׳� �����ϸ� �����ͼ��� ������ �ȵǳ�.. �ƹ� ������ ���..
			// ���� �����ͼ��� ������ ���� ���·� ������ֱ�
			for(i=1;i<=ds_apline.CountRow;i++){
				ds_apline.namevalue(i,"DUMMY") = 1;
			}

			// �׸����� �����ʹ� ������Ʈ, �������� ���� �� ���� insert ���ֱ�
		    var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2,"
 					+ "v_app_nm=" + v_app_nm.value+","
		   	     	+ "v_sid=" + lc_apline.BindColVal;  
		   	     	
		    ln_TRSetting(tr_save,
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	            "JSP(I:DS1=ds_apline)",
	            param);
			tr_post(tr_save);
			fnMyApline();
		}
    
	<% // �� ���缱 ���� %>
    function fnDelete(){
        if(confirm("�����Ͻðڽ��ϱ�? ")==false){
            return;
		}    
         for(i=1;i<=ds_apline.CountRow;i++){
        	ds_apline.namevalue(i,"DUMMY") = 1;
         }

	     var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=3,"
	   	     	+ "v_app_nm=" + v_app_nm.value+","
	   	     	+ "v_sid=" + lc_apline.BindColVal;  
	   	     	
		 ln_TRSetting(tr_save,
	    	"<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	     	"JSP(I:DS1=ds_apline)",
	     	param);
	     tr_post(tr_save);
	     fnMyApline();
    }	

    


    </script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="TreeView_org" event="onClick()">
	var dptcd = ds_org_tree.namevalue(ds_org_tree.rowposition,"DEPTCD");
	var dptlv = ds_org_tree.namevalue(ds_org_tree.rowposition,"DEPT_LEVEL");
	fnTreeOnlick(dptcd,dptlv);
</script>


<script language="javascript" for="ds_my_apline" event="onloadCompleted(row,colid)">
	ds_my_apline.insertrow(1);
	ds_my_apline.namevalue(1,"SID") = "";
	ds_my_apline.namevalue(1,"APPROVE_NM") = "�űԵ��";
	lc_apline.index = 0;
</script>

<% //�� ���缱 ���� ó�� �ҷ��� �� %>
<script language=JavaScript for=lc_apline event=OnSelChange()>
	if (lc_apline.index ==0 ) {
		sp0.style.display = "";		//��ư ����
		sp1.style.display = "none";
		sp2.style.display = "none";
		v_app_nm.value = "";		// ���缱�� ����
	
		fnInitApline();	// ���缱 �ʱ�ȭ : ���=�α��λ���ڷ� ����
		
    }else{
		sp0.style.display = "none";
		sp1.style.display = "";
		sp2.style.display = "";	 	    	 	        	
		fnSelect2();
	
		v_app_nm.value = ds_my_apline.NameValue(ds_my_apline.RowPosition, "APPROVE_NM");
	}        	                   
</script>
  
		      
<script language=javascript for=gr_master event="OnDblClick(Row,Colid)">
	for (i = 1; i <= ds_apline.countrow; i++) {
		if(ds_apline.NameValue(i, "ENO_NO") == ds_emplist.NameValue(Row, "ENO_NO")) {
			alert("�����ڸ� �ߺ� ������ �� �����ϴ�.");
			return false;
		};
	};
	var RowPos ;
    if(ds_apline.RowPosition==0) {	//�� ����� �߰��� ��
    	RowPos = 1;
    }else{
    	RowPos = ds_apline.RowPosition;
    }
    ds_apline.InsertRow(RowPos);
    ds_apline.NameValue(RowPos, "ENO_NO")    	= ds_emplist.NameValue(Row, "ENO_NO");
    ds_apline.NameValue(RowPos, "ENO_NM")     	= ds_emplist.NameValue(Row, "ENO_NM");
    ds_apline.NameValue(RowPos, "JOB_NM")      	= ds_emplist.NameValue(Row, "JOB_NM");
    ds_apline.NameValue(RowPos, "DPT_NM")       = ds_emplist.NameValue(Row, "DPT_NM");
	ln_add_seq();

</script>		


												
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="onsuccess()">
</script>

<script language="javascript" for="tr1" event="onfail()">
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

<script language="javascript" for="tr2" event="onsuccess()">
	if(v_job=="emplist"){
		var dptcd= ds_emplist.namevalue(ds_emplist.rowposition,"DPT_CD");
		ln_tree(dptcd);    
	}

</script>

<script language="javascript" for="tr2" event="onfail()">
    
    alert("<%=HDConstant.S_MSG_SAVE_ERR%>");         
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save" event="onsuccess()">
    
    alert("<%=HDConstant.S_MSG_SAVE_DONE%>");
//     fnMyApline();
    
    
</script>

<script language="javascript" for="tr_save" event="onfail()">
    
    alert("<%=HDConstant.S_MSG_SAVE_ERR%>");         
    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
        
    fnSelect();
</script>


<%
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>

<!--����Ʈ�� --> 
<OBJECT id=ds_org_tree classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="TREECD">
</OBJECT>

<!--�μ��� --> 
<OBJECT id=ds_emplist classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--���缱 --> 
<OBJECT id=ds_apline classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--���缱���� --> 
<object  id=ds_my_apline classid=<%=HDConstant.CT_DATASET_CLSID%>>  
    <param name="SyncLoad"  value="False">
</object>  

<!--���缱Ÿ�� --> 
<object  id=ds_gc_aptype classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>


<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
    <param name="StatusResetType"  value="2">
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
</head>

<body onLoad="fnOnLoad();">
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border=0 cellpadding='0' cellspacing='0'>
  <tr>
  	<td width="10">&nbsp;</td>
  	<td width="600" class="t"><br>
    <table border='0' cellpadding='0' cellspacing='0'> 
	  <tr>
		<td>
		<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
		  <tr height='25px'>
			<td class="text" width="80">�̸�</td>
			<td class="l" width="517" bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" maxlength="10" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
			<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer"  onclick="fnSelect()" >
			</td>	                                                                                 
			<!-- <td class="text" width="80">�μ�</td> -->
			<!-- <td class="c" width="275" bgcolor="#ffffff">&nbsp;<input type="text" name="v_dept_nm" maxlength="14" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"> -->
				
			</td>
		  </tr>
    	</table>
		</td>
	  </tr>
	  <tr height='6px'>
		<td></td>
	  </tr>
	  <tr>
		<td class="t">
		<table border=0 cellspacing=0 cellpadding=0>
		  <tr>
			<td width="241" style="border:1 solid #666666;">                           
			<object id="TreeView_org" classid="clsid:4401B994-DD33-11D2-B539-006097ADB678" style="width:241px; height:230px; font-size:9pt"> 
				<Param Name="DataID"		value="ds_org_tree">
				<Param Name="TextColumn"	value="DEPTNM">
				<Param Name="LevelColumn"	value="DEPT_LEVEL">
				<Param Name="BorderStyle"	value="0">
				<param name="useimage"		value="false">
			</object>			                            
			</td>
			<td width="356" style="border-top:1 solid #666666;border-bottom:1 solid #666666;border-right:1 solid #666666;">
				<object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='356px' height='230px' border='0'>
					<param name="DataID"            value="ds_emplist">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="true">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name="Format"            value="
						<C>ID=ENO_NO		 Name=���	 width=70	align=center	Edit=None	show=false</C>
						<C>ID=ENO_NM	 Name=�̸�	 width=70 	 align=center	 Edit=None</C>
						<C>ID=JOB_NM	 Name=����	 width=100	 align=center 	 Edit=None</C>																					
						<C>ID=DPT_NM	 Name=�μ�	 width=169	 align=left 	 Edit=None</C>												
					">
				</object>
			</td>       
		  </tr>
		</table>

		</td>
	  </tr>
	  <tr height=5><td></td></tr>
	  <tr>
		<td>
		<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
		  <tr height='25px'>
			<td class="text" width="100">�� ���缱 ����</td>
			<td width="140" class="c" bgcolor="#ffffff">																									
	            <object id=lc_apline classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
					<param name=ComboDataID		value=ds_my_apline>
					<param name=BindColumn      value="sid"">
					<param name=BindColVal      value="sid">
					<param name=EditExprFormat	value="%,%;sid,approve_nm">
					<param name=ListExprFormat  value="approve_nm^0^120">
				</object>
			</td>		                                                                                 
			<td class="text" width="100">�� ���缱��</td>
			<td class="l" width="255" bgcolor="#ffffff">&nbsp;<input type="text" name="v_app_nm" size="20" maxlength="20" class="textbox"  OnKeyUp="cfLengthCheck(this, 20);">
				<span id=sp0 style="display:none;">						                 		
				<img src="<%=dirPath%>/Sales/images/save.gif"  style="cursor:pointer" onclick="fnSave()">
				</span>
				<span id=sp1 style="display:none;">
				<img src="<%=dirPath%>/Sales/images/correct.gif"  style="cursor:pointer" onclick="fnCorrect()">
				</span>
				<span id=sp2 style="display:none;">
				<img src="<%=dirPath%>/Sales/images/delete.gif"  style="cursor:pointer" onclick="fnDelete()">
        		</span>
			</td>
		  </tr>
		</table>	
		</td>
	  </tr>    	
	  <tr height=5><td></td></tr>	  
	  <tr>
		<td height='25px' align='right'>
			<img src="<%=dirPath%>/Sales/images/btn_ap_up.gif" style="cursor:pointer"  onClick="fnAplineUp()">
			<img src="<%=dirPath%>/Sales/images/btn_ap_dn.gif" style="cursor:pointer"  onClick="fnAplineDown()">
			<img src="<%=dirPath%>/Sales/images/btn_ap_del.gif" style="cursor:pointer" onClick="fnAplineDel()">
			  
			
		</td>
	  </tr>
	  <tr>
		<td class="t" style="border:1 solid #666666;">
        <object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='598px' height='100px' border='0'>
			<param name="DataID"            value="ds_apline">
			<param name="ColSizing"         value="true">
			<param name="Editable"          value="true">
			<param name="SuppressOption"    value="1">
			<param name="BorderStyle"       value="0">
			<param name="Format"            value="												    
				<C>ID='CREATE_YN'	 Name='����'	 Width=35	 align=center editlimit=1 editstyle=checkbox show=false</C>
					<C>ID='DUMMY'			 Name='DUM'	 Width=40	 align=center Edit=None SHOW=false </C>
				<C>ID='SEQ'			 Name='����'	 Width=40	 align=center Edit=None</C>
				<C>ID=APPROVE_TYPE	 Name='����'	 width=80	 align=center EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm' </C> 
				<C>ID=ENO_NM		 Name=�̸�		 width=121	 align=center Edit=None</C>
				<C>ID=JOB_NM		 Name=����		 width=120	 align=center Edit=None</C>
				<C>ID=DPT_NM		 Name=�μ�		 width=220	 align=left Edit=None</C>	       
				<C>ID=ENO_NO		 Name=���		 width=70	 align=center Edit=None show=false </C>
				<C>ID=SID			 Name=���缱sID	 width=70	 align=center Edit=None show=false </C>

			">
		</object>
		</td>																	
	  </tr>
	  <tr>
		<td height='25px' align='right'>
			<img src="<%=dirPath%>/Sales/images/ap_line.gif" style="cursor:pointer"  onClick="fnClose('A')" >
			<img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:pointer" onclick="fnCancel()">                              
			<img src="<%=dirPath%>/Sales/images/p_exit.gif"  style="cursor:pointer" onclick="fnClose('C')">                          
    </td>
</tr>  


	</table>
  	</td>
  	<td width="10">&nbsp;</td>
  </tr>
</table>
  	
                                

                              

                                                                                  						                 						                 
</body>
</html>
<!-- BODY footer end-->


