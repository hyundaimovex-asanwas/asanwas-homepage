<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-----------------------------------------------------------------------------
+ �� �� �� ��	:	�����������-�������곻����ȸ
+ ���α׷� ID	: P030025.HTML
+ �� �� �� ��	: ��ȸ,���
+ �� �� �� ��	: 
+ �� �� �� ��	: p030025_s1 (P030002.HTML�� �������) 
------------------------------------------------------------------------------
+ �� �� �� ��  :	 
+ ��   ��  ��  :  
+ �� �� �� ��  :  
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>


<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>

<title>�������곻����ȸ</title>

<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substr(5,2);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = parseInt(gcurdate.substring(0,4))+1;
var gs_level;
var gs_treecd;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_curdt.text = gcurdate.substring(0,4);	//�ͼӳ⵵
	gcem_curdt.text = "2010" ;//gcurdate.substring(0,4);	//�ͼӳ⵵

	ln_Before();	//����ȸ

	gcds_manager.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s2?v_str1=2060&v_str2="+gusrid;
	gcds_manager.Reset();	

	if(gcds_manager.countrow>0){ //������ ����
    txt_empno1.value="";
		txt_empnmk1.value = "";
	}else{
		txt_empno1.value = gusrid;
		txt_empnmk1.value = gusrnm;
    txt_empnmk1.readOnly = "true";
	}
}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){

	if (gcem_curdt.text=="") {
		alert("�ͼӳ⵵�� �ʼ��׸��Դϴ�.");
		gcem_curdt.setFocus();
	}
	
  if(gcds_manager.countrow>0){ //������ ����
	
	}else{
	  /*
	  if(txt_empno1.value !='2040046'){
			alert("�������� ��ȸ�Ⱓ�� �ƴմϴ�.");
			return false;
		}
		*/
		//���������
		if (gusrid=="2110001") txt_empno1.value="3080035";  
		if (gusrid=="2110002") txt_empno1.value="3080141";
		if (gusrid=="2110003") txt_empno1.value="3080087";
		if (gusrid=="2100004") txt_empno1.value="3080114";
		if (gusrid=="2110005") txt_empno1.value="3080143";
		if (gusrid=="2110006") txt_empno1.value="3080086";
	}
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030025_s1?v_str1="+gcem_curdt.text
									  + "&v_str2=" + gclx_deptcd.bindcolval
									  + "&v_str3=" + fn_trim(txt_empnmk1.value)
									  + "&v_str4=" + gs_level
									  + "&v_str5=" + gs_treecd
										+ "&v_str6=" + gcem_curdt.text
										+ "&v_str7=" + txt_empno1.value;
	//prompt('',gcds_data.DataID);
	gcds_data.Reset(); 

}


/******************************************************************************
	Description : �������� ��¹�...
******************************************************************************/
function ln_Query02(t,p) {

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s6?v_str1=" + gcem_curdt.text+"12"
									  + "&v_str2=" + gclx_deptcd.bindcolval
									  + "&v_str3=" + t
									  + "&v_str4=" + p;

	//prompt('',gcds_data2.DataID);

	gcds_data2.Reset(); 

}

/******************************************************************************
	Description : �������� ��¹�...
******************************************************************************/
function ln_Query03(p) {

	gcds_data12.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s7?v_str1=" + gcem_curdt.text
									  + "&v_str2=" + p;

	//prompt('',gcds_data12.DataID);

	gcds_data12.Reset(); 

}


/******************************************************************************
	Description : ����ȸ ����
******************************************************************************/
function ln_Before(){

	//�Ҽ��ڵ�
	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";
	gcds_dept1.Reset();

	//�Ҽ��ڵ�2
	gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";
	gcds_dept2.Reset();

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}


/******************************************************************************
	Description : ��� - ������  
******************************************************************************/
function ln_Print(){
  if (gcds_data.countrow<1) {
		alert("����Ͻ� ������ �����ϴ�");
		return;
	}else{
	  //�������� ������ üũ
		if(gcds_manager.countrow>0){ 	
			alert("��½� ������ �����,������ ������,�ҵ��� ������ ������ ���� ��µ˴ϴ�.");
		}else{
			gcds_empno.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s5?v_str1=" + gcem_curdt.text+"12";
			//prompt('',gcds_empno.DataID);
			gcds_empno.Reset(); 
		}

		gcds_print.ClearAll();
		gcds_print1.ClearAll();
		gcds_print22.ClearAll();

		var ls_temp = "";
		var ls_temp1 = "";
		var ls_temp12 = "";

		for( var i=1;i<=gcds_data.countcolumn;i++) {
			ls_temp+=gcds_data.columnid(i)+":";
			if(gcds_data.ColumnType(i)==1)			ls_temp+="STRING";
			else if(gcds_data.ColumnType(i)==2)	ls_temp+="INTEGER";
			else if(gcds_data.ColumnType(i)==3)	ls_temp+="DECIMAL";
			else if(gcds_data.ColumnType(i)==4)	ls_temp+="DATE";
			else if(gcds_data.ColumnType(i)==5)	ls_temp+="URL";
			if(gcds_data.countcolumn != i) ls_temp+=",";
		 }

			ls_temp+=",HTITLE:STRING,CURDT:STRING,CURDT2:STRING";
		
			gcds_print.SetDataHeader(ls_temp);



			//3PAGE�κ��� �����ͼ� ��� ���� , �������� �κи� ��ȸ�� ��ȸ�Ͽ� ������ ������ . 

			ls_temp1 ="EMPNO:STRING,APPDT:STRING,RELAT1:STRING,FAMNM1:STRING,RESINO1:STRING,RESINO:STRING,"
						+ "REF1:STRING,REF2:STRING,REF3:STRING,REF4:STRING,REF5:STRING,REF6:STRING,REF7:STRING,REF8:STRING,JUMIN:STRING,"
						+ "REF11:DECIMAL,REF12:DECIMAL,REF13:DECIMAL,REF14:DECIMAL,REF15:DECIMAL,REF16:DECIMAL,REF17:DECIMAL,"
						+ "REF21:DECIMAL,REF22:DECIMAL,REF23:DECIMAL,REF24:DECIMAL,REF25:DECIMAL,REF26:DECIMAL,REF27:DECIMAL,"
						+ "CHILDCNT:DECIMAL,"
						+ "PCNT:DECIMAL,TCNT:DECIMAL,"
						+ "TREF11:DECIMAL(9.0),TREF12:DECIMAL(9.0),TREF13:DECIMAL(9.0),TREF14:DECIMAL(9.0),TREF15:DECIMAL(9.0),TREF16:DECIMAL(9.0),TREF17:DECIMAL(9.0),"
						+ "TREF21:DECIMAL(9.0),TREF22:DECIMAL(9.0),TREF23:DECIMAL(9.0),TREF24:DECIMAL(9.0),TREF25:DECIMAL(9.0),TREF26:DECIMAL(9.0),TREF27:DECIMAL(9.0)";


			//prompt(this, ls_temp1);

			gcds_print1.SetDataHeader(ls_temp1);
      

		//20060112 ������ �߰�
		 gs_date = gcem_curdt.text;

		 gs_date4=Number(gcem_curdt.text)+1;
      
		 var iccnt = 0; /*2010.01.26 �̻�� ���ϳ� */

		 for (j=1;j<=gcds_data.countrow;j++) {

		    //iccnt = 1;

			gcds_print.Addrow();

			gcds_print.namevalue(j,"HTITLE") = "(������ �����)";

			gcds_print.namevalue(j,"CURDT")  = gcem_curdt.text+"1231" //20100126 ���ϳ��߰�, �ٹ�������

			gcds_print.namevalue(j,"CURDT2") = gs_date4; 
			

			//prompt(this, gcds_data.namevalue(j,"EMPNMK"));

			ln_Query02(gcds_data.namevalue(j,"EMPNMK"), gcds_data.namevalue(j,"EMPNO"));

			for(var i=1;i<=gcds_data.countcolumn;i++)	{
				gcds_print.namevalue(j,gcds_data.columnid(i))	= gcds_data.namevalue(j,gcds_data.columnid(i));
			}//END I FOR

			gcds_print.namevalue(j,"RCNT")=j; 

			for(var aa=1;aa<=gcds_data2.countrow;aa++)	{

				gcds_print1.Addrow();

				var row = gcds_print1.rowposition;

				gcds_print1.namevalue(row,"FAMNM1") = gcds_data2.namevalue(aa,"FAMNM1");
				gcds_print1.namevalue(row,"RESINO1") = gcds_data2.namevalue(aa,"RESINO1");
				gcds_print1.namevalue(row,"RELAT1") = gcds_data2.namevalue(aa,"RELAT1");
				gcds_print1.namevalue(row,"RESINO") = gcds_data2.namevalue(aa,"RESINO");
				gcds_print1.namevalue(row,"JUMIN") = gcds_data2.namevalue(aa,"JUMIN");

				//alert("AD0106CNT"+gcds_data2.namevalue(aa,"FAMNM1"));

				if( gcds_data2.namevalue(aa,"REF1")=="T")gcds_print1.namevalue(row,"REF1")="9"
				else gcds_print1.namevalue(row,"REF1")="1"
				if( gcds_data2.namevalue(aa,"REF2")=="T")gcds_print1.namevalue(row,"REF2")="O"
				else gcds_print1.namevalue(row,"REF2")=""
				if( gcds_data2.namevalue(aa,"REF3")=="T")gcds_print1.namevalue(row,"REF3")="O"
				else gcds_print1.namevalue(row,"REF3")=""
				if( gcds_data2.namevalue(aa,"REF4")=="T")gcds_print1.namevalue(row,"REF4")="O"
				else gcds_print1.namevalue(row,"REF4")=""
				if( gcds_data2.namevalue(aa,"REF5")=="T")gcds_print1.namevalue(row,"REF5")="O"
				else gcds_print1.namevalue(row,"REF5")=""
				if( gcds_data2.namevalue(aa,"REF6")=="T")gcds_print1.namevalue(row,"REF6")="O"
				else gcds_print1.namevalue(row,"REF6")=""

			/*	if( gcds_data2.namevalue(aa,"REF7")=="T")gcds_print1.namevalue(row,"REF7")="O"
				else gcds_print1.namevalue(row,"REF7")="" 2010.01.26 �̻�� ���ϳ� */

				if( gcds_data2.namevalue(aa,"REF8")=="T")gcds_print1.namevalue(row,"REF8")="O"
				else gcds_print1.namevalue(row,"REF8")=""


				for (var d=1; d<8; d++) {             //�������� ���� �ҵ�����׸�� 

					var nm1 = "REF1"+d;
					var nm2 = "REF2"+d;
					gcds_print1.namevalue(row,nm1) = gcds_data2.namevalue(aa,nm1);
					gcds_print1.namevalue(row,nm2) = gcds_data2.namevalue(aa,nm2);


				}

			/*	gcds_print1.namevalue(row,"PCNT")  = iccnt; 2010.01.26 �̻�� ���ϳ� */
				
				if (gcds_data2.namevalue(row,"RELAT1") == 4 ) {

								iccnt++;
				}



		//		if (aa==1) {





			}//END aa FOR
 					gcds_print1.namevalue(1,"CHILDCNT") = iccnt;   



			var icc = 8 - gcds_data2.countrow;
			for (var s=1;s<=icc;s++) {
				gcds_print1.addrow();
			/*	var rr = gcds_print1.rowposition;
				gcds_print1.namevalue(rr,"PCNT")  = iccnt; 2010.01.26 �̻�� ���ϳ� */
			} 


		var kkk = gcds_print1.countrow;




		//	prompt(this, gcds_data2.countrow);
					
		//if(kkk%8 == "0")
		//{

		//			var scnt = 0;
					var tcnt = gcds_data2.countrow;

		//	for(var sss=1;sss<=gcds_data2.countrow;sss++)
		//	{
					gcds_print1.namevalue(j,"TREF11")  = gcds_data2.sum(16,0,tcnt);
					gcds_print1.namevalue(j,"TREF12")  = gcds_data2.sum(17,0,tcnt);
					gcds_print1.namevalue(j,"TREF13")  = gcds_data2.sum(18,0,tcnt);
					gcds_print1.namevalue(j,"TREF14")  = gcds_data2.sum(19,0,tcnt);
					gcds_print1.namevalue(j,"TREF15")  = gcds_data2.sum(20,0,tcnt);
					gcds_print1.namevalue(j,"TREF16")  = gcds_data2.sum(21,0,tcnt);
					gcds_print1.namevalue(j,"TREF17")  = gcds_data2.sum(22,0,tcnt);

					gcds_print1.namevalue(j,"TREF21")  = gcds_data2.sum(23,0,tcnt);
					gcds_print1.namevalue(j,"TREF22")  = gcds_data2.sum(24,0,tcnt);
					gcds_print1.namevalue(j,"TREF23")  = gcds_data2.sum(25,0,tcnt);
					gcds_print1.namevalue(j,"TREF24")  = gcds_data2.sum(26,0,tcnt);
		//			gcds_print1.namevalue(row,"TREF25")  = gcds_data2.sum(27,0,tcnt);

					gcds_print1.namevalue(j,"TREF27")  = gcds_data2.sum(27,0,tcnt);

					gcds_print1.namevalue(j,"TREF26")  = gcds_data2.sum(28,0,tcnt);					
					//scnt = scnt+tcnt+1;
					//tcnt = scnt+tcnt;
					//prompt(this, scnt);
					//prompt(this, tcnt);

			//	}

		//}





		}//END J FOR




			//5PAGE �κ��� �����ͼ� ��� ���� , ���� �κи� ��ȸ�Ͽ� ������ ������ . 

			ls_temp12 ="APPYY:STRING,EMPNO:STRING,EMPNMK:STRING,ADDRESS:STRING,TELNO:STRING,"

							+ "EMPJUNO1:STRING,EMPJUNO2:STRING,EMPJUNO3:STRING,EMPJUNO4:STRING,EMPJUNO5:STRING,EMPJUNO6:STRING,"
							+ "EMPJUNO7:STRING,EMPJUNO8:STRING,EMPJUNO9:STRING,EMPJUNO10:STRING,EMPJUNO11:STRING,EMPJUNO12:STRING,EMPJUNO13:STRING,"

							+ "DUDGBNM1_1:STRING,FINANM1_1:STRING,ACCNO1_1:STRING,PAYAMT1_1:DECIMAL(9.0),DEDAMT1_1:DECIMAL(9.0),"
							+ "DUDGBNM1_2:STRING,FINANM1_2:STRING,ACCNO1_2:STRING,PAYAMT1_2:DECIMAL(9.0),DEDAMT1_2:DECIMAL(9.0),"
							+ "DUDGBNM1_3:STRING,FINANM1_3:STRING,ACCNO1_3:STRING,PAYAMT1_3:DECIMAL(9.0),DEDAMT1_3:DECIMAL(9.0),"
							+ "DUDGBNM2_1:STRING,FINANM2_1:STRING,ACCNO2_1:STRING,PAYAMT2_1:DECIMAL(9.0),DEDAMT2_1:DECIMAL(9.0),"
							+ "DUDGBNM2_2:STRING,FINANM2_2:STRING,ACCNO2_2:STRING,PAYAMT2_2:DECIMAL(9.0),DEDAMT2_2:DECIMAL(9.0),"
							+ "DUDGBNM2_3:STRING,FINANM2_3:STRING,ACCNO2_3:STRING,PAYAMT2_3:DECIMAL(9.0),DEDAMT2_3:DECIMAL(9.0),"
							+ "DUDGBNM2_4:STRING,FINANM2_4:STRING,ACCNO2_4:STRING,PAYAMT2_4:DECIMAL(9.0),DEDAMT2_4:DECIMAL(9.0),"
							+ "DUDGBNM2_5:STRING,FINANM2_5:STRING,ACCNO2_5:STRING,PAYAMT2_5:DECIMAL(9.0),DEDAMT2_5:DECIMAL(9.0),"
							+ "DUDGBNM3_1:STRING,FINANM3_1:STRING,ACCNO3_1:STRING,PAYAMT3_1:DECIMAL(9.0),DEDAMT3_1:DECIMAL(9.0),"
							+ "DUDGBNM3_2:STRING,FINANM3_2:STRING,ACCNO3_2:STRING,PAYAMT3_2:DECIMAL(9.0),DEDAMT3_2:DECIMAL(9.0),"
							+ "DUDGBNM3_3:STRING,FINANM3_3:STRING,ACCNO3_3:STRING,PAYAMT3_3:DECIMAL(9.0),DEDAMT3_3:DECIMAL(9.0),"
							+ "DUDGBNM3_4:STRING,FINANM3_4:STRING,ACCNO3_4:STRING,PAYAMT3_4:DECIMAL(9.0),DEDAMT3_4:DECIMAL(9.0),"
							+ "DUDGBNM3_5:STRING,FINANM3_5:STRING,ACCNO3_5:STRING,PAYAMT3_5:DECIMAL(9.0),DEDAMT3_5:DECIMAL(9.0),"	
								
							+ "YEARLY4_1:STRING,FINANM4_1:STRING,ACCNO4_1:STRING,PAYAMT4_1:DECIMAL(9.0),DEDAMT4_1:DECIMAL(9.0),"
							+ "YEARLY4_2:STRING,FINANM4_2:STRING,ACCNO4_2:STRING,PAYAMT4_2:DECIMAL(9.0),DEDAMT4_2:DECIMAL(9.0),"
							+ "YEARLY4_3:STRING,FINANM4_3:STRING,ACCNO4_3:STRING,PAYAMT4_3:DECIMAL(9.0),DEDAMT4_3:DECIMAL(9.0),"
							+ "YEARLY4_4:STRING,FINANM4_4:STRING,ACCNO4_4:STRING,PAYAMT4_4:DECIMAL(9.0),DEDAMT4_4:DECIMAL(9.0)";


			gcds_print22.SetDataHeader(ls_temp12);



		 for (j=1;j<=gcds_data.countrow;j++) {


				ln_Query03(gcds_data.namevalue(j,"EMPNO"));

				gcds_print22.Addrow();

				var row = gcds_print22.rowposition;

				gcds_print22.namevalue(j,"EMPNO") = gcds_data.namevalue(j,"EMPNO");
				gcds_print22.namevalue(j,"EMPNMK") = gcds_data.namevalue(j,"EMPNMK");
				gcds_print22.namevalue(j,"ADDRESS") = gcds_data12.namevalue(j,"ADDRESS");
				gcds_print22.namevalue(j,"TELNO") = gcds_data12.namevalue(j,"TELNO");	


				gcds_print22.namevalue(j,"EMPJUNO1")  = gcds_data.namevalue(j,"RESINO").substr(0,1);
				gcds_print22.namevalue(j,"EMPJUNO2")  =gcds_data.namevalue(j,"RESINO").substr(1,1);
				gcds_print22.namevalue(j,"EMPJUNO3")  =gcds_data.namevalue(j,"RESINO").substr(2,1);
				gcds_print22.namevalue(j,"EMPJUNO4")  =gcds_data.namevalue(j,"RESINO").substr(3,1);
				gcds_print22.namevalue(j,"EMPJUNO5")  =gcds_data.namevalue(j,"RESINO").substr(4,1);
				gcds_print22.namevalue(j,"EMPJUNO6")  =gcds_data.namevalue(j,"RESINO").substr(5,1);
				gcds_print22.namevalue(j,"EMPJUNO7")  =gcds_data.namevalue(j,"RESINO").substr(6,1);
				gcds_print22.namevalue(j,"EMPJUNO8")  =gcds_data.namevalue(j,"RESINO").substr(7,1);
				gcds_print22.namevalue(j,"EMPJUNO9")  =gcds_data.namevalue(j,"RESINO").substr(8,1);
				gcds_print22.namevalue(j,"EMPJUNO10")  =gcds_data.namevalue(j,"RESINO").substr(9,1);
				gcds_print22.namevalue(j,"EMPJUNO11")  =gcds_data.namevalue(j,"RESINO").substr(10,1);
				gcds_print22.namevalue(j,"EMPJUNO12")  =gcds_data.namevalue(j,"RESINO").substr(11,1);
				gcds_print22.namevalue(j,"EMPJUNO13")  =gcds_data.namevalue(j,"RESINO").substr(12,1);


		//���ݵ���
		var no = 1;
		for(i=1;i<=gcds_data12.countrow;i++){
			  if(gcds_data12.namevalue(i,"DUDGB")=="11"){
				  gcds_print22.namevalue(row,"DUDGBNM1_"+no)="��������";											//��������
				  gcds_print22.namevalue(row,"FINANM1_"+no)=gcds_data12.namevalue(i,"FINANM");			//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO1_"+no)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"PAYAMT1_"+no)=gcds_data12.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT1_"+no)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no++;
				}else if(gcds_data12.namevalue(i,"DUDGB")=="12"){
				  gcds_print22.namevalue(row,"DUDGBNM1_"+no)="���б���ΰ���";									//���б���ΰ���
				  gcds_print22.namevalue(row,"FINANM1_"+no)=gcds_data12.namevalue(i,"FINANM");			//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO1_"+no)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"PAYAMT1_"+no)=gcds_data12.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT1_"+no)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no++;
				}
		}

		var no2 = 1;
		for(i=1;i<=gcds_data12.countrow;i++){
			  if(gcds_data12.namevalue(i,"DUDGB")=="21"){
				  gcds_print22.namevalue(row,"DUDGBNM2_"+no2)="���ο�������";										//���ο�������
				  gcds_print22.namevalue(row,"FINANM2_"+no2)=gcds_data12.namevalue(i,"FINANM");				//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO2_"+no2)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"PAYAMT2_"+no2)=gcds_data2.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT2_"+no2)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no2++;
				}else if(gcds_data12.namevalue(i,"DUDGB")=="22"){
				  gcds_print22.namevalue(row,"DUDGBNM2_"+no2)="��������";												//��������
				  gcds_print22.namevalue(row,"FINANM2_"+no2)=gcds_data12.namevalue(i,"FINANM");				//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO2_"+no2)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"PAYAMT2_"+no2)=gcds_data12.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT2_"+no2)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no2++;
				}
		}

		var no3 = 1;
		for(i=1;i<=gcds_data12.countrow;i++){
			  if(gcds_data12.namevalue(i,"DUDGB")=="31"){
				  gcds_print22.namevalue(row,"DUDGBNM3_"+no3)="û������";												//û������
				  gcds_print22.namevalue(row,"FINANM3_"+no3)=gcds_data12.namevalue(i,"FINANM");				//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO3_"+no3)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"PAYAMT3_"+no3)=gcds_data12.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT3_"+no3)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no3++;
				}else if(gcds_data12.namevalue(i,"DUDGB")=="32"){
				  gcds_print22.namevalue(row,"DUDGBNM3_"+no3)="����û����������";									//����û����������
				  gcds_print22.namevalue(row,"FINANM3_"+no3)=gcds_data12.namevalue(i,"FINANM");				//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO3_"+no3)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"PAYAMT3_"+no3)=gcds_data12.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT3_"+no3)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no3++;
				}else if(gcds_data12.namevalue(i,"DUDGB")=="33"){
				  gcds_print22.namevalue(row,"DUDGBNM3_"+no3)="������ø�������";									//������ø�������
				  gcds_print22.namevalue(row,"FINANM3_"+no3)=gcds_data12.namevalue(i,"FINANM");				//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO3_"+no3)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"PAYAMT3_"+no3)=gcds_data12.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT3_"+no3)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no3++;
				}else if(gcds_data12.namevalue(i,"DUDGB")=="34"){
				  gcds_print22.namevalue(row,"DUDGBNM3_"+no3)="�ٷ������ø�������";								//�ٷ������ø�������
				  gcds_print22.namevalue(row,"FINANM3_"+no3)=gcds_data12.namevalue(i,"FINANM");				//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO3_"+no3)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"PAYAMT3_"+no3)=gcds_data12.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT3_"+no3)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no3++;
				}
		}

		var no4 = 1;
		for(i=1;i<=gcds_data12.countrow;i++){
			  if(gcds_data12.namevalue(i,"DUDGB")=="41"){																		//����ֽ����������
				  gcds_print22.namevalue(row,"FINANM4_"+no4)=gcds_data12.namevalue(i,"FINANM");				//���������ȣ
				  gcds_print22.namevalue(row,"ACCNO4_"+no4)=gcds_data12.namevalue(i,"ACCNO");				//���¹�ȣ
				  gcds_print22.namevalue(row,"YEARLY4_"+no4)=gcds_data12.namevalue(i,"YEARLY");				//���Կ���
				  gcds_print22.namevalue(row,"PAYAMT4_"+no4)=gcds_data12.namevalue(i,"PAYAMT");			//���Աݾ�
				  gcds_print22.namevalue(row,"DEDAMT4_"+no4)=gcds_data12.namevalue(i,"DEDAMT");			//�����ݾ�
				  no4++;
				}
			}

	}




			//prompt(this, gcds_print1.text);






		if(gcds_manager.countrow>0){ 	//������ 

		  //�ӽø���.
			//////gcrp_print.preview();		//(������ �����)
			for (j=1;j<=gcds_data.countrow;j++) {

				gcds_print.namevalue(j,"HTITLE") = "(������ ������)";
			}

			gcrp_print2.preview();	//(������ ������)
			//gcrp_print22.preview();	//(������ ������)
			for (j=1;j<=gcds_data.countrow;j++) {

				gcds_print.namevalue(j,"HTITLE") = "(�ҵ��� ������)";

			}
		//�ӽø���
		//////gcrp_print3.preview();	//(�ҵ��� ������)
		}else{  //����

		  for(var k=1;k<=gcds_empno.countrow;k++){

				if(gcds_empno.namevalue(k,"EMPNO")==gusrid){

					gcds_print.namevalue(1,"RCNT")=k;

				}

			}
			for (j=1;j<=gcds_data.countrow;j++) {

				gcds_print.namevalue(j,"HTITLE") = "(�ҵ��� ������)";
			}
		
			//2011.02.24 jys �ӽ÷� ����.
			//gcrp_print3.preview();	//(�ҵ��� ������)

     
			gcrp_print2.preview();	//(�ҵ��� ������)
		}		
	}





}



