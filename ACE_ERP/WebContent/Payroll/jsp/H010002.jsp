<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�⺻�ڵ����
+ ���α׷� ID	: h010002
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: �̼���
+ �� �� �� ��	: h010002_s1, h010002_s2, h010002_s3, h010002_s4
								h010002_t1, h010002_t2, h010002_t3, h010002_t4,
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�⺻�ڵ����</title>


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
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);		//Ʈ���ʱ�ȭ ȣ��
	ln_Luxequery();				//�����ڵ�

	gcem_bundle.text = gcurdate;

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	gcem_zipcd.enabled = false;

	var v_str1 = txt_dong2.value;

  if (ln_Trim(txt_dong2.value) == "") {
		alert("�˻��� ���̸��� �Է��Ͽ� �ֽʽÿ�.");
		txt_dong2.value="";
		txt_dong2.focus();
	} else {
		gcds_zipcode.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s1?v_str1=" + v_str1; 
		gcds_zipcode.Reset();
	}

}

/*-----------------------------------------------------------------------------
 #  �߷��ڵ�  : ��ȸ
-----------------------------------------------------------------------------*/
function ln_Query2(){

		window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		//document.all.LowerFrame.style.visibility="visible";

	if (gcds_sendal.namevalue(gcds_sendal.rowposition,"USEYN") == "T") {
		txt_useyn2.checked		= true;
	} else {
		txt_useyn2.checked		= false;
	}

		gcds_sendal.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s2?v_str1=";
		gcds_sendal.Reset(); 
		txt_ordcd.disabled = true;
}

/*-----------------------------------------------------------------------------
 #  ȸ�����ϰ���  : ��ȸ
-----------------------------------------------------------------------------*/
function ln_Query3(){

		window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		//document.all.LowerFrame.style.visibility="visible";

		var str1 = gcem_bundle.text;
		gcds_holiday.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s3?v_str1="+str1; 
		gcds_holiday.Reset(); 

}

/*-----------------------------------------------------------------------------
 #  Ư�ټ������  : ��ȸ
-----------------------------------------------------------------------------*/
function ln_Query4(){

		window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		//document.all.LowerFrame.style.visibility="visible";

		gcds_special.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s4?v_str1="; 
		gcds_special.Reset(); 

		txt_lazcd.disabled = true;
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	gcds_zipcode.addrow();
	gcem_zipcd.enabled = true;
	gcem_zipcd.focus();

}

/*-----------------------------------------------------------------------------
 #  �߷��ڵ�  : �߰�
-----------------------------------------------------------------------------*/
function ln_Add2(){

	gcds_sendal.addrow();
	gcds_sendal.DataID = "";

	if (gcds_sendal.DataID == "") {txt_useyn2.checked = false;}

	txt_ordcd.disabled = false;
	txt_ordcd.focus();
}

/*-----------------------------------------------------------------------------
 #  ȸ���ް�����  : �߰�
-----------------------------------------------------------------------------*/
function ln_Add3(){

	gcds_holiday.addrow();

	ln_Luxequery();				//�����ڵ�

	tb_HOLDT.enabled = true;
	tb_HOLDT.focus();
}

/*-----------------------------------------------------------------------------
 #  Ư�ټ������  : �߰�
-----------------------------------------------------------------------------*/
function ln_Add4(){

	gcds_special.addrow();

	txt_lazcd.disabled = false;
	txt_lazcd.focus();
}

/******************************************************************************
	Description : ������ȣ - ����
******************************************************************************/
function ln_Save(){

	if (gcds_zipcode.IsUpdated) {	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_zipcode.KeyValue = "h010002_t1(I:USER=gcds_zipcode)";
			gctr_zipcode.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t1";
			gctr_zipcode.post();
			return ln_Query();
		}
	}
}

/*-----------------------------------------------------------------------------
 #  �߷��ڵ�  : ����
-----------------------------------------------------------------------------*/
function ln_Save2(){
	
	if (txt_useyn2.checked == true) {
		gcds_sendal.namevalue(gcds_sendal.rowposition, "USEYN") = "T";
	} else {
		gcds_sendal.namevalue(gcds_sendal.rowposition, "USEYN") = "F";
	}

	if (!ln_Valchk2()) return;

	if (gcds_sendal.IsUpdated) {	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_sendal.KeyValue = "h010002_t2(I:USER=gcds_sendal)";
			gctr_sendal.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t2";
			gctr_sendal.post();
			return ln_Query2();
		}
	}
}

/******************************************************************************
	Description : �Է°� üũ[�߷��ڵ�]
******************************************************************************/
function ln_Valchk2() {

	if (txt_ordcd.value == "") {			
		alert("��Ȯ�� �߷��ڵ带 �Է��� �ֽʽÿ�");
		txt_ordcd.focus();
		return false;
	}

	if (txt_ordnm.value == "") {			
		alert("��Ȯ�� �߷��ڵ���� �Է��� �ֽʽÿ�");
		txt_ordnm.focus();
		return false;
	}

	return true;

}

