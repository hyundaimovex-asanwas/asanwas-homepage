<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : ����Ϻ�����
+ ���α׷�ID : em014i.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.11.07
----------------------------------------------------------------------------------
+ �������� : ����üũ (D+1�� ���� 12:00:00 ������ �Է°���) 
+ �� �� �� : ������
+ �������� : 2008.03.05 
----------------------------------------------------------------------------------
+ ������ : Em014_S.java
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
  java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());	
%>
<!-- HTML ����-->
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>
	<script language="javascript">

	get_cookdata();
	//���ÿ��� ����ϱ� ���� ���Ƿ� ����.
    /*
	var gs_date = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	*/
	var gs_date ='<%=firstday%>';

	var gs_team_cd=""; //����Ϻ����� - �Ҽ���

//	var gs_txt ="";
	
	
 
	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			ln_before();//����ȸ
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			gcem_att_dt_fr.Text = gs_date;
			gcem_att_dt_to.Text = gs_date;

		}
/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){
	//gcds_data00.UseChangeInfo ="true"; 
	if(gclx_team_cd.text==""){
		alert("�ش� ����� ��ȸ �� �� �����ϴ�.");
		return;
	}
  
	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S1"
											 + "?v_str1=" + gclx_dept_cd.bindcolval	// �μ�       
											 + "&v_str2=" + gclx_team_cd.bindcolval	// �Ҽ�       
											 + "&v_str3=" + gcem_att_dt_fr.text			// from ����  
											 + "&v_str4=" + gcem_att_dt_to.text			// to ����    
											 + "&v_str5=" + txt_empno.value 			    // ���       
											 + "&v_str6=" + txt_empnmk.value;			  // ����       
	gcds_data00.Reset();
}

/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

  //�����ð� ��ȸ
	gcds_close_time.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S6?"
	gcds_close_time.Reset();

	//�μ�  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();
	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();
	//�ٹ�����  
	gcds_cm014.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM014";
	gcds_cm014.Reset();

  if(gusrid==null)gusrid="6070001";	
	//if(gusrid==null)gusrid="1990045";	
	//if(gusrid==null)gusrid="2070001";	

  ////////gusrid='';
	//����Ϻ� ����ں� �Ҽ���....
	gcds_cm034.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s2?v_str1=CM034&v_str2="+gusrid;
	//prompt('',gcds_cm034.DataID);
	gcds_cm034.Reset();
  
	gs_team_cd="";

	for(i=1;i<=gcds_cm034.countrow;i++){
		if(gcds_cm034.namevalue(i,"ITEM3")=="00000"){
			 gs_team_cd="00000";
			 break;   //��ü�� ���
		}
		if(i==1) gs_team_cd = gcds_cm034.namevalue(i,"ITEM3");
		if(i>1)  gs_team_cd = gs_team_cd +"','"+gcds_cm034.namevalue(i,"ITEM3");
	}

	if(gs_team_cd=="") gs_team_cd="99999"; //

	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s3?v_str1=CM003&v_str2="+gs_team_cd;
	gcds_cm003.Reset();

	//gcds_cm034.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s2?v_str1=CM034&v_str2=6070001";
	//gcds_cm034.Reset();

	if(gs_team_cd=="00000"){
		sp1.style.display = "";
		sp0.style.display = "";
	  chkbox.checked = false;
	}else{
		sp1.style.display = "none";
		sp0.style.display = "none";    // ����
		chkbox.checked = false;
	}
	
	//sp1.style.display = "";
	//sp0.style.display = "";
	//chkbox.checked = false;
 
 ln_SetDataHeader();

 //alert("CTIME::"+gcds_close_time.namevalue(gcds_close_time.rowposition,"CTIME"));

 var str_ctime = gcds_close_time.namevalue(gcds_close_time.rowposition,"CTIME").substring(0,2)+":"+gcds_close_time.namevalue(gcds_close_time.rowposition,"CTIME").substring(2,4);
 txt_nm.value = "* �������� ������� ���� D+"+gcds_close_time.namevalue(gcds_close_time.rowposition,"CDAY")+"�� "+str_ctime+"���� �Դϴ�.";
}

/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(){//������ȸ

  var arrParam	= new Array();
	var strURL   = "./Per_com_pop.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_empno.value = arrParam[0];
		txt_empnmk.value = arrParam[1];
	} else {
		txt_empno.value = "";
		txt_empnmk.value = "";
	}
}

/*----------------------------------------------------------------------------
	Description : ���°��� �ϰ����� 
----------------------------------------------------------------------------*/
function ln_Batch_Create(){
	   var strfrdt="";
		 var strtodt="";
		 var strTeamnm="";

		if(fn_trim(gcem_att_dt_fr.text)==""){
			alert("������ڸ� �Է��Ͻʽÿ�");
			return;
		}

		if(chkbox.checked==true){ //�����ڸ� ����
			if(fn_trim(gcem_att_dt_to.text)==""){
				alert("������ڸ� �Է��Ͻʽÿ�");
				return;
			}
    }else{
			if(gcem_att_dt_fr.text!=gcem_att_dt_to.text){
				alert("������ڸ� �����ϰ� �Ͻʽÿ�.");
				return;
			}
		}

		//����üũ
		if(!ln_Close_Chk()) return;

		//��������Ÿ ��ȸ
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S2?"
										   + "?v_str1=" + gclx_dept_cd.bindcolval	// �μ�       
											 + "&v_str2=" + gclx_team_cd.bindcolval	// �Ҽ�       
											 + "&v_str3=" + gcem_att_dt_fr.text			// from ����  
											 + "&v_str4=" + gcem_att_dt_to.text			// to ����    
											 + "&v_str5=" + txt_empno.value 			  // ���       
											 + "&v_str6=" + txt_empnmk.value;			  // ����       
		gcds_data.Reset();
 
    gcds_data2.ClearAll();
    ln_SetDataHeader();
		gcds_data2.Addrow();
		gcds_data2.namevalue(gcds_data2.rowposition,"TEMP")="A";

		strfrdt =gcem_att_dt_fr.text.substring(0,4)+"/"+gcem_att_dt_fr.text.substring(4,6)+"/"+gcem_att_dt_fr.text.substring(6,8);
		strtodt =gcem_att_dt_to.text.substring(0,4)+"/"+gcem_att_dt_to.text.substring(4,6)+"/"+gcem_att_dt_to.text.substring(6,8);


		if(gclx_team_cd.bindcolval=="") strTeamnm ="��ü"
		if(gclx_team_cd.bindcolval!="") strTeamnm =gclx_team_cd.text;


		if(gcds_data.countrow==0){ //�űԻ���
		  if(confirm(strfrdt+" ~ "+strtodt+" ���� \n "+strTeamnm+" ����Ÿ�� �����Ͻðڽ��ϱ�?")){
				//gcds_data00.AddRow();
				gctr_data.KeyValue = "Em014_t1(I:USER=gcds_data2)";
				if(chkbox.checked==true){
					gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_t1_b";
				}else{
          gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_t1";  
				}
				gctr_data.Parameters = "v_str1=Y,v_str2="+gcem_att_dt_fr.text+",v_str3="+gusrid+",v_str4="+gcem_att_dt_to.text+",v_str5="+txt_empno.value+",v_str6="+gclx_team_cd.bindcolval;
				//prompt(this,gcds_data.text);
				gctr_data.post();
				ln_Query();
			}
   	}else{//��������Ÿ ����
			if(confirm("���� ����Ÿ�� �����մϴ�. \n���� �� "+strfrdt+" ~ "+strtodt+ " ����\n" + strTeamnm + " ����Ÿ�� �ٽ� �����Ͻðڽ��ϱ�?")){
				//gcds_data00.AddRow();
				gctr_data.KeyValue = "Em014_t1(I:USER=gcds_data2)";
				if(chkbox.checked==true){
					gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_t1_b";
				}else{
          gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_t1";  
				}
				gctr_data.Parameters = "v_str1=N,v_str2="+gcem_att_dt_fr.text+",v_str3="+gusrid+",v_str4="+gcem_att_dt_to.text+",v_str5="+txt_empno.value+",v_str6="+gclx_team_cd.bindcolval;
				gctr_data.post();
				ln_Query();
			}
		}
}


/*----------------------------------------------------------------------------
	Description : ���°��� �ӽ� - OT data ó�� �ø� �� ���
----------------------------------------------------------------------------*/
function ln_Batch_Update(){
		//��������Ÿ ��ȸ
		gcds_OT.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_OT_S1?"
									 + "v_str1=" + gcem_att_dt_fr.text.substring(0,6);			//���
		gcds_OT.Reset();

		//prompt('',gcds_OT.DataID);

  	if (gcds_OT_UP.countrow<1){
			var s_temp = " EMPNO:STRING(10),ATT_DT:STRING(8),WORK_GB:STRING(3),O_TIME_TOT:DECIMAL(4.1),O_NTIME:DECIMAL(4.1)";
			gcds_OT_UP.SetDataHeader(s_temp);
		}

		var strnum="";
    
		_out:
		for (i=1;i<=gcds_OT.countrow;i++){
			for(j=1;j<=30;j++){

        if(j>=1&&j<=9){
					strnum ="0"+j;
				}else{
          strnum =j;
				}

				gcds_OT_UP.Addrow();
				gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"EMPNO")  = gcds_OT.namevalue(i,"EMPNO");
				gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"ATT_DT") = gcds_OT.namevalue(i,"ATT_YM")+strnum;
        
				if(gcds_OT.namevalue(i,"D_"+strnum)==99){
					gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"WORK_GB")= "002"; //�޹�
					gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"O_TIME_TOT")=0;
					gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"O_NTIME")=0;
				}else if(gcds_OT.namevalue(i,"D_"+strnum)==88){ // �ް�
          gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"WORK_GB")= "005"; //�޹�
					gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"O_TIME_TOT")=0;
					gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"O_NTIME")=0;
				}else{
          gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"WORK_GB")= "001";       
					gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"O_TIME_TOT") = gcds_OT.namevalue(i,"D_"+strnum);
          gcds_OT_UP.namevalue(gcds_OT_UP.rowposition,"O_NTIME")    = gcds_OT.namevalue(i,"D_"+strnum);
				}
			}
		}

    gctr_data.TimeOut = "240000000";
    gctr_data.KeyValue = "Em014_OT_t1(I:USER=gcds_OT_UP)";
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_OT_t1";  
		gctr_data.post();
}

/*----------------------------------------------------------------------------
	Description : ���߰�
----------------------------------------------------------------------------*/
/*
function ln_Add(){
  ln_SetDataHeader()
  gcds_data00.Addrow();
}
*/

/*----------------------------------------------------------------------------
	Description : �����
----------------------------------------------------------------------------*/

function ln_Delete(){
	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
    gcds_data00.DeleteRow(gcds_data00.rowposition);
		gctr_data.KeyValue = "Em016_t1(I:USER=gcds_data00)";
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_t2?";
		gctr_data.post();
	}	
}


/*----------------------------------------------------------------------------
	Description : ����üũ ( ����Ÿ ����)
	//2008.03.05 ������ ����üũ//////////////////////////////////
	//2008.06.03 ������ ���� �� Ǯ����.
----------------------------------------------------------------------------*/
function ln_Close_Chk2(){

    if(gusrid=="1990045"){
			return true;
		}else{
			gcds_close_time.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S6?"
			gcds_close_time.Reset();

			gcds_close_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S5?"
														+ "v_str1=" + gcds_close_time.namevalue(gcds_close_time.rowposition,"CDAY");
			gcds_close_chk.Reset();

			if(gcds_close_chk.countrow<0){
				alert("�ٽ� ������ �ֽʽÿ�.");
				return false;
			}else if(gcds_close_chk.countrow>=1){
				for(i=1;i<=gcds_data00.countrow;i++){
					if(gcds_data00.IsUpdated){
						if(gcds_close_chk.namevalue(gcds_close_chk.rowposition,"CHKDT")>gcds_data00.namevalue(i,"ATT_DT")){
							alert("�������ڰ� �������ϴ�. Ȯ�ιٶ��ϴ�.");
							return false;
						}else if(gcds_close_chk.namevalue(gcds_close_chk.rowposition,"CHKDT")==gcds_data00.namevalue(i,"ATT_DT")){
							if(gcds_close_chk.namevalue(gcds_close_chk.rowposition,"CHKTM")>gcds_close_time.namevalue(gcds_close_time.rowposition,"CTIME")){
								alert("�����ð��� �������ϴ�. Ȯ�ιٶ��ϴ�.");
								return false;
							}
						}
					}
				}
			}else{
				alert("�ٽ� ������ �ֽʽÿ�.0");
				return false;
			}
			return true;
		}
}

/*----------------------------------------------------------------------------
	Description : ����üũ (����Ÿ ����)
	//2008.03.05 ������ ����üũ//////////////////////////////////
----------------------------------------------------------------------------*/
function ln_Close_Chk(){
    
		if(gusrid=="1990045"){
			return true;
		}else{
			gcds_close_time.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S6?"
			gcds_close_time.Reset();

			gcds_close_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S5?"
														+ "v_str1=" + gcds_close_time.namevalue(gcds_close_time.rowposition,"CDAY");
			gcds_close_chk.Reset();

			if(gcds_close_chk.countrow<0){
				alert("�ٽ� ������ �ֽʽÿ�.");
				return false;
			}else if(gcds_close_chk.countrow>=1){
				//alert("CHKDT::"+gcds_close_chk.namevalue(gcds_close_chk.rowposition,"CHKDT"));
				if(gcds_close_chk.namevalue(gcds_close_chk.rowposition,"CHKDT")>gcem_att_dt_fr.text){
					alert("�������ڰ� �������ϴ�. Ȯ�ιٶ��ϴ�.");
					return false;
				}else if(gcds_close_chk.namevalue(gcds_close_chk.rowposition,"CHKDT")==gcem_att_dt_fr.text){
					if(gcds_close_chk.namevalue(gcds_close_chk.rowposition,"CHKTM")>gcds_close_time.namevalue(gcds_close_time.rowposition,"CTIME")){
						alert("�����ð��� �������ϴ�. Ȯ�ιٶ��ϴ�.");
						return false;
					}
				}
			}else{
				alert("�ٽ� ������ �ֽʽÿ�.");
				return false;
			}
			return true;
		}
}

/*----------------------------------------------------------------------------
	Description : ���� ( ��������Ÿ ����)
----------------------------------------------------------------------------*/
function ln_Save(){

	//����üũ
	if(!ln_Close_Chk2()) return;
  
	if(!ln_Save_Chk()) return;

	if (gcds_data00.IsUpdated) {
			if(confirm("������ �����Ͻðڽ��ϱ�?")){
				gctr_data.KeyValue = "Em014_t2(I:USER=gcds_data00)";
				gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_t2?";
				// prompt(this,gcds_data00.text);
				gctr_data.post();
			}
	}
}

/*----------------------------------------------------------------------------
	Description : ����� üũ
----------------------------------------------------------------------------*/
function ln_Save_Chk(){
	for(i=1;i<=gcds_data00.countrow;i++){

		if(gcds_data00.SysStatus(i)==3){ // �����ҷ��� �Ұ��
			 if(fn_trim(gcds_data00.namevalue(i,"ATT_DT"))==""){
					alert("������ڸ� �Է��Ͻʽÿ�.");
					return false;
			 }

       if(gcds_data00.namevalue(i,"WORK_GB")==""){
					alert("�ٹ������� �Է��Ͻʽÿ�.");
					return false;
			 }

			 if(gcds_data00.namevalue(i,"WORK_GB")=="001"){ //�ٹ��϶� �ٹ�
					if(gcds_data00.namevalue(i,"W_TIME_TOT")==""||gcds_data00.namevalue(i,"W_TIME_TOT")=="0"){
						alert("�ٹ��ð� �踦 �Է��Ͻʽÿ�.");
            gcds_data00.rowposition=i;
						return false;
					}

			 }else if(gcds_data00.namevalue(i,"WORK_GB")=="003"){ //������ �� 
			    if(gcds_data00.namevalue(i,"W_TIME_TOT")==""||gcds_data00.namevalue(i,"W_TIME_TOT")=="0"){
						alert("�ٹ��ð� �踦 �Է��Ͻʽÿ�.");
            gcds_data00.rowposition=i;
						return false;
					}
					//if(gcds_data00.namevalue(i,"O_TIME_TOT")==""||gcds_data00.namevalue(i,"O_TIME_TOT")=="0"){
					//	alert("OT�ð� �踦 �Է��Ͻʽÿ�.");
          //  gcds_data00.rowposition=i;
					//	return false;
					//}
			 }else{ // �׿� ����, ������� �϶�
				  if(gcds_data00.namevalue(i,"W_TIME_TOT")!=""&&gcds_data00.namevalue(i,"W_TIME_TOT")!="0"){
						alert("�ٹ��ð� �迡 �ԷµǾ����ϴ�. Ȯ�� �ٶ��ϴ�.");
            gcds_data00.rowposition=i;
						return false;
					}
					
					if(gcds_data00.namevalue(i,"O_TIME_TOT")!=""&&gcds_data00.namevalue(i,"O_TIME_TOT")!="0"){
						alert("OT�ð� �迡 �ԷµǾ����ϴ�. Ȯ�� �ٶ��ϴ�.");
            gcds_data00.rowposition=i;
						return false;
					}
			 }
		}
	}
	return true;
}
/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
  function ln_Excel(){

    var szName1 = "����Ϻ�����";
    var szPath = "C:\\Test\\em014i.xls";
       if (gcds_data00.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
       }
   }
/*----------------------------------------------------------------------------
	Description : ���
----------------------------------------------------------------------------*/
function ln_Print(){
  if(!ln_Print_Chk()) return;
	gcds_print.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S2"
											 + "?v_str1=" + gclx_dept_cd.bindcolval	// �μ�       
											 + "&v_str2=" + gclx_team_cd.bindcolval	// �Ҽ�       
											 + "&v_str3=" + gcem_att_dt_fr.text			// from ����  
											 + "&v_str4=" + gcem_att_dt_to.text			// to ����    
											 + "&v_str5=" + txt_empno.value 			  // ���       
											 + "&v_str6=" + txt_empnmk.value;			  // ����       
	gcds_print.Reset();

 // alert("");

	gcrp_print.preview();
}

/*----------------------------------------------------------------------------
	Description : ���üũ
----------------------------------------------------------------------------*/
function ln_Print_Chk(){
	if(fn_trim(gcem_att_dt_fr.text)==""){
			alert("������ڸ� �Է��Ͻʽÿ�");
			return false;
	}

  return true;
	if(gcem_att_dt_fr.text!=gcem_att_dt_to.text){
		alert("������ڸ� �����ϰ� �Ͻʽÿ�.");
		return false;
	}

	return true;
}

/*----------------------------------------------------------------------------
	Description : ���
----------------------------------------------------------------------------*/
function ln_Sum(){
    
		if(fn_trim(gcem_o_dtime.text)=="")gcem_o_dtime.text=0;
		if(fn_trim(gcem_o_ntime.text)=="")gcem_o_ntime.text=0;

		gcem_o_time_tot.text = parseFloat(gcem_o_dtime.text) + parseFloat(gcem_o_ntime.text);
}

/******************************************************************************
	Description : �ϰ������� �����.
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data2.countrow<1){
		var s_temp = " TEMP:STRING(1)";
		gcds_data2.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : �Ҽ����� ȯ�漳��.
******************************************************************************/
function ln_Setup(){

  //�Ҽ��� ���� ��� ����� ����.
  //alert("gclx_team_cd"+gclx_team_cd.text);

	if(fn_trim(gclx_team_cd.text)==""){
		alert("�Ҽ����� Ȯ���Ͻʽÿ�.");
		return false;
	}

	//("�ҼӺ� ȯ�漳��");
	var arrParam	= new Array();
	var arrParam2	= new Array();

	var strURL   = "../popup/em014_popup.jsp";
	var strPos = "dialogWidth:950px;dialogHeight:430px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);

	if (arrResult != null) {

  }
}

</script>
<%
/*=============================================================================
				Developer Java Script ��
=============================================================================*/
%>
    
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/
%>

<script language=JavaScript for=gcem_o_dtime event=onKillFocus()>
    ln_Sum();
</script>

<script language=JavaScript for=gcem_o_ntime event=onKillFocus()>
    ln_Sum();
</script>

<script lanaguage=JavaScript for=gcem_o_dtime event=OnLastDownChar(char)>
	  ln_Sum();
</script>

<script lanaguage=JavaScript for=gcem_o_ntime event=OnLastDownChar(char)>
    ln_Sum();
</script>
<script language=JavaScript for= gclx_work_gb event=OnSelChange()>
   
	 if(gclx_work_gb.bindcolval=="001"){ //�ٹ�
		  gcem_w_time.text  ="0730";
			gcem_w2_time.text ="1800";
      gcem_w_time_tot.text =10;
	 }else if(gclx_work_gb.bindcolval=="002" ||gclx_work_gb.bindcolval=="004"||gclx_work_gb.bindcolval=="005"){ //�޹�,  �������,  �ް�
			gcem_w_time.text  ="0000";
			gcem_w2_time.text ="0000";
      gcem_w_time_tot.text =0;
   }

   /*
	 if(gcds_cm014.namevalue(gcds_cm014.rowposition,"COM_CODE")=="003"){ //�������� ���� OT���� �Է°���
			gcem_w_time.text = "";
			gcem_w2_time.text ="";
			gcem_w_time_tot.text ="";
			gcem_w_time.ReadOnly  = "true";
			gcem_w2_time.ReadOnly  ="true";
			gcem_w_time_tot.ReadOnly  ="true";
	 }else{
  		gcem_w_time.ReadOnly  = "false";
			gcem_w2_time.ReadOnly  ="false";
			gcem_w_time_tot.ReadOnly  ="false";
	 }
	 */
	///  <param name=ComboDataID			value="gcds_cm014">
  ///  <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
</script>


<script language=JavaScript for=gcds_cm003 event=OnFilter(row)>
/*
 // alert("row:"+row+"::::"+gcds_cm003.namevalue(row,"COM_CODE"));

	//alert("gcds_cm034.countrow:"+gcds_cm034.countrow);
	
	for(i=1;i<=gcds_cm034.countrow;i++){
		if(gcds_cm034.namevalue(i,"ITEM3")=="00000"){
			return true;
		}else{
		//	alert("i::::::::::::"+i+"::::"+gcds_cm034.namevalue(i,"ITEM3")); 
			if(gcds_cm034.namevalue(i,"ITEM3")==gcds_cm003.namevalue(row,"COM_CODE")){
			//	alert("i::"+i+"::::"+gcds_cm034.namevalue(i,"ITEM3"));
				return true;
			}else{
				return false;
			}
		}
	}

  //gcds_cm034.namevalue(gcds_cm034.rowposition,"COM_SNAME")
 */
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts ��
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
	<script language="javascript" for="gctr_data" event="onsuccess()">
		 alert("���忡 �����Ͽ����ϴ�");
	</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
	<script language="javascript" for="gctr_data" event="onfail()">
		alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	</script>

	<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
	</script>
	<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
		window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		document.all.LowerFrame.style.visibility="hidden";
		ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
		if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
		}
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
=============================================================================*/
%>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts ����
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>

	<script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
    ln_Insert_Row(2,"gcds_cm006","gclx_dept_cd");
	</script>

	<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
		if(gcds_cm034.namevalue(gcds_cm034.rowposition,"ITEM3")=="00000"){
			ln_Insert_Row(2,"gcds_cm003","gclx_team_cd");
	  }
	//	ln_Insert_Row(2,"gcds_cm003","gclx_team_cd");
	</script>

	<script language="javascript" for="gcds_cm014" event="onloadCompleted(row,colid)">
			//ln_Insert_Row(1,"gcds_cm014","gclx_work_gb");
	</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts ��
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_close_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_close_time classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<!-- �����ڵ� -->
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_cm014 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<!-- <Param Name="SubsumExpr" VALUE="100:TEAM_NM"> -->
</OBJECT>

<OBJECT id=gcds_cm034 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<!-- <Param Name="SubsumExpr" VALUE="100:TEAM_NM"> -->
</OBJECT>

<OBJECT id=gcds_OT classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<!-- <Param Name="SubsumExpr" VALUE="100:TEAM_NM"> -->
</OBJECT>

<OBJECT id=gcds_OT_UP classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<!-- <Param Name="SubsumExpr" VALUE="100:TEAM_NM"> -->
</OBJECT>
<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>
</head>
<body>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- ��ư ���� ����-->
					<tr>
            <td align="left" height="30px"  >
							<input id="txt_nm"  type="text"   class="txtbox"  style= "position:relative;left:5px;width:350px;height:20px;" ReadOnly>
						</td>
						<td align="right" height="30px">		

             <!--  <img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand" onclick="ln_Batch_Update()"> -->
						  <span id=sp1>
							<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand" onclick="ln_Batch_Create()">
							<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="ln_Delete()" >		
							</span>
							<img src="<%=dirPath%>/Sales/images/btn_setup.gif"	style="cursor:hand;" onclick="ln_Setup()">
							<img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onclick="ln_Query()">
						  <!-- 	<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="ln_Add()" >  
							<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" onClick="ln_Delete()" >	 -->
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" onClick="ln_Save()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand" onclick="ln_Excel()">
							<img src="<%=dirPath%>/Sales/images/print.gif"	style="cursor:hand" onclick="ln_Print()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
					  <td bgcolor="#eeeeee" align="center">�������</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_att_dt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_att_dt_fr', 'Text');">
              <span style="position:relative;left:0px;top:-4px;">&nbsp;&nbsp;&nbsp;~</span>
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_att_dt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_att_dt_to', 'Text');">
						</td>
           
						<td align="center" width="120" bgcolor="#eeeeee">���� </td>
						<td bgcolor="#FFFFFF">
						<input type="text" id="txt_empnmk" style="position:relative;;left:8px;width:80px;top:-1px;">&nbsp;
						<img src="<%=dirPath%>/Sales/images/help.gif" alt="������ �˻��մϴ�" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find()">
					  <input type="text" id="txt_empno" style="position:relative;;left:8px;width:80px;top:-1px;">&nbsp;
					</td>
					</tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">�μ�</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm006">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">�Ҽ���</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_team_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:3px;font-size:12px;width:150px;height:300px">
								<param name=ComboDataID			value="gcds_cm003">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^150">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;&nbsp;&nbsp;&nbsp;
                <span id=sp0 style="display:none;">
									<input type=checkbox  id=chkbox  style=width:15px;position:relative;left:-4px;top:-1px;><FONT style="position:relative;top:-3px;">�Ⱓ ����</FONT>
								</span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=0 style="width:600px;height:390px;position:relative;top:-5px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:600;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<param name="ViewSummary"  value="1">
  						<PARAM NAME="Format"			VALUE="  
                <F> Name=NO				   ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right  SumBgColor=#C3D0DB </F> 
                <FC>Name=����,       ID=CHK     ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, show=false SumBgColor=#C3D0DB </FC>
                <FC>Name=�ٹ���ü,   ID=VEND_NM ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true show=false SumBgColor=#C3D0DB</FC>
								<FC>Name=�μ�,       ID=DEPT_NM ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true show=false SumBgColor=#C3D0DB </FC>
                <FC>Name=�Ҽ���,     ID=TEAM_NM ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true SumBgColor=#C3D0DB </FC>
                <FC>Name=�ٹ���,     ID=WORK_NM ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true show=false SumBgColor=#C3D0DB</FC>
                <FC>Name=���,       ID=EMPNO   ,width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true SumBgColor=#C3D0DB</FC>
								<FC>Name=����,       ID=EMPNMK  ,width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true SumBgColor=#C3D0DB</FC>
								<C>Name='�ٹ�����',  ID=ATT_DT  ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, mask='XXXX/XX/XX' SumBgColor=#C3D0DB</C>
								<C>Name='�ٹ�\\����',ID=WORK_GB ,width=55,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, EditStyle=Lookup Data='gcds_cm014:COM_CODE:COM_SNAME' SumBgColor=#C3D0DB</C>
                <X> name='������ �ٹ��ð�'  HeadBgColor=#B9D4DC,
									<G> name=�ٹ��ð�  HeadBgColor=#B9D4DC,     
										<C>Name=FROM,  ID=W_TIME   ,width=40,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,  mask='XX:XX' SumBgColor=#C3D0DB</C>
										<C>Name=TO,    ID=W2_TIME  ,width=40,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, mask='XX:XX' SumBgColor=#C3D0DB</C>
									</G>
									<C>Name=��,       ID=W_TIME_TOT  ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff,  align=right, decao=1, sumtext=@sum, SumBgColor=#C3D0DB</C>
									<C>Name=�۾�����, ID=W_REMARK    ,width=90,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, SumBgColor=#C3D0DB</C>
                </X>
								<X> name='O/T �ٹ��ð�'  HeadBgColor=#B9D4DC,
									<G> name=OT�ð�1  HeadBgColor=#B9D4DC,     
										<C>Name=FROM,  ID=O_TIME  ,width=40,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,  mask='XX:XX' SumBgColor=#C3D0DB</C>
										<C>Name=TO,    ID=O2_TIME  ,width=40,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, mask='XX:XX' SumBgColor=#C3D0DB</C>
									</G>
									<G> name=OT�ð�2  HeadBgColor=#B9D4DC,     
										<C>Name=FROM,   ID=O3_TIME  ,width=40,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,  mask='XX:XX' SumBgColor=#C3D0DB</C>
										<C>Name=TO,     ID=O4_TIME  ,width=40,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, mask='XX:XX' SumBgColor=#C3D0DB</C>
									</G>
									<C>Name=��,       ID=O_TIME_TOT ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, decao=1,  sumtext=@sum, SumBgColor=#C3D0DB</C>
									<C>Name=�ְ�,     ID=O_DTIME    ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, decao=1,  sumtext=@sum, SumBgColor=#C3D0DB</C>
									<C>Name=�߰�,     ID=O_NTIME    ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, decao=1,  sumtext=@sum, SumBgColor=#C3D0DB</C>
									<C>Name=�۾�����, ID=O_REMARK   ,width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, SumBgColor=#C3D0DB</C>
                </X>
								<C>Name=���, ID=REMARK   ,width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, SumBgColor=#C3D0DB</C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
								<fieldset style="width:600;height:20px;border:1 solid #708090;border-top-width:1px;border-bottom-width:0px;border-right-width:0px;text-align:left;">
									&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
								</fieldset>
						</td>
						<td bgcolor="#FFFFFF">&nbsp;</td>
						<td>
							<table cellpadding=0 cellspacing=0 style="width:218px;height:390px;">
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010">����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
                    <input id="txt_empno2"   type="text"   class="txtbox"  style= "position:relative;left:7px;width:55px;height:20px;" ReadOnly>
										<input id="txt_empnmk2"  type="text"   class="txtbox"  style= "position:relative;left:5px;width:70px;height:20px;" ReadOnly>
									</td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�μ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<input id="txt_dept_cd"  type="text"   class="txtbox"  style= "position:relative;left:7px;width:35px;height:20px;" ReadOnly>
										<input id="txt_dept_nm"  type="text"   class="txtbox"  style= "position:relative;left:5px;width:90px;height:20px;" ReadOnly>
									</td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�Ҽ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<input id="txt_team_cd"  type="text"   class="txtbox"  style= "position:relative;left:7px;width:35px;height:20px;" ReadOnly>
										<input id="txt_team_nm"  type="text"   class="txtbox"  style= "position:relative;left:5px;width:90px;height:20px;" ReadOnly>
									</td>
								</tr>
								<tr  height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�������</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_att_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:70px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM/DD">
                    <param name=PromptChar	  value="_">
										<param name=ReadOnly      value="true">
                    <param name=ReadOnlyBackColor      value=#CCFFCC>
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <!-- <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_att_dt', 'Text');"> -->
									</td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�ٹ�����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_work_gb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                    style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                    <param name=ComboDataID			value="gcds_cm014">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="13">
								<td colspan="2" class="tab_z0010"><font style="position:relative;top:0px;left:0px; color=#0000FF"><b>[������ �ٹ��ð�]</b></font></td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�ٹ��ð�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_w_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="##:##">
										<param name=ReadOnlyBackColor   value="#CCFFCC">
										<param name=PromptChar	value="_">
										</OBJECT><%=HDConstant.COMMENT_END%>
                      <span style="position:relative;left:8px;top:-4px;">&nbsp;~</span>
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_w2_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="##:##">
										<param name=ReadOnlyBackColor   value="#CCFFCC">
										<param name=PromptChar	value="_">
										</OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >��</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_w_time_tot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px; font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=MaxLength     value=2>
  									<param name=MaxDecimalPlace  value=1>
										<param name=ReadOnlyBackColor   value="#CCFFCC">
										</OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�۾�����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
									  <textarea id="txt_w_remark" class="txtbox"  style= "width:125px; height:20px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;
									</td>
								</tr>
								<tr height="13">
								<td colspan="2" class="tab_z0010"><font style="position:relative;top:0px;left:0px; color=#0000FF"><b>[O/T �ٹ��ð�]</b></font></td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >OT�ð�1</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="##:##">
										<param name=PromptChar	value="_">
										</OBJECT><%=HDConstant.COMMENT_END%>
                      <span style="position:relative;left:8px;top:-4px;">&nbsp;~</span>
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o2_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="##:##">
										<param name=PromptChar	value="_">
										</OBJECT><%=HDConstant.COMMENT_END%>
                  </td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >OT�ð�2</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
											<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o3_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="##:##">
										<param name=PromptChar	value="_">
										</OBJECT><%=HDConstant.COMMENT_END%>
                      <span style="position:relative;left:8px;top:-4px;">&nbsp;~</span>
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o4_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="##:##">
										<param name=PromptChar	value="_">
										</OBJECT><%=HDConstant.COMMENT_END%>
                  </td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" ><font style="position:relative;right:0px;">�ְ�|�߰�</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o_dtime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=MaxLength     value=2>
  									<param name=MaxDecimalPlace  value=1>
										</OBJECT><%=HDConstant.COMMENT_END%>
                      <span style="position:relative;left:8px;top:-4px;">&nbsp;|</span>
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o_ntime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=MaxLength     value=2>
  									<param name=MaxDecimalPlace  value=1>
										</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;

										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o_time_tot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:35px; font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=ReadOnly      value="true">
                    <param name=ReadOnlyBackColor   value="#CCFFCC">
										<param name=MaxLength     value=2>
  									<param name=MaxDecimalPlace  value=1>
										</OBJECT><%=HDConstant.COMMENT_END%>
                  </td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�۾�����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<textarea id="txt_o_remark" class="txtbox"  style= "width:125px; height:20px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;
                  </td>
								</tr>
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1011" >���</td>
									<td bgcolor="#FFFFFF" class="tab_z1111" >
											<textarea id="txt_remark" class="txtbox"  style= "width:125px; height:20px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;
                  </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- �⺻�� -->
	<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"		VALUE="true">
		<PARAM NAME="BindInfo"			VALUE="
		  <C>Col=EMPNO       		  Ctrl=txt_empno2      			   		Param=Value</C>
			<C>Col=EMPNMK       		Ctrl=txt_empnmk2       					Param=Value</C>
			<C>Col=DEPT_CD   			  Ctrl=txt_dept_cd     					  Param=Value</C>
			<C>Col=DEPT_NM    			Ctrl=txt_dept_nm       					Param=Value</C>
			<C>Col=TEAM_CD     			Ctrl=txt_team_cd      					Param=Value</C>
			<C>Col=TEAM_NM   			  Ctrl=txt_team_nm     						Param=Value</C>
			<C>Col=ATT_DT   			  Ctrl=gcem_att_dt     						Param=Text</C>
			<C>Col=WORK_GB    			Ctrl=gclx_work_gb    						Param=bindcolval</C>
			<C>Col=W_TIME    			  Ctrl=gcem_w_time     						Param=Text</C>
			<C>Col=W2_TIME     			Ctrl=gcem_w2_time    						Param=Text</C>
			<C>Col=W_TIME_TOT  			Ctrl=gcem_w_time_tot 						Param=Text</C>
			<C>Col=W_REMARK 	  	  Ctrl=txt_w_remark    					  Param=value</C>
			<C>Col=O_TIME   		  	Ctrl=gcem_o_time     						Param=Text</C>
			<C>Col=O2_TIME   		  	Ctrl=gcem_o2_time    						Param=Text</C>
			<C>Col=O3_TIME   		  	Ctrl=gcem_o3_time     					Param=Text</C>
			<C>Col=O4_TIME   		  	Ctrl=gcem_o4_time    						Param=Text</C>
      <C>Col=O_TIME_TOT  			Ctrl=gcem_o_time_tot   					Param=Text</C>
			<C>Col=O_DTIME  			  Ctrl=gcem_o_dtime    					  Param=Text</C>
			<C>Col=O_NTIME     			Ctrl=gcem_o_ntime      					Param=Text</C>
			<C>Col=O_REMARK    			Ctrl=txt_o_remark     					Param=Value</C>
			<C>Col=REMARK   			  Ctrl=txt_remark      						Param=Value</C>
		">
	</OBJECT><%=HDConstant.COMMENT_END%>
	</table>

	<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!--  <PARAM NAME="MasterDataID"			VALUE="gcds_print"> -->
	<param name="DetailDataID"			value="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="FALSE">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true"> 
	<param name="SuppressColumns"	value="1:pageskip,TEAM_NM">
  <PARAM NAME="PreviewZoom"				VALUE="100">
  <param name=NullRecordFlag			value=true>
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=154 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�� �� �� ��' ,left=19 ,top=32 ,right=1873 ,bottom=138 ,face='����' ,size=24 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=289 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='O/T�ٹ��ð�' ,left=1167 ,top=153 ,right=1868 ,bottom=212 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=19 ,top=140 ,right=1868 ,bottom=140 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�������ٹ��ð�' ,left=624 ,top=153 ,right=1154 ,bottom=212 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=16 ,top=140 ,right=16 ,bottom=288 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=616 ,top=212 ,right=1868 ,bottom=212 </L>
	<T>id='����' ,left=108 ,top=153 ,right=389 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=24 ,top=153 ,right=103 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=397 ,top=153 ,right=519 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=826 ,top=222 ,right=897 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�۾�����' ,left=905 ,top=222 ,right=1154 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�۾�����' ,left=1611 ,top=222 ,right=1860 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ְ�' ,left=1455 ,top=222 ,right=1524 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1603 ,top=214 ,right=1603 ,bottom=286 </L>
	<L> left=103 ,top=140 ,right=103 ,bottom=286 </L>
	<L> left=392 ,top=140 ,right=392 ,bottom=286 </L>
	<L> left=521 ,top=140 ,right=521 ,bottom=286 </L>
	<L> left=1164 ,top=140 ,right=1164 ,bottom=286 </L>
	<L> left=1159 ,top=140 ,right=1159 ,bottom=286 </L>
	<L> left=1871 ,top=140 ,right=1871 ,bottom=288 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=820 ,top=214 ,right=820 ,bottom=286 </L>
	<L> left=900 ,top=214 ,right=900 ,bottom=286 </L>
	<L> left=1371 ,top=214 ,right=1371 ,bottom=286 </L>
	<L> left=1450 ,top=214 ,right=1450 ,bottom=286 </L>
	<L> left=1527 ,top=214 ,right=1527 ,bottom=286 </L>
	<T>id='�߰�' ,left=1532 ,top=222 ,right=1601 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ATT_DT', left=1204, top=50, right=1868, bottom=130, align='right' ,mask='XXXX�� XX�� XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=1376 ,top=222 ,right=1447 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=19 ,top=288 ,right=1871 ,bottom=288 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�Ҽ��� :' ,left=29 ,top=56 ,right=196 ,bottom=135 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TEAM_NM', left=196, top=56, right=1148, bottom=135, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ٹ��ð�' ,left=1169 ,top=222 ,right=1368 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ��ð�' ,left=619 ,top=222 ,right=818 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=614 ,top=140 ,right=614 ,bottom=286 </L>
	<L> left=616 ,top=217 ,right=1868 ,bottom=217 </L>
	<T>id='����' ,left=527 ,top=153 ,right=611 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=82 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=16 ,top=0 ,right=16 ,bottom=79 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='JOB_NM', left=106, top=5, right=386, bottom=77, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='O_REMARK', left=1611, top=5, right=1860, bottom=77, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(O_NTIME,0,\'\',O_NTIME)}', left=1532, top=5, right=1601, bottom=77, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='{decode(O_DTIME,0,\'\',O_DTIME)}', left=1455, top=5, right=1524, bottom=77, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='{decode(O_TIME_TOT,0,\'\',O_TIME_TOT)}', left=1376, top=5, right=1447, bottom=77, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='W_REMARK', left=905, top=5, right=1154, bottom=77, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(W_TIME_TOT,0,\'\',W_TIME_TOT)}', left=826, top=5, right=897, bottom=77, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='W_TIME', left=619, top=5, right=818, bottom=77, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WKGB_NM', left=527, top=5, right=611, bottom=77, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=397, top=5, right=519, bottom=77, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='O3_TIME', left=1169, top=40, right=1368, bottom=74, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='O_TIME', left=1169, top=5, right=1368, bottom=40, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=392 ,top=3 ,right=392 ,bottom=82 </L>
	<L> left=521 ,top=3 ,right=521 ,bottom=82 </L>
	<L> left=614 ,top=3 ,right=614 ,bottom=82 </L>
	<L> left=820 ,top=3 ,right=820 ,bottom=82 </L>
	<L> left=900 ,top=3 ,right=900 ,bottom=82 </L>
	<L> left=1159 ,top=3 ,right=1159 ,bottom=82 </L>
	<L> left=1164 ,top=3 ,right=1164 ,bottom=82 </L>
	<L> left=1371 ,top=3 ,right=1371 ,bottom=82 </L>
	<L> left=1450 ,top=3 ,right=1450 ,bottom=82 </L>
	<L> left=1527 ,top=3 ,right=1527 ,bottom=82 </L>
	<L> left=1603 ,top=3 ,right=1603 ,bottom=82 </L>
	<L> left=1871 ,top=0 ,right=1871 ,bottom=79 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=24, top=5, right=103, bottom=77, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=19 ,top=82 ,right=1871 ,bottom=82 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=103 ,top=0 ,right=103 ,bottom=79 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=2000 ,bottom=111 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=16 ,top=0 ,right=16 ,bottom=79 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�հ�' ,left=108 ,top=8 ,right=357 ,bottom=74 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(O_NTIME)}' ,left=1532 ,top=11 ,right=1601 ,bottom=77 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(O_DTIME)}' ,left=1455 ,top=11 ,right=1524 ,bottom=77 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(O_TIME_TOT)}' ,left=1376 ,top=11 ,right=1447 ,bottom=77 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(W_TIME_TOT)}' ,left=802 ,top=11 ,right=897 ,bottom=77 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=614 ,top=0 ,right=614 ,bottom=79 </L>
	<L> left=1159 ,top=0 ,right=1159 ,bottom=79 </L>
	<L> left=1164 ,top=0 ,right=1164 ,bottom=79 </L>
	<L> left=1371 ,top=0 ,right=1371 ,bottom=79 </L>
	<L> left=1450 ,top=0 ,right=1450 ,bottom=79 </L>
	<L> left=1527 ,top=0 ,right=1527 ,bottom=79 </L>
	<L> left=1603 ,top=0 ,right=1603 ,bottom=79 </L>
	<L> left=1871 ,top=0 ,right=1871 ,bottom=79 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=19 ,top=82 ,right=1871 ,bottom=82 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2246 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=19 ,top=3 ,right=1868 ,bottom=3 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='��      ��      ��' ,left=251 ,top=85 ,right=717 ,bottom=146 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��      ��       ��' ,left=1183 ,top=87 ,right=1648 ,bottom=148 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1640 ,top=164 ,right=1865 ,bottom=225 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ��' ,left=1413 ,top=164 ,right=1638 ,bottom=225 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=958 ,top=164 ,right=1183 ,bottom=225 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=709 ,top=164 ,right=934 ,bottom=225 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ��' ,left=482 ,top=164 ,right=706 ,bottom=225 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=254 ,top=164 ,right=479 ,bottom=225 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=26 ,top=164 ,right=251 ,bottom=225 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1185 ,top=164 ,right=1410 ,bottom=225 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=19 ,top=77 ,right=1868 ,bottom=77 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=19 ,top=153 ,right=1868 ,bottom=153 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=19 ,top=230 ,right=1868 ,bottom=230 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=19 ,top=442 ,right=1868 ,bottom=442 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=19 ,top=508 ,right=1868 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1871 ,top=3 ,right=1871 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=937 ,top=3 ,right=937 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=950 ,top=3 ,right=950 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=251 ,top=153 ,right=251 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=479 ,top=153 ,right=479 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=706 ,top=153 ,right=706 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1180 ,top=153 ,right=1180 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1410 ,top=153 ,right=1410 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1638 ,top=153 ,right=1638 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=127 ,top=442 ,right=127 ,bottom=511 </L>
	<L> left=362 ,top=442 ,right=362 ,bottom=511 </L>
	<L> left=590 ,top=442 ,right=590 ,bottom=511 </L>
	<L> left=820 ,top=442 ,right=820 ,bottom=511 </L>
	<L> left=1064 ,top=442 ,right=1064 ,bottom=511 </L>
	<L> left=1299 ,top=442 ,right=1299 ,bottom=511 </L>
	<L> left=1519 ,top=442 ,right=1519 ,bottom=511 </L>
	<L> left=1752 ,top=442 ,right=1752 ,bottom=511 </L>
	<I>id='../common/img/icon.jpg' ,left=1461 ,top=534 ,right=1873 ,bottom=616</I>
	<L> left=19 ,top=527 ,right=1868 ,bottom=527 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��   ��   ��   ��' ,left=249 ,top=11 ,right=714 ,bottom=71 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    ��   ��   ��' ,left=1180 ,top=11 ,right=1643 ,bottom=71 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=13 ,top=3 ,right=13 ,bottom=508 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>

	">
	</OBJECT><%=HDConstant.COMMENT_END%>	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->
<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>