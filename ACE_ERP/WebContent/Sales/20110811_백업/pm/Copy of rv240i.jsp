<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��Ͻ�û
 * ���α׷�ID 	: RV240I
 * J  S  P		: rv240i
 * �� �� ��		: Rv240I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-26
 * �������		:
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
//   String firsttime = m_today.format(date.getTime()).substring(8,12);


%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>	
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		var init_flag = "";
		var updateFlag = "";
		var dsName = "";
		var oldDeptDate = "";
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			
			codeDs3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        	codeDs3.Reset(); //�����ڵ�
        	
          	ds_goods.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?proType=S&dsType=2";
          	ds_goods.Reset();	//��ǰ����
        	
	        ds_cust.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV003&s_item1=Y";
	        ds_cust.Reset(); //��������
	        
	        ds_stay.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV031&s_item1=Y";
	        ds_stay.Reset(); //��������
	        
			fnInit(); 
			
			codeDs1.deleterow(1);
			codeDs2.deleterow(1);
			codeDs4.deleterow(1);
			
		} 
		 
		/*
		 * �ʱ��۾�
		 * Header ���� 
		 */
		function fnInit(){
			init_flag = "H";
	  		from_accept_date.text='<%=firstday%>';	//��û���� �¾�
			to_accept_date.text='<%=firstday%>';  
			    
			ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
	            "JSP(O:RM014=codeDs1,O:RM015=codeDs2,O:SY010=codeDs4, O:DS1=ds1, O:DS2=ds2, O:DS3=ds3)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
	        
	        init_flag = "";
		}
		
		
		function fnSelect() {
			if (sClient_sid.value != null && sClient_sid.value != "" && sClient_sid.value.length >0 ) {
				fnSelectDs1();
			} else {
				alert("��ȸ�Ͻð��� �ϴ� �븮���� �������ּ���!");
				return;
			}
		}
			
		/*
		 * ���� ��ȸ
		 * �ʱ� ��������Ʈ�� �ο�����Ʈ�� ��ȸ�Ѵ� 
		 */			
		function fnSelectDs1() {
		 	if (!ds1.IsUpdated && !ds2.IsUpdated && !ds3.IsUpdated) {
		 		updateFlag = "S";
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sClientSid="+ sClient_sid.value				// ���¾�ü �ڵ�
				          + ",sFromAcceptDate=" + from_accept_date.Text		// ��û���� To
				          + ",sToAcceptDate=" + to_accept_date.Text			// ��û���� From
				          + ",sAcceptNo=" + sAcceptNo.value
				          + ",sSaupSid=" + sSaupSid.ValueOfIndex("saup_sid",sSaupSid.Index); 
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			} else {
				alert("�۾��߿��� ��ȸ�Ҽ� �����ϴ�!");	
				return;			
			}
		}
		
		/*
		 * �������� Ű�� �޾Ƽ� ��ȸ
		 * ��������Ʈ Ŭ���� �ο�����Ʈ ��ȸ 
		 */
		function fnSelectDs2(row) {
			updateFlag = "S";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sAcceptSid="+ ds1.namevalue(row, "ACCEPT_SID");
			
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
			    "JSP(O:DS3=ds3, O:DS2=ds2)",
			    param);
			tr_post(tr2);
		}
		
		/*
		 * ������� Ȯ��
		 */
		 
		 function fnDeptDateChkDs2(ds) {

			if(ds=="ds2") {
				dsName = "ds2";
			 	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			 				+",sClientSid=" + sClient_sid.value
			 				+",sDeptDate=" + ds2.namevalue(ds2.rowposition,"depart_date");
			 } else if (ds=="ds3") {
			 	dsName = "ds3";
			 	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			 				+",sClientSid=" + sClient_sid.value
			 				+",sDeptDate=" + ds3.namevalue(ds3.rowposition,"depart_date");
	
			 }				
		 	ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
			    "JSP(O:DEPT_DATE=ds5)",
			    param);
			tr_post(tr2);			
		 }
		 
		/*
		 * ����
		 * ��������Ʈ, �ο�����Ʈ�� �����Ѵ� 
		 */
		function fnApply() {
			if(fnChecked()) {			
				var param= "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
							+ ",sClientSid=" + sClient_sid.value
							+ ",sSaupSid=" + sSaupSid.ValueOfIndex("saup_sid",sSaupSid.Index);
					
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
				    "JSP(I:DS1=ds1,I:DS2=ds2, I:DS3=ds3, O:DS4=ds4)",
				    param);
				tr_post(tr1);	
			}				
		}
		
		
		/*
		 * ���� 
		 * ���λ����� ��������Ʈ�� �ο�����Ʈ�� �����Ѵ� 
		 */
		function fnDeleteRowDs1() {
			ds1.DeleteRow(ds1.RowPosition);
			ds2.ClearAll();
			ds3.ClearAll();
			
			fnApply();

			ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
	            "JSP(O:DS2=ds2, O:DS3=ds3)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		}
		 
		/*
		 * ����� 
		 * �ο�����Ʈ ���� 
		 */
		function fnDeleteRowDs2() {
			for(i = 1; i <= ds3.countrow; i++) {
				if (ds2.namevalue(ds2.rowposition,"manage_no") == ds3.namevalue(i, "manage_no")) {
					ds2.DeleteRow(ds2.RowPosition);
					ds3.deleteRow(i);
					return;
				}
			}
			ds2.DeleteRow(ds2.RowPosition);
		}
		
		/*
		 * ����� 
		 * �ο�����Ʈ ���� 
		 */
		function fnDeleteRowDs3() {
			ds3.DeleteRow(ds3.RowPosition);
		}
		
		/*
		 * �ű�
		 * ������ �߰� 
		 */
		function fnAddRowDs1() {
			if (sClient_sid.value != null && sClient_sid.value != "" && sClient_sid.value.length >0 ) {
				updateFlag = "N";
				ds1.AddRow();
				accept_date.text='<%=firstday%>'; // ��û���ڸ� �����Ѵ� 
				v_goods.Enable = "true";
				depart_date.Enable = "true";
				
			} else {
				alert("����ϰ��� �ϴ� �븮���� �������ּ���!");
				return;
			}
		}
		
		/*
		 * ���߰� 
		 * ���߰� ��������Ʈ 
		 */
		function  fnAddRowDs2() {
			if (ds1.rowposition <= 0) {
				alert("����� ���ڸ� ���� �������ּ���!");
				return;
			} else {
				updateFlag = "sub";
				if(v_goods.Index==-1 || v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)=='0'){
					alert("��ǰ������ ���� �����Ͻñ� �ٶ��ϴ�.");
					return;
				}
				if(depart_date.Text == "" || depart_date.Text.length!=8){
					alert("������ڸ� ���� ����Ͻñ� �ٶ��ϴ�.");
					return;
				}
				
				if(ds_temp.CountRow==0){
					alert("��ǰ �� �� ������ ���� Ȯ�� �ϼ���");
					return;
				}
				
				v_goods.Enable = "false";
				depart_date.Enable = "false";
				
				ds2.AddRow();
				ds2.namevalue(ds2.rowposition,"client_sid") = sClient_sid.value;
				ds2.namevalue(ds2.rowposition,"accept_sid") = ds1.namevalue(ds1.rowposition,"accept_sid");
				ds2.namevalue(ds2.rowposition,"depart_date") = ds_temp.NameValue(1, "DEPART_DATE");
				ds2.namevalue(ds2.rowposition,"depart_time") = ds_temp.NameValue(1, "DEPART_TIME");
				ds2.namevalue(ds2.rowposition,"arrive_date") = ds_temp.NameValue(1, "ARRIVE_DATE");
				ds2.namevalue(ds2.rowposition,"arrive_time") = ds_temp.NameValue(1, "ARRIVE_TIME");
			}
		}
		
		/*
		 * ���߰� 
		 * �ο�����Ʈ
		 */
		 function fnAddRowDs3() {
		 	
		 	if (ds1.rowposition <= 0) {
				alert("����� ���ڸ� ���� �������ּ���!");
				return;
			} else {
				updateFlag = "sub";
				if(v_goods.Index==-1 || v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)=='0'){
					alert("��ǰ������ ���� �����Ͻñ� �ٶ��ϴ�.");
					return;
				}
				if(depart_date.Text == "" || depart_date.Text.length!=8){
					alert("������ڸ� ���� ����Ͻñ� �ٶ��ϴ�.");
					return;
				}
				
				v_goods.Enable = "false";
				depart_date.Enable = "false";
				
				if(ds_temp.CountRow==0){
					alert("��ǰ �� �� ������ ���� Ȯ�� �ϼ���");
					return;
				}

				ds3.AddRow();
				ds3.namevalue(ds3.rowposition,"accept_sid") = ds1.namevalue(ds1.rowposition,"accept_sid");
				ds3.namevalue(ds3.rowposition,"depart_date") = ds_temp.NameValue(1, "DEPART_DATE");
				ds3.namevalue(ds3.rowposition,"depart_time") = ds_temp.NameValue(1, "DEPART_TIME");
				ds3.namevalue(ds3.rowposition,"arrive_date") = ds_temp.NameValue(1, "ARRIVE_DATE");
				ds3.namevalue(ds3.rowposition,"arrive_time") = ds_temp.NameValue(1, "ARRIVE_TIME");
			}
		 }
		 
		/* 
		 * ��� 
		 * �۾���� 
		 */
		 
		 function fnCancel() {
		 	updateFlag = "";
		 	ds1.UndoAll();
		 	ds2.UndoAll();
		 	ds3.UndoAll();
		 }
		 
		/*
		 * ���¾�ü
		 */
		function fnClientPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			var dir = '<%=dirPath%>';
			
			arrResult = fnClientPop(dir,'2');
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		sClient_sid.value = arrParam[0];
		   		sClient_nm.value = arrParam[1];
			} else {
			  sClient_nm.value = "";
			  sClient_sid.value = "";
			}				
		}	
		
		/*
		 * ���� �˾�
		 */
		function fnCarPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	 
			var strPos;
			
