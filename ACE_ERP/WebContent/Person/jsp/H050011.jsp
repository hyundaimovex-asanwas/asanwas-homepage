<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� �� :  �λ�_�����û����(�ؿ�&����)
+ ���α׷� ID :  H050010.html
+ �� �� �� �� :  ����, �ؿ� ������ ��� �� �����ϰ�, ���������� ��� 
                 Ư������ ó���Ͽ� ���¿� �����Ѵ�.
								 ���� �� ���ڰ���� �����Ͽ� �����Ѵ�.
								 �׸���, ����Ư���� ��� ���� ����� �ڵ� ����ȴ�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2007.07.13
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� �� :	
+ ��   ��  �� : 
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� �� : h050010_s1 - �ؿ�,���� ���� mst ��ȸ
                h050010_s2 - ���� ���� dtl ��ȸ
                h050010_t1 - �ؿ����� 
								h050010_t2 - ��������
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
get_cookdata();
lfn_init();
var gs_date_fr = gcurdate.substring(0,4) + gcurdate.substring(5,7) + "01";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var g_managegb="";

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	gcem_frdt.text=gs_date_fr;
  gcem_todt.text=gs_date;
	gclx_closeyn.index=0;
	gclx_closeyn_1.index=0;
	gclx_closeyn_2.index=0;
	gclx_closeyn_1.enable=false;
	gclx_closeyn_2.enable=false;
	ln_Before();
}

/******************************************************************************
	Description : �ε��� ��ȸ
******************************************************************************/
function ln_Before(){

  //�����ڱ���
	gcds_manager.DataID = "/servlet/Person.hclcode_s2?v_str1=2052&v_str2="+gusrid;
	gcds_manager.Reset();	
	//���±���
	gcds_lazcd.DataID = "/servlet/Person.hclcode_s1?v_str1=1124&v_str2=G";
	gcds_lazcd.Reset();

	gcds_lazcd_1.DataID = "/servlet/Person.hclcode_s1?v_str1=1124&v_str2=G";
	gcds_lazcd_1.Reset();

	gcds_lazcd_2.DataID = "/servlet/Person.hclcode_s1?v_str1=1124&v_str2=G";
	gcds_lazcd_2.Reset();

  /*
	//�Ҽ��ڵ�[��ȸ����]
	gcds_deptcd.DataID = "/servlet/Person.hcdept_s1?v_str1=";
	gcds_deptcd.Reset();
  */

  //�Ҽ��ڵ�[��ȸ����]
	if(g_managegb=="Y"){
		gcds_deptcd.DataID = "/servlet/Person.hcdept_s4?v_str1="+gdeptcd;
		gcds_deptcd.Reset();
  }else{
		gcds_deptcd.DataID = "/servlet/Person.hcdept_s1?v_str1=";
		gcds_deptcd.Reset();
	}
	
	//�����ڵ�[�˻�����]
	gcds_paygrd.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";
	gcds_paygrd.Reset();

	//�ؿ�ȯ������
	gcds_ovrategb.DataID = "/servlet/Account.a010001_s2?v_str1=1043";
	gcds_ovrategb.Reset();

  ln_Paygrd_info(gusrid);

	 //��������
	gcds_traffic.DataID = "/servlet/Person.hclcode_s1?v_str1=2053";
	gcds_traffic.Reset();	

	 //
	gcds_instamt.DataID = "/servlet/Person.hclcode_s1?v_str1=2055";
	gcds_instamt.Reset();	

	gcds_infdamt.DataID = "/servlet/Person.hclcode_s1?v_str1=2056";
	gcds_infdamt.Reset();	

	gcds_dayamt.DataID = "/servlet/Person.hclcode_s1?v_str1=2054";
	gcds_dayamt.Reset();	

  //ȯ��
  gcds_exchage.DataID = "/servlet/Person.hclcode_s1?v_str1=2057";
	gcds_exchage.Reset();	

}

/******************************************************************************
	Description : ���κ� ���� ������ ������.
******************************************************************************/
function ln_Paygrd_info(userid){
	gcds_data2.DataID = "/servlet/Person.h050001_s3?v_str1="+userid;
	gcds_data2.Reset();
}

/******************************************************************************
	Description : ����ڿ� ���� ����
******************************************************************************/
function ln_User_Setting(gbn){
	gcem_frdt_1.ReadOnly=true;

  if(gclx_lazcd.bindcolval=="G02"){ //��������
		if(gbn=="Y"){ //������
			gcem_empno_fr.ReadOnly = false;
			gcem_empno_to.ReadOnly = false;
			txt_empnmk.disabled=false;
			txt_empnmk.readOnly =false;
			gclx_deptcd.enable=true;
			gclx_paygrd.enable=true;
			gcem_empno_fr.text = gusrid;
			gcem_empno_to.text = gusrid;
			txt_empnmk.value=gusrnm;

			gclx_deptcd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");
			gclx_paygrd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");
			
		}else{        //�Ϲݻ����
			gcem_empno_fr.ReadOnly = true;
			gcem_empno_to.ReadOnly = true;
			txt_empnmk.disabled=false;
			txt_empnmk.readOnly =true;
			gclx_deptcd.enable=false;
			gclx_paygrd.enable=false;
			gcem_empno_fr.text = gusrid;
			gcem_empno_to.text = gusrid;
			txt_empnmk.value=gusrnm;

			gclx_deptcd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");
			gclx_paygrd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");
				
		}
	}else{
		if(gbn=="Y"){ //������
			gclx_ovrategb_1.enable=true;
			//gcem_ovrate_1.enable=true;
      gcem_ovrate_1.ReadOnly=true;

			gcem_ovdsamt_1.enable=true;
			gcem_ovwnamt_1.enable=true;
			gcem_caramt_1.enable=true;
			txt_ovetc_1.disabled=false;

		}else{        //�Ϲݻ����
		  /*
			gclx_ovrategb_1.enable=false;
			gcem_ovrate_1.enable=false;
			gcem_ovdsamt_1.enable=false;
			gcem_ovwnamt_1.enable=false;
			gcem_caramt_1.enable=false;
			txt_ovetc_1.disabled=true;
			*/

      gcem_ovrate_1.ReadOnly=true;
			gcem_empno_fr.ReadOnly = true;
			gcem_empno_to.ReadOnly = true;

			txt_empnmk.disabled=false;
			gclx_deptcd.enable=false;
			gclx_paygrd.enable=false;

			gcem_empno_fr.text = gusrid;
			gcem_empno_to.text = gusrid;
			txt_empnmk.value=gusrnm;

			gclx_deptcd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");
			gclx_paygrd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");
		}
	}
}

/******************************************************************************
	Description : ��ȸ
	Parameter   : 
******************************************************************************/
function ln_Query(){
  var strdeptcd="";
	if(gclx_deptcd.bindcolval==""){ //��ü�� ���
		for(i=1;i<=gcds_deptcd.countrow;i++){
			if(i==1){
				strdeptcd = "'"+gcds_deptcd.namevalue(i,"DEPTCD")+"'";
			}else{
				strdeptcd = strdeptcd+",'"+gcds_deptcd.namevalue(i,"DEPTCD")+"'";
			}
		}
	}else{
		strdeptcd =  "'"+gclx_deptcd.bindcolval+"'"
	}

	strdeptcd = "("+strdeptcd+")";

	if(gclx_lazcd.bindcolval=="G02"){//��������
		gcds_data02.DataID = "/servlet/Person.h050010_s1?"
		                   + "v_str1=" + gcem_frdt.text
											 + "&v_str2=" + gcem_todt.text
											 + "&v_str3=" + fn_trim(gcem_empno_fr.text)
											 + "&v_str4=" + fn_trim(gcem_empno_to.text)
											 + "&v_str5=" + fn_trim(txt_empnmk.value)
											 + "&v_str6=" + gclx_lazcd.bindcolval
											 + "&v_str7=" + strdeptcd
											 + "&v_str8=" + gclx_paygrd.bindcolval
											 + "&v_str9=" + gclx_closeyn.bindcolval;
		gcds_data02.Reset();
	}else{
		gcds_data01.DataID = "/servlet/Person.h050010_s1?"
		                   + "v_str1=" + gcem_frdt.text
											 + "&v_str2=" + gcem_todt.text
											 + "&v_str3=" + fn_trim(gcem_empno_fr.text)
											 + "&v_str4=" + fn_trim(gcem_empno_to.text)
											 + "&v_str5=" + fn_trim(txt_empnmk.value)
											 + "&v_str6=" + gclx_lazcd.bindcolval
											 + "&v_str7=" + strdeptcd
											 + "&v_str8=" + gclx_paygrd.bindcolval
											 + "&v_str9=" + gclx_closeyn.bindcolval;
		gcds_data01.Reset();
	}
}

/******************************************************************************
	Description : ��������� ��ȸ
	Parameter   : 
******************************************************************************/
function ln_Query_Dtl(row){
	//if(row<1)return;
	gcds_data03.DataID = "/servlet/Person.h050010_s2?"
										 + "v_str1=" + gcds_data02.namevalue(row,"APPDT")
										 + "&v_str2=" + gcds_data02.namevalue(row,"EMPNO")
										 + "&v_str3=" + gcds_data02.namevalue(row,"LAZCD")
										 + "&v_str4=" + gcds_data02.namevalue(row,"FRDT");	
	gcds_data03.Reset();
}

