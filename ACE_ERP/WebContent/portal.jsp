<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: �α��� ��Ż- ����
 * ���α׷�ID 	: index
 * J  S  P		: index.jsp
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2010-09-08
 * �������		: Ʈ���޴� ������ erp ������Ż
 * [ �������� ][������] ����
 * [2010-09-07][�ɵ���] �̰��� ǥ�� 
 * [2010-09-09][�ɵ���] �޴�Ʈ�� ��ȸ ���ν��� ������ : ��ü �޴� ���� �ִ� �͸�~!
 * [2011-04-05][�ɵ���] ��Żȭ������ ����� Ʈ�� ����. �� ������ �����ܸ� ����
 * [2011-05-27][�ɵ���] XHTML 1.0 ���� ǥ���۾��� �ݿ��ұ� �ϰ� �ִµ�..��;;
 *						�ϴ��� �α��κ��� �ݿ��س��� ���̾ƿ��� ��ġ��..ů..
 * [2011-06-01][�ɵ���] UI�� 1024*768 �ּ� ����. �׽�Ʈ�غ� ��~
 * [2011-08-19][�ɵ���] �޴� ������ ���� ���� �� ��Ÿ �˸�, ���ã�⵵ ���..ů;;
 * [2011-10-14][�ɵ���] ������ ����, �����ҹ���(common.ApManager) �߰�
 * [2011-12-13][�ɵ���] EHR ����.. ��..
 * [2013-07-19][�ɵ���] ���հ��� �޴� �߰� (���ø�)
 * [2013-10-23][�ɵ���] �籸��-���� �̽�
 *						UI ����? �޼��� ��?  ������?, ��ư? ����..
 * [2013-11-13][�ɵ���] ������ ����, �������� ��java ���� ����		 
 * [2013-11-21][�ɵ���] UI ����, �ҽ� ����~  
 * [2015-01-07][�ɵ���] ���� ��� ��ü
 * [2020-02-18][�̵���] ���ʿ��� ȭ�� ���� �� Push �޼��� �����ֱ�
 *****************************************************************************/

///////////////////////////////////////////////////////////////////////////////
//Description 	:  JAVA Import ����
%>

<%@ page import="sales.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="common.ApManager" %>
<%@ page import="common.VacManager" %>
<%@ page import="common.MsgManager" %>