//			strURL = "<%=dirPath%>/Sales/help/rv002h.jsp?sClientSid="+ sClient_sid.value+"&sClientNm="+ sClient_nm.value;

			arrParam[0] = sClient_sid.value;
			arrParam[1] = sClient_nm.value;
			
			strURL = "<%=dirPath%>/Sales/help/rv002h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);	
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		ds2.namevalue(ds2.rowposition,"car_sid") = arrParam[0];
		   		ds2.namevalue(ds2.rowposition,"car_nm") = arrParam[2];
		   		ds2.namevalue(ds2.rowposition, "car_no") = arrParam[1];
		   		
	   			for (row = 1; row < ds2.countrow; row++) {
	   				if (ds2.namevalue(row,"car_sid") == arrParam[0]) {
	   					alert("���� ������ ����Ҽ� �����ϴ�!");
	   					
	   					ds2.namevalue(ds2.rowposition,"car_sid") = "";
				   		ds2.namevalue(ds2.rowposition,"car_nm") = "";
				   		ds2.namevalue(ds2.rowposition,"car_no") = "";
		   		
	   					return;
	   				}
	   			}
			} else {
			 	ds2.namevalue(ds2.rowposition,"car_sid") = "";
		   		ds2.namevalue(ds2.rowposition,"car_nm") = "";
		   		ds2.namevalue(ds2.rowposition, "car_no") = "";
			}				
		}			
		
		/*
		 * ������ �˾�
		 */
		function fnDriverPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	 
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/rv003h.jsp?sClientSid="+sClient_sid.value;
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			if (arrResult != null) {
				arrParam = arrResult.split(";");

			   		ds2.namevalue(ds2.rowposition,"drive_sid") = arrParam[0];
			   		ds2.namevalue(ds2.rowposition,"cust_nm") = arrParam[1];
			   		ds2.namevalue(ds2.rowposition,"manage_no") = arrParam[2];
			   		ds2.namevalue(ds2.rowposition,"drive_no") = arrParam[3];
								 	 
			   		for (row1 = 1; row1 < ds2.countrow; row1++) {
		   				if (ds2.namevalue(row1,"drive_sid") == arrParam[0]) {
		   					alert("�����ڸ� �ߺ� ����Ҽ� �����ϴ�!");
		   					
		   					ds2.namevalue(ds2.rowposition,"drive_sid") = "";
					   		ds2.namevalue(ds2.rowposition,"cust_nm") = "";
					   		ds2.namevalue(ds2.rowposition,"manage_no") = "";
					   		ds2.namevalue(ds2.rowposition,"drive_no") = "";
		   					
		   					return;
		   				}
		   			}
		   			
		   			ds3.addRow();
		   			
			   		ds3.namevalue(ds3.rowposition, "cust_sid") 		= arrParam[4];
			   		ds3.namevalue(ds3.rowposition, "cust_nm") 		= arrParam[1];
			   		ds3.namevalue(ds3.rowposition, "manage_no") 	= arrParam[2];
			   		ds3.namevalue(ds3.rowposition, "cust_type") 		= arrParam[5];
			   		ds3.namevalue(ds3.rowposition, "work_no") 		= arrParam[6];
			   		ds3.namevalue(ds3.rowposition, "n_card_no")		= arrParam[7];
					ds3.namevalue(ds3.rowposition, "depart_date") 	= ds2.namevalue(ds2.rowposition, "depart_date")
					ds3.namevalue(ds3.rowposition, "depart_time") 	= ds2.namevalue(ds2.rowposition, "depart_time") 
					ds3.namevalue(ds3.rowposition, "arrive_date") 	= ds2.namevalue(ds2.rowposition, "arrive_date")
					ds3.namevalue(ds3.rowposition, "arrive_time") 	= ds2.namevalue(ds2.rowposition, "arrive_time")
					ds3.namevalue(ds3.rowposition, "drive_yn") 		= "Y";
					
		   			for (row2 = 1; row2 < ds3.countrow; row2++) {
		   				if (ds3.namevalue(row2,"cust_sid") == arrParam[4]) {
		   					alert("�����ڸ� �ߺ� ����Ҽ� �����ϴ�!");
		   					ds3.Undo(ds3.RowPosition);
		   					return;
		   				}
		   			}
					               
			} else {
			 	ds2.namevalue(ds2.rowposition,"drive_sid") = "";
		   		ds2.namevalue(ds2.rowposition,"cust_nm") = "";
		   		ds2.namevalue(ds2.rowposition,"manage_no") = "";
		   		ds2.namevalue(ds2.rowposition,"drive_no") = "";
		   	
		   		ds3.DeleteRow(ds3.rowposition);
			}				
		}			 		 
		 
		 
		/*
		 * �ο� �˾� : �ο� �׸��忡�� 
		 */
		function fnCustPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	 
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rv004h.jsp?sClientSid="+sClient_sid.value+"&sClientNm="+sClient_nm.value;
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);	
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		ds3.namevalue(ds3.rowposition,"cust_sid") = arrParam[0];
		   		ds3.namevalue(ds3.rowposition,"cust_nm") = arrParam[1];
		   		ds3.namevalue(ds3.rowposition, "manage_no") = arrParam[2];
		   		ds3.namevalue(ds3.rowposition, "cust_type") = arrParam[3];
		   		ds3.namevalue(ds3.rowposition, "n_card_no") = arrParam[4];
		   		ds3.namevalue(ds3.rowposition, "work_no") = arrParam[5];
		   		ds3.namevalue(ds3.rowposition, "drive_yn") = "N";
		   		for (row2 = 1; row2 < ds3.countrow; row2++) {
	   				if (ds3.namevalue(row2,"cust_sid") == arrParam[0]) {
	   					alert("�ο��� �ߺ� ����Ҽ� �����ϴ�!");
	   					
	   					ds3.namevalue(ds3.rowposition,"cust_sid") = "";
				   		ds3.namevalue(ds3.rowposition,"cust_nm") = "";
				   		ds3.namevalue(ds3.rowposition,"manage_no") = "";
				   		ds3.namevalue(ds3.rowposition,"cust_type") = "";
				   		ds3.namevalue(ds3.rowposition,"n_card_no") = "";
				   		ds3.namevalue(ds3.rowposition,"work_no") = "";
		   		
	   					return;
	   				}
	   			}
			} else {
	   			ds3.namevalue(ds3.rowposition,"cust_sid") = "";
		   		ds3.namevalue(ds3.rowposition,"cust_nm") = "";
		   		ds3.namevalue(ds3.rowposition, "manage_no") = "";
		   		ds3.namevalue(ds3.rowposition,"cust_type") = "";
		   		ds3.namevalue(ds3.rowposition,"n_card_no") = "";
		   		ds3.namevalue(ds3.rowposition,"work_no") = "";
			}				
		}			 	 
		
		
		function fnChecked() {
			
			if (ds2.IsUpdated ) {
				for (i = 1; i <= ds2.countrow; i++) {
					if (ds2.namevalue(i, "car_nm") == "") {
						alert("������ �Է��ϼ���!");
						gr2.SetColumn("car_nm");
						return;
					
					} else if (ds2.namevalue(i,"depart_date") == "") {
						alert("������ڸ� �Է��ϼ���!");
						gr2.SetColumn("depart_date");
						return;
					
					} else if (ds2.namevalue(i,"depart_time") == "") {
						alert("���ð��� �Է��ϼ���!");
						gr2.SetColumn("depart_time");
						return;
					
					} else if (ds2.namevalue(i,"arrive_date") == "") {
						alert("�԰����ڸ� �Է��ϼ���!");
						gr2.SetColumn("arrive_date");
						return;
					
					} else if (ds2.namevalue(i,"arrive_time") == "") {
						alert("�԰�ð��� �Է��ϼ���!");
						gr2.SetColumn("arrive_time");
						return;
					
					} else if (ds2.namevalue(i,"cargo") == "") {
						alert("ȭ���� �Է��ϼ���!");
						gr2.SetColumn("cargo");
						return;
					
					} else if (ds2.namevalue(i,"cust_nm") == "") {
						alert("�����ڸ� �����ϼ���!");
						gr2.SetColumn("cust_nm");
						return;
					}
				}
			}
				// ds3
			if (ds3.IsUpdated) {
				for (j = 1; j <= ds3.countrow; j++) {
					if (ds3.namevalue(j, "cust_nm") == "") {
						alert("������ �Է��ϼ���!");
						gr3.SetColumn("cust_nm");
						return;
					
					} else if (ds3.namevalue(j,"depart_date") == "") {
						alert("������ڸ� �Է��ϼ���!");
						gr3.SetColumn("depart_date");
						return;
					
					} else if (ds3.namevalue(j,"depart_time") =="") {
						alert("���ð��� �Է��ϼ���!");
						gr3.SetColumn("depart_time");
						return;
					
					} else if (ds3.namevalue(j,"arrive_date") =="") {
						alert("�԰����ڸ� �Է��ϼ���!");
						gr3.SetColumn("arrive_date");
						return;
					
					} else if (ds3.namevalue(j,"arrive_time") =="") {
						alert("�԰�ð��� �Է��ϼ���!");
						gr3.SetColumn("arrive_time");
						return;
					} 
				}
			}
				return true;
		}
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		
	</script>	
	
	<!-- ������ Ŭ���� ��������Ʈ ��ȸ   -->
 
	<script language=JavaScript for=ds1 event=OnClick(row,colid)>
	
	</script>
 	
	<!-- ��������Ʈ ��ȸ�� �ο�����Ʈ ��ȸ -->
	<script language=JavaScript for=ds2 event=OnClick(row,colid)>
	
	</script>
	
	<!--  �˾� ���� -->
	<script language=JavaScript for=gr2 event=OnPopup(row,colid,data)>
		if(colid=="car_nm") {                            
			fnCarPopup();   
		}            
		
		if (colid=="cust_nm") {
			fnDriverPopup();
		}                                                 
	</script>	    
	
	<!--  ������� üũ -->
	<script language=JavaScript for=gr2 event=OnExit(row,colid,olddata)>
		if (ds2.namevalue(row,"depart_date") != "") {
			if(colid=="depart_date") {
				oldDeptDate = olddata;
				fnDeptDateChkDs2("ds2");
			}
		} else {
			alert("������� �Է��ϼ���!");
			return;
		}
	</script>
	
		<!--  ������� üũ -->
	<script language=JavaScript for=gr3 event=OnExit(row,colid,olddata)>
		if (ds3.namevalue(row,"depart_date") != "") {
		if(colid=="depart_date") {
			
			oldDeptDate = olddata;
			fnDeptDateChkDs2("ds3");
		}
		} else {
			alert("������� �Է��ϼ���!");
			return;
		}
	</script>
	
	<script language=JavaScript for=ds5 event=OnLoadCompleted(rowcnt)>
		if (ds5.namevalue(1,"dept_flag") == 'Y') {
			alert("������ �����Դϴ�!");
			if (dsName == "ds2") {
				gr2.SetColumn("depart_date");
				ds2.namevalue(ds2.RowPosition,"depart_date") = oldDeptDate;
		 	} else if (dsName == "ds3") {
				gr3.SetColumn("depart_date");
				ds3.namevalue(ds3.RowPosition,"depart_date") = oldDeptDate;
		 	}
		}
	</script>
	
	<script language=JavaScript for=gr3 event=OnPopup(row,colid,data)>
		if (colid=="cust_nm") {
			fnCustPopup();
		}                                                 
	</script>         
	
	<script language=JavaScript for=ds4 event=OnLoadCompleted(rowcnt)>

		var count2 = 0;
		var count3 = 0;
	
		for (k = 1; k <= ds2.countrow; k++) {
			if (ds2.RowStatus(k) == 0) {
				count2++;
			}
		}

		for (l = 1; l <= ds3.countrow; l++) {
			if (ds3.RowStatus(l) == 0) {
				count3++;
			}
		}
		
		for (i = 1; i <= ds4.countrow; i++) {
			if (ds4.namevalue(i,"flag") == "DS1") {
				ds1.namevalue(ds1.rowposition, "accept_sid") = ds4.namevalue(1,"ACCEPT_SID");
				ds1.namevalue(ds1.rowposition, "accept_no") = ds4.namevalue(1,"ACCEPT_NO");
			} else if (ds4.namevalue(i,"flag") == "DS2") {
					count2++;
					ds2.namevalue(count2, "accept_sid") = ds4.namevalue(1,"ACCEPT_SID");
					ds2.namevalue(count2, "car_rsv_sid") = ds4.namevalue(i,"CAR_RSV_SID");
			} else if (ds4.namevalue(i,"flag") == "DS3") {
				count3++;
				ds3.namevalue(count3, "accept_sid") = ds4.namevalue(1,"ACCEPT_SID");
				ds3.namevalue(count3, "rsv_sid") = ds4.namevalue(i,"RSV_SID");
			}
			
			ds1.ResetStatus();
			ds2.ResetStatus();
			ds3.ResetStatus();
		}
	</script>
	
	<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
		if(row==0 || init_flag=="H") {
			return;
		}
		
		if (sAcceptNo.value == "" && updateFlag == "N") {
			fnSelectDs2(row);
		} else if (updateFlag == "S" || updateFlag == ""){
			fnSelectDs2(row);
		} else {
			alert("�۾����� ���� �ֽ��ϴ�!");
			return;
		}

		if(ds1.RowStatus(row)==0){
			var v_param = "proType=S,dsType=1"
					+ ",v_goods_sid="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)
					+ ",v_depart_date="+ depart_date.Text;
	
			ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
	            "JSP(O:DS_TEMP=ds_temp)",
	            v_param);
	        tr_post(tr2);
	        
	        v_goods.Enable = "false";
	        depart_date.Enable = "false";
		}
	</script>
	
	<script language=javascript for=depart_date event="OnKillFocus()">
		if(depart_date.Text!="" && depart_date.Text.length==8 && v_goods.Index!=-1 && v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)!='0'){
			var v_param = "proType=S,dsType=1"
					+ ",v_goods_sid="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)
					+ ",v_depart_date="+ depart_date.Text;

			ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
	            "JSP(O:DS_TEMP=ds_temp)",
	            v_param);
	        tr_post(tr1);
		}
	</script>
	
	<script language=javascript for=v_goods event="OnSelChange()">
		if(depart_date.Text!="" && depart_date.Text.length==8 && v_goods.Index!=-1 && v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)!='0'){
			var v_param = "proType=S,dsType=1"
					+ ",v_goods_sid="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)
					+ ",v_depart_date="+ depart_date.Text;

			ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv240I",
	            "JSP(O:DS_TEMP=ds_temp)",
	            v_param);
	        tr_post(tr1);
		}
	</script>
	
	<script language=javascript for=ds_temp event="OnLoadCompleted(row)">
		if(row==0){
			alert("��ǰ : " + v_goods.Text + " ������� : " + depart_date.Text +" �� ���� �������� �����ϴ�.");
			return;
		}
	</script>
	
	<script language="javascript" for="tr1" event="OnFail()">
	    document.all.LowerFrame.style.visibility="hidden";
	    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	
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
	
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��������Ʈ  -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �ο�����Ʈ  -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��û����ȣ �űԽ�   -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ������� üũ   -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- RM014   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- RM015   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��������   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��������   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��������   -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds_stay classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �������   -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds_temp classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��������   -->
	<param name="SyncLoad" 	value="true">
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->	

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td>
				<table border='0' cellpadding='0' cellspacing='1' bgcolor="#666666"  width='220px'>
					
					<tr  height="30px">
						<td bgcolor="#FFFFFF"  width="100px" class='text'>����</td>
						<td bgcolor="#ffffff" width='100px'>&nbsp;
							<%=HDConstant.COMMENT_START%>
    						<object id=sSaupSid classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  class="txtbox"  align=absmiddle >
    							<param name=ComboDataID			value=codeDs3>
    							<param name=SearchColumn		value="saup_nm">
    							<param name=Sort				value="false">
    							<param name=ListExprFormat		value="saup_nm^0^140">
    							<param name=BindColumn			value="saup_sid">
    						</object>
                            <%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
			<td align="right" colspan='4'>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
				<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"	align=absmiddle onClick="fnAddRowDs1()">	<!-- �ű� -->
				<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand"	align=absmiddle onClick="fnApply();">			<!-- ���� -->
				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">			<!-- ��� -->
				<img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs1()">	<!-- ���� -->
			</td>
		</tr>
		<tr height="10px">
			<td></td>
		</tr>
		<tr>
			<td colspan="3"  border='0' cellpadding='0' cellspacing='0' width='845'>
				<table colspan="3"  border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height="30px">
						<td bgcolor="#FFFFFF" class="text" width="100px" >���¾�ü</td>
						<td  bgcolor="#FFFFFF" align="center" width="200px">
							<input type="text" name="sClient_nm" value="�ƻ��������η�" size="20" readonly="readonly" class="textbox">&nbsp;
							<input type="hidden" name="sClient_sid"  value="1051" size="5" readonly="readonly" class="textbox">&nbsp;
							<img src="<%=dirPath%>/Sales/images/help.gif" 	style="cursor:hand" 	align=absmiddle onClick="fnClientPopup();" >
						</td>
						<td bgcolor="#FFFFFF" class="text" width="100px">��û����</td>
						<td  bgcolor="#FFFFFF" align="center" width="200px">
							<%=HDConstant.COMMENT_START%>
							<object id=from_accept_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>			
								<param name=Alignment 	value=1>
								<param name=Format      value="YYYY-MM-DD">
                                <PARAM NAME=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
							</object>
							<%=HDConstant.COMMENT_END%>
							~
							<%=HDConstant.COMMENT_START%>
							<object id=to_accept_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>			
								<param name=Alignment 	value=1>
								<param name=Format      value="YYYY-MM-DD">
                                <PARAM NAME=InputFormat value="YYYYMMDD">
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
						<td bgcolor="#FFFFFF" class="text" width="100px">��û����ȣ</td>
						<td  bgcolor="#FFFFFF" align="center" width="120px">
							<input type="text" name="sAcceptNo" value="" size="15"  class="textbox" maxlength="15">
						</td>
						
					</tr>
				</table>
			</td>
		</tr>
		<tr height="15px">
			<td></td>
		</tr>
		<tr>
			<td width='210' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0' width='210'>
					<%=HDConstant.COMMENT_START%>
					<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='210px' height='400px' border='1'>
						<param name="DataID"			value="ds1">
						<param name="ColSizing"			value="true">
						<param name="Fillarea"			value="false">
						<param name="Editable"  		value="false">
						<param name="BorderStyle"      	value="0">
						<param name=FixSizing  			value="false">
						<param name=IndWidth  			value="20">	
						<param name="Format" 			value="
			               <C> name='��ûSID'   	ID='accept_sid'  	align=left width=60 	editlimit=12 	show=false</C>
			               <C> name='��û����ȣ'	ID='accept_no'   	align=left width=130 	editlimit=15 	show=true mask='XXXXX-XXXXXX-XXX'</C>
			               <C> name='��û����'  	ID='accept_date'	align=left width=80 	editlimit=8 	show=true  mask='XXXX-XX-XX' bgColor=<%=HDConstant.GRID_ITEM%></C>
						">											
					</object>	
					<%=HDConstant.COMMENT_END%>		
				</table>
			</td>
			<td width='15'>&nbsp;</td>
			<td valign="top">
				<table  border='0' cellpadding='0' cellspacing='0' width='620'>
					<tr>
						<td width='410px' valign="top" bgcolor=#ff0000>
							<table width='410px' border='0' cellpadding='0' cellspacing='1' bgcolor="#666666">
								<tr height="30px"> 
									<td class="boardt02" width="80px">��û����</td>
									<td bgcolor="#FFFFFF" align="center" width="100px">
										<%=HDConstant.COMMENT_START%>
										<object id=accept_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>			
											<param name=Alignment 	value=1>
											<param name=Format      value="YYYY-MM-DD">
	                                        <PARAM NAME=InputFormat value="YYYYMMDD">
	                                          <param name=Cursor      value="iBeam">
				                                <param name=Border      value="false">
				                                <param name=InheritColor      value="true">
				                                <param name=Enable    value="false">
				                                <param name=SelectAll   value="true">
				                                <param name=SelectAllOnClick    value="true">
				                                <param name=SelectAllOnClickAny   value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td  class="boardt02"  width="100px">��û����ȣ</td>
									<td  bgcolor="#FFFFFF" width='130px' align="center">
										<!-- <input type="text" name="accept_no" id="accept_no" value="" size="10"  class="textbox" readonly="readonly">&nbsp;-->
										<%=HDConstant.COMMENT_START%>
										<object id=accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>			
											<param name=Alignment 	value=1>
											<param name=Format 		value="#####-######-###">
											  <param name=Cursor      value="iBeam">
				                                <param name=Border      value="false">
				                                <param name=InheritColor      value="true">
				                                <param name=Enable    value="false">
				                                <param name=SelectAll   value="true">
				                                <param name=SelectAllOnClick    value="true">
				                                <param name=SelectAllOnClickAny   value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="30px"> 
									<td class="boardt02" width="80px">��ǰ�ڵ�</td>
									<td bgcolor="#FFFFFF" align="center" width="130px"><%=HDConstant.COMMENT_START%>
			                            <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=110 style="position:relative;left:1px;top:2px" class="txtbox" >
			                                <param name=ComboDataID         value=ds_goods>
			                                <param name=SearchColumn        value="GOODS_NM">
			                                <param name=Sort                value="false">
			                                <param name=ListExprFormat      value="GOODS_NM^0^130">
			                                <param name=BindColumn          value="GOODS_SID">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
									</td>
									<td  class="boardt02"  width="100px">�������</td>
									<td  bgcolor="#FFFFFF" width='130px' align="center">
										<!-- <input type="text" name="accept_no" id="accept_no" value="" size="10"  class="textbox" readonly="readonly">&nbsp;-->
										<%=HDConstant.COMMENT_START%>
										<object id=depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>			
											<param name=Alignment 	value=1>
											<param name=Format      value="YYYY-MM-DD">
	                                        <PARAM NAME=InputFormat value="YYYYMMDD">
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
								</tr>
							</table>
						</td>
						<td align="right" width='210px'>
							<img src="<%=dirPath%>/Sales/images/plus.gif"		style="cursor:hand" 	align=absmiddle onClick="fnAddRowDs2()" >		<!-- ���߰� -->
							<img src="<%=dirPath%>/Sales/images/minus.gif" 		style="cursor:hand" 	align=absmiddle onClick="fnDeleteRowDs2()" >		<!-- ����� -->
						</td>
					</tr>
					<tr height="5px">
						<td>
							
						</td>
					</tr>
					
					
					<tr>
						<td colspan="2"  width='620px'>
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='620px' height='140px' border='1'>
								<param name="DataID"			value="ds2">
								<param name="ColSizing"			value="true">
								<param name="Fillarea"			value="false">
								<param name="Editable"  		value="True">
								<param name="BorderStyle"      	value="0">
								<param name=FixSizing  			value="false">
								<Param Name="AllShowEdit"   value="True">
								<param name=IndWidth  			value="20">	
								<param name="Format" 			value="
					               <C> name='��������SID'  	ID='car_rsv_sid'    align=left width=100 	editlimit=12 	show=false </C>
					               <C> name='��ûSID'   		ID='accept_sid'  	align=left width=100 	editlimit=12 	show=false</C>
					               <C> name='����SID'      	ID='car_sid'     	align=left width=100 	editlimit=12 	show=false </C>
					               <C> name='����'       	ID='car_nm'      	align=left width=100 	editlimit=32 	show=true  	editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
					               <C> name='������Ϲ�ȣ'   	ID='car_no'      	align=left width=100 	editlimit=30 	show=true 	edit=none</C>
					               <C> name='�������'  		ID='depart_date'    align=left width=70 	editlimit=8 	show=true mask='XXXX-XX-XX' edit=none</C>
					               <C> name='���ð�'  		ID='depart_time'    align=left width=60 	editlimit=4 	show=true editstyle=lookup  data='codeDs1:detail:detail_nm' edit=none</C>
					               <C> name='�԰�����'  		ID='arrive_date'    align=left width=70 	editlimit=8 	show=true mask='XXXX-XX-XX' bgColor=<%=HDConstant.GRID_ITEM%></C>
					               <C> name='�԰�ð�'  		ID='arrive_time'    align=left width=60 	editlimit=4 	show=true editstyle=lookup  data='codeDs2:detail:detail_nm' bgColor=<%=HDConstant.GRID_ITEM%></C>
					               <C> name='��⿩��'  		ID='long_stay_yn'    align=left width=60 	editlimit=4 	show=true editstyle=lookup  data='ds_stay:detail:detail_nm' bgColor=<%=HDConstant.GRID_ITEM%></C>
					               <C> name='�������԰���'        	ID='car_desc'       	align=left width=80 	editlimit=100 	show=true</C>
					               <C> name='ȭ��'        	ID='cargo'       	align=left width=80 	editlimit=100 	show=true</C>
					               <C> name='��������SID'    ID='drive_sid'   	align=left width=100 	editlimit=12 	show=false</C>
					               <C> name='������'      	ID='cust_nm'     	align=left width=100 	editlimit=30 	show=true 	editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
					               <C> name='�ֹο��ǹ�ȣ'   	ID='manage_no'   	align=left width=100 	editlimit=20 	show=true 	edit=none</C>
					               <C> name='���������ȣ'   	ID='drive_no'   	align=left width=100 	editlimit=20 	show=true 	edit=none</C>
					               <C> name='�븮��SID'   	ID='client_sid'  	align=left width=100 	editlimit=12 	show=false </C>															             
								">											
							</object>	
							<%=HDConstant.COMMENT_END%>	
						</td>
					</tr>
					<tr height="5px">
						<td></td>
					</tr>
					<tr height="30px">
						<td colspan="2" align="right"  width='620'>
							<img src="<%=dirPath%>/Sales/images/plus.gif"		style="cursor:hand" 	align=absmiddle onClick="fnAddRowDs3()" >		<!-- ���߰� -->
							<img src="<%=dirPath%>/Sales/images/minus.gif" 		style="cursor:hand" 	align=absmiddle onClick="fnDeleteRowDs3()" >		<!-- ����� -->
						</td>
					</tr>
					<tr height="5px">
						<td></td>
					</tr>
					<tr>
						<td colspan="2"  width='620'>
							<%=HDConstant.COMMENT_START%>
							<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width='620px' height='140px' border='1'>
								<param name="DataID"			value="ds3">
								<param name="ColSizing"			value="true">
								<param name="Fillarea"			value="false">
								<param name="Editable"  		value="True">
								<param name="BorderStyle"      	value="0">
								<param name=FixSizing  			value="false">
								<Param Name="AllShowEdit"   value="True">
								<param name=IndWidth  			value="20">	
								<param name="Format" 			value="
									<C> name='��ûSID'  	ID='accept_sid'   	align=left width=100 editlimit=12 show=false</C>
								 	<C> name='����SID'  	ID='rsv_sid'    	align=left width=100 editlimit=12 show=false</C>
					               <C> name='��SID'   	ID='cust_sid'    	align=left width=100 editlimit=12 show=false</C>
					               <C> name='�ѱۼ���'	ID='cust_nm'     	align=left width=100 editlimit=30 show=true editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
					               <C> name='�ֹ�/���ǹ�ȣ'	ID='manage_no'   	align=left width=100 editlimit=20 show=true edit=none</C>
					               <C> name='��������'	ID='cust_type'	align=left width=70 editlimit=8 	editstyle=lookup  data='ds_cust:detail:detail_nm' edit=none</C>
					               <C> name='�������'	ID='depart_date'	align=left width=70 editlimit=8 	show=true mask='XXXX-XX-XX' edit=none</C>
					               <C> name='���ð�'  	ID='depart_time'	align=left width=60 editlimit=4 	show=true editstyle=lookup  data='codeDs1:detail:detail_nm' edit=none</C>
					               <C> name='�԰�����'  	ID='arrive_date'	align=left width=70 editlimit=8 show=true mask='XXXX-XX-XX bgColor=<%=HDConstant.GRID_ITEM%>'</C>
					               <C> name='�԰�ð�'  	ID='arrive_time'	align=left width=60 editlimit=4 show=true editstyle=lookup  data='codeDs2:detail:detail_nm' bgColor=<%=HDConstant.GRID_ITEM%></C>
					               <C> name='��⿩��'  		ID='long_stay_yn'    align=left width=60 	editlimit=4 	show=true editstyle=lookup  data='ds_stay:detail:detail_nm' bgColor=<%=HDConstant.GRID_ITEM%></C>
					               <C> name='��������'   	ID='drive_yn'		align=left width=100 editlimit=1 show=true editstyle=lookup  data='codeDs4:detail:detail_nm' edit=none</C>
					               <C> name='��ϸ���'	ID='north_purpose'	align=left width=100 editlimit=62 show=true</C>															             
					               <C> name='�������ȣ'	ID='n_card_no'	align=left width=100 show=true edit=none</C>
					               <C> name='�ǹ���ȣ'	ID='work_no'	align=left width=100 show=true edit=none</C>
								">											
							</object>	
							<%=HDConstant.COMMENT_END%>							
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
 <%
/*=============================================================================
                        Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
        <param name="DataId" value="ds1">
        <param name=BindInfo    value="
            <C>Col=accept_sid               Ctrl=accept_sid         Param=value </C>
            <C>Col=accept_no                Ctrl=accept_no          Param=Text </C>
            <C>Col=accept_date              Ctrl=accept_date        Param=Text </C>
            <C>Col=goods_sid              Ctrl=v_goods        Param=BindColVal </C>
            <C>Col=depart_date              Ctrl=depart_date        Param=Text </C>
        ">
</object>
<%=HDConstant.COMMENT_END%>	
        
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