/*-----------------------------------------------------------------------------
 #  ȸ�����ϰ���  : ����
-----------------------------------------------------------------------------*/
function ln_Save3(){

	if (gcds_holiday.IsUpdated) {	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_holiday.KeyValue = "h010002_t3(I:USER=gcds_holiday)";
			gctr_holiday.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t3";
			gctr_holiday.post();
			return ln_Query3();
		}
	}
}

/*-----------------------------------------------------------------------------
 #  ���� �ϰ�����  : ����
-----------------------------------------------------------------------------*/
function ln_SaveBatch(){

	if (gcds_batch.IsUpdated) {	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_batch.KeyValue = "h010002_t5(I:USER=gcds_batch)";
			gctr_batch.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t5";
			gctr_batch.post();
			return ln_Query3();
		}
	}
}

/******************************************************************************
	Description : �Է°� üũ[���� �ϰ�����]
******************************************************************************/
function ln_ValchkBatch() {
	var ch = gclx_weekday.text;
	for(i=1;i<=gcds_holiday.countrow;i++) {
		if(gcds_holiday.namevalue(i,"HOLDT") == lx_weekday+"0105") {
			alert("������ ����[��/��/��]�� �����մϴ�.");
		}
	}
}


/*-----------------------------------------------------------------------------
 #  ȸ�����ϰ��� : �ϰ�����[��,�� - ������] 
-----------------------------------------------------------------------------*/
function ln_TimeCalculate() {

	///ln_ValchkBatch();

	if (gclx_weekday.text == "") {
		alert("��Ȯ�� ���� �ϰ� ��������� �Է��� �ֽʽÿ�");
		return false;
	}

	var endM				= new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	var months			= new Array("1","2","3","4","5","6","7","8","9","10","11","12");
	var days				= new Array("1","2","3","4","5","6","7");	//1:�Ͽ���
	var days2				= new Array("�Ͽ���","������","ȭ����","������","�����","�ݿ���","�����");
	var type				= new Array("1","2");	//1:������
	
	var lx_weekday	= gclx_weekday.text;
	var row					= gcds_holiday.rowposition;

	var y = lx_weekday;
	var m = 0;
	var d = 1;

	var hlpr = endM[m];
	//alert("end[M]_hlpr : "+ hlpr);
	if (d < endM[m] + 1) {
		if (m == 1 && y % 4 == 0) { hlpr++; }
		var c = new Date(y,m,d);
		var dayOfWeek = c.getDay();
		var mon_1 = ""
		//alert("dayOfWeek : " + c.getDay());
		//alert("���� "+days2[dayOfWeek]);
		//alert("���� "+days[dayOfWeek]);

		var a = c.getDay();	//����ϱ���
		var mon_sun = "";	//�Ͽ��ϱ���

		alert("����� : "+a);
		alert("�Ͽ��� : "+mon_sun);
		
		if (a == "0") {
			mon_1 = 7;	//1[��]
			mon_sun = 1;
		} else if (a == "1") {
			mon_1 = 6;	//1[��]
		} else if (a == "2") {
			mon_1 = 5;	//1[ȭ]
		} else if (a == "3") {
			mon_1 = 4;	//1[��]
		} else if (a == "4") {
			mon_1 = 3;	//1[��]
		} else if (a == "5") {
			mon_1 = 2;	//1[��]
		} else if (a == "6") {
			mon_1 = 1;	//1[��]
		}
	}

		//alert("�� : "+mon_1);
		//alert("�� : "+mon_sun);

	for(i=1;i<=gcds_holiday.countrow;i++) {
		if(gcds_holiday.namevalue(i,"HOLDT") == lx_weekday+"01"+"0"+mon_1) {
			alert("������ ����[��/��/��]�� �����մϴ�.");
			return false;
		}
	}

	

/*---------------------------------------------------------------------------------------
		�� 1�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/
		
    //alert("mon_1::: " + mon_1 + " ::endM[0]:: "+ endM[0] );
		for(i=mon_1; i <= endM[0];i=i+7) {			//1��			
			//alert("1�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {
				//alert("����");
				//alert("HOLDT: "+lx_weekday+"01"+"0"+i+"/"+"WHATDAY: 7"+"HOLNM : ''"+"HOLDIV: 2");
				//alert(mon_1);

				if (mon_sun == 1) {
					//alert("�Ͽ��� - 1��");
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"01"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { 
					
					}else{
						gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"01"+"07";							//��_��/��/��
						gclx_whatday.BindColVal = "7";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
					}
				} else {				
					//2010.02.01 jys ���� 1�� ������ �̻�����..
					if (i<9) {
						gcds_holiday.addrow();	//Row �߰�
						
						tb_HOLDT.text = lx_weekday+"01"+"0"+i;						//��_��/��/��
						gclx_whatday.BindColVal = "7";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

						gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"01"+"0"+Number(i+1);	//��_��/��/��
						gclx_whatday.BindColVal = "1";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
          }else if (i==9){
            gcds_holiday.addrow();	//Row �߰�
					  tb_HOLDT.text = lx_weekday+"01"+"0"+i;						//��_��/��/��
						gclx_whatday.BindColVal = "7";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
						
						gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"01"+"10";	            //��_��/��/��
						gclx_whatday.BindColVal = "1";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}else{
			      gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"01"+i;						  //��_��/��/��
						gclx_whatday.BindColVal = "7";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

						gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"01"+Number(i+1);	    //��_��/��/��
						gclx_whatday.BindColVal = "1";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
					}
				}
					
			}else{

				//alert("�̻�");
				//alert("HOLDT: "+lx_weekday+"01"+i+"/"+"WHATDAY: 7"+"HOLNM : ''"+"HOLDIV: 2");

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"01"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=31) { 
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"02"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"01"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 2�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_2 = i-endM[0];
		//alert("2�� --> "+ mon_2);
		for(i=mon_2; i <= endM[1];i=i+7) {			//2��	
			//alert("2�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"02"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) {
						
						gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"02"+"10";							//��_��/��/��
						gclx_whatday.BindColVal = "1";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
					
					}else{

						gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"02"+"0"+Number(i+1);	//��_��/��/��
						gclx_whatday.BindColVal = "1";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"02"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
				
				if (i>=28) { 
					//alert("1");

						gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"03"+"01";							//��_��/��/��
						gclx_whatday.BindColVal = "1";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				} else {

						gcds_holiday.addrow();	//Row �߰�
						tb_HOLDT.text = lx_weekday+"02"+Number(i+1);			//��_��/��/��
						gclx_whatday.BindColVal = "1";										//��_����
						txt_holnm.value = "";															//��_���ϳ���
						gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
					
			}

			if(((y%4)==0)&&((y%100)!=0)||((y%400)==0)) { 
				//alert("����!!");
				//gcds_holiday.addrow();	//Row �߰�
				endM[1] = 29;
				//tb_HOLDT.text = lx_weekday+"02"+i;							//��_��/��/��
				//gclx_whatday.BindColVal = "7";										//��_����
				//txt_holnm.value = "";															//��_���ϳ���
				//gclx_holdiv.BindColVal = "2";											//��_���� '2:������'  
			}

		}
	}

/*---------------------------------------------------------------------------------------
		�� 3�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_3 = i-endM[1];
		for(i=mon_3; i <= endM[2];i=i+7) {			//3��	
			//alert("3�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�	
					tb_HOLDT.text = lx_weekday+"03"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"03"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
					
					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"03"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"04"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"03"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
				}
			}
		}

/*---------------------------------------------------------------------------------------
		�� 4�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_4 = i-endM[2];
		for(i=mon_4; i <= endM[3];i=i+7) {			//4��	
			//alert("4�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�				
					tb_HOLDT.text = lx_weekday+"04"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"04"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"04"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=30) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"05"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"04"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 5�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_5 = i-endM[3];
		for(i=mon_5; i <= endM[4];i=i+7) {			//5��	
			//alert("5�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"05"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"05"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"05"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"06"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"05"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 6�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_6 = i-endM[4];
		for(i=mon_6; i <= endM[5];i=i+7) {			//6��	
			//alert("6�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"06"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"06"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"06"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=30) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"07"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"06"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 7�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_7 = i-endM[5];
		for(i=mon_7; i <= endM[6];i=i+7) {			//7��	
			//alert("7�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"07"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"07"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"07"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"08"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"07"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 8�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_8 = i-endM[6];
		for(i=mon_8; i <= endM[7];i=i+7) {			//8��	
			//alert("8�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"08"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"08"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"08"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"09"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"08"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 9�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_9 = i-endM[7];
		for(i=mon_9; i <= endM[8];i=i+7) {			//9��	
			//alert("9�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"09"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"09"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"09"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=30) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"10"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"09"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 10�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_10 = i-endM[8];
		for(i=mon_10; i <= endM[9];i=i+7) {			//10��	
			//alert("10�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�				
					tb_HOLDT.text = lx_weekday+"10"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"10"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"10"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"11"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"10"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 11�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_11 = i-endM[9];
		for(i=mon_11; i <= endM[10];i=i+7) {			//11��	
			//alert("11�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�				
					tb_HOLDT.text = lx_weekday+"11"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"11"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"11"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=30) { 
				
					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"12"+"01";							//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"11"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		�� 12�� ������[��,��] ����	
---------------------------------------------------------------------------------------*/

		var mon_12 = i-endM[10];
		for(i=mon_12; i <= endM[11];i=i+7) {			//12��	
			//alert("11�� " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row �߰�				
					tb_HOLDT.text = lx_weekday+"12"+"0"+i;						//��_��/��/��
					gclx_whatday.BindColVal = "7";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row �߰�
					tb_HOLDT.text = lx_weekday+"12"+"0"+Number(i+1);	//��_��/��/��
					gclx_whatday.BindColVal = "1";										//��_����
					txt_holnm.value = "";															//��_���ϳ���
					gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
					
					}
					
			}else{

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"12"+i;								//��_��/��/��
				gclx_whatday.BindColVal = "7";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'

				if (i>=31) { 
				
					//gcds_holiday.addrow();	//Row �߰�
					//tb_HOLDT.text = lx_weekday+"01"+"01";							//��_��/��/��
					//gclx_whatday.BindColVal = "1";										//��_����
					//txt_holnm.value = "";															//��_���ϳ���
					//gclx_holdiv.BindColVal = "2";											//��_���� '2:������' 
				
				}else {

				gcds_holiday.addrow();	//Row �߰�
				tb_HOLDT.text = lx_weekday+"12"+Number(i+1);			//��_��/��/��
				gclx_whatday.BindColVal = "1";										//��_����
				txt_holnm.value = "";															//��_���ϳ���
				gclx_holdiv.BindColVal = "2";											//��_���� '2:������'
			}
		}
	}
	

	ln_Save3();

}

function setY() {
	var y = new Date().getYear();
	if (y < 2000) y += 1900;
	document.ymdForm1.year.value = y;
}	

/*-----------------------------------------------------------------------------
 #  Ư�ټ������  : ����
-----------------------------------------------------------------------------*/
function ln_Save4(){

	if (gcds_special.IsUpdated) {	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_special.KeyValue = "h010002_t4(I:USER=gcds_special)";
			gctr_special.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t4";
			gctr_special.post();
			return ln_Query4();
		}
	}
}

/******************************************************************************
	Description : ������ȣ - ����
******************************************************************************/
function ln_Delete(){

if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_zipcode.deleterow(gcds_zipcode.rowposition);
		gctr_zipcode.KeyValue = "h010002_t1(I:USER=gcds_zipcode)";
		gctr_zipcode.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t1";
		gctr_zipcode.post();
		return ln_Query();
	}else gcds_zipcode.undo(gcds_zipcode.rowposition);		

}

/*-----------------------------------------------------------------------------
 #  �߷��ڵ�  : ����
-----------------------------------------------------------------------------*/
function ln_Delete2(){

	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_sendal.UserStatus(gcds_sendal.rowposition)=2;
		gcds_sendal.deleterow(gcds_sendal.rowposition);
		gctr_sendal.KeyValue = "h010002_t2(I:USER=gcds_sendal)";
		gctr_sendal.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t2";
		gctr_sendal.post();
		return ln_Query2();
	}else gcds_sendal.undo(gcds_sendal.rowposition);		
}

/*-----------------------------------------------------------------------------
 #  ȸ�����ϰ���  : ����
-----------------------------------------------------------------------------*/
function ln_Delete3(){

	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
			gcds_holiday.deleterow(gcds_holiday.rowposition);
			gctr_holiday.KeyValue = "h010002_t3(I:USER=gcds_holiday)";
			gctr_holiday.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t3";
			gctr_holiday.post();
			return ln_Query3();
		}else gcds_holiday.undo(gcds_holiday.rowposition);		
	}

/*-----------------------------------------------------------------------------
 #  ���� �ϰ�����
-----------------------------------------------------------------------------*/
function ln_DelBatch(){

	var str1 = gclx_weekday.text;

	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
			gcds_holiday.deleterow(gcds_holiday.rowposition);
			gctr_holiday.KeyValue = "h010002_t5(I:USER=gcds_holiday)";
			gctr_holiday.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t5?v_str1="+str1;
			gctr_holiday.post();
			return ln_Query3();
		}else gcds_holiday.undo(gcds_holiday.rowposition);		

}

/*-----------------------------------------------------------------------------
 #  Ư�ټ������  : ����
-----------------------------------------------------------------------------*/
function ln_Delete4(){

	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
			gcds_special.deleterow(gcds_special.rowposition);
			gctr_special.KeyValue = "h010002_t4(I:USER=gcds_special)";
			gctr_special.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t4";
			gctr_special.post();
			return ln_Query4();
		}else gcds_special.undo(gcds_special.rowposition);
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
	Description : �� ����
******************************************************************************/
function ln_Tabset(index){

	var div_cm=new Array("div_zipcode","div_sendal","div_holiday","div_special");

	for(var i=0;i<=3;i++)  {
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		} else {
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************************
	Descrition : CheckBox
******************************************************************************************/
function ln_Chkbox(e,a){
	var row = gcds_sendal.rowposition;

	if (e.checked) gcds_sendal.namevalue(row,a) = "T";
	else gcds_sendal.namevalue(row,a) = "F";
}


/******************************************************************************
	Description : �����ڵ� ��ȸ
******************************************************************************/
function ln_Luxequery(){

	//ȸ�����ϰ��� - ����
	gcds_whatday.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1151"; 
	gcds_whatday.Reset();

	//ȸ�����ϰ��� - ���ϱ���
	gcds_holdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1150"; 
	gcds_holdiv.Reset();

}

/******************************************************************************
	Description : ��������
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_zipcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!--������ȣ-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_sendal" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!--�߷��ڵ�-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_holiday" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!--ȸ������-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_whatday" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--ȸ������ - ����-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_holdiv" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--ȸ������ - ���ϱ���-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_batch" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--���� �ϰ�����-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_special" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!--Ư�ټ���-->
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_zipcode classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--������ȣ-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_sendal classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�߷��ڵ�-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_holiday classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--ȸ������-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_batch classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--���� �ϰ�����-->
		<PARAM NAME="KeyValue" VALUE="h010002_t5(I:USER=gcds_batch)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_special classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--Ư�ټ���-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gs_tab event=OnSelChanged(index)>
	ln_Tabset((index-1));
</script>

<script language="javascript" for="gcgd_sendal" event="onClick(row,colid)">
	if (gcds_sendal.namevalue(gcds_sendal.rowposition,"USEYN") == 'T') {
		txt_useyn2.checked = true;
	} else {
		txt_useyn2.checked = false;
	}
</script>

<script language=JavaScript  for=gcds_zipcode event=OnLoadCompleted(rowcount)>	//������ȣ �� �˻� �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search1.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<script language=JavaScript  for=gcds_sendal event=OnLoadCompleted(rowcount)>	//�߷��ڵ� �� �˻� �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search2.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>



<script language=JavaScript  for=gcds_holiday event=OnLoadCompleted(rowcount)>	//ȸ������ �� �˻� �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search3.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<script language=JavaScript  for=gcds_special event=OnLoadCompleted(rowcount)>	//���¼��� �� �˻� �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search4.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_zipcode" event=OnLoadStarted()>	//������ȣ
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_zipcode" event="onsuccess()">//������ȣ
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_zipcode" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_sendal" event="OnSuccess()">//�߷��ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_sendal" event="OnFail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="JavaScript" for="gctr_holiday" event=OnSuccess()>//ȸ������
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="JavaScript" for="gctr_holiday" event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�999.");
</script>

<script language="javascript" for="gctr_special" event="onsuccess()">//Ư�ټ���
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_special" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>



</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h010002_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2 ALING=LEFT>

      <table width="0" cellpadding="1" cellspacing="1" border="0">
				<tr> 
					<td width="0" align=RIGHT><NOBR>
					  <comment id="__NSID__"><OBJECT id=gs_tab classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;cursor:hand;">
              <PARAM NAME="BackColor" VALUE="#cccccc">
              <PARAM NAME="titleHeight" VALUE="20px">
              <PARAM NAME="DisableBackColor" VALUE="#eeeeee">
              <PARAM NAME="Format" VALUE="
							<T>divid=div_zipcode  title=������ȣ</T>                                  
              <T>divid=div_sendal		title=�߷��ڵ�</T>
              <T>divid=div_holiday  title=ȸ������</T>
              <T>divid=div_special  title=Ư�ټ���</T>                                  
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
        </tr>
      </table>
    
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2><div id="div_zipcode" style="cursor:hand;">
			<table width="875" cellpadding="1" cellspacing="0" border="0">
				<tr><td height=10></td></tr>
				<tr>
					<td colspan=8 align=center>

						<table width="846" cellpadding="1" cellspacing="1" border="0" style='width:846px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							
							<tr><!--������ȣ-->
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; �� �� ��&nbsp;&nbsp;</nobr></td>
								<td width="0" align=LEFT ><nobr>
									<INPUT TYPE=TEXT ID=txt_dong2 class="txtbox"  width=70 height=18 style="position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,60);" onkeydown="if(event.keyCode==13) ln_Query();"></nobr></td>
                <td width=100%>&nbsp;</td>
                <td><nobr>      
									<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-69px" onClick="ln_Delete()">
									<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-69px" onClick="ln_Add()">
									<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-69px" onClick="ln_Save()">
									<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-69px" onClick="ln_Query()"> 
									</nobr>
								</td>
              </tr>
            </table>
                </td>
              </tr>
              <tr>
								<td ALIGN=CENTER>

							<table width="847" cellpadding="1" cellspacing="1" border="0">
								<tr> 
									<td style="width:847" ALIGN=LEFT VALIGN=TOP>
										<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_zipcode  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
											<PARAM NAME="DataID"        VALUE="gcds_zipcode">
											<PARAM NAME="Editable"			VALUE="false">
											<PARAM NAME="BorderStyle"		VALUE="0">
											<param NAME="Fillarea"      VALUE="true">
											<PARAM NAME="Format"        VALUE="  
												<C> Name='����'			ID=ZIPSEQ   HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER show=false</C> 
                        <C> Name='������ȣ' ID=ZIPCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER Mask='XXX-XXX'</C> 
                        <C> Name='�õ�'			ID=SIDO			HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER</C> 
                        <C> Name='�ñ���'		ID=GUGUN		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=CENTER</C> 
                        <C> Name='���鵿'		ID=DONG			HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=LEFT</C> 
                        <C> Name='����'			ID=BUNJI		HeadAlign=Center HeadBgColor=#B9D4DC Width=95		align=CENTER</C> 
                        ">
										</OBJECT></comment><script>__ws__(__NSID__);</script>
                  </td>
                  <td>

									<table border= "0" class=itemdisp cellpadding=0 cellspacing=1  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
                    <tr>											
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;������ȣ</td>
                      <td style="border:0 solid #708090;border-bottom-width:1px;">&nbsp;
												<comment id="__NSID__"><object id=gcem_zipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:60px; height:20px; font-family:����; font-size:9pt;z-index:2; "class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
													<PARAM NAME="DataID"			VALUE="gcds_zipcode">
													<param name=Text          value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=ClipMode      value=true>
													<param name=Numeric       value=false>
													<param name=Format        value="000-000">
													<param name=MaxLength     value=6>
													<param name=PromptChar    value="_">
													<param name=IsComma       value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
                    </tr>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_sido" name="nwrlgn"  class="txtbox" type="text" style="width:260px;" maxlength="6" onBlur="bytelength(this,this.value,6);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;�� �� ��</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_gugun" name="nwrlgn"  class="txtbox" type="text" style="width:260px;" maxlength="20" onBlur="bytelength(this,this.value,20);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;�� �� ��</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_dong" name="nwrlgn"  class="txtbox" type="text" style="width:260px;" maxlength="60" onBlur="bytelength(this,this.value,60);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_bunji" name="nwrlgn"  class="txtbox" type="text" style="width:260px;" maxlength="30" onBlur="bytelength(this,this.value,30);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
                      </td>
                    </tr>
									</table>
											</TD>
										</tr>
									</table>
								</td>
               </tr>
             </table>
						 <table border=0 cellpadding=1 cellspacing=1 width=875>
								<tr><td height=10></td></tr>
							 <tr>
							  <td height="24">��ȸ�Ǽ� : <label id="lbl_search1"></label></td>
							 </tr>
						</table>
						 </div>

<div id="div_sendal" style="display:none">
	<table width="875" cellpadding="1" cellspacing="1" border="0">
		<tr><td height=13></td></tr>
		<tr>
			<td colspan=8 align=center>
			<table width="847" cellpadding="1" cellspacing="1" border="0">
				<tr> 
					<td width="0" align=RIGHT ><nobr ><!--�߷��ڵ�--></nobr></td>
					<td width=100%>&nbsp;</td>
					<td><nobr>      
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Delete2()">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Add2()">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Save2()">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Query2()"> 
						</nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr><td align=center valign=middle>
	<table width="847" cellpadding="1" cellspacing="1" border="0">
		<tr> 
			<td style="width:847" align=center>
				<comment id="__NSID__"><OBJECT id=gcgd_sendal classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_sendal">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param NAME="Fillarea"		VALUE="true">
							<param name="sortview"				VALUE=left>
							<PARAM NAME="Format"			VALUE="
            <C> Name='�߷��ڵ�' ID=ORDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER	Edit=none sort = true</C>
            <C> Name='�߷ɸ�Ī' ID=ORDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=146	align=LEFT		Edit=none sort = true</C>
            <C> Name='�����׸�' ID=CHKITEM  HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=CENTER  Edit=none</C>
            <C> Name='�߷ɱ���' ID=ORDDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER  Edit=none</C>
						<C> Name='�������'	ID=USEYN  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center  EditStyle=combo  Data='T:���,F:�̻��' Pointer=Hand	</C>
            ">
					</OBJECT></comment><script>__ws__(__NSID__);</script>
        </td>
        <TD align=left>
                
					<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
            <tr>
							<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;�߷��ڵ�</td>                        
              <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
								<input id="txt_ordcd" name="txt_ordcd"  class="txtbox" type="text" style="width:260px;" maxlength="2" onBlur="bytelength(this,this.value,2);">&nbsp;</nobr>
							</td>
            </tr>
            <tr>
              <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;�߷��ڵ��</td>   
              <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
								<input id="txt_ordnm" name="txt_ordnm"  class="txtbox" type="text" style="width:260px;" maxlength="30" onBlur="bytelength(this,this.value,30);">&nbsp;</nobr>
							</td>
            </tr>
            <tr>
              <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;�����׸�</td>
              <td style="border:0 solid #708090;border-bottom-width:1px;">
								<nobr>&nbsp;
								<input id="txt_chkitem" name="txt_chkitem"  class="txtbox" type="text"  style="width:260px;" maxlength="8" onBlur="bytelength(this,this.value,8);">&nbsp;</nobr>
								</td>
            </tr>
            <tr>
              <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;�߷ɱ���</td>                        
              <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
								<input id="txt_orddiv" name="txt_orddiv" class="txtbox"  type="text"  style="width:260px;" maxlength="1" onBlur="bytelength(this,this.value,1);">&nbsp;</nobr>
							</td>
            </tr>
						<tr>
              <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;�������</td>                        
              <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
								<input name="txt_useyn2" type="checkbox"  style="width:15px;" onclick="ln_Chkbox(this,'USEYN')">&nbsp;</nobr>
							</td>
            </tr>
            <tr>
              <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;</td>
            </tr>
					</table>
        </TD>
			</tr>
		</table>
  </td>
 </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	 <tr>
		<td height="24">��ȸ�Ǽ� : <label id="lbl_search2"></label></td>
	 </tr>
</table>
</div>

<div id="div_holiday" style="display:none">
  <table width="875" cellpadding="1" cellspacing="0" border="0">
		<tr><td height=13></td></tr>
    <tr> 
			<td colspan=8 align=center>

				<table width="846" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;width:846px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; ���� �⵵&nbsp;&nbsp;</nobr></td>
						<td width="0" align=LEFT ><nobr>
							<comment id="__NSID__"><object id=gcem_bundle classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;position:relative;left:5px;top:2px" class="txtbox" >
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Format        value="YYYY">
								<param name=ClipMode      value=true>
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
							&nbsp;</td>
					
						<td width="0" align=RIGHT ><nobr ><!--ȸ������--></nobr></td>
            <td width=100%>&nbsp;</td>
            <td><nobr>
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-69px;right:2px;left:0" onClick="ln_Delete3()">
							<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-69px;right:2px;left:0" onClick="ln_Add3()">
							<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-69px;right:2px;left:0" onClick="ln_Save3()">
							<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-69px;right:2px;left:0" onClick="ln_Query3()">
							</nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td align=center valign=middle>
      <table width="847" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;'>
        <tr> 
          <td style="width:847" align=center>
            <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_holiday  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"        VALUE="gcds_holiday">
              <PARAM NAME="Editable"			VALUE="false">
              <PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM name="Fillarea"      VALUE="true">
              <PARAM NAME="Format"        VALUE="  
                <C> Name='��������'	ID=HOLDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=CENTER	Mask='XXXX/XX/XX'</C> 
                <C> Name='����'			ID=WHATDAY	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=CENTER	EditStyle=Lookup Data='gcds_whatday:MINORCD:MINORNM'</C> 
                <C> Name='���ϳ���'	ID=HOLNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=LEFT	</C> 
                <C> Name='����'			ID=HOLDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=78		align=CENTER	EditStyle=Lookup Data='gcds_holdiv:MINORCD:MINORNM'</C> 
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
          </td>
          <TD align=left>
            
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#B9D4DC" align=center class="txtbox" >&nbsp;���� �ϰ�����</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px;" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gclx_weekday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:30px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY">
										<param name=MaxLength     value=8>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
									
									<img src="../../Common/img/btn/com_b_total.gif"		style="cursor:hand;position:relative;top:2px;right:2px;left:0" onClick="ln_TimeCalculate()">&nbsp;
									<!-- <img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;top:2px;right:2px;left:-7" onClick="ln_DelBatch()"> -->
									</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;��/��/��</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=tb_HOLDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
										<PARAM NAME="DataID"			VALUE="gcds_holiday">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM/DD">
										<param name=MaxLength     value=8>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
									
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('tb_HOLDT', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                <td style="border:0 solid #708090;border-bottom-width:1px;">&nbsp;
									<comment id="__NSID__"><object id=gclx_whatday classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;left:5px" class="txtbox" >
										<param name=ComboDataID			value=gcds_whatday>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="MINORCD">
										<param name=ListExprFormat	value="MINORNM^0^95">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>
                </td>
              </tr>
              <tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;���ϳ���</td>
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<input id="txt_holnm" name="txt_holnm" type="text"   class="txtbox" style="width:260px;position:relative;left:5px;" maxlength="20" onBlur="bytelength(this,this.value,20);" >&nbsp;</nobr></td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;���ϱ���</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;&nbsp;</nobr>
									<comment id="__NSID__"><object id=gclx_holdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 class="txtbox" >
										<param name=ComboDataID			value=gcds_holdiv>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="MINORCD">
										<param name=ListExprFormat	value="MINORNM^0^116">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              </tr>
              <tr>
                <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;
                </td>
              </tr>
            </table>
          </TD>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	 <tr>
		<td height="24">��ȸ�Ǽ� : <label id="lbl_search3"></label></td>
	 </tr>
</table>
</div>

<div id="div_special" style="display:none">
  <table width="875" cellpadding="1" cellspacing="0" border="0">
		<tr><td height=13></td></tr>
    <tr> 
			<td colspan=8 align=center>

				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td width="0" align=RIGHT ><nobr ><!--Ư�ټ���--></nobr></td>
            <td width=100%>&nbsp;</td>
            <td><nobr>      
							<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Delete4()">
							<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Add4()">
							<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Save4()">
							<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Query4()">  
							</nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td align=center valign=middle>
      
			<table width="847" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td style="width:847" align=center>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_special  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"          VALUE="gcds_special">
              <PARAM NAME="Editable"				VALUE="false">
              <PARAM NAME="BorderStyle"			VALUE="0">
							<PARAM name="Fillarea"				VALUE="true">
              <PARAM NAME="Format"          VALUE="  
                <C> Name='�����ڵ�' ID=LAZCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER</C> 
                <C> Name='���¸�Ī' ID=LAZFEENM   HeadAlign=Center HeadBgColor=#B9D4DC Width=127	align=LEFT</C> 
                <C> Name='���籸��' ID=ALWCON			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER value={decode(ALWCON,1,'�ñ�',2,'�ϱ�',3,'ȸ��',4,'����')}</C> 
                <C> Name='�ݾ�'			ID=AMT				HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=RIGHT</C>
								<C> Name='���'			ID=MEMO				HeadAlign=Center HeadBgColor=#B9D4DC Width=119	align=CENTER</C>
                ">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
          </td>
          <TD align=left>
                
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;�����ڵ�</td>
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<input id="txt_lazcd" name="txt_lazcd"  class="txtbox" type="text" style="width:260px;" maxlength="4" onBlur="bytelength(this,this.value,4);">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;���¸�Ī</td>                        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<input id="txt_lazfeenm" name="txt_lazfeenm"  class="txtbox" type="text" style="width:260px;" maxlength="20" onBlur="bytelength(this,this.value,20);">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;���籸��</td>
                <td style="border:0 solid #708090;border-bottom-width:1px;">&nbsp;
									<select id=sel_alwcon  style="width:100px;" class="txtbox" >
										<option value></option>
										<option value=1>�ñ�</option>
										<option value=2>�ϱ�</option>
										<option value=3>ȸ��</option>
										<option value=4>����</option>
									</select>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:260px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>        
                <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:5px;" class="txtbox" >
										<PARAM name="DataID"			value="gcds_special">								
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										 <param name=IsComma			value=true>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
									<!-- <input id="gcem_amt" name="gcem_amt" type="text" style="width:157px;" maxlength=16 > -->&nbsp;</nobr>
								</td>
              </tr>
							<tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_memo" name="txt_memo"  class="txtbox" type="text" style="width:260px;" maxlength="20" onBlur="bytelength(this,this.value,20);">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;</td>
              </tr>
            </table>
								</TD>
							</tr>
						</table>
					</td>
				</tr>
			</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	<tr>
		<td height="24">��ȸ�Ǽ� : <label id="lbl_search4"></label></td>
	</tr>
</table></div>
    <td>
	</tr>
</table>

<comment id="__NSID__"><object id=gcbn_zipcode classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 disabled> 
    <param name=DataID    value=gcds_zipcode><!--������ȣ-->
    <param name=BindInfo  value='
				
        <C>Col=ZIPCD			Ctrl=gcem_zipcd						Param=text</C>
        <C>Col=SIDO				Ctrl=txt_sido							Param=value</C>
        <C>Col=GUGUN			Ctrl=txt_gugun						Param=value</C>
        <C>Col=DONG				Ctrl=txt_dong							Param=value</C>
				<C>Col=BUNJI			Ctrl=txt_bunji						Param=value</C>
    '>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcbn_sendal classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 disabled> 
    <param name=DataID    value=gcds_sendal><!--�߷��ڵ�-->
    <param name=BindInfo  value='
        <C>Col=ORDCD			Ctrl=txt_ordcd						Param=value</C>
        <C>Col=ORDNM			Ctrl=txt_ordnm						Param=value</C>
        <C>Col=CHKITEM		Ctrl=txt_chkitem					Param=value</C>
        <C>Col=ORDDIV			Ctrl=txt_orddiv						Param=value</C>
				<C>Col=USEYN			Ctrl=txt_useyn2						Param=value</C>
    '>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcbn_holiday classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 disabled> 
    <param name=DataID    value=gcds_holiday><!--ȸ������-->
    <param name=BindInfo  value='

        <C>Col=HOLDT			Ctrl=tb_HOLDT 						Param=text</C>
        <C>Col=WHATDAY		Ctrl=gclx_whatday					Param=BindColVal</C>
        <C>Col=HOLNM			Ctrl=txt_holnm						Param=value</C>
        <C>Col=HOLDIV			Ctrl=gclx_holdiv					Param=BindColVal</C>
    '>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcbn_special classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 disabled> 
    <param name=DataID    value=gcds_special><!--Ư�ټ���-->
    <param name=BindInfo  value='
        <C>Col=LAZCD			Ctrl=txt_lazcd						Param=value</C>
        <C>Col=LAZFEENM		Ctrl=txt_lazfeenm					Param=value</C>
        <C>Col=ALWCON			Ctrl=sel_alwcon						Param=value</C>
        <C>Col=AMT				Ctrl=gcem_amt							Param=text</C>
				<C>Col=MEMO				Ctrl=txt_memo							Param=value</C>
    '>
</object></comment><script>__ws__(__NSID__);</script>

<div class=page id="out_line" style="position:absolute; left:4; top:68; width:875; height:438;z-index:-1;">&nbsp;</div>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>