/******************************************************************************
	Description : �߰�
	              Mst Data�� 2���̻� ���ÿ� �Է����� ����.
******************************************************************************/
function ln_Add(){
  var cnt=0;
	ln_SetDataHeader();
	if(gclx_lazcd.bindcolval=="G02"){ //��������
	  //if(ln_Chk_Save()){
		  var intc=0;
      for(i=1;i<=gcds_data02.countrow;i++){
				if(gcds_data02.SysStatus(i)==1||gcds_data02.SysStatus(i)==2||gcds_data02.SysStatus(i)==3){
					intc+=1;
				}
			}

			if(intc>0){
				alert("���� �� ��� �Ͻʽÿ�.");
				return false;
			}

			for(i=1;i<=gcds_data03.countrow;i++){
				if(gcds_data03.SysStatus(i)==1||gcds_data03.SysStatus(i)==2||gcds_data03.SysStatus(i)==3){
					alert("���� �� ����Ͻʽÿ�.");
					return false;
				}
			}
			gcds_data02.addrow();
			gcds_data02.namevalue(gcds_data02.rowposition,"APPDT")=gs_date;
			txt_deptnm_2.value	=  gcds_data2.namevalue(gcds_data2.rowpostion,"DEPTNM");		//�ҼӸ�
			txt_paygrdnm_2.value = gcds_data2.namevalue(gcds_data2.rowpostion,"MINORNM");	//����
			txt_empnmk_2.value	= gusrnm;																//����	
			gcem_empno_2.text = gcds_data2.namevalue(gcds_data2.rowpostion,"EMPNO");	 
			txt_deptcd_2.value =gcds_data2.namevalue(gcds_data2.rowpostion,"DEPTCD");	
			txt_paygrd_2.value =gcds_data2.namevalue(gcds_data2.rowpostion,"PAYGRD");	

			gclx_lazcd_2.index=0;
			gcds_lazcd_2.Filter();
			gclx_closeyn_2.index=0;
			gcds_data03.Addrow();
			ln_Query_Dtl(gcds_data02.rowposition);
      ln_User_Setting(g_managegb);
		//}
	}else{
		gcds_data01.addrow();
		gcds_data01.namevalue(gcds_data01.rowposition,"APPDT")=gs_date;
		gclx_lazcd_1.index=0;
		gcds_lazcd_1.Filter();
		gclx_closeyn_1.index=0;
		txt_deptnm_1.value	= gcds_data2.namevalue(gcds_data2.rowpostion,"DEPTNM");		//�ҼӸ�
		txt_paygrdnm_1.value = gcds_data2.namevalue(gcds_data2.rowpostion,"MINORNM");	//����
		txt_empnmk_1.value	= gusrnm;																//����	
		gcem_empno_1.text = gcds_data2.namevalue(gcds_data2.rowpostion,"EMPNO");	 
		txt_deptcd_1.value =gcds_data2.namevalue(gcds_data2.rowpostion,"DEPTCD");	
		txt_paygrd_1.value =gcds_data2.namevalue(gcds_data2.rowpostion,"PAYGRD");	

		gcem_ovrate_1.text = gcds_exchage.namevalue(gcds_exchage.rowposition,"MINORNM");
    gclx_ovrategb_1.index =1;
		gcem_sum_1.text=0;
		
		ln_User_Setting(g_managegb);
 }
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	 if(gclx_lazcd.bindcolval=="G02"){ //��������
			if(gcds_data02.IsUpdated||gcds_data03.IsUpdated){
				var row = gcds_data02.rowposition;
				ln_Calc_Days(); //�����ϼ����
				if(ln_Chk_Save()){
					if(gcds_data02.SysStatus(row)==3){
						if(gcds_data02.namevalue(row,"CLOSYN")=="I"){
							alert("���� �������Դϴ�. ������ �� �����ϴ�.");
							return false;
						}else if(gcds_data02.namevalue(row,"CLOSYN")=="Y"){
							alert("����Ϸ� �Ǿ����ϴ�. ������ �� �����ϴ�.");
							return false;
						}else if(gcds_data02.namevalue(row,"CLOSYN")=="J"){
							alert("�����Ϸ� �Ǿ����ϴ�. ������ �� �����ϴ�.");
							return false;
						}else if(gcds_data02.namevalue(row,"CLOSYN")=="S"){
							alert("���Ű���Ϸ� �Ǿ����ϴ�. ������ �� �����ϴ�.");
							return false;
						}
					}

					if(!ln_Chk_Otdt())return;
          
					//��������MST
          //DIVCDã�� 
					gcds_data02.namevalue(gcds_data02.rowposition,"DIVCD")=ln_Find_Divcd(gcds_data02.namevalue(gcds_data02.rowposition,"DEPTCD"));
          gcds_data02.namevalue(gcds_data02.rowposition,"APPLYID")=gusrid;
					gcds_data02.namevalue(gcds_data02.rowposition,"WRDT")=gs_date;
					gcds_data02.namevalue(gcds_data02.rowposition,"WRID")=gusrid;
					gcds_data02.namevalue(gcds_data02.rowposition,"UPDT")=gs_date;
					gcds_data02.namevalue(gcds_data02.rowposition,"UPID")=gusrid;

          //��������DTL
					for(i=1;i<=gcds_data03.countrow;i++){
					  if(gcds_data03.SysStatus(i)==1||gcds_data03.SysStatus(i)==3){
							gcds_data03.namevalue(i,"WRDT")=gs_date;
							gcds_data03.namevalue(i,"WRID")=gusrid;
							gcds_data03.namevalue(i,"UPDT")=gs_date;
							gcds_data03.namevalue(i,"UPID")=gusrid;
							gcds_data03.namevalue(i,"DEPTCD")=gcds_data02.namevalue(gcds_data02.rowposition,"DEPTCD");
							gcds_data03.namevalue(i,"PAYGRD")=gcds_data02.namevalue(gcds_data02.rowposition,"PAYGRD");
							gcds_data03.namevalue(i,"MEMO")=gcds_data02.namevalue(gcds_data02.rowposition,"MEMO");
							gcds_data03.namevalue(i,"HLNO")=gcds_data02.namevalue(gcds_data02.rowposition,"HLNO");
						}
					}

					if (confirm("���� �Ͻðڽ��ϱ�?")){	
						gctr_data02.Action = "/servlet/Person.h050010_t2?";
						//prompt("gcds_data02",gcds_data02.text);
            //prompt("gcds_data03",gcds_data03.text);
						gctr_data02.post();
						ln_Query();
					}	
				}
			}			
	 }else{
			if (gcds_data01.IsUpdated){
				var row = gcds_data01.rowposition;
				ln_Calc_Days(); //�����ϼ����
				if(ln_Chk_Save()){
					if(gcds_data01.SysStatus(row)==3){
						if(gcds_data01.namevalue(row,"CLOSYN")=="I"){
							alert("���� �������Դϴ�. ������ �� �����ϴ�.");
							return false;
						}else if(gcds_data01.namevalue(row,"CLOSYN")=="Y"){
							alert("����Ϸ� �Ǿ����ϴ�. ������ �� �����ϴ�.");
							return false;
						}else if(gcds_data01.namevalue(row,"CLOSYN")=="J"){
							alert("�����Ϸ� �Ǿ����ϴ�. ������ �� �����ϴ�.");
							return false;
						}else if(gcds_data01.namevalue(row,"CLOSYN")=="S"){
							alert("���Ű���Ϸ� �Ǿ����ϴ�. ������ �� �����ϴ�.");
							return false;
						}
					}
          //DIVCDã�� 
          gcds_data01.namevalue(gcds_data01.rowposition,"DIVCD")=ln_Find_Divcd(gcds_data01.namevalue(gcds_data01.rowposition,"DEPTCD"));
          gcds_data01.namevalue(gcds_data01.rowposition,"APPLYID")=gusrid;
					gcds_data01.namevalue(gcds_data01.rowposition,"WRDT")=gs_date;
					gcds_data01.namevalue(gcds_data01.rowposition,"WRID")=gusrid;
					gcds_data01.namevalue(gcds_data01.rowposition,"UPDT")=gs_date;
					gcds_data01.namevalue(gcds_data01.rowposition,"UPID")=gusrid;

					if (confirm("���� �Ͻðڽ��ϱ�?")){	
						gctr_data01.Action = "/servlet/Person.h050010_t1?";
						gctr_data01.post();
						ln_Query();
					}	
				}
			}			
	 }
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
  if(gclx_lazcd.bindcolval=="G02"){ //��������
	  if(!ln_Chk_Delete(gclx_lazcd.bindcolval))return;
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
		  gcds_data02.ClearAllMark();
			for(i=1;i<=gcds_data02.countrow;i++){
				if(gcds_data02.namevalue(i,"CHK")=="T"){
					gcds_data02.MarkRows(i,i);
				}
			}
			gcds_data02.DeleteMarked();
			gctr_data02.action = "/servlet/Person.h050010_t2?";
			gctr_data02.post();
      ln_Query();
		}
	}else{
	  if(!ln_Chk_Delete(gclx_lazcd.bindcolval))return;
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
			gcds_data01.ClearAllMark();
			for(i=1;i<=gcds_data01.countrow;i++){
				if(gcds_data01.namevalue(i,"CHK")=="T"){
					gcds_data01.MarkRows(i,i);
				}
			}
			gcds_data01.DeleteMarked();
			gctr_data01.action = "/servlet/Person.h050010_t1?";
			gctr_data01.post();
		}
	}
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : �˾�
	Parameter   : 1 - �ؿ�����
	              2 - �������� mst
******************************************************************************/
function ln_Popup(gbn){
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	if(g_managegb!="Y"){ //�μ������ڰ� �ƴ� ���
		return;
	}else{
		arrSend[1]=gusrid;
	}

	if(gbn=="1"){
	  if(gcds_data01.SysStatus(gcds_data01.rowposition)!=1){
			return false;
		}
	}else if(gbn=="2"){
		if(gcds_data02.SysStatus(gcds_data02.rowposition)!=1){
			return false;
		}
	}

	//arrSend[0]="EMPNO";
	arrSend[0]="H050005";
	strURL = "../../Person/html/H030003_popup.html"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if(gbn=="0"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_empnmk.value = arrParam[0]; //����
		} else {
			txt_empnmk.value ="";			//����
		}
	}else if(gbn=="1"||gbn=="2"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			eval("txt_empnmk_"+gbn).value = arrParam[0]; //����
			eval("gcem_empno_"+gbn).text = arrParam[1];  //���
			eval("txt_deptcd_"+gbn).value=arrParam[4];   //
			eval("txt_deptnm_"+gbn).value=arrParam[2];   //
			eval("txt_paygrd_"+gbn).value=arrParam[5];   //
			eval("txt_paygrdnm_"+gbn).value=arrParam[3]; //
			gcds_data02.namevalue(gcds_data02.rowposition,"MEMO")= arrParam[6];

			if(gbn=="2")ln_Key_Change(gcds_data02.rowposition); //�������� �󼼿� Ű�� �ڵ� ������.
		} else {
			eval("txt_empnmk_"+gbn).value  ="";			//����
			eval("gcem_empno_"+gbn).text="";
			eval("txt_deptcd_"+gbn).value="";   //
			eval("txt_deptnm_"+gbn).value="";   //
			eval("txt_paygrd_"+gbn).value="";   //
			eval("txt_paygrdnm_"+gbn).value=""; //
	  	gcds_data02.namevalue(gcds_data02.rowposition,"MEMO")= "";

		}
	}
}