/******************************************************************************
	Description : ��� - �������� ������Ȳ
******************************************************************************/
function ln_Print2(){
	//��ø��Ƴ���
	//gcds_print2.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s2?v_str1=" + gcem_curdt.text+"12"
	//																												+"&v_str2=" + gcem_curdt.text;
//	gcds_print2.Reset();
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<object id="gcds_data00" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<object id="gcds_data" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<object id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__">
<object id="gcds_data12" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �Ҽ� �˻�-->
<comment id="__NSID__">
<object id=gcds_dept1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</object></comment><script>__ws__(__NSID__);</script>

<!-- �Ҽ� BIND-->
<comment id="__NSID__">
<object id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<object id="gcds_print" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<object id="gcds_print1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<object id="gcds_print22" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<object id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<OBJECT id=gcds_manager classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �����ڱ��� -->
</OBJECT>

<OBJECT id=gcds_empno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- ������ȣ ���� ���ο� -->
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
  ft_cnt1.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	if (rowcount==0)	alert("�˻��� ����Ÿ�� �����ϴ�."); 
</script>

<script language=JavaScript  for=gcds_print2 event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print2 event=OnLoadCompleted(rowcount)>
	//document.all.LowerFrame.style.visibility="hidden";
	if (rowcount<1) {
		alert("����Ͻ� ������ �����ϴ�");
	}else{
		gcrp_print4.preview();	
	}
</script>


<script language=JavaScript  for=gcds_print22 event=OnLoadCompleted(rowcount)>
  ft_cnt1.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	if (rowcount==0)	alert("�˻��� ����Ÿ�� �����ϴ�."); 
</script>

<script language=JavaScript  for=gcds_print22 event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	//window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
	gcds_dept2.insertrow(1);
	gcds_dept2.namevalue(1,"DEPTCD") = "";
	gcds_dept2.namevalue(1,"DEPTNM") = "��ü";
	gclx_deptcd.index = 0;
</script>

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
	gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	//window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p030005_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>	    
			<img src="../../Common/img/btn/com_b_receipt.gif"	style="cursor:hand" onclick="ln_Print()">
			<!-- <img src="../../Common/img/btn/com_btn_ledger.gif"	style="cursor:hand" onclick="ln_Print2()"> -->
			<img src="../../Common/img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()"> 
			</nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;�ͼӳ⵵&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
							<param name=Text          value="">
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=enable				value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>	
					<td  width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;&nbsp;�� ��&nbsp;&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:112px;">
							<param name=ComboDataID			value="gcds_dept2">
							<param name=CBDataColumns		value="DEPTCD, DEPTNM">
							<param name=SearchColumn		value=DEPTNM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DEPTNM^0^150">
							<param name=BindColumn			value=DEPTCD>
 						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
						<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
							<nobr>&nbsp;&nbsp;&nbsp;�� ��&nbsp;&nbsp;&nbsp;</nobr></td>
						<td><nobr>&nbsp;<input id="txt_empnmk1" name="txt_empnmk1" type="text"  class="txtbox" style="width:70px; height:18px;" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;
						<input id="txt_empno1" type="hidden"  class="txtbox" style="width:70px; height:18px;" ">
					</nobr>
						</td>
						<td width="100%">&nbsp;&nbsp;</td>
						<td style="padding-top:4px;"></td>
					</tr>
				</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:310px" valign=top>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  style="WIDTH: 282px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="FALSE">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
              <PARAM name="SortView"    value="Left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='�⵵'     ID=APPYY  	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	Mask='XXXX'</C> 
								<C> Name='�Ҽ�'			ID=DEPTNMK	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT		sort=true</C> 
								<C> Name='����'			ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=LEFT		sort=true</C>
								<C> Name='���'			ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=CENTER  sort=true</C> 
								<C> Name='�Ի���'		ID=STRTDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER	MASK='XXXX/XX/XX'	 sort=true</C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:284px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
						</fieldset>
					</td>
          <td>&nbsp;</td>
					<td STYLE="PADDING-TOP:0px;" valign=top>
		<table width="512" cellpadding="0" cellspacing="0" border="0">
			<tr> 
				<td valign=top>
				
					<table border= "0"  cellpadding=0 cellspacing=0  border=0  style='width:565px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
						<tr>
							<td class ="tab25" style="width:60;height:25px;" bgcolor="#eeeeee">&nbsp;�ͼӳ⵵</td>
							<td class ="tab26" style="" colspan=2><nobr>
								<comment id="__NSID__"><object id=gcem_APPYY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
									<param name=Text          value="">
								  <param name=Border	      value=true>
									<param name=Format	      value="YYYY">
									<param name=MaxLength     value=6>
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=enable				value=false>
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
							</td>
							<td class ="tab26"  style="height:25px;" bgcolor="#eeeeee">&nbsp;���</td>
							<td class ="tab26"  style="" colspan=2><nobr>
								<comment id="__NSID__"><object id=gcem_EMPNO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt; " > 
								<param name=Text          value="">
								<param name=Border	      value=true>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=7>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
							</td>
							<td class ="tab26"  style="" bgcolor="#eeeeee">&nbsp;����</td>
							<td class ="tab26"  style="" colspan=2>
								<input id="txt_empnmk2" name="txt_empnmk2" type="text"  class="txtbox"  style="width:70px; height:18px;position:relative;left:6px" maxlength=16 disabled>
							</td>
						</tr>
						<tr>
							<td class ="tab30" style="height:25px;" bgcolor="#eeeeee">&nbsp;�Ҽ�</td>
							<td class ="tab21" style="" colspan=2>&nbsp;
								<input id="txt_DEPTNMK" name="txt_DEPTNMK" type="text"  class="txtbox" style="width:70px; height:18px;position:relative;left:-6px" maxlength=16 disabled></td>
							</td>
							<td class ="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;����</td>
							<td class ="tab21" style="" colspan=2>&nbsp;
								<input id="txt_PAYGRDNM" name="txt_PAYGRDNM" type="text"  class="txtbox"  style= "width:70px; height:18px; position:relative;left:-6px" value="" maxlength=16 disabled></td>
							</td>
							<td class ="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;ȣ��</td>
						  <td class ="tab21" style="" colspan=2>&nbsp;
								<input id="txt_PAYSEQNM" name="txt_PAYSEQNM" type="text"  class="txtbox"  style= "width:70px; height:18px; position:relative;left:-6px" value="" maxlength=16 disabled></td>
						</tr>
						<tr>
						<td class ="tab30" style="height:25px;" bgcolor="#eeeeee">&nbsp;�Ի�����</td>
						<td class ="tab21" style="" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_STRTDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Text          value="">
		   					<param name=Border	      value=True>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class ="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�������</td>
						<td class ="tab21" style="" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ENDDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; "  >
								<param name=Text          value="">
								<param name=Border	      value=True>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab28" colspan=2><nobr>&nbsp;</nobr>
					</tr>
					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>
					<tr>
						<td class="tab25" style="font-family:����;font-size:9pt;" bgcolor="#B9D4DC">&nbsp;�ҵ��</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#eeeeee" colspan=2>���ٹ���</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#eeeeee">�����ٹ���</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#eeeeee" colspan=2>�����ٹ���</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#eeeeee">��������</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#DCDCDC" colspan=2>�հ�</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�޿�</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CP11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px;height:20px;font-family:����;font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=ReadOnly      value=true>

							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BP11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
							  <param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BP21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BP31000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CBP1000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CP12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
							  <param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28"><nobr>
							<comment id="__NSID__"><object id=gcem_BP12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BP22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BP32000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CBP2000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;������</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CP13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BP13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BP23000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BP33000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CBP3000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#DCDCDC">&nbsp;��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CP10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BP10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BP20000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BP30000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CBPSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					
					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;������ҵ�</td>
						<td class="tab24" colspan=2><nobr>
							&nbsp;</nobr>
						</td>
						<td class="tab26" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab26" colspan=2><nobr>&nbsp;</nobr>
						</td>
						<td class="tab26" bgcolor="#DCDCDC">&nbsp;������ҵ��</td>
						<td class="tab26" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc20000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�߱ٱٷμ���</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;���ܱٷμҵ�<br>(100����)</br></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc23000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;���ܱٷμҵ�(150����)</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_btaxamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;�����</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�ѱ޿�</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_TOTPAY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�ٷμҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_DUDPAY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ٷμҵ�ݾ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_LABPAY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;��������</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BAAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BAAMT02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�ξ簡��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BAAMT03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;��ο��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ADAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ADAMT02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�γ���</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ADAMT03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�ڳ������</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ADAMT04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;���.�Ծ���</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ADAMT05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;���ڳ��߰�����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ADAMT06 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;���ο��ݺ�������&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_PENAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#B9D4DC"><nobr>&nbsp;�������ݺ�������&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_PENAMT03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;Ư������</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#DCDCDC">&nbsp;Ư��������</td>
						<td class="tab14" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_SPCSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�ǰ������</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_INSAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;��뺸���</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_INSAMT02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;���强�����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_INSAMT03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;����κ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_INSAMT04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�Ƿ��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_MEDSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;������</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_EDUSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�����������Ա�<br>&nbsp;�����ݻ�ȯ��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_HOUAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�����������<br>&nbsp;���Ա����ڻ�ȯ��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_HOUAMT03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;������</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_HOUAMT02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>

						<td class="tab27" bgcolor="#eeeeee">&nbsp;��α�</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CONAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab28" colspan=2>&nbsp;</td>			
						<td class="tab28" bgcolor="#eeeeee">&nbsp;ǥ�ذ���</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_STDSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;�����ҵ�ݾ�&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_OFFSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;�� ���� �ҵ����</nobr></td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#DCDCDC">&nbsp;�� ����<BR>&nbsp�ҵ������</td>
						<td class="tab14" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ETCSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;���ο���<br>&nbsp;����ҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_PESAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;��������<br>&nbsp;�ҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_PESAMT02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;��������<br>&nbsp;���ڼҵ����</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_INVSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
          <tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;û������</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_SAVAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;����û����������</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_SAVAMT03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;���<br>&nbsp;���ø�������</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_SAVAMT04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>


					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�ſ�ī�� ��<br>&nbsp;�ҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CRDSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;�츮����<br>&nbsp;���ռҵ����</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ASSSUM  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;����ֽ���<br>&nbsp;����ҵ����</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_FNDSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;���ռҵ����ǥ��&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_TAXSTDAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;���⼼��&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_TAXSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;���װ���</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab26" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab26" colspan=2><nobr>&nbsp;</nobr>
						</td>
						<td class="tab26" bgcolor="#DCDCDC">&nbsp;���鼼�װ�</td>
						<td class="tab26" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_TREDSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ҵ漼��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_TREDAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;����Ư�����ѹ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_TREDAMT02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;���װ���</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab26" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab26" colspan=2><nobr>&nbsp;</nobr>
						</td>
						<td class="tab26" bgcolor="#DCDCDC">&nbsp;���װ�����</td>
						<td class="tab26" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_DEDSUM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ٷμҵ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_DEDAMT01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�������հ���</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_DEDAMT02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�������Ա�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_DEDAMT03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ܱ��γ���</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_DEDAMT05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�����ġ�ڱ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_DEDAMT04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;��������&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CCP41000_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" style="font-family:����;font-size:9pt;" bgcolor="#B9D4DC">&nbsp;���׸�</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#eeeeee" colspan=2>�ҵ漼</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#eeeeee">�ֹμ�</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#eeeeee" colspan=2>�����Ư����</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#DCDCDC">��</td>
						<td class="tab14" style="font-family:����;font-size:9pt;" bgcolor="#eeeeee" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;��������</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CCP41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px;height:20px;font-family:����;font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_CCP42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CCP43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_CCP40000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
  							<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;���ٹ���<br>&nbsp;�ⳳ�μ���</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BP456_10 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28"><nobr>
							<comment id="__NSID__"><object id=gcem_BP456_20 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BP456_30 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BP456_00 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;���ٹ�����<br>&nbsp;���μ���</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CP41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_CP42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CP43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_CP40000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;����¡������</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BA41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BA42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_BA43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_BA40000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>

<!--

						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_STRTDT1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_ENDDT1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>

						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bp141000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
								<param name=Visible             value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bp142000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
								<param name=Visible             value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bp143000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
								<param name=Visible             value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_STRTDT2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
								<param name=Visible             value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_ENDDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; "  >
								<param name=Text          value="">
								<param name=Border	      value=True>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable		  value=false>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bp241000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
								<param name=Visible             value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bp242000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
								<param name=Visible             value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bp243000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
								<param name=Visible             value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
			
	<C>Col=STRTDT1		Ctrl=gcem_STRTDT1   Param=Text</C>
			<C>Col=ENDDT1		Ctrl=gcem_ENDDT1    Param=Text</C>
			<C>Col=BP141000		Ctrl=gcem_bp141000   Param=Text</C>
			<C>Col=BP142000		Ctrl=gcem_bp142000   Param=Text</C>
			<C>Col=BP143000		Ctrl=gcem_bp143000   Param=Text</C>
			<C>Col=STRTDT2		Ctrl=gcem_STRTDT2   Param=Text</C>
			<C>Col=ENDDT2		Ctrl=gcem_ENDDT2    Param=Text</C>
			<C>Col=BP241000		Ctrl=gcem_bp241000    Param=Text</C>
			<C>Col=BP242000		Ctrl=gcem_bp242000   Param=Text</C>
			<C>Col=BP243000		Ctrl=gcem_bp243000   Param=Text</C>-->
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>					         
         </table>
						</td>
					</tr>
				</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
	</table>




<comment id="__NSID__"><object id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPYY				Ctrl=gcem_APPYY				Param=Text</C>
		<C>Col=EMPNO			Ctrl=gcem_EMPNO			Param=Text</C>
		<C>Col=EMPNMK			Ctrl=txt_empnmk2			Param=Value</C>
		<C>Col=DEPTNMK		Ctrl=txt_DEPTNMK			Param=Value</C>
		<C>Col=PAYGRDNM		Ctrl=txt_PAYGRDNM			Param=Value</C>
		<C>Col=PAYSEQNM		Ctrl=txt_PAYSEQNM			Param=Value</C>
		<C>Col=STRTDT			Ctrl=gcem_STRTDT			Param=Text</C>
		<C>Col=ENDDT			Ctrl=gcem_ENDDT			Param=Text</C>
		<C>Col=CP11000		Ctrl=gcem_CP11000			Param=Text</C>
		<C>Col=CP12000		Ctrl=gcem_CP12000			Param=Text</C>
		<C>Col=CP13000		Ctrl=gcem_CP13000			Param=Text</C>
		<C>Col=CP10000		Ctrl=gcem_CP10000			Param=Text</C>
		<C>Col=BP11000		Ctrl=gcem_BP11000			Param=Text</C>
		<C>Col=BP12000		Ctrl=gcem_BP12000			Param=Text</C>
		<C>Col=BP13000		Ctrl=gcem_BP13000			Param=Text</C>
		<C>Col=BP10000		Ctrl=gcem_BP10000			Param=Text</C>
		<C>Col=BP21000		Ctrl=gcem_BP21000			Param=Text</C>
		<C>Col=BP22000		Ctrl=gcem_BP22000			Param=Text</C>
		<C>Col=BP23000		Ctrl=gcem_BP23000			Param=Text</C>
		<C>Col=BP20000		Ctrl=gcem_BP20000			Param=Text</C>
		<C>Col=BP31000		Ctrl=gcem_BP31000			Param=Text</C>
		<C>Col=BP32000		Ctrl=gcem_BP32000			Param=Text</C>
		<C>Col=BP33000		Ctrl=gcem_BP33000			Param=Text</C>
		<C>Col=BP30000		Ctrl=gcem_BP30000			Param=Text</C>
		<C>Col=CBP1000		Ctrl=gcem_CBP1000			Param=Text</C>
		<C>Col=CBP2000		Ctrl=gcem_CBP2000			Param=Text</C>
		<C>Col=CBP3000		Ctrl=gcem_CBP3000			Param=Text</C>
		<C>Col=CBPSUM 		Ctrl=gcem_CBPSUM			Param=Text</C>
		<C>Col=TOTPAY			Ctrl=gcem_TOTPAY			Param=Text</C>
		<C>Col=DUDPAY			Ctrl=gcem_DUDPAY			Param=Text</C>
		<C>Col=LABPAY			Ctrl=gcem_LABPAY			Param=Text</C>
		<C>Col=BAAMT01		Ctrl=gcem_BAAMT01		Param=Text</C>
		<C>Col=BAAMT02		Ctrl=gcem_BAAMT02		Param=Text</C>
		<C>Col=BAAMT03		Ctrl=gcem_BAAMT03		Param=Text</C>
		<C>Col=ADAMT01		Ctrl=gcem_ADAMT01		Param=Text</C>
		<C>Col=ADAMT02		Ctrl=gcem_ADAMT02		Param=Text</C>
		<C>Col=ADAMT03		Ctrl=gcem_ADAMT03		Param=Text</C>
		<C>Col=ADAMT04		Ctrl=gcem_ADAMT04		Param=Text</C>
		<C>Col=ADAMT05		Ctrl=gcem_ADAMT05		Param=Text</C>
		<C>Col=ADAMT06 		Ctrl=gcem_ADAMT06		Param=Text</C>
		<C>Col=PENAMT01		Ctrl=gcem_PENAMT01		Param=Text</C>
		<C>Col=PENAMT03		Ctrl=gcem_PENAMT03		Param=Text</C>
		<C>Col=INSAMT01		Ctrl=gcem_INSAMT01		Param=Text</C>
		<C>Col=INSAMT02		Ctrl=gcem_INSAMT02		Param=Text</C>
		<C>Col=INSAMT03		Ctrl=gcem_INSAMT03		Param=Text</C>
		<C>Col=INSAMT04		Ctrl=gcem_INSAMT04		Param=Text</C>
		<C>Col=MEDSUM			Ctrl=gcem_MEDSUM			Param=Text</C>
		<C>Col=EDUSUM			Ctrl=gcem_EDUSUM			Param=Text</C>
		<C>Col=HOUAMT01		Ctrl=gcem_HOUAMT01		Param=Text</C>
		<C>Col=HOUAMT02		Ctrl=gcem_HOUAMT02		Param=Text</C>
		<C>Col=HOUAMT03		Ctrl=gcem_HOUAMT03		Param=Text</C>
		<C>Col=CONAMT			Ctrl=gcem_CONAMT			Param=Text</C>
		<C>Col=SPCSUM			Ctrl=gcem_SPCSUM			Param=Text</C>
		<C>Col=STDSUM			Ctrl=gcem_STDSUM			Param=Text</C>
		<C>Col=OFFSUM			Ctrl=gcem_OFFSUM			Param=Text</C>
		<C>Col=ETCSUM			Ctrl=gcem_ETCSUM			Param=Text</C>
		<C>Col=PESAMT01		Ctrl=gcem_PESAMT01		Param=Text</C>
		<C>Col=PESAMT02		Ctrl=gcem_PESAMT02		Param=Text</C>
		<C>Col=INVSUM			Ctrl=gcem_INVSUM			Param=Text</C>
		<C>Col=SAVAMT01		Ctrl=gcem_SAVAMT01		Param=Text</C>
		<C>Col=SAVAMT03		Ctrl=gcem_SAVAMT03		Param=Text</C>
		<C>Col=SAVAMT04		Ctrl=gcem_SAVAMT04		Param=Text</C>
		<C>Col=CRDSUM			Ctrl=gcem_CRDSUM			Param=Text</C>
		<C>Col=ASSSUM			Ctrl=gcem_ASSSUM			Param=Text</C>
		<C>Col=FNDSUM			Ctrl=gcem_FNDSUM			Param=Text</C>
		<C>Col=TAXSTDAMT	Ctrl=gcem_TAXSTDAMT	Param=Text</C>
		<C>Col=TAXSUM			Ctrl=gcem_TAXSUM			Param=Text</C>
		<C>Col=TREDSUM		Ctrl=gcem_TREDSUM		Param=Text</C>
		<C>Col=TREDAMT01	Ctrl=gcem_TREDAMT01	Param=Text</C>
		<C>Col=TREDAMT02	Ctrl=gcem_TREDAMT02	Param=Text</C>
		<C>Col=DEDSUM			Ctrl=gcem_DEDSUM			Param=Text</C>
		<C>Col=DEDAMT01		Ctrl=gcem_DEDAMT01		Param=Text</C>
		<C>Col=DEDAMT02		Ctrl=gcem_DEDAMT02		Param=Text</C>
		<C>Col=DEDAMT03		Ctrl=gcem_DEDAMT03		Param=Text</C>
		<C>Col=DEDAMT04		Ctrl=gcem_DEDAMT04		Param=Text</C>
		<C>Col=DEDAMT05		Ctrl=gcem_DEDAMT05		Param=Text</C>
		<C>Col=CCP41000		Ctrl=gcem_CCP41000_1	Param=Text</C>
		<C>Col=CCP41000		Ctrl=gcem_CCP41000		Param=Text</C>
		<C>Col=CCP42000		Ctrl=gcem_CCP42000		Param=Text</C>
		<C>Col=CCP43000		Ctrl=gcem_CCP43000		Param=Text</C>
		<C>Col=CCP40000		Ctrl=gcem_CCP40000		Param=Text</C>
		<C>Col=BP456_10		Ctrl=gcem_BP456_10		Param=Text</C>
		<C>Col=BP456_20		Ctrl=gcem_BP456_20		Param=Text</C>
		<C>Col=BP456_30		Ctrl=gcem_BP456_30		Param=Text</C>
		<C>Col=BP456_00		Ctrl=gcem_BP456_00		Param=Text</C>
		<C>Col=CP41000		Ctrl=gcem_CP41000			Param=Text</C>
		<C>Col=CP42000		Ctrl=gcem_CP42000			Param=Text</C>
		<C>Col=CP43000		Ctrl=gcem_CP43000			Param=Text</C>
		<C>Col=CP40000		Ctrl=gcem_CP40000			Param=Text</C>
		<C>Col=BA41000		Ctrl=gcem_BA41000			Param=Text</C>
		<C>Col=BA42000		Ctrl=gcem_BA42000			Param=Text</C>
		<C>Col=BA43000		Ctrl=gcem_BA43000			Param=Text</C>
		<C>Col=BA40000		Ctrl=gcem_BA40000			Param=Text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>



























<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ� �� : �ٷμҵ��õ¡�������� REPORT
--------------------------------------------------------------------------------------->


<comment id="__NSID__">
<object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print">  -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2750 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=66 ,top=185 ,right=395 ,bottom=274 ,border=true</X>
	<L> left=29 ,top=2650 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=158 ,right=29 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210��x297��(�Ϲݿ��� 60g/��)' ,left=1206 ,top=2663 ,right=1848 ,bottom=2705 ,align='right' ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��1��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1719 ,top=319 ,right=1719 ,bottom=361 </L>
	<L> left=1293 ,top=232 ,right=1830 ,bottom=232 </L>
	<T>id='��1 / ��2' ,left=1585 ,top=279 ,right=1827 ,bottom=314 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ֱ���' ,left=1303 ,top=195 ,right=1514 ,bottom=227 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������1 / �������2' ,left=1530 ,top=195 ,right=1827 ,bottom=227 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ܱ���' ,left=1303 ,top=240 ,right=1514 ,bottom=269 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=274 ,right=1830 ,bottom=274 </L>
	<T>id='�ܱ��δ��ϼ�������' ,left=1303 ,top=279 ,right=1572 ,bottom=314 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=319 ,right=1830 ,bottom=319 </L>
	<T>id='��������' ,left=1303 ,top=324 ,right=1422 ,bottom=356 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=361 ,right=1830 ,bottom=361 </L>
	<T>id='������1 / �ܱ���9' ,left=1530 ,top=240 ,right=1827 ,bottom=269 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������ڵ�' ,left=1530 ,top=324 ,right=1709 ,bottom=356 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=187 ,right=1830 ,bottom=187 </L>
	<L> left=1293 ,top=187 ,right=1293 ,bottom=361 </L>
	<T>id='[���� ��24ȣ ����(1)]  ' ,left=29 ,top=90 ,right=1438 ,bottom=150 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=380 ,right=1851 ,bottom=380 </L>
	<C>id='HTITLE', left=629, top=298, right=1048, bottom=340, face='����', size=10, bold=true, underline=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ٷμҵ� ���޸���' ,left=598 ,top=240 ,right=1216 ,bottom=287 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷμҵ��õ¡��������' ,left=598 ,top=187 ,right=1216 ,bottom=235 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=550 ,top=243 ,right=579 ,bottom=277 ,border=true</X>
	<X>left=550 ,top=192 ,right=579 ,bottom=227 ,border=true</X>
	<T>id='����' ,left=71 ,top=190 ,right=184 ,bottom=229 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=71 ,top=232 ,right=184 ,bottom=269 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCNT', left=303, top=190, right=390, bottom=269, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2009 -' ,left=205 ,top=190 ,right=321 ,bottom=269 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=185 ,right=192 ,bottom=274 </L>
	<T>id='(���� �Ǵ� ��)' ,left=1482 ,top=2550 ,right=1748 ,bottom=2584 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2418 ,right=1851 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1522 ,top=187 ,right=1522 ,bottom=274 </L>
	<L> left=1830 ,top=190 ,right=1830 ,bottom=361 </L>
	<L> left=1577 ,top=274 ,right=1577 ,bottom=319 </L>
	<L> left=1527 ,top=319 ,right=1527 ,bottom=361 </L>
	<L> left=29 ,top=672 ,right=1851 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�켺��' ,left=221 ,top=564 ,right=508 ,bottom=609 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�Ϲ�ȣ' ,left=221 ,top=446 ,right=508 ,bottom=490 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� �� �� (�ּ�)' ,left=221 ,top=501 ,right=508 ,bottom=546 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ּ�' ,left=221 ,top=620 ,right=508 ,bottom=664 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� ǥ �� (��     ��)' ,left=1014 ,top=388 ,right=1356 ,bottom=432 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1385 ,top=388 ,right=1703 ,bottom=432 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� �� �� ȣ' ,left=1014 ,top=446 ,right=1356 ,bottom=490 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1385 ,top=446 ,right=1703 ,bottom=490 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� ��  �� ȣ' ,left=1014 ,top=564 ,right=1356 ,bottom=609 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1385, top=564, right=1819, bottom=609, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=213 ,top=496 ,right=1851 ,bottom=496 </L>
	<L> left=995 ,top=380 ,right=995 ,bottom=496 </L>
	<L> left=1364 ,top=380 ,right=1364 ,bottom=496 </L>
	<L> left=29 ,top=554 ,right=1851 ,bottom=554 </L>
	<L> left=998 ,top=554 ,right=998 ,bottom=614 </L>
	<L> left=1364 ,top=554 ,right=1364 ,bottom=614 </L>
	<T>id='��� �� �� (�� ȣ)' ,left=221 ,top=388 ,right=508 ,bottom=432 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǹ���' ,left=37 ,top=469 ,right=208 ,bottom=514 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡   ��' ,left=37 ,top=414 ,right=208 ,bottom=459 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ���' ,left=37 ,top=564 ,right=208 ,bottom=651 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=595 ,top=683 ,right=819 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=982, top=915, right=1079, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=840, top=915, right=937, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=857, right=1445, bottom=902, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=915, right=1445, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=857, right=1585, bottom=902, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=915, right=1585, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC11000,0,,PC11000)}', left=595, top=976, right=819, bottom=1020, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC12000,0,,PC12000)}', left=595, top=1031, right=819, bottom=1076, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=857, right=1696, bottom=902, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=857, right=1827, bottom=902, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=915, right=1696, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=915, right=1827, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1095, top=915, right=1187, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1222, top=915, right=1319, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=865 ,right=87 ,bottom=904 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=912 ,right=87 ,bottom=952 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=957 ,right=87 ,bottom=997 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ó' ,left=34 ,top=999 ,right=87 ,bottom=1039 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1042 ,right=87 ,bottom=1081 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1129 ,right=87 ,bottom=1168 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1171 ,right=87 ,bottom=1210 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1216 ,right=87 ,bottom=1255 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1084 ,right=87 ,bottom=1123 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��          ��' ,left=100 ,top=2025 ,right=582 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=400 ,top=2133 ,right=400 ,bottom=2297 </L>
	<T>id='�ҵ漼' ,left=695 ,top=2025 ,right=974 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=982 ,top=2025 ,right=1261 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ư����' ,left=1272 ,top=2025 ,right=1551 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1561 ,top=2025 ,right=1840 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB41000,0,,PB41000)}', left=695, top=2083, right=974, bottom=2128, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB42000,0,,PB42000)}', left=982, top=2083, right=1261, bottom=2128, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB43000,0,,PB43000)}', left=1272, top=2083, right=1551, bottom=2128, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB40000,0,,PB40000)}', left=1561, top=2083, right=1840, bottom=2128, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='66)��(��)�ٹ���' ,left=197 ,top=2302 ,right=519 ,bottom=2347 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=503, top=2138, right=685, bottom=2183, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP141000,0,,BP141000)}', left=695, top=2138, right=974, bottom=2183, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP142000,0,,BP142000)}', left=982, top=2138, right=1261, bottom=2183, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP143000,0,,BP143000)}', left=1272, top=2138, right=1551, bottom=2183, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=503, top=2191, right=685, bottom=2236, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000,0,,BP241000)}', left=695, top=2191, right=974, bottom=2236, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP242000,0,,BP242000)}', left=982, top=2191, right=1261, bottom=2236, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP243000,0,,BP243000)}', left=1272, top=2191, right=1551, bottom=2236, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000+BP242000+BP243000,0,,BP241000+BP242000+BP243000)}', left=1561, top=2191, right=1840, bottom=2236, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='' ,left=503 ,top=2246 ,right=685 ,bottom=2291 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=695, top=2246, right=974, bottom=2291, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=982, top=2246, right=1261, bottom=2291, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1272, top=2246, right=1551, bottom=2291, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1561, top=2246, right=1840, bottom=2291, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB61000,0,,PB61000)}', left=695, top=2302, right=974, bottom=2347, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB62000,0,,PB62000)}', left=982, top=2302, right=1261, bottom=2347, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB63000,0,,PB63000)}', left=1272, top=2302, right=1551, bottom=2347, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB60000,0,,PB60000)}', left=1561, top=2302, right=1840, bottom=2347, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB71000,0,,PB71000)}', left=695, top=2362, right=974, bottom=2407, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB72000,0,,PB72000)}', left=982, top=2362, right=1261, bottom=2407, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB73000,0,,PB73000)}', left=1272, top=2362, right=1551, bottom=2407, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB70000,0,,PB70000)}', left=1561, top=2362, right=1840, bottom=2407, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=1550 ,right=87 ,bottom=1590 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1603 ,right=87 ,bottom=1643 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1661 ,right=87 ,bottom=1701 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1714 ,right=87 ,bottom=1753 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1764 ,right=87 ,bottom=1804 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1814 ,right=87 ,bottom=1854 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2159 ,right=87 ,bottom=2196 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2217 ,right=87 ,bottom=2257 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2273 ,right=87 ,bottom=2310 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2328 ,right=87 ,bottom=2365 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2107 ,right=87 ,bottom=2146 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC11000,0,,BC11000)}', left=848, top=976, right=1072, bottom=1020, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC12000,0,,BC12000)}', left=848, top=1031, right=1072, bottom=1076, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC21000,0,,BC21000)}', left=1106, top=976, right=1330, bottom=1020, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC22000,0,,BC22000)}', left=1106, top=1031, right=1330, bottom=1076, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM3', left=1356, top=741, right=1580, bottom=786, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO3', left=1356, top=799, right=1580, bottom=844, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC31000,0,,BC31000)}', left=1356, top=976, right=1580, bottom=1020, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC32000,0,,BC32000)}', left=1356, top=1031, right=1580, bottom=1076, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC2000,0,,PBC2000)}', left=1598, top=1031, right=1838, bottom=1076, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC1000,0,,PBC1000)}', left=1598, top=976, right=1838, bottom=1020, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC10000,0,,PC10000)}', left=595, top=1379, right=819, bottom=1424, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC10000,0,,BC10000)}', left=848, top=1379, right=1072, bottom=1424, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC20000,0,,BC20000)}', left=1106, top=1379, right=1330, bottom=1424, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC3000,0,,BC3000)}', left=1356, top=1379, right=1580, bottom=1424, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TWKSUM,0,,TWKSUM)}', left=1598, top=1379, right=1838, bottom=1424, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1321, right=819, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1321, right=1072, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1321, right=1330, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1321, right=1580, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1321, right=1838, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1266, right=819, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1266, right=1072, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1266, right=1330, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1266, right=1580, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1266, right=1838, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1205, right=819, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1205, right=1072, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1205, right=1330, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1205, right=1580, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1205, right=1838, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1147, right=819, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1147, right=1072, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1147, right=1330, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1147, right=1580, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1147, right=1838, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC13000,0,,PC13000)}', left=595, top=1089, right=819, bottom=1134, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC13000,0,,BC13000)}', left=848, top=1089, right=1072, bottom=1134, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC23000,0,,BC23000)}', left=1106, top=1089, right=1330, bottom=1134, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC33000,0,,BC33000)}', left=1356, top=1089, right=1580, bottom=1134, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC3000,0,,PBC3000)}', left=1598, top=1089, right=1838, bottom=1134, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1427 ,top=319 ,right=1427 ,bottom=361 </L>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1440, right=819, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1440, right=1330, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1440, right=1580, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=1598, top=1440, right=1838, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT201,0,,BTAXAMT201)}', left=1106, top=1495, right=1330, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1495, right=1580, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+BTAXAMT201,0,,BTAXAMT101+BTAXAMT201)}', left=1598, top=1495, right=1838, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='O01' ,left=408 ,top=1550 ,right=577 ,bottom=1595 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1550, right=819, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1550, right=1072, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1550, right=1330, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1550, right=1580, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1550, right=1838, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Q01' ,left=408 ,top=1606 ,right=577 ,bottom=1651 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1606, right=819, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1606, right=1072, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1606, right=1330, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1606, right=1580, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1606, right=1838, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1661, right=819, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=845, top=1661, right=1069, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1103, top=1661, right=1327, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1353, top=1661, right=1577, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1595, top=1661, right=1835, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1717, right=819, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1717, right=1072, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1717, right=1330, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1717, right=1580, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1717, right=1838, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1772, right=1072, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1772, right=1330, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1772, right=1580, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1772, right=1838, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1830, right=819, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1830, right=1072, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1830, right=1330, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1830, right=1580, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1830, right=1838, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1893, right=1072, bottom=1938, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1893, right=1330, bottom=1938, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1893, right=1580, bottom=1938, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1893, right=1838, bottom=1938, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1962, right=819, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1962, right=1072, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1962, right=1330, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1962, right=1580, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+PC23000,0,,BTAXAMT101+PC23000)}', left=1598, top=1962, right=1838, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=832 ,top=675 ,right=832 ,bottom=2017 </L>
	<L> left=1087 ,top=675 ,right=1087 ,bottom=2017 </L>
	<L> left=1590 ,top=675 ,right=1590 ,bottom=2017 </L>
	<L> left=192 ,top=2133 ,right=192 ,bottom=2352 </L>
	<C>id='CADDNM', left=592, top=620, right=1819, bottom=664, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='101-85-10695' ,left=592 ,top=446 ,right=885 ,bottom=490 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ���α� �赿 ������� 140-2' ,left=592 ,top=501 ,right=1727 ,bottom=546 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=592, top=564, right=885, bottom=609, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=592 ,top=388 ,right=885 ,bottom=432 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=587 ,top=380 ,right=587 ,bottom=2017 </L>
	<L> left=213 ,top=380 ,right=213 ,bottom=670 </L>
	<L> left=213 ,top=614 ,right=1851 ,bottom=614 </L>
	<C>id='CURDT2', left=1332, top=2492, right=1740, bottom=2529 ,mask='XXXX��  02��  28��', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=1203 ,top=2550 ,right=1435 ,bottom=2584 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=498 ,top=2133 ,right=498 ,bottom=2297 </L>
	<L> left=498 ,top=2241 ,right=1851 ,bottom=2241 </L>
	<L> left=498 ,top=2186 ,right=1851 ,bottom=2186 </L>
	<T>id='�ⳳ��' ,left=95 ,top=2191 ,right=187 ,bottom=2223 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=95 ,top=2228 ,right=184 ,bottom=2260 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1772, right=819, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=213 ,top=438 ,right=1851 ,bottom=438 </L>
	<L> left=687 ,top=2014 ,right=687 ,bottom=2418 </L>
	<L> left=92 ,top=733 ,right=1851 ,bottom=733 </L>
	<L> left=92 ,top=791 ,right=1851 ,bottom=791 </L>
	<L> left=92 ,top=852 ,right=1851 ,bottom=852 </L>
	<L> left=92 ,top=907 ,right=1851 ,bottom=907 </L>
	<L> left=92 ,top=1371 ,right=1851 ,bottom=1371 </L>
	<L> left=92 ,top=1316 ,right=1851 ,bottom=1316 </L>
	<L> left=92 ,top=1258 ,right=1851 ,bottom=1258 </L>
	<L> left=92 ,top=1200 ,right=1851 ,bottom=1200 </L>
	<L> left=92 ,top=1142 ,right=1851 ,bottom=1142 </L>
	<L> left=92 ,top=1081 ,right=1851 ,bottom=1081 </L>
	<L> left=92 ,top=1026 ,right=1851 ,bottom=1026 </L>
	<L> left=92 ,top=968 ,right=1851 ,bottom=968 </L>
	<L> left=92 ,top=1490 ,right=1851 ,bottom=1490 </L>
	<L> left=92 ,top=1545 ,right=1851 ,bottom=1545 </L>
	<L> left=92 ,top=1600 ,right=1851 ,bottom=1600 </L>
	<L> left=92 ,top=1656 ,right=1851 ,bottom=1656 </L>
	<L> left=92 ,top=1711 ,right=1851 ,bottom=1711 </L>
	<L> left=92 ,top=1767 ,right=1851 ,bottom=1767 </L>
	<L> left=92 ,top=1822 ,right=1851 ,bottom=1822 </L>
	<L> left=92 ,top=1883 ,right=1851 ,bottom=1883 </L>
	<L> left=92 ,top=1949 ,right=1851 ,bottom=1949 </L>
	<L> left=92 ,top=2355 ,right=1851 ,bottom=2355 </L>
	<L> left=92 ,top=2133 ,right=1851 ,bottom=2133 </L>
	<L> left=92 ,top=2078 ,right=1851 ,bottom=2078 </L>
	<L> left=977 ,top=2014 ,right=977 ,bottom=2418 </L>
	<L> left=1266 ,top=2014 ,right=1266 ,bottom=2418 </L>
	<L> left=1556 ,top=2014 ,right=1556 ,bottom=2418 </L>
	<L> left=29 ,top=2014 ,right=1851 ,bottom=2014 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=672 ,right=90 ,bottom=2415 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='���� ��õ¡����(�ٷμҵ�)�� ����(����)�մϴ�.' ,left=29 ,top=2436 ,right=1851 ,bottom=2476 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������  ����' ,left=461 ,top=2587 ,right=740 ,bottom=2631 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��(����)�ǹ���' ,left=742 ,top=2550 ,right=1095 ,bottom=2584 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)��(��)�ٹ���' ,left=197 ,top=2149 ,right=395 ,bottom=2202 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�������׶���' ,left=197 ,top=2188 ,right=398 ,bottom=2244 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����)' ,left=197 ,top=2236 ,right=395 ,bottom=2281 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP141000+BP142000+BP143000,0,,BP141000+BP142000+BP143000)}', left=1561, top=2138, right=1840, bottom=2183, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��(��)' ,left=848 ,top=683 ,right=1072 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=1106 ,top=683 ,right=1330 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)-1��������' ,left=1356 ,top=683 ,right=1580 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1598 ,top=683 ,right=1838 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT3', left=590, top=857, right=706, bottom=902, align='left', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUTO', left=721, top=915, right=829, bottom=960, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUFR', left=590, top=915, right=706, bottom=960, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1340 ,top=675 ,right=1340 ,bottom=2017 </L>
	<C>id='BCWKNM1', left=835, top=741, right=1085, bottom=786, align='left', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM2', left=1090, top=741, right=1337, bottom=786, align='left', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=' ~' ,left=695 ,top=857 ,right=724 ,bottom=902 ,face='Arial' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=721, top=857, right=829, bottom=902, align='left', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT1', left=835, top=857, right=1085, bottom=902, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT2', left=1090, top=857, right=1337, bottom=902, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=405 ,top=2154 ,right=495 ,bottom=2199 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=405 ,top=2191 ,right=495 ,bottom=2236 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=405 ,top=2228 ,right=495 ,bottom=2273 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=835, top=799, right=1085, bottom=844, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1090, top=799, right=1337, bottom=844, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=1432 ,right=1851 ,bottom=1432 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=403 ,top=1437 ,right=403 ,bottom=1949 </L>
	<T>id='��   ��' ,left=97 ,top=683 ,right=569 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)��   ��   ó   ��' ,left=97 ,top=741 ,right=569 ,bottom=786 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10)����ڵ�Ϲ�ȣ' ,left=97 ,top=799 ,right=569 ,bottom=844 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)�ٹ��Ⱓ' ,left=97 ,top=857 ,right=569 ,bottom=902 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)����Ⱓ' ,left=97 ,top=915 ,right=569 ,bottom=960 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13)��               ��' ,left=97 ,top=976 ,right=569 ,bottom=1020 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14)��               ��' ,left=97 ,top=1031 ,right=569 ,bottom=1076 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)��   ��   ��   ��' ,left=97 ,top=1092 ,right=569 ,bottom=1136 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-1�ֽĸż����ñ� �������' ,left=97 ,top=1150 ,right=569 ,bottom=1194 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-2�츮�������������' ,left=97 ,top=1208 ,right=569 ,bottom=1252 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-3' ,left=97 ,top=1268 ,right=569 ,bottom=1313 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-4' ,left=97 ,top=1324 ,right=569 ,bottom=1368 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)��' ,left=97 ,top=1382 ,right=569 ,bottom=1426 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-1 �߰��ٷμ���' ,left=97 ,top=1553 ,right=384 ,bottom=1598 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-2 ��꺸������' ,left=97 ,top=1608 ,right=384 ,bottom=1653 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-3 �ܱ��αٷ���' ,left=97 ,top=1664 ,right=384 ,bottom=1709 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-4' ,left=97 ,top=1719 ,right=384 ,bottom=1764 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-5' ,left=97 ,top=1775 ,right=384 ,bottom=1819 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-6' ,left=97 ,top=1833 ,right=384 ,bottom=1877 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)�� ���� �����' ,left=97 ,top=1896 ,right=384 ,bottom=1941 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20)������ҵ� ��' ,left=97 ,top=1964 ,right=569 ,bottom=2009 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)��     ��     ��     ��' ,left=97 ,top=2086 ,right=579 ,bottom=2130 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='67)��  ��  ¡  ��  ��  ��' ,left=97 ,top=2365 ,right=579 ,bottom=2410 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='M01' ,left=408 ,top=1440 ,right=577 ,bottom=1484 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=848, top=1440, right=1072, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1495, right=1072, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1495, right=819, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='M02' ,left=408 ,top=1495 ,right=577 ,bottom=1540 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(150����)' ,left=97 ,top=1495 ,right=400 ,bottom=1540 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(100����)' ,left=97 ,top=1440 ,right=398 ,bottom=1484 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='X01' ,left=408 ,top=1664 ,right=577 ,bottom=1709 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=2297 ,right=1851 ,bottom=2297 </L>