<%	
		// ContextPath ���� ����.
		String dirPath = request.getContextPath(); //HDASan
		// local ServerScript
		// ����ƻ� ����, �븮��/���¾�ü ����
		// Value = ERP, Value=Tour
		// ERP�� ��� = 

		//	�����ð� �����
	   java.util.Calendar date = java.util.Calendar.getInstance();
	   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("ssMMmmyyyyHHdd");
	   String strD = m_today.format(date.getTime());
	
	try {
		


		SmartRequest sr = new SmartRequest(request);
		//�α��� �������� �ҷ����� �� /////011-06-14 �ɵ������� ///////////////////////////////////////////////////////////////////////////////////////
		String gusrid	= (String)session.getAttribute("vusrid");
		String gusrnm	= (String)session.getAttribute("vusrnm");
		String ssID		= sr.getString("ssID");				//������ �̵��� ����ID üũ(�̰� ������ ���� ���� ������?)
		String gusrpos	= (String)session.getAttribute("vusrpos");	//������ �̵��� ���Ǻ���("�α�") üũ
		String gusrip	= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ
		//�α��� �������� �ҷ����� �� /////
		
		
		String key 			= HDUtil.nullCheckStr(request.getParameter("search_key"));
		String values 		= HDUtil.nullCheckStr(request.getParameter("search_value"));
		String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
		String pageSize  	= "10";  	//1�������� ǥ�õ� ����
		String where_sql3     = "";
		String brd_gu = "01";	//���� ����~!
		


		//�������� ���� //////////////////////////////////////////////////////////////////
		//�������� �θ��� (�븮����?)
		SmartRequest sr3 = new SmartRequest(request);
		int	view_cnt=6;
	
		//������ �����.
		if (values !=  null && !values.equals("")){	
	    	where_sql3=" AND " + key + " like '%" + values + "%'";
		}
	   	where_sql3 = "";	// �ӽ� �⺻�� ����
	   
		ArrayList data3 = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
		int len3 = 0;
		BaseDataClass bean3;
	
		ArrayList data_all = new ArrayList();	//�Խù� ��ü ī��Ʈ�� �޾ƿ� �� ����.     
		
		sr3.setObject("where_sql",(Object)where_sql3);						//������ ����
		sr3.setObject("brd_gu",(Object)brd_gu);									//���� ���� ����
		sr3.setObject("requestedPage",(Object)requestedPage);			//��û������ ����
		sr3.setObject("pageSize",(Object)pageSize);								//������ ������ ����
	
		My210Manager manager3 = new My210Manager();
		//data3 		= manager3.list(sr3);											//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		manager3.close();
		//�������� �� //////////////////////////////////////////////////////////////////





		//������ ���� //////////////////////////////////////////////////////////////////
		SmartRequest sr4= new SmartRequest(request);

		key 		     = sr4.getString("search_key");
		values 		 = sr4.getString("search_value");
		// �ᱹ �ѱ��� �޾ƿ��鼭 ������ ���� �����Դϴ�. ��_��;; ��..
		// ��Ƽ��Ʈ�� ������ �ȴ�!
		//requestedPage = sr4.getString("requestedPage");
		requestedPage = "1";
		pageSize  	 = "5";  	//1�������� ǥ�õ� ����
		String where_sql4    = "";

		ArrayList data4 = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
		int len4 = 0;
		brd_gu = "01";	//���� ����~!
		BaseDataClass bean4;

		ArrayList data_all4 = new ArrayList();	//�Խù� ��ü ī��Ʈ�� �޾ƿ� �� ����.     
		
		//�̺κ��� ����� �Ŵ������Ͽ��� sr.getObject()�� �о�� �� �ִ�.
		sr4.setObject("where_sql",(Object)where_sql3);	//������ ����
		sr4.setObject("brd_gu",(Object)brd_gu);			//���� ���� ����
		sr4.setObject("requestedPage",(Object)requestedPage);	//��û������ ����
		sr4.setObject("pageSize",(Object)pageSize);			//������ ������ ����
		sr4.setObject("search_key",(Object)key);			//������ ������ ����
		sr4.setObject("v_login_id",(Object)gusrid);		//�α� ���̵� ���� 
		sr4.setObject("v_login_name",(Object)gusrnm);		//�α� �̸� ���� 
		
		My710Manager manager4 = new My710Manager();
		//data4 		= manager4.list(sr4);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		//data_all4 	= manager4.alllist(sr4);	//�ش� ������ ��ü �Խù� ���� ī��Ʈ�ؿ���
		manager4.close();
	
		//������ ��//////////////////////////////////////////////////////////////////////




		//���� �޼��� ���� //////////////////////////////////////////////////////////////////
		SmartRequest sr_msg= new SmartRequest(request);	

		ArrayList data_msg = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
		int len_msg = 0;
		BaseDataClass bean_msg;
	
		//�̺κ��� ����� �Ŵ������Ͽ��� sr.getObject()�� �о�� �� �ִ�.
		sr_msg.setObject("v_login_id",(Object)gusrid);					//�α� ���̵� ���� 
		
		MsgManager manager_msg = new MsgManager();
		data_msg		= manager_msg.list(sr_msg);						//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		manager_msg.close();
		//���� �޼��� ��//////////////////////////////////////////////////////////////////////	





		//�����ҹ��� ���� //////////////////////////////////////////////////////////////////
		SmartRequest sr_ap= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	 = "6";  	//1�������� ǥ�õ� ����
		ArrayList data_ap = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
		int len_ap = 0;
		BaseDataClass bean_ap;
	
		//�̺κ��� ����� �Ŵ������Ͽ��� sr.getObject()�� �о�� �� �ִ�.
		sr_ap.setObject("requestedPage",(Object)requestedPage);	//��û������ ����
		sr_ap.setObject("pageSize",(Object)pageSize);			//������ ������ ����
		sr_ap.setObject("v_login_id",(Object)gusrid);		//�α� ���̵� ���� 
		
		ApManager manager_ap = new ApManager();
		data_ap		= manager_ap.list(sr_ap);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		manager_ap.close();
		//�����ҹ��� ��//////////////////////////////////////////////////////////////////////



		//������Ȳ ���� //////////////////////////////////////////////////////////////////
		SmartRequest sr_vac= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	 = "6";  	//1�������� ǥ�õ� ����
		ArrayList data_vac = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
		int len_vac = 0;
		BaseDataClass bean_vac;
	
		//�̺κ��� ����� �Ŵ������Ͽ��� sr.getObject()�� �о�� �� �ִ�.
		sr_vac.setObject("requestedPage",(Object)requestedPage);	//��û������ ����
		sr_vac.setObject("pageSize",(Object)pageSize);			//������ ������ ����
		sr_vac.setObject("v_login_id",(Object)gusrid);		//�α� ���̵� ���� 
		//sr_vac.setObject("v_login_deptcd",(Object)v_login_deptcd);		//�α� ���̵� ���� 
		
		VacManager manager_vac = new VacManager();
		data_vac		= manager_vac.list(sr_vac);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		manager_vac.close();
		//������Ȳ ��//////////////////////////////////////////////////////////////////////
			


		//���� tree_idx
		int tree_idx = 0;


%>


	
<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
		<meta http-equiv="Cache-control" content="no-cache"/>
		<meta http-equiv="Cache-control" content="no-store"/>
		
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=1080" />
		<title>������ �ݰ���(����)����������������������������������������������������������������������������������������������������������������������������</title>
		<link rel="shortcut icon" href="<%=dirPath%>/Common/img/iconlogo.jpg" />
<%
/*=============================================================================
			Style Sheet, Common Java Script Link
=============================================================================*/



	// (ssID + ���������ǰ� + IP) ��
	//���� �Բ� ���� ȭ������ �� �α׾ƿ� �������� ���� ������ �� ������ ������~!!!
	
	//System.out.println("session.getId().substring(0,40) -->" + session.getId().substring(0,40));
	//System.out.println("ssID.substring(0,40) -->" + ssID.substring(0,40));	


	if(!ssID.substring(0,40).equals(session.getId().substring(0,40)) || !gusrpos.equals("Tadaima") ){		//����
	//if(!ssID.substring(0,40).equals(session.getId().substring(0,40)) || !gusrip.equals(request.getHeader("Proxy-Client-IP")) || !gusrpos.equals("Tadaima") ){		//����2016.01.14
	//if(!ssID.equals(session.getId()) || !gusrip.equals(request.getRemoteAddr()) || !gusrpos.equals("Tadaima") ){		//����
		%>
		
		
		<script type="text/javascript">
			alert("�ð��� �����Ǿ� �ڵ� �α׾ƿ��Ǿ����ϴ�.\n\n���� �α��� ���ּ���.");
			top.location.href="<%=dirPath%>/Common/sys/logout.jsp";
		</script>


		<%
		return;
	}
	//�α��� üũ �� ///////////////////////////////////////////////////////////////////////////////////////
%>



	<link href="<%=dirPath%>/Common/css30/basic.css" rel="stylesheet" type="text/css">
	<link href="<%=dirPath%>/Common/css30/layout.css" rel="stylesheet" type="text/css">	

	<script language="javascript" src="<%=dirPath%>/Common/js/portal.js"></script>

	<!-- 
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/PubFun.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/embedControl.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/menu.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_gauce.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_pop.js"></script>      
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common.js"></script>        
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/em.js"></script>  
	 -->


	<%//	������ ��ũ��Ʈ	------------------------------------------------------------------		%>		
	<script type="text/javascript">

		var menuWin;

		var gTime;

		/* �������ε� */
		function fnOnLoad(tree_idx){		

			//�ƻ� EHR �̰��� üũ//2011-12-13
			//GetHRCnt();
			//window.setInterval(ChkUniHRApproval, 5000 * 60);	

		}


		function chk_safety(param1){

	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	        	+ "empno=" + param1;	

			ln_TRSetting(tr_safety,
	        	"<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>ChkSafety", 
	        	"JSP(O:DS_SAFETY=ds_safety)",
	       		param);

	        tr_post(tr_safety);	
			
		} 		 
	


		/* �������� �Ⱦ�_20200218 �̵���*/
		function view_send(brd_no){
	
			var f = document.form1;
			f.action="<%=dirPath%>/Sales/my/my210_read.jsp?idx=404";
			f.brd_no.value = brd_no;
			f.method = "POST";
			f.target="";
			
			f.submit();

		} 


		/* ���� ������ �Ⱦ�_20200218 �̵���*/
	   function view_send4(brd_no,ref,ref_step){
			var readURL ="<%=dirPath%>/Config/my/my710_read_pop.jsp?pageFrom=710&idx=400&brd_no="+brd_no+"&ref="+ref+"&ref_step="+ref_step;
		   	window.open(readURL,"memoRead_from","width=480,height=450,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
	   }
		
	
		// EHR ����////////////////////////////////////////////////////		
		/* [�λ�] ������ ���� �� */
		function view_send_ehr(Menutype){	

			var readURL ="<%=dirPath%>/Ehr/hr/cod/codd010.jsp?idx=2694";	
			window.open(readURL,"memoRead_from","width=1100,height=800,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");		
      
		}
		

		function view_send_act(Menutype){	
			
			var readURL ="<%=dirPath%>/Ehr/hr/acq/acqa090.jsp";	
			window.open(readURL,"memoRead_from","width=1100,height=800,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");		   
			
		}


		function view_message(){	
			
			var readURL ="<%=dirPath%>/Ehr/hr/cod/codd050.jsp?idx=2694";	
			window.open(readURL,"memoRead_from","width=1100,height=800,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");	    
			
			document.movForm.target="_self";
			document.movForm.action=page+ ""+ param;
			document.movForm.submit();
			
			
		}





		/* [�λ�] ���� - �޴� ������ */
		function move_ehr_icon(Menutype){	
			var sURL = "https://ehr.hdasan.com:449/hrms_sso.jsp";
			SSORedirection2.action=sURL;
			SSORedirection2.gw_menunum.value= Menutype;
			SSORedirection2.target="_blank";
			SSORedirection2.MENU_ID.value="erp";
			SSORedirection2.submit();              
		}



		function move_ehr_yac(Menutype){	
			//yaca020 = �Է�, yaca050 = ��� ��ȸ
			//var menuWin1 = "http://ace.hdasan.com/Ehr/hr/yac/yaca050_14.jsp?idx=6103";
			//window.open(menuWin1, menuWin,"width=1080,height=790,status=yes,menubar=no,toolbar=no,scrollbars=yes,titlebar=yes,resizable=yes");

			//alert("��� ��ȸ �Ⱓ�� �������ϴ�");

			/*var sURL = "http://ehr.hdasan.com/hrms_sso.jsp";
			SSORedirection2.action=sURL;
			SSORedirection2.gw_menunum.value= Menutype;
			SSORedirection2.target="_blank";
			SSORedirection2.MENU_ID.value="yac";
			SSORedirection2.submit();              */
		}


		// EHR ����////////////////////////////////////////////////////	


		function move_gw(){//�׷���� �������� ����	2016-03-22

			var gwURL ="http://portal.hdasan.com/employee/hda/Lists/10002_7/DispForm.aspx?ID=633&IsDlg=2";
		   	window.open(gwURL,"gw_notice","width=1040,height=750,scrollbars=yes,toolbar=yes,location=yes,top=100,left=100,resizable=yes,status=yes");

		}
	

		document.onkeydown = function() {	//�� �������� ���� ���� ��ũ��Ʈ.

			if( event.keyCode ==119 ) { //F2=113, F8=119
				helpme();				//��� ȣ��
	            event.keyCode = 0;
	            event.cancelBubble = true;
	            event.returnValue = false;
			}

		}



		function helpme(){	//���� ���� ���
			window.open("<%=dirPath%>/Helpshop/baseFrame.jsp?menu_idx=<%=tree_idx%>","Helpshop","width=900px, height=700px, resizable=yes,");
		}
		

		function moveMove(page,param){	//�� ����

			document.movForm.target="_self";
			document.movForm.action=page+ ""+ param;
			document.movForm.submit();

		}

		
		function moveMoveN(page,param){		<%//������ �̵� : ��â%>
			
			gTime = new Date();
			menuWin = "mWin"+gTime.getTime();	//��â�� �̸� ����. �ð� ���̽����ؼ� ��� ������.
			document.movForm.target= menuWin;						//Ÿ���� ��â����
			document.movForm.action=page+"?idx="+ param;				//�� ������
			window.open("", menuWin,"width=1080,height=790,status=yes,menubar=no,toolbar=no,scrollbars=yes,titlebar=yes,resizable=yes");
			window.opener=this;
			document.movForm.submit();	
			
		}	


		/* ������ ���� */
		function view_send_ap(){

			moveMoveN("<%=dirPath%>/Config/ap/ap100i.jsp","951");

		}


		function fnSetHeader_tree(){		<%//�޴�Ʈ��-����Ÿ�� ��� ����  %>

			if (ds_tree.countrow < 1){
				var s_temp1 = "TREE_LV:STRING,TREE_ID:STRING,TREE_IDX:INT,TREE_NM:STRING,TREE_TYPE:STRING,TREE_SEQ:INT,TREE_FILE:STRING";
				ds_tree.SetDataHeader(s_temp1);
			}	

		}
		


		function fnInit_tree(tree_idx, menuSeq){		<%//�޴�Ʈ��-��ȸ %>

			//���ã�� 00 //�� �λ� 01 // ȸ�� 02	// ���� 04 // ���� 05 // ���� 07	// ���� 10 // ���� 08	// ���� 09 // ȯ�漳�� 03 // ���հ���(�ݰ���) 13 // �η°���(����) 14 // Ehr 15 // PMS 16 // ����new 17
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	        	+ "tree_idx=" + tree_idx;	//���õ� �޴� idx�� ������.
			ln_TRSetting(tr_tree,
	        	"<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm011I_"+ menuSeq,	//���⸦ �ٲٸ� 
	        	"JSP(O:DEFAULT=ds_tree)",
	       		param);
	        tr_post(tr_tree);

		}	
		


		function setTree(menuSeq){
			if(menuSeq=="00"){
				mcMenuTit.innerHTML="�� �� ã ��";
			}else if(menuSeq=="20"){
				mcMenuTit.innerHTML="�� ��";	//Ehr
			}else if(menuSeq=="02"){
				mcMenuTit.innerHTML="ȸ ��";
			}else if(menuSeq=="11"){
				mcMenuTit.innerHTML="Action Plan";
			}else if(menuSeq=="04"){
				mcMenuTit.innerHTML="�� ��";
			}else if(menuSeq=="05"){
				mcMenuTit.innerHTML="�� ��";
			}else if(menuSeq=="07"){
				mcMenuTit.innerHTML="�� ��";
			}else if(menuSeq=="08"){
				mcMenuTit.innerHTML="�� ��";
			}else if(menuSeq=="09"){
				mcMenuTit.innerHTML="�� �� �� ȣ";
			}else if(menuSeq=="10"){
				mcMenuTit.innerHTML="�� ��";
			}else if(menuSeq=="03"){
				mcMenuTit.innerHTML="ȯ �� �� ��";
			}else if(menuSeq=="13"){
				mcMenuTit.innerHTML="�� �� ��";
			}else if(menuSeq=="14"){
				mcMenuTit.innerHTML="�� ��";
			}else if(menuSeq=="16"){
				mcMenuTit.innerHTML="P M S";
			}else if(menuSeq=="17"){
				mcMenuTit.innerHTML="�� ��";
			}
			
			//�� �����ϰ� ®�� ��.��. 
			/*document.all.mcAMenu00.style.backgroundPosition="6px 0px";
			document.all.mcAMenu15.style.backgroundPosition="6px 0px";
			//document.all.mcAMenu01.style.backgroundPosition="6px 0px";
			document.all.mcAMenu02.style.backgroundPosition="6px 0px";
			document.all.mcAMenu04.style.backgroundPosition="6px 0px";
			document.all.mcAMenu05.style.backgroundPosition="6px 0px";
			document.all.mcAMenu07.style.backgroundPosition="6px 0px";
			document.all.mcAMenu08.style.backgroundPosition="6px 0px";
			document.all.mcAMenu09.style.backgroundPosition="6px 0px";
			document.all.mcAMenu10.style.backgroundPosition="6px 0px";
			document.all.mcAMenu03.style.backgroundPosition="6px 0px";
			//document.all.mcAMenu13.style.backgroundPosition="6px 0px";
			//document.all.mcAMenu14.style.backgroundPosition="6px 0px";
			document.all.mcAMenu16.style.backgroundPosition="6px 0px";*/
			//��ư�� Ŭ��������� �����ֱ� 
			//eval("document.all.mcAMenu"+menuSeq).style.backgroundPosition="6px -46px";	//��Ű! ����! �ڹٽ�ũ��Ʈ���� CSS�� ������ �� �ִ�. Jquery ���� lib�� ���� ��
			//������ ������� ���ư��� �ʳ�.. ��


			fnInit_tree(0,menuSeq);

		}
		
		function setCenterIco(param){		<%//���� ������ ����%>

			for(i=1; i<4; i++) {
				eval("document.all.area"+i).style.display="none";//���̾ �⺻����
				eval("document.images.ico"+i).src="images/icon/ci_"+i+".png";//�������� �⺻����
			}

			eval("document.all.area"+param).style.display="block";
			eval("document.images.ico"+param).src="images/icon/ci_"+param+"_o.png";//�������� ����

		}
		
	</script>



	<%// 	���콺 �̺�Ʈ ��ũ��Ʈ------------------------------------------------------------------		%>
    <script language=JavaScript  for="ds_tree" event="OnLoadCompleted(row)">

		if(row>0){

			tb_TreeView.focus();
			tb_TreeView.ExpandLevel = '1';
			tb_TreeView.index=4;
			//tb_TreeView.expand=row;
			//window.setTimeout(function(){tb_TreeView.index=1}, 2000);

        }

    </script>



	<script language="javascript" for="tb_TreeView" event="OnDblClick()" >

		//�޴�Ʈ�� ����Ŭ�� �̺�Ʈ
		var fileName = ds_tree.namevalue(ds_tree.rowposition,"TREE_FILE");
		var lev      = ds_tree.namevalue(ds_tree.rowposition,"TREE_LV");
		var idx      = ds_tree.namevalue(ds_tree.rowposition,"TREE_IDX");
		
		if(lev=='4'){	//4���� �϶��� ȭ�� �̵�.

			if(idx==287||idx==603||idx==376){
				//alert(idx+"��ݰ���!") ��ȸ
				moveMoveN("http://ace.hdasan.com<%=dirPath%>/"+fileName+".jsp",idx);
			}else{
				moveMoveN("<%=dirPath%>/"+fileName+".jsp",idx);
			}

		}
	</script>



    <script language=JavaScript  for="ds_safety" event="OnLoadCompleted(row)">

    	var resYN =ds_safety.namevalue(ds_safety.rowposition,"RES");//������� �޾Ƽ� 	

		if (resYN=="N"){//�̼����ΰ� N�̸�

			//alert(document.all.top_notice);
			document.all.top_notice.style.display = "";//â�� �����

		}

	</script>



	<!-- gauce ds -->
	<object id=ds_tree classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False"/>
	</object>



	<!-- gauce tr -->
	<object  id="tr_tree" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyName"    value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>



	<% //������ 2016�������Ǳ���  %>
	<object id=ds_safety classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False"/>
	</object>


	<object  id="tr_safety" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyName"    value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>

</head>





<!-- BODY header begin-->
<body onload="fnOnLoad(0);">


<!-- form ���� -->
<form name="FormPortal">


<div id="wrap">

    <!-- header -->
    <div id="header">

		<div id="haHeaderTop">
			<table border=0 cellspacing=0 cellpadding=0 width=100%>
			  <tr>
				<td width="158px" class="c b" style="padding-bottom:2px;cursor:pointer;"><img src="<%=dirPath%>/images/Common/logo.gif" onclick="moveMove('<%=dirPath%>/portal.jsp','');"/></td>
				<td width="150px" >&nbsp;</td>
				<td class="l b">&nbsp;</td>
				<td class="r b" style="padding-bottom:1px"></td>
			  </tr>
			</table>
		</div>

		<div id="haHeaderMenu">
			<table width=100%>
			  <tr>
				<td width="158" height="27" class="c b bold" style="color:#ffffff"><%=gusrnm%> (<%=gusrid%>)</td>
				<td class="r b bold"><a href="#" onclick="moveMove('<%=dirPath%>/Common/sys/logout.jsp','');"><font color=#ffffff>Logout</font></a>&nbsp;&nbsp;</td>

			  </tr>
			</table>
		</div>    

    </div>
	<!-- //header -->
    
    
    
    <!-- container -->
    <div id="container">
		<!--||| Menu Area  |||-->
		<div class="mcLeftCol" >
			<!--||| MAIN CONTENTS SHORTCUT �ٷΰ��� |||-->
			<div class="mcShortcut" >
				<div class="mcSCicon"><a href="#" onclick="setTree('00')" class="mcLMenu00" id="mcAMenu00"><span>���ã��</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('20')" class="mcLMenu15" id="mcAMenu15"><span>�λ�</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('02')" class="mcLMenu02" id="mcAMenu02"><span>ȸ��</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('11')" class="mcLMenu11" id="mcAMenu11"><span>Action Plan</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('08')" class="mcLMenu08" id="mcAMenu08"><span>����</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('04')" class="mcLMenu04" id="mcAMenu04"><span>����</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('05')" class="mcLMenu05" id="mcAMenu05"><span>����</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('17')" class="mcLMenu07" id="mcAMenu07"><span>����</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('10')" class="mcLMenu10" id="mcAMenu10"><span>�������</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('16')" class="mcLMenu16" id="mcAMenu16"><span>PMS</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('09')" class="mcLMenu09" id="mcAMenu09"><span>������ȣ</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('03')" class="mcLMenu03" id="mcAMenu03"><span>ȯ�漳��</span></a></div>
				<!-- <div class="mcSCicon" align="center">
					<div class="mcSCiconT" ><a href="#" onclick="setTree('01')"><img src="images/icon/mi01g.png" class="mcImg" alt="(�λ�)" /></a></div>
				</div>
				<div class="mcSCicon" align="center">
					<div class="mcSCiconT" ><a href="#" onclick="setTree('13')"><img src="images/icon/mi13.png" class="mcImg" alt="���հ���" /></a></div>
				</div>
				<div class="mcSCicon" align="center">
					<div class="mcSCiconT" ><a href="#" onclick="setTree('14')"><img src="images/icon/mi14.png" class="mcImg" alt="�η°���" /></a></div>
				</div> -->
			</div>
			<!-- //�޴������� -->
		

			<div id="mcSpace" >&nbsp;</div>
	

			<div id="mcMenu" >	<!--||| MAIN Menu Tree  |||-->

				<div id="mcMenuTit" class="mcMenuTitle c bold" >�� �� ã ��</div>

				<!-- [2013-11-21][�ɵ���] �޴� ǥ�� UI ���� ����Ʈ�� ���ã��~! -->
				<object id=tb_TreeView classid=CLSID:4401B994-DD33-11D2-B539-006097ADB678 style="border:0 solid #708090; WIDTH: 100%; HEIGHT: 658px;"> 
					<param name=DataID					value="ds_tree"/>
					<param name=TextColumn			value="TREE_NM"/>
					<param name=TypeColumn			value="TREE_Type"/>
					<param name=LevelColumn			value="TREE_LV"/>
					<param name=BorderStyle  			value="0"/>
					<param name=HasLines      			value="false"/> 
					<param name="UseImage"			value="true"/>
					<param name="ItemEnable"			value="Enable"/>
					<param name="SingleExpand"		value="true"/>
				</object>
			</div><!-- menu tree end -->
			
		
		</div>
		<div id="mcSpace" >&nbsp;</div>
		<div id="mcCenterCol" >


			<!-- �޼����� -->
			<div class="mcMemo">
			  <table width="428" border="0" cellspacing="0" cellpadding="1">
				<tr>
				  <td><b>������ �޼���</b>��������������������������������������������
					  <a href="#" onclick="view_message()" ><img src="<%=dirPath%>/Sales/images/more.gif" border="0"/></a></td>
				</tr>
				<tr>
				  <td align="center"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="428" height="2"/></td>
				</tr>
				<tr>
				  <td valign="top" height="95">
					<table width="418" border="0" cellspacing="0" cellpadding="1" align="center">
			            <% //���� �޼�����
			               if(data_msg == null || data_msg.size() < 1 ) {
			            %>
						<tr>
							<td height="90" align="center" valign="middle" colspan="4">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
						</tr>	
								                        
			            <%
			            	}else {
			            		
			                  len_msg = data_msg.size();
			                  
			                  bean_msg = null;
			                  
								for(int h=0; h<len_msg; h++) {
									
									bean_msg = (BaseDataClass)data_msg.get(h);
									

				            %>
							<tr height=19>
								<td align="center"><b>��Ȯ�� �޼��� <%=bean_msg.get("cnt")%>���� �����մϴ�.</b></td>
				 			</tr>
						   <%
				               		}
				           		}
						   %>							
					</table>
					
				  </td>
				</tr>
			  </table>

			</div>	
			<!-- //�޼����� -->


			<!-- ������Ȳ -->
			<div class="mcVac">
			  <table width="428" border="0" cellspacing="0" cellpadding="1">
				<tr>
				  <td><b>���� ���� ��Ȳ</b></td>
				</tr>
				<tr>
				  <td><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="428" height="2"></td>
				</tr>
				<tr>
				  <td valign="top" height="470">
					<table width="428" border="0" cellspacing="0" cellpadding="1">
		            <% //�� ���� ��Ȳ : 20120201
		               if(data_vac == null || data_vac.size() < 1 ) {
		            %>
					<tr>
						<td height="60" align="center" valign="middle" colspan="4">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
					</tr>			                        
		            <%
		            	}else {
		                  len_vac = data_vac.size();
		                  bean_vac = null;
		
							for(int h=0; h<len_vac; h++) {
		                     	bean_vac = (BaseDataClass)data_vac.get(h);
								//bean_vac.get("eno_no") �̰� ���
								String v_day1="";	
								String v_deptnm="";
								v_day1=bean_vac.get("day"); // �̰� ��������
								v_deptnm=bean_vac.get("dpt_nm");
		            %>
					<tr height=19>
						<td width="60" align="center"><%=bean_vac.get("day")%> (<%=bean_vac.get("dy")%>)</td>
						<td width="90" align="center"><%=bean_vac.get("job_nm")%></td>
						<td width="80" align="center"><%=bean_vac.get("eno_nm")%></td>
						<td width="80" align="center"><b><%=bean_vac.get("vac")%></b></td>
		 			</tr>
				   <%
		               		}
		           		}
				   %>
					</table>
				   </td>
				</tr>
			  </table>
			</div>	
			<!-- //������Ȳ -->

		</div>


		<div id="mcSpace" >&nbsp;</div>


		<div id="mcRightCol" >
			<div class="mcProfile"><!-- �α� ������ -->
				<span style="padding-bottom:1px;COLOR:#696969;font-weight:bold;padding-left:6px">My Area</span>
			</div>	<!-- //�α� ������ -->

<!-- **********************************************************************************************  -->
<!-- **********************************************************************************************  -->
<!--                                                             2019.03.29 Action Plan Ȯ���� ���� �߰���                                                                    -->
<!-- **********************************************************************************************  -->
<!-- **********************************************************************************************  -->
			<div class="mcApproval"><!-- Ȯ���� ���� -->
			  <table width="198" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td width="198"><b>��Ȯ���� ����</b></td>
				</tr>
				<tr>
				  <td class="c"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="178" height="2"></td>
				</tr>
				<tr>
				  <td valign="top" height="50">
					<table border="0" align="center">
			            <% //��EHR Ȯ���Կ� ��	%>
						<form name="SSORedirection" method="post">
							<input type="hidden" name="gw_menunum"/>
							<input type="hidden" name="SSO_FLAG" value="gw"/>
							<input type="hidden" name="MENU_ID" value="etcb010"/>
							<input type="hidden" name="ENO_NO" value="hda<%=gusrid%>" />
							<input type="hidden" name="SERVER_TIME" value="<%=strD%>" />
						</form>

			            <% //��Ȯ����
			               if(data_ap == null || data_ap.size() < 1 ) {
			            %>
						<tr>
							<td height="60" align="center" valign="middle" colspan="4">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
						</tr>			                        
			            <%
			            	}else {
			                  len_ap = data_ap.size();
			                  bean_ap = null;
								for(int h=0; h<len_ap; h++) {
			                     	bean_ap = (BaseDataClass)data_ap.get(h);

			            			if("Action PLAN".equals(bean_ap.get("detail_nm")) ){%>
			            			
									<tr>
										<td width="15" height="19" class="c t"><img src="<%=dirPath%>/Sales/images/dot.gif"  style="margin-top:6px;" /></td>
										<td width="120" class="c" onclick="view_send_act('A')" style="cursor:pointer;"><%=bean_ap.get("detail_nm")%></td>
										<td width="30" class="c" onclick="view_send_act('A')" style="cursor:pointer;">
											<%if(!bean_ap.get("cnt").equals("0") ){%>
												<font color="EE6A00"><b><%=bean_ap.get("cnt")%></b></font>
											<%}else{%><%=bean_ap.get("cnt")%>
											<%}%>
										</td>
									</tr>	

			            			<%}
			               		}
			           		}
					   %>						
					   </table>	
				  </td>
				</tr>
			  </table>
			</div>	<!-- //Ȯ���� ���� -->
<!-- **********************************************************************************************  -->
<!-- **********************************************************************************************  -->
<!--                                                             2019.03.29 Action Plan Ȯ���� ���� �߰���                                                                    -->
<!-- **********************************************************************************************  -->
<!-- **********************************************************************************************  -->

			<!-- ������ ���� -->
			<div class="mcApproval">
			  <table width="198" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td width="198"><b>�������� ����</b></td>
				</tr>
				<tr>
				  <td class="c"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="178" height="2"></td>
				</tr>
				<tr>
				  <td valign="top" height="100">
					<table border="0" align="center">
			            <% //��EHR �����Կ� ��	%>
						<form name="SSORedirection" method="post">
							<input type="hidden" name="gw_menunum"/>
							<input type="hidden" name="SSO_FLAG" value="gw"/>
							<input type="hidden" name="MENU_ID" value="etcb010"/>
							<input type="hidden" name="ENO_NO" value="hda<%=gusrid%>" />
							<input type="hidden" name="SERVER_TIME" value="<%=strD%>" />
						</form>

			            <% //��������
			               if(data_ap == null || data_ap.size() < 1 ) {
			            %>
						<tr>
							<td height="60" align="center" valign="middle" colspan="4">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
						</tr>			                        
			            <%
			            	}else {
			                  len_ap = data_ap.size();
			                  bean_ap = null;
								for(int h=0; h<len_ap; h++) {
			                     	bean_ap = (BaseDataClass)data_ap.get(h);

			            			if("�λ�".equals(bean_ap.get("detail_nm")) ){%>
						<tr>
							<td width="15" height="19" class="c t"><img src="<%=dirPath%>/Sales/images/dot.gif"  style="margin-top:6px;" /></td>
							<td width="120" class="c" onclick="view_send_ehr('1')" style="cursor:pointer;"><%=bean_ap.get("detail_nm")%></td>
							<td width="30" class="c" onclick="view_send_ehr('1')" style="cursor:pointer;">
								<%if(!bean_ap.get("cnt").equals("0") ){%>
									<font color="EE6A00"><b><%=bean_ap.get("cnt")%></b></font>
								<%}else{%><%=bean_ap.get("cnt")%>
								<%}%>
								
							</td>
						</tr>

			            	<%	}else if("Action PLAN".equals(bean_ap.get("detail_nm")) ){%>

						<tr>
							<td></td>
						</tr>
	
			            			<%}else{%>
						<tr>
							<td width="15" height="19" class="c t"><img src="<%=dirPath%>/Sales/images/dot.gif"  style="margin-top:6px;" /></td>
							<td width="120" class="c" onclick="view_send_ap()" style="cursor:pointer;"><%=bean_ap.get("detail_nm")%></td>
							<td width="30" class="c" onclick="view_send_ap()" style="cursor:pointer;">
								<%if(!bean_ap.get("cnt").equals("0") ){%>
									<font color="EE6A00"><b><%=bean_ap.get("cnt")%></b></font>
								<%}else{%><%=bean_ap.get("cnt")%>
								<%}%>
							</td>
						</tr>
			            			<%}
			               		}
			           		}
					   %>	
					 </table>	
				  </td>
				</tr>
			  </table>
			</div>	
			<!-- //������ ���� -->


			<div class="mcSpaceH"></div>	
			<!-- //���� -->
			

			<!-- //�ٷΰ��� -->
			<div class="mcLinks">
			  <table width="198" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td width="198"><b>���ٷΰ���</b></td>
				</tr>
				<tr>
				  <td class="c"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="178" height="2"></td>
				</tr>
				<tr>
				  <td valign="top">
					<ul>
						<li>&nbsp;&nbsp;&nbsp;�� <a href="http://www.hdasan.com" target="_blank">ȸ�� Ȩ</a></li>
						<li>&nbsp;&nbsp;&nbsp;�� <a href="http://www.mtkumgang.com" target="_blank">�ݰ������</a></li>
						<li>&nbsp;&nbsp;&nbsp;�� <a href="http://www.ikaesong.com" target="_blank">��������</a></li>
						<li>&nbsp;&nbsp;&nbsp;�� <a href="http://www.hdasantour.com" target="_blank">�����</a></li>
						<li>&nbsp;&nbsp;&nbsp;�� <a href="http://portal.hdasan.com" target="_blank">�׷����</a></li>
						<li>&nbsp;&nbsp;&nbsp;�� <a href="#" onclick="moveMoveN('<%=dirPath%>/Config/my/sq100s.jsp','960');">����������ȣ �����ϱ� ����</a></li>
					</ul>
				  </td>
				</tr>
			  </table>			
			</div>	
			<!-- //�ٷΰ��� -->		
			

			<div class="mcSpaceH"></div>	<!-- //���� -->


			<!-- //Responsibility & Matrix -->
			<div class="mcRAM">
				<table style="width:198px;">
				  <tr>
				  	<td width="54px"><img src="<%=dirPath%>/images/it_team/uni200261.jpg" height="60px" alt="������" title="������" /></td>
				  	<td style="line-height:1.3;">������ ���� (<b>3717</b>)</br>
				  		��IT��ȹ, ��� ����, </br>
				  		��ȸ��, ����, ����, </br>
				  		���������(POS), �о�
				  		</td>
				  </tr>
				</table>	<!-- //���Ұ� å�� -->
			</div>	<!-- //Responsibility & Matrix -->

			<div class="mcSpaceH"></div>	<!-- //���� -->

			<div class="mcRAM">
				<table style="width:198px;">
				  <tr>
				  	<td width="54px"><img src="<%=dirPath%>/images/it_team/uni200124.jpg" height="60px" alt="�̵���" title="�̵���" /></td>
				  	<td style="line-height:1.3;">�̵��� ���� (<b>3753</b>)</br>
				  		���Ǽ�, �λ�, MICE,</br>
				  		����������� ����, </br>
				  		��������Ʈ ������ </td>
				  </tr>
				</table>
			</div>	<!-- //Responsibility & Matrix -->

			<div class="mcSpaceH"></div>	<!-- //���� -->

			<div class="mcRAM">
				<table style="width:198px;">
				  <tr>
				  	<td width="54px"><img src="<%=dirPath%>/images/it_team/uni200440.jpg" height="60px" alt="������" title="������" /></td>
				  	<td style="line-height:1.3;">������ �븮 (<b>3809</b>)</br>
				  		������, ������Ʈ,</br>
				  		��������ȣ �����,</br>
				  		��H/W + S/W ���� </td>
				  </tr>
				</table>	<!-- //���Ұ� å�� -->
			</div>	<!-- //Responsibility & Matrix -->

		</div>
    
    </div><!-- //container -->
    
    <!-- footer  -->
    <div id="footer" onclick="setSet()">    </div><!-- //footer  -->
   
</div><!-- //warp	-->


</form>
<!-- form �� -->



<!-- ��Ÿ html��ҵ� -->	
<% /* �޴� �̵��� ������ �������� ��  */ %>
<form name="movForm" id="movForm" method="post">
	<input name="ssID" type="hidden" value="<%=session.getId()%>"/>
</form>


<% /* EHR�� �������� ��  */ %>
<form name="SSORedirection2" method="post">
	<input type="hidden" name="gw_menunum"/>
	<input type="hidden" name="SSO_FLAG" value="gw"/>
	<input type="hidden" name="MENU_ID" value="erp"/>
	<input type="hidden" name="ENO_NO" value="hda<%=gusrid%>"/>
</form>	


<%//2016���������� ����������.. %>
<iframe id="top_notice" 
		name="top_notice" 
		style="width:100%;height:810px;display:none;top:90px; position:absolute;z-index:90;" 
		Frameborder="0" src="<%=dirPath%>/Common/notice/1610_safety/1610_safety_01.jsp">
</iframe>	


<script language=javascript>
	fnSetHeader_tree();// ���� 1ȸ �������
	setTree('00');//fnInit_tree(0,'10');	// ȭ�� ǥ�� �� Ʈ�� �θ���
	setCenterIco('1');
	chk_safety("<%=gusrid%>");//2016����������
</script>






<!-- //��Ÿ html��ҵ� -->
</body>
</html>


<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>