/******************************************************************************
	Description : �׷���� ���� ����
******************************************************************************/
function ln_Submit(){
	var arrMst	= new Array();
	var arrDtl	= new Array();
	var m=0; //
	var dblovwnamt=0;
	var cnt =0;
	var strFrdt="";
	var yy="";
	var mm="";
	var dd="";
	var strTodt="";
	var yy2="";
	var mm2="";
	var dd2="";
	var strTemp="";
	var strTemp2="";
	var strOtdt="";

	if(!ln_Chk_Submit(gclx_lazcd.bindcolval)) return;

	if(gclx_lazcd.bindcolval=="G02"){ //��������
		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"CHK")=="T"){
			   arrMst[0]="HA2";                                        //����ڵ�
				 arrMst[1]=gusrid;                                       //����ڻ��
				 arrMst[2]=fn_trim(gcds_data02.namevalue(i,"OBJECT"));   //������       
				 arrMst[3]=fn_trim(gcds_data02.namevalue(i,"TRIPOBJ"));  //�������       
				
				 //����Ⱓ
				 strFrdt = gcds_data02.namevalue(i,"FRDT");      //
				 yy = strFrdt.substring(0,4);
				 mm = strFrdt.substring(4,6);
				 dd = strFrdt.substring(6,8);
				 strTemp=yy+" �� "+mm+" �� "+dd+" ��"+"  ( "+ gf_dayOfWeek(yy,mm,dd) +" )"  

				 strTodt = gcds_data02.namevalue(i,"TODT");      //
				 yy2 = strTodt.substring(0,4);
				 mm2 = strTodt.substring(4,6);
				 dd2 = strTodt.substring(6,8);
				 strTemp2=yy2+" �� "+mm2+" �� "+dd2+" ��"+"  ( "+ gf_dayOfWeek(yy2,mm2,dd2) +" )"  
				 arrMst[4]=strTemp +"~"+ strTemp2;
				 
				 arrMst[7]=fn_trim(gcds_data02.namevalue(i,"REMARK1"));   //���1
				 arrMst[8]=fn_trim(gcds_data02.namevalue(i,"REMARK2"));   //���2
				 break; 
			}
		}

		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"CHK")=="T"){
				dblovwnamt=dblovwnamt+gcds_data02.namevalue(i,"OVWNAMT")+gcds_data02.namevalue(i,"CARAMT");
			}
		}
		arrMst[5]=gf_setnum(dblovwnamt);      
    //�������� DTL
		//�μ�, ����, ���, ����, ����,  ����,  ����, �����, ���ں�, �Ĵ�, �Ϻ�, �� 
		for(j=1;j<=gcds_data02.countrow;j++){
			if(gcds_data02.namevalue(j,"CHK")=="T"){
 				ln_Query_Dtl(j);
				for(k=1;k<=gcds_data03.countrow;k++){
				  cnt+=1;
					arrDtl[0+m]=fn_trim(gcds_data02.namevalue(j,"DIVNM"))//+"/"+fn_trim(gcds_data02.namevalue(j,"DEPTNM"));//�μ�
					arrDtl[1+m]=gcds_data02.namevalue(j,"PAYGRDNM");//����
					arrDtl[2+m]=gcds_data02.namevalue(j,"EMPNMK");  //����
					strOtdt=gcds_data03.namevalue(k,"OTDT");        //����
					strOtdt = strOtdt.substring(4,6)+"/"+ strOtdt.substring(6,8);
          arrDtl[3+m]=strOtdt;  
					arrDtl[4+m]=gcds_data03.namevalue(k,"SECTION"); //����
					arrDtl[5+m]=gcds_data03.namevalue(k,"TRAFFICNM"); //������
					arrDtl[6+m]=gf_setnum(gcds_data03.namevalue(k,"CARFARE")); //�����
					arrDtl[7+m]=gf_setnum(gcds_data03.namevalue(k,"INSTAMT")); //���ں�
					arrDtl[8+m]=gf_setnum(gcds_data03.namevalue(k,"INFDAMT")); //�ĺ�
					arrDtl[9+m]=gf_setnum(gcds_data03.namevalue(k,"INDAYAMT")); //�Ϻ�
					arrDtl[10+m]=gf_setnum(gcds_data03.namevalue(k,"CARFARE")+gcds_data03.namevalue(k,"INSTAMT")+gcds_data03.namevalue(k,"INFDAMT")+gcds_data03.namevalue(k,"INDAYAMT")); //��					
					arrDtl[11+m]=gcds_data02.namevalue(j,"HLNO");  //�����ȣ
					m+=12;
				}
			}
		}
		arrMst[6]=cnt; 
	}else{                       //�ؿ�����
		//�ؿ����� MST
		//������, �������, ����Ⱓ
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				 arrMst[0]="HA3";                                        //����ڵ�
				 arrMst[1]=gusrid;                                       //����ڻ��
				 arrMst[2]=fn_trim(gcds_data01.namevalue(i,"OBJECT"));   //������       
	 		   arrMst[3]=fn_trim(gcds_data01.namevalue(i,"TRIPOBJ"));  //�������       
				
         //����Ⱓ
				 strFrdt = gcds_data01.namevalue(i,"FRDT");      //
				 yy = strFrdt.substring(0,4);
				 mm = strFrdt.substring(4,6);
				 dd = strFrdt.substring(6,8);
				 strTemp=yy+" �� "+mm+" �� "+dd+" ��"+"  ( "+ gf_dayOfWeek(yy,mm,dd) +" )";  

				 strTodt = gcds_data01.namevalue(i,"TODT");      //
				 yy2 = strTodt.substring(0,4);
				 mm2 = strTodt.substring(4,6);
				 dd2 = strTodt.substring(6,8);
				 strTemp2=yy2+" �� "+mm2+" �� "+dd2+" ��"+"  ( "+ gf_dayOfWeek(yy2,mm2,dd2) +" )";  
 
         arrMst[4]=strTemp +"~"+ strTemp2;
				 arrMst[6]=gcds_data01.namevalue(i,"OVRATE");//ȯ��  

				 arrMst[8]=fn_trim(gcds_data01.namevalue(i,"REMARK1"));   //���1       
	 		   arrMst[9]=fn_trim(gcds_data01.namevalue(i,"REMARK2"));   //���2  
				 break;
			}
		}

		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				dblovwnamt=dblovwnamt+gcds_data01.namevalue(i,"OVWNAMT")+gcds_data01.namevalue(i,"CARAMT")+gcds_data01.namevalue(i,"OVFDAMT");
				cnt+=1;
			}
		}
		arrMst[5]=gf_setnum(dblovwnamt);      
		arrMst[7]=cnt; 

    //�ؿ����� DTL
		//�μ�, ����, ���, ����, �Ⱓ,  �ϼ�,  �����, ȯ��, �ĺ�, ����� 
		for(j=1;j<=gcds_data01.countrow;j++){
			if(gcds_data01.namevalue(j,"CHK")=="T"){
        arrDtl[0+m]=fn_trim(gcds_data01.namevalue(j,"DIVNM")) //+"/"+fn_trim(gcds_data01.namevalue(j,"DEPTNM"));//�μ�
				arrDtl[1+m]=gcds_data01.namevalue(j,"PAYGRDNM");//����
				arrDtl[2+m]=gcds_data01.namevalue(j,"EMPNMK");//����
				strFrdt = gcds_data01.namevalue(j,"FRDT");      //
				mm = strFrdt.substring(4,6);
				dd = strFrdt.substring(6,8);
				strTodt = gcds_data01.namevalue(j,"TODT");      //
				mm2 = strTodt.substring(4,6);
				dd2 = strTodt.substring(6,8);
				arrDtl[3+m]=mm+"/"+dd+"-"+mm2+"/"+dd2;//�Ⱓ
				arrDtl[4+m]=gcds_data01.namevalue(j,"INTRDAY");//�ϼ�
				arrDtl[5+m]=gcds_data01.namevalue(j,"OVETC");  //�����
				arrDtl[6+m]=gf_setnum(gcds_data01.namevalue(j,"OVFDAMT"));//�ĺ�
				arrDtl[7+m]=gf_setnum(gcds_data01.namevalue(j,"CARAMT"));//�����
				arrDtl[8+m]=gf_setnum(gcds_data01.namevalue(j,"OVWNAMT")+gcds_data01.namevalue(j,"OVFDAMT")+gcds_data01.namevalue(j,"CARAMT"));//�հ�
				arrDtl[9+m]=gcds_data01.namevalue(j,"HLNO");  //�����ȣ
				m+=10;
			}
		}
	}

	//���ȣ��
	//document.all("ifrm").src ="../../Person/html/GP_form.html";
	ifrm.ln_Popup(arrMst[0],arrMst,arrDtl);
}
/******************************************************************************
	Description : ȭ�� Display
	prameter    : 
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp01","div_disp02");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************
	Description : �������� �� ���߰�
	prameter    : 
******************************************************************************/
function ln_Dtl_Add(){
   var row=gcds_data02.rowposition;
  //���� �׸��尡 �ƹ��͵� ���� ��� ���߰� �ȵ�.
	//���� �׸����� Ű���� �Է����� ��� ������.
	//���� ���� �׸����� Ű���� ������ ��� ���� �׸��嵵 �Բ� ����Ǿ����.
	ln_SetDataHeader2();
	if(gclx_lazcd.bindcolval=="G02"){ //��������
	 
		if(gcds_data02.countrow==0||row<1){
			alert("���߰� �� �� �����ϴ�.");
			return false;
		}

		if(fn_trim(gcds_data02.namevalue(row,"APPDT"))==""||fn_trim(gcds_data02.namevalue(row,"EMPNO"))==""||
		   fn_trim(gcds_data02.namevalue(row,"EMPNMK"))==""||fn_trim(gcds_data02.namevalue(row,"LAZCD"))==""||
			 fn_trim(gcds_data02.namevalue(row,"FRDT"))==""){
			 alert("�Է°��� �����ϴ�. �Է� �� �� �߰��Ͻʽÿ�.");
			 return false;
		}
		gcds_data03.addrow();
		gcds_data03.namevalue(gcds_data03.rowposition,"APPDT")=gcds_data02.namevalue(row,"APPDT");
		gcds_data03.namevalue(gcds_data03.rowposition,"EMPNO")=gcds_data02.namevalue(row,"EMPNO");
		gcds_data03.namevalue(gcds_data03.rowposition,"EMPNMK")=gcds_data02.namevalue(row,"EMPNMK");
		gcds_data03.namevalue(gcds_data03.rowposition,"LAZCD")=gcds_data02.namevalue(row,"LAZCD");
		gcds_data03.namevalue(gcds_data03.rowposition,"FRDT")=gcds_data02.namevalue(row,"FRDT");
		gcds_data03.namevalue(gcds_data03.rowposition,"OTDT")=gcds_data02.namevalue(row,"FRDT");
		gcds_data03.namevalue(gcds_data03.rowposition,"MEMO")=gcds_data02.namevalue(row,"MEMO");
		ln_Todt_Setting();
		gclx_traffic_2.index=0;

	}
}

/******************************************************************************
	Description : �������� �� �����
	prameter    : 
******************************************************************************/
function ln_Dtl_Del(){
	if(gclx_lazcd.bindcolval=="G02"){ //��������
		gcds_data03.deleterow(gcds_data03.rowposition);
		ln_Wn_AutoSum();
		ln_Todt_Setting();
	}else{
		ln_OV_AutoSum();
	}
}

/******************************************************************************
	Description : �������� Mst����� �󼼵� ������.
	prameter    : 
******************************************************************************/
function ln_Key_Change(row){
	for(i=1;i<=gcds_data03.countrow;i++){
		gcds_data03.namevalue(i,"APPDT")=gcds_data02.namevalue(row,"APPDT");
		gcds_data03.namevalue(i,"EMPNO")=gcds_data02.namevalue(row,"EMPNO");
		gcds_data03.namevalue(i,"EMPNMK")=gcds_data02.namevalue(row,"EMPNMK");
		gcds_data03.namevalue(i,"LAZCD")=gcds_data02.namevalue(row,"LAZCD");
		gcds_data03.namevalue(i,"FRDT")=gcds_data02.namevalue(row,"FRDT");
		gcds_data03.namevalue(i,"HLNO")=gcds_data02.namevalue(row,"HLNO");
	}
}

/************************************************************************************************************
	Description : �����ڵ� ã��
	parameter   :
*************************************************************************************************************/
function ln_Find_Divcd(strdeptcd){
	  if(strdeptcd=="")return;
		gcds_divcd.DataID = g_servlet+"/Account.a020001_s9?v_str1="+strdeptcd;		
		//prompt('',gcds_divcd.DataID);
		gcds_divcd.Reset();
    if(gcds_divcd.countrow>0){
			return gcds_divcd.namevalue(gcds_divcd.rowposition,"DIVCD");
		}else{
			return;
		}
}
/******************************************************************************
	Description : �����ϼ����
	prameter    : 
******************************************************************************/
function ln_Calc_Days(){
  if(gclx_lazcd.bindcolval=="G02"){ //��������
		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.SysStatus(i)==1||gcds_data02.SysStatus(i)==3){
				 gcds_data02.namevalue(i,"INTRDAY") = ln_DataChk(gcds_data02.namevalue(i,"FRDT"),gcds_data02.namevalue(i,"TODT"));
			}
		}
	}else{
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.SysStatus(i)==1||gcds_data01.SysStatus(i)==3){
				 gcds_data01.namevalue(i,"INTRDAY") = ln_DataChk(gcds_data01.namevalue(i,"FRDT"),gcds_data01.namevalue(i,"TODT"));
			}
		}
	} 
}

/******************************************************************************
	Description : ��¥ ���� ��ȸ
	Parameter   : frdt - �����, todt - ������
******************************************************************************/
function ln_DataChk(frdt,todt) { 
	var fryy =frdt.substring(0,4);
	var frmm =frdt.substring(4,6);
	var frdd =frdt.substring(6,8);

	var toyy =todt.substring(0,4);
	var tomm =todt.substring(4,6);
	var todd =todt.substring(6,8);

	frdate=new Date(fryy,frmm-1,frdd); //�������� 1�� ���� 
	todate=new Date(toyy,tomm-1,todd); //���ó�¥ 

	frtime=frdate.getTime(); //��߽ð� 
	totime=todate.getTime(); //�����ð�
	cha=totime-frtime;       //�ð����� 
	conv=Math.floor(cha/(60*60*24*1000))+1; //�ð����̸� �������̷� ��� 
	return conv
}

/******************************************************************************
	Description : ����� üũ
	prameter    : 
******************************************************************************/
function ln_Chk_Save(){
  
	if(gclx_lazcd.bindcolval=="G02"){//��������
		
		for(j=1;j<=gcds_data02.countrow;j++){
			if(gcds_data02.SysStatus(j)==1||gcds_data02.SysStatus(j)==3){
				if(gcds_data02.namevalue(j,"EMPNO")==""||gcds_data02.namevalue(j,"EMPNMK")==""){
					alert("������ Ȯ���ϼ���.");
					return false;
				}
				if(gcds_data02.namevalue(j,"DEPTCD")==""||gcds_data02.namevalue(j,"DEPTNM")==""){
					alert("�μ��� Ȯ���ϼ���.");
					return false;
				}
				if(gcds_data02.namevalue(j,"PAYGRD")==""||gcds_data02.namevalue(j,"PAYGRDNM")==""){
					alert("������ Ȯ���ϼ���.");
					return false;
				}
				if(gcds_data02.namevalue(j,"LAZCD")==""){
					alert("���±����� Ȯ���ϼ���.");
					return false;
				}
				if(gcds_data02.namevalue(j,"TRIPOBJ")==""){
					alert("��������� Ȯ���ϼ���.");
					return false;
				}
				if(gcds_data02.namevalue(j,"FRDT")==""){
					alert("������� Ȯ���ϼ���.");
					return false;
				}
        if(gcds_data02.namevalue(j,"TODT")==""){
					alert("�������� Ȯ���ϼ���.");
					return false;
				}
				if(gcds_data02.namevalue(j,"FRDT")<=gs_date){
					alert("������� �����Ϻ��� ũ���մϴ�.");
					return false;
				}
				if(gcds_data02.namevalue(j,"FRDT")>gcds_data02.namevalue(j,"TODT")){
					alert("�������� ����Ϻ��� ���ų� ũ���մϴ�.");
					return false;
				}
				if(gcds_data02.namevalue(j,"OBJECT")==""){
					alert("�������� Ȯ���ϼ���.");
					return false;
				}
			}
		}
		
	
		//���Է�Ȯ��///////////////////////
		for(i=1;i<=gcds_data03.countrow;i++){
			if(fn_trim(gcds_data03.namevalue(i,"OTDT"))==""){
				alert("���ڸ� Ȯ���Ͻʽÿ�.");
				return false;
			}

			/*
			if(gcds_data03.namevalue(i,"SECTION")==""){
				alert("������ Ȯ���ϼ���.");
				return false;
			}
			*/
			//�������� ����ϰ� ������ ���̿� �־���Ѵ�.
			if(gcds_data03.namevalue(i,"OTDT")<gcem_frdt_2.text||gcds_data03.namevalue(i,"OTDT")>gcem_todt_2.text){
				alert("���ڸ� Ȯ���Ͻʽÿ�.");
				return false;
			}

			if(gcds_data03.namevalue(i,"CARFARE")==0&&gcds_data03.namevalue(i,"INSTAMT")==0&&
			   gcds_data03.namevalue(i,"INFDAMT")==0&&gcds_data03.namevalue(i,"INDAYAMT")==0){
				alert("���Է¿��� ����� �Է��Ͻʽÿ�");
				return false;
			}
		}
		////////////////////////////////////

	}else{
		/***����***/
		if(gcem_empno_1.text==""||txt_empnmk_1.value==""){//����
			alert("������ Ȯ���ϼ���.");
			return false;
		}
		if(txt_deptcd_1.value==""||txt_deptnm_1.value==""){//�Ҽ�
			alert("�Ҽ��� Ȯ���ϼ���.");
			return false;
		}
		if(txt_paygrd_1.value==""||txt_paygrdnm_1.value==""){//����
			alert("������ Ȯ���ϼ���.");
			return false;
		}
		if(gclx_lazcd_1.bindcolval==""||gclx_lazcd_1.text==""){//����
			alert("���±����� Ȯ���ϼ���.");
			return false;
		}
		if(txt_tripobj_1.value==""){//�������
			alert("��������� Ȯ���ϼ���.");
			return false;
		}
		if(gcem_frdt_1.text==""){//
			alert("������� Ȯ���ϼ���.");
			return false;
		}
		if(gcem_todt_1.text==""){//
			alert("�������� Ȯ���ϼ���.");
			return false;
		}
    //�����>=�����Ϻ�
		if(gcem_frdt_1.text<=gs_date){
			alert("������� �����Ϻ��� ũ���մϴ�.");
			return false;
		}
		//������>=�����
		if(gcem_frdt_1.text>gcem_todt_1.text){
			alert("�������� ����Ϻ��� ���ų� ũ���մϴ�.");
			return false;
		}
		if(txt_object_1.value==""){//
			alert("�������� Ȯ���ϼ���.");
			return false;
		}

		//if(g_managegb=="Y"){ //������
			if(gclx_ovrategb_1.bindcolval==""||gclx_ovrategb_1.text==""){//
				alert("ȯ�������� Ȯ���ϼ���.");
				return false;
			}
		  if(gcem_ovrate_1.text==""||gcem_ovrate_1.text==0){//
				alert("ȯ���� Ȯ���ϼ���.");
				return false;
			}
      if(gcem_ovdsamt_1.text==""||gcem_ovdsamt_1.text==0){//
				alert("�޷��� Ȯ���ϼ���.");
				return false;
			}
			if(gcem_ovwnamt_1.text==""||gcem_ovwnamt_1.text==0){//
				alert("��ȭ�� Ȯ���ϼ���.");
				return false;
			}
			if(gcem_caramt_1.text==""||gcem_caramt_1.text==0){//
				alert("����� Ȯ���ϼ���.");
				return false;
			}
			if(fn_trim(txt_ovetc_1.value)==""){//
				alert("��� Ȯ���ϼ���.");
				return false;
			}

		//}
	}
	return true;
}

/******************************************************************************
	Description : �������忡�� ����ϰ� ������ ������ ��¥�� ������ ��
  parameter   :
******************************************************************************/
function ln_Chk_Otdt(){
	var chk="";
	//�����ϰ� ������ ������ ��� ���ڰ� �����ؾ��Ѵ�.
	step2:
	for(k=gcds_data02.namevalue(gcds_data02.rowposition,"FRDT");k<=gcds_data02.namevalue(gcds_data02.rowposition,"TODT");k++){
		step1:
		for(j=1;j<=gcds_data03.countrow;j++){
			if(k==gcds_data03.namevalue(j,"OTDT")){
			  chk="1";
				break step1;
			}else{
				chk="0";
			}
		}
		if(chk==""||chk=="0"){
			alert(k+" ���ڰ� �������� �ʽ��ϴ�.");
			return false;
			break step2;
		}
	}
	return true;
}

/******************************************************************************
	Description : �������� �ݾ� �ڵ� Sum
  parameter   :
******************************************************************************/
function ln_Wn_AutoSum(){
	var lngovamt =0;
	for(i=1;i<=gcds_data03.countrow;i++){
		if(gcds_data03.SysStatus(i)!=2){
			lngovamt=lngovamt+gcds_data03.namevalue(i,"CARFARE")+gcds_data03.namevalue(i,"INSTAMT")
							+gcds_data03.namevalue(i,"INFDAMT")+gcds_data03.namevalue(i,"INDAYAMT");
		}
	}
	gcds_data02.namevalue(gcds_data02.rowposition,"OVWNAMT")=lngovamt
}

/******************************************************************************
	Description : �ؿ� �ݾ� �ڵ� Sum
  parameter   :
******************************************************************************/
function ln_OV_AutoSum(){
	var row = gcds_data01.rowposition;
	if(gcds_data01.SysStatus(row)!=2){
		gcem_sum_1.text=gcds_data01.namevalue(row,"OVWNAMT")+gcds_data01.namevalue(row,"CARAMT")+gcds_data01.namevalue(row,"OVFDAMT");
	}
}

/******************************************************************************
	Description : �������� ������ �ڵ����� �󼼿��� ã�Ƽ� ������.
  parameter   :
******************************************************************************/
function ln_Todt_Setting(){
	gcds_data02.namevalue(gcds_data02.rowposition,"TODT")=gcds_data03.Max(5,0,0);
}
/******************************************************************************
	Description : Dataset Head ���� - �ؿ�/���� ���� mst
  parameter   :
******************************************************************************/
function ln_SetDataHeader(){
	if(gclx_lazcd.bindcolval=="G02"){ //�������� MST
		if (gcds_data02.countrow<1){
			var s_temp = "CHK:STRING(1),APPDT:STRING(8),EMPNO:STRING(7),LAZCD:STRING(4),FRDT:STRING(8),TODT:STRING(8),"
								 + "DIVCD:STRING(4),DEPTCD:STRING(4),PAYGRD:STRING(4),OBJECT:STRING(30),TRIPOBJ:STRING(50),"
								 + "CARAMT:DECIAML(7.0),OVRATEGB:STRING(4),OVRATE:DECIAML(8.4),OVDSAMT:DECIAML(7.0),OVWNAMT:DECIAML(7.0),OVETC:STRING(100),"
								 + "INTRDAY:DECIAML(7.0),APPLYID:STRING(7),CLOSYN:STRING(1),"
								 + "WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10),"
                 + "EMPNMK:STRING(20),PAYGRDNM:STRING(30),DEPTNM:STRING(50),ORGFRDT:STRING(8),ORGTODT:STRING(8),MEMO:STRING(30),"
								 + "DIVNM:STRING(50),OVFDAMT::DECIAML(7.0), HLNO:STRING(14), REMARK1:STRING(130), REMARK2:STRING(130)";
			gcds_data02.SetDataHeader(s_temp);
		}
	}else{
		if (gcds_data01.countrow<1){
			var s_temp = "CHK:STRING(1),APPDT:STRING(8),EMPNO:STRING(7),LAZCD:STRING(4),FRDT:STRING(8),TODT:STRING(8),"
								 + "DIVCD:STRING(4),DEPTCD:STRING(4),PAYGRD:STRING(4),OBJECT:STRING(30),TRIPOBJ:STRING(50),"
								 + "CARAMT:DECIAML(7.0),OVRATEGB:STRING(4),OVRATE:DECIAML(8.4),OVDSAMT:DECIAML(7.0),OVWNAMT:DECIAML(7.0),OVETC:STRING(100),"
								 + "INTRDAY:DECIAML(7.0),APPLYID:STRING(7),CLOSYN:STRING(1),"
								 + "WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10),"
								 + "EMPNMK:STRING(20),PAYGRDNM:STRING(30),DEPTNM:STRING(50),ORGFRDT:STRING(8),ORGTODT:STRING(8),MEMO:STRING(30),"
								 + "DIVNM:STRING(50),OVFDAMT::DECIAML(7.0), HLNO:STRING(14), REMARK1:STRING(130), REMARK2:STRING(130)";
			gcds_data01.SetDataHeader(s_temp);
		}
	}
}

/******************************************************************************
	Description : Dataset Head ���� 
  parameter   :
******************************************************************************/
function ln_SetDataHeader2(){
	if(gclx_lazcd.bindcolval=="G02"){ //���������
		if (gcds_data03.countrow<1){
			var s_temp = "APPDT:STRING(8),EMPNO:STRING(7),LAZCD:STRING(4),FRDT:STRING(8),OTDT:STRING(8),"
			           + "OTSEQ:STRING(2),SECTION:STRING(20),TRAFFIC:STRING(4),CARFARE:DECIAML(7.0),INSTAMT:DECIAML(7.0),"
								 + "INFDAMT:DECIAML(7.0),INDAYAMT:DECIAML(7.0),WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),"
								 + "UPID:STRING(10),EMPNMK:STRING(20),"
								 + "ORGAPPDT:STRING(8),ORGEMPNO:STRING(7),ORGLAZCD:STRING(4),ORGFRDT:STRING(8),ORGOTDT:STRING(8),"
								 + "ORGOTSEQ:STRING(2),DEPTCD:STRING(4),PAYGRD:STRING(4),MEMO:STRING(30)";
			gcds_data03.SetDataHeader(s_temp);
		}
	}
}

/******************************************************************************
	Description : �޷°���
  parameter   : �������� ��� ������� key���̶� ���� ���ϰ� ����.
******************************************************************************/
function ln_Calendar(gbn){
  if(gclx_lazcd.bindcolval=="G02"){ //��������	
		if(gbn=="fr"){
			if(gcds_data02.SysStatus(gcds_data02.rowposition)!=1){
				return false;
			}
			__GetCallCalendar('gcem_frdt_2','Text');
		}else if(gbn=="ot"){
			__GetCallCalendar('gcem_otdt_2','Text');
      gcem_otdt_2.Focus();
		}
  }else{
		if(gbn=="fr"){
			if(gcds_data01.SysStatus(gcds_data01.rowposition)!=1){
				return false;
			}
			__GetCallCalendar('gcem_frdt_1','Text');
		}
	}
}

/******************************************************************************
	Description : ��ȸ�� Loading bar start
  parameter   :
******************************************************************************/
function ln_Loading_Start(){
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.1";
	//document.all.LowerFrame.style.visibility="visible";
}
/******************************************************************************
	Description : ��ȸ�� Loading bar end
  parameter   :
******************************************************************************/
function ln_Loading_End(row){
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	lbl_search.innerText = "( " + row + " �� )";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
}

/******************************************************************************
	Description : �����üũ
	Parameter :
******************************************************************************/
function ln_Chk_Submit(gbn){
	var cnt=0;
	if(gusrid==""||gusrid==null) return false;
	if(gbn=="") return false;
	if(gbn=="G02"){//����
		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"CHK")=="T"){
				if(gcds_data02.namevalue(i,"CLOSYN")!=""&&gcds_data02.namevalue(i,"CLOSYN")!="N"){
					alert("������ �� �����ϴ�.������¸� Ȯ���Ͻʽÿ�.");
					return false;
				}
				cnt+=1;
			}
		}
		if(cnt==0){
			alert("������ ����� �����Ͻʽÿ�.");
			return false;
		}
	}else if(gbn=="G03"){
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				if(gcds_data01.namevalue(i,"CLOSYN")!=""&&gcds_data01.namevalue(i,"CLOSYN")!="N"){
					alert("������ �� �����ϴ�.������¸� Ȯ���Ͻʽÿ�.");
					return false;
				}
				cnt+=1;
			}
		}
		if(cnt==0){
			alert("������ ����� �����Ͻʽÿ�.");
			return false;
		}
	}
	return true;
}

/******************************************************************************
	Description : ������ üũ
	Parameter :
******************************************************************************/
function ln_Chk_Delete(gbn){
	var cnt=0;
	if(gbn=="") return false;
	if(gbn=="G02"){//����
		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"CHK")=="T"){
				if(gcds_data02.namevalue(i,"CLOSYN")!=""&&gcds_data02.namevalue(i,"CLOSYN")!="N"){
					alert("������ �� �����ϴ�.");
					return false;
				}
				cnt+=1;
			}
		}
		if(cnt==0){
			alert("������ ����� �����Ͻʽÿ�.");
			return false;
		}
	}else if(gbn=="G03"){
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				if(gcds_data01.namevalue(i,"CLOSYN")!=""&&gcds_data01.namevalue(i,"CLOSYN")!="N"){
					alert("������ �� �����ϴ�.");
					return false;
				}
				cnt+=1;
			}
		}
		if(cnt==0){
			alert("������ ����� �����Ͻʽÿ�.");
			return false;
		}
	}
	return true;
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �ؿ����� -->
</OBJECT>

<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--��������mst-->
</OBJECT>

<OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--��������dtl-->
</OBJECT>

<OBJECT id=gcds_lazcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_lazcd_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"  VALUE="false">
	<param name="UseFilter"	value="true">
</OBJECT>

<OBJECT id=gcds_lazcd_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"  VALUE="false">
	<param name="UseFilter"	value="true">
</OBJECT>

<OBJECT id=gcds_deptcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_paygrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_ovrategb classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_manager classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �����ڱ��� -->
</OBJECT>

<OBJECT  id=gcds_divcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--�μ��� �����ڵ� ã��-->
</OBJECT>

<OBJECT id=gcds_traffic classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �������� -->
</OBJECT>

<OBJECT id=gcds_instamt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���ں� -->
</OBJECT>

<OBJECT id=gcds_infdamt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �ĺ�-->
</OBJECT>

<OBJECT id=gcds_dayamt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �Ϻ� -->
</OBJECT>

<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>


<OBJECT id=gcds_exchage classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ����ȯ�� -->
</OBJECT>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><OBJECT id=gctr_data01 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050010_t1(I:USER=gcds_data01)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

 <comment id="__NSID__"><OBJECT id=gctr_data02 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050010_t1(I:USER=gcds_data02,I:USER2=gcds_data03)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ln_Loading_Start();
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	ln_Loading_End(row);
</script>

<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	ln_Loading_Start();
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	ln_Loading_End(row);
	if(row>0)	ln_Query_Dtl(gcds_data02.rowposition);
	else ln_Query_Dtl(0);
</script>

<script language="javascript" for="gcds_manager" event="onloadCompleted(row,colid)">
	if(row>0){ //������
		ln_User_Setting('Y');
		g_managegb="Y";
	}else{     //�Ϲݻ����
    ln_User_Setting('N'); 
		g_managegb="N";
	}
</script>

<script language="javascript"  for="gcds_data2"  event=onLoadCompleted(rowcount)>
	var row = gcds_data2.rowposition;
	
	if(row>0){
		txt_deptnm_1.value	=  gcds_data2.namevalue(row,"DEPTNM");		//�ҼӸ�
		txt_paygrdnm_1.value = gcds_data2.namevalue(row,"MINORNM");	//����
		txt_empnmk_1.value	= gusrnm;																//����	
		gcem_empno_1.text = gcds_data2.namevalue(row,"EMPNO");	 
		txt_deptcd_1.value =gcds_data2.namevalue(row,"DEPTCD");	
		txt_paygrd_1.value =gcds_data2.namevalue(row,"PAYGRD");	

		txt_deptnm_2.value	=  gcds_data2.namevalue(row,"DEPTNM");		//�ҼӸ�
		txt_paygrdnm_2.value = gcds_data2.namevalue(row,"MINORNM");	//����
		txt_empnmk_2.value	= gusrnm;																//����	
		gcem_empno_2.text = gcds_data2.namevalue(row,"EMPNO");	 
		txt_deptcd_2.value =gcds_data2.namevalue(row,"DEPTCD");	
		txt_paygrd_2.value =gcds_data2.namevalue(row,"PAYGRD");	

	} else {
		txt_deptnm_1.value	= "";
		txt_paygrdnm_1.value = "";
		txt_empnmk_1.value	= gusrnm;	

		txt_deptnm_2.value	= "";
		txt_paygrdnm_2.value = "";
		txt_empnmk_2.value	= gusrnm;	
	}
</script>

<!-- <script language="javascript" for="gcds_lazcd" event="onloadCompleted(row,colid)">
		gcds_lazcd.insertrow(1);
		gcds_lazcd.namevalue(1,"MINORCD") = "";
		gcds_lazcd.namevalue(1,"MINORNM") = "��ü";
		gclx_lazcd.index = 0;
</script>
 -->
<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "��ü";
	gclx_deptcd.index = 0;
</script>

<script language="javascript" for="gcds_paygrd" event="onloadCompleted(row,colid)">
	//����[�˻�����]
	gcds_paygrd.insertrow(1);
	gcds_paygrd.namevalue(1,"MINORCD") = "";
	gcds_paygrd.namevalue(1,"MINORNM") = "��ü";
	gclx_paygrd.index = 0;
</script>

<script language="javascript" for="gcds_traffic" event="onloadCompleted(row,colid)">
	//������
	gcds_traffic.insertrow(1);
	gcds_traffic.namevalue(1,"MINORCD") = "";
	gcds_traffic.namevalue(1,"MINORNM") = "";
	gclx_traffic_2.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_lazcd event=OnSelChange()>
	if(gclx_lazcd.bindcolval=="G02"){//��������
		ln_DispChk(1);
		gcds_lazcd_2.Filter();
	}else{
    ln_DispChk(0);
		gcds_lazcd_1.Filter();
	}
	
  if(g_managegb=="Y"){
     ln_User_Setting('Y'); 
	}else if(g_managegb=="N"){
     ln_User_Setting('N'); 
	}

</script>

<script language=JavaScript for=gcds_lazcd_1 event=onFilter(row)>
  if(gclx_lazcd.bindcolval!="G02"){//�ؿ�����
		if(gcds_lazcd_1.namevalue(row,"MINORCD")!="G02") return true;
		else return false;
	}
</script>

<script language=JavaScript for=gcds_lazcd_2 event=onFilter(row)>
  if(gclx_lazcd.bindcolval=="G02"){//��������
		if(gcds_lazcd_2.namevalue(row,"MINORCD")=="G02") return true;
		else return false;
	}
</script>

<script language=JavaScript for=gcem_ovrate_1 event=onKillFocus()>
		gcem_ovwnamt_1.text = Math.round(gcem_ovrate_1.text*gcem_ovdsamt_1.text);
		ln_OV_AutoSum();
</script>
<script language=JavaScript for=gcem_ovdsamt_1 event=onKillFocus()>
		gcem_ovwnamt_1.text = Math.round(gcem_ovrate_1.text*gcem_ovdsamt_1.text);
		ln_OV_AutoSum();
</script>
<script language=JavaScript for=gcem_caramt_1 event=onKillFocus()>
		ln_OV_AutoSum();
</script>
<script language=JavaScript for=gcem_ovfdamt_1 event=onKillFocus()>
		ln_OV_AutoSum();
</script>

<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
	if(row<1)return;
	if(row>=1&&colid!="CHK"){
		ln_OV_AutoSum();
	}
</script>

<!-- �������� -->
<script language=JavaScript for=gcem_otdt_2 event=onKillFocus()>
		ln_Todt_Setting();
</script> 
<script language=JavaScript for=gcem_carfare_2 event=onKillFocus()>
    ln_Wn_AutoSum();
</script>
<script language=JavaScript for= gcem_instamt_2 event=onKillFocus()>
    ln_Wn_AutoSum();
</script>
 <script language=JavaScript for= gclx_infdamt_2 event=OnSelChange()>
    ln_Wn_AutoSum();
</script>
<script language=JavaScript for= gclx_dayamt_2 event=OnSelChange()>
    ln_Wn_AutoSum();
</script>

<script language="javascript"  for=gcgd_disp02 event=OnClick(row,colid)>
	if(row<1)return;
	if(row>=1&&colid!="CHK"){
		ln_Query_Dtl(row);
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data01" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language=JavaScript for=gctr_data01 event=OnFail()>
	alert("Error Code : " + gctr_data01.ErrorCode + "\n" + "Error Message : " + gctr_data01.ErrorMsg + "\n");
</script>
<script language="javascript" for="gctr_data02" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language=JavaScript for=gctr_data02 event=OnFail()>
	alert("Error Code : " + gctr_data02.ErrorCode + "\n" + "Error Message : " + gctr_data02.ErrorMsg + "\n");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" >
				<tr> 
					<td ><img src="../img/h050011_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
					  <img src="../../Common/img/btn/com_b_result.gif"	style="cursor:hand" onclick="ln_Submit()">
						<!-- <img src="../../Common/img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print()"> -->
					  <img src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
				</tr>
       </table>
    </td>
	</tr>
	<!-- �˻����� Start -->
	<tr>
		<td>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="60px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;��������&nbsp;</nobr></td>
					<td class="tab18" style="width:210px;"><nobr>&nbsp;
					<comment id="__NSID__">
						<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
						 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt','Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
							~&nbsp;
						 <comment id="__NSID__"><object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
							 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt','Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
							</nobr>
					</td>
          <td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;���&nbsp;</nobr></td>
          <td class="tab18" style="width:140px;"><nobr>&nbsp;
					<comment id="__NSID__">
						<object id=gcem_empno_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment	    value=0>
											<param name=Border	      value=True>
											<param name=Format	      value="0000000">
											<param name=PromptChar	  value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										~ &nbsp;
          <comment id="__NSID__"><object id=gcem_empno_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="80px"  bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;����</nobr></td>
          <td class="tab18" style="width:160px;" align=center><nobr>&nbsp;
						<input id="txt_empnmk"  type="text"  class="txtbox"  style= "position:relative;left:-8px;top:-2px;width:90px;height:20px;"   onkeydown="if(event.keyCode==13) ln_Query();" ReadOnly=true>
						<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-8px;top:2px;" onclick="ln_Popup('0')" >
					  </nobr>
					</td>
          <td width="80px"  bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;�������</nobr></td>
          <td class="tab18" style="width:140px;" align=center><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gclx_closeyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-8px;top:2px;" >
								<param name=CBData			    value="''^��ü,N^������,I^������,Y^����Ϸ�,J^�����Ϸ�,S^���Ű���Ϸ�,R^ȸ��,B^�ݼ�,H^ȸ��">
								<param name=CBDataColumns	  value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value="MINORCD">
								<param name=Enable          value="true">
							</object></comment><script>__ws__(__NSID__);</script>
					  </nobr>
					</td> 
				</tr>
				<tr>
					<td width="60px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;���±���&nbsp;</nobr></td>
					<td class="tab19" ><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_lazcd  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  
						style="position:relative;left:0px;top:2px;font-size:12px;width:173px;"  >
						<param name=ComboDataID			value="gcds_lazcd">
						<param name=SearchColumn		value="MINORNM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="MINORNM^0^173">
						<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�Ҽ�&nbsp;</nobr></td>
          <td class="tab19" ><nobr>&nbsp;
						<comment id="__NSID__"><OBJECT id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:125px;">
							<param name=ComboDataID			value="gcds_deptcd">
							<param name=SearchColumn		value="DEPTNM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="DEPTNM^0^130">
							<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>			
					<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;����&nbsp;</nobr></td>
          <td class="tab19" colspan=3><nobr>&nbsp;
					 <comment id="__NSID__"><OBJECT id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:-4px;top:2px;font-size:12px;width:135px;">
							<param name=ComboDataID			value="gcds_paygrd">
							<param name=CBDataColumns		value="MINORCD, MINORNM">
							<param name=SearchColumn		value=MINORNM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="MINORNM^0^130">
							<param name=BindColumn			value=MINORCD>
					</OBJECT></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
      </table>
		</td>
	</tr>
	<!-- �˻����� End -->
  <!-- Grid �� �Է�â -->
	<tr>
		<td>
		  <!-- �ؿ����� Start -->
		  <div id="div_disp01" style="display:none;">
			<table>
				<tr>
				  <td>
					  <!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:280px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
										style="position:relative;left:2px;width:637px; height:400px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			value="gcds_data01">
											<param name="indwidth"		value ='0'>
											<param name="borderstyle" value="0">
											<param name="fillarea"		value="true">
											<param name="sortview"		value="left">
											<param name="ColSelect"   value="false">
											<param name="colsizing"   value="true">
											<param name=MultiRowSelect	value=true>
											<param name="editable"    value="true">
											<param name="format"			value="  
											<X> Name='ǰ�Ǻμ�'      HeadAlign=Center HeadBgColor=#B9D4DC
												<FC> Name='����'		   ID=CHK       HeadAlign=Center HeadBgColor=#B9D4DC Width=28	align=center	sort=false SumBgColor=#C3D0DB EditStyle=CheckBox </FC> 
												<FC> Name='��û��'		 ID=APPDT     HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center	sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX' </FC> 
												<FC> Name='���±���'   ID=LAZCD     HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB Edit=None EditStyle=Lookup Data='gcds_lazcd_1:MINORCD:MINORNM'</</FC> 
												<FC> Name='�Ҽ�'       ID=DEPTNM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left    sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<FC> Name='����'       ID=PAYGRDNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left    sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<FC> Name='���'       ID=EMPNO 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center  sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<FC> Name='����'       ID=EMPNMK    HeadAlign=Center HeadBgColor=#B9D4DC Width=55	align=center  sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<C> Name='�������'    ID=TRIPOBJ   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB Edit=None </C> 
												<G> Name='��������'    HeadAlign=Center HeadBgColor=#B9D4DC
													<C> Name='�����'    ID=FRDT 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center  sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX'</C> 
													<C> Name='������'    ID=TODT 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center  sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX'</C> 
													<C> Name='������'    ID=OBJECT    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=left    sort=false SumBgColor=#C3D0DB Edit=None </C> 
												</G>
											</X>
											<X> Name='�ѹ���'        HeadAlign=Center HeadBgColor=#B9D4DC
												<G> Name='�����'      HeadAlign=Center HeadBgColor=#B9D4DC
													<C> Name='ȯ������'	 ID=OVRATEGB  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center sort=false SumBgColor=#C3D0DB SumText='��   ��' Edit=None EditStyle=Lookup Data='gcds_ovrategb:CDCODE:CDNAM'</C> 
													<C> Name='ȯ��'      ID=OVRATE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=right  sort=false SumBgColor=#C3D0DB Edit=None dec=4 </C> 
                          <C> Name='�޷�'      ID=OVDSAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=right  sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
													<C> Name='��ȭ'      ID=OVWNAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=right  sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
													<C> Name='�����'    ID=CARAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=right  sort=false SumBgColor=#C3D0DB </C> 
													<C> Name='�޷�����'  ID=OVETC     HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left   sort=false SumBgColor=#C3D0DB </C> 
												</G>
											</X>
											<C> Name='�������'      ID=CLOSYN    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left   sort=false Edit=None EditStyle=Combo Data='N:������,I:������,Y:����Ϸ�,J:�����Ϸ�,S:���Ű���Ϸ�,R:ȸ��,B:�ݼ�,H:ȸ��'</C> 
											">
									</object></comment><script>__ws__(__NSID__);</script>   
								</td>
							</tr>
						</table>
					</td>
					<td>
						<!--�Է�â -->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:215px;height:402px;border:1 solid #708090;">
						<tr>
							<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
							<td class="tab13"><nobr>
							<comment id="__NSID__">
							<object id=gcem_empno_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:6px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=13>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;
							<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('1')" >
              <input id="txt_empnmk_1" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;"  ReadOnly> 
						</nobr>
					  </td>
            </tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�Ҽ�</nobr></td>
							<td class="tab13"><nobr> 
							  <input id="txt_deptcd_1"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;" ReadOnly>
								<input id="txt_deptnm_1" type="text"   class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
							<td class="tab13"><nobr>
								<input id="txt_paygrd_1"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;" ReadOnly>
								<input id="txt_paygrdnm_1"  type="text" class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���±���</nobr></td>
							<td class="tab13" ><nobr>
							<comment id="__NSID__">
							<object id=gclx_lazcd_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=150 class="txtbox"  style="position:relative;left:-9px;" >
								<param name=ComboDataID			value=gcds_lazcd_1>
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^150">
								<param name=BindColumn			value="MINORCD">
								<!-- <param name=Enable          value=false> -->
							</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="txt_tripobj_1" type="text"   class="txtbox"  style="position:relative;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�����</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_frdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('fr')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_todt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt_1','Text')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="txt_object_1" type="text"   class="txtbox"  style="position:relative;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�հ�</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_sum_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=8>
											<param name=IsComma       value=true>
											<param name=ReadOnly      value="true">
											<param name=ReadOnlyBackColor   value="#CCFFCC">
											<param name=BackColor     value="#CCCCCC">
									 </object></comment><script>__ws__(__NSID__);</script> 
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>ȯ��</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gclx_ovrategb_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=70 class="txtbox"  style="position:relative;left:5px;top:3px" >
									<param name=ComboDataID			value=gcds_ovrategb>
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="CDNAM^0^70">
									<param name=BindColumn			value="CDCODE">
									<!-- <param name=Enable          value=false> -->
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/
							<comment id="__NSID__">
								<object  id=gcem_ovrate_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value=0>
										<param name=Alignment     value=2>
										<param name=Numeric       value="false">
										<param name=Border        value=true>
										<!-- <param name=format        value="0000.0000"> -->
										<param name=MaxLength     value=4>
										<param name=MaxDecimalPlace   value=4>
										<param name=IsComma       value=true>
										<param name=ReadOnly      value="true">
										<param name=ReadOnlyBackColor   value="#CCFFCC">
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script> 
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�޷�/��ȭ</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_ovdsamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/ 
								<comment id="__NSID__">
									<object  id=gcem_ovwnamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=ReadOnly      value="true">
										  <param name=ReadOnlyBackColor   value="#CCFFCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr>
						<!-- <tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>��ȭ</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							
								</nobr></td>
						</tr> -->
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����/�ĺ�</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_caramt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/ 
									 <comment id="__NSID__">
									<object  id=gcem_ovfdamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr>
					<!-- 	<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�ĺ�</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_ovfdamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr> -->
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�޷�����</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_ovetc_1" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="48" onBlur="bytelength(this,this.value,100);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���1</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_remark1_1" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���2</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_remark2_1" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" align=center style="border:0 solid #708090;border-right-width:1px;"><nobr>�������</nobr></td>
							<td style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gclx_closeyn_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:5px;" >
									<param name=CBData			    value="N^������,I^������,Y^����Ϸ�,J^�����Ϸ�,S^���Ű���Ϸ�,R^ȸ��,B^�ݼ�,H^ȸ��">
									<param name=CBDataColumns	  value="MINORCD,MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value="MINORCD">
									<param name=Enable          value="true">
								</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td><nobr></nobr></td>
							<td><nobr></nobr></td>
						</tr>
						</table>
					</td>
        </tr>
			</table>
			</div>
		</td>
	</tr>
	<!-- �ؿ����� End -->
  <tr>
		<td>
			 <!-- �������� Start-->
		  <div id="div_disp02" style="display:block;">
			<table>
				<tr>
				  <td>
					  <!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:260px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
										style="position:relative;left:2px;width:637px; height:217px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			value="gcds_data02">
											<param name="indwidth"		value ='0'>
											<param name="borderstyle" value="0">
											<param name="fillarea"		value="true">
											<param name="sortview"		value="left">
											<param name="colsizing"   value="true">
											<param name=MultiRowSelect	value=true>
											<param name="ViewSummary"	value=1>
											<param name="editable"    value="true">
											<param name="format"			value="  
												<FC> Name='����'		   ID=CHK         HeadAlign=Center HeadBgColor=#B9D4DC Width=28	align=center	sort=false SumBgColor=#C3D0DB EditStyle=CheckBox </FC> 
												<FC> Name='��û��'		 ID=APPDT  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center	sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX' </FC> 
												<FC> Name='�Ҽ�'       ID=DEPTNM 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left    sort=false SumBgColor=#C3D0DB Edit=None</FC> 
												<FC> Name='����'       ID=PAYGRDNM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left    sort=false SumBgColor=#C3D0DB Edit=None SumText='��   ��'</FC> 
												<FC> Name='���'       ID=EMPNO 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center  sort=false SumBgColor=#C3D0DB Edit=None</FC> 
												<FC> Name='����'       ID=EMPNMK	    HeadAlign=Center HeadBgColor=#B9D4DC Width=55	align=left    sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<C> Name='�������'    ID=TRIPOBJ 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB Edit=None </C> 
												<G> Name='��������'    HeadAlign=Center HeadBgColor=#B9D4DC																									 
													<C> Name='�����'    ID=FRDT 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center  sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX'</C> 
													<C> Name='������'    ID=TODT 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center  sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX'</C> 
													<C> Name='������'    ID=OBJECT 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=left    sort=false SumBgColor=#C3D0DB Edit=None</C> 
												</G>
												<C> Name='�ϼ�'        ID=INTRDAY 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=right   sort=false SumBgColor=#C3D0DB Edit=None</C> 
												<C> Name='�ݾװ�'      ID=OVWNAMT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=right   sort=false SumBgColor=#C3D0DB Edit=None SumText=@sum</C> 
												<C> Name='�������'    ID=CLOSYN      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left    sort=false SumBgColor=#C3D0DB Edit=None EditStyle=Combo Data='N:������,I:������,Y:����Ϸ�,J:�����Ϸ�,S:���Ű���Ϸ�,R:ȸ��,B:�ݼ�,H:ȸ��'</C> 
											">
									</object></comment><script>__ws__(__NSID__);</script>   
								</td>
							</tr>
              <tr>
								<td height=25px><nobr>				
										<font style="position:relative;top:0px;left:0px; color=#0000FF">[���Է�]</font>&nbsp;
										<font style="position:relative;top:0px;left:290px; color=#FF0000">�ݾװ�:</font>&nbsp;
										<comment id="__NSID__"> 
										<object  id=gcem_ovwnamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:280px;top:3px">		
												<param name=Text					value="">
												<param name=Alignment     value=2>
												<param name=Border        value=true>
												<param name=MaxLength     value=7>
												<param name=IsComma       value=true>
												<param name=ReadOnly      value="true">
												<param name=ReadOnlyBackColor   value="#CCFFCC">
												<param name=BackColor     value="#CCCCCC">
										 </object></comment><script>__ws__(__NSID__);</script> 
										<img src="../../Common/img/btn/com_b_rowdel.gif"	style="cursor:hand;position:relative;top:3px;left:300px;" onClick="ln_Dtl_Del()">
										<img src="../../Common/img/btn/com_b_rowadd.gif"  style="cursor:hand;position:relative;top:3px;left:300px;" onclick="ln_Dtl_Add()">
										</nobr>
								</td>
							</tr>
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp03  
										style="position:relative;left:2px;width:637px; height:153px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			value="gcds_data03">
											<param name="indwidth"		value ='0'>
											<param name="borderstyle" value="0">
											<param name="fillarea"		value="true">
											<param name="sortview"		value="left">
											<param name="colsizing"   value="true">
											<param name="editable"    value="false">
											<param name="ViewSummary"	value=1>
											<param name=TitleHeight   value="30">
											<param name="format"			value="  
												<C> Name='���'		      ID=EMPNO    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center	sort=false SumBgColor=#C3D0DB Edit=None  </C> 
												<C> Name='����'		      ID=EMPNMK   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left	  sort=false SumBgColor=#C3D0DB Edit=None  </C> 
												<C> Name='����'         ID=OTDT     HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=center  sort=false SumBgColor=#C3D0DB Mask='XXXX/XX/XX' </C> 
												<C> Name='����'         ID=SECTION  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB SumText='��   ��'</C> 
												<C> Name='������'       ID=TRAFFIC  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB EditStyle=Lookup Data='gcds_traffic:MINORCD:MINORNM'</C> 
												<C> Name='�����  '     ID=CARFARE  HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=right   sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
												<C> Name='���ں�'       ID=INSTAMT  HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=right   sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
												<C> Name='�ĺ�'         ID=INFDAMT  HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=right   sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
												<C> Name='�Ϻ�'         ID=INDAYAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=right   sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
											">
									</object></comment><script>__ws__(__NSID__);</script>   
								</td>
							</tr>
						</table>
					</td>
					<td>
						<!--�������� �Է�â -->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:215px;height:400px;border:1 solid #708090;">
						<tr height="25px">
							<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
							<td class="tab13"><nobr>
							<comment id="__NSID__">
							<object id=gcem_empno_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:6px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=13>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;
							<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('2')" >
              <input id="txt_empnmk_2" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;"  ReadOnly> 
						</nobr>
					  </td>
            </tr>
						<tr height="25px">
						  <td width="80px" height="20px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�Ҽ�</nobr></td>
							<td class="tab13" height="20px" ><nobr> 
							  <input id="txt_deptcd_2"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;"  ReadOnly>
								<input id="txt_deptnm_2" type="text"    class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
							<td class="tab13"><nobr>
								<input id="txt_paygrd_2"    type="text" class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;" ReadOnly>
								<input id="txt_paygrdnm_2"  type="text" class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���±���</nobr></td>
							<td class="tab13" ><nobr>
							<comment id="__NSID__">
							<object id=gclx_lazcd_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=150 class="txtbox"  style="position:relative;left:-9px;" >
								<param name=ComboDataID			value=gcds_lazcd_2>
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^150">
								<param name=BindColumn			value="MINORCD">
								<!-- <param name=Enable          value=false> -->
							</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="txt_tripobj_2" type="text"   class="txtbox"  style="position:relative;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="23px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���/����</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__"><nobr>
									<object  id=gcem_frdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script>
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('fr')" style="position:relative;width:20px;left:7px;cursor:hand;">  
									  <comment id="__NSID__">
									<object  id=gcem_todt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:2px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=ReadOnly      value="true">
											      <param name=ReadOnlyBackColor   value="#CCFFCC">
														<param name=ReadOnly      value="true">
									</object></comment><script>__ws__(__NSID__);</script> 
							</nobr></td>
						</tr>
						<!-- <tr>
              <td width="80px" height="23px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_todt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=ReadOnly      value="true">
											      <param name=ReadOnlyBackColor   value="#C0C0C0">
														<param name=ReadOnly      value="true">
									</object></comment><script>__ws__(__NSID__);</script> 
  								<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('to')" style="position:relative;width:20px;left:7px;cursor:hand;">   -->
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="txt_object_2" type="text"   class="txtbox"  style="position:relative;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<!-- <tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�ݾװ�</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__"> 
									<object  id=gcem_ovwnamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=ReadOnly      value="true">
											<param name=ReadOnlyBackColor   value="#C0C0C0">
											<param name=BackColor     value="#CCCCCC">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr> -->
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���1</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_remark1_2" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���2</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_remark2_2" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
						</tr>

						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gclx_closeyn_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:5px;" >
									<param name=CBData			    value="N^������,I^������,Y^����Ϸ�,J^�����Ϸ�,S^���Ű���Ϸ�,R^ȸ��,B^�ݼ�,H^ȸ��">
									<param name=CBDataColumns	  value="MINORCD,MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value="MINORCD">
									<param name=Enable          value="true">
								</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td height=13px colspan=2><nobr><font style="position:relative;top:2px;left:0px; color=#0000FF">[���Է�]</font></nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>����</nobr></td>
							<td class="tab31" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object  id=gcem_otdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
													<param name=Text					value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=Format        value="YYYY/MM/DD">
													<param name=PromptChar    value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
								 </object></comment><script>__ws__(__NSID__);</script> 
								 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('ot')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
						  <td class="tab13" style="text-align:left"><nobr>
								 <input id="txt_section_2" type="text"   class="txtbox"  style="position:relative;top:-1px;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�����/��</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
								<object  id=gcem_carfare_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:2px">		
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Numeric       value="true">
										<param name=Border        value=true>
										<param name=MaxLength     value=7>
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/
								 <comment id="__NSID__">
									<object id=gclx_traffic_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=80 class="txtbox"  style="position:relative;top:2px;left:0px;" >
										<param name=ComboDataID			value=gcds_traffic>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="FALSE">
										<param name=ListExprFormat	value="MINORNM^0^80">
										<param name=BindColumn			value="MINORCD">
										<!-- <param name=Enable          value=false> -->
									</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���ں�</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
								<object  id=gcem_instamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Numeric       value="true">
										<param name=Border        value=true>
										<param name=MaxLength     value=7>
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script>  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" align=center ><nobr>�ĺ�/�Ϻ�</nobr></td>
							<td style="text-align:left"><nobr>
							<comment id="__NSID__">
                <object id=gclx_infdamt_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=70 class="txtbox"  style="position:relative;top:2px;left:5px;" >
										<param name=ComboDataID			value=gcds_infdamt>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="FALSE">
										<param name=ListExprFormat	value="MINORNM^0^50,MEMO^0^120">
										<param name=BindColumn			value="MINORNM">
										<!-- <param name=Enable          value=false> -->
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;/
              <comment id="__NSID__">
								<object id=gclx_dayamt_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=80 class="txtbox"  style="position:relative;top:2px;left:0px;" >
										<param name=ComboDataID			value=gcds_dayamt>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="FALSE">
										<param name=ListExprFormat	value="MINORNM^0^50,MEMO^0^70">
										<param name=BindColumn			value="MINORNM">
										<!-- <param name=Enable          value=false> -->
								</object></comment><script>__ws__(__NSID__);</script>
							  
								<!-- <comment id="__NSID__">
								<object  id=gcem_infdamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Numeric       value="true">
										<param name=Border        value=true>
										<param name=MaxLength     value=7>
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/

								 <comment id="__NSID__">
								<object  id=gcem_dayamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Numeric       value="true">
										<param name=Border        value=true>
										<param name=MaxLength     value=7>
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script>  -->
							</nobr></td>
						</tr>
						</table>
					</td>
        </tr>
			</table>
			</div>
      <!-- �������� End -->
		</td>
  </tr>
	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td>
  </tr>	
</table>

<!-- �ؿ����� -->
<comment id="__NSID__"><object id=gcbn_date01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data01>
	<param name=BindInfo  value="
	<C>Col=EMPNO   	  Ctrl=gcem_empno_1	     Param=text</C>
	<C>Col=LAZCD   	  Ctrl=gclx_lazcd_1			 Param=bindcolval</C>
	<C>Col=FRDT    	  Ctrl=gcem_frdt_1			 Param=text</C>
	<C>Col=TODT    	  Ctrl=gcem_todt_1			 Param=text</C>
	<C>Col=DEPTCD  	  Ctrl=txt_deptcd_1			 Param=value</C>
	<C>Col=PAYGRD  	  Ctrl=txt_paygrd_1			 Param=value</C>
	<C>Col=OBJECT  	  Ctrl=txt_object_1			 Param=value</C>
	<C>Col=TRIPOBJ 	  Ctrl=txt_tripobj_1		 Param=value</C>
	<C>Col=CARAMT  	  Ctrl=gcem_caramt_1		 Param=text</C>
	<C>Col=OVRATEGB	  Ctrl=gclx_ovrategb_1	 Param=bindcolval</C>
	<C>Col=OVRATE  	  Ctrl=gcem_ovrate_1		 Param=text</C>
	<C>Col=OVDSAMT 	  Ctrl=gcem_ovdsamt_1		 Param=text</C>
	<C>Col=OVWNAMT 	  Ctrl=gcem_ovwnamt_1		 Param=text</C>
	<C>Col=OVETC   	  Ctrl=txt_ovetc_1		   Param=value</C>
	<C>Col=CLOSYN  	  Ctrl=gclx_closeyn_1		 Param=bindcolval</C>
	<C>Col=EMPNMK  	  Ctrl=txt_empnmk_1	     Param=value</C>
	<C>Col=DEPTNM   	Ctrl=txt_deptnm_1	     Param=value</C>
	<C>Col=PAYGRDNM   Ctrl=txt_paygrdnm_1	   Param=value</C>
	<C>Col=LAZCDNM    Ctrl=gclx_lazcd_1	     Param=Text</C>
	<C>Col=OVFDAMT    Ctrl=gcem_ovfdamt_1	   Param=Text</C>
	<C>Col=REMARK1    Ctrl=txt_remark1_1	   Param=value</C>
	<C>Col=REMARK2    Ctrl=txt_remark2_1	   Param=value</C>
	">
</object></comment><script>__ws__(__NSID__);</script>


<!-- �������� MST -->
<comment id="__NSID__"><object id=gcbn_date02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data02>
	<param name=BindInfo  value="
	<C>Col=EMPNO   	  Ctrl=gcem_empno_2	     Param=text</C>
	<C>Col=LAZCD   	  Ctrl=gclx_lazcd_2			 Param=bindcolval</C>
	<C>Col=FRDT    	  Ctrl=gcem_frdt_2			 Param=text</C>
	<C>Col=TODT    	  Ctrl=gcem_todt_2			 Param=text</C>
	<C>Col=DEPTCD  	  Ctrl=txt_deptcd_2			 Param=value</C>
	<C>Col=PAYGRD  	  Ctrl=txt_paygrd_2			 Param=value</C>
	<C>Col=OBJECT  	  Ctrl=txt_object_2			 Param=value</C>
	<C>Col=TRIPOBJ 	  Ctrl=txt_tripobj_2		 Param=value</C>
	<C>Col=CARAMT  	  Ctrl=gcem_caramt_2		 Param=text</C>
	<C>Col=OVRATEGB	  Ctrl=gclx_ovrategb_2	 Param=bindcolval</C>
	<C>Col=OVRATE  	  Ctrl=gcem_ovrate_2		 Param=text</C>
	<C>Col=OVDSAMT 	  Ctrl=gcem_ovdsamt_2		 Param=text</C>
	<C>Col=OVWNAMT 	  Ctrl=gcem_ovwnamt_2		 Param=text</C>
	<C>Col=OVETC   	  Ctrl=txt_ovetc_2		   Param=value</C>
	<C>Col=CLOSYN  	  Ctrl=gclx_closeyn_2		 Param=bindcolval</C>
	<C>Col=EMPNMK  	  Ctrl=txt_empnmk_2	     Param=value</C>
	<C>Col=DEPTNM   	Ctrl=txt_deptnm_2	     Param=value</C>
	<C>Col=PAYGRDNM   Ctrl=txt_paygrdnm_2	   Param=value</C>
	<C>Col=LAZCDNM    Ctrl=gclx_lazcd_2	     Param=Text</C>
	<C>Col=REMARK1    Ctrl=txt_remark1_2	   Param=value</C>
	<C>Col=REMARK2    Ctrl=txt_remark2_2	   Param=value</C>
	">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �������� DTL-->
<comment id="__NSID__"><object id=gcbn_date03 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data03>
	<param name=BindInfo  value="
	<C>Col=OTDT  	    Ctrl=gcem_otdt_2			 Param=text</C>
	<C>Col=SECTION  	Ctrl=txt_section_2		 Param=value</C>
	<C>Col=TRAFFIC  	Ctrl=gclx_traffic_2		 Param=bindcolval</C>
	<C>Col=CARFARE  	Ctrl=gcem_carfare_2		 Param=text</C>
	<C>Col=INSTAMT  	Ctrl=gcem_instamt_2		 Param=text</C>
	<C>Col=INFDAMT	  Ctrl=gclx_infdamt_2	   Param=bindcolval</C>
	<C>Col=INDAYAMT  	Ctrl=gclx_dayamt_2		 Param=bindcolval</C>
	">
</object></comment><script>__ws__(__NSID__);</script>
<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
</body>
</html><jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>