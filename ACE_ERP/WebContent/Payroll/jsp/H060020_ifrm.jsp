<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�/�����Ű��ۼ�_ifrm
+ ���α׷� ID	: h060020
+ �� �� �� ��	: 
+ �� �� �� ��	: ������
+ �� �� �� ��	: h060020_s1, h060020_s2, h060020_t1
-----------------------------------------------------------------------------
+ �� �� �� �� :	
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>
<html>
<head>
 <jsp:include page="/Payroll/common/include/head.jsp"/>  
<title></title>

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
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7);// + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

var gs_title_format="";
var gs_format="";
var gs_seq;
var gs_evaym=""; 
var gs_evayy=""; 
var gs_evamm=""; 
var gs_gb="";

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
  ln_SetDataHeader(2);

  //ln_Initial();
	//gcds_dtl.addrow();
	//ln_Data(1);

 }

/******************************************************************************
	Description : �ʱ�
******************************************************************************/
function ln_Initial(){
	gs_seq=1;
	gs_format ="";

	gcds_dtl.deleteall();
  
	var oRow = tb_1.insertRow();
  var oCell = oRow.insertCell();
	//alert("ù�� �߰�")
	ln_SetFormat(gs_seq);
  oCell.innerHTML = gs_format;
	txt_11.value=1;
	ln_SetDataHeader(2);
	gcds_dtl.addrow();
}

/******************************************************************************
	Description : ��ȸ 
******************************************************************************/
function ln_Query(){
    ("9999");
   
    //�����
		ln_Row_Clear(1);
    //������
		//@@@
		gcds_dtl.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060020_s1?"
		               + "v_str1="+parent.gcem_evaym.text
									 + "&v_str2="+parent.txt_empno2.value;
		//prompt('dtl::ln_Query',gcds_dtl.DataID);									
		gcds_dtl.Reset();

		gs_evaym = parent.gcem_evaym.text;
    gs_evayy = gs_evaym.substring(0,4);
    gs_evamm = gs_evaym.substring(4,6);
		gs_gb="";
    
		if (gs_evamm>="01"&&gs_evamm<="06"){		
			gs_gb = gs_evayy+"�� ��ݱ�"
		}else{
      gs_gb = gs_evayy+"�� �Ϲݱ�"
		}


    if(gcds_dtl.namevalue(1,"WORKGB")==""&&gcds_dtl.namevalue(1,"WKCONT")==""&&gcds_dtl.namevalue(1,"IMPORT")==0){
			eval("txt_2"+i).value="�ؾ����׸�";
			//eval("txt_3"+i).value="��2008�� ��ݱ� �ֿ���� �� ����(����) ��� \n (�ۼ��� ���κ� ���������, ����������ȹ���� �����Ͽ� �ۼ�)";
            eval("txt_3"+i).value="��"+gs_gb+" �ֿ���� �� ����(����) ��� \n (�ۼ��� ���κ� ���������, ����������ȹ���� �����Ͽ� �ۼ�)";
			//eval("txt_3"+i).value="��2008�� �Ϲݱ� �ֿ���� �� ����(����) ��� \n (�ۼ��� ���κ� ���������, ����������ȹ���� �����Ͽ� �ۼ�)";
			eval("txt_4"+i).value="����ġ�� �Ѱ谡 100% �ǵ��� ����"
		}
		
}
/******************************************************************************
	Description : �����
	parameter : 1 - 1�ุ ���ܵΰ� ����
	            2 - ��� ������ �ʱ� �� �� �߰�
******************************************************************************/
function ln_Row_Clear(gbn){
	if(gbn==1){
		for(i=gs_seq;i>1;i--){
			tb_1.deleteRow();
		}
		gs_seq=1;
	}else if(gbn==2){
		for(i=gs_seq;i>=1;i--){
			tb_1.deleteRow();
		}
		ln_Initial();
	}

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
   //ln_SetDataHeader(1);
   ln_SetDataHeader(2);
   gs_seq+=1;
   gs_format="";
	 ln_SetFormat(gs_seq);

	 var oRow = tb_1.insertRow();
	 var oCell = oRow.insertCell();
	 oCell.innerHTML = gs_format;
	 eval("txt_1"+gs_seq).value=gs_seq;
	 gcds_dtl.addrow();
	 ln_Data(gs_seq);
}

/******************************************************************************
	Description : ����
	              p1  - ������
								p2  - ��� 
								p3  - ���� 
								p4  - �μ�
								p5  - �Ҽ���
								p6  - ������1
								p7  - �ٹ�������1
								p8  - �ٹ�������1 
								p9  - �ٹ���1
								p10 - ���1
								p11 - ������2   
								p12 - �ٹ�������2 
								p13 - �ٹ�������2 
								p14 - �ٹ���2     
								p15 - ���2       
								p16 - ������2   
								p17 - �ٹ�������2 
								p18 - �ٹ�������2 
								p19 - �ٹ���2     
								p20 - ���2      
								p21 - �������� 
								p22 - ������
								p23 - ��������
								P24 - ������
******************************************************************************/
function ln_Save(){
   if(!ln_Save_Chk()) return;
   ln_SetDataHeader(1);
	 gcds_mst.addrow();
	 var row = gcds_mst.rowposition;
	 var row2 = parent.gcds_mst.rowposition;
	 gcds_mst.namevalue(row,"EVAYM")=parent.gcds_mst.namevalue(row2,"EVAYM");
	 gcds_mst.namevalue(row,"EMPNO")=parent.gcds_mst.namevalue(row2,"EMPNO");
	 gcds_mst.namevalue(row,"HEADCD")=parent.gcds_mst.namevalue(row2,"HEADCD");
	 gcds_mst.namevalue(row,"DIVCD")=parent.gcds_mst.namevalue(row2,"DIVCD");
	 gcds_mst.namevalue(row,"DEPTCD")=parent.gcds_mst.namevalue(row2,"DEPTCD");
	 gcds_mst.namevalue(row,"PAYGRD")=parent.gcds_mst.namevalue(row2,"PAYGRD");
	 gcds_mst.namevalue(row,"WORK_1")=parent.gcds_mst.namevalue(row2,"WORK_1");
	 gcds_mst.namevalue(row,"STARTDT_1")=parent.gcds_mst.namevalue(row2,"STARTDT_1"); 
	 gcds_mst.namevalue(row,"ENDDT_1")=parent.gcds_mst.namevalue(row2,"ENDDT_1");   
	 gcds_mst.namevalue(row,"PLACE_1")=parent.gcds_mst.namevalue(row2,"PLACE_1");   
	 gcds_mst.namevalue(row,"REMARK_1")=parent.gcds_mst.namevalue(row2,"REMARK_1");  
	 gcds_mst.namevalue(row,"WORK_2")=parent.gcds_mst.namevalue(row2,"WORK_2");    
	 gcds_mst.namevalue(row,"STARTDT_2")=parent.gcds_mst.namevalue(row2,"STARTDT_2"); 
	 gcds_mst.namevalue(row,"ENDDT_2")=parent.gcds_mst.namevalue(row2,"ENDDT_2");   
	 gcds_mst.namevalue(row,"PLACE_2")=parent.gcds_mst.namevalue(row2,"PLACE_2");   
	 gcds_mst.namevalue(row,"REMARK_2")=parent.gcds_mst.namevalue(row2,"REMARK_2");  
	 gcds_mst.namevalue(row,"WORK_3")=parent.gcds_mst.namevalue(row2,"WORK_3");    
	 gcds_mst.namevalue(row,"STARTDT_3")=parent.gcds_mst.namevalue(row2,"STARTDT_3"); 
	 gcds_mst.namevalue(row,"ENDDT_3")=parent.gcds_mst.namevalue(row2,"ENDDT_3");   
	 gcds_mst.namevalue(row,"PLACE_3")=parent.gcds_mst.namevalue(row2,"PLACE_3");   
	 gcds_mst.namevalue(row,"REMARK_3")=parent.gcds_mst.namevalue(row2,"REMARK_3");  
	 gcds_mst.namevalue(row,"WRDT")=parent.gcds_mst.namevalue(row2,"WRDT");      
	 gcds_mst.namevalue(row,"WRID")=parent.gcds_mst.namevalue(row2,"WRID");      
	 gcds_mst.namevalue(row,"UPDT")=parent.gcds_mst.namevalue(row2,"UPDT");      
	 gcds_mst.namevalue(row,"UPID")=parent.gcds_mst.namevalue(row2,"UPID"); 
	
	for(i=1;i<=gs_seq;i++){
	  if(gcds_dtl.SysStatus(i)!=2){
		  ln_Data(i);
		}
	}

  gctr_data.KeyValue = "h060020_t1?(I:USER=gcds_mst,I:USER2=gcds_dtl)";
	gctr_data.Action ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h060020_t1?";
	//prompt('gcds_mst',gcds_mst.text);
	//prompt('',gcds_dtl.text);
	gctr_data.post();
}


/******************************************************************************
	Description : ȭ�� ����Ÿ ==> ����Ÿ�� ���� (DTL)
******************************************************************************/
function ln_Data(i){
//@@@

	gcds_dtl.namevalue(i,"EVAYM") =parent.gcem_evaym.text; 
	gcds_dtl.namevalue(i,"EMPNO") = parent.txt_empno2.value;
	gcds_dtl.namevalue(i,"SEQ2") = eval("txt_1"+i).value;
	gcds_dtl.namevalue(i,"WORKGB") = eval("txt_2"+i).value;
	gcds_dtl.namevalue(i,"WKCONT") = eval("txt_3"+i).value;
	gcds_dtl.namevalue(i,"IMPORT") = fn_trim(eval("txt_4"+i).value);
	gcds_dtl.namevalue(i,"REMARK") = eval("txt_5"+i).value;
	gcds_dtl.namevalue(i,"WRDT")=gs_date2; 
	gcds_dtl.namevalue(i,"WRID")=gusrid; 
	gcds_dtl.namevalue(i,"UPDT")=gs_date2; 
	gcds_dtl.namevalue(i,"UPID")=gusrid; 
}


/******************************************************************************
	Description : ����Ÿ�� ==> ȭ�鵥��Ÿ ���� (DTL)
******************************************************************************/
function ln_Display(i){
	eval("txt_1"+i).value=gcds_dtl.namevalue(i,"SEQ2"); 
	eval("txt_2"+i).value=gcds_dtl.namevalue(i,"WORKGB");
	eval("txt_3"+i).value=gcds_dtl.namevalue(i,"WKCONT");
	eval("txt_4"+i).value=gcds_dtl.namevalue(i,"IMPORT");
	eval("txt_5"+i).value=gcds_dtl.namevalue(i,"REMARK");
}

/******************************************************************************
	Description : �Է°� üũ[���°���]
******************************************************************************/
function ln_Save_Chk() {
  var dbltemp=0;

  //�ʼ��׸� üũ
 	for(i=1;i<=gs_seq;i++){

		if(eval("txt_2"+i).value==""){
			alert("�׸��� �Է��Ͻʽÿ�.");
			return false;
		}


		if(eval("txt_2"+i).value.length>=45) {
			alert( i+" ��° �׸� ���̰� ��ϴ�." );
			return false
		}


  
		if(eval("txt_3"+i).value==""){
			alert("�ֿ���������� �Է��Ͻʽÿ�.");
			return false;
		}

		if(eval("txt_4"+i).value==""){
			alert("����ġ�� �Է��Ͻʽÿ�.");
			return false;
		}
	
	   //2010.05.28 jys �߰� 
		 eval("txt_4"+i).value=fn_trim(eval("txt_4"+i).value);
	}

  //����üũ
	var str="";
	for(j=1;j<=gs_seq;j++){
		str="txt_4"+j+"";
	  if(!ln_ChkNumber(str)) return false;
  }


  for(j=1;j<=gs_seq;j++){
	 
		dbltemp=parseInt(dbltemp)+parseInt(eval("txt_4"+j).value);
  }

	if(dbltemp!=100) {
		alert("����ġ �հ谡 100�� �ƴմϴ�. Ȯ�� �ٶ��ϴ�.");
		return false;
	}

	return true
}


/******************************************************************************************
	Descrition : ��¥�� ���� üũ
	parameter  : obj
	retun      : true - ���� , false - �Ұ���
******************************************************************************************/
function ln_ChkNumber(obj){
	var str="";
	var sChk=0;
	var src=eval(obj).value;

	for(var i=0;i<src.length;i++){
		if(isNaN(src.charAt(i))||src.charAt(i)==" ") sChk+=1;
		else str+=src.charAt(i);
	}

	if(sChk!=0){
		alert("���ڸ� �Է��Ͻʽÿ�.");
		obj.value=src;
		return false;
	}

	return true;
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
  
   if (tb_1.rows.length>1) {
			gcds_dtl.DeleteRow(gs_seq);  
	    gs_seq-=1;	
      tb_1.deleteRow();
   }

	 //����Ÿ ����
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

  var s_startdt_1=parent.gcds_mst.namevalue(1,"STARTDT_1");
	var s_enddt_1=parent.gcds_mst.namevalue(1,"ENDDT_1");
	var s_startdt_2=parent.gcds_mst.namevalue(1,"STARTDT_2");
	var s_enddt_2=parent.gcds_mst.namevalue(1,"ENDDT_2");
	var s_startdt_3=parent.gcds_mst.namevalue(1,"STARTDT_3");
	var s_enddt_3=parent.gcds_mst.namevalue(1,"ENDDT_3");
 
  gcds_prthead.ClearAll();
	ln_SetDataHeader(3);
  gcds_prthead.Addrow();
	
	//gcds_prthead.namevalue(1,"TITLE")="2008�� ��ݱ� �����Ű�"
	//gcds_prthead.namevalue(1,"TERM")="(���Ⱓ : 2007. 12. 01 ~ 2008. 05. 31)";

	//gcds_prthead.namevalue(1,"TITLE")="2008�� �Ϲݱ� �����Ű�"
	//gcds_prthead.namevalue(1,"TERM")="(���Ⱓ : 2008. 06. 01 ~ 2008. 11. 30)";

	gcds_prthead.namevalue(1,"TITLE")=gs_gb+" �����Ű�";
	gcds_prthead.namevalue(1,"TERM")="(���Ⱓ : "+ parent.txt_term.value+ ")";
	
	gcds_prthead.namevalue(1,"EMPNMK")=parent.gcds_mst.namevalue(1,"EMPNMK");

	if(s_startdt_1!=""&&s_enddt_1!=""){
		gcds_prthead.namevalue(1,"DATE1")=s_startdt_1.substring(4,6)+"."+s_startdt_1.substring(6,8)+" ~ "+s_enddt_1.substring(4,6)+"."+s_enddt_1.substring(6,8);
	}
	gcds_prthead.namevalue(1,"DEPT1")=parent.gcds_mst.namevalue(1,"PLACE_1");
	gcds_prthead.namevalue(1,"CONTENT1")=parent.gcds_mst.namevalue(1,"WORK_1");
	gcds_prthead.namevalue(1,"REMARK1")=parent.gcds_mst.namevalue(1,"REMARK_1");

	if(s_startdt_2!=""&&s_enddt_2!=""){
		gcds_prthead.namevalue(1,"DATE2")=s_startdt_2.substring(4,6)+"."+s_startdt_2.substring(6,8)+" ~ "+s_enddt_2.substring(4,6)+"."+s_enddt_2.substring(6,8);
	}
	gcds_prthead.namevalue(1,"DEPT2")=parent.gcds_mst.namevalue(1,"PLACE_2");
	gcds_prthead.namevalue(1,"CONTENT2")=parent.gcds_mst.namevalue(1,"WORK_2");
	gcds_prthead.namevalue(1,"REMARK2")=parent.gcds_mst.namevalue(1,"REMARK_2");

	if(s_startdt_3!=""&&s_enddt_3!=""){
		gcds_prthead.namevalue(1,"DATE3")=s_startdt_3.substring(4,6)+"."+s_startdt_3.substring(6,8)+" ~ "+s_enddt_3.substring(4,6)+"."+s_enddt_3.substring(6,8);
	}
	gcds_prthead.namevalue(1,"DEPT3")=parent.gcds_mst.namevalue(1,"PLACE_3");
	gcds_prthead.namevalue(1,"CONTENT3")=parent.gcds_mst.namevalue(1,"WORK_3");
	gcds_prthead.namevalue(1,"REMARK3")=parent.gcds_mst.namevalue(1,"REMARK_3");


   //������
	 //@@@
	gcds_length.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060020_s4?"
		                               + "v_str1="+parent.gcem_evaym.text
									   + "&v_str2="+parent.txt_empno2.value;
	gcds_length.Reset();
	
	//prompt('',gcds_length.DataID);
  
	var len = gcds_length.namevalue(1,"LEN");
	var gbn ="";
	
	//alert("len"+len);
  
	//1 ������ ��  
	if(len<=200){ //8ĭ
    gbn="1";
	}else if(len>200 && len<=270){ //7ĭ
		gbn="2";
	}else if(len>270 && len<=350){ //5ĭ
		gbn="3";
	}else if(len>350 && len<=570){ //4ĭ
	  gbn="4";
	}else if (len>570 && len<=865){//3ĭ
    gbn="5";
	}else if (len>865 ){//2ĭ
    gbn="6";
	}else{
		alert("����� ����Ÿ�� �����ϴ�.");
	}


	//����ó��
	if(gusrid=="2030005"){
   gbn="4";
	}else if (gusrid=="1990023"){
	 gbn="9";   //1�������� 6ĭ ����ó��
	}
  
	ln_Print_Format(gbn);

	gcrp_print1.preview();	
	
}

/******************************************************************************
	Description : ��¹� format ����
******************************************************************************/
function ln_Print_Format(gbn){
  var ls_format= "";

	if(gbn=="1"){	//200	
		ls_format +="	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                  ";
		ls_format +="	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
		ls_format +="	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                  ";
		ls_format +="	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
    ls_format +="	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
		ls_format +="	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
		ls_format +="	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                    ";
		ls_format +="	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
		ls_format +="	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
		ls_format +="	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
    ls_format +="	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +="	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
    ls_format +="	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
    ls_format +="	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                 ";
		ls_format +="	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
		ls_format +="	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                        ";
		ls_format +="	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
		ls_format +="	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                 ";
		ls_format +="	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                  ";
		ls_format +="	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";
    ls_format +="</B>                                                                                                                                                                                                                                      ";
		ls_format +="<B>id=default ,left=0,top=0 ,right=2000 ,bottom=225 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                    ";
		ls_format +="	<L> left=71 ,top=0 ,right=71 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="	<L> left=159 ,top=0 ,right=159 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<L> left=439 ,top=0 ,right=439 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<L> left=1942 ,top=0 ,right=1942 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=1709 ,top=5 ,right=1709 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=1529 ,top=5 ,right=1529 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<C>id='SEQ2', left=79, top=5, right=151, bottom=220, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
		ls_format +="	<C>id='WKCONT', left=445, top=5, right=1521, bottom=220, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
		ls_format +="	<C>id='REMARK', left=1715, top=5, right=1937, bottom=220, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                       ";
		ls_format +="	<L> left=71 ,top=225 ,right=1942 ,bottom=225 </L>                                                                                                                                                                                       ";
    ls_format +="	<C>id='IMPORT', left=1577, top=77, right=1667, bottom=153, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
		ls_format +="	<C>id='WORKGB', left=169, top=5, right=431, bottom=220, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         ";
		ls_format +="</B>                                                                                                                                                                                                                                      ";
		ls_format +="<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                      ";
		ls_format +="	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="</B>                                                                                                                                                                                                                                      ";
		ls_format +="<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                ";
		ls_format +="	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>                                                                                                                                                          ";
		ls_format +="	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>     ";
		ls_format +="	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                    ";
		ls_format +="</B>                                                                                                                                                                                                                                      ";

	}else if(gbn=="2"){ //295
	  ls_format +=" <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     ";
 	  ls_format +=" 	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              ";
		ls_format +=" 	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              ";
		ls_format +=" 	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +=" 	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              ";
		ls_format +=" 	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                   ";
		ls_format +=" 	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
 	  ls_format +=" 	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       ";
		ls_format +=" 	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                          ";
		ls_format +=" 	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
 	  ls_format +=" 	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +=" 	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +=" 	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                     ";
		ls_format +=" 	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                              ";
 	  ls_format +=" 	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                   ";
		ls_format +=" 	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +=" 	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +=" 	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
		ls_format +=" 	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
    ls_format +=" 	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
		ls_format +=" 	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
		ls_format +=" 	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +=" 	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +=" 	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +=" 	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +=" 	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +=" 	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +=" 	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
		ls_format +=" 	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
		ls_format +=" 	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
		ls_format +=" 	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +=" 	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                            ";
		ls_format +=" 	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
    ls_format +=" 	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
 	  ls_format +=" 	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                              ";
		ls_format +=" 	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
		ls_format +=" 	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       ";
		ls_format +=" 	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                  ";
 	  ls_format +=" 	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                   ";
		ls_format +=" 	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                       ";
		ls_format +=" </B>                                                                                                                                                                                                                                       ";
		ls_format +=" <B>id=default ,left=0,top=0 ,right=2000 ,bottom=318 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     ";
		ls_format +=" 	<L> left=71 ,top=0 ,right=71 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +=" 	<C>id='WORKGB', left=169, top=5, right=431, bottom=307, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                          ";
 	  ls_format +=" 	<C>id='IMPORT', left=1577, top=122, right=1667, bottom=198, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
		ls_format +=" 	<C>id='SEQ2', left=79, top=53, right=151, bottom=267, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
		ls_format +=" 	<L> left=159 ,top=0 ,right=159 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +=" 	<L> left=439 ,top=0 ,right=439 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +=" 	<L> left=1529 ,top=0 ,right=1529 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=1709 ,top=0 ,right=1709 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
 	  ls_format +=" 	<L> left=1942 ,top=0 ,right=1942 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<C>id='WKCONT', left=445, top=5, right=1521, bottom=307, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         ";
		ls_format +=" 	<C>id='REMARK', left=1715, top=5, right=1937, bottom=307, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
		ls_format +=" 	<L> left=69 ,top=312 ,right=1939 ,bottom=312 </L>                                                                                                                                                                                        ";
		ls_format +=" </B>                                                                                                                                                                                                                                       ";
    ls_format +=" <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=3 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                       ";
		ls_format +=" 	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +=" </B>                                                                                                                                                                                                                                       ";
		ls_format +=" <B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                 ";
		ls_format +=" 	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +=" 	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>                                                                                                                                                           ";
		ls_format +=" 	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>      ";
		ls_format +=" 	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                     ";
		ls_format +=" </B>                                                                                                                                                                                                                                       ";
  }else if(gbn=="3"){ //350
	  ls_format +="  <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                    ";
		ls_format +="  	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="  	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="  	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
		ls_format +="  	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="  	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                  ";
		ls_format +="  	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
		ls_format +="  	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
		ls_format +="  	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="  	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="  	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                    ";
		ls_format +="  	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
		ls_format +="  	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
		ls_format +="  	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +="  	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +="  	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="  	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="  	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="  	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="  	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="  	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="  	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="  	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="  	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="  	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="  	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="  	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="  	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="  	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="  	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
		ls_format +="  	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                 ";
		ls_format +="  	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="  	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
		ls_format +="  	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                        ";
		ls_format +="  	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
		ls_format +="  	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                 ";
		ls_format +="  	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                  ";
		ls_format +="  	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";
		ls_format +="  </B>                                                                                                                                                                                                                                      ";
		ls_format +="  <B>id=default ,left=0,top=0 ,right=2000 ,bottom=381 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                    ";
		ls_format +="  	<L> left=71 ,top=0 ,right=71 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="  	<C>id='WORKGB', left=169, top=5, right=431, bottom=370, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         ";
		ls_format +="  	<C>id='SEQ2', left=79, top=79, right=151, bottom=294, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                         ";
		ls_format +="  	<C>id='IMPORT', left=1577, top=146, right=1667, bottom=222, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                   ";
		ls_format +="  	<L> left=159 ,top=0 ,right=159 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="  	<L> left=439 ,top=0 ,right=439 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="  	<L> left=1529 ,top=0 ,right=1529 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=1709 ,top=0 ,right=1709 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<L> left=1942 ,top=0 ,right=1942 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="  	<C>id='WKCONT', left=445, top=5, right=1521, bottom=370, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
		ls_format +="  	<C>id='REMARK', left=1715, top=5, right=1937, bottom=370, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                       ";
		ls_format +="  	<L> left=71 ,top=378 ,right=1942 ,bottom=378 </L>                                                                                                                                                                                       ";
		ls_format +="  </B>                                                                                                                                                                                                                                      ";
		ls_format +="  <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=2 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                      ";
		ls_format +="  	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="  </B>                                                                                                                                                                                                                                      ";
		ls_format +="  <B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                ";
		ls_format +="  	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="  	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>                                                                                                                                                          ";
		ls_format +="  	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>     ";
		ls_format +="  	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                    ";
		ls_format +="  </B>                                                                                                                                                                                                                                      ";

									                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
	}else if(gbn=="4"){ //570
	  ls_format +="	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                  ";
		ls_format +="	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
		ls_format +="	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
		ls_format +="	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                  ";
		ls_format +="	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
    ls_format +="	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
		ls_format +="	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
		ls_format +="	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                    ";
		ls_format +="	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
		ls_format +="	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
		ls_format +="	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
    ls_format +="	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +="	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
		ls_format +="	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +="	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
    ls_format +="	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +="	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
		ls_format +="	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
    ls_format +="	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                 ";
		ls_format +="	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +="	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
		ls_format +="	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                        ";
		ls_format +="	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
		ls_format +="	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                 ";
		ls_format +="	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                  ";
		ls_format +="	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";
    ls_format +="</B>                                                                                                                                                                                                                                      ";
		ls_format +="<B>id=default ,left=0,top=0 ,right=2000 ,bottom=445 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                    ";
		ls_format +="	<L> left=71 ,top=0 ,right=71 ,bottom=445 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="	<C>id='WORKGB', left=169, top=5, right=431, bottom=437, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         ";
		ls_format +="	<C>id='IMPORT', left=1577, top=183, right=1667, bottom=259, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                   ";
		ls_format +="	<C>id='SEQ2', left=79, top=116, right=151, bottom=331, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                        ";
		ls_format +="	<L> left=159 ,top=0 ,right=159 ,bottom=445 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<L> left=439 ,top=0 ,right=439 ,bottom=445 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
		ls_format +="	<L> left=1529 ,top=0 ,right=1529 ,bottom=445 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=1709 ,top=0 ,right=1709 ,bottom=445 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<L> left=1942 ,top=0 ,right=1942 ,bottom=445 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		ls_format +="	<C>id='WKCONT', left=445, top=5, right=1521, bottom=437, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
    ls_format +="	<C>id='REMARK', left=1715, top=5, right=1937, bottom=437, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                       ";
		ls_format +="	<L> left=71 ,top=445 ,right=1942 ,bottom=445 </L>                                                                                                                                                                                       ";
		ls_format +="</B>                                                                                                                                                                                                                                      ";
		ls_format +="<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                      ";
		ls_format +="	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="</B>                                                                                                                                                                                                                                      ";
		ls_format +="<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                ";
		ls_format +="	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>                                                                                                                                                          ";
		ls_format +="	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>     ";
		ls_format +="	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                    ";
		ls_format +="</B>                                                                                                                                                                                                                                      ";

	}else if(gbn=="5"){ //865
		ls_format +="	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                       ";
		ls_format +="	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                                  ";
		ls_format +="	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                                  ";
		ls_format +="	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                                 ";
		ls_format +="	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                                  ";
		ls_format +="	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                       ";
		ls_format +="	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +="	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
    ls_format +="	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +="	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
		ls_format +="	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                              ";
		ls_format +="	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +="	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
		ls_format +="	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +="	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
		ls_format +="	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
		ls_format +="	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
		ls_format +="	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       ";
		ls_format +="	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
    ls_format +="	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		ls_format +="	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                           ";
		ls_format +="	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                           ";
		ls_format +="	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                           ";
		ls_format +="	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                           ";
		ls_format +="	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +="	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
		ls_format +="	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
		ls_format +="	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
		ls_format +="	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
    ls_format +="	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                        ";
		ls_format +="	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                        ";
		ls_format +="	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                        ";
		ls_format +="	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                         ";
		ls_format +="	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                         ";
		ls_format +="	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                         ";
		ls_format +="	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
		ls_format +="	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                                ";
    ls_format +="	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +="	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
		ls_format +="	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +="	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +="	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
		ls_format +="	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                             ";
		ls_format +="	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
		ls_format +="	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                      ";
		ls_format +="	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       ";
		ls_format +="	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                           ";
    ls_format +="</B>                                                                                                                                                                                                                                           ";
		ls_format +="<B>id=default ,left=0,top=0 ,right=2000 ,bottom=625 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                         ";
		ls_format +="	<L> left=71 ,top=0 ,right=71 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                  ";
		ls_format +="	<C>id='WORKGB', left=169, top=5, right=431, bottom=614, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                              ";
		ls_format +="	<L> left=159 ,top=0 ,right=159 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
		ls_format +="	<L> left=439 ,top=0 ,right=439 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
		ls_format +="	<L> left=1529 ,top=0 ,right=1529 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=1709 ,top=0 ,right=1709 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<L> left=1942 ,top=0 ,right=1942 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		ls_format +="	<C>id='WKCONT', left=445, top=5, right=1521, bottom=614, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                             ";
		ls_format +="	<C>id='REMARK', left=1715, top=5, right=1937, bottom=614, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                            ";
		ls_format +="	<L> left=71 ,top=624 ,right=1942 ,bottom=624 </L>                                                                                                                                                                                            ";
    ls_format +="	<C>id='IMPORT', left=1577, top=275, right=1667, bottom=352, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                        ";
		ls_format +="	<C>id='SEQ2', left=79, top=201, right=151, bottom=415, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                             ";
		ls_format +="</B>                                                                                                                                                                                                                                           ";
		ls_format +="<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                           ";
		ls_format +="	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                  ";
		ls_format +="</B>                                                                                                                                                                                                                                           ";
		ls_format +="<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     ";
		ls_format +="	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                  ";
		ls_format +="	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>                                                                                                                                                               ";
		ls_format +="	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>          ";
		ls_format +="	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                         ";
		ls_format +="</B>                                                                                                                                                                                                                                           ";
	
	}else if(gbn=="6"){ //865�̻�
    ls_format +=" 	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                  ";
		ls_format +=" 	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
		ls_format +=" 	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
		ls_format +=" 	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                           ";
		ls_format +=" 	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
		ls_format +=" 	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                 ";
		ls_format +=" 	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		ls_format +=" 	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
    ls_format +=" 	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		ls_format +=" 	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                     ";
		ls_format +=" 	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                        ";
		ls_format +=" 	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		ls_format +=" 	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		ls_format +=" 	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                   ";
		ls_format +=" 	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                            ";
		ls_format +=" 	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                 ";
		ls_format +=" 	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
    ls_format +=" 	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		ls_format +=" 	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +=" 	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +=" 	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +=" 	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
		ls_format +=" 	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		ls_format +=" 	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
		ls_format +=" 	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
		ls_format +=" 	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
		ls_format +=" 	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
    ls_format +=" 	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";
		ls_format +=" 	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";
		ls_format +=" 	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";
		ls_format +=" 	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +=" 	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +=" 	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
		ls_format +=" 	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                          ";
    ls_format +=" 	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		ls_format +=" 	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                ";
		ls_format +=" 	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		ls_format +=" 	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		ls_format +=" 	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                            ";
		ls_format +=" 	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       ";
		ls_format +=" 	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                     ";
		ls_format +=" 	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                ";
		ls_format +=" 	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                 ";
		ls_format +=" 	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
    ls_format +=" </B>                                                                                                                                                                                                                                     ";
		ls_format +=" <B>id=default ,left=0,top=0 ,right=2000 ,bottom=955 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                   ";
		ls_format +=" 	<L> left=71 ,top=0 ,right=71 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +=" 	<C>id='WORKGB', left=169, top=5, right=431, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
		ls_format +=" 	<C>id='IMPORT', left=1577, top=458, right=1667, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                  ";
		ls_format +=" 	<C>id='SEQ2', left=77, top=389, right=148, bottom=603, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
		ls_format +=" 	<L> left=159 ,top=0 ,right=159 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=439 ,top=0 ,right=439 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		ls_format +=" 	<L> left=1529 ,top=0 ,right=1529 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=1709 ,top=0 ,right=1709 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<L> left=1942 ,top=0 ,right=1942 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		ls_format +=" 	<C>id='WKCONT', left=445, top=5, right=1521, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                       ";
    ls_format +=" 	<C>id='REMARK', left=1715, top=5, right=1937, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                      ";
		ls_format +=" 	<L> left=71 ,top=955 ,right=1942 ,bottom=955 </L>                                                                                                                                                                                      ";
		ls_format +=" </B>                                                                                                                                                                                                                                     ";
		ls_format +=" <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     ";
		ls_format +=" 	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +=" </B>                                                                                                                                                                                                                                     ";
		ls_format +=" <B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                               ";
		ls_format +=" 	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		ls_format +=" 	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>                                                                                                                                                         ";
		ls_format +=" 	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>    ";
		ls_format +=" 	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                   ";
		ls_format +=" </B>                                                                                                                                                                                                                                     ";

	} else if(gbn=="9") {

    ls_format +=" <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                         "
		ls_format +=" 	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              "
		ls_format +=" 	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              "
		ls_format +=" 	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             "
		ls_format +=" 	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              "
		ls_format +=" 	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                   "
		ls_format +=" 	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       "
		ls_format +=" 	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                          "
		ls_format +=" 	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
		ls_format +=" 	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
		ls_format +=" 	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                     "
		ls_format +=" 	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                              "
		ls_format +=" 	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                   "
		ls_format +=" 	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         "
		ls_format +=" 	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         "
		ls_format +=" 	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       "
		ls_format +=" 	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       "
		ls_format +=" 	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       "
		ls_format +=" 	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       "
		ls_format +=" 	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      "
		ls_format +=" 	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      "
		ls_format +=" 	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      "
		ls_format +=" 	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    "
		ls_format +=" 	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    "
		ls_format +=" 	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    "
		ls_format +=" 	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     "
		ls_format +=" 	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     "
		ls_format +=" 	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     "
		ls_format +=" 	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
		ls_format +=" 	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                            "
		ls_format +=" 	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  "
		ls_format +=" 	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
		ls_format +=" 	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                              "
		ls_format +=" 	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         "
		ls_format +=" 	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       "
		ls_format +=" 	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                  "
		ls_format +=" 	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                   "
		ls_format +=" 	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                       "
		ls_format +=" </B>                                                                                                                                                                                                                                           "
		ls_format +=" <B>id=default ,left=0,top=0 ,right=2000 ,bottom=310 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                         "
		ls_format +=" 	<L> left=71 ,top=0 ,right=71 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              "
		ls_format +=" 	<C>id='WORKGB', left=169, top=5, right=431, bottom=302, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                          "
		ls_format +=" 	<L> left=159 ,top=0 ,right=159 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
		ls_format +=" 	<L> left=439 ,top=0 ,right=439 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
		ls_format +=" 	<L> left=1529 ,top=0 ,right=1529 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=1709 ,top=0 ,right=1709 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<L> left=1942 ,top=0 ,right=1942 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
		ls_format +=" 	<C>id='SEQ2', left=79, top=48, right=151, bottom=262, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          "
		ls_format +=" 	<C>id='IMPORT', left=1577, top=119, right=1667, bottom=196, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    "
		ls_format +=" 	<C>id='WKCONT', left=445, top=5, right=1521, bottom=302, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         "
		ls_format +=" 	<C>id='REMARK', left=1715, top=5, right=1937, bottom=302, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        "
		ls_format +=" 	<L> left=71 ,top=304 ,right=1942 ,bottom=304 </L>                                                                                                                                                                                        "
		ls_format +=" </B>                                                                                                                                                                                                                                           "
		ls_format +=" <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=3 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                           "
		ls_format +=" 	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              "
		ls_format +=" </B>                                                                                                                                                                                                                                           "
		ls_format +=" <B>id=Footer ,left=0 ,top=2728 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     "
		ls_format +=" 	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              "
		ls_format +=" 	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>                                                                                                                                                           "
		ls_format +=" 	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>      "
		ls_format +=" 	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                     "
		ls_format +=" </B>                                                                                                                                                                                                                                           "
		
	}


	gcrp_print1.format=ls_format;
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : �˾�
******************************************************************************/
function ln_Popup(gbn){

}


/******************************************************************************
	Description : ��뿩��
  parameter   :
******************************************************************************/
function ln_Enable(gbn){

}


/******************************************************************************
	Description : DTL ȭ�� DISPLAY
  parameter   :
******************************************************************************/
function ln_SetFormat(i){
  
  gs_format +="<table  cellpadding=0 cellspacing=0 style=width:855px;height:30px;font-size:9pt;background-color:#ffffff;>"
	gs_format +="	<tr>" 
	gs_format +="		<td style=height:105px;border:1 solid #708090>"					
	gs_format +="		<textarea id=txt_1"+i+"   style=width:40px;height:100px;overflow:auto;font-size:30pt;text-align:center;vertical-align:center; readOnly></textarea>"					
	gs_format +="		</td>"					
	gs_format +="		<td style=height:105px;border:1 solid #708090>"					
	gs_format +="		 <textarea id=txt_2"+i+" style=width:80px;height:100px;overflow:auto;ime-mode:active; maxlength=50 onBlur=bytelength(this,this.value,100);></textarea>"					
	gs_format +="		</td>"					
	gs_format +="		<td style=height:105px;border:1 solid #708090>"					
	gs_format +="		 <textarea id=txt_3"+i+" style=width:620px;height:100px;overflow:auto;ime-mode:active; maxlength=1000 onBlur=bytelength(this,this.value,1500);></textarea>"					
	gs_format +="		</td>"					
	gs_format +="		<td style=height:105px;border:1 solid #708090>"					
	gs_format +="		 <textarea id=txt_4"+i+" style=width:55px;height:100px;overflow:auto;ime-mode:active;  maxlength=50   onBlur=bytelength(this,this.value,100);></textarea>"					
	gs_format +="		</td>"					
	gs_format +="		<td style=height:105px;border:1 solid #708090>"					
	gs_format +="		 <textarea id=txt_5"+i+" style=width:60px;height:100px;overflow:auto;ime-mode:active;  maxlength=50   onBlur=bytelength(this,this.value,100);></textarea>"					
	gs_format +="		</td>"					
	gs_format +="	</tr>"
	gs_format +="</table>";

}

/******************************************************************************
	Description : ����Ÿ �� ��� ����
******************************************************************************/
function ln_SetDataHeader(gbn){
  
	if(gbn==1){       //�����Ű�MST
		if (gcds_mst.countrow<1){
			var s_temp = " EVAYM:STRING(6),EMPNO:STRING(7),EMPNMK:STRING(30),HEADCD:STRING(4),HEADNM:STRING(50),"
			           + " DIVCD:STRING(4),DIVNM:STRING(50),DEPTCD:STRING(4),DEPTNMK:STRING(50),PAYGRD:STRING(4),PAYGRDNM:STRING(50), "
								 + " WORK_1:STRING(50),STARTDT_1:STRING(8),ENDDT_1:STRING(8),PLACE_1:STRING(50),REMARK_1:STRING(100),"
								 + " WORK_2:STRING(50),STARTDT_2:STRING(8),ENDDT_2:STRING(8),PLACE_2:STRING(50),REMARK_2:STRING(100),"
								 + " WORK_3:STRING(50),STARTDT_3:STRING(8),ENDDT_3:STRING(8),PLACE_3:STRING(50),REMARK_3:STRING(100),"
								 + " WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10)";
			gcds_mst.SetDataHeader(s_temp);
		}
	}else if(gbn==2){ //�����Ű�DTL
		if (gcds_dtl.countrow<1){
			var s_temp = " EVAYM:STRING(6),EMPNO:STRING(7),SEQ2:DECIMAL(2),WORKGB:STRING(100),WKCONT:STRING(2048),"
								 + " IMPORT:DECIMAL(3),REMARK:STRING(100),"
								 + " WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10)";
			gcds_dtl.SetDataHeader(s_temp);
		}
	}else if(gbn==3){ //print head
		if (gcds_prthead.countrow<1){
			var s_temp = " TITLE:STRING(50),TERM:STRING(50),EMPNMK:STRING(30),"
			           + " DATE1:STRING(50),DEPT1:STRING(50),CONTENT1:STRING(2048),REMARK1:STRING(100),"
								 + " DATE2:STRING(50),DEPT2:STRING(50),CONTENT2:STRING(2048),REMARK2:STRING(100),"
								 + " DATE3:STRING(50),DEPT3:STRING(50),CONTENT3:STRING(2048),REMARK3:STRING(100)";
			gcds_prthead.SetDataHeader(s_temp);
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
	//lbl_search.innerText = "( " + row + " �� )";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
		ln_SetDataHeader(2);
  	gcds_dtl.addrow();
	}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_dtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_prthead classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_length classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_dtl" event="OnLoadStarted()">
	ln_Loading_Start();
</script>

<script language="javascript" for="gcds_dtl" event="onloadCompleted(row,colid)">
  var oRow 
	var oCell
	for(i=1;i<=row;i++){
		if(i>1){
			gs_format=""; 
			oRow= tb_1.insertRow();
			oCell = oRow.insertCell();
			ln_SetFormat(i);
			oCell.innerHTML = gs_format;
		}

		//��ȸ ����Ÿ ������
		ln_Display(i);
	}

	if (row==0)gs_seq = 1;
	else gs_seq = row;
  ln_Loading_End(row);
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data2" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<body bgcolor="#FFFFFF" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0" onload="ln_Start();">
<table id="tb_1" value="" cellpadding="0" cellspacing="0" border="0">
</table>


<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_prthead">
	<param name="DetailDataID"			value="gcds_dtl">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="false">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=955 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=71 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='WORKGB', left=169, top=5, right=431, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='IMPORT', left=1577, top=458, right=1667, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEQ2', left=77, top=389, right=148, bottom=603, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=159 ,top=0 ,right=159 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=439 ,top=0 ,right=439 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1529 ,top=0 ,right=1529 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1709 ,top=0 ,right=1709 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='WKCONT', left=445, top=5, right=1521, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='REMARK', left=1715, top=5, right=1937, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<L> left=71 ,top=955 ,right=1942 ,bottom=955 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


	">
</object></comment><script>__ws__(__NSID__);</script> 





</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	