</B>

</R>
</A>












<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
 <R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID='gcds_print1', DetailDataID='gcds_print1', 
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=2650 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=158 ,right=29 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(��2��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=156 ,right=90 ,bottom=2647 </L>
	<L> left=140 ,top=430 ,right=140 ,bottom=2560 </L>
	<T>id='��' ,left=145 ,top=881 ,right=184 ,bottom=910 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1392 ,right=184 ,bottom=1421 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1329 ,right=134 ,bottom=1368 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1160 ,right=84 ,bottom=1200 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1274 ,right=84 ,bottom=1313 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1387 ,right=84 ,bottom=1424 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1484 ,right=84 ,bottom=1521 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1606 ,right=84 ,bottom=1643 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1392 ,right=134 ,bottom=1432 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1458 ,right=134 ,bottom=1495 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1513 ,right=134 ,bottom=1550 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1564 ,right=134 ,bottom=1603 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1614 ,right=134 ,bottom=1656 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=912 ,right=184 ,bottom=941 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=947 ,right=184 ,bottom=976 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=983 ,right=184 ,bottom=1012 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=671 ,top=158 ,right=671 ,bottom=2650 </L>
	<L> left=1519 ,top=158 ,right=1519 ,bottom=2650 </L>
	<L> left=972 ,top=158 ,right=972 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=243 ,right=972 ,bottom=243 </L>
	<L> left=90 ,top=337 ,right=972 ,bottom=337 </L>
	<L> left=187 ,top=519 ,right=972 ,bottom=519 </L>
	<L> left=90 ,top=430 ,right=972 ,bottom=430 </L>
	<L> left=187 ,top=614 ,right=972 ,bottom=614 </L>
	<L> left=187 ,top=802 ,right=972 ,bottom=802 </L>
	<L> left=187 ,top=891 ,right=972 ,bottom=891 </L>
	<L> left=187 ,top=986 ,right=972 ,bottom=986 </L>
	<L> left=187 ,top=1081 ,right=972 ,bottom=1081 </L>
	<L> left=187 ,top=430 ,right=187 ,bottom=1263 </L>
	<L> left=140 ,top=1263 ,right=1851 ,bottom=1263 </L>
	<L> left=140 ,top=1361 ,right=1851 ,bottom=1361 </L>
	<L> left=187 ,top=1448 ,right=972 ,bottom=1448 </L>
	<L> left=187 ,top=1542 ,right=972 ,bottom=1542 </L>
	<L> left=140 ,top=1632 ,right=972 ,bottom=1632 </L>
	<L> left=187 ,top=1724 ,right=972 ,bottom=1724 </L>
	<L> left=187 ,top=1912 ,right=972 ,bottom=1912 </L>
	<L> left=187 ,top=2001 ,right=972 ,bottom=2001 </L>
	<L> left=187 ,top=2094 ,right=972 ,bottom=2094 </L>
	<L> left=187 ,top=2188 ,right=972 ,bottom=2188 </L>
	<L> left=187 ,top=2283 ,right=972 ,bottom=2283 </L>
	<L> left=187 ,top=2365 ,right=972 ,bottom=2365 </L>
	<L> left=187 ,top=2465 ,right=972 ,bottom=2465 </L>
	<L> left=187 ,top=1361 ,right=187 ,bottom=2563 </L>
	<L> left=1019 ,top=1361 ,right=1019 ,bottom=2563 </L>
	<L> left=1019 ,top=156 ,right=1019 ,bottom=1168 </L>
	<L> left=1019 ,top=243 ,right=1848 ,bottom=243 </L>
	<L> left=1019 ,top=337 ,right=1848 ,bottom=337 </L>
	<L> left=1019 ,top=430 ,right=1848 ,bottom=430 </L>
	<L> left=1019 ,top=519 ,right=1848 ,bottom=519 </L>
	<L> left=1019 ,top=614 ,right=1848 ,bottom=614 </L>
	<L> left=1019 ,top=707 ,right=1848 ,bottom=707 </L>
	<L> left=1019 ,top=802 ,right=1848 ,bottom=802 </L>
	<L> left=1019 ,top=891 ,right=1848 ,bottom=891 </L>
	<L> left=1019 ,top=986 ,right=1848 ,bottom=986 </L>
	<L> left=1019 ,top=1081 ,right=1848 ,bottom=1081 </L>
	<L> left=1019 ,top=1448 ,right=1848 ,bottom=1448 </L>
	<L> left=1019 ,top=1542 ,right=1848 ,bottom=1542 </L>
	<L> left=1019 ,top=1632 ,right=1848 ,bottom=1632 </L>
	<L> left=1019 ,top=1724 ,right=1848 ,bottom=1724 </L>
	<L> left=1019 ,top=1912 ,right=1848 ,bottom=1912 </L>
	<L> left=187 ,top=1811 ,right=1851 ,bottom=1811 </L>
	<L> left=1019 ,top=2001 ,right=1848 ,bottom=2001 </L>
	<L> left=1019 ,top=2094 ,right=1848 ,bottom=2094 </L>
	<L> left=1019 ,top=2188 ,right=1848 ,bottom=2188 </L>
	<L> left=1019 ,top=2283 ,right=1848 ,bottom=2283 </L>
	<L> left=1019 ,top=2365 ,right=1848 ,bottom=2365 </L>
	<L> left=1019 ,top=2465 ,right=1848 ,bottom=2465 </L>
	<L> left=90 ,top=2563 ,right=1851 ,bottom=2563 </L>
	<L> left=190 ,top=1168 ,right=1851 ,bottom=1168 </L>
	<L> left=140 ,top=707 ,right=972 ,bottom=707 </L>
	<T>id='42)�� �� �� �� �� ��' ,left=95 ,top=2573 ,right=577 ,bottom=2634 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)�� �� ��(16) �Ǵ� 16)- 18)-3)' ,left=97 ,top=169 ,right=663 ,bottom=229 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)�ٷμҵ����' ,left=97 ,top=261 ,right=663 ,bottom=322 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50)���ռҵ� ����ǥ��' ,left=979 ,top=1192 ,right=1459 ,bottom=1252 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB10000,0,,PB10000)}', left=679, top=169, right=964, bottom=229, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='43)���ο�������ҵ����' ,left=1029 ,top=169 ,right=1509 ,bottom=229 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT011S,0,,ETCAMT011S)}', left=1543, top=169, right=1825, bottom=229, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB20000,0,,PB20000)}', left=679, top=261, right=964, bottom=322, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)��������ҵ����' ,left=1029 ,top=261 ,right=1509 ,bottom=322 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT01S,0,,ETCAMT01S)}', left=1543, top=261, right=1825, bottom=322, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='23)�ٷμҵ�ݾ�' ,left=97 ,top=356 ,right=663 ,bottom=417 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB30000,0,,PB30000)}', left=679, top=356, right=964, bottom=417, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-1�ұ�����һ���� �����α� �ҵ����' ,left=1029 ,top=356 ,right=1509 ,bottom=417 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1543, top=356, right=1825, bottom=417, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='24)��         ��' ,left=205 ,top=446 ,right=490 ,bottom=506 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)��   ��   ��' ,left=205 ,top=541 ,right=500 ,bottom=601 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)�ξ簡��(' ,left=205 ,top=630 ,right=392 ,bottom=691 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)��ο��(' ,left=205 ,top=725 ,right=392 ,bottom=786 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)�� �� �� (' ,left=205 ,top=817 ,right=392 ,bottom=878 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)��   ��   ��' ,left=205 ,top=907 ,right=500 ,bottom=968 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)�ڳ������(' ,left=205 ,top=1002 ,right=421 ,bottom=1063 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=679, top=446, right=964, bottom=506, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-2���ø������� �ҵ����' ,left=1029 ,top=446 ,right=1509 ,bottom=506 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HOUAMT01S,0,,HOUAMT01S)}', left=1543, top=446, right=1825, bottom=506, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=679, top=541, right=964, bottom=601, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='45)�����������ڵ�ҵ����' ,left=1029 ,top=541 ,right=1509 ,bottom=601 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT02S,0,,ETCAMT02S)}', left=1543, top=541, right=1825, bottom=601, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BA0101CNT,0,,BA0101CNT)}', left=395, top=630, right=458, bottom=691 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=630 ,right=516 ,bottom=691 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=679, top=630, right=964, bottom=691, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='46)�ſ�ī���ҵ����' ,left=1029 ,top=630 ,right=1509 ,bottom=691 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT03S,0,,ETCAMT03S)}', left=1543, top=630, right=1825, bottom=691, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TOTCNT02,0,,TOTCNT02)}', left=395, top=725, right=455, bottom=786 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=725 ,right=516 ,bottom=786 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=679, top=725, right=964, bottom=786, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='47)�츮�������ռҵ����' ,left=1029 ,top=725 ,right=1509 ,bottom=786 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT04S,0,,ETCAMT04S)}', left=1543, top=725, right=1825, bottom=786, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0103CNT,0,,AD0103CNT)}', left=395, top=817, right=455, bottom=878 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=817 ,right=516 ,bottom=878 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=679, top=817, right=964, bottom=878, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='48)����ֽ�������ҵ����' ,left=1029 ,top=817 ,right=1509 ,bottom=878 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(FNDSUMS,0,,FNDSUMS)}', left=1543, top=817, right=1825, bottom=878, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=679, top=907, right=964, bottom=968, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0105CNT,0,,AD0105CNT)}', left=427, top=1002, right=469, bottom=1063 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=471 ,top=1002 ,right=519 ,bottom=1063 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=679, top=1002, right=964, bottom=1063, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT07,0,,ADAMT07)}', left=679, top=1094, right=964, bottom=1155, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1543, top=1094, right=1825, bottom=1155, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='49)�� ���� �ҵ���� ��' ,left=1029 ,top=1094 ,right=1509 ,bottom=1155 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TSTDSUM,0,,TSTDSUM)}', left=1543, top=1192, right=1825, bottom=1252, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='31)���ڳ��߰�����(' ,left=153 ,top=1281 ,right=445 ,bottom=1342 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0106CNT,0,,AD0106CNT)}', left=453, top=1281, right=513, bottom=1342 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=516 ,top=1281 ,right=571 ,bottom=1342 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)���ο��ݺ�������' ,left=200 ,top=1376 ,right=529 ,bottom=1437 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1��Ÿ ���ݺ�������' ,left=197 ,top=1466 ,right=577 ,bottom=1527 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)�������ݼҵ����' ,left=200 ,top=1558 ,right=524 ,bottom=1619 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)��   ��   ��' ,left=200 ,top=1648 ,right=521 ,bottom=1709 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)��   ��   ��' ,left=205 ,top=1835 ,right=527 ,bottom=1896 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)�����������Աݿ����ݻ�ȯ��' ,left=200 ,top=1930 ,right=616 ,bottom=1991 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)-1��������������Ա����ڻ�ȯ��' ,left=200 ,top=2020 ,right=666 ,bottom=2080 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)��α�' ,left=200 ,top=2115 ,right=521 ,bottom=2175 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)' ,left=197 ,top=2207 ,right=519 ,bottom=2268 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)      ��' ,left=200 ,top=2384 ,right=521 ,bottom=2444 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)ǥ �� �� ��' ,left=200 ,top=2481 ,right=521 ,bottom=2542 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT05S,0,,ADAMT05S)}', left=679, top=1281, right=964, bottom=1342, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='51)��     ��     ��     ��' ,left=979 ,top=1281 ,right=1459 ,bottom=1342 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDTAX,0,,STDTAX)}', left=1543, top=1281, right=1825, bottom=1342, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUMS,0,,PENSUMS)}', left=679, top=1376, right=964, bottom=1437, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='52)[��   ��   ��   ��]' ,left=1029 ,top=1376 ,right=1509 ,bottom=1437 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT01S,0,,REDAMT01S)}', left=1543, top=1376, right=1825, bottom=1437, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='53)[����Ư�����ѹ�]' ,left=1029 ,top=1466 ,right=1509 ,bottom=1527 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT02S,0,,REDAMT02S)}', left=1543, top=1466, right=1825, bottom=1527, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT05,0,,ETCAMT05)}', left=679, top=1558, right=964, bottom=1619, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='54)' ,left=1029 ,top=1558 ,right=1509 ,bottom=1619 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=679, top=1648, right=964, bottom=1709, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='35)��   ��   ��' ,left=203 ,top=1738 ,right=524 ,bottom=1798 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=679, top=1738, right=964, bottom=1798, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='55)���װ��� ��' ,left=1029 ,top=1738 ,right=1509 ,bottom=1798 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDSUM,0,,REDSUM)}', left=1543, top=1738, right=1825, bottom=1798, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=679, top=1466, right=961, bottom=1527, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='56)��  ��   ��  ��' ,left=1029 ,top=1835 ,right=1509 ,bottom=1896 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)�������հ���' ,left=1029 ,top=1930 ,right=1509 ,bottom=1991 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)�� �� �� �� ��' ,left=1029 ,top=2020 ,right=1509 ,bottom=2080 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)��� ��ġ�ڱ�' ,left=1029 ,top=2115 ,right=1509 ,bottom=2175 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT01S,0,,DEDAMT01S)}', left=1543, top=1835, right=1825, bottom=1896, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02S,0,,DEDAMT02S)}', left=1543, top=1930, right=1825, bottom=1991, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03S,0,,DEDAMT03S)}', left=1543, top=2020, right=1825, bottom=2080, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04S,0,,DEDAMT04S)}', left=1543, top=2115, right=1825, bottom=2175, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='60)��  ��   ��  ��' ,left=1029 ,top=2207 ,right=1509 ,bottom=2268 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT05S,0,,DEDAMT05S)}', left=1543, top=2207, right=1825, bottom=2268, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=679, top=1835, right=964, bottom=1896, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02S,0,,HOUAMT02S)}', left=679, top=1930, right=964, bottom=1991, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT34S,0,,HOUAMT34S)}', left=679, top=2020, right=964, bottom=2080, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONSUM,0,,CONSUM)}', left=679, top=2115, right=964, bottom=2175, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=679, top=2384, right=964, bottom=2444, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='62)' ,left=1029 ,top=2384 ,right=1509 ,bottom=2444 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1029 ,top=2297 ,right=1509 ,bottom=2357 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=679, top=2481, right=964, bottom=2542, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='63)�� �� �� �� ��' ,left=1029 ,top=2481 ,right=1509 ,bottom=2542 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1543, top=2481, right=1825, bottom=2542, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=679, top=2573, right=964, bottom=2634, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� �� ��[51)-55)-63)]' ,left=979 ,top=2573 ,right=1459 ,bottom=2634 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(RESSUM,0,,RESSUM)}', left=1543, top=2573, right=1825, bottom=2634, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=977 ,top=454 ,right=1016 ,bottom=493 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1421 ,right=184 ,bottom=1450 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1450 ,right=184 ,bottom=1479 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1471 ,right=184 ,bottom=1508 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1503 ,right=184 ,bottom=1535 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1532 ,right=184 ,bottom=1564 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1564 ,right=184 ,bottom=1595 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1484 ,right=1016 ,bottom=1521 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1535 ,right=1016 ,bottom=1571 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1587 ,right=1016 ,bottom=1627 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1645 ,right=1016 ,bottom=1687 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2070 ,right=1016 ,bottom=2107 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2130 ,right=1016 ,bottom=2167 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2194 ,right=1016 ,bottom=2233 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2257 ,right=1016 ,bottom=2299 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=145 ,top=1941 ,right=184 ,bottom=1999 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2030 ,right=184 ,bottom=2088 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2123 ,right=184 ,bottom=2183 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2225 ,right=184 ,bottom=2286 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=501 ,right=184 ,bottom=530 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=530 ,right=184 ,bottom=559 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=559 ,right=184 ,bottom=588 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=588 ,right=184 ,bottom=617 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=559 ,right=1016 ,bottom=599 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=614 ,right=1016 ,bottom=651 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=691 ,right=1016 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=736 ,right=1016 ,bottom=773 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=783 ,right=1016 ,bottom=823 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=831 ,right=1016 ,bottom=873 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)-1��������߼ұ���ٷ��ڼҵ����' ,left=1029 ,top=907 ,right=1516 ,bottom=968 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0107CNT,0,,AD0107CNT)}', left=487, top=1094, right=532, bottom=1155 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=532 ,top=1094 ,right=574 ,bottom=1155 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)-1�����Ծ���(' ,left=205 ,top=1094 ,right=484 ,bottom=1155 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='3��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print1'
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=614 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��)' ,left=305 ,top=562 ,right=358 ,bottom=606 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='68)�ҵ���� ��(���������׸��� �ش���� O ǥ�ø� �ϸ�, ���� �ҵ���� �׸��� ������ ���Ͽ� ���� ������ �ݾ��� �����ϴ�)' ,left=71 ,top=87 ,right=1888 ,bottom=148 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=69 ,right=1901 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='������' ,left=71 ,top=324 ,right=147 ,bottom=369 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�' ,left=71 ,top=208 ,right=147 ,bottom=253 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=158 ,top=166 ,right=427 ,bottom=253 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=166 ,right=147 ,bottom=208 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=153 ,top=161 ,right=153 ,bottom=488 </L>
	<T>id='�������� �׸�' ,left=103 ,top=493 ,right=374 ,bottom=538 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���ڳ�' ,left=103 ,top=562 ,right=224 ,bottom=606 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=359 ,right=147 ,bottom=403 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��         ȣ' ,left=158 ,top=359 ,right=429 ,bottom=403 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� ��' ,left=158 ,top=324 ,right=429 ,bottom=369 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻' ,left=434 ,top=277 ,right=498 ,bottom=322 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=322 ,right=498 ,bottom=364 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�γ�' ,left=434 ,top=377 ,right=498 ,bottom=414 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=434 ,top=409 ,right=498 ,bottom=446 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=440 ,right=498 ,bottom=477 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=369 ,right=498 ,bottom=369 </L>
	<T>id='���' ,left=505 ,top=306 ,right=569 ,bottom=351 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=505 ,top=343 ,right=569 ,bottom=388 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=505 ,top=380 ,right=569 ,bottom=422 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=577 ,top=411 ,right=640 ,bottom=456 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=382 ,right=640 ,bottom=419 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ծ�' ,left=577 ,top=343 ,right=640 ,bottom=388 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=327 ,right=640 ,bottom=348 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=577 ,top=293 ,right=640 ,bottom=337 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=648 ,top=301 ,right=711 ,bottom=345 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=648 ,top=337 ,right=711 ,bottom=374 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=648 ,top=372 ,right=711 ,bottom=417 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڳ�' ,left=719 ,top=287 ,right=782 ,bottom=332 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=322 ,right=782 ,bottom=367 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=719 ,top=359 ,right=782 ,bottom=396 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=390 ,right=782 ,bottom=435 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=161 ,right=429 ,bottom=609 </L>
	<L> left=571 ,top=256 ,right=571 ,bottom=609 </L>
	<L> left=642 ,top=256 ,right=642 ,bottom=609 </L>
	<L> left=713 ,top=256 ,right=713 ,bottom=609 </L>
	<T>id='�������� �׸�' ,left=434 ,top=166 ,right=782 ,bottom=253 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=543 ,right=498 ,bottom=543 </L>
	<L> left=895 ,top=161 ,right=895 ,bottom=609 </L>
	<T>id='���� �ҵ���� �׸�' ,left=900 ,top=166 ,right=1898 ,bottom=253 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=932 ,top=290 ,right=1037 ,bottom=335 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ǰ������' ,left=898 ,top=332 ,right=1069 ,bottom=377 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����)' ,left=898 ,top=369 ,right=1069 ,bottom=414 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ��' ,left=1077 ,top=264 ,right=1232 ,bottom=480 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1243 ,top=261 ,right=1398 ,bottom=477 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1738 ,top=261 ,right=1898 ,bottom=477 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1732 ,top=256 ,right=1732 ,bottom=609 </L>
	<L> left=1403 ,top=256 ,right=1403 ,bottom=609 </L>
	<L> left=1237 ,top=256 ,right=1237 ,bottom=609 </L>
	<L> left=1072 ,top=256 ,right=1072 ,bottom=609 </L>


	<C>id='{decode(TREF11,0,,TREF11)}', left=898, top=498, right=1069, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=1077, top=498, right=1232, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1243, top=498, right=1398, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF14,0,,TREF14)}', left=1411, top=498, right=1567, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1577, top=498, right=1727, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1738, top=498, right=1898, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='{decode(TREF21,0,,TREF21)}', left=898, top=554, right=1069, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=1077, top=554, right=1232, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1243, top=554, right=1398, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1411, top=554, right=1567, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF25,0,,TREF25)}', left=1590, top=554, right=1706, bottom=601, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1738, top=554, right=1898, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>

	<L> left=893 ,top=256 ,right=1901 ,bottom=256 </L>
	<T>id='�ڷ�' ,left=795 ,top=293 ,right=893 ,bottom=337 ,supplevel=1 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=795 ,top=335 ,right=893 ,bottom=372 ,supplevel=1 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=795 ,top=496 ,right=893 ,bottom=543 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=554 ,right=893 ,bottom=601 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=790 ,top=161 ,right=790 ,bottom=609 </L>
	<L> left=61 ,top=161 ,right=1901 ,bottom=161 </L>
	<L> left=61 ,top=483 ,right=1901 ,bottom=483 </L>
	<L> left=61 ,top=488 ,right=1901 ,bottom=488 </L>
	<L> left=790 ,top=548 ,right=898 ,bottom=548 </L>
	<L> left=58 ,top=256 ,right=790 ,bottom=256 </L>
	<L> left=61 ,top=604 ,right=1901 ,bottom=604 </L>
	<L> left=58 ,top=69 ,right=58 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1901 ,top=69 ,right=1901 ,bottom=612 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=898 ,top=548 ,right=1901 ,bottom=548 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=500 ,top=256 ,right=500 ,bottom=609 </L>
	<L> left=61 ,top=609 ,right=1901 ,bottom=609 </L>
	<X>left=1572 ,top=551 ,right=1732 ,bottom=604 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1403 ,top=374 ,right=1732 ,bottom=374 </L>
	<L> left=895 ,top=256 ,right=1901 ,bottom=256 </L>
	<L> left=1572 ,top=374 ,right=1572 ,bottom=609 </L>
	<T>id='�ſ�ī�� ��' ,left=1477 ,top=264 ,right=1667 ,bottom=332 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=1477 ,top=314 ,right=1667 ,bottom=356 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī�� ��' ,left=1409 ,top=401 ,right=1564 ,bottom=435 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ī�� ��' ,left=1409 ,top=432 ,right=1569 ,bottom=467 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1577 ,top=432 ,right=1727 ,bottom=467 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1577 ,top=401 ,right=1727 ,bottom=435 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ϴ� �ο����� ����' ,left=63 ,top=527 ,right=427 ,bottom=564 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��3��)' ,left=1622 ,top=8 ,right=1877 ,bottom=61 ,align='right' ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AD0106CNT', left=226, top=562, right=305, bottom=606, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=105 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=105 ,right=1901 ,bottom=105 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=153 ,top=3 ,right=153 ,bottom=105 </L>
	<C>id='RESINO1', left=158, top=58, right=427, bottom=103 ,mask='XXXXXX-XXXXXXX', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=158, top=5, right=427, bottom=50, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=429 ,top=0 ,right=429 ,bottom=103 </L>
	<C>id='{decode(REF1,T,��,T,��,)}', left=74, top=58, right=147, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1', left=74, top=5, right=147, bottom=50, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2', left=434, top=5, right=498, bottom=50, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=434, top=58, right=498, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=500 ,top=0 ,right=500 ,bottom=103 </L>
	<C>id='REF5', left=505, top=8, right=569, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=571 ,top=0 ,right=571 ,bottom=103 </L>
	<C>id='REF8', left=577, top=8, right=640, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=642 ,top=0 ,right=642 ,bottom=103 </L>
	<C>id='REF3', left=648, top=8, right=711, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=713 ,top=0 ,right=713 ,bottom=103 </L>
	<L> left=429 ,top=53 ,right=63 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=895 ,top=0 ,right=895 ,bottom=103 </L>
	<L> left=1072 ,top=0 ,right=1072 ,bottom=103 </L>
	<L> left=1237 ,top=0 ,right=1237 ,bottom=103 </L>
	<L> left=1403 ,top=0 ,right=1403 ,bottom=103 </L>
	<L> left=1732 ,top=0 ,right=1732 ,bottom=103 </L>
	<C>id='{decode(REF21,0,,REF21)}', left=898, top=58, right=1069, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=1077, top=58, right=1232, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1243, top=58, right=1398, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1411, top=58, right=1567, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1738, top=58, right=1898, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11,0,,REF11)}', left=898, top=8, right=1069, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=1077, top=8, right=1232, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1243, top=8, right=1398, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1411, top=8, right=1567, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25,0,,REF25)}', left=1601, top=58, right=1706, bottom=103, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1738, top=8, right=1898, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1577, top=8, right=1727, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=795 ,top=8 ,right=893 ,bottom=53 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=58 ,right=893 ,bottom=103 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=898 ,top=53 ,right=1901 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=790 ,top=3 ,right=790 ,bottom=105 </L>
	<C>id='REF4', left=719, top=8, right=782, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=432 ,top=53 ,right=500 ,bottom=53 </L>
	<L> left=790 ,top=53 ,right=903 ,bottom=53 </L>
	<L> left=1572 ,top=0 ,right=1572 ,bottom=103 </L>
	<X>left=1572 ,top=55 ,right=1732 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2001 ,bottom=967 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�� �ۼ����' ,left=74 ,top=13 ,right=279 ,bottom=58 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     (* ISO�����ڵ� : ����ûȨ������->��������->������������->���������ڷ�ǿ��� ��ȸ �� �� �ֽ��ϴ�. ��) ���ѹα�: KR, �̱� : US' ,left=71 ,top=98 ,right=1888 ,bottom=137 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ���� ���޸����� �����Ͽ��� �մϴ�.' ,left=71 ,top=171 ,right=1888 ,bottom=211 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. ��õ¡���ǹ��ڴ� �������� ���ϴ� ������ ���� ���� 3�� 10��(�޾� �Ǵ� ����� ��쿡�� �޾��� �Ǵ� ������� ���ϴ� ���� ���� ���� �� ������ ���մϴ�)' ,left=71 ,top=134 ,right=1888 ,bottom=174 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=61 ,top=965 ,right=1906 ,bottom=965 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='  3. ���ٹ�ó���ҵ������ ������ҵ�(�ܱ��αٷ��� 30% ����� ����)�� ������ �ݾ��� ����, ��.������ҵ������ ���޸��� �ۼ���� ������ҵ��� ������ҵ���' ,left=71 ,top=208 ,right=1888 ,bottom=248 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. �����ٷμҵ�� �����ٷμҵ��� ���Ͽ� ���������ϴ� ������ 16)-1 �������ն��� ���� �����ٷμҵ泳�����հ� �����ٷμҵ���  ����, [�ҵ漼�� �����] ' ,left=71 ,top=279 ,right=1888 ,bottom=319 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ��150���� ���� �������հ����ݾ��� 57)�������հ������� �����ϴ�. �պ�, ������� ���� ������ �ش� ������ ���������� �ϴ� ��쿡 ���պ�����, ' ,left=71 ,top=316 ,right=1888 ,bottom=359 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ������º������� �ҵ��� �ٹ�ó���ҵ�� ��(��)���� ������ �����ϴ�.' ,left=71 ,top=353 ,right=1888 ,bottom=396 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 18-3���� �ܱ��αٷ��ڰ� [����Ư�����ѹ�] �� 18����2��1���� �����ϴ� ��쿡�� ������, 16)����� �ݾ׿� 100���� 30�� ���� �ݾ��� �����ϴ�.' ,left=71 ,top=390 ,right=1888 ,bottom=432 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 21)�ѱ޿������� 16)����� �ݾ��� ����, 18)-3���� �ݾ��� �ִ� ��쿡�� 16)����� �ݾ׿��� 18)-3���� �ݾ��� �� �ݾ��� ������, �ܱ��αٷ��ڰ� ' ,left=71 ,top=427 ,right=1888 ,bottom=469 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    [����Ư�����ѹ�] ��18����2��2�׿� ���� ���ϼ����� �����ϴ� ��쿡�� 16)���� �ݾְ� ������ҵ�ݾ��� ���� �ݾ��� ����, �ҵ漼�� ������ ����� .����.����' ,left=71 ,top=464 ,right=1888 ,bottom=506 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �� ���װ����� ���� ������ �������� �ʽ��ϴ�.' ,left=71 ,top=501 ,right=1888 ,bottom=543 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. ���ռҵ� Ư������[34) ~ 39)]���� �� ���� �ҵ����[43)~47)]���� ���� ��37ȣ������ �������� �����ϴ�.' ,left=71 ,top=541 ,right=1888 ,bottom=580 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. �� ���Ŀ� ���� �ݾ� �� �Ҽ��� ���� ���� ������, 67) ����¡�������� �Ҿ׺�¡��(1õ�� �̸��� ���մϴ�)�� �ش��ϴ� ��� ������ 0 ���� �����ϴ�.' ,left=71 ,top=577 ,right=1888 ,bottom=617 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68) �ҵ���� ������ 2006�� ���� �߻��ϴ� �ٷμҵ� ��������к��� ����մϴ�.' ,left=71 ,top=614 ,right=1888 ,bottom=654 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �����ڵ�� : �ҵ��� ����=0, �ҵ����� ��������=1, ������� ��������=2, �����=3, ������ �ڳ�=4, ������ �ڳ� �� = 5 �����ڸ�=6, ��Ÿ=7�� �����ϴ�' ,left=71 ,top=654 ,right=1888 ,bottom=693 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='           (4��5��6��7�� ��� �ҵ��ڿ� ������� ������ ���踦 �����մϴ�). ' ,left=71 ,top=691 ,right=1888 ,bottom=730 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ��.�ܱ��ζ� : �������� ��� 1 ��, �ܱ����� ��� 9 �� �����ϴ�.' ,left=71 ,top=728 ,right=1888 ,bottom=767 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���������׸�� : �������������� �ִ� ��� �ش���� O ǥ�ø� �մϴ�(�ش������ ���� ��� ����Ӵϴ�).' ,left=71 ,top=765 ,right=1888 ,bottom=804 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ����û �ڷ�� : [�ҵ漼��] ��165���� ���� ����û Ȩ���������� �����ϴ� �� �ҵ���� �׸��� �ݾ� �� �ҵ��������� �Ǵ� �ݾ���  �����ϴ�.' ,left=71 ,top=802 ,right=1888 ,bottom=841 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �� ���� �ڷ�� : ����û���� �����ϴ� �������� ���� ���� ���մϴ�.(���� ���, �п��� ���γ��ο������� �ſ�ī�� �� ����, �÷±����� �Ȱ汸�Ժ�� ' ,left=71 ,top=838 ,right=1888 ,bottom=878 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='        �Ƿ����� ���� �����ϴ�).' ,left=71 ,top=875 ,right=1888 ,bottom=915 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���� �ҵ���� �׸�� : �ҵ�����׸� �ش��ϴ� ���� ����ݾ��� �����ϴ�(�ҵ�������� �ƴ� ���� ���ݾ��� �����׸񺰷� ���е� ���� �ȿ� �����ϴ�).' ,left=71 ,top=912 ,right=1888 ,bottom=952 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �ش� �ڵ庰�� �����Ͽ� �����ϴ�. (������׸��� ���� ��� ��.����� �ҵ���� 20)������ҵ� ����� �Ѿ׸� ���� ��.����� �ҵ���� ������ �ۼ� �����մϴ�.)' ,left=71 ,top=240 ,right=1888 ,bottom=279 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. ���������� ���������ڵ�� ������ڿ� �ش��ϴ� ��쿡 ���Ͽ� ������, ����ǥ��ȭ�ⱸ(ISO)�� ���� ISO�ڵ� �� ������ �� �����ڵ带 �����ϴ�.' ,left=79 ,top=61 ,right=1896 ,bottom=100 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
	">
</object></comment><script>__ws__(__NSID__);</script>
















<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ� ���� : �ٷμҵ��õ¡�������� REPORT
--------------------------------------------------------------------------------------->

<comment id="__NSID__">
<object id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_print"> 
	<PARAM NAME="DetailDataID"				VALUE="gcds_print"> 
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="False">
	<PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="150">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='4��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2750 ,face='Arial' ,size=10 ,penwidth=1


<L> left=29 ,top=2659 ,right=1860 ,bottom=2659 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=29 ,top=381 ,right=1860 ,bottom=381 </L>
<L> left=193 ,top=185 ,right=193 ,bottom=275 </L>
<L> left=29 ,top=2426 ,right=1860 ,bottom=2426 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=29 ,top=675 ,right=1860 ,bottom=675 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=214 ,top=497 ,right=1860 ,bottom=497 </L>
<L> left=1000 ,top=381 ,right=1000 ,bottom=497 </L>
<L> left=1371 ,top=381 ,right=1371 ,bottom=497 </L>
<L> left=29 ,top=556 ,right=1860 ,bottom=556 </L>
<L> left=1003 ,top=556 ,right=1003 ,bottom=616 </L>
<L> left=1371 ,top=556 ,right=1371 ,bottom=616 </L>
<L> left=402 ,top=2140 ,right=402 ,bottom=2305 </L>

<L> left=850 ,top=677 ,right=850 ,bottom=2024 </L>

<L> left=1120 ,top=677 ,right=1120 ,bottom=2024 </L>
<L> left=1598 ,top=677 ,right=1598 ,bottom=2024 </L>

<L> left=193 ,top=2140 ,right=193 ,bottom=2360 </L>
<L> left=590 ,top=381 ,right=590 ,bottom=2024 </L>
<L> left=214 ,top=381 ,right=214 ,bottom=672 </L>
<L> left=214 ,top=616 ,right=1860 ,bottom=616 </L>
<L> left=500 ,top=2140 ,right=500 ,bottom=2305 </L>
<L> left=500 ,top=2249 ,right=1860 ,bottom=2249 </L>
<L> left=500 ,top=2193 ,right=1860 ,bottom=2193 </L>
<L> left=214 ,top=439 ,right=1860 ,bottom=439 </L>
<L> left=691 ,top=2021 ,right=691 ,bottom=2426 </L>
<L> left=93 ,top=736 ,right=1860 ,bottom=736 </L>
<L> left=93 ,top=794 ,right=1860 ,bottom=794 </L>
<L> left=93 ,top=855 ,right=1860 ,bottom=855 </L>
<L> left=93 ,top=910 ,right=1860 ,bottom=910 </L>
<L> left=93 ,top=1376 ,right=1860 ,bottom=1376 </L>
<L> left=93 ,top=1320 ,right=1860 ,bottom=1320 </L>
<L> left=93 ,top=1262 ,right=1860 ,bottom=1262 </L>
<L> left=93 ,top=1204 ,right=1860 ,bottom=1204 </L>
<L> left=93 ,top=1146 ,right=1860 ,bottom=1146 </L>
<L> left=93 ,top=1085 ,right=1860 ,bottom=1085 </L>
<L> left=93 ,top=1029 ,right=1860 ,bottom=1029 </L>
<L> left=93 ,top=971 ,right=1860 ,bottom=971 </L>
<L> left=93 ,top=1495 ,right=1860 ,bottom=1495 </L>
<L> left=93 ,top=1550 ,right=1860 ,bottom=1550 </L>
<L> left=93 ,top=1606 ,right=1860 ,bottom=1606 </L>
<L> left=93 ,top=1662 ,right=1860 ,bottom=1662 </L>
<L> left=93 ,top=1717 ,right=1860 ,bottom=1717 </L>
<L> left=93 ,top=1773 ,right=1860 ,bottom=1773 </L>
<L> left=93 ,top=1828 ,right=1860 ,bottom=1828 </L>
<L> left=93 ,top=1889 ,right=1860 ,bottom=1889 </L>
<L> left=93 ,top=1955 ,right=1860 ,bottom=1955 </L>
<L> left=93 ,top=2363 ,right=1860 ,bottom=2363 </L>
<L> left=93 ,top=2140 ,right=1860 ,bottom=2140 </L>
<L> left=93 ,top=2085 ,right=1860 ,bottom=2085 </L>
<L> left=982 ,top=2021 ,right=982 ,bottom=2426 </L>
<L> left=1273 ,top=2021 ,right=1273 ,bottom=2426 </L>
<L> left=1564 ,top=2021 ,right=1564 ,bottom=2426 </L>
<L> left=29 ,top=2021 ,right=1860 ,bottom=2021 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=90 ,top=675 ,right=90 ,bottom=2424 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=1347 ,top=677 ,right=1347 ,bottom=2024 </L>
<L> left=29 ,top=1437 ,right=1860 ,bottom=1437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=193 ,top=2305 ,right=1860 ,bottom=2305 </L>
<L> left=1299 ,top=93 ,right=1839 ,bottom=93 </L>
<L> left=1299 ,top=167 ,right=1839 ,bottom=167 </L>
<L> left=1299 ,top=93 ,right=1299 ,bottom=357 </L>
<L> left=1299 ,top=130 ,right=1839 ,bottom=130 </L>
<L> left=1299 ,top=204 ,right=1839 ,bottom=204 </L>
<L> left=1299 ,top=243 ,right=1839 ,bottom=243 </L>
<L> left=1299 ,top=280 ,right=1839 ,bottom=280 </L>
<L> left=1299 ,top=318 ,right=1839 ,bottom=318 </L>
<L> left=1839 ,top=93 ,right=1839 ,bottom=357 </L>
<L> left=1299 ,top=357 ,right=1839 ,bottom=357 </L>
<L> left=1431 ,top=130 ,right=1431 ,bottom=167 </L>
<L> left=1529 ,top=93 ,right=1529 ,bottom=204 </L>
<L> left=1722 ,top=130 ,right=1722 ,bottom=167 </L>
<L> left=1437 ,top=243 ,right=1437 ,bottom=280 </L>
<L> left=1529 ,top=243 ,right=1529 ,bottom=357 </L>
<L> left=1860 ,top=77 ,right=1860 ,bottom=2656 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=29 ,top=77 ,right=1860 ,bottom=77 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=29 ,top=77 ,right=29 ,bottom=2656 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=405 ,top=1437 ,right=405 ,bottom=1889 </L>
<L> left=1696 ,top=244 ,right=1696 ,bottom=281 </L>


<X>left=66 ,top=185 ,right=397 ,bottom=275 ,border=true</X>
<X>left=553 ,top=243 ,right=582 ,bottom=278 ,border=true</X>
<X>left=553 ,top=193 ,right=582 ,bottom=228 ,border=true</X>


<T>id='210��x297��(�Ϲݿ��� 60g/��)' ,left=1212 ,top=2672 ,right=1857 ,bottom=2715 ,align='right' </T>
<T>id='�ٷμҵ� ���޸���' ,left=601 ,top=241 ,right=1222 ,bottom=288 ,align='left'  ,size=10 ,bold=true  ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='�ٷμҵ��õ¡��������' ,left=601 ,top=188 ,right=1222 ,bottom=235 ,align='left'  ,size=10 ,bold=true  ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='����' ,left=71 ,top=191 ,right=185 ,bottom=230  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��ȣ' ,left=71 ,top=233 ,right=185 ,bottom=270  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='2010 -' ,left=206 ,top=191 ,right=323 ,bottom=270  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='(���� �Ǵ� ��)' ,left=1490 ,top=2559 ,right=1757 ,bottom=2593 ,align='right'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='�켺��' ,left=222 ,top=566 ,right=511 ,bottom=611 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='�����ڵ�Ϲ�ȣ' ,left=222 ,top=447 ,right=511 ,bottom=492 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='���ּ�' ,left=222 ,top=622 ,right=511 ,bottom=667 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��� ǥ �� (��     ��)' ,left=1019 ,top=389 ,right=1363 ,bottom=434 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='�� �� ��' ,left=1392 ,top=389 ,right=1712 ,bottom=434 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='���� �� �� �� �� ȣ' ,left=1019 ,top=447 ,right=1363 ,bottom=492 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='140111-0011714' ,left=1392 ,top=447 ,right=1712 ,bottom=492 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='���� �� �� ��  �� ȣ' ,left=1019 ,top=566 ,right=1363 ,bottom=611 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��� �� �� (�� ȣ)' ,left=222 ,top=389 ,right=511 ,bottom=434 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='�ǹ���' ,left=37 ,top=471 ,right=209 ,bottom=516  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='¡   ��' ,left=37 ,top=415 ,right=209 ,bottom=460  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='�ҵ���' ,left=37 ,top=566 ,right=209 ,bottom=654  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��(��)' ,left=598 ,top=685 ,right=823 ,bottom=730  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=868 ,right=87 ,bottom=908  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=915 ,right=87 ,bottom=955  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=960 ,right=87 ,bottom=1000  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='ó' ,left=34 ,top=1003 ,right=87 ,bottom=1042  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=1045 ,right=87 ,bottom=1085  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=1132 ,right=87 ,bottom=1172  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=1175 ,right=87 ,bottom=1214  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=1220 ,right=87 ,bottom=1259  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=1087 ,right=87 ,bottom=1127  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��          ��' ,left=101 ,top=2032 ,right=585 ,bottom=2077  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='�ҵ漼' ,left=699 ,top=2032 ,right=979 ,bottom=2077  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='�ֹμ�' ,left=987 ,top=2032 ,right=1267 ,bottom=2077  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='�����Ư����' ,left=1278 ,top=2032 ,right=1558 ,bottom=2077  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=1569 ,top=2032 ,right=1849 ,bottom=2077  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='66)��(��)�ٹ���' ,left=198 ,top=2310 ,right=521 ,bottom=2355 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='' ,left=505 ,top=2254 ,right=688 ,bottom=2299 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=1556 ,right=87 ,bottom=1595  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=1609 ,right=87 ,bottom=1648  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=1667 ,right=87 ,bottom=1707  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=1720 ,right=87 ,bottom=1759  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=1770 ,right=87 ,bottom=1810  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=1820 ,right=87 ,bottom=1860  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=2167 ,right=87 ,bottom=2204  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=2225 ,right=87 ,bottom=2265  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=2281 ,right=87 ,bottom=2318  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��' ,left=34 ,top=2336 ,right=87 ,bottom=2373  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��' ,left=34 ,top=2114 ,right=87 ,bottom=2154  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='Q01' ,left=410 ,top=1556 ,right=579 ,bottom=1601  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='X01' ,left=410 ,top=1611 ,right=579 ,bottom=1656  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='221-81-13834' ,left=595 ,top=447 ,right=889 ,bottom=492 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='������ ���� ������ �ʵ��� 258-2' ,left=595 ,top=503 ,right=1736 ,bottom=548 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='����ƻ�(��)' ,left=595 ,top=389 ,right=889 ,bottom=434 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>

<T>id='����ƻ�(��)' ,left=595 ,top=736 ,right=889 ,bottom=794 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='221-81-13834' ,left=595 ,top=794 ,right=889 ,bottom=855 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>

<T>id='����ƻ�(��)' ,left=1209 ,top=2559 ,right=1442 ,bottom=2593 ,align='right'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='�ⳳ��' ,left=95 ,top=2199 ,right=188 ,bottom=2230  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��   ��' ,left=95 ,top=2236 ,right=185 ,bottom=2267  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='���� ��õ¡����(�ٷμҵ�)�� ����(����)�մϴ�.' ,left=29 ,top=2445 ,right=1860 ,bottom=2484  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��������  ����' ,left=463 ,top=2596 ,right=743 ,bottom=2641 ,align='left'  ,size=10 ,bold=true  ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='¡��(����)�ǹ���' ,left=746 ,top=2559 ,right=1101 ,bottom=2593 ,align='right'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='65)��(��)�ٹ���' ,left=198 ,top=2156 ,right=397 ,bottom=2209  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='(�������׶���' ,left=198 ,top=2196 ,right=400 ,bottom=2252 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='���� ����)' ,left=198 ,top=2244 ,right=397 ,bottom=2289 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��(��)' ,left=852 ,top=685 ,right=1077 ,bottom=730  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��(��)' ,left=1111 ,top=685 ,right=1336 ,bottom=730  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='16)-1��������' ,left=1363 ,top=685 ,right=1588 ,bottom=730  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='��  ��' ,left=1606 ,top=685 ,right=1847 ,bottom=730  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id=' ~' ,left=699 ,top=860 ,right=728 ,bottom=905  ,size=7   ,forecolor=#000000 ,backcolor=#FFFFFF </T>

<T>id='�����' ,left=407 ,top=2162 ,right=497 ,bottom=2207 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='���' ,left=407 ,top=2199 ,right=497 ,bottom=2244  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��ȣ' ,left=407 ,top=2236 ,right=497 ,bottom=2281  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��   ��' ,left=98 ,top=685 ,right=572 ,bottom=730  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='9) ��   ��   ó   ��' ,left=98 ,top=743 ,right=572 ,bottom=788 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='10)����ڵ�Ϲ�ȣ' ,left=98 ,top=802 ,right=572 ,bottom=847 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='11)�ٹ��Ⱓ' ,left=98 ,top=860 ,right=572 ,bottom=905 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='12)����Ⱓ' ,left=98 ,top=918 ,right=572 ,bottom=963 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='13)��               ��' ,left=98 ,top=979 ,right=572 ,bottom=1024 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='14)��               ��' ,left=98 ,top=1035 ,right=572 ,bottom=1080 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='15)��   ��   ��   ��' ,left=98 ,top=1095 ,right=572 ,bottom=1140 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='15)-1�ֽĸż����ñ� �������' ,left=98 ,top=1154 ,right=572 ,bottom=1199 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='15)-2�츮�������������' ,left=98 ,top=1212 ,right=572 ,bottom=1257 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='15)-3' ,left=98 ,top=1273 ,right=572 ,bottom=1318 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='15)-4' ,left=98 ,top=1328 ,right=572 ,bottom=1373 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='16)       ��' ,left=98 ,top=1386 ,right=572 ,bottom=1431 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='18)-2 ��꺸������' ,left=98 ,top=1558 ,right=386 ,bottom=1603 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='18)-3 �ܱ��αٷ���' ,left=98 ,top=1614 ,right=386 ,bottom=1659 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='18)-4' ,left=98 ,top=1670 ,right=386 ,bottom=1715 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='18)-5' ,left=98 ,top=1725 ,right=386 ,bottom=1770 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='18)-20' ,left=98 ,top=1781 ,right=386 ,bottom=1826 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='64)��     ��     ��     ��' ,left=98 ,top=2093 ,right=582 ,bottom=2138 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='67)��  ��  ¡  ��  ��  ��' ,left=98 ,top=2373 ,right=582 ,bottom=2418 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='M01' ,left=410 ,top=1445 ,right=579 ,bottom=1490  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='O01' ,left=410 ,top=1500 ,right=579 ,bottom=1545  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='18)-1 �߰��ٷμ���' ,left=98 ,top=1500 ,right=402 ,bottom=1545 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='18) ���ܱٷ�' ,left=98 ,top=1445 ,right=400 ,bottom=1490 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='(��1��)' ,left=1699 ,top=11 ,right=1857 ,bottom=71 ,align='right'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='[���� ��24ȣ ����(1)]  ' ,left=29 ,top=11 ,right=1445 ,bottom=71 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='���ֱ���' ,left=1310 ,top=95 ,right=1521 ,bottom=127  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='������1 / �������2' ,left=1537 ,top=95 ,right=1836 ,bottom=127  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='���������ڵ�' ,left=1537 ,top=132 ,right=1717 ,bottom=164  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��������' ,left=1310 ,top=132 ,right=1429 ,bottom=164  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='�����ܱ���' ,left=1310 ,top=172 ,right=1521 ,bottom=201  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='������1 / �ܱ���9' ,left=1537 ,top=172 ,right=1836 ,bottom=201  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��1 / ��2' ,left=1593 ,top=209 ,right=1836 ,bottom=243  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='�ܱ��δ��ϼ�������' ,left=1310 ,top=209 ,right=1580 ,bottom=243 ,align='left'  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='����' ,left=1312 ,top=249 ,right=1431 ,bottom=280  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='������1, �����2' ,left=1540 ,top=286 ,right=1820 ,bottom=318  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='�����ֿ���' ,left=1312 ,top=286 ,right=1471 ,bottom=318  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��ӱٷ�1, �ߵ����2' ,left=1537 ,top=323 ,right=1836 ,bottom=355  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='�������걸��' ,left=1312 ,top=323 ,right=1511 ,bottom=355  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='�����ڵ�' ,left=1540 ,top=249 ,right=1691 ,bottom=280  ,size=8   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='��� �� �� (�ּ�)' ,left=222 ,top=503 ,right=585 ,bottom=548 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='19)���� �����' ,left=98 ,top=1836 ,right=386 ,bottom=1881 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='20)������ҵ� ��' ,left=98 ,top=1902 ,right=572 ,bottom=1947 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>
<T>id='20)-1 ����ҵ� ��' ,left=98 ,top=1969 ,right=572 ,bottom=2013 ,align='left'  ,size=9   ,forecolor=#000000 ,backcolor=#FFFFFF </T>




<C>id='HTITLE', left=632, top=299, right=1053, bottom=341, size=10, bold=true,   forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='RCNT', left=304, top=191, right=392, bottom=270, size=9,    forecolor=#000000, backcolor=#FFFFFF </C>


<C>id='EMPNMK', left=595, top=566, right=889, bottom=611, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='RESINO', left=1392, top=566, right=1828, bottom=611, align='left' ,mask='XXXXXX-XXXXXXX', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='ADDR1', left=595, top=622, right=1100, bottom=667, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='ADDR2', left=1110, top=622, right=1828, bottom=667, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>

<C>id='CWORKFR', left=590, top=860, right=715, bottom=905, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='CWORKTO', left=725, top=860, right=850, bottom=905, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>

<C>id='CREDUFR', left=590, top=918, right=715, bottom=963, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='CREDUTO', left=725, top=918, right=850, bottom=963, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>





<C>id='BWORKNM1', left=855, top=743, right=1150, bottom=788, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BWORKNO1', left=855, top=802, right=1150, bottom=847, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF ,mask='XXX-XX-XXXXX'</C>

<C>id='BWORKFR1', left=855, top=861, right=980, bottom=904, align='left',  size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='BWORKTO1', left=1000, top=860, right=1150, bottom=905, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BREDUFR1', left=855, top=919, right=980, bottom=962, align='right',  size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='BREDUTO1', left=1000, top=918, right=1150, bottom=963, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>





<C>id='BWORKNM2', left=1095, top=743, right=1344, bottom=788, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BWORKNO2', left=1095, top=802, right=1344, bottom=847, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF ,mask='XXX-XX-XXXXX'</C>

<C>id='BWORKFR2', left=1095, top=860, right=1205, bottom=905, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BWORKTO2', left=1230, top=860, right=1344, bottom=905, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BREDUFR2', left=1095, top=918, right=1205, bottom=963, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BREDUTO2', left=1230, top=918, right=1344, bottom=963, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>



<C>id='BCWKNM3', left=1363, top=743, right=1588, bottom=788, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='BCRESINO3', left=1363, top=802, right=1588, bottom=847, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF ,mask='XXX-XX-XXXXX'</C>

<C>id='BWORKFR3', left=1363, top=860, right=1463, bottom=905, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BWORKTO3', left=1480, top=860, right=1588, bottom=905, align='left', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BREDUFR3', left=1363, top=918, right=1463, bottom=963, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='BREDUTO3', left=1480, top=918, right=1588, bottom=963, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>




<C>id='BWORKNO1', left=505, top=2146, right=688, bottom=2191, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF ,mask='XXX-XX-XXXXX'</C>
<C>id='BWORKNO2', left=505, top=2199, right=688, bottom=2244, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF,mask='XXX-XX-XXXXX'</C>

<C>id='CURDT2', left=1339, top=2500, right=1749, bottom=2537 ,mask='XXXX��  02��  28��', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>


<C>id='{decode(CP11000,0,,CP11000)}', left=598, top=979, right=823, bottom=1024, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(CP12000,0,,CP12000)}', left=598, top=1035, right=823, bottom=1080, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CP13000,0,,CP13000)}', left=598, top=1093, right=823, bottom=1138, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CP10000,0,,CP10000)}', left=598, top=1384, right=823, bottom=1429, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>

<C>id='{decode(BP11000,0,,BP11000)}', left=852, top=979, right=1100, bottom=1024, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BP12000,0,,BP12000)}', left=852, top=1035, right=1100, bottom=1080, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BP13000,0,,BP13000)}', left=852, top=1093, right=1100, bottom=1138, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>

<C>id='{decode(BP21000,0,,BP21000)}', left=1111, top=979, right=1336, bottom=1024, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BP22000,0,,BP22000)}', left=1111, top=1035, right=1336, bottom=1080, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BP23000,0,,BP23000)}', left=1111, top=1093, right=1336, bottom=1138, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>

<C>id='{decode(BP31000,0,,BP31000)}', left=1363, top=979, right=1588, bottom=1024, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BP32000,0,,BP32000)}', left=1363, top=1035, right=1588, bottom=1080, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BP33000,0,,BP33000)}', left=1363, top=1093, right=1588, bottom=1138, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>

<C>id='{decode(BP10000,0,,BP10000)}', left=852, top=1384, right=1100, bottom=1429, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BP20000,0,,BP20000)}', left=1111, top=1384, right=1336, bottom=1429, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BP30000,0,,BP30000)}', left=1363, top=1384, right=1588, bottom=1429, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>

<C>id='{decode(CBP1000,0,,CBP1000)}', left=1606, top=979, right=1847, bottom=1024, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CBP2000,0,,CBP2000)}', left=1606, top=1035, right=1847, bottom=1080, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CBP3000,0,,CBP3000)}', left=1606, top=1093, right=1847, bottom=1138, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CBPSUM,0,,CBPSUM)}', left=1606, top=1384, right=1847, bottom=1429, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>




<C>id='{decode(CNTAX01,0,,CNTAX01)}', left=598, top=1450, right=823, bottom=1497, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CNTAX02,0,,CNTAX02)}', left=598, top=1510, right=823, bottom=1550, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CNTAX03,0,,CNTAX03)}', left=598, top=1560, right=823, bottom=1605, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CNTAX04,0,,CNTAX04)}', left=598, top=1620, right=823, bottom=1660, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CNTAX05,0,,CNTAX05)}', left=598, top=1670, right=823, bottom=1715, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CNTAXSUM,0,,CNTAXSUM)}', left=598, top=1900, right=823, bottom=1955, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CREDAMT01,0,,CREDAMT01)}', left=598, top=1970, right=823, bottom=2020, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>


<C>id='{decode(BNTAX101,0,,BNTAX101)}', left=852, top=1450, right=1100, bottom=1497, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX102,0,,BNTAX102)}', left=852, top=1510, right=1100, bottom=1550, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX103,0,,BNTAX103)}', left=852, top=1560, right=1100, bottom=1605, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX104,0,,BNTAX104)}', left=852, top=1620, right=1100, bottom=1660, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX105,0,,BNTAX105)}', left=852, top=1670, right=1100, bottom=1715, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX1SUM,0,,BNTAX1SUM)}', left=852, top=1900, right=1100, bottom=1955, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BREDAMT01,0,,BREDAMT01)}', left=852, top=1970, right=1100, bottom=2020, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>


<C>id='{decode(BNTAX201,0,,BNTAX201)}', left=1111, top=1450, right=1336, bottom=1497, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX202,0,,BNTAX202)}', left=1111, top=1510, right=1336, bottom=1550, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX203,0,,BNTAX203)}', left=1111, top=1560, right=1336, bottom=1605, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX204,0,,BNTAX204)}', left=1111, top=1620, right=1336, bottom=1660, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX205,0,,BNTAX205)}', left=1111, top=1670, right=1336, bottom=1715, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX2SUM,0,,BNTAX2SUM)}', left=1111, top=1900, right=1336, bottom=1955, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BREDAMT02,0,,BREDAMT02)}', left=1111, top=1970, right=1336, bottom=2020, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>


<C>id='{decode(BNTAX301,0,,BNTAX301)}', left=1363, top=1450, right=1588, bottom=1497, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX302,0,,BNTAX302)}', left=1363, top=1510, right=1588, bottom=1550, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX303,0,,BNTAX303)}', left=1363, top=1560, right=1588, bottom=1605, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX304,0,,BNTAX304)}', left=1363, top=1620, right=1588, bottom=1660, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX305,0,,BNTAX305)}', left=1363, top=1670, right=1588, bottom=1715, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BNTAX3SUM,0,,BNTAX3SUM)}', left=1363, top=1900, right=1588, bottom=1955, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BREDAMT03,0,,BREDAMT03)}', left=1363, top=1970, right=1588, bottom=2020, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>




<C>id='{decode(REDSUM,0,,REDSUM)}', left=1606, top=1970, right=1847, bottom=2020, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>



<C>id='{decode(NTAXSUM01,0,,NTAXSUM01)}', left=1606, top=1450, right=1847, bottom=1497, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(NTAXSUM02,0,,NTAXSUM02)}', left=1606, top=1510, right=1847, bottom=1550, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(NTAXSUM03,0,,NTAXSUM03)}', left=1606, top=1560, right=1847, bottom=1605, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(NTAXSUM04,0,,NTAXSUM04)}', left=1606, top=1620, right=1847, bottom=1660, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(NTAXSUM05,0,,NTAXSUM05)}', left=1606, top=1670, right=1847, bottom=1715, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(NTAXSUM,0,,NTAXSUM)}', left=1606, top=1900, right=1847, bottom=1955, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>






<C>id='{decode(CCP41000,0,,CCP41000)}', left=699, top=2090, right=979, bottom=2135, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(CCP42000,0,,CCP42000)}', left=987, top=2090, right=1267, bottom=2135, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(CCP43000,0,,CCP43000)}', left=1278, top=2090, right=1558, bottom=2135, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(CCP40000,0,,CCP40000)}', left=1569, top=2090, right=1849, bottom=2135, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>

<C>id='{decode(BP41000,0,,BP41000)}', left=699, top=2146, right=979, bottom=2191, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BP42000,0,,BP42000)}', left=987, top=2146, right=1267, bottom=2191, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BP43000,0,,BP43000)}', left=1278, top=2146, right=1558, bottom=2191, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BP41000+BP42000+BP43000,0,,BP41000+BP42000+BP43000)}', left=1569, top=2146, right=1849, bottom=2191, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>

<C>id='{decode(BP51000,0,,BP51000)}', left=699, top=2199, right=979, bottom=2244, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BP52000,0,,BP52000)}', left=987, top=2199, right=1267, bottom=2244, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BP53000,0,,BP53000)}', left=1278, top=2199, right=1558, bottom=2244, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BP51000+BP52000+BP53000,0,,BP51000+BP52000+BP53000)}', left=1569, top=2199, right=1849, bottom=2244, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>

<C>id='{decode(CP41000,0,,CP41000)}', left=699, top=2310, right=979, bottom=2355, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(CP42000,0,,CP42000)}', left=987, top=2310, right=1267, bottom=2355, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(CP43000,0,,CP43000)}', left=1278, top=2310, right=1558, bottom=2355, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(CP40000,0,,CP40000)}', left=1569, top=2310, right=1849, bottom=2355, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>

<C>id='{decode(BA41000,0,,BA41000)}', left=699, top=2371, right=979, bottom=2416, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BA42000,0,,BA42000)}', left=987, top=2371, right=1267, bottom=2416, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>
<C>id='{decode(BA43000,0,,BA43000)}', left=1278, top=2371, right=1558, bottom=2416, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='{decode(BA40000,0,,BA40000)}', left=1569, top=2371, right=1849, bottom=2416, align='right', size=9,    forecolor=#000000, backcolor=#FFFFFF </C>


</B>

</R>
</A>






<A>id=Area2 ,left=0,top=0 ,right=2001 ,bottom=10
	<R>id='5��.sbt' ,left=0 ,top=0 ,right=2001 ,bottom=10, MasterDataID='gcds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1

	<C>id='{decode((TAXSUM-TREDSUM-DEDSUM),0,,(TAXSUM-TREDSUM-DEDSUM))}', left=1667, top=2731, right=1930, bottom=2786, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1667, top=2656, right=1930, bottom=2712, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT05,0,,DEDAMT05)}', left=1667, top=2434, right=1930, bottom=2487, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04,0,,DEDAMT04)}', left=1667, top=2360, right=1930, bottom=2416, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03,0,,DEDAMT03)}', left=1667, top=2270, right=1930, bottom=2323, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02,0,,DEDAMT02)}', left=1667, top=2074, right=1930, bottom=2130, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT01,0,,DEDAMT01)}', left=1667, top=1976, right=1930, bottom=2032, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREDSUM,0,,TREDSUM)}', left=1667, top=1905, right=1930, bottom=1961, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREDAMT02,0,,TREDAMT02)}', left=1667, top=1516, right=1930, bottom=1582, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREDAMT01,0,,TREDAMT01)}', left=1667, top=1418, right=1930, bottom=1474, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TAXSUM,0,,TAXSUM)}', left=1667, top=1328, right=1930, bottom=1381, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TAXSTDAMT,0,,TAXSTDAMT)}', left=1667, top=1241, right=1930, bottom=1296, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1667, top=1159, right=1930, bottom=1214, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FNDSUM,0,,FNDSUM)}', left=1667, top=799, right=1930, bottom=852, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ASSSUM,0,,ASSSUM)}', left=1667, top=730, right=1930, bottom=783, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CRDSUM,0,,CRDSUM)}', left=1667, top=654, right=1930, bottom=709, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INVSUM,0,,INVSUM)}', left=1667, top=585, right=1930, bottom=640, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVAMT02,0,,SAVAMT02)}', left=1667, top=508, right=1930, bottom=564, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVAMT04,0,,SAVAMT04)}', left=1667, top=439, right=1930, bottom=495, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVAMT03,0,,SAVAMT03)}', left=1667, top=360, right=1930, bottom=415, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVAMT01,0,,SAVAMT01)}', left=1667, top=294, right=1930, bottom=349, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SMAAMT,0,,SMAAMT)}', left=1667, top=220, right=1930, bottom=275, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PESAMT02,0,,PESAMT02)}', left=1667, top=148, right=1930, bottom=204, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PESAMT01,0,,PESAMT01)}', left=1667, top=79, right=1930, bottom=135, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=720, top=2733, right=1029, bottom=2789, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=720, top=2656, right=1029, bottom=2712, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=720, top=2585, right=1029, bottom=2638, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT,0,,CONAMT)}', left=720, top=2360, right=1029, bottom=2416, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT03,0,,HOUAMT03)}', left=720, top=2244, right=1029, bottom=2342, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02,0,,HOUAMT02)}', left=720, top=2167, right=1029, bottom=2223, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT01,0,,HOUAMT01)}', left=720, top=2048, right=1029, bottom=2148, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=720, top=1976, right=1029, bottom=2032, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=720, top=1905, right=1029, bottom=1961, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT04,0,,INSAMT04)}', left=720, top=1831, right=1029, bottom=1884, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT03,0,,INSAMT03)}', left=720, top=1757, right=1029, bottom=1812, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT02,0,,INSAMT02)}', left=720, top=1685, right=1029, bottom=1741, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT01,0,,INSAMT01)}', left=720, top=1614, right=1029, bottom=1667, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENAMT03,0,,PENAMT03)}', left=720, top=1500, right=1029, bottom=1593, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENAMT01,0,,PENAMT01)}', left=720, top=1042, right=1029, bottom=1095, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT06,0,,ADAMT06)}', left=720, top=968, right=1029, bottom=1024, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADCNT06,0,,ADCNT06)}', left=471, top=968, right=537, bottom=1024 ,mask='(XX��)', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT05,0,,ADAMT05)}', left=720, top=820, right=1029, bottom=876, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADCNT05,0,,ADCNT05)}', left=511, top=820, right=558, bottom=876 ,mask='(XX��)', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=720, top=746, right=1029, bottom=802, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADCNT04,0,,ADCNT04)}', left=442, top=746, right=487, bottom=802 ,mask='(XX��)', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=720, top=672, right=1029, bottom=725, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=720, top=595, right=1029, bottom=651, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADCNT02,0,,ADCNT02)}', left=407, top=595, right=474, bottom=651 ,mask='(XX��)', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=720, top=524, right=1029, bottom=579, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADCNT01,0,,ADCNT01)}', left=407, top=524, right=474, bottom=579 ,mask='(XX��)', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=720, top=450, right=1029, bottom=505, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BACNT03,0,,BACNT03)}', left=407, top=450, right=476, bottom=505 ,mask='(XX��)', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=720, top=376, right=1029, bottom=431, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=720, top=304, right=1029, bottom=360, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LABPAY,0,,LABPAY)}', left=720, top=220, right=1029, bottom=275, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DUDPAY,0,,DUDPAY)}', left=720, top=148, right=1029, bottom=204, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TOTPAY,0,,TOTPAY)}', left=720, top=79, right=1029, bottom=135, align='right', size=9, forecolor=#000000, backcolor=#FFFFFF</C>


	<T>id='37)����' ,left=191 ,top=2148 ,right=320 ,bottom=2201 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �ڱ�' ,left=191 ,top=2199 ,right=320 ,bottom=2254 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=191 ,top=1752 ,right=320 ,bottom=1807 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)' ,left=191 ,top=1701 ,right=320 ,bottom=1754 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=191 ,top=1545 ,right=320 ,bottom=1595 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݼҵ�' ,left=191 ,top=1500 ,right=320 ,bottom=1550 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=191 ,top=1455 ,right=320 ,bottom=1503 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)' ,left=191 ,top=1408 ,right=320 ,bottom=1458 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=191 ,top=1331 ,right=320 ,bottom=1386 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=191 ,top=1278 ,right=320 ,bottom=1334 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1' ,left=191 ,top=1122 ,right=320 ,bottom=1177 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  Ÿ' ,left=191 ,top=1175 ,right=320 ,bottom=1230 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݺ�' ,left=191 ,top=1225 ,right=320 ,bottom=1281 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)�� �� �� �� ��' ,left=1103 ,top=2270 ,right=1630 ,bottom=2323 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)��� ��ġ�ڱ�' ,left=1103 ,top=2360 ,right=1630 ,bottom=2416 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='60)��  ��   ��  ��' ,left=1103 ,top=2434 ,right=1630 ,bottom=2487 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1103 ,top=2506 ,right=1630 ,bottom=2561 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='62)' ,left=1103 ,top=2577 ,right=1630 ,bottom=2633 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='63)�� �� �� �� ��' ,left=1103 ,top=2656 ,right=1630 ,bottom=2712 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)�������հ���' ,left=1103 ,top=2074 ,right=1630 ,bottom=2130 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='56)��  ��   ��  ��' ,left=1103 ,top=1976 ,right=1630 ,bottom=2032 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='54)' ,left=1103 ,top=1611 ,right=1630 ,bottom=1664 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='55)���װ��� ��' ,left=1103 ,top=1905 ,right=1630 ,bottom=1961 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='52)[��   ��   ��   ��]' ,left=1103 ,top=1418 ,right=1630 ,bottom=1474 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='53)[����Ư�����ѹ�]' ,left=1103 ,top=1516 ,right=1630 ,bottom=1582 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='51)��     ��     ��     ��' ,left=1048 ,top=1328 ,right=1574 ,bottom=1381 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50)���ռҵ� ����ǥ��' ,left=1048 ,top=1241 ,right=1574 ,bottom=1296 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='49)�� ���� �ҵ���� ��' ,left=1103 ,top=1159 ,right=1630 ,bottom=1214 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)-1 ��������߼ұ���ٷ���' ,left=1103 ,top=873 ,right=1630 ,bottom=929 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)����ֽ�������ҵ����' ,left=1103 ,top=799 ,right=1630 ,bottom=852 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='47)�츮�������ռҵ����' ,left=1103 ,top=730 ,right=1630 ,bottom=783 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='46)�ſ�ī���ҵ����' ,left=1103 ,top=654 ,right=1630 ,bottom=709 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='45)�����������ڵ�ҵ����' ,left=1103 ,top=585 ,right=1630 ,bottom=640 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='44)-2����' ,left=1103 ,top=300 ,right=1259 ,bottom=360 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1103 ,top=360 ,right=1259 ,bottom=420 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ����' ,left=1103 ,top=420 ,right=1259 ,bottom=480 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='�±ٷ������ø�������' ,left=1270 ,top=508 ,right=1632 ,bottom=564 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������ø�������' ,left=1270 ,top=439 ,right=1632 ,bottom=495 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������û����������' ,left=1270 ,top=365 ,right=1632 ,bottom=421 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û������' ,left=1270 ,top=294 ,right=1632 ,bottom=349 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='�� �� �� ��[51)-55)-63)]' ,left=1048 ,top=2731 ,right=1574 ,bottom=2786 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=2302 ,right=175 ,bottom=2371  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=2162 ,right=175 ,bottom=2228  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=2032 ,right=175 ,bottom=2096  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=132 ,top=1905 ,right=175 ,bottom=1969  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=1521 ,right=175 ,bottom=1556  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=1458 ,right=175 ,bottom=1492  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=1397 ,right=175 ,bottom=1431  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=1334 ,right=175 ,bottom=1373  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=1281 ,right=175 ,bottom=1312  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=1217 ,right=175 ,bottom=1249  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=1156 ,right=175 ,bottom=1188  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٷ�������' ,left=331 ,top=1500 ,right=693 ,bottom=1550 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�޿� �����' ,left=331 ,top=1550 ,right=693 ,bottom=1600 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����б���ΰ���' ,left=331 ,top=1416 ,right=693 ,bottom=1471 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)�� �� �� �� �� �� �� �� ��' ,left=193 ,top=1042 ,right=685 ,bottom=1095 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)-1�����Ծ���(' ,left=201 ,top=820 ,right=508 ,bottom=876 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��)' ,left=558 ,top=820 ,right=606 ,bottom=876 ,align='right'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)�ڳ������(' ,left=198 ,top=746 ,right=437 ,bottom=802 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��)' ,left=489 ,top=746 ,right=542 ,bottom=802 ,align='right'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)��   ��   ��' ,left=198 ,top=672 ,right=521 ,bottom=725 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)�� �� �� (' ,left=198 ,top=595 ,right=405 ,bottom=651 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��)' ,left=479 ,top=595 ,right=540 ,bottom=651 ,align='right'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)��ο��(' ,left=198 ,top=524 ,right=405 ,bottom=579 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��)' ,left=479 ,top=524 ,right=540 ,bottom=579 ,align='right'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)�ξ簡��(' ,left=198 ,top=450 ,right=405 ,bottom=505 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��)' ,left=479 ,top=450 ,right=540 ,bottom=505 ,align='right'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)��   ��   ��' ,left=198 ,top=376 ,right=521 ,bottom=431 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=439 ,right=175 ,bottom=471  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=402 ,right=175 ,bottom=434  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=365 ,right=175 ,bottom=397  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=328 ,right=175 ,bottom=360  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=614 ,right=175 ,bottom=646  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=677 ,right=175 ,bottom=709  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=743 ,right=175 ,bottom=775  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=132 ,top=812 ,right=175 ,bottom=844  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='24)��         ��' ,left=198 ,top=304 ,right=511 ,bottom=360 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������������' ,left=331 ,top=2244 ,right=693 ,bottom=2292 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ա����ڻ�ȯ��' ,left=331 ,top=2294 ,right=693 ,bottom=2342 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� ��' ,left=331 ,top=2167 ,right=693 ,bottom=2223 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������������Ա�' ,left=331 ,top=2048 ,right=693 ,bottom=2098 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ݻ�ȯ��' ,left=331 ,top=2098 ,right=693 ,bottom=2148 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='35)��  ��  ��' ,left=201 ,top=1905 ,right=638 ,bottom=1961 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)��  ��  ��' ,left=201 ,top=1976 ,right=638 ,bottom=2032 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ǰ������' ,left=331 ,top=1614 ,right=693 ,bottom=1667 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����뺸���' ,left=331 ,top=1685 ,right=693 ,bottom=1741 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����强����' ,left=331 ,top=1757 ,right=693 ,bottom=1812 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����������' ,left=331 ,top=1831 ,right=693 ,bottom=1884 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������������' ,left=331 ,top=1114 ,right=693 ,bottom=1169 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ο���' ,left=331 ,top=1185 ,right=693 ,bottom=1241 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���縳�б�����������' ,left=331 ,top=1259 ,right=693 ,bottom=1315 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�º�����ü������' ,left=331 ,top=1336 ,right=693 ,bottom=1389 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��)' ,left=540 ,top=968 ,right=601 ,bottom=1024 ,align='right'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='31)���ڳ��߰�����(' ,left=140 ,top=968 ,right=460 ,bottom=1024 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41) ǥ �� �� ��' ,left=201 ,top=2656 ,right=638 ,bottom=2712 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40) ��' ,left=201 ,top=2585 ,right=638 ,bottom=2638 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='42)�� �� �� �� �� ��' ,left=77 ,top=2733 ,right=606 ,bottom=2789 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)' ,left=201 ,top=2434 ,right=638 ,bottom=2487 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)��  ��  ��' ,left=201 ,top=2360 ,right=638 ,bottom=2416 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='23)�ٷμҵ�ݾ�' ,left=79 ,top=220 ,right=701 ,bottom=275 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='44)-1�ұ�����һ���� �����α� �ҵ����' ,left=1103 ,top=220 ,right=1630 ,bottom=275 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)�ٷμҵ����' ,left=79 ,top=148 ,right=701 ,bottom=204 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='44)��������ҵ����' ,left=1103 ,top=148 ,right=1630 ,bottom=204 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=804 ,right=1087 ,bottom=849  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=751 ,right=1087 ,bottom=796  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=701 ,right=1087 ,bottom=741  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=651 ,right=1087 ,bottom=691  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=566 ,right=1087 ,bottom=609  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=505 ,right=1087 ,bottom=550  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=2368 ,right=1087 ,bottom=2413  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=2299 ,right=1087 ,bottom=2342  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=2228 ,right=1087 ,bottom=2270  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=2162 ,right=1087 ,bottom=2201  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=1696 ,right=1087 ,bottom=1744  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=1632 ,right=1087 ,bottom=1677  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=1574 ,right=1087 ,bottom=1617  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=1521 ,right=1087 ,bottom=1561  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1045 ,top=392 ,right=1087 ,bottom=434  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='43)���ο�������ҵ����' ,left=1103 ,top=79 ,right=1630 ,bottom=135 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)�� �� ��(16) �Ǵ� 16)- 18)-3)' ,left=79 ,top=79 ,right=701 ,bottom=135 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=77 ,top=1662 ,right=122 ,bottom=1709  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=77 ,top=1606 ,right=122 ,bottom=1651  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=77 ,top=1553 ,right=122 ,bottom=1593  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=77 ,top=1492 ,right=122 ,bottom=1532  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=77 ,top=1418 ,right=122 ,bottom=1463  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=26 ,top=1654 ,right=77 ,bottom=1693</T>
	<T>id='��' ,left=26 ,top=1521 ,right=77 ,bottom=1561</T>
	<T>id='��' ,left=26 ,top=1413 ,right=77 ,bottom=1455</T>
	<T>id='��' ,left=26 ,top=1289 ,right=77 ,bottom=1334</T>
	<T>id='��' ,left=26 ,top=1164 ,right=77 ,bottom=1209</T>
	<T>id='��' ,left=77 ,top=1349 ,right=122 ,bottom=1394  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��2��)' ,left=1778 ,top=0 ,right=1940 ,bottom=66 ,align='right'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<L> left=1262 ,top=356 ,right=1940 ,bottom=356 </L>
	<L> left=1262 ,top=430 ,right=1940 ,bottom=430 </L>
	<L> left=1262 ,top=500 ,right=1940 ,bottom=500 </L>

	<L> left=1093 ,top=1400 ,right=1093 ,bottom=2723 </L>
	<L> left=1093 ,top=2638 ,right=1940 ,bottom=2638 </L>
	<L> left=1093 ,top=2566 ,right=1940 ,bottom=2566 </L>
	<L> left=1093 ,top=2495 ,right=1940 ,bottom=2495 </L>
	<L> left=1093 ,top=2421 ,right=1940 ,bottom=2421 </L>
	<L> left=1093 ,top=2350 ,right=1940 ,bottom=2350 </L>
	<L> left=1093 ,top=2228 ,right=1940 ,bottom=2228 </L>
	<L> left=1093 ,top=2156 ,right=1940 ,bottom=2156 </L>
	<L> left=1093 ,top=2037 ,right=1940 ,bottom=2037 </L>
	<L> left=1093 ,top=1894 ,right=1940 ,bottom=1894 </L>
	<L> left=1093 ,top=1820 ,right=1940 ,bottom=1820 </L>
	<L> left=1093 ,top=1749 ,right=1940 ,bottom=1749 </L>
	<L> left=1093 ,top=1675 ,right=1940 ,bottom=1675 </L>
	<L> left=1035 ,top=1966 ,right=1940 ,bottom=1966 </L>
	<L> left=1093 ,top=1601 ,right=1940 ,bottom=1601 </L>
	<L> left=1093 ,top=1487 ,right=1940 ,bottom=1487 </L>
	<L> left=1093 ,top=66 ,right=1093 ,bottom=1225 </L>
	<L> left=1040 ,top=1400 ,right=1940 ,bottom=1400 </L>
	<L> left=1040 ,top=1307 ,right=1940 ,bottom=1307 </L>
	<L> left=1040 ,top=1222 ,right=1940 ,bottom=1222 </L>
	<L> left=1093 ,top=1151 ,right=1940 ,bottom=1151 </L>
	<L> left=1093 ,top=1077 ,right=1940 ,bottom=1077 </L>
	<L> left=1093 ,top=1005 ,right=1940 ,bottom=1005 </L>
	<L> left=1093 ,top=934 ,right=1940 ,bottom=934 </L>
	<L> left=1093 ,top=863 ,right=1940 ,bottom=863 </L>
	<L> left=1093 ,top=791 ,right=1940 ,bottom=791 </L>
	<L> left=1093 ,top=717 ,right=1940 ,bottom=717 </L>
	<L> left=1093 ,top=646 ,right=1940 ,bottom=646 </L>
	<L> left=1093 ,top=574 ,right=1940 ,bottom=574 </L>
	<L> left=1262 ,top=280 ,right=1262 ,bottom=574 </L>
	<L> left=323 ,top=2037 ,right=323 ,bottom=2350 </L>
	<L> left=1037 ,top=1601 ,right=130 ,bottom=1601 </L>
	<L> left=323 ,top=2230 ,right=1040 ,bottom=2230 </L>
	<L> left=323 ,top=2156 ,right=1040 ,bottom=2156 </L>
	<L> left=323 ,top=1820 ,right=1040 ,bottom=1820 </L>
	<L> left=323 ,top=1749 ,right=1040 ,bottom=1749 </L>
	<L> left=323 ,top=1675 ,right=1040 ,bottom=1675 </L>
	<L> left=323 ,top=1323 ,right=1040 ,bottom=1323 </L>
	<L> left=323 ,top=1487 ,right=1040 ,bottom=1487 </L>
	<L> left=177 ,top=1400 ,right=1040 ,bottom=1400 </L>
	<L> left=323 ,top=1249 ,right=1040 ,bottom=1249 </L>
	<L> left=323 ,top=1103 ,right=323 ,bottom=1894 </L>
	<L> left=177 ,top=1103 ,right=1040 ,bottom=1103 </L>
	<L> left=177 ,top=1029 ,right=177 ,bottom=2723 </L>
	<L> left=177 ,top=736 ,right=1040 ,bottom=736 </L>
	<L> left=177 ,top=585 ,right=1040 ,bottom=585 </L>
	<L> left=177 ,top=294 ,right=177 ,bottom=958 </L>
	<L> left=127 ,top=958 ,right=1037 ,bottom=958 </L>
	<L> left=127 ,top=294 ,right=127 ,bottom=2723 </L>
	<L> left=177 ,top=1966 ,right=1040 ,bottom=1966 </L>
	<L> left=177 ,top=1894 ,right=1040 ,bottom=1894 </L>
	<L> left=177 ,top=2037 ,right=1040 ,bottom=2037 </L>
	<L> left=323 ,top=1175 ,right=1040 ,bottom=1175 </L>
	<L> left=177 ,top=810 ,right=1040 ,bottom=810 </L>
	<L> left=71 ,top=294 ,right=1040 ,bottom=294 </L>
	<L> left=177 ,top=365 ,right=1040 ,bottom=365 </L>
	<L> left=127 ,top=513 ,right=1040 ,bottom=513 </L>
	<L> left=177 ,top=661 ,right=1040 ,bottom=661 </L>
	<L> left=177 ,top=437 ,right=1040 ,bottom=437 </L>
	<L> left=177 ,top=886 ,right=1040 ,bottom=886 </L>
	<L> left=127 ,top=1029 ,right=1040 ,bottom=1029 </L>
	<L> left=177 ,top=2643 ,right=1040 ,bottom=2643 </L>
	<L> left=177 ,top=2572 ,right=1040 ,bottom=2572 </L>
	<L> left=177 ,top=2498 ,right=1040 ,bottom=2498 </L>
	<L> left=177 ,top=2421 ,right=1040 ,bottom=2421 </L>
	<L> left=177 ,top=2350 ,right=1040 ,bottom=2350 </L>
	<L> left=71 ,top=2723 ,right=1940 ,bottom=2723 </L>
	<L> left=1093 ,top=280 ,right=1940 ,bottom=280 </L>
	<L> left=1093 ,top=209 ,right=1940 ,bottom=209 </L>
	<L> left=71 ,top=209 ,right=1040 ,bottom=209 </L>
	<L> left=71 ,top=138 ,right=1040 ,bottom=138 </L>
	<L> left=1093 ,top=138 ,right=1940 ,bottom=138 </L>
	<L> left=1640 ,top=66 ,right=1640 ,bottom=2797 </L>
	<L> left=712 ,top=66 ,right=712 ,bottom=2797 </L>
	<L> left=71 ,top=64 ,right=71 ,bottom=2794 </L>
	<L> left=1040 ,top=64 ,right=1040 ,bottom=2794 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1940 ,top=64 ,right=1940 ,bottom=2797 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=64 ,right=1940 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=66 ,right=26 ,bottom=2797 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=2797 ,right=1940 ,bottom=2797 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>
</R>
</A>









<A>id=Area3 ,left=0,top=0 ,right=2000 ,bottom=132
	<R>id='6��.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132,  DetailDataID='gcds_print1'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=613  ,size=10 ,penwidth=1
	<L> left=11 ,top=50 ,right=1910 ,bottom=50 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(��3��)' ,left=1617 ,top=3 ,right=1897 ,bottom=45 ,align='right'</T>
	<T>id='68)�ҵ���� ��(���������׸��� �ش���� O ǥ�ø� �ϸ�, ���� �ҵ���� �׸��� ������ ���Ͽ� ���� ������ �ݾ��� �����ϴ�)' ,left=26 ,top=58 ,right=1839 ,bottom=108 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#D1D1D1</T>
	<L> left=13 ,top=124 ,right=1908 ,bottom=124 </L>
	<T>id='���� �ҵ���� �׸�' ,left=783 ,top=130 ,right=1820 ,bottom=225  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� �׸�' ,left=423 ,top=130 ,right=680 ,bottom=225  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=119 ,top=130 ,right=415 ,bottom=225  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=24 ,top=130 ,right=108 ,bottom=175  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�' ,left=24 ,top=175 ,right=108 ,bottom=225  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=11 ,top=228 ,right=680 ,bottom=228 </L>
	<L> left=114 ,top=124 ,right=114 ,bottom=482 </L>
	<L> left=418 ,top=124 ,right=418 ,bottom=614 </L>
	<T>id='�� �� �� ��' ,left=119 ,top=302 ,right=418 ,bottom=352  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��         ȣ' ,left=119 ,top=355 ,right=418 ,bottom=402  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=24 ,top=302 ,right=108 ,bottom=352  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=24 ,top=341 ,right=108 ,bottom=389  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=929 ,top=228 ,right=929 ,bottom=614 </L>
	<T>id='�γ�' ,left=423 ,top=360 ,right=492 ,bottom=402  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=423 ,top=394 ,right=492 ,bottom=434  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=423 ,top=429 ,right=492 ,bottom=471  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=542 ,top=228 ,right=542 ,bottom=614 </L>
	<L> left=587 ,top=228 ,right=587 ,bottom=614 </L>
	<L> left=635 ,top=228 ,right=635 ,bottom=614 </L>
	<L> left=926 ,top=228 ,right=1826 ,bottom=228 </L>
	<L> left=680 ,top=124 ,right=680 ,bottom=614 </L>
	<L> left=13 ,top=476 ,right=1908 ,bottom=476 </L>
	<L> left=680 ,top=548 ,right=775 ,bottom=548 </L>
	<L> left=773 ,top=548 ,right=1905 ,bottom=548 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=495 ,top=228 ,right=495 ,bottom=614 </L>
	<L> left=13 ,top=614 ,right=1908 ,bottom=614 </L>
	<L> left=775 ,top=228 ,right=1908 ,bottom=228 </L>
	<T>id='��' ,left=503 ,top=254 ,right=540 ,bottom=302  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=503 ,top=302 ,right=540 ,bottom=352  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=503 ,top=352 ,right=540 ,bottom=402  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=503 ,top=402 ,right=540 ,bottom=450  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=548 ,top=405 ,right=585 ,bottom=455  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=548 ,top=357 ,right=585 ,bottom=405  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=548 ,top=246 ,right=585 ,bottom=296  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=548 ,top=296 ,right=585 ,bottom=347  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=548 ,top=344 ,right=585 ,bottom=365  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=595 ,top=283 ,right=632 ,bottom=331  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=595 ,top=331 ,right=632 ,bottom=381  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=595 ,top=381 ,right=632 ,bottom=429  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=640 ,top=254 ,right=677 ,bottom=302  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=640 ,top=302 ,right=677 ,bottom=352  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=640 ,top=352 ,right=677 ,bottom=402  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=640 ,top=402 ,right=677 ,bottom=450  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=685 ,top=553 ,right=775 ,bottom=606  ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=685 ,top=489 ,right=775 ,bottom=542  ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=418 ,top=545 ,right=495 ,bottom=545 </L>
	<T>id='�ڷ�' ,left=685 ,top=267 ,right=775 ,bottom=318 ,supplevel=1  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=685 ,top=315 ,right=775 ,bottom=355 ,supplevel=1  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=13 ,top=482 ,right=1908 ,bottom=482 </L>
	<T>id='�����' ,left=791 ,top=267 ,right=908 ,bottom=318  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=775 ,top=124 ,right=775 ,bottom=614 </L>
	<T>id='��� ����)' ,left=783 ,top=370 ,right=923 ,bottom=421  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ǰ�����' ,left=781 ,top=320 ,right=918 ,bottom=368  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>


	<C>id='{decode(TREF11,0,,TREF11)}', left=783, top=492, right=923, bottom=542, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=937, top=495, right=1077, bottom=545, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1082, top=495, right=1222, bottom=545, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>	
	<C>id='{decode(TREF14,0,,TREF14)}', left=1238, top=495, right=1416, bottom=545, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF17,0,,TREF17)}', left=1431, top=497, right=1606, bottom=548, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1614, top=497, right=1770, bottom=548, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1775, top=495, right=1908, bottom=545, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>


	<C>id='{decode(TREF21,0,,TREF21)}', left=783, top=553, right=923, bottom=606, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=937, top=553, right=1077, bottom=606, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1082, top=553, right=1222, bottom=606, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1238, top=553, right=1416, bottom=606, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF27,0,,TREF27)}', left=1431, top=553, right=1606, bottom=606, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1775, top=553, right=1910, bottom=606, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>


	<C>id='CHILDCNT', left=196, top=561, right=283, bottom=611, size=9, forecolor=#000000, backcolor=#FFFFFF</C>

	<T>id='�Ƿ��' ,left=937 ,top=233 ,right=1072 ,bottom=471  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<L> left=1077 ,top=228 ,right=1077 ,bottom=614 </L>
	<T>id='������' ,left=1085 ,top=233 ,right=1217 ,bottom=471  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>




	<L> left=1228 ,top=228 ,right=1228 ,bottom=614 </L>
	<L> left=1421 ,top=357 ,right=1421 ,bottom=614 </L>
	<L> left=1228 ,top=357 ,right=1778 ,bottom=357 </L>
	<L> left=1609 ,top=357 ,right=1609 ,bottom=614 </L>
	<X>left=1611 ,top=550 ,right=1773 ,bottom=609 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='������' ,left=1614 ,top=431 ,right=1767 ,bottom=468  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1773 ,top=222 ,right=1773 ,bottom=609 </L>
	<T>id='����' ,left=1614 ,top=389 ,right=1765 ,bottom=426  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=1262 ,top=307 ,right=1744 ,bottom=352  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī�� ��' ,left=1262 ,top=246 ,right=1744 ,bottom=299  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1781 ,top=233 ,right=1905 ,bottom=471  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='�ſ�' ,left=1244 ,top=389 ,right=1416 ,bottom=426  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ī�� ��' ,left=1244 ,top=431 ,right=1416 ,bottom=468  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1437 ,top=389 ,right=1606 ,bottom=426  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ī�� ��' ,left=1437 ,top=431 ,right=1606 ,bottom=468  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='�������� �׸�' ,left=61 ,top=487 ,right=357 ,bottom=537  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ϴ� �ο����� ����' ,left=16 ,top=524 ,right=415 ,bottom=566  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���ڳ�' ,left=34 ,top=561 ,right=167 ,bottom=611  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<L> left=13 ,top=609 ,right=1908 ,bottom=609 </L>
	<T>id='��)' ,left=310 ,top=561 ,right=368 ,bottom=611  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1910 ,top=50 ,right=1910 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=418 ,top=352 ,right=492 ,bottom=352 </L>
	<T>id='����' ,left=423 ,top=294 ,right=492 ,bottom=341  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻' ,left=423 ,top=246 ,right=492 ,bottom=294  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=11 ,top=50 ,right=11 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>





<B>id=default ,left=0,top=0 ,right=2000 ,bottom=100  ,size=10 ,penwidth=1
	<L> left=11 ,top=0 ,right=11 ,bottom=100 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=114 ,top=0 ,right=114 ,bottom=100 </L>
	<L> left=418 ,top=0 ,right=418 ,bottom=100 </L>
	<L> left=495 ,top=0 ,right=495 ,bottom=100 </L>
	<L> left=542 ,top=0 ,right=542 ,bottom=100 </L>
	<L> left=587 ,top=0 ,right=587 ,bottom=100 </L>
	<L> left=635 ,top=0 ,right=635 ,bottom=100 </L>
	<L> left=1773 ,top=0 ,right=1773 ,bottom=100 </L>
	<L> left=775 ,top=50 ,right=1905 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=421 ,top=50 ,right=495 ,bottom=50 </L>
	<L> left=680 ,top=0 ,right=680 ,bottom=100 </L>
	<L> left=680 ,top=50 ,right=775 ,bottom=50 </L>
	<L> left=1421 ,top=0 ,right=1421 ,bottom=100 </L>

	<C>id='REF2', left=423, top=5, right=492, bottom=50, size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=423, top=64, right=492, bottom=100, size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5', left=503, top=8, right=540, bottom=100, size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8', left=548, top=8, right=585, bottom=100, size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3', left=595, top=8, right=632, bottom=100, size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4', left=640, top=8, right=677, bottom=100, size=9, forecolor=#000000, backcolor=#FFFFFF</C>

	<T>id='��Ÿ' ,left=685 ,top=64 ,right=775 ,bottom=100  ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=685 ,top=8 ,right=775 ,bottom=50  ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=929 ,top=0 ,right=929 ,bottom=100 </L>
	<L> left=1077 ,top=0 ,right=1077 ,bottom=100 </L>
	<L> left=410 ,top=50 ,right=8 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1910 ,top=0 ,right=1910 ,bottom=100 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>

	<L> left=11 ,top=100 ,right=1913 ,bottom=100 </L>
	<L> left=1228 ,top=0 ,right=1228 ,bottom=100 </L>
	<L> left=1609 ,top=0 ,right=1609 ,bottom=100 </L>
	<X>left=1609 ,top=50 ,right=1773 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>

	<C>id='{decode(REF11,0,,REF11)}', left=788, top=5, right=926, bottom=50, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=934, top=8, right=1072, bottom=50, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1087, top=8, right=1225, bottom=50, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1251, top=8, right=1421, bottom=50, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17,0,,REF17)}', left=1437, top=8, right=1603, bottom=50, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1611, top=8, right=1770, bottom=50, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1778, top=8, right=1908, bottom=50, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>




	<C>id='{decode(REF21,0,,REF21)}', left=786, top=64, right=926, bottom=100, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=934, top=64, right=1072, bottom=100, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1087, top=64, right=1225, bottom=100, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1251, top=66, right=1421, bottom=100, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27,0,,REF27)}', left=1437, top=66, right=1603, bottom=100, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1778, top=64, right=1908, bottom=100, align='right', size=8, forecolor=#000000, backcolor=#FFFFFF</C>








	<L> left=775 ,top=0 ,right=775 ,bottom=100 </L>

	<C>id='FAMNM1', left=119, top=5, right=413, bottom=50, size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO1', left=119, top=64, right=410, bottom=100 ,mask='XXXXXX-XXXXXXX', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1', left=16, top=5, right=108, bottom=50, size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1', left=16, top=64, right=108, bottom=100, size=9, forecolor=#000000, backcolor=#FFFFFF</C>
</B>




<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=1350  ,size=10 ,penwidth=1
	<L> left=11 ,top=0 ,right=13 ,bottom=1347 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1910 ,top=0 ,right=1910 ,bottom=1349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�� �ۼ����' ,left=21 ,top=0 ,right=222 ,bottom=42 ,align='left'  ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ҵ漼���� ��149����1ȣ�� �ش��ϴ� ���������� ���ҵ漼���� ��127����1����4ȣ �� �� �ش��ϴ� �ٷμҵ��� ���������ϴ� ��쿡�� ����ϸ�, �� ��� �� �ٹ�ó�� �� �����ڵ�Ϲ�ȣ���� ' ,left=19 ,top=45 ,right=1791 ,bottom=77 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ٹ�ó�� ��ȣ �� ����ڹ�ȣ�� �����ϴ�. �ٸ�, �ٹ�ó�� ����ڵ���� ���� ��� ���������� ����ڵ�Ϲ�ȣ�� �����ϴ�.' ,left=19 ,top=82 ,right=1791 ,bottom=114 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. ���������� ���������ڵ�� �ٷμҵ��ڰ� ������ڿ� �ش��ϴ� ��쿡�� ������, ����ǥ��ȭ�ⱸ(ISO)�� ���� ISO�ڵ� �� ������ �� �����ڵ带 �����ϴ�' ,left=21 ,top=111 ,right=1799 ,bottom=153 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      (�� ISO�����ڵ�: ����ûȨ�������汹�������汹�����������汹�������ڷ�ǿ��� ��ȸ�� �� �ֽ��ϴ�). ��) ���ѹα�:KR, �̱�:US' ,left=24 ,top=146 ,right=1802 ,bottom=191 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. �ٷμҵ��ڰ� �ܱ��ο� �ش��ϴ� ��쿡�� �����ܱ��ζ��� ���ܱ��� 9���� �����ϰ� ���� �� �����ڵ���� ����ǥ��ȭ�ⱸ(ISO)�� ���� ISO�ڵ� �� ������ �� ����' ,left=24 ,top=183 ,right=1802 ,bottom=225 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �ڵ带 �����ϴ�. �ش� �ٷμҵ��ڰ� �ܱ��αٷ��� ���ϼ��������û���� ������ ��� ���ܱ��δ��ϼ��� ���롯���� ��1�� �����մϴ�.' ,left=26 ,top=220 ,right=1804 ,bottom=262 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. ��õ¡���ǹ��ڴ� �������� ���ϴ� ������ ���� ���� 3�� 10��(�޾� �Ǵ� ����� ��쿡�� �޾��� �Ǵ� ������� ���ϴ� ���� ���� ���� �� ������ ���մϴ�)���� ' ,left=26 ,top=257 ,right=1804 ,bottom=302 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ���޸����� �����Ͽ��� �մϴ�.' ,left=26 ,top=294 ,right=1804 ,bottom=339 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. ��.�ٹ�ó���ҵ������ ������ҵ渦 ������ �ݾ��� ���� ��.����� �� ����ҵ� ���������� ���޸��� �ۼ���� ������ҵ� �� �������� �ش��ڵ庰�� ����' ,left=26 ,top=331 ,right=1804 ,bottom=373 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �Ͽ� �����ϴ�. (������ �׸��� ���� ��� ��.����� �� ����ҵ� ��������  ������ҵ� ��� �� -1 ���鼼�� �迡 �Ѿ׸� ����, ��.����� �ҵ���� ������ �ۼ� �����մϴ�.) ' ,left=26 ,top=368 ,right=1804 ,bottom=410 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. ���ҵ漼���� ��127����1����4ȣ�� �� �� �ش��ϴ� �ٷμҵ�� �� �� �ٷμҵ��� ���Ͽ� ���������ϴ� ������ -1�������ն��� ���� �ٷμҵ泳�����հ� ���ҵ漼��' ,left=26 ,top=402 ,right=1804 ,bottom=445 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ����127����1����4ȣ �� �� �ش��ϴ� �ٷμҵ��� ����,���ҵ漼������150���� ���� �������հ����ݾ��� �������հ������� �����ϴ�. �պ�, ������� ���� ������' ,left=26 ,top=437 ,right=1804 ,bottom=479 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �ش� ������ ���������� �ϴ� ��쿡 ���պ����ΰ� ������º������� �ҵ��� �ٹ�ó���ҵ�� ��(��)���� ������ �����ϴ�.' ,left=26 ,top=471 ,right=1804 ,bottom=513 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. �ѱ޿������� ���衱���� �ݾ��� ����, �ܱ��αٷ��ڷΰ�������Ư�����ѹ��� ��18����2��2�׿� ���� ���ϼ����� �����ϴ� ��쿡�� ���衱�� �ݾװ� ������ҵ�ݾ���' ,left=26 ,top=505 ,right=1804 ,bottom=550 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ���� �ݾ��� ����, �� ��� �ҵ漼�� ������ ����������������� �� ���װ����� ���� ������ �������� �ʽ��ϴ�.' ,left=26 ,top=540 ,right=1804 ,bottom=582 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. ���ռҵ� Ư������(~)���� �� ���� �ҵ����(��)���� ���� ��37ȣ������ �������� �����ϴ�.' ,left=26 ,top=574 ,right=1802 ,bottom=619 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. �� ���Ŀ� ���� �ݾ� �� �Ҽ��� ���� ���� ������, ����¡�������� �Ҿ׺�¡��(1õ�� �̸��� ���մϴ�)�� �ش��ϴ� ��� ������ ��0������ �����ϴ�.' ,left=26 ,top=609 ,right=1802 ,bottom=654 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68)�ҵ���� ������ ������ ���� �ۼ��մϴ�.' ,left=26 ,top=643 ,right=1804 ,bottom=688 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �����ڵ��' ,left=26 ,top=680 ,right=1810 ,bottom=722 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�' ,left=445 ,top=730 ,right=606 ,bottom=773  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=445 ,top=915 ,right=606 ,bottom=982  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=445 ,top=847 ,right=606 ,bottom=913  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='0' ,left=445 ,top=778 ,right=606 ,bottom=844  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1566 ,top=722 ,right=1566 ,bottom=982 </L>
	<L> left=1207 ,top=722 ,right=1207 ,bottom=982 </L>
	<L> left=974 ,top=722 ,right=974 ,bottom=982 </L>
	<L> left=614 ,top=722 ,right=614 ,bottom=982 </L>
	<L> left=434 ,top=722 ,right=434 ,bottom=982 </L>
	<L> left=74 ,top=722 ,right=74 ,bottom=982 </L>
	<L> left=74 ,top=982 ,right=1807 ,bottom=982 </L>
	<L> left=74 ,top=913 ,right=1807 ,bottom=913 </L>
	<L> left=74 ,top=844 ,right=1807 ,bottom=844 </L>
	<L> left=74 ,top=773 ,right=1807 ,bottom=773 </L>
	<L> left=74 ,top=722 ,right=1804 ,bottom=722 </L>
	<T>id='������� ��������' ,left=1214 ,top=778 ,right=1564 ,bottom=810  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� 3 ��)' ,left=1214 ,top=812 ,right=1564 ,bottom=844  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�ڵ� 4 ����)' ,left=1214 ,top=847 ,right=1564 ,bottom=878  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� 3 ��)' ,left=1214 ,top=950 ,right=1564 ,bottom=982  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ź�Ƶ�' ,left=1214 ,top=915 ,right=1564 ,bottom=947  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� 3 ��)' ,left=1214 ,top=881 ,right=1564 ,bottom=913  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=1574 ,top=915 ,right=1791 ,bottom=982  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5' ,left=1574 ,top=847 ,right=1791 ,bottom=913  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=1574 ,top=778 ,right=1791 ,bottom=844  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=1214 ,top=730 ,right=1564 ,bottom=773  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�' ,left=1574 ,top=730 ,right=1791 ,bottom=773  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ����� ��������' ,left=622 ,top=778 ,right=971 ,bottom=810  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� 3 ��)' ,left=622 ,top=812 ,right=971 ,bottom=844  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�ڳ���Ծ���)' ,left=622 ,top=847 ,right=971 ,bottom=878  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� 3 ��)' ,left=622 ,top=950 ,right=971 ,bottom=982  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�ڵ�1~6����)' ,left=622 ,top=915 ,right=971 ,bottom=947  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� 3 ��)' ,left=622 ,top=881 ,right=971 ,bottom=913  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=984 ,top=915 ,right=1201 ,bottom=982  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4' ,left=984 ,top=847 ,right=1201 ,bottom=913  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=984 ,top=778 ,right=1201 ,bottom=844  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=622 ,top=730 ,right=971 ,bottom=773  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�' ,left=984 ,top=730 ,right=1201 ,bottom=773  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ��� ����' ,left=82 ,top=778 ,right=431 ,bottom=810  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� 1)' ,left=82 ,top=812 ,right=431 ,bottom=844  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=82 ,top=847 ,right=431 ,bottom=878  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� ��)' ,left=82 ,top=950 ,right=431 ,bottom=982  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڸ�' ,left=82 ,top=915 ,right=431 ,bottom=947  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ҹ� ��50 �� 2)' ,left=82 ,top=881 ,right=431 ,bottom=913  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=82 ,top=730 ,right=431 ,bottom=773  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       * �ش� �����Ӱ� �� ����ڰ� ������� ��� �� ����ڸ� ����, �� �����ڵ� 4��6 �� �ҵ��ڿ� ������� ������ ���踦 �����մϴ�.' ,left=24 ,top=979 ,right=1820 ,bottom=1024 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. �����ܱ��ζ�: �������� ��� ��1����, �ܱ����� ��� ��9���� �����ϴ�.' ,left=24 ,top=1016 ,right=1818 ,bottom=1058 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. ���������׸��: �������������� �ִ� ��� �ش���� ���ۡ� ǥ�ø� �մϴ�(�ش� ������ ���� ��� ����Ӵϴ�).' ,left=24 ,top=1050 ,right=1815 ,bottom=1093 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      ��. ����û �ڷ��: �ҵ���� ���������� ���ҵ漼���� ��165���� ���� ����û Ȩ���������� �����ϴ� �ڷḦ �̿��ϴ� ��� �� �ҵ���� �׸��� �ݾ� �� ' ,left=24 ,top=1085 ,right=1815 ,bottom=1127 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='                               �ҵ��������� �Ǵ� �ݾ��� �����ϴ�.' ,left=24 ,top=1117 ,right=1815 ,bottom=1159 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      ��. ��Ÿ�ڷ��: ����û���� �����ϴ� �������� ���� �������� �̿��ϴ� ��츦 ���մϴ�(���� ���, �п��� ���γ��ο������� ���ſ�ī�� �����, �÷±����� ' ,left=24 ,top=1151 ,right=1812 ,bottom=1193 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='                           �Ȱ汸�Ժ�� �Ƿ����� ���� �����ϴ�). ' ,left=26 ,top=1185 ,right=1791 ,bottom=1230 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  10. �ش� �ٷμҵ��ڰ� ��������, ��������, ���ø�������, ����ֽ������� �� �ҵ������ �� ��쿡�� �ٷμҵ����޸����� ��õ¡�� ���� �������忡��' ,left=26 ,top=1259 ,right=1810 ,bottom=1302 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ����� �ش� ������ �Բ� �����Ͽ��� �մϴ�.' ,left=26 ,top=1294 ,right=1812 ,bottom=1336 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=11 ,top=1347 ,right=1910 ,bottom=1347 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='      ��. ���� �ҵ���� �׸��: �ҵ�����׸� �ش��ϴ� ���� ����ݾ��� �����ϴ�(�ҵ�������� �ƴ� ���� ���ݾ��� �����׸񺰷� ���е� ���� �ȿ� �����ϴ�).' ,left=26 ,top=1222 ,right=1865 ,bottom=1267 ,align='left'  ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1807 ,top=722 ,right=1807 ,bottom=982 </L>
</B>
</R>
</A>






<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=132
	<R>id='7��.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132,  DetailDataID='gcds_print22'




<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2780  ,size=10 ,penwidth=1


<L> left=30 ,top=130 ,right=1900 ,bottom=130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=30 ,top=2780 ,right=1900 ,bottom=2780 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=30 ,top=130 ,right=30 ,bottom=2780 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=1900 ,top=130 ,right=1900 ,bottom=2780 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>

<L> left=30 ,top=250 ,right=1900 ,bottom=250 </L>
<L> left=30 ,top=350 ,right=1900 ,bottom=350 </L>
<L> left=30 ,top=430 ,right=1900 ,bottom=430 </L>
<L> left=30 ,top=510 ,right=1900 ,bottom=510 </L>
<L> left=30 ,top=610 ,right=1900 ,bottom=610 </L>
<L> left=30 ,top=710 ,right=1900 ,bottom=710 </L>

<L> left=30 ,top=810 ,right=1900 ,bottom=810 </L>
<L> left=30 ,top=870 ,right=1900 ,bottom=870 </L>
<L> left=30 ,top=930 ,right=1900 ,bottom=930 </L>
<L> left=30 ,top=990 ,right=1900 ,bottom=990 </L>
<L> left=30 ,top=1050 ,right=1900 ,bottom=1050 </L>

<L> left=30 ,top=1150 ,right=1900 ,bottom=1150 </L>
<L> left=30 ,top=1210 ,right=1900 ,bottom=1210 </L>
<L> left=30 ,top=1270 ,right=1900 ,bottom=1270 </L>
<L> left=30 ,top=1330 ,right=1900 ,bottom=1330 </L>
<L> left=30 ,top=1390 ,right=1900 ,bottom=1390 </L>
<L> left=30 ,top=1450 ,right=1900 ,bottom=1450 </L>
<L> left=30 ,top=1510 ,right=1900 ,bottom=1510 </L>


<L> left=30 ,top=1610 ,right=1900 ,bottom=1610 </L>
<L> left=30 ,top=1670 ,right=1900 ,bottom=1670 </L>
<L> left=30 ,top=1730 ,right=1900 ,bottom=1730 </L>
<L> left=30 ,top=1790 ,right=1900 ,bottom=1790 </L>
<L> left=30 ,top=1850 ,right=1900 ,bottom=1850 </L>
<L> left=30 ,top=1910 ,right=1900 ,bottom=1910 </L>
<L> left=30 ,top=1970 ,right=1900 ,bottom=1970 </L>


<L> left=30 ,top=2070 ,right=1900 ,bottom=2070 </L>
<L> left=30 ,top=2130 ,right=1900 ,bottom=2130 </L>
<L> left=30 ,top=2190 ,right=1900 ,bottom=2190 </L>
<L> left=30 ,top=2250 ,right=1900 ,bottom=2250 </L>
<L> left=30 ,top=2310 ,right=1900 ,bottom=2310 </L>
<L> left=30 ,top=2370 ,right=1900 ,bottom=2370 </L>


<L> left=750 ,top=350 ,right=750 ,bottom=510 </L>

<L> left=1228 ,top=350 ,right=1228 ,bottom=510 </L>
<L> left=1284 ,top=350 ,right=1284 ,bottom=430 </L>
<L> left=1340 ,top=350 ,right=1340 ,bottom=430 </L>
<L> left=1396 ,top=350 ,right=1396 ,bottom=430 </L>
<L> left=1452 ,top=350 ,right=1452 ,bottom=430 </L>
<L> left=1508 ,top=350 ,right=1508 ,bottom=430 </L>
<L> left=1564 ,top=350 ,right=1564 ,bottom=430 </L>
<L> left=1620 ,top=350 ,right=1620 ,bottom=430 </L>
<L> left=1676 ,top=350 ,right=1676 ,bottom=430 </L>
<L> left=1732 ,top=350 ,right=1732 ,bottom=430 </L>
<L> left=1788 ,top=350 ,right=1788 ,bottom=430 </L>
<L> left=1844 ,top=350 ,right=1844 ,bottom=430 </L>

<L> left=1276 ,top=430 ,right=1276 ,bottom=510 </L>
<L> left=1324 ,top=430 ,right=1324 ,bottom=510 </L>
<L> left=1372 ,top=430 ,right=1372 ,bottom=510 </L>
<L> left=1420 ,top=430 ,right=1420 ,bottom=510 </L>
<L> left=1468 ,top=430 ,right=1468 ,bottom=510 </L>
<L> left=1516 ,top=430 ,right=1516 ,bottom=510 </L>
<L> left=1564 ,top=430 ,right=1564 ,bottom=510 </L>
<L> left=1612 ,top=430 ,right=1612 ,bottom=510 </L>
<L> left=1660 ,top=430 ,right=1660 ,bottom=510 </L>
<L> left=1708 ,top=430 ,right=1708 ,bottom=510 </L>
<L> left=1756 ,top=430 ,right=1756 ,bottom=510 </L>
<L> left=1804 ,top=430 ,right=1804 ,bottom=510 </L>
<L> left=1852 ,top=430 ,right=1852 ,bottom=510 </L>

<L> left=300 ,top=350 ,right=300 ,bottom=710 </L>
<L> left=300 ,top=810 ,right=300 ,bottom=1050 </L>
<L> left=300 ,top=1150 ,right=300 ,bottom=1510 </L>
<L> left=300 ,top=1610 ,right=300 ,bottom=1970 </L>
<L> left=600 ,top=2070 ,right=600 ,bottom=2370 </L>

<L> left=850 ,top=810 ,right=850 ,bottom=1050 </L>
<L> left=850 ,top=1150 ,right=850 ,bottom=1510 </L>
<L> left=850 ,top=1610 ,right=850 ,bottom=1970 </L>
<L> left=1000 ,top=2070 ,right=1000 ,bottom=2370 </L>

<L> left=1300 ,top=810 ,right=1300 ,bottom=1050 </L>
<L> left=1300 ,top=1150 ,right=1300 ,bottom=1510 </L>
<L> left=1300 ,top=1610 ,right=1300 ,bottom=1970 </L>
<L> left=1300 ,top=2070 ,right=1300 ,bottom=2370 </L>

<L> left=1600 ,top=810 ,right=1600 ,bottom=1050 </L>
<L> left=1600 ,top=1150 ,right=1600 ,bottom=1510 </L>
<L> left=1600 ,top=1610 ,right=1600 ,bottom=1970 </L>
<L> left=1600 ,top=2070 ,right=1600 ,bottom=2370 </L>




<C>id='EMPNMK', left=300, top=430, right=750, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>

<C>id='ADDRESS', left=310, top=510, right=1900, bottom=610, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>

<C>id='TELNO', left=1564, top=510, right=1852, bottom=610, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>


<C>id='EMPJUNO1', left=1228, top=430, right=1276, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO2', left=1276, top=430, right=1324, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO3', left=1324, top=430, right=1372, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO4', left=1372, top=430, right=1420, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO5', left=1420, top=430, right=1468, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO6', left=1468, top=430, right=1516, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<T>id='-' ,left=1516 ,top=430 ,right=1564 ,bottom=510 ,face='����' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<C>id='EMPJUNO7', left=1564, top=430, right=1612, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO8', left=1612, top=430, right=1660, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO9', left=1660, top=430, right=1708, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO10', left=1708, top=430, right=1756, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO11', left=1756, top=430, right=1804, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO12', left=1804, top=430, right=1852, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO13', left=1852, top=430, right=1900, bottom=510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>


<C>id='DUDGBNM1_1', left=30, top=870, right=300, bottom=930, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM1_1', left=300, top=870, right=850, bottom=930, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO1_1', left=850, top=870, right=1300, bottom=930, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT1_1,0,,PAYAMT1_1)}', left=1300, top=870, right=1600, bottom=930, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT1_1,0,,DEDAMT1_1)}', left=1600, top=870, right=1900, bottom=930, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM1_2', left=30, top=930, right=300, bottom=990, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM1_2', left=300, top=930, right=850, bottom=990, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO1_2', left=850, top=930, right=1300, bottom=990, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT1_2,0,,PAYAMT1_2)}', left=1300, top=930, right=1600, bottom=990, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT1_2,0,,DEDAMT1_2)}', left=1600, top=930, right=1900, bottom=990, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM1_3', left=30, top=990, right=300, bottom=1050, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM1_3', left=300, top=990, right=850, bottom=1050, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO1_3', left=850, top=990, right=1300, bottom=1050, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT1_3,0,,PAYAMT1_3)}', left=1300, top=990, right=1600, bottom=1050, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT1_3,0,,DEDAMT1_3)}', left=1600, top=990, right=1900, bottom=1050, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM2_1', left=30, top=1210, right=300, bottom=1270, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_1', left=300, top=1210, right=850, bottom=1270, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_1', left=850, top=1210, right=1300, bottom=1270, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_1,0,,PAYAMT2_1)}', left=1300, top=1210, right=1600, bottom=1270, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_1,0,,DEDAMT2_1)}', left=1600, top=1210, right=1900, bottom=1270, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM2_2', left=30, top=1270, right=300, bottom=1330, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_2', left=300, top=1270, right=850, bottom=1330, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_2', left=850, top=1270, right=1300, bottom=1330, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_2,0,,PAYAMT2_2)}', left=1300, top=1270, right=1600, bottom=1330, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_2,0,,DEDAMT2_2)}', left=1600, top=1270, right=1900, bottom=1330, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM2_3', left=30, top=1330, right=300, bottom=1390, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_3', left=300, top=1330, right=850, bottom=1390, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_3', left=850, top=1330, right=1300, bottom=1390, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_3,0,,PAYAMT2_3)}', left=1300, top=1330, right=1600, bottom=1390, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_3,0,,DEDAMT2_3)}', left=1600, top=1330, right=1900, bottom=1390, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>


<C>id='DUDGBNM2_4', left=30, top=1390, right=300, bottom=1450, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_4', left=300, top=1390, right=850, bottom=1450, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_4', left=850, top=1390, right=1300, bottom=1450, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_4,0,,PAYAMT2_4)}', left=1300, top=1390, right=1600, bottom=1450, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_4,0,,DEDAMT2_4)}', left=1600, top=1390, right=1900, bottom=1450, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM2_5', left=30, top=1450, right=300, bottom=1510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_5', left=300, top=1450, right=850, bottom=1510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_5', left=850, top=1450, right=1300, bottom=1510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_5,0,,PAYAMT2_5)}', left=1300, top=1450, right=1600, bottom=1510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_5,0,,DEDAMT2_5)}', left=1600, top=1450, right=1900, bottom=1510, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>



<C>id='DUDGBNM3_1', left=30, top=1670, right=300, bottom=1730, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_1', left=300, top=1670, right=850, bottom=1730, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_1', left=850, top=1670, right=1300, bottom=1730, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_1,0,,PAYAMT3_1)}', left=1300, top=1670, right=1600, bottom=1730, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_1,0,,DEDAMT3_1)}', left=1600, top=1670, right=1900, bottom=1730, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM3_2', left=30, top=1730, right=300, bottom=1790, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_2', left=300, top=1730, right=850, bottom=1790, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_2', left=850, top=1730, right=1300, bottom=1790, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_2,0,,PAYAMT3_2)}', left=1300, top=1730, right=1600, bottom=1790, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_2,0,,DEDAMT3_2)}', left=1600, top=1730, right=1900, bottom=1790, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM3_3', left=30, top=1790, right=300, bottom=1850, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_3', left=300, top=1790, right=850, bottom=1850, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_3', left=850, top=1790, right=1300, bottom=1850, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_3,0,,PAYAMT3_3)}', left=1300, top=1790, right=1600, bottom=1850, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_3,0,,DEDAMT3_3)}', left=1600, top=1790, right=1900, bottom=1850, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM3_4', left=30, top=1850, right=300, bottom=1910, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_4', left=300, top=1850, right=850, bottom=1910, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_4', left=850, top=1850, right=1300, bottom=1910, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_4,0,,PAYAMT3_4)}', left=1300, top=1850, right=1600, bottom=1910, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_4,0,,DEDAMT3_4)}', left=1600, top=1850, right=1900, bottom=1910, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM3_5', left=30, top=1910, right=300, bottom=1970, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_5', left=300, top=1910, right=850, bottom=1970, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_5', left=850, top=1910, right=1300, bottom=1970, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_5,0,,PAYAMT3_5)}', left=1300, top=1910, right=1600, bottom=1970, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_5,0,,DEDAMT3_5)}', left=1600, top=1910, right=1900, bottom=1970, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='FINANM4_1', left=30, top=2130, right=600, bottom=2190, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='ACCNO4_1', left=600, top=2130, right=1000, bottom=2190, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='YEARLY4_1', left=1000, top=2130, right=1300, bottom=2190, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT4_1,0,,PAYAMT4_1)}', left=1300, top=2130, right=1600, bottom=2190, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT4_1,0,,DEDAMT4_1)}', left=1600, top=2130, right=1900, bottom=2190, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='FINANM4_2', left=30, top=2190, right=600, bottom=2250, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='ACCNO4_2', left=600, top=2190, right=1000, bottom=2250, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='YEARLY4_2', left=1000, top=2190, right=1300, bottom=2250, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT4_2,0,,PAYAMT4_2)}', left=1300, top=2190, right=1600, bottom=2250, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT4_2,0,,DEDAMT4_2)}', left=1600, top=2190, right=1900, bottom=2250, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='FINANM4_3', left=30, top=2250, right=600, bottom=2310, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='ACCNO4_3', left=600, top=2250, right=1000, bottom=2310, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='YEARLY4_3', left=1000, top=2250, right=1300, bottom=2310, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT4_3,0,,PAYAMT4_3)}', left=1300, top=2250, right=1600, bottom=2310, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT4_3,0,,DEDAMT4_3)}', left=1600, top=2250, right=1900, bottom=2310, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='FINANM4_4', left=30, top=2310, right=600, bottom=2370, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='ACCNO4_4', left=600, top=2310, right=1000, bottom=2370, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='YEARLY4_4', left=1000, top=2310, right=1300, bottom=2370, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT4_4,0,,PAYAMT4_4)}', left=1300, top=2310, right=1600, bottom=2370, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT4_4,0,,DEDAMT4_4)}', left=1600, top=2310, right=1900, bottom=2370, face='����', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>





<T>id='(5��)' ,left=1738 ,top=71 ,right=1892 ,bottom=132 ,align='right'</T>

<T>id='���� �� ���� �� �ҵ���� ����' ,left=30 ,top=100 ,right=1900 ,bottom=250 ,face='���� ���' ,bold=true, size=20 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='1. ��������' ,left=50 ,top=250 ,right=300 ,bottom=350 ,face='����' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='���            ȣ' ,left=30 ,top=350 ,right=300 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='����ƻ� �ֽ�ȸ��' ,left=300 ,top=350 ,right=750 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='���  ��  ��  ��  ��  ��  ȣ' ,left=750 ,top=350 ,right=1228 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T> id='2' , left=1228 ,top=350 ,right=1284 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='2' , left=1284 ,top=350 ,right=1340 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='1' , left=1340 ,top=350 ,right=1396 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='-' , left=1396 ,top=350 ,right=1452 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T> id='8' , left=1452 ,top=350 ,right=1508 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='1' , left=1508 ,top=350 ,right=1564 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='-' , left=1564 ,top=350 ,right=1620 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T> id='1' , left=1620 ,top=350 ,right=1676 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='3' , left=1676 ,top=350 ,right=1732 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='8' , left=1732 ,top=350 ,right=1788 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='3' , left=1788 ,top=350 ,right=1844 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='4' , left=1844 ,top=350 ,right=1900 ,bottom=430 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>

<T>id='�鼺            ��' ,left=30 ,top=430 ,right=300 ,bottom=510 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='����   ��   ��   ��   ��   ȣ' ,left=750 ,top=430 ,right=1228 ,bottom=510 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='����            ��' ,left=30 ,top=510 ,right=300 ,bottom=610 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='�����������' ,left=30 ,top=610 ,right=300 ,bottom=710 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id=' ���� ���α� ������ 1-7 ����׷����' ,left=300 ,top=610 ,right=900 ,bottom=710 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='(��ȭ��ȣ:' ,left=1400 ,top=510 ,right=1570 ,bottom=610 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='( ��ȭ��ȣ:02-3669-3867     )' ,left=1400 ,top=610 ,right=1880 ,bottom=710 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id=')' ,left=1840 ,top=510 ,right=1870 ,bottom=610 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='2. �������� ����' ,left=50 ,top=710 ,right=400 ,bottom=760 ,face='����' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF ,align='left'</T>
<T>id='     * �������� ������ ���� ���� �ۼ��մϴ�.' ,left=40 ,top=760 ,right=900 ,bottom=810 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='�������ݱ���' ,left=30 ,top=810 ,right=300 ,bottom=870 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='�������' ,left=300 ,top=810 ,right=850 ,bottom=870 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���¹�ȣ' ,left=850 ,top=810 ,right=1300 ,bottom=870 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���Աݾ�' ,left=1300 ,top=810 ,right=1600 ,bottom=870 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='�����ݾ�' ,left=1600 ,top=810 ,right=1900 ,bottom=870 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='3. �������� ����' ,left=50 ,top=1050 ,right=400 ,bottom=1100 ,face='����' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * �������� ������ ���� ���� �ۼ��մϴ�.' ,left=40 ,top=1100 ,right=900 ,bottom=1150 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='�������౸��' ,left=30 ,top=1150 ,right=300 ,bottom=1210 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='�������' ,left=300 ,top=1150 ,right=850 ,bottom=1210 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���¹�ȣ' ,left=850 ,top=1150 ,right=1300 ,bottom=1210 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���Աݾ�' ,left=1300 ,top=1150 ,right=1600 ,bottom=1210 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='�����ݾ�' ,left=1600 ,top=1150 ,right=1900 ,bottom=1210 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>


<T>id='4. ���ø������� ����' ,left=50 ,top=1510 ,right=500 ,bottom=1560 ,face='����' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * ���ø������� ������ ���� ���� �ۼ��մϴ�.' ,left=40 ,top=1560 ,right=1000 ,bottom=1610 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='���� ����' ,left=30 ,top=1610 ,right=300 ,bottom=1670 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='�������' ,left=300 ,top=1610 ,right=850 ,bottom=1670 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���¹�ȣ' ,left=850 ,top=1610 ,right=1300 ,bottom=1670 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���Աݾ�' ,left=1300 ,top=1610 ,right=1600 ,bottom=1670 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='�����ݾ�' ,left=1600 ,top=1610 ,right=1900 ,bottom=1670 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>


<T>id='5. ����ֽ������� ����' ,left=50 ,top=1970 ,right=500 ,bottom=2020 ,face='����' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * ����ֽ������� ������ ���� ���� �ۼ��մϴ�.' ,left=40 ,top=2020 ,right=1000 ,bottom=2070 ,face='����' ,size=10,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='�������' ,left=30 ,top=2070 ,right=600 ,bottom=2130 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���¹�ȣ' ,left=600 ,top=2070 ,right=1000 ,bottom=2130 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���Կ���' ,left=1000 ,top=2070 ,right=1300 ,bottom=2130 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='���Աݾ�' ,left=1300 ,top=2070 ,right=1600 ,bottom=2130 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='�����ݾ�' ,left=1600 ,top=2070 ,right=1900 ,bottom=2130 ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='�� �ۼ����' ,left=40 ,top=2380 ,right=1900 ,bottom=2430 ,align='left' ,face='����' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='1. �������ݡ��������ࡤ���ø������ࡤ����ֽ������� ������ ��û�ϰ��� �ϴ� �ٷμҵ��ڴ� �ش� �ҵ������ ���� ����' ,left=40 ,top=2430 ,right=1900 ,bottom=2480 ,align='left' ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id=' �ۼ��Ͽ��� �մϴ�.' ,left=40 ,top=2480 ,right=1900 ,bottom=2530 ,align='left' ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>

<T>id='2. �������� �������� �������ݱ��ж��� �������ݡ����б���ΰ���ȸ�� �����Ͽ� �����ϴ�.' ,left=40 ,top=2530 ,right=1900 ,bottom=2580 ,align='left' ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='3. �������� ������ �������౸�ж��� ���ο�������� ������������ �����Ͽ� �����ϴ�.' ,left=40 ,top=2580 ,right=1900 ,bottom=2630 ,align='left' ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='4. ���ø������� ������ ���౸�ж��� û������, ����û����������, ������ø������� �� �ٷ������ø����������� �����Ͽ� �����ϴ�.' ,left=40 ,top=2630 ,right=1900 ,bottom=2680 ,align='left' ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='5. ����ֽ������� ������ ��� ���� ���¶� �ϴ��� �ش� �����Ⱓ�� ���Կ����� �޶����� ��� �����Ͽ� �����ϴ�.' ,left=40 ,top=2680 ,right=1900 ,bottom=2730 ,align='left' ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='6. �ٷ��ڰ� ��õ¡���ǹ��ڿ��� ����� �����ݾ׶��� �ٷμҵ��ڰ� ���� �ƴ��� �� �ֽ��ϴ�.' ,left=40 ,top=2730 ,right=1900 ,bottom=2780 ,align='left' ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>



</B>
</R>
</A>

	">
</object></comment><script>__ws__(__NSID__);</script>












<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ� ������ : �ٷμҵ��õ¡�������� REPORT
--------------------------------------------------------------------------------------->


<comment id="__NSID__"><object id=gcrp_print3 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print"> -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='7��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2750 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=66 ,top=185 ,right=395 ,bottom=274 ,border=true</X>
	<L> left=29 ,top=2650 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=158 ,right=29 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210��x297��(�Ϲݿ��� 60g/��)' ,left=1206 ,top=2663 ,right=1848 ,bottom=2705 ,align='right' ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��1��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1719 ,top=319 ,right=1719 ,bottom=361 </L>
	<L> left=1293 ,top=232 ,right=1830 ,bottom=232 </L>
	<T>id='��1 / ��2' ,left=1585 ,top=279 ,right=1827 ,bottom=314 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ֱ���' ,left=1303 ,top=195 ,right=1514 ,bottom=227 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������1 / �������2' ,left=1530 ,top=195 ,right=1827 ,bottom=227 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ܱ���' ,left=1303 ,top=240 ,right=1514 ,bottom=269 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=274 ,right=1830 ,bottom=274 </L>
	<T>id='�ܱ��δ��ϼ�������' ,left=1303 ,top=279 ,right=1572 ,bottom=314 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=319 ,right=1830 ,bottom=319 </L>
	<T>id='��������' ,left=1303 ,top=324 ,right=1422 ,bottom=356 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=361 ,right=1830 ,bottom=361 </L>
	<T>id='������1 / �ܱ���9' ,left=1530 ,top=240 ,right=1827 ,bottom=269 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������ڵ�' ,left=1530 ,top=324 ,right=1709 ,bottom=356 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=187 ,right=1830 ,bottom=187 </L>
	<L> left=1293 ,top=187 ,right=1293 ,bottom=361 </L>
	<T>id='[���� ��24ȣ ����(1)]  ' ,left=29 ,top=90 ,right=1438 ,bottom=150 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=380 ,right=1851 ,bottom=380 </L>
	<C>id='HTITLE', left=629, top=298, right=1048, bottom=340, face='����', size=10, bold=true, underline=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ٷμҵ� ���޸���' ,left=598 ,top=240 ,right=1216 ,bottom=287 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷμҵ��õ¡��������' ,left=598 ,top=187 ,right=1216 ,bottom=235 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=550 ,top=243 ,right=579 ,bottom=277 ,border=true</X>
	<X>left=550 ,top=192 ,right=579 ,bottom=227 ,border=true</X>
	<T>id='����' ,left=71 ,top=190 ,right=184 ,bottom=229 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=71 ,top=232 ,right=184 ,bottom=269 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCNT', left=303, top=190, right=390, bottom=269, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2009 -' ,left=205 ,top=190 ,right=321 ,bottom=269 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=185 ,right=192 ,bottom=274 </L>
	<T>id='(���� �Ǵ� ��)' ,left=1482 ,top=2550 ,right=1748 ,bottom=2584 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2418 ,right=1851 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1522 ,top=187 ,right=1522 ,bottom=274 </L>
	<L> left=1830 ,top=190 ,right=1830 ,bottom=361 </L>
	<L> left=1577 ,top=274 ,right=1577 ,bottom=319 </L>
	<L> left=1527 ,top=319 ,right=1527 ,bottom=361 </L>
	<L> left=29 ,top=672 ,right=1851 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�켺��' ,left=221 ,top=564 ,right=508 ,bottom=609 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�Ϲ�ȣ' ,left=221 ,top=446 ,right=508 ,bottom=490 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� �� �� (�ּ�)' ,left=221 ,top=501 ,right=508 ,bottom=546 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ּ�' ,left=221 ,top=620 ,right=508 ,bottom=664 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� ǥ �� (��     ��)' ,left=1014 ,top=388 ,right=1356 ,bottom=432 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1385 ,top=388 ,right=1703 ,bottom=432 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� �� �� ȣ' ,left=1014 ,top=446 ,right=1356 ,bottom=490 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1385 ,top=446 ,right=1703 ,bottom=490 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� ��  �� ȣ' ,left=1014 ,top=564 ,right=1356 ,bottom=609 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1385, top=564, right=1819, bottom=609, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=213 ,top=496 ,right=1851 ,bottom=496 </L>
	<L> left=995 ,top=380 ,right=995 ,bottom=496 </L>
	<L> left=1364 ,top=380 ,right=1364 ,bottom=496 </L>
	<L> left=29 ,top=554 ,right=1851 ,bottom=554 </L>
	<L> left=998 ,top=554 ,right=998 ,bottom=614 </L>
	<L> left=1364 ,top=554 ,right=1364 ,bottom=614 </L>
	<T>id='��� �� �� (�� ȣ)' ,left=221 ,top=388 ,right=508 ,bottom=432 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǹ���' ,left=37 ,top=469 ,right=208 ,bottom=514 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡   ��' ,left=37 ,top=414 ,right=208 ,bottom=459 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ���' ,left=37 ,top=564 ,right=208 ,bottom=651 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=595 ,top=683 ,right=819 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=982, top=915, right=1079, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=840, top=915, right=937, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=857, right=1445, bottom=902, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=915, right=1445, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=857, right=1585, bottom=902, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=915, right=1585, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC11000,0,,PC11000)}', left=595, top=976, right=819, bottom=1020, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC12000,0,,PC12000)}', left=595, top=1031, right=819, bottom=1076, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=857, right=1696, bottom=902, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=857, right=1827, bottom=902, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=915, right=1696, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=915, right=1827, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1095, top=915, right=1187, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1222, top=915, right=1319, bottom=960, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=865 ,right=87 ,bottom=904 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=912 ,right=87 ,bottom=952 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=957 ,right=87 ,bottom=997 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ó' ,left=34 ,top=999 ,right=87 ,bottom=1039 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1042 ,right=87 ,bottom=1081 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1129 ,right=87 ,bottom=1168 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1171 ,right=87 ,bottom=1210 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1216 ,right=87 ,bottom=1255 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1084 ,right=87 ,bottom=1123 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��          ��' ,left=100 ,top=2025 ,right=582 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=400 ,top=2133 ,right=400 ,bottom=2297 </L>
	<T>id='�ҵ漼' ,left=695 ,top=2025 ,right=974 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=982 ,top=2025 ,right=1261 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ư����' ,left=1272 ,top=2025 ,right=1551 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1561 ,top=2025 ,right=1840 ,bottom=2070 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB41000,0,,PB41000)}', left=695, top=2083, right=974, bottom=2128, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB42000,0,,PB42000)}', left=982, top=2083, right=1261, bottom=2128, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB43000,0,,PB43000)}', left=1272, top=2083, right=1551, bottom=2128, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB40000,0,,PB40000)}', left=1561, top=2083, right=1840, bottom=2128, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='66)��(��)�ٹ���' ,left=197 ,top=2302 ,right=519 ,bottom=2347 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=503, top=2138, right=685, bottom=2183, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP141000,0,,BP141000)}', left=695, top=2138, right=974, bottom=2183, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP142000,0,,BP142000)}', left=982, top=2138, right=1261, bottom=2183, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP143000,0,,BP143000)}', left=1272, top=2138, right=1551, bottom=2183, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=503, top=2191, right=685, bottom=2236, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000,0,,BP241000)}', left=695, top=2191, right=974, bottom=2236, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP242000,0,,BP242000)}', left=982, top=2191, right=1261, bottom=2236, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP243000,0,,BP243000)}', left=1272, top=2191, right=1551, bottom=2236, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000+BP242000+BP243000,0,,BP241000+BP242000+BP243000)}', left=1561, top=2191, right=1840, bottom=2236, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='' ,left=503 ,top=2246 ,right=685 ,bottom=2291 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=695, top=2246, right=974, bottom=2291, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=982, top=2246, right=1261, bottom=2291, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1272, top=2246, right=1551, bottom=2291, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1561, top=2246, right=1840, bottom=2291, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB61000,0,,PB61000)}', left=695, top=2302, right=974, bottom=2347, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB62000,0,,PB62000)}', left=982, top=2302, right=1261, bottom=2347, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB63000,0,,PB63000)}', left=1272, top=2302, right=1551, bottom=2347, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB60000,0,,PB60000)}', left=1561, top=2302, right=1840, bottom=2347, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB71000,0,,PB71000)}', left=695, top=2362, right=974, bottom=2407, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB72000,0,,PB72000)}', left=982, top=2362, right=1261, bottom=2407, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB73000,0,,PB73000)}', left=1272, top=2362, right=1551, bottom=2407, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB70000,0,,PB70000)}', left=1561, top=2362, right=1840, bottom=2407, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=1550 ,right=87 ,bottom=1590 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1603 ,right=87 ,bottom=1643 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1661 ,right=87 ,bottom=1701 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1714 ,right=87 ,bottom=1753 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1764 ,right=87 ,bottom=1804 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1814 ,right=87 ,bottom=1854 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2159 ,right=87 ,bottom=2196 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2217 ,right=87 ,bottom=2257 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2273 ,right=87 ,bottom=2310 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2328 ,right=87 ,bottom=2365 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2107 ,right=87 ,bottom=2146 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC11000,0,,BC11000)}', left=848, top=976, right=1072, bottom=1020, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC12000,0,,BC12000)}', left=848, top=1031, right=1072, bottom=1076, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC21000,0,,BC21000)}', left=1106, top=976, right=1330, bottom=1020, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC22000,0,,BC22000)}', left=1106, top=1031, right=1330, bottom=1076, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM3', left=1356, top=741, right=1580, bottom=786, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO3', left=1356, top=799, right=1580, bottom=844, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC31000,0,,BC31000)}', left=1356, top=976, right=1580, bottom=1020, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC32000,0,,BC32000)}', left=1356, top=1031, right=1580, bottom=1076, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC2000,0,,PBC2000)}', left=1598, top=1031, right=1838, bottom=1076, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC1000,0,,PBC1000)}', left=1598, top=976, right=1838, bottom=1020, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC10000,0,,PC10000)}', left=595, top=1379, right=819, bottom=1424, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC10000,0,,BC10000)}', left=848, top=1379, right=1072, bottom=1424, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC20000,0,,BC20000)}', left=1106, top=1379, right=1330, bottom=1424, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC3000,0,,BC3000)}', left=1356, top=1379, right=1580, bottom=1424, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TWKSUM,0,,TWKSUM)}', left=1598, top=1379, right=1838, bottom=1424, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1321, right=819, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1321, right=1072, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1321, right=1330, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1321, right=1580, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1321, right=1838, bottom=1366, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1266, right=819, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1266, right=1072, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1266, right=1330, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1266, right=1580, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1266, right=1838, bottom=1310, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1205, right=819, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1205, right=1072, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1205, right=1330, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1205, right=1580, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1205, right=1838, bottom=1250, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1147, right=819, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1147, right=1072, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1147, right=1330, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1147, right=1580, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1147, right=1838, bottom=1192, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC13000,0,,PC13000)}', left=595, top=1089, right=819, bottom=1134, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC13000,0,,BC13000)}', left=848, top=1089, right=1072, bottom=1134, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC23000,0,,BC23000)}', left=1106, top=1089, right=1330, bottom=1134, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC33000,0,,BC33000)}', left=1356, top=1089, right=1580, bottom=1134, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC3000,0,,PBC3000)}', left=1598, top=1089, right=1838, bottom=1134, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1427 ,top=319 ,right=1427 ,bottom=361 </L>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1440, right=819, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1440, right=1330, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1440, right=1580, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=1598, top=1440, right=1838, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT201,0,,BTAXAMT201)}', left=1106, top=1495, right=1330, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1495, right=1580, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+BTAXAMT201,0,,BTAXAMT101+BTAXAMT201)}', left=1598, top=1495, right=1838, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='O01' ,left=408 ,top=1550 ,right=577 ,bottom=1595 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1550, right=819, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1550, right=1072, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1550, right=1330, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1550, right=1580, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1550, right=1838, bottom=1595, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Q01' ,left=408 ,top=1606 ,right=577 ,bottom=1651 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1606, right=819, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1606, right=1072, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1606, right=1330, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1606, right=1580, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1606, right=1838, bottom=1651, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1661, right=819, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=845, top=1661, right=1069, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1103, top=1661, right=1327, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1353, top=1661, right=1577, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1595, top=1661, right=1835, bottom=1706, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1717, right=819, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1717, right=1072, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1717, right=1330, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1717, right=1580, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1717, right=1838, bottom=1761, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1772, right=1072, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1772, right=1330, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1772, right=1580, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1772, right=1838, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1830, right=819, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1830, right=1072, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1830, right=1330, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1830, right=1580, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1830, right=1838, bottom=1875, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1893, right=1072, bottom=1938, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1893, right=1330, bottom=1938, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1893, right=1580, bottom=1938, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1893, right=1838, bottom=1938, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1962, right=819, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1962, right=1072, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1962, right=1330, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1962, right=1580, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+PC23000,0,,BTAXAMT101+PC23000)}', left=1598, top=1962, right=1838, bottom=2007, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=832 ,top=675 ,right=832 ,bottom=2017 </L>
	<L> left=1087 ,top=675 ,right=1087 ,bottom=2017 </L>
	<L> left=1590 ,top=675 ,right=1590 ,bottom=2017 </L>
	<L> left=192 ,top=2133 ,right=192 ,bottom=2352 </L>
	<C>id='CADDNM', left=592, top=620, right=1819, bottom=664, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='101-85-10695' ,left=592 ,top=446 ,right=885 ,bottom=490 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ���α� �赿 ������� 140-2' ,left=592 ,top=501 ,right=1727 ,bottom=546 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=592, top=564, right=885, bottom=609, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=592 ,top=388 ,right=885 ,bottom=432 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=587 ,top=380 ,right=587 ,bottom=2017 </L>
	<L> left=213 ,top=380 ,right=213 ,bottom=670 </L>
	<L> left=213 ,top=614 ,right=1851 ,bottom=614 </L>
	<C>id='CURDT2', left=1332, top=2492, right=1740, bottom=2529 ,mask='XXXX��  02��  28��', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=1203 ,top=2550 ,right=1435 ,bottom=2584 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=498 ,top=2133 ,right=498 ,bottom=2297 </L>
	<L> left=498 ,top=2241 ,right=1851 ,bottom=2241 </L>
	<L> left=498 ,top=2186 ,right=1851 ,bottom=2186 </L>
	<T>id='�ⳳ��' ,left=95 ,top=2191 ,right=187 ,bottom=2223 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=95 ,top=2228 ,right=184 ,bottom=2260 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1772, right=819, bottom=1817, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=213 ,top=438 ,right=1851 ,bottom=438 </L>
	<L> left=687 ,top=2014 ,right=687 ,bottom=2418 </L>
	<L> left=92 ,top=733 ,right=1851 ,bottom=733 </L>
	<L> left=92 ,top=791 ,right=1851 ,bottom=791 </L>
	<L> left=92 ,top=852 ,right=1851 ,bottom=852 </L>
	<L> left=92 ,top=907 ,right=1851 ,bottom=907 </L>
	<L> left=92 ,top=1371 ,right=1851 ,bottom=1371 </L>
	<L> left=92 ,top=1316 ,right=1851 ,bottom=1316 </L>
	<L> left=92 ,top=1258 ,right=1851 ,bottom=1258 </L>
	<L> left=92 ,top=1200 ,right=1851 ,bottom=1200 </L>
	<L> left=92 ,top=1142 ,right=1851 ,bottom=1142 </L>
	<L> left=92 ,top=1081 ,right=1851 ,bottom=1081 </L>
	<L> left=92 ,top=1026 ,right=1851 ,bottom=1026 </L>
	<L> left=92 ,top=968 ,right=1851 ,bottom=968 </L>
	<L> left=92 ,top=1490 ,right=1851 ,bottom=1490 </L>
	<L> left=92 ,top=1545 ,right=1851 ,bottom=1545 </L>
	<L> left=92 ,top=1600 ,right=1851 ,bottom=1600 </L>
	<L> left=92 ,top=1656 ,right=1851 ,bottom=1656 </L>
	<L> left=92 ,top=1711 ,right=1851 ,bottom=1711 </L>
	<L> left=92 ,top=1767 ,right=1851 ,bottom=1767 </L>
	<L> left=92 ,top=1822 ,right=1851 ,bottom=1822 </L>
	<L> left=92 ,top=1883 ,right=1851 ,bottom=1883 </L>
	<L> left=92 ,top=1949 ,right=1851 ,bottom=1949 </L>
	<L> left=92 ,top=2355 ,right=1851 ,bottom=2355 </L>
	<L> left=92 ,top=2133 ,right=1851 ,bottom=2133 </L>
	<L> left=92 ,top=2078 ,right=1851 ,bottom=2078 </L>
	<L> left=977 ,top=2014 ,right=977 ,bottom=2418 </L>
	<L> left=1266 ,top=2014 ,right=1266 ,bottom=2418 </L>
	<L> left=1556 ,top=2014 ,right=1556 ,bottom=2418 </L>
	<L> left=29 ,top=2014 ,right=1851 ,bottom=2014 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=672 ,right=90 ,bottom=2415 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='���� ��õ¡����(�ٷμҵ�)�� ����(����)�մϴ�.' ,left=29 ,top=2436 ,right=1851 ,bottom=2476 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������  ����' ,left=461 ,top=2587 ,right=740 ,bottom=2631 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��(����)�ǹ���' ,left=742 ,top=2550 ,right=1095 ,bottom=2584 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)��(��)�ٹ���' ,left=197 ,top=2149 ,right=395 ,bottom=2202 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�������׶���' ,left=197 ,top=2188 ,right=398 ,bottom=2244 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����)' ,left=197 ,top=2236 ,right=395 ,bottom=2281 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP141000+BP142000+BP143000,0,,BP141000+BP142000+BP143000)}', left=1561, top=2138, right=1840, bottom=2183, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��(��)' ,left=848 ,top=683 ,right=1072 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=1106 ,top=683 ,right=1330 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)-1��������' ,left=1356 ,top=683 ,right=1580 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1598 ,top=683 ,right=1838 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT3', left=590, top=857, right=706, bottom=902, align='left', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUTO', left=721, top=915, right=829, bottom=960, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUFR', left=590, top=915, right=706, bottom=960, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1340 ,top=675 ,right=1340 ,bottom=2017 </L>
	<C>id='BCWKNM1', left=835, top=741, right=1085, bottom=786, align='left', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM2', left=1090, top=741, right=1337, bottom=786, align='left', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=' ~' ,left=695 ,top=857 ,right=724 ,bottom=902 ,face='Arial' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=721, top=857, right=829, bottom=902, align='left', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT1', left=835, top=857, right=1085, bottom=902, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT2', left=1090, top=857, right=1337, bottom=902, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=405 ,top=2154 ,right=495 ,bottom=2199 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=405 ,top=2191 ,right=495 ,bottom=2236 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=405 ,top=2228 ,right=495 ,bottom=2273 ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=835, top=799, right=1085, bottom=844, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1090, top=799, right=1337, bottom=844, align='left', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=1432 ,right=1851 ,bottom=1432 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=403 ,top=1437 ,right=403 ,bottom=1949 </L>
	<T>id='��   ��' ,left=97 ,top=683 ,right=569 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)��   ��   ó   ��' ,left=97 ,top=741 ,right=569 ,bottom=786 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10)����ڵ�Ϲ�ȣ' ,left=97 ,top=799 ,right=569 ,bottom=844 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)�ٹ��Ⱓ' ,left=97 ,top=857 ,right=569 ,bottom=902 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)����Ⱓ' ,left=97 ,top=915 ,right=569 ,bottom=960 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13)��               ��' ,left=97 ,top=976 ,right=569 ,bottom=1020 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14)��               ��' ,left=97 ,top=1031 ,right=569 ,bottom=1076 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)��   ��   ��   ��' ,left=97 ,top=1092 ,right=569 ,bottom=1136 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-1�ֽĸż����ñ� �������' ,left=97 ,top=1150 ,right=569 ,bottom=1194 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-2�츮�������������' ,left=97 ,top=1208 ,right=569 ,bottom=1252 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-3' ,left=97 ,top=1268 ,right=569 ,bottom=1313 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-4' ,left=97 ,top=1324 ,right=569 ,bottom=1368 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)��' ,left=97 ,top=1382 ,right=569 ,bottom=1426 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-1 �߰��ٷμ���' ,left=97 ,top=1553 ,right=384 ,bottom=1598 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-2 ��꺸������' ,left=97 ,top=1608 ,right=384 ,bottom=1653 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-3 �ܱ��αٷ���' ,left=97 ,top=1664 ,right=384 ,bottom=1709 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-4' ,left=97 ,top=1719 ,right=384 ,bottom=1764 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-5' ,left=97 ,top=1775 ,right=384 ,bottom=1819 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-6' ,left=97 ,top=1833 ,right=384 ,bottom=1877 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)�� ���� �����' ,left=97 ,top=1896 ,right=384 ,bottom=1941 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20)������ҵ� ��' ,left=97 ,top=1964 ,right=569 ,bottom=2009 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)��     ��     ��     ��' ,left=97 ,top=2086 ,right=579 ,bottom=2130 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='67)��  ��  ¡  ��  ��  ��' ,left=97 ,top=2365 ,right=579 ,bottom=2410 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='M01' ,left=408 ,top=1440 ,right=577 ,bottom=1484 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=848, top=1440, right=1072, bottom=1484, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1495, right=1072, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1495, right=819, bottom=1540, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='M02' ,left=408 ,top=1495 ,right=577 ,bottom=1540 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(150����)' ,left=97 ,top=1495 ,right=400 ,bottom=1540 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(100����)' ,left=97 ,top=1440 ,right=398 ,bottom=1484 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='X01' ,left=408 ,top=1664 ,right=577 ,bottom=1709 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=2297 ,right=1851 ,bottom=2297 </L>
</B>





</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='8��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=2650 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=158 ,right=29 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(��2��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=156 ,right=90 ,bottom=2647 </L>
	<L> left=140 ,top=430 ,right=140 ,bottom=2560 </L>
	<T>id='��' ,left=145 ,top=881 ,right=184 ,bottom=910 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1392 ,right=184 ,bottom=1421 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1329 ,right=134 ,bottom=1368 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1160 ,right=84 ,bottom=1200 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1274 ,right=84 ,bottom=1313 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1387 ,right=84 ,bottom=1424 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1484 ,right=84 ,bottom=1521 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1606 ,right=84 ,bottom=1643 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1392 ,right=134 ,bottom=1432 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1458 ,right=134 ,bottom=1495 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1513 ,right=134 ,bottom=1550 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1564 ,right=134 ,bottom=1603 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1614 ,right=134 ,bottom=1656 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=912 ,right=184 ,bottom=941 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=947 ,right=184 ,bottom=976 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=983 ,right=184 ,bottom=1012 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=671 ,top=158 ,right=671 ,bottom=2650 </L>
	<L> left=1519 ,top=158 ,right=1519 ,bottom=2650 </L>
	<L> left=972 ,top=158 ,right=972 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=243 ,right=972 ,bottom=243 </L>
	<L> left=90 ,top=337 ,right=972 ,bottom=337 </L>
	<L> left=187 ,top=519 ,right=972 ,bottom=519 </L>
	<L> left=90 ,top=430 ,right=972 ,bottom=430 </L>
	<L> left=187 ,top=614 ,right=972 ,bottom=614 </L>
	<L> left=187 ,top=802 ,right=972 ,bottom=802 </L>
	<L> left=187 ,top=891 ,right=972 ,bottom=891 </L>
	<L> left=187 ,top=986 ,right=972 ,bottom=986 </L>
	<L> left=187 ,top=1081 ,right=972 ,bottom=1081 </L>
	<L> left=187 ,top=430 ,right=187 ,bottom=1263 </L>
	<L> left=140 ,top=1263 ,right=1851 ,bottom=1263 </L>
	<L> left=140 ,top=1361 ,right=1851 ,bottom=1361 </L>
	<L> left=187 ,top=1448 ,right=972 ,bottom=1448 </L>
	<L> left=187 ,top=1542 ,right=972 ,bottom=1542 </L>
	<L> left=140 ,top=1632 ,right=972 ,bottom=1632 </L>
	<L> left=187 ,top=1724 ,right=972 ,bottom=1724 </L>
	<L> left=187 ,top=1912 ,right=972 ,bottom=1912 </L>
	<L> left=187 ,top=2001 ,right=972 ,bottom=2001 </L>
	<L> left=187 ,top=2094 ,right=972 ,bottom=2094 </L>
	<L> left=187 ,top=2188 ,right=972 ,bottom=2188 </L>
	<L> left=187 ,top=2283 ,right=972 ,bottom=2283 </L>
	<L> left=187 ,top=2365 ,right=972 ,bottom=2365 </L>
	<L> left=187 ,top=2465 ,right=972 ,bottom=2465 </L>
	<L> left=187 ,top=1361 ,right=187 ,bottom=2563 </L>
	<L> left=1019 ,top=1361 ,right=1019 ,bottom=2563 </L>
	<L> left=1019 ,top=156 ,right=1019 ,bottom=1168 </L>
	<L> left=1019 ,top=243 ,right=1848 ,bottom=243 </L>
	<L> left=1019 ,top=337 ,right=1848 ,bottom=337 </L>
	<L> left=1019 ,top=430 ,right=1848 ,bottom=430 </L>
	<L> left=1019 ,top=519 ,right=1848 ,bottom=519 </L>
	<L> left=1019 ,top=614 ,right=1848 ,bottom=614 </L>
	<L> left=1019 ,top=707 ,right=1848 ,bottom=707 </L>
	<L> left=1019 ,top=802 ,right=1848 ,bottom=802 </L>
	<L> left=1019 ,top=891 ,right=1848 ,bottom=891 </L>
	<L> left=1019 ,top=986 ,right=1848 ,bottom=986 </L>
	<L> left=1019 ,top=1081 ,right=1848 ,bottom=1081 </L>
	<L> left=1019 ,top=1448 ,right=1848 ,bottom=1448 </L>
	<L> left=1019 ,top=1542 ,right=1848 ,bottom=1542 </L>
	<L> left=1019 ,top=1632 ,right=1848 ,bottom=1632 </L>
	<L> left=1019 ,top=1724 ,right=1848 ,bottom=1724 </L>
	<L> left=1019 ,top=1912 ,right=1848 ,bottom=1912 </L>
	<L> left=187 ,top=1811 ,right=1851 ,bottom=1811 </L>
	<L> left=1019 ,top=2001 ,right=1848 ,bottom=2001 </L>
	<L> left=1019 ,top=2094 ,right=1848 ,bottom=2094 </L>
	<L> left=1019 ,top=2188 ,right=1848 ,bottom=2188 </L>
	<L> left=1019 ,top=2283 ,right=1848 ,bottom=2283 </L>
	<L> left=1019 ,top=2365 ,right=1848 ,bottom=2365 </L>
	<L> left=1019 ,top=2465 ,right=1848 ,bottom=2465 </L>
	<L> left=90 ,top=2563 ,right=1851 ,bottom=2563 </L>
	<L> left=190 ,top=1168 ,right=1851 ,bottom=1168 </L>
	<L> left=140 ,top=707 ,right=972 ,bottom=707 </L>
	<T>id='42)�� �� �� �� �� ��' ,left=95 ,top=2573 ,right=577 ,bottom=2634 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)�� �� ��(16) �Ǵ� 16)- 18)-3)' ,left=97 ,top=169 ,right=663 ,bottom=229 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)�ٷμҵ����' ,left=97 ,top=261 ,right=663 ,bottom=322 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50)���ռҵ� ����ǥ��' ,left=979 ,top=1192 ,right=1459 ,bottom=1252 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB10000,0,,PB10000)}', left=679, top=169, right=964, bottom=229, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='43)���ο�������ҵ����' ,left=1029 ,top=169 ,right=1509 ,bottom=229 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT011S,0,,ETCAMT011S)}', left=1543, top=169, right=1825, bottom=229, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB20000,0,,PB20000)}', left=679, top=261, right=964, bottom=322, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)��������ҵ����' ,left=1029 ,top=261 ,right=1509 ,bottom=322 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT01S,0,,ETCAMT01S)}', left=1543, top=261, right=1825, bottom=322, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='23)�ٷμҵ�ݾ�' ,left=97 ,top=356 ,right=663 ,bottom=417 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB30000,0,,PB30000)}', left=679, top=356, right=964, bottom=417, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-1�ұ�����һ���� �����α� �ҵ����' ,left=1029 ,top=356 ,right=1509 ,bottom=417 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1543, top=356, right=1825, bottom=417, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='24)��         ��' ,left=205 ,top=446 ,right=490 ,bottom=506 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)��   ��   ��' ,left=205 ,top=541 ,right=500 ,bottom=601 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)�ξ簡��(' ,left=205 ,top=630 ,right=392 ,bottom=691 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)��ο��(' ,left=205 ,top=725 ,right=392 ,bottom=786 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)�� �� �� (' ,left=205 ,top=817 ,right=392 ,bottom=878 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)��   ��   ��' ,left=205 ,top=907 ,right=500 ,bottom=968 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)�ڳ������(' ,left=205 ,top=1002 ,right=421 ,bottom=1063 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=679, top=446, right=964, bottom=506, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-2���ø������� �ҵ����' ,left=1029 ,top=446 ,right=1509 ,bottom=506 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HOUAMT01S,0,,HOUAMT01S)}', left=1543, top=446, right=1825, bottom=506, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=679, top=541, right=964, bottom=601, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='45)�����������ڵ�ҵ����' ,left=1029 ,top=541 ,right=1509 ,bottom=601 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT02S,0,,ETCAMT02S)}', left=1543, top=541, right=1825, bottom=601, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BA0101CNT,0,,BA0101CNT)}', left=395, top=630, right=458, bottom=691 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=630 ,right=516 ,bottom=691 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=679, top=630, right=964, bottom=691, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='46)�ſ�ī���ҵ����' ,left=1029 ,top=630 ,right=1509 ,bottom=691 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT03S,0,,ETCAMT03S)}', left=1543, top=630, right=1825, bottom=691, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TOTCNT02,0,,TOTCNT02)}', left=395, top=725, right=455, bottom=786 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=725 ,right=516 ,bottom=786 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=679, top=725, right=964, bottom=786, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='47)�츮�������ռҵ����' ,left=1029 ,top=725 ,right=1509 ,bottom=786 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT04S,0,,ETCAMT04S)}', left=1543, top=725, right=1825, bottom=786, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0103CNT,0,,AD0103CNT)}', left=395, top=817, right=455, bottom=878 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=817 ,right=516 ,bottom=878 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=679, top=817, right=964, bottom=878, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='48)����ֽ�������ҵ����' ,left=1029 ,top=817 ,right=1509 ,bottom=878 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(FNDSUMS,0,,FNDSUMS)}', left=1543, top=817, right=1825, bottom=878, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=679, top=907, right=964, bottom=968, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0105CNT,0,,AD0105CNT)}', left=427, top=1002, right=469, bottom=1063 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=471 ,top=1002 ,right=519 ,bottom=1063 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=679, top=1002, right=964, bottom=1063, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT07,0,,ADAMT07)}', left=679, top=1094, right=964, bottom=1155, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1543, top=1094, right=1825, bottom=1155, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='49)�� ���� �ҵ���� ��' ,left=1029 ,top=1094 ,right=1509 ,bottom=1155 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TSTDSUM,0,,TSTDSUM)}', left=1543, top=1192, right=1825, bottom=1252, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='31)���ڳ��߰�����(' ,left=153 ,top=1281 ,right=445 ,bottom=1342 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0106CNT,0,,AD0106CNT)}', left=453, top=1281, right=513, bottom=1342 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=516 ,top=1281 ,right=571 ,bottom=1342 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)���ο��ݺ�������' ,left=200 ,top=1376 ,right=529 ,bottom=1437 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1��Ÿ ���ݺ�������' ,left=197 ,top=1466 ,right=577 ,bottom=1527 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)�������ݼҵ����' ,left=200 ,top=1558 ,right=524 ,bottom=1619 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)��   ��   ��' ,left=200 ,top=1648 ,right=521 ,bottom=1709 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)��   ��   ��' ,left=205 ,top=1835 ,right=527 ,bottom=1896 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)�����������Աݿ����ݻ�ȯ��' ,left=200 ,top=1930 ,right=616 ,bottom=1991 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)-1��������������Ա����ڻ�ȯ��' ,left=200 ,top=2020 ,right=666 ,bottom=2080 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)��α�' ,left=200 ,top=2115 ,right=521 ,bottom=2175 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)' ,left=197 ,top=2207 ,right=519 ,bottom=2268 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)      ��' ,left=200 ,top=2384 ,right=521 ,bottom=2444 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)ǥ �� �� ��' ,left=200 ,top=2481 ,right=521 ,bottom=2542 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT05S,0,,ADAMT05S)}', left=679, top=1281, right=964, bottom=1342, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='51)��     ��     ��     ��' ,left=979 ,top=1281 ,right=1459 ,bottom=1342 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDTAX,0,,STDTAX)}', left=1543, top=1281, right=1825, bottom=1342, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUMS,0,,PENSUMS)}', left=679, top=1376, right=964, bottom=1437, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='52)[��   ��   ��   ��]' ,left=1029 ,top=1376 ,right=1509 ,bottom=1437 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT01S,0,,REDAMT01S)}', left=1543, top=1376, right=1825, bottom=1437, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='53)[����Ư�����ѹ�]' ,left=1029 ,top=1466 ,right=1509 ,bottom=1527 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT02S,0,,REDAMT02S)}', left=1543, top=1466, right=1825, bottom=1527, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT05,0,,ETCAMT05)}', left=679, top=1558, right=964, bottom=1619, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='54)' ,left=1029 ,top=1558 ,right=1509 ,bottom=1619 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=679, top=1648, right=964, bottom=1709, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='35)��   ��   ��' ,left=203 ,top=1738 ,right=524 ,bottom=1798 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=679, top=1738, right=964, bottom=1798, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='55)���װ��� ��' ,left=1029 ,top=1738 ,right=1509 ,bottom=1798 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDSUM,0,,REDSUM)}', left=1543, top=1738, right=1825, bottom=1798, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=679, top=1466, right=961, bottom=1527, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='56)��  ��   ��  ��' ,left=1029 ,top=1835 ,right=1509 ,bottom=1896 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)�������հ���' ,left=1029 ,top=1930 ,right=1509 ,bottom=1991 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)�� �� �� �� ��' ,left=1029 ,top=2020 ,right=1509 ,bottom=2080 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)��� ��ġ�ڱ�' ,left=1029 ,top=2115 ,right=1509 ,bottom=2175 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT01S,0,,DEDAMT01S)}', left=1543, top=1835, right=1825, bottom=1896, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02S,0,,DEDAMT02S)}', left=1543, top=1930, right=1825, bottom=1991, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03S,0,,DEDAMT03S)}', left=1543, top=2020, right=1825, bottom=2080, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04S,0,,DEDAMT04S)}', left=1543, top=2115, right=1825, bottom=2175, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='60)��  ��   ��  ��' ,left=1029 ,top=2207 ,right=1509 ,bottom=2268 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT05S,0,,DEDAMT05S)}', left=1543, top=2207, right=1825, bottom=2268, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=679, top=1835, right=964, bottom=1896, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02S,0,,HOUAMT02S)}', left=679, top=1930, right=964, bottom=1991, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT34S,0,,HOUAMT34S)}', left=679, top=2020, right=964, bottom=2080, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONSUM,0,,CONSUM)}', left=679, top=2115, right=964, bottom=2175, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=679, top=2384, right=964, bottom=2444, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='62)' ,left=1029 ,top=2384 ,right=1509 ,bottom=2444 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1029 ,top=2297 ,right=1509 ,bottom=2357 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=679, top=2481, right=964, bottom=2542, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='63)�� �� �� �� ��' ,left=1029 ,top=2481 ,right=1509 ,bottom=2542 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1543, top=2481, right=1825, bottom=2542, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=679, top=2573, right=964, bottom=2634, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� �� ��[51)-55)-63)]' ,left=979 ,top=2573 ,right=1459 ,bottom=2634 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(RESSUM,0,,RESSUM)}', left=1543, top=2573, right=1825, bottom=2634, align='right', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=977 ,top=454 ,right=1016 ,bottom=493 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1421 ,right=184 ,bottom=1450 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1450 ,right=184 ,bottom=1479 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1471 ,right=184 ,bottom=1508 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1503 ,right=184 ,bottom=1535 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1532 ,right=184 ,bottom=1564 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1564 ,right=184 ,bottom=1595 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1484 ,right=1016 ,bottom=1521 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1535 ,right=1016 ,bottom=1571 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1587 ,right=1016 ,bottom=1627 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1645 ,right=1016 ,bottom=1687 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2070 ,right=1016 ,bottom=2107 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2130 ,right=1016 ,bottom=2167 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2194 ,right=1016 ,bottom=2233 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2257 ,right=1016 ,bottom=2299 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=145 ,top=1941 ,right=184 ,bottom=1999 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2030 ,right=184 ,bottom=2088 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2123 ,right=184 ,bottom=2183 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2225 ,right=184 ,bottom=2286 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=501 ,right=184 ,bottom=530 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=530 ,right=184 ,bottom=559 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=559 ,right=184 ,bottom=588 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=588 ,right=184 ,bottom=617 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=559 ,right=1016 ,bottom=599 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=614 ,right=1016 ,bottom=651 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=691 ,right=1016 ,bottom=728 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=736 ,right=1016 ,bottom=773 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=783 ,right=1016 ,bottom=823 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=831 ,right=1016 ,bottom=873 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)-1��������߼ұ���ٷ��ڼҵ����' ,left=1029 ,top=907 ,right=1516 ,bottom=968 ,align='left' ,face='����' ,size=8  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0107CNT,0,,AD0107CNT)}', left=487, top=1094, right=532, bottom=1155 ,mask='(XX��)', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=532 ,top=1094 ,right=574 ,bottom=1155 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)-1�����Ծ���(' ,left=205 ,top=1094 ,right=484 ,bottom=1155 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>


<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='9��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print1'
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=614 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��)' ,left=305 ,top=562 ,right=358 ,bottom=606 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='68)�ҵ���� ��(���������׸��� �ش���� O ǥ�ø� �ϸ�, ���� �ҵ���� �׸��� ������ ���Ͽ� ���� ������ �ݾ��� �����ϴ�)' ,left=71 ,top=87 ,right=1888 ,bottom=148 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=69 ,right=1901 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='������' ,left=71 ,top=324 ,right=147 ,bottom=369 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�' ,left=71 ,top=208 ,right=147 ,bottom=253 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=158 ,top=166 ,right=427 ,bottom=253 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=166 ,right=147 ,bottom=208 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=153 ,top=161 ,right=153 ,bottom=488 </L>
	<T>id='�������� �׸�' ,left=103 ,top=493 ,right=374 ,bottom=538 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���ڳ�' ,left=103 ,top=562 ,right=224 ,bottom=606 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=359 ,right=147 ,bottom=403 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��         ȣ' ,left=158 ,top=359 ,right=429 ,bottom=403 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� ��' ,left=158 ,top=324 ,right=429 ,bottom=369 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻' ,left=434 ,top=277 ,right=498 ,bottom=322 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=322 ,right=498 ,bottom=364 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�γ�' ,left=434 ,top=377 ,right=498 ,bottom=414 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=434 ,top=409 ,right=498 ,bottom=446 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=440 ,right=498 ,bottom=477 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=369 ,right=498 ,bottom=369 </L>
	<T>id='���' ,left=505 ,top=306 ,right=569 ,bottom=351 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=505 ,top=343 ,right=569 ,bottom=388 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=505 ,top=380 ,right=569 ,bottom=422 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=577 ,top=411 ,right=640 ,bottom=456 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=382 ,right=640 ,bottom=419 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ծ�' ,left=577 ,top=343 ,right=640 ,bottom=388 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=327 ,right=640 ,bottom=348 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=577 ,top=293 ,right=640 ,bottom=337 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=648 ,top=301 ,right=711 ,bottom=345 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=648 ,top=337 ,right=711 ,bottom=374 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=648 ,top=372 ,right=711 ,bottom=417 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڳ�' ,left=719 ,top=287 ,right=782 ,bottom=332 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=322 ,right=782 ,bottom=367 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=719 ,top=359 ,right=782 ,bottom=396 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=390 ,right=782 ,bottom=435 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=161 ,right=429 ,bottom=609 </L>
	<L> left=571 ,top=256 ,right=571 ,bottom=609 </L>
	<L> left=642 ,top=256 ,right=642 ,bottom=609 </L>
	<L> left=713 ,top=256 ,right=713 ,bottom=609 </L>
	<T>id='�������� �׸�' ,left=434 ,top=166 ,right=782 ,bottom=253 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=543 ,right=498 ,bottom=543 </L>
	<L> left=895 ,top=161 ,right=895 ,bottom=609 </L>
	<T>id='���� �ҵ���� �׸�' ,left=900 ,top=166 ,right=1898 ,bottom=253 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=932 ,top=290 ,right=1037 ,bottom=335 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ǰ������' ,left=898 ,top=332 ,right=1069 ,bottom=377 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����)' ,left=898 ,top=369 ,right=1069 ,bottom=414 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ��' ,left=1077 ,top=264 ,right=1232 ,bottom=480 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1243 ,top=261 ,right=1398 ,bottom=477 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1738 ,top=261 ,right=1898 ,bottom=477 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1732 ,top=256 ,right=1732 ,bottom=609 </L>
	<L> left=1403 ,top=256 ,right=1403 ,bottom=609 </L>
	<L> left=1237 ,top=256 ,right=1237 ,bottom=609 </L>
	<L> left=1072 ,top=256 ,right=1072 ,bottom=609 </L>
	<C>id='{decode(TREF25,0,,TREF25)}', left=1590, top=554, right=1706, bottom=601, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF11,0,,TREF11)}', left=898, top=498, right=1069, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=1077, top=498, right=1232, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1243, top=498, right=1398, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF14,0,,TREF14)}', left=1411, top=498, right=1567, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1577, top=498, right=1727, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1738, top=498, right=1898, bottom=543, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF21,0,,TREF21)}', left=898, top=554, right=1069, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=1077, top=554, right=1232, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1243, top=554, right=1398, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1411, top=554, right=1567, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1738, top=554, right=1898, bottom=601, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=893 ,top=256 ,right=1901 ,bottom=256 </L>
	<T>id='�ڷ�' ,left=795 ,top=293 ,right=893 ,bottom=337 ,supplevel=1 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=795 ,top=335 ,right=893 ,bottom=372 ,supplevel=1 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=795 ,top=496 ,right=893 ,bottom=543 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=554 ,right=893 ,bottom=601 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=790 ,top=161 ,right=790 ,bottom=609 </L>
	<L> left=61 ,top=161 ,right=1901 ,bottom=161 </L>
	<L> left=61 ,top=483 ,right=1901 ,bottom=483 </L>
	<L> left=61 ,top=488 ,right=1901 ,bottom=488 </L>
	<L> left=790 ,top=548 ,right=898 ,bottom=548 </L>
	<L> left=58 ,top=256 ,right=790 ,bottom=256 </L>
	<L> left=61 ,top=604 ,right=1901 ,bottom=604 </L>
	<L> left=58 ,top=69 ,right=58 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1901 ,top=69 ,right=1901 ,bottom=612 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=898 ,top=548 ,right=1901 ,bottom=548 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=500 ,top=256 ,right=500 ,bottom=609 </L>
	<L> left=61 ,top=609 ,right=1901 ,bottom=609 </L>
	<X>left=1572 ,top=551 ,right=1732 ,bottom=604 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1403 ,top=374 ,right=1732 ,bottom=374 </L>
	<L> left=895 ,top=256 ,right=1901 ,bottom=256 </L>
	<L> left=1572 ,top=374 ,right=1572 ,bottom=609 </L>
	<T>id='�ſ�ī�� ��' ,left=1477 ,top=264 ,right=1667 ,bottom=332 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=1477 ,top=314 ,right=1667 ,bottom=356 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī�� ��' ,left=1409 ,top=401 ,right=1564 ,bottom=435 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ī�� ��' ,left=1409 ,top=432 ,right=1569 ,bottom=467 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1577 ,top=432 ,right=1727 ,bottom=467 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1577 ,top=401 ,right=1727 ,bottom=435 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ϴ� �ο����� ����' ,left=63 ,top=527 ,right=427 ,bottom=564 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��3��)' ,left=1622 ,top=8 ,right=1877 ,bottom=61 ,align='right' ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AD0106CNT', left=226, top=562, right=305, bottom=606, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=105 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=105 ,right=1901 ,bottom=105 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=153 ,top=3 ,right=153 ,bottom=105 </L>
	<C>id='RESINO1', left=158, top=58, right=427, bottom=103 ,mask='XXXXXX-XXXXXXX', face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=158, top=5, right=427, bottom=50, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=429 ,top=0 ,right=429 ,bottom=103 </L>
	<C>id='{decode(REF1,T,��,T,��,)}', left=74, top=58, right=147, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1', left=74, top=5, right=147, bottom=50, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2', left=434, top=5, right=498, bottom=50, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=434, top=58, right=498, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=500 ,top=0 ,right=500 ,bottom=103 </L>
	<C>id='REF5', left=505, top=8, right=569, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=571 ,top=0 ,right=571 ,bottom=103 </L>
	<C>id='REF8', left=577, top=8, right=640, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=642 ,top=0 ,right=642 ,bottom=103 </L>
	<C>id='REF3', left=648, top=8, right=711, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=713 ,top=0 ,right=713 ,bottom=103 </L>
	<L> left=429 ,top=53 ,right=63 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=895 ,top=0 ,right=895 ,bottom=103 </L>
	<L> left=1072 ,top=0 ,right=1072 ,bottom=103 </L>
	<L> left=1237 ,top=0 ,right=1237 ,bottom=103 </L>
	<L> left=1403 ,top=0 ,right=1403 ,bottom=103 </L>
	<L> left=1732 ,top=0 ,right=1732 ,bottom=103 </L>
	<C>id='{decode(REF21,0,,REF21)}', left=898, top=58, right=1069, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=1077, top=58, right=1232, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1243, top=58, right=1398, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1411, top=58, right=1567, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1738, top=58, right=1898, bottom=103, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11,0,,REF11)}', left=898, top=8, right=1069, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=1077, top=8, right=1232, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1243, top=8, right=1398, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1411, top=8, right=1567, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25,0,,REF25)}', left=1601, top=58, right=1706, bottom=103, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1738, top=8, right=1898, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1577, top=8, right=1727, bottom=53, align='right', face='����', size=8, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=795 ,top=8 ,right=893 ,bottom=53 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=58 ,right=893 ,bottom=103 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=898 ,top=53 ,right=1901 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=790 ,top=3 ,right=790 ,bottom=105 </L>
	<C>id='REF4', left=719, top=8, right=782, bottom=103, face='����', size=9, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=432 ,top=53 ,right=500 ,bottom=53 </L>
	<L> left=790 ,top=53 ,right=903 ,bottom=53 </L>
	<L> left=1572 ,top=0 ,right=1572 ,bottom=103 </L>
	<X>left=1572 ,top=55 ,right=1732 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2001 ,bottom=967 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�� �ۼ����' ,left=74 ,top=13 ,right=279 ,bottom=58 ,align='left' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     (* ISO�����ڵ� : ����ûȨ������->��������->������������->���������ڷ�ǿ��� ��ȸ �� �� �ֽ��ϴ�. ��) ���ѹα�: KR, �̱� : US' ,left=71 ,top=98 ,right=1888 ,bottom=137 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ���� ���޸����� �����Ͽ��� �մϴ�.' ,left=71 ,top=171 ,right=1888 ,bottom=211 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. ��õ¡���ǹ��ڴ� �������� ���ϴ� ������ ���� ���� 3�� 10��(�޾� �Ǵ� ����� ��쿡�� �޾��� �Ǵ� ������� ���ϴ� ���� ���� ���� �� ������ ���մϴ�)' ,left=71 ,top=134 ,right=1888 ,bottom=174 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=61 ,top=965 ,right=1906 ,bottom=965 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='  3. ���ٹ�ó���ҵ������ ������ҵ�(�ܱ��αٷ��� 30% ����� ����)�� ������ �ݾ��� ����, ��.������ҵ������ ���޸��� �ۼ���� ������ҵ��� ������ҵ���' ,left=71 ,top=208 ,right=1888 ,bottom=248 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. �����ٷμҵ�� �����ٷμҵ��� ���Ͽ� ���������ϴ� ������ 16)-1 �������ն��� ���� �����ٷμҵ泳�����հ� �����ٷμҵ���  ����, [�ҵ漼�� �����] ' ,left=71 ,top=279 ,right=1888 ,bottom=319 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ��150���� ���� �������հ����ݾ��� 57)�������հ������� �����ϴ�. �պ�, ������� ���� ������ �ش� ������ ���������� �ϴ� ��쿡 ���պ�����, ' ,left=71 ,top=316 ,right=1888 ,bottom=359 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ������º������� �ҵ��� �ٹ�ó���ҵ�� ��(��)���� ������ �����ϴ�.' ,left=71 ,top=353 ,right=1888 ,bottom=396 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 18-3���� �ܱ��αٷ��ڰ� [����Ư�����ѹ�] �� 18����2��1���� �����ϴ� ��쿡�� ������, 16)����� �ݾ׿� 100���� 30�� ���� �ݾ��� �����ϴ�.' ,left=71 ,top=390 ,right=1888 ,bottom=432 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 21)�ѱ޿������� 16)����� �ݾ��� ����, 18)-3���� �ݾ��� �ִ� ��쿡�� 16)����� �ݾ׿��� 18)-3���� �ݾ��� �� �ݾ��� ������, �ܱ��αٷ��ڰ� ' ,left=71 ,top=427 ,right=1888 ,bottom=469 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    [����Ư�����ѹ�] ��18����2��2�׿� ���� ���ϼ����� �����ϴ� ��쿡�� 16)���� �ݾְ� ������ҵ�ݾ��� ���� �ݾ��� ����, �ҵ漼�� ������ ����� .����.����' ,left=71 ,top=464 ,right=1888 ,bottom=506 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �� ���װ����� ���� ������ �������� �ʽ��ϴ�.' ,left=71 ,top=501 ,right=1888 ,bottom=543 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. ���ռҵ� Ư������[34) ~ 39)]���� �� ���� �ҵ����[43)~47)]���� ���� ��37ȣ������ �������� �����ϴ�.' ,left=71 ,top=541 ,right=1888 ,bottom=580 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. �� ���Ŀ� ���� �ݾ� �� �Ҽ��� ���� ���� ������, 67) ����¡�������� �Ҿ׺�¡��(1õ�� �̸��� ���մϴ�)�� �ش��ϴ� ��� ������ 0 ���� �����ϴ�.' ,left=71 ,top=577 ,right=1888 ,bottom=617 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68) �ҵ���� ������ 2006�� ���� �߻��ϴ� �ٷμҵ� ��������к��� ����մϴ�.' ,left=71 ,top=614 ,right=1888 ,bottom=654 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �����ڵ�� : �ҵ��� ����=0, �ҵ����� ��������=1, ������� ��������=2, �����=3, ������ �ڳ�=4, ������ �ڳ� �� = 5 �����ڸ�=6, ��Ÿ=7�� �����ϴ�' ,left=71 ,top=654 ,right=1888 ,bottom=693 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='           (4��5��6��7�� ��� �ҵ��ڿ� ������� ������ ���踦 �����մϴ�). ' ,left=71 ,top=691 ,right=1888 ,bottom=730 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ��.�ܱ��ζ� : �������� ��� 1 ��, �ܱ����� ��� 9 �� �����ϴ�.' ,left=71 ,top=728 ,right=1888 ,bottom=767 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���������׸�� : �������������� �ִ� ��� �ش���� O ǥ�ø� �մϴ�(�ش������ ���� ��� ����Ӵϴ�).' ,left=71 ,top=765 ,right=1888 ,bottom=804 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ����û �ڷ�� : [�ҵ漼��] ��165���� ���� ����û Ȩ���������� �����ϴ� �� �ҵ���� �׸��� �ݾ� �� �ҵ��������� �Ǵ� �ݾ���  �����ϴ�.' ,left=71 ,top=802 ,right=1888 ,bottom=841 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �� ���� �ڷ�� : ����û���� �����ϴ� �������� ���� ���� ���մϴ�.(���� ���, �п��� ���γ��ο������� �ſ�ī�� �� ����, �÷±����� �Ȱ汸�Ժ�� ' ,left=71 ,top=838 ,right=1888 ,bottom=878 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='        �Ƿ����� ���� �����ϴ�).' ,left=71 ,top=875 ,right=1888 ,bottom=915 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���� �ҵ���� �׸�� : �ҵ�����׸� �ش��ϴ� ���� ����ݾ��� �����ϴ�(�ҵ�������� �ƴ� ���� ���ݾ��� �����׸񺰷� ���е� ���� �ȿ� �����ϴ�).' ,left=71 ,top=912 ,right=1888 ,bottom=952 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �ش� �ڵ庰�� �����Ͽ� �����ϴ�. (������׸��� ���� ��� ��.����� �ҵ���� 20)������ҵ� ����� �Ѿ׸� ���� ��.����� �ҵ���� ������ �ۼ� �����մϴ�.)' ,left=71 ,top=240 ,right=1888 ,bottom=279 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. ���������� ���������ڵ�� ������ڿ� �ش��ϴ� ��쿡 ���Ͽ� ������, ����ǥ��ȭ�ⱸ(ISO)�� ���� ISO�ڵ� �� ������ �� �����ڵ带 �����ϴ�.' ,left=79 ,top=61 ,right=1896 ,bottom=100 ,align='left' ,face='����' ,size=7  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>





<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   �������� ���� ��Ȳ
------------------------------------------------------------------------------>


<comment id="__NSID__">
<OBJECT id=gcrp_print4  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print2">
	<param NAME="DetailDataID"				VALUE="gcds_print2">
	<PARAM NAME="PaperSize"						VALUE="A3">	
	<PARAM NAME="LandScape"						VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="FixPaperSize"				VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="PreviewZoom"					VALUE="70">
	<PARAM NAME="Format"							VALUE="
<B>id=Header ,left=0,top=0 ,right=4100 ,bottom=144 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1631 ,top=34 ,right=2506 ,bottom=112 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1619 ,top=25 ,right=2500 ,bottom=103 ,border=true</X>
	<C>id='CURDT', left=1625, top=31, right=2494, bottom=97 ,mask='�������� XXXX �� ���� ��Ȳ', face='HY�߰��', size=12, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(����:��)' ,left=3872 ,top=100 ,right=4084 ,bottom=144 ,align='right' ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4100 ,bottom=166 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�ֹμ�' ,left=3816 ,top=119 ,right=3947 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=3956 ,top=119 ,right=4088 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����¡�� ����' ,left=3675 ,top=19 ,right=4088 ,bottom=106 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ�����' ,left=1988 ,top=19 ,right=2400 ,bottom=106 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=3253 ,top=119 ,right=3384 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ漼' ,left=3113 ,top=119 ,right=3244 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2825 ,top=9 ,right=2825 ,bottom=166 </L>
	<T>id='�ѱ޿�' ,left=2409 ,top=19 ,right=2822 ,bottom=59 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(����� ����)' ,left=2409 ,top=66 ,right=2822 ,bottom=106 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ܱٷμҵ�' ,left=1566 ,top=19 ,right=1978 ,bottom=106 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=2831 ,top=19 ,right=3103 ,bottom=106 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2403 ,top=9 ,right=2403 ,bottom=166 </L>
	<L> left=1981 ,top=9 ,right=1981 ,bottom=166 </L>
	<T>id='70~' ,left=941 ,top=119 ,right=1000 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=72 ,top=9 ,right=72 ,bottom=166 </L>
	<L> left=3 ,top=9 ,right=3 ,bottom=166 </L>
	<L> left=353 ,top=9 ,right=353 ,bottom=166 </L>
	<L> left=725 ,top=9 ,right=725 ,bottom=166 </L>
	<L> left=616 ,top=9 ,right=616 ,bottom=166 </L>
	<L> left=463 ,top=9 ,right=463 ,bottom=166 </L>
	<T>id='(����� ����)' ,left=1144 ,top=66 ,right=1556 ,bottom=106 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����޿���' ,left=1144 ,top=19 ,right=1556 ,bottom=59 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1138 ,top=9 ,right=1138 ,bottom=166 </L>
	<L> left=1559 ,top=9 ,right=1559 ,bottom=166 </L>
	<L> left=1138 ,top=112 ,right=4091 ,bottom=112 </L>
	<T>id='���ٹ���' ,left=1144 ,top=119 ,right=1275 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65~' ,left=872 ,top=119 ,right=931 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=866 ,top=112 ,right=1003 ,bottom=112 </L>
	<T>id='����' ,left=9 ,top=16 ,right=69 ,bottom=162 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=466 ,top=16 ,right=613 ,bottom=162 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڳ�' ,left=1009 ,top=72 ,right=1066 ,bottom=112 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=731 ,top=69 ,right=769 ,bottom=162 ,face='Arial' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=772 ,top=62 ,right=772 ,bottom=166 </L>
	<L> left=819 ,top=62 ,right=819 ,bottom=166 </L>
	<L> left=1003 ,top=62 ,right=1003 ,bottom=166 </L>
	<L> left=866 ,top=62 ,right=866 ,bottom=166 </L>
	<L> left=3 ,top=166 ,right=4091 ,bottom=166 </L>
	<T>id='��' ,left=872 ,top=69 ,right=1000 ,bottom=109 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=731 ,top=16 ,right=1131 ,bottom=56 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=9 ,right=4091 ,bottom=9 </L>
	<L> left=725 ,top=62 ,right=1138 ,bottom=62 </L>
	<T>id='����' ,left=1009 ,top=119 ,right=1066 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=825 ,top=69 ,right=863 ,bottom=162 ,face='Arial' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=778 ,top=69 ,right=816 ,bottom=162 ,face='Arial' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�γ�' ,left=1075 ,top=72 ,right=1131 ,bottom=112 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1075 ,top=119 ,right=1131 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=1284 ,top=119 ,right=1416 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1425 ,top=119 ,right=1556 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2269 ,top=119 ,right=2400 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=1988 ,top=119 ,right=2119 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=2128 ,top=119 ,right=2259 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1847 ,top=119 ,right=1978 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=1706 ,top=119 ,right=1838 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=1566 ,top=119 ,right=1697 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2691 ,top=119 ,right=2822 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=2550 ,top=119 ,right=2681 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=2409 ,top=119 ,right=2541 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=934 ,top=112 ,right=934 ,bottom=166 </L>
	<L> left=1841 ,top=112 ,right=1841 ,bottom=166 </L>
	<L> left=1700 ,top=112 ,right=1700 ,bottom=166 </L>
	<L> left=2263 ,top=112 ,right=2263 ,bottom=166 </L>
	<L> left=2122 ,top=112 ,right=2122 ,bottom=166 </L>
	<L> left=2684 ,top=112 ,right=2684 ,bottom=166 </L>
	<L> left=2544 ,top=112 ,right=2544 ,bottom=166 </L>
	<L> left=1419 ,top=112 ,right=1419 ,bottom=166 </L>
	<L> left=1278 ,top=112 ,right=1278 ,bottom=166 </L>
	<T>id='�ҵ漼' ,left=2831 ,top=119 ,right=2963 ,bottom=159 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3106 ,top=9 ,right=3106 ,bottom=166 </L>
	<T>id='�ֹμ�' ,left=2972 ,top=119 ,right=3103 ,bottom=159 ,face='����' ,size=10  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ��� ����' ,left=3113 ,top=19 ,right=3384 ,bottom=106 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3247 ,top=112 ,right=3247 ,bottom=166 </L>
	<L> left=2966 ,top=112 ,right=2966 ,bottom=166 </L>
	<L> left=1069 ,top=62 ,right=1069 ,bottom=166 </L>
	<T>id='�μ�' ,left=78 ,top=16 ,right=350 ,bottom=162 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ漼' ,left=3394 ,top=119 ,right=3525 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3669 ,top=9 ,right=3669 ,bottom=166 </L>
	<T>id='�ֹμ�' ,left=3534 ,top=119 ,right=3666 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ��� ����' ,left=3394 ,top=19 ,right=3666 ,bottom=106 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3528 ,top=112 ,right=3528 ,bottom=166 </L>
	<T>id='�ҵ漼' ,left=3675 ,top=119 ,right=3806 ,bottom=159 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=4091 ,top=9 ,right=4091 ,bottom=166 </L>
	<L> left=3950 ,top=112 ,right=3950 ,bottom=166 </L>
	<L> left=3809 ,top=112 ,right=3809 ,bottom=166 </L>
	<L> left=3388 ,top=9 ,right=3388 ,bottom=166 </L>
	<T>id='���' ,left=359 ,top=16 ,right=459 ,bottom=162 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=622 ,top=16 ,right=722 ,bottom=162 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=4100 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3 ,top=0 ,right=3 ,bottom=50 </L>
	<L> left=3 ,top=50 ,right=4091 ,bottom=50 </L>
	<L> left=72 ,top=0 ,right=72 ,bottom=50 </L>
	<L> left=353 ,top=0 ,right=353 ,bottom=50 </L>
	<L> left=616 ,top=0 ,right=616 ,bottom=50 </L>
	<L> left=725 ,top=0 ,right=725 ,bottom=50 </L>
	<L> left=2966 ,top=0 ,right=2966 ,bottom=50 </L>
	<L> left=3247 ,top=0 ,right=3247 ,bottom=50 </L>
	<L> left=3388 ,top=0 ,right=3388 ,bottom=50 </L>
	<L> left=3528 ,top=0 ,right=3528 ,bottom=50 </L>
	<L> left=3669 ,top=0 ,right=3669 ,bottom=50 </L>
	<L> left=3950 ,top=0 ,right=3950 ,bottom=50 </L>
	<L> left=3809 ,top=0 ,right=3809 ,bottom=50 </L>
	<L> left=4091 ,top=0 ,right=4091 ,bottom=50 </L>
	<L> left=463 ,top=0 ,right=463 ,bottom=50 </L>
	<C>id='BA0101YN', left=731, top=3, right=769, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=772 ,top=0 ,right=772 ,bottom=50 </L>
	<C>id='BA0102CNT', left=778, top=3, right=816, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=819 ,top=0 ,right=819 ,bottom=50 </L>
	<C>id='AD0103CNT', left=825, top=3, right=863, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=866 ,top=0 ,right=866 ,bottom=50 </L>
	<C>id='AD0101CNT', left=872, top=3, right=931, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=934 ,top=0 ,right=934 ,bottom=50 </L>
	<C>id='AD0102CNT', left=941, top=3, right=1000, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1003 ,top=0 ,right=1003 ,bottom=50 </L>
	<C>id='AD0105CNT', left=1009, top=3, right=1066, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1069 ,top=0 ,right=1069 ,bottom=50 </L>
	<L> left=1278 ,top=0 ,right=1278 ,bottom=50 </L>
	<L> left=1419 ,top=0 ,right=1419 ,bottom=50 </L>
	<C>id='AD0104YN', left=1075, top=3, right=1131, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1138 ,top=0 ,right=1138 ,bottom=50 </L>
	<L> left=1700 ,top=0 ,right=1700 ,bottom=50 </L>
	<L> left=1841 ,top=0 ,right=1841 ,bottom=50 </L>
	<C>id={CURROW}, left=9, top=3, right=69, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=78, top=3, right=350, bottom=44, align='left', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000}, left=1141, top=3, right=1275, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1559 ,top=0 ,right=1559 ,bottom=50 </L>
	<L> left=1981 ,top=0 ,right=1981 ,bottom=50 </L>
	<L> left=2122 ,top=0 ,right=2122 ,bottom=50 </L>
	<L> left=2263 ,top=0 ,right=2263 ,bottom=50 </L>
	<L> left=2403 ,top=0 ,right=2403 ,bottom=50 </L>
	<L> left=2544 ,top=0 ,right=2544 ,bottom=50 </L>
	<L> left=2684 ,top=0 ,right=2684 ,bottom=50 </L>
	<L> left=2825 ,top=0 ,right=2825 ,bottom=50 </L>
	<C>id={PC10000+PC20000}, left=1281, top=3, right=1416, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000+PC10000+PC20000}, left=1422, top=3, right=1556, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={FRE13001+PC23000}, left=1844, top=3, right=1978, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC23000', left=1703, top=3, right=1838, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE13001', left=1563, top=3, right=1697, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={FRE13005+PC20000}, left=2266, top=3, right=2400, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC20000', left=2125, top=3, right=2259, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE13005', left=1984, top=3, right=2119, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000+PB10000}, left=2688, top=3, right=2822, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB10000', left=2547, top=3, right=2681, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000}, left=2406, top=3, right=2541, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB41000', left=2828, top=3, right=2963, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB42000', left=2969, top=3, right=3103, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3106 ,top=0 ,right=3106 ,bottom=50 </L>
	<C>id='PB51000', left=3109, top=3, right=3244, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB52000', left=3250, top=3, right=3384, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB62000', left=3531, top=3, right=3666, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB61000', left=3391, top=3, right=3525, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB71000', left=3672, top=3, right=3806, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB72000', left=3813, top=3, right=3947, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={PB71000+PB72000}, left=3953, top=3, right=4088, bottom=44, align='right', face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNO', left=359, top=3, right=459, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=466, top=3, right=613, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=622, top=3, right=722, bottom=44, face='����', size=7, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2726 ,right=4100 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=3713 ,top=3 ,right=4091 ,bottom=84</I>
	<T>id='#p/#t' ,left=1706 ,top=3 ,right=2413 ,bottom=44 ,face='����' ,size=9  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=0 ,right=4091 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>