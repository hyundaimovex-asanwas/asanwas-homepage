<%@ page language="java" contentType="text/html;charset=ksc5601" %>
<%
/******************************************************************************
 * �ý��۸�		: �޿��ý���
 * ���α׷�ID   : P03000
 * J  S  P		: P030009i
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-01-11
 * �������		:	ds1) �⺻���� + ��Ÿ���� �Ϻ�
 					ds2) �����ٹ��� 
					ds3) ��������
					ds4) ���
 *                   
 * ������������ 	: 2007-01-11

 * ������������ 	: 2009 - ���ϳ�

 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//�ͼӳ⵵
    String eno 		 = request.getParameter("eno");			//���   
    eyy="2009";
%>

<HTML>
<HEAD>
<TITLE><%=eyy%>�� �ٷμҵ���� �Ű� �Է�</TITLE>
<META http-equiv=Content-Type content="text/html; charset=euc-kr">

<LINK href="imgs/css_ehr.css" type=text/css rel=stylesheet>

<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../common/include/common.css">

<!-- ���� ���콺 ����-->
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>

<Script language="javascript" src="../../common/include/PubFun.js"></script>

<script language="javascript" src="js/PubFun.js"></script>  
 <script language="javascript" src="js/menu.js"></script>
<script language="javascript" src="js/common_pop.js"></script>     
<script language="javascript" src="js/common.js"></script>     
 <SCRIPT language=JavaScript   src="imgs/web.js"></SCRIPT>
<SCRIPT language=JavaScript   src="imgs/06YearEntry.js"></SCRIPT> 
<SCRIPT language="JavaScript" src="imgs/ApplyChk.js"></SCRIPT> 

<script language="javascript" src="js/embedControl.js"></script> 
<script language="javascript" src="js/common_gauce.js"></script> 


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //���
	var gs_level;
	var gs_treecd;
	var g_empno="";
	
	get_cookdata();
	
	var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
	//var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
	function ln_Start(){
		//�׸��� ��Ÿ�� �ֱ�
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn");		
		cfStyleGrid(getObjectFirst("gr3"), "comn");				

		//�����ͼ� ��� ����
		ln_SetDataHeader();
			
		fnSelect("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (���μҵ� + ���)
		alert(ds1.namevalue(ds1.rowposition, "TAX_PAY"));
		fnSelect2("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (�����ٹ�)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
		fnSelect4("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��α�)		
	}
	
	function ln_SetDataHeader(){
//		var s_temp = "VD_FAXNO:DECIMAL,POST_NO1:STRING,POST_NO2:STRING,ADDRESS1:STRING,VEND_ID:STRING";
		var s_temp = "REFc1:DECIMAL,REFc2:DECIMAL";
		ds3.SetDataHeader(s_temp);
	}	

	function ln_SetDataHeader_Submit(){
		if (ds7.countrow<1){
			var s_temp = "EMPNO:STRING(10),APPDT:STRING(6),SENDFLAG:STRING(1)";
			ds7.SetDataHeader(s_temp);
		}
	}	

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
	function fnSelect(pYear, pEmpno) {	 //�⺻ ��ȸ
	        g_empno = pEmpno ;
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//		��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param);
			tr_post(tr1);

			
           
		    /*
			prompt('',ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//		��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param));

			*/
	}

	function fnSelect2(pYear, pEmpno) {	 //�����ٹ���
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS2=ds2)",
			    param);
			tr_post(tr1);
	}	
	
	function fnSelect3(pYear, pEmpno) {	 //��������
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS3=ds3)",
			    param);
			tr_post(tr1);
	}	

	function fnSelect4(pYear, pEmpno) {	 //��α�
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr2, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS4=ds4)",
			    param);
			tr_post(tr2);
	}	


	function fnSelect5(pYear, pEmpno) {	 //��½� �������� ��������
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS5=ds5)",
			    param);
			tr_post(tr1);
	}	


	function fnSelect6(pYear, pEmpno) {	 //��½� �������� ����������
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS6=ds6)",
			    param);
			tr_post(tr1);
	}	
	
	
	
/******************************************************************************
	Description : �߰�, ����, ����, ���
******************************************************************************/
    function fnApply() {// ���� �����ͼ� �ݿ�
       
        if (ds1.IsUpdated) {

			if(!fnSaveChk()){
				alert("���� ������ �̹� �Ǿ����ϴ�. �������� ������ ���� �����ڿ��� �����Ͻʽÿ�.");
				return;
			};
            
			v_job = "I";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030009i",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);
        } else {
            alert("�⺻���� ������ ���� ������ �����ϴ�.");
        }
    }
    
	function fnCancel() {	//��ҽ� undo all. 
		ds1.undoall();
	} 

	function fnAddRow3(){
		ds3.addrow();	
		ds3.namevalue(ds3.rowposition, "APPDT")="<%=eyy%>12";
		ds3.namevalue(ds3.rowposition, "EMPNO")="<%=eno%>";	
		ds3.namevalue(ds3.rowposition, "REF1")="F";
		ds3.namevalue(ds3.rowposition, "REF2")="F";
		ds3.namevalue(ds3.rowposition, "REF3")="F";
		ds3.namevalue(ds3.rowposition, "REF4")="F";
		ds3.namevalue(ds3.rowposition, "REF5")="F";
		ds3.namevalue(ds3.rowposition, "REF6")="F";
		ds3.namevalue(ds3.rowposition, "REF7")="F";
		ds3.namevalue(ds3.rowposition, "REF8")="F"; //2008�ͼ�
	};
	function fnDeleteRow3() {//Row ����
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("������ �ڷ��Դϴ�. �����Ҽ� �����ϴ�");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds3.DeleteRow(ds3.RowPosition);
	}

    function fnApply3() {// ���� �����ͼ� �ݿ�
		if(!Basic_Apply_Chk("ds3")) return; //�⺻ �������� üũ
		
		if (ds3.IsUpdated) {
			if(!fnSaveChk()){
				alert("���� ������ �̹� �Ǿ����ϴ�. �������� ������ ���� �����ڿ��� �����Ͻʽÿ�.");
				return;
			};

			v_job = "I";	
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030009i",
                "JSP(I:DS3=ds3,O:RESULT=ds_result)",	//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);
        } else {
            alert("�������� ������ ���� ������ �����ϴ�.");
        }
    };

	function fnCancel3() {	//��ҽ� undo all. 
		ds3.undoall();
	};


	function fnSubmit(){ //��������
		if(confirm("���� ������ �Ŀ��� ����Ÿ �Է�,����,������ �Ұ��մϴ�.\n\n���������� �Ͻðڽ��ϱ�?")){
			ln_SetDataHeader_Submit();

			ds7.Addrow();
			ds7.namevalue(ds7.rowposition,"EMPNO")=ds1.namevalue(ds1.rowposition,"EMPNO");
			ds7.namevalue(ds7.rowposition,"APPDT")=ds1.namevalue(ds1.rowposition,"APPDT");

			if (ds7.IsUpdated) {
				v_job = "I";	
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

				ln_TRSetting(tr1, 
					"/services/servlet/Payroll.p030009i",
					"JSP(I:DS7=ds7,O:RESULT=ds_result)",	//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
					param);
				tr_post(tr1);
			} else {
				alert("�������� �� �� �����ϴ�.");
			}
		}
	}

	function fnSaveChk(){ //������ �������ⱸ��üũ
		v_job = "S";	  //select �ϵ�..
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				  + ",eyy="       + <%=eyy%>
				  + ",eno="       + <%=eno%> ;
        
		ln_TRSetting(tr1, 
			"/services/servlet/Payroll.p030009i",	//		��� ������ ��!
			"JSP(O:DS9=ds9)",
			param);
		tr_post(tr1);

		if(ds9.namevalue(ds9.rowposition,"SENDFLAG")=="Y"){
			return false;
		}else{
            return true;
	    }
	}

	function fnPrint(){ //��¹�
   
        /*


	    if(fnSaveChk()){
			alert("�������� �����Դϴ�. �������� �� ����Ͻʽÿ�.");
			return;
		};

        */

        //��� ������ �۾��� ������.
		ds_print.ClearAll();
        fnSelect5("<%=eyy%>", "<%=eno%>");   //�ٷμҵ�Ű� ���-�⺻(��������)
		fnSelect6("<%=eyy%>", "<%=eno%>");   //�ٷμҵ�Ű� ���-�⺻
        var row=0;
		ln_Rpt_SetDataHeader();//����Ÿ ����� 
        ds_print.addrow();
 
        //�λ� �⺻���� 
		row = ds_print.rowposition;
		row1 = ds6.rowposition;
		ds_print.namevalue(row,"EMPNO")=ds6.namevalue(ds1.rowposition,"EMPNO")
		ds_print.namevalue(row,"YYYY")="<%=eyy%>";
		ds_print.namevalue(row,"EMPNMK")=ds6.namevalue(row1,"EMPNMK");
		ds_print.namevalue(row,"EMPJUNO")=ds6.namevalue(row1,"EMPJUNO");
		ds_print.namevalue(row,"COMPANY")="����ƻ�(��)";
		ds_print.namevalue(row,"COMRESINO")=ds6.namevalue(row1,"COMRESINO");
		ds_print.namevalue(row,"CURDT3")=ds6.namevalue(row1,"CURDT3"); //�ٹ�������
		ds_print.namevalue(row,"CURDT")="20091231" //�ٹ�������
	//	ds_print.namevalue(row,"CNT")=ds5.countrow;
		ds_print.namevalue(row,"CNT")=ds6.namevalue(row1,"CNT");
		ds_print.namevalue(row,"CURDT2") = gs_date;
        var dblref11=0;
		var dblref12=0;
		var dblref13=0;
		var dblref14=0;
		var dblref15=0;
		var dblref16=0;
		var dblref21=0;
		var dblref22=0;
		var dblref23=0;
		var dblref24=0;
		var dblref26=0;
  
        var i=0;

		for(i=1;i<=ds5.countrow;i++){
         
          ds_print.namevalue(row,"RELAT1_"+i)=ds5.namevalue(i,"RELAT1");

		  if(ds5.namevalue(i,"REF1")=="T")ds_print.namevalue(row,"REF1_"+i)="9"; //��.�ܱ���
		  else ds_print.namevalue(row,"REF1_"+i)="1";

		  if(ds5.namevalue(i,"REF2")=="T")ds_print.namevalue(row,"REF2_"+i)="O"; //�⺻����
		  else ds_print.namevalue(row,"REF2_"+i)="";

		  if(ds5.namevalue(i,"REF3")=="T")ds_print.namevalue(row,"REF3_"+i)="O"; //�����
		  else ds_print.namevalue(row,"REF3_"+i)="";

		  if(ds5.namevalue(i,"REF5")=="T")ds_print.namevalue(row,"REF5_"+i)="O"; //��ο��
		  else ds_print.namevalue(row,"REF5_"+i)=""; 

		  if(i>1){
            if(ds5.namevalue(i,"REF4")=="T")ds_print.namevalue(row,"REF4_"+i)="O"; //�ڳ������
		    else ds_print.namevalue(row,"REF4_"+i)="";

			if(ds5.namevalue(i,"REF7")=="T")ds_print.namevalue(row,"REF7_"+i)="O"; //���ڳ�
		    else ds_print.namevalue(row,"REF7_"+i)="";

			if(ds5.namevalue(i,"REF8")=="T")ds_print.namevalue(row,"REF8_"+i)="O"; //����Ծ�
		    else ds_print.namevalue(row,"REF8_"+i)="";

            ds_print.namevalue(row,"EMPNMK_"+i) = ds5.namevalue(i,"FAMNM1");
			ds_print.namevalue(row,"EMPJUNO_"+i) = ds5.namevalue(i,"RESINO1");
		    
		  }else if(i==1){
            if(ds5.namevalue(i,"REF6")=="T")ds_print.namevalue(row,"REF6_"+i)="O"; //�γ���
		    else ds_print.namevalue(row,"REF6_"+i)=""; 
		  }

		  ds_print.namevalue(row,"REF11_"+i)=ds5.namevalue(i,"REF11");
		  ds_print.namevalue(row,"REF12_"+i)=ds5.namevalue(i,"REF12");
		  ds_print.namevalue(row,"REF13_"+i)=ds5.namevalue(i,"REF13");
		  ds_print.namevalue(row,"REF14_"+i)=ds5.namevalue(i,"REF14");
		  ds_print.namevalue(row,"REF15_"+i)=ds5.namevalue(i,"REF15");
		  ds_print.namevalue(row,"REF16_"+i)=ds5.namevalue(i,"REF16");

		  ds_print.namevalue(row,"REF21_"+i)=ds5.namevalue(i,"REF21");
		  ds_print.namevalue(row,"REF22_"+i)=ds5.namevalue(i,"REF22");
		  ds_print.namevalue(row,"REF23_"+i)=ds5.namevalue(i,"REF23");
		  ds_print.namevalue(row,"REF24_"+i)=ds5.namevalue(i,"REF24");
		  ds_print.namevalue(row,"REF26_"+i)=ds5.namevalue(i,"REF26");

		  dblref11 += parseInt(ds5.namevalue(i,"REF11"));
		  dblref12 += parseInt(ds5.namevalue(i,"REF12"));
		  dblref13 += parseInt(ds5.namevalue(i,"REF13"));
		  dblref14 += parseInt(ds5.namevalue(i,"REF14"));
		  dblref15 += parseInt(ds5.namevalue(i,"REF15"));
		  dblref16 += parseInt(ds5.namevalue(i,"REF16"));

		  dblref21 += parseInt(ds5.namevalue(i,"REF21"));
		  dblref22 += parseInt(ds5.namevalue(i,"REF22"));
		  dblref23 += parseInt(ds5.namevalue(i,"REF23"));
		  dblref24 += parseInt(ds5.namevalue(i,"REF24"));
          dblref26 += parseInt(ds5.namevalue(i,"REF26"));
		}

        ds_print.namevalue(row,"REF11_S") = dblref11;  //�����(����û�ڷ�)
		ds_print.namevalue(row,"REF12_S") = dblref12;  //�Ƿ��
		ds_print.namevalue(row,"REF13_S") = dblref13;  //������
		ds_print.namevalue(row,"REF14_S") = dblref14;  //�ſ�ī��
		ds_print.namevalue(row,"REF15_S") = dblref15;  //���ݿ�����
		ds_print.namevalue(row,"REF16_S") = dblref16;  //��α�
		ds_print.namevalue(row,"REF21_S") = dblref21;  //�����(�׹����ڷ�)
		ds_print.namevalue(row,"REF22_S") = dblref22;  //�Ƿ��            
		ds_print.namevalue(row,"REF23_S") = dblref23;  //������            
		ds_print.namevalue(row,"REF24_S") = dblref24;  //�ſ�ī��          
		ds_print.namevalue(row,"REF26_S") = dblref26;  //��α�     

        
		//2009.01.06 ������� ����.//2009.12.21 ��� ���ϳ� 
		ds_print.namevalue(row,"GIVAMT1_1") = ds6.namevalue(row1,"GIVAMT1_1"); //��α�(����û�ڷ�)
		ds_print.namevalue(row,"GIVAMT2_1") = ds6.namevalue(row1,"GIVAMT2_1"); //��α�(�׹����ڷ�)

		/*���ݺ�������*/
        ds_print.namevalue(row,"BP31000") =ds6.namevalue(row1,"BP31000");//�����ٹ���(���ο���)
		ds_print.namevalue(row,"PENSUM") = ds6.namevalue(row1,"PENSUM"); //�����ٹ���(���ο���)
		ds_print.namevalue(row,"PENTOT") = parseInt(ds6.namevalue(row1,"BP31000"))+parseInt(ds6.namevalue(row1,"PENSUM")); //�հ�
        
				 
		ds_print.namevalue(row,"BP34000") =ds6.namevalue(row1,"BP34000");//�����ٹ���(��������)
		
		/*Ư������ - �����*/
		ds_print.namevalue(row,"BP32000") =ds6.namevalue(row1,"BP32000");//�����ٹ���(�ǰ�����)
		ds_print.namevalue(row,"BP33000") =ds6.namevalue(row1,"BP33000");//�����ٹ���(��뺸��)
		ds_print.namevalue(row,"INSAMT01") =ds6.namevalue(row1,"INSAMT01");//���ٹ���(�ǰ�����)
		ds_print.namevalue(row,"INSAMT02") =ds6.namevalue(row1,"INSAMT02");//���ٹ���(��뺸��)
		ds_print.namevalue(row,"INSAMT03") =ds6.namevalue(row1,"INSAMT03");//���ٹ���(�Ϲݺ��强����)
		ds_print.namevalue(row,"INSAMT04") =ds6.namevalue(row1,"INSAMT04");//���ٹ���(����κ��强����)

		if(parseInt(ds6.namevalue(row1,"INSAMT03"))>1000000){
			ds_print.namevalue(row,"INSAMT03S")=1000000;
		}else{
            ds_print.namevalue(row,"INSAMT03S")=ds6.namevalue(row1,"INSAMT03");
		}
		if(parseInt(ds6.namevalue(row1,"INSAMT04"))>1000000){
			ds_print.namevalue(row,"INSAMT04S")=1000000;
		}else{
            ds_print.namevalue(row,"INSAMT04S")=ds6.namevalue(row1,"INSAMT04");
		}
        
		//������
		ds_print.namevalue(row,"INSSUM") = parseInt(ds_print.namevalue(row,"BP32000"))+parseInt(ds_print.namevalue(row,"BP33000"))
			                             + parseInt(ds_print.namevalue(row,"INSAMT01"))+parseInt(ds_print.namevalue(row,"INSAMT02"))
			                             + parseInt(ds_print.namevalue(row,"INSAMT03"))+parseInt(ds_print.namevalue(row,"INSAMT04"));
	    //����������
		ds_print.namevalue(row,"INSSUMS")= parseInt(ds_print.namevalue(row,"BP32000"))+parseInt(ds_print.namevalue(row,"BP33000"))
			                             + parseInt(ds_print.namevalue(row,"INSAMT01"))+parseInt(ds_print.namevalue(row,"INSAMT02"))
			                             + parseInt(ds_print.namevalue(row,"INSAMT03S"))+parseInt(ds_print.namevalue(row,"INSAMT04S"));

		/*Ư������ - �Ƿ��*/
		ds_print.namevalue(row,"M_AMT1") =ds6.namevalue(row1,"M_AMT1");//����.���.�����
		ds_print.namevalue(row,"M_AMT2") =ds6.namevalue(row1,"M_AMT2");//�׹��ǰ��������
		ds_print.namevalue(row,"M_AMT3") =ds6.namevalue(row1,"M_AMT3");//�ſ�ī��
		ds_print.namevalue(row,"M_AMT4") =ds6.namevalue(row1,"M_AMT4");//����
		ds_print.namevalue(row,"M_SUM")  =ds6.namevalue(row1,"M_SUM"); //�ſ�ī�� + ����
		ds_print.namevalue(row,"M_SUMS") =ds6.namevalue(row1,"M_SUMS");//������

		/*Ư������ - ������*/
		ds_print.namevalue(row,"E_AMT1") =ds6.namevalue(row1,"E_AMT1");//����
		ds_print.namevalue(row,"E_AMT2") =ds6.namevalue(row1,"E_AMT2");//������
		ds_print.namevalue(row,"E_AMT3") =ds6.namevalue(row1,"E_AMT3");//���߰�
		ds_print.namevalue(row,"E_AMT4") =ds6.namevalue(row1,"E_AMT4");//���л�
		ds_print.namevalue(row,"E_AMT5") =ds6.namevalue(row1,"E_AMT5");//�����
		ds_print.namevalue(row,"E_SUM") = parseInt(ds6.namevalue(row1,"E_AMT1"))+ parseInt(ds6.namevalue(row1,"E_AMT2"))+ parseInt(ds6.namevalue(row1,"E_AMT3"))
			                            + parseInt(ds6.namevalue(row1,"E_AMT4"))+ parseInt(ds6.namevalue(row1,"E_AMT5"));
		//�ο�
		ds_print.namevalue(row,"E_CNT2") =ds6.namevalue(row1,"E_CNT2");//������
		ds_print.namevalue(row,"E_CNT3") =ds6.namevalue(row1,"E_CNT3");//���߰�
		ds_print.namevalue(row,"E_CNT4") =ds6.namevalue(row1,"E_CNT4");//���л�
		ds_print.namevalue(row,"E_CNT5") =ds6.namevalue(row1,"E_CNT5");//�����

		//�����ݾ�
		ds_print.namevalue(row,"E_AMT1S") =ds6.namevalue(row1,"E_AMT1S"); //����    
		ds_print.namevalue(row,"E_AMT2S") =ds6.namevalue(row1,"E_AMT2S");//������  
		ds_print.namevalue(row,"E_AMT3S") =ds6.namevalue(row1,"E_AMT3S");//���߰�  
		ds_print.namevalue(row,"E_AMT4S") =ds6.namevalue(row1,"E_AMT4S");//���л�  
		ds_print.namevalue(row,"E_AMT5S") =ds6.namevalue(row1,"E_AMT5S");//�����  
		ds_print.namevalue(row,"E_SUMS") = parseInt(ds6.namevalue(row1,"E_AMT1S"))+ parseInt(ds6.namevalue(row1,"E_AMT2S"))+ parseInt(ds6.namevalue(row1,"E_AMT3S"))
			                             + parseInt(ds6.namevalue(row1,"E_AMT4S"))+ parseInt(ds6.namevalue(row1,"E_AMT5S"));

		/*Ư������ - �����ڱ�*/
		ds_print.namevalue(row,"H_AMT1") =ds6.namevalue(row1,"H_AMT1"); //���ø�������  
		ds_print.namevalue(row,"H_AMT2") =ds6.namevalue(row1,"H_AMT2"); //���Ա�  
		ds_print.namevalue(row,"H_AMT3") =ds6.namevalue(row1,"H_AMT3"); //�������Ա�  
		 

        //�����ݾ�
		ds_print.namevalue(row,"H_AMT1S") =ds6.namevalue(row1,"H_AMT1S"); //���ø�������
		ds_print.namevalue(row,"H_AMT2S") =ds6.namevalue(row1,"H_AMT2S"); //���Ա�      
		ds_print.namevalue(row,"H_AMT3S") =ds6.namevalue(row1,"H_AMT3S"); //�������Ա�
		ds_print.namevalue(row,"H_AMT4S") =ds6.namevalue(row1,"H_AMT4S"); //�������Ա�  		
		ds_print.namevalue(row,"H_AMT5S") =ds6.namevalue(row1,"H_AMT5S"); //�������Ա�  	
		ds_print.namevalue(row,"H_SUMS") =ds6.namevalue(row1,"H_SUMS"); //�� 

		/*Ư������ - ��α�*/
		ds_print.namevalue(row,"CONAMT02") =ds6.namevalue(row1,"CONAMT02"); //��ġ�ڱݱ�α�
		ds_print.namevalue(row,"G_AMT1") =ds6.namevalue(row1,"G_AMT1"); //���װ���  
		ds_print.namevalue(row,"G_AMT2") =ds6.namevalue(row1,"G_AMT2"); //50%�ѵ�����  
		ds_print.namevalue(row,"G_AMT3") =ds6.namevalue(row1,"G_AMT3"); //30%�ѵ�����
		ds_print.namevalue(row,"CONAMT06") =ds6.namevalue(row1,"CONAMT06"); //������ü ��
		ds_print.namevalue(row,"CONAMT07") =ds6.namevalue(row1,"CONAMT07"); //������ü		
		//ds_print.namevalue(row,"G_AMT4") =ds6.namevalue(row1,"G_AMT4"); //������αݰ���  

		//alert("G_AMT1::"+ds_print.namevalue(row,"G_AMT1"));

        //�����ݾ�
		ds_print.namevalue(row,"CONAMT02S") =ds6.namevalue(row1,"CONAMT02S"); //��ġ�ڱݱ�α�
		ds_print.namevalue(row,"G_AMT1S") =ds6.namevalue(row1,"G_AMT1S"); //���װ���      
		ds_print.namevalue(row,"G_AMT2S") =ds6.namevalue(row1,"G_AMT2S"); //50%�ѵ�����   
		ds_print.namevalue(row,"G_AMT3S") =ds6.namevalue(row1,"G_AMT3S"); //30%�ѵ�����  
		ds_print.namevalue(row,"CONAMT06S") =ds6.namevalue(row1,"CONAMT06S"); //������ü ��
		ds_print.namevalue(row,"CONAMT07S") =ds6.namevalue(row1,"CONAMT07S"); //������ü			
		//ds_print.namevalue(row,"G_AMT4S") =ds6.namevalue(row1,"G_AMT4S"); //10%�ѵ�����  
		ds_print.namevalue(row,"G_SUMS") =ds6.namevalue(row1,"G_SUMS");  //��
        
		/*Ư������ - ȥ�κ�.�̻��.��ʺ�*/
		ds_print.namevalue(row,"W_SUMS") =ds6.namevalue(row1,"W_SUMS"); //����

		/*�׹��ǰ��� -  �ұ�� �һ���� �����α� �ҵ����*/
		ds_print.namevalue(row,"SM_AMT") =ds6.namevalue(row1,"SM_AMT"); //���Ծ�
		ds_print.namevalue(row,"SM_AMT") =ds6.namevalue(row1,"SM_AMTS"); //�����ݾ�

		/*�׹��ǰ��� - �����������*/
		ds_print.namevalue(row,"S_AMT1") =ds6.namevalue(row1,"S_AMT1");  //���ο�������
		ds_print.namevalue(row,"S_AMT2") =ds6.namevalue(row1,"S_AMT2");  //��������
		ds_print.namevalue(row,"S_SUM") =ds6.namevalue(row1,"S_SUM");   //���ݰ�����

        //�����������
		ds_print.namevalue(row,"S_AMT1S") =ds6.namevalue(row1,"S_AMT1S");  //���ο�������
		ds_print.namevalue(row,"S_AMT2S") =ds6.namevalue(row1,"S_AMT2S");  //��������
		ds_print.namevalue(row,"S_SUMS") =ds6.namevalue(row1,"S_SUMS");   //���ݰ�����

		/*�׹��ǰ��� - �����������ڰ���*/
		ds_print.namevalue(row,"T_SUM") =ds6.namevalue(row1,"T_SUM");    //��������
		ds_print.namevalue(row,"T_SUMS")=ds6.namevalue(row1,"T_SUMS");   //�������հ���

		/*�׹��ǰ��� - �ſ�ī��ҵ����*/
		ds_print.namevalue(row,"C_AMT1")=ds6.namevalue(row1,"C_AMT1");    //�ſ�.����.����
		ds_print.namevalue(row,"C_AMT2")=ds6.namevalue(row1,"C_AMT2");    //���ݿ�����
		ds_print.namevalue(row,"C_AMT3")=ds6.namevalue(row1,"C_AMT3");    //�п����γ���
		ds_print.namevalue(row,"C_AMT4")=ds6.namevalue(row1,"C_AMT4");    //�Ƿ���ߺ����� ==> 2008�� �ͼӺк��� ������ú������ ����
		ds_print.namevalue(row,"C_SUM")=ds6.namevalue(row1,"C_SUM");      //��
		ds_print.namevalue(row,"C_SUMS")=ds6.namevalue(row1,"C_SUMS");    //�ſ�ī�����

		/*�׹��ǰ��� - �츮���� �⿬�� �ҵ����*/
		ds_print.namevalue(row,"D_SUM")=ds6.namevalue(row1,"D_SUM");       //��
		ds_print.namevalue(row,"D_SUMS")=ds6.namevalue(row1,"D_SUMS");     //������

        /*�׹��ǰ��� - ����ֽ�������ҵ����*/
		ds_print.namevalue(row,"FD_AMT1")=ds6.namevalue(row1,"FD_AMT1");   //����1����
		ds_print.namevalue(row,"FD_AMT2")=ds6.namevalue(row1,"FD_AMT2");   //����2����
		ds_print.namevalue(row,"FD_AMT3")=ds6.namevalue(row1,"FD_AMT3");   //����3����
		ds_print.namevalue(row,"FD_SUM")=ds6.namevalue(row1,"FD_SUM");     //�����հ�
		ds_print.namevalue(row,"FD_AMT1S")=ds6.namevalue(row1,"FD_AMT1S"); //����1��������
		ds_print.namevalue(row,"FD_AMT2S")=ds6.namevalue(row1,"FD_AMT2S"); //����2��������
		ds_print.namevalue(row,"FD_AMT3S")=ds6.namevalue(row1,"FD_AMT3S"); //����3��������
		ds_print.namevalue(row,"FD_SUMS")=ds6.namevalue(row1,"FD_SUMS");   //�����հ����

		/*�׹��ǰ��� - �������� �ҵ����*/
		ds_print.namevalue(row,"F_SUM")=ds6.namevalue(row1,"F_SUM");       //��
		ds_print.namevalue(row,"F_SUMS")=ds6.namevalue(row1,"F_SUMS");     //������
        
		/*���װ��� - �ܱ����μ���*/
		ds_print.namevalue(row,"FX_AMT1")=ds6.namevalue(row1,"FX_AMT1");  
		ds_print.namevalue(row,"FX_AMT2")=ds6.namevalue(row1,"FX_AMT2");      
		ds_print.namevalue(row,"FX_NATION")=ds6.namevalue(row1,"FX_NATION");      
		ds_print.namevalue(row,"FX_DATE1")=ds6.namevalue(row1,"FX_DATE1");      
		ds_print.namevalue(row,"FX_DATE2")=ds6.namevalue(row1,"FX_DATE2"); 
        ds_print.namevalue(row,"FX_WORK")=ds6.namevalue(row1,"FX_WORK");     
		ds_print.namevalue(row,"FX_FRTO")=ds6.namevalue(row1,"FX_FRTO");      
		ds_print.namevalue(row,"FX_POSITION")=ds6.namevalue(row1,"FX_POSITION");      

		/*���װ��� - �����ڱ����Ա����ڼ��װ���*/
		ds_print.namevalue(row,"HX_AMT")=ds6.namevalue(row1,"HX_AMT");  
		ds_print.namevalue(row,"HX_AMTS")=ds6.namevalue(row1,"HX_AMTS");  //����

		/*���װ��� - �����ġ�ڱ�*/
		ds_print.namevalue(row,"GX_AMT")=ds6.namevalue(row1,"GX_AMT");  
		ds_print.namevalue(row,"GX_AMTS")=ds6.namevalue(row1,"GX_AMTS");  //����

		/*�����ٹ��� ����*/
		ds_print.namevalue(row,"WKNM") =ds6.namevalue(row1,"WKNM");        //�����ٹ�����
		ds_print.namevalue(row,"WKRESINO") =ds6.namevalue(row1,"WKRESINO");//����ڵ�Ϲ�ȣ
		ds_print.namevalue(row,"WK_AMT") =ds6.namevalue(row1,"WK_AMT");    //���� �ѱ޿���
 		ds_print.namevalue(row,"WK_AMTSD") =ds6.namevalue(row1,"WK_AMTSD");    //���� ��������

		getObjectFirst("gcrp_print").preview();
	}

	function ln_Rpt_SetDataHeader(){ //��¹� ����Ÿ ����� ����
		var ls_temp = "";
		if (ds_print.countrow<1){
			ds_print.SetDataHeader(ls_temp);
			ls_temp1 = "EMPNO:STRING(7),YYYY:STRING(4),EMPNMK:STRING(20),EMPJUNO:STRING(13),COMPANY:STRING(50),COMRESINO:STRING(10),CURDT3:STRING(8),CURDT2:STRING(8),CURDT:STRING(8),"     
					 + "REF11_S:DECIMAL(9.0),REF12_S:DECIMAL(9.0),REF13_S:DECIMAL(9.0),REF14_S:DECIMAL(9.0),REF15_S:DECIMAL(9.0),REF16_S:DECIMAL(9.0),"
					 + "REF21_S:DECIMAL(9.0),REF22_S:DECIMAL(9.0),REF23_S:DECIMAL(9.0),REF24_S:DECIMAL(9.0),REF26_S:DECIMAL(9.0),"
                     + "CNT:INT(2),GIVAMT1_1:DECIMAL(9.0),GIVAMT2_1:DECIMAL(9.0),"		 
					 + "RELAT1_1:STRING(1),REF1_1:STRING(1),REF2_1:STRING(1),REF3_1:STRING(1),REF5_1:STRING(1),REF6_1:STRING(1),REF7_1:STRING(1),REF8_1:STRING(1),"
					 + "REF11_1:DECIMAL(9.0),REF12_1:DECIMAL(9.0),REF13_1:DECIMAL(9.0),REF14_1:DECIMAL(9.0),REF15_1:DECIMAL(9.0),REF16_1:DECIMAL(9.0),"
					 + "REF21_1:DECIMAL(9.0),REF22_1:DECIMAL(9.0),REF23_1:DECIMAL(9.0),REF24_1:DECIMAL(9.0),REF26_1:DECIMAL(9.0),"
                     + "EMPNMK_2:STRING(20),EMPJUNO_2:STRING(13),"
					 + "RELAT1_2:STRING(1),REF1_2:STRING(1),REF2_2:STRING(1),REF3_2:STRING(1),REF4_2:STRING(1),REF5_2:STRING(1),REF7_2:STRING(1),REF8_2:STRING(1),"
					 + "REF11_2:DECIMAL(9.0),REF12_2:DECIMAL(9.0),REF13_2:DECIMAL(9.0),REF14_2:DECIMAL(9.0),REF15_2:DECIMAL(9.0),REF16_2:DECIMAL(9.0),"
					 + "REF21_2:DECIMAL(9.0),REF22_2:DECIMAL(9.0),REF23_2:DECIMAL(9.0),REF24_2:DECIMAL(9.0),REF26_2:DECIMAL(9.0),"
					 + "EMPNMK_3:STRING(20),EMPJUNO_3:STRING(13),"
					 + "RELAT1_3:STRING(1),REF1_3:STRING(1),REF2_3:STRING(1),REF3_3:STRING(1),REF4_3:STRING(1),REF5_3:STRING(1),REF7_3:STRING(1),REF8_3:STRING(1),"
					 + "REF11_3:DECIMAL(9.0),REF12_3:DECIMAL(9.0),REF13_3:DECIMAL(9.0),REF14_3:DECIMAL(9.0),REF15_3:DECIMAL(9.0),REF16_3:DECIMAL(9.0),"
					 + "REF21_3:DECIMAL(9.0),REF22_3:DECIMAL(9.0),REF23_3:DECIMAL(9.0),REF24_3:DECIMAL(9.0),REF26_3:DECIMAL(9.0),"
					 + "EMPNMK_4:STRING(20),EMPJUNO_4:STRING(13),"
					 + "RELAT1_4:STRING(1),REF1_4:STRING(1),REF2_4:STRING(1),REF3_4:STRING(1),REF4_4:STRING(1),REF5_4:STRING(1),REF7_4:STRING(1),REF8_4:STRING(1),"
					 + "REF11_4:DECIMAL(9.0),REF12_4:DECIMAL(9.0),REF13_4:DECIMAL(9.0),REF14_4:DECIMAL(9.0),REF15_4:DECIMAL(9.0),REF16_4:DECIMAL(9.0),"
					 + "REF21_4:DECIMAL(9.0),REF22_4:DECIMAL(9.0),REF23_4:DECIMAL(9.0),REF24_4:DECIMAL(9.0),REF26_4:DECIMAL(9.0),"
					 + "EMPNMK_5:STRING(20),EMPJUNO_5:STRING(13),"
					 + "RELAT1_5:STRING(1),REF1_5:STRING(1),REF2_5:STRING(1),REF3_5:STRING(1),REF4_5:STRING(1),REF5_5:STRING(1),REF7_5:STRING(1),REF8_5:STRING(1),"
					 + "REF11_5:DECIMAL(9.0),REF12_5:DECIMAL(9.0),REF13_5:DECIMAL(9.0),REF14_5:DECIMAL(9.0),REF15_5:DECIMAL(9.0),REF16_5:DECIMAL(9.0),"
					 + "REF21_5:DECIMAL(9.0),REF22_5:DECIMAL(9.0),REF23_5:DECIMAL(9.0),REF24_5:DECIMAL(9.0),REF26_5:DECIMAL(9.0),"
					 + "EMPNMK_6:STRING(20),EMPJUNO_6:STRING(13),"
					 + "RELAT1_6:STRING(1),REF1_6:STRING(1),REF2_6:STRING(1),REF3_6:STRING(1),REF4_6:STRING(1),REF5_6:STRING(1),REF7_6:STRING(1),REF8_6:STRING(1),"
					 + "REF11_6:DECIMAL(9.0),REF12_6:DECIMAL(9.0),REF13_6:DECIMAL(9.0),REF14_6:DECIMAL(9.0),REF15_6:DECIMAL(9.0),REF16_6:DECIMAL(9.0),"
					 + "REF21_6:DECIMAL(9.0),REF22_6:DECIMAL(9.0),REF23_6:DECIMAL(9.0),REF24_6:DECIMAL(9.0),REF26_6:DECIMAL(9.0),"
					 + "EMPNMK_7:STRING(20),EMPJUNO_7:STRING(13),"
					 + "RELAT1_7:STRING(1),REF1_7:STRING(1),REF2_7:STRING(1),REF3_7:STRING(1),REF4_7:STRING(1),REF5_7:STRING(1),REF7_7:STRING(1),REF8_7:STRING(1),"
					 + "REF11_7:DECIMAL(9.0),REF12_7:DECIMAL(9.0),REF13_7:DECIMAL(9.0),REF14_7:DECIMAL(9.0),REF15_7:DECIMAL(9.0),REF16_7:DECIMAL(9.0),"
					 + "REF21_7:DECIMAL(9.0),REF22_7:DECIMAL(9.0),REF23_7:DECIMAL(9.0),REF24_7:DECIMAL(9.0),REF26_7:DECIMAL(9.0),"
					 + "EMPNMK_8:STRING(20),EMPJUNO_8:STRING(13),"
					 + "RELAT1_8:STRING(1),REF1_8:STRING(1),REF2_8:STRING(1),REF3_8:STRING(1),REF4_8:STRING(1),REF5_8:STRING(1),REF7_8:STRING(1),REF8_8:STRING(1),"
					 + "REF11_8:DECIMAL(9.0),REF12_8:DECIMAL(9.0),REF13_8:DECIMAL(9.0),REF14_8:DECIMAL(9.0),REF15_8:DECIMAL(9.0),REF16_8:DECIMAL(9.0),"
					 + "REF21_8:DECIMAL(9.0),REF22_8:DECIMAL(9.0),REF23_8:DECIMAL(9.0),REF24_8:DECIMAL(9.0),REF26_8:DECIMAL(9.0),"
					 + "EMPNMK_9:STRING(20),EMPJUNO_9:STRING(13),"
					 + "RELAT1_9:STRING(1),REF1_9:STRING(1),REF2_9:STRING(1),REF3_9:STRING(1),REF4_9:STRING(1),REF5_9:STRING(1),REF7_9:STRING(1),REF8_9:STRING(1),"
					 + "REF11_9:DECIMAL(9.0),REF12_9:DECIMAL(9.0),REF13_9:DECIMAL(9.0),REF14_9:DECIMAL(9.0),REF15_9:DECIMAL(9.0),REF16_9:DECIMAL(9.0),"
					 + "REF21_9:DECIMAL(9.0),REF22_9:DECIMAL(9.0),REF23_9:DECIMAL(9.0),REF24_9:DECIMAL(9.0),REF26_9:DECIMAL(9.0),"
					 + "EMPNMK_10:STRING(20),EMPJUNO_10:STRING(13),"
					 + "RELAT1_10:STRING(1),REF1_10:STRING(1),REF2_10:STRING(1),REF3_10:STRING(1),REF4_10:STRING(1),REF5_10:STRING(1),REF7_10:STRING(1),REF8_10:STRING(1),"
					 + "REF11_10:DECIMAL(9.0),REF12_10:DECIMAL(9.0),REF13_10:DECIMAL(9.0),REF14_10:DECIMAL(9.0),REF15_10:DECIMAL(9.0),REF16_10:DECIMAL(9.0),"
					 + "REF21_10:DECIMAL(9.0),REF22_10:DECIMAL(9.0),REF23_10:DECIMAL(9.0),REF24_10:DECIMAL(9.0),REF26_10:DECIMAL(9.0),"
					 + "BP31000:DECIMAL(9.0),PENSUM:DECIMAL(9.0),PENTOT:DECIMAL(9.0),"
					 + "BP32000:DECIMAL(9.0),INSAMT01:DECIMAL(9.0),BP33000:DECIMAL(9.0),BP34000:DECIMAL(9.0),INSAMT02:DECIMAL(9.0),INSAMT03:DECIMAL(9.0),"
					 + "INSAMT03S:DECIMAL(9.0),INSAMT04:DECIMAL(9.0),INSAMT04S:DECIMAL(9.0),INSSUM:DECIMAL(9.0),INSSUMS:DECIMAL(9.0),"
					 + "M_AMT1:DECIMAL(9.0),M_AMT2:DECIMAL(9.0),M_SUM:DECIMAL(9.0),M_SUMS:DECIMAL(9.0),M_AMT3:DECIMAL(9.0),M_AMT4:DECIMAL(9.0),"
					 + "E_CNT2:DECIMAL(9.0),E_CNT3:DECIMAL(9.0),E_CNT4:DECIMAL(9.0),E_CNT5:DECIMAL(9.0)"
					 + "E_AMT1:DECIMAL(9.0),E_AMT1S:DECIMAL(9.0),E_AMT2:DECIMAL(9.0),E_AMT2S:DECIMAL(9.0),E_AMT3:DECIMAL(9.0),E_AMT3S:DECIMAL(9.0),"
					 + "E_AMT4:DECIMAL(9.0),E_AMT4S:DECIMAL(9.0),E_AMT5:DECIMAL(9.0),E_AMT5S:DECIMAL(9.0),E_SUM:DECIMAL(9.0),E_SUMS:DECIMAL(9.0),"
					 + "H_AMT1:DECIMAL(9.0),H_AMT1S:DECIMAL(9.0),H_AMT2:DECIMAL(9.0),H_AMT2S:DECIMAL(9.0),H_AMT3:DECIMAL(9.0),H_AMT3S:DECIMAL(9.0),H_SUMS:DECIMAL(9.0),"
					 +"CONAMT02:DECIMAL(9.0),CONAMT02S:DECIMAL(9.0),G_AMT1:DECIMAL(9.0),G_AMT1S:DECIMAL(9.0),G_AMT2:DECIMAL(9.0),G_AMT2S:DECIMAL(9.0),G_AMT3:DECIMAL(9.0),G_AMT3S:DECIMAL(9.0),"
  				     +"CONAMT06:DECIMAL(9.0),CONAMT06S:DECIMAL(9.0),CONAMT07:DECIMAL(9.0),CONAMT07S:DECIMAL(9.0),E_AMT5:DECIMAL(9.0),G_SUMS:DECIMAL(9.0),"
					 + "W_SUMS:DECIMAL(9.0),"
					 + "SM_AMT1:DECIMAL(9.0),SM_AMTS:DECIMAL(9.0),"
					 + "S_AMT1:DECIMAL(9.0),S_AMT1S:DECIMAL(9.0),S_AMT2:DECIMAL(9.0),S_AMT2S:DECIMAL(9.0),S_SUM:DECIMAL(9.0),S_SUMS:DECIMAL(9.0),"
					 + "T_SUM:DECIMAL(9.0),T_SUMS:DECIMAL(9.0),"
					 + "C_AMT1:DECIMAL(9.0),C_AMT2:DECIMAL(9.0),C_AMT3:DECIMAL(9.0),C_AMT4:DECIMAL(9.0),C_SUM:DECIMAL(9.0),C_SUMS:DECIMAL(9.0),"
					 + "D_SUM:DECIMAL(9.0),D_SUMS:DECIMAL(9.0),"
                     + "FD_AMT1:DECIMAL(9.0),FD_AMT1S:DECIMAL(9.0),FD_AMT2:DECIMAL(9.0),FD_AMT2S:DECIMAL(9.0),FD_AMT3:DECIMAL(9.0),FD_AMT3S:DECIMAL(9.0),FD_SUM:DECIMAL(9.0),FD_SUMS:DECIMAL(9.0),"
					 + "F_SUM:DECIMAL(9.0),F_SUMS:DECIMAL(9.0),"
					 + "FX_AMT1:DECIMAL(9.0),FX_AMT2:DECIMAL(9.0),FX_NATION:STRING(30),FX_DATE1:STRING(8),FX_DATE2:STRING(8),"
					 + "FX_WORK:STRING(30),FX_FRTO:STRING(12),FX_POSITION:STRING(30),"
					 + "HX_AMT:DECIMAL(9.0),HX_AMTS:DECIMAL(9.0),GX_AMT:DECIMAL(9.0),GX_AMTS:DECIMAL(9.0),"
					 + "WKNM:STRING(30),WKRESINO:STRING(10),WK_AMT:DECIMAL(9.0),WK_AMTSD:DECIMAL(9.0)";
			
			ds_print.SetDataHeader(ls_temp1);
		}
	}

    //�ֹι�ȣ ����� �տ� �⵵ ���̱�
    function ln_yyyymmdd(strGb,strGb2,strResino){

        //�ֹι�ȣ�� ������� ����� (yyyymmdd)
		if(strGb==3||strGb==4){ //2000���
           strResino="20"+strResino;
		}else if(strGb==5||strGb==6){ //�ܱ���
		   if(strGb2>="00"&&strGb2<="10"){ //���Ƿ� 10�⵵ ������
			 strResino="20"+strResino;
		   }else{
             strResino="19"+strResino;
		   }
		}else{
		    strResino="19"+strResino; //�� ��.  
		}
		return strResino;
	}
   

/******************************************************************************
	Description : �� �˾�â ����
******************************************************************************/
function openOfc(){
	dest = "P030009_ofc1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"ofc", "left=0,top=0,width=704,height=750,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openInsu(juno){
	dest = "P030009_insu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=800,height=560,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openMedi(juno){
	dest = "P030009_medi1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=1000,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openEdu(juno){
	dest = "P030009_edu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=850,height=560,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openCard(juno){
	dest = "P030009_card1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=840,height=660,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openGibu(){
	dest = "P030009_gibu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"gibu", "left=0,top=0,width=1004,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

//�������(�⺻����)
function openBasic(){
	dest = "P030009_basic_ref1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"basic", "left=0,top=0,width=704,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

//����� �޴���
function ln_Manual(){
	window.open('./files/YearManual.hwp','','resizable=yes,width=800,height=600,scrollbars=no,status=no');
}
</script>

<script language="javascript"  for="gr3" event="OnExit(row,colid,olddata)">
//�ֹι�ȣ �Է½� �ڵ����� - ��ο��, �ڳ�, ����
    var strResino="";
	var strGb="";
	var strGb2="";

	if(colid =="RESINO1"){
		
		//2008.12.29 jys
        //�ֹι�ȣ üũ
        if(ds3.namevalue(row, "REF1")=="T"){ //�ܱ���
            if(!gn_FgResino(ds3.namevalue(row, "RESINO1"))) return;
		}else{ //������
			if(!gn_Resino(ds3.namevalue(row, "RESINO1"))) return;
		}

		strResino = ds3.namevalue(row, "RESINO1");
		//strResino = strResino.substring(0,6);
        strGb = strResino.substring(6,7);
		strGb2 = strResino.substring(0,2);
		strResino = strResino.substring(0,6);
		strResino = ln_yyyymmdd(strGb,strGb2,strResino);

		//alert("strResino::"+strResino);
       
		//��ο��
		if(strResino<="19391231"){ //2009�⵵ ����
			ds3.namevalue(row,"REF5")="T";
		}else{
            ds3.namevalue(row,"REF5")="F";
		}

		//�ڳ������ (������,�Ծ���,�����ӿ�, ��Ź�Ƶ��̸鼭, 20030101 ����
		if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5"||ds3.namevalue(row, "RELAT1")=="7")&& strResino>="20030101"){
			ds3.namevalue(row,"REF4")="T";
		}else{
			ds3.namevalue(row,"REF4")="F";
	    }

        //��� �Ծ�
		if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5")&& strResino>="20090101"){
			ds3.namevalue(row,"REF8")="T";
		}else{
			ds3.namevalue(row,"REF8")="F";
	    }

	}


</script>
 
 
<script language=javascript for="gr3" event="OnClick(row, Colid)">
//�������� Ŭ���� �� �˾� ����
    var strResino="";
	var strGb="";
	var strGb2="";

    if(row<1){
     return;
    }
	//���� - �ڳ������ �� ���ڳ� üũ �ȵ�.
	//2008 - ��� �߰� ��
	if(ds3.namevalue(row,"RELAT1")=="0"||ds3.namevalue(row,"RELAT1")=="1"){
		if((Colid=="REF4")||(Colid=="REF7")||(Colid=="REF8")){
			ds3.namevalue(row,"REF4")="F";
			ds3.namevalue(row,"REF7")="F";
			ds3.namevalue(row,"REF8")="F";
		}
	}
	

	//�ڳ������ üũ
	//������ �Ǵ� �Ծ���,��Ź�Ƶ��̸� �ֹι�ȣ�� 2003.1.1 ���� ����� ����
    if((Colid=="REF4")){    
		if(ds3.namevalue(row, "RESINO1")!=""){
			strResino = ds3.namevalue(row, "RESINO1");
			strGb = strResino.substring(6,7);
			strGb2 = strResino.substring(0,2);
			strResino = strResino.substring(0,6);
			strResino = ln_yyyymmdd(strGb,strGb2,strResino);
            
			if(ds3.namevalue(row,"REF4")=="F") return;

			 //�ڳ������ 
			if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5"||ds3.namevalue(row, "RELAT1")=="7")&&strResino>="20030101"){ //2009�⵵ ����
				ds3.namevalue(row,"REF4")="T";
			}else{
				ds3.namevalue(row,"REF4")="F";
			}
		}
	}
	 
	  

	//����ڿ��üũ
    if((Colid=="REF5")){    
		if(ds3.namevalue(row, "RESINO1")!=""){
			strResino = ds3.namevalue(row, "RESINO1");
			//strResino = strResino.substring(0,6);
			strGb = strResino.substring(6,7);
			strGb2 = strResino.substring(0,2);
			strResino = strResino.substring(0,6);
			strResino = ln_yyyymmdd(strGb,strGb2,strResino);

			 //��ο��
			if(strResino<="19391231"){ //2009�⵵ ����
				ds3.namevalue(row,"REF5")="T";
			}else{
				ds3.namevalue(row,"REF5")="F";
			}
		}
	}
	
   
	//�γ��ڰ��� üũ
	if((Colid=="REF6")){    
		//���� - ������ ��� �γ��� ���� �ȵ�.
        if(ds3.namevalue(row,"RELAT1")=="0"){
			strResino = ds3.namevalue(row, "RESINO1");
			if(strResino==""){
				ds3.namevalue(row,"REF6")="F";	
				alert("�ֹε�Ϲ�ȣ ���� �Է��Ͻʽÿ�.");
				return;
			}else{
			   var strResino_chk = strResino.substring(6,7);
			   if(strResino_chk=="2"||strResino_chk=="4"){
				 // alert(ds3.namevalue(row,"REF6"));
				 // if(ds3.namevalue(row,"REF6")=="T") ds3.namevalue(row,"REF6")="F";		
				 // else ds3.namevalue(row,"REF6")="T";		
			   }else ds3.namevalue(row,"REF6")="F";		
			}
		}else{
			ds3.namevalue(row,"REF6")="F";	
		}
	}

   
	//���ڳ�
	//������ �� �⵵üũ & �ڳ� �� ��츸 ����
	if((Colid=="REF7")){
      
	   strResino = ds3.namevalue(row, "RESINO1");
	   if(strResino==""){
		  ds3.namevalue(row,"REF7")="F";	
		  alert("�ֹε�Ϲ�ȣ ���� �Է��Ͻʽÿ�.");
		  return;
	   }
		strGb = strResino.substring(6,7);
		strGb2 = strResino.substring(0,2);
		strResino = strResino.substring(0,6);
		strResino = ln_yyyymmdd(strGb,strGb2,strResino);

        /*
		if(g_empno=="3080141"){
            alert("strResino:::"+strResino);
			alert("REF2:::"+ds3.namevalue(row,"REF2"));
			alert("RELAT1:::"+ds3.namevalue(row,"RELAT1"));
		}
		*/

        if(ds3.namevalue(row,"REF7")=="F") return;

       //�⺻���� & ������ & �ֹι�ȣ�� 2009�� �̻��� ��츸 ���� 
	    if(ds3.namevalue(row,"REF2")=="T"&&ds3.namevalue(row,"RELAT1")=="4"){
			if(strResino>="19890101"){ //2009�⵵ ����
			
			}else{
				ds3.namevalue(row,"REF7")="F";
			}

	    }else{
		   ds3.namevalue(row,"REF7")="F";	
	    }
	}



	//����Ծ� ���� üũ
	if((Colid=="REF8")){
	   strResino = ds3.namevalue(row, "RESINO1");
	   if(strResino==""){
		  ds3.namevalue(row,"REF8")="F";	
		  alert("�ֹε�Ϲ�ȣ ���� �Է��Ͻʽÿ�.");
		  return;
	   }
	   strResino = strResino.substring(0,2);
       //�⺻���� & ������ & �ֹι�ȣ�� 2009�� �̻��� ��츸 ���� 
	   if(ds3.namevalue(row,"REF2")=="T"&&(ds3.namevalue(row,"RELAT1")=="4"||ds3.namevalue(row,"RELAT1")=="5")&&strResino=="09"){
		
	   }else{
		   ds3.namevalue(row,"REF8")="F";	
	   }
	}


    //alert("SysStatus::"+ds3.SysStatus(row));
	//alert("FLAGCOL::"+ds3.namevalue(row,"FLAGCOL"));

    if(ds3.SysStatus(row)==1&&ds3.namevalue(row,"FLAGCOL")==""){ // ������
		if ((Colid =="REF11") || (Colid =="REF21") || (Colid =="REF12") || (Colid == "REF22")||(Colid =="REF13") || (Colid == "REF23")||(Colid =="REFc1")||(Colid == "REFc2") ) {
				alert("�������� ����������� ���� �Է�/���� �� ���Է�â�� ����ּ���.");
				return;		
		};
	}

	if ( (Colid =="REF11") || (Colid =="REF21") || (Colid =="REF12") || (Colid == "REF22")||(Colid =="REF13") || (Colid == "REF23")||(Colid =="REFc1")||(Colid == "REFc2") ) {
		if (ds3.namevalue(ds3.rowposition, "RESINO1").length < 13) {
			alert("�������� ����������� ���� �Է�/���� �� ���Է�â�� ����ּ���.");
			return;
		};
	};

    
    if ((Colid =="REF11") || (Colid =="REF21")) { 
//    	alert("�����");
    	openInsu(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF12") || (Colid == "REF22")) {
//    	alert("�Ƿ��");    
		openMedi(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF13") || (Colid == "REF23")) {	
//    	alert("������");    
		openEdu(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REFc1") || (Colid == "REFc2")) {
//    	alert("ī��/��");    
		openCard(ds3.namevalue(ds3.rowposition, "RESINO1"));
	}
//    alert(ds3.namevalue(ds3.rowposition, "REF11"));
//REF11,21,12,22,13,23,14,24
</script>

<script language="javascript" for="tr1" event="onsuccess()">
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//����
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnSelect("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (���μҵ� + ���)
//		fnSelect2("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (�����ٹ�)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
//		fnSelect4("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��α�)		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    };	
	// ������� �׽�Ʈ �Ϸ� : ds_result�� ���� ���� �� ���־�� ������ �ȳ���.~
</script>

<script language="javascript" for="tr2" event="onsuccess()">
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//����
	    gf_msg();1
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
						//		fnSelect("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (���μҵ� + ���)
//		fnSelect2("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (�����ٹ�)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
//		fnSelect4("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��α�)		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    };	
	// ������� �׽�Ʈ �Ϸ� : ds_result�� ���� ���� �� ���־�� ������ �ȳ���.~
</script>

<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
// ��� �޼��� Ȯ��...
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_msg!=""){
        alert(v_msg);
    }
</script>
<script language=javascript for=ds4 event="OnLoadCompleted(row)">
	if(row==0) return;

    var intGIVAMT_10A=ds4.namevalue(row,"GIVAMT_10A");
	var intGIVAMT_10B=ds4.namevalue(row,"GIVAMT_10B");
	var intGIVAMT_30A=ds4.namevalue(row,"GIVAMT_30A");
	var intGIVAMT_30B=ds4.namevalue(row,"GIVAMT_30B");
	var intGIVAMT_42A=ds4.namevalue(row,"GIVAMT_42A");
	var intGIVAMT_42B=ds4.namevalue(row,"GIVAMT_42B");
	var intGIVAMT_40A=ds4.namevalue(row,"GIVAMT_40A");
	var intGIVAMT_40B=ds4.namevalue(row,"GIVAMT_40B");

    var intCOMSUM = parseInt(intGIVAMT_10A) + parseInt(intGIVAMT_10B)+ parseInt(intGIVAMT_30A) + parseInt(intGIVAMT_30B)
	              + parseInt(intGIVAMT_42A) + parseInt(intGIVAMT_42B)+ parseInt(intGIVAMT_40A) + parseInt(intGIVAMT_40B);
	
	getObjectFirst("CONSUM").text= intCOMSUM;

</script>


<script language=JavaScript for=gcrp_print event=OnError()>

// alert("Error Code = " + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);

</script>

<%=HDConstant.COMMENT_START%>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_print classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �޼��� -->
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �޼��� -->
    <param name="SyncLoad"  value="false">
</object>
<%=HDConstant.COMMENT_END%>

<BODY text=#000000 bgColor=#ffffff style='padding:0px' OnLoad="ln_Start()"> 
<FORM name=entry action="" method=post>
	<INPUT type=hidden value=2007 name=eyy> 
	<INPUT type=hidden value=200089 name=eno> <!-- ��� -->

<%=HDConstant.COMMENT_START%>
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='���'				ID=APPDT   		Width=63	</C>    
	<C> Name='���'				ID=EMPNO  		Width=60	</C>    
	<C> Name='�ҼӺμ�'			ID=DEPTCD  		Width=60	</C>    
	<C> Name='����'				ID=PAYGRD  		Width=60	</C>    
	<C> Name='�׷��Ի���'			ID=JOINDATE  	Width=60	</C>    
	<C> Name='����'				ID=EMPNMK  		Width=40	</C>    
	<C> Name='�ֹι�ȣ'			ID=EMPJUNO  	Width=60	</C> 	
	<C> Name='��ȭ��ȣ'			ID=TELNUM	  	Width=60	</C>
	<C> Name='�ּ�'				ID=ADDRESS  	Width=60	</C>
	<C> Name='�����޿�'			ID=TAX_PAY  	Width=80	</C>
	<C> Name='������'			ID=TAX_BNS  	Width=60	</C>
	<C> Name='�����ҵ��'			ID=TAX_SUM  	Width=60	</C>
	<C> Name='������ҵ��'		ID=NTAX_SUM  	Width=60	</C>
	<C> Name='���ټ�'  			ID=DEDUCT1 		Width=60	</C>	
	<C> Name='�ֹμ�'  			ID=DEDUCT2 		Width=60	</C>	
	<C> Name='���ο���'			ID=DEDUCT3 		Width=60	</C>                                                             
	<C> Name='�ǰ�����'			ID=DEDUCT4 		Width=60	</C>
	<C> Name='��뺸��'			ID=DEDUCT5  	Width=60	</C>
	<C> Name='���ø��������'		ID=HOUAMT01 		Width=63	</C>    
	<C> Name='�������Աݻ�ȯ'		ID=HOUAMT02 		Width=60	</C>    
	<C> Name='������������6'		ID=HOUAMT03 		Width=60	</C>    
	<C> Name='������������10'		ID=HOUAMT04 		Width=60	</C>
	<C> Name='������������15'		ID=HOUAMT05 		Width=60	</C> 	
	<C> Name='�����ڱݰ�'			ID=HOUSUM 	     	Width=60	</C>    
	<C> Name='��αݰ�'			ID=CONSUM	 		Width=60	</C>
	<C> Name='���ο���'			ID=ETCAMT011A    	Width=40	</C>    
	<C> Name='��������'			ID=ETCAMT01A 		Width=60	</C>
	<C> Name='�������Ա�(����'		ID=DEDAMT03 		Width=60	</C>
	<C> Name='��ġ��α�(����'		ID=DEDAMT04		Width=60	</C>	
	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	</C>		
	">
</OBJECT>	

<OBJECT id=gr2  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds2">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='�ٹ�ó��'			ID=BF_WKNM     			Width=60	</C>    
	<C> Name='����ڵ�'			ID=BF_RESINO			Width=60	</C> 
	<C> Name='�����޿�'			ID=BF_TAX_PAY			Width=60	</C>    
	<C> Name='������'			ID=BF_TAX_BNS			Width=60	</C> 
	<C> Name='�����ҵ�'			ID=BF_TAX_SUM 			Width=60	</C>    
	<C> Name='�������'			ID=BF_NTAX_SUM 			Width=60	</C> 
	<C> Name='�����ҵ�'			ID=BF_DEDUCT1   		Width=60	</C>    
	<C> Name='�����ֹ�'			ID=BF_DEDUCT2			Width=60	</C> 
	<C> Name='���ο���'			ID=BF_DEDUCT3			Width=60	</C>    
	<C> Name='�ǰ�����'			ID=BF_DEDUCT4			Width=60	</C> 
	<C> Name='�ǰ�����'			ID=BF_DEDUCT5			Width=60	</C>
	">
</OBJECT>	

<OBJECT id=gr4  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds4">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='100%�ѵ� ����û'	ID=GIVAMT_10A 	Width=60	</C>    
	<C> Name='100%�ѵ� �׹�'	ID=GIVAMT_10B	Width=60	</C>    
	<C> Name='50%�ѵ� ����û'	ID=GIVAMT_30A	Width=60	</C>    
	<C> Name='50%�ѵ� �׹�'		ID=GIVAMT_30B	Width=60	</C> 
	<C> Name='30%�ѵ� ����û'	ID=GIVAMT_42A	Width=60	</C>    
	<C> Name='30%�ѵ� �׹�'		ID=GIVAMT_42B	Width=60	</C> 
	<C> Name='10%�ѵ� ����û'	ID=GIVAMT_40A	Width=60	</C>    
	<C> Name='10%�ѵ� �׹�'		ID=GIVAMT_40B 	Width=60	</C>    
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

<TABLE cellSpacing=0 cellPadding=0 width=854 border=0>
  <TR>
    <TD vAlign=top width=1003 bgColor=#ffffff height=62>

	  <TABLE cellSpacing=0 cellPadding=0 width=1003 align=center border=0>
        <TR>
          <TD><IMG src="imgs/tit_01_14.gif"></TD>
		  <TD align=right>
		    <!--  <img src="./imgs/btn_menu.gif"	style="cursor:hand;position:relative;left:-5px" onmouseover="this.src='./imgs/btn_menu.gif'"	onmouseout="this.src='./imgs/btn_menu.gif'"		onclick="ln_Manual()"> -->
			 <img src="./imgs/btn_menu9.gif"	style="cursor:hand;position:relative;left:-5px" onmouseover="this.src='./imgs/btn_menu9.gif'"	onmouseout="this.src='./imgs/btn_menu9.gif'"		onclick="ln_Manual()">
		  </TD>
		</TR>
		<!-- <TR>
		  <TD colspan=2 align=right>
		    <img src="../Sales/images/print.gif"	style="cursor:hand;position:relative;left:-7px"	align=absmiddle onClick="fnPrint()">
		  </TD>
		</TR> -->

	  </TABLE>
	  
	  
	  <BR>
	  <!--�������� -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD width=30 bgColor=#aad2ff rowSpan=4>����<BR>���� 
          <TD width=82>�����ȣ</TD>
          <TD width=160>�Ҽ�</TD>
          <TD width=140>����</TD>
          <TD width=106>�׷��Ի���</TD>
          <TD width=140>����</TD>
          <TD width=150>�ֹε�Ϲ�ȣ</TD>
          <TD>��ȭ��ȣ</TD></TR>
        <TR align=CENTER bgColor=#ffffff>
      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPNO" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="0000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="DEPTCD" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="PAYGRD" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="JOINDATE" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPNMK" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="000000-0000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="TELNUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="000000000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
        </TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD colSpan=4>�� ��</TD>
          <TD colSpan=3>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#ffffff>
          <TD colSpan=4><%=HDConstant.COMMENT_START%>
				<object id="ADDRESS" style= "position:relative;left:0px;top:2px;width:465px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD colSpan=3>&nbsp;</TD>
		</TR>
	  </TABLE>
		  
	
	<!-- �ٷμҵ� -->
	  <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        <TR align=CENTER>
          <TD width=30 bgColor=#aad2ff rowSpan=2>����</TD>
          <TD bgColor=#aad2ff colSpan=4><%=eyy%>�� �ٷμҵ�</TD>
          <TD bgColor=#aad2ff colSpan=5><%=eyy%>�� ��õ¡��</TD>
          <TD bgColor=#aad2ff>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD width=79>�����޿�</TD>
          <TD width=79>������</TD>
          <TD width=79>�����ҵ� ��</TD>
          <TD width=79>������ҵ� ��</TD>
          <TD width=79>���ټ�</TD>
          <TD width=79>�ֹμ�</TD>
          <TD width=79>���ο���</TD>
          <TD width=79>�ǰ�����</TD>
          <TD width=79>��뺸��</TD>
          <TD>&nbsp;</TD>
		</TR>
        <TR align=CENTER>
          <TD bgColor=#e8f3ff>�ݾ�</TD>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_BNS" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="NTAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT1" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT2" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT3" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT4" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT5" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff>&nbsp;</TD>
		</TR>
        <TR bgColor=#ffffff>
          <TD colSpan=14><!--
						&nbsp;&nbsp;�� ������� <br>
						&nbsp;&nbsp;&nbsp;&nbsp;�� �� �� �� �� : 2004�� ��������� �츮�������� �ҵ������ �޾Ҵ� �����
						2006�� ESOP�ֽ� �����Ͽ� �߻��� �ҵ��� &quot;�ٷμҵ�&quot;�� �ջ�˴ϴ�. <br>
						&nbsp;&nbsp;&nbsp;&nbsp;�� ������ҵ� : ���� - �ؿܱٹ��� �� 100����, �ڳຸ������ 10���� / �ؿ� - �ܱ����� ���� �� 150����,
						Ȳ�������� �� ��Ÿ ������ҵ� <br>-->
			&nbsp;&nbsp;<!-- <FONT color=#ff6633>�� �� �ݾ��� 12�� �޿� ���� �� ��ȸ�ڷ��̹Ƿ� 2007�� ���� Ȯ�� �ݾ��� �ƴմϴ�.</FONT> --> </TD>
		  </TR>
	  </TABLE><BR><BR>

	  <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        <TR bgColor=#ffffff>
          <TD colSpan=6><B>I. ���س⵵ "����Ի��� �� �ٹ�ó�� 2�� �̻��� ���" ��(��)�ٹ��� �ҵ� �� ��õ¡�� ��Ȳ�� �Է¹ٶ��ϴ�.</B>
		                <BR><FONT color=#3366ff>&nbsp;&nbsp;�� �󼼳��� ��ȸ �� ����� �ҷ���</FONT> <FONT color=#ff6633> <B>�ۼ�</B></FONT> <FONT color=#3366ff>��ư�� ��������.</FONT>
					   </TD></TR>
        <TR bgColor=#ffffff>
          <TD></TD>
          <TD width=25></TD>
          <TD></TD>
          <TD width=40></TD>
          <TD></TD>
          <TD width=930 align="right"><img src="./imgs/btn_write2.gif" style="cursor:hand" align=absmiddle onClick="openOfc()"></TD>
		 </TR>
	  </TABLE><!-- ���ٹ��� ��õ¡�� ��Ȳ -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        
        <TR align=CENTER>
          <TD width=30 bgColor=#ffedd2 rowSpan=2>����</TD>
          <TD bgColor=#ffedd2 colSpan=2  onclick="openOfc();" style="cursor:hand"><b>ȸ���</b></TD>
          <TD bgColor=#ffffff colSpan=2><%=HDConstant.COMMENT_START%>
				<object id="BF_WKNM" style= "position:relative;left:0px;top:2px;width:265px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffedd2 colSpan=2>����ڵ�Ϲ�ȣ</TD>
          <TD bgColor=#ffffff colSpan=2><%=HDConstant.COMMENT_START%>
				<object id="BF_RESINO" style= "position:relative;left:0px;top:2px;width:165px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffedd2>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#ffedd2>
          <TD align=CENTER>�����޿�</TD>
          <TD align=CENTER>������</TD>
          <TD align=CENTER>�����ҵ� ��</TD>
          <TD align=CENTER>������ҵ� ��</TD>
          <TD align=CENTER>�������ټ�</TD>
          <TD align=CENTER>�����ֹμ�</TD>
          <TD align=CENTER>���ο���</TD>
          <TD align=CENTER>�ǰ�����</TD>
          <TD align=CENTER>��뺸��</TD></TR>
        <TR align=left>
          <TD align=CENTER bgColor=#ffedd2>�ݾ�</TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_PAY" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_BNS" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_NTAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT1" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT2" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT3" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT4" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT5" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

		</TR>
	  </TABLE>


	  <BR>
	  <BR>

	  <!-- �������� �� �����׸� -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=800><B>��. ���� ���ΰ� �ξ簡���� �������� �� ���� �׸��� ����(��) �Ǵ� �Է¹ٶ��ϴ�.</B> 
          </TD>
          <TD vAlign=bottom align=right></TD>
          <TD vAlign=bottom align=right></TD></TR>
        <TR>
          <TD width=900><FONT color=#3366ff>&nbsp;&nbsp;�� ���ǻ��� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;�� "���������ȳ�"�� �ݵ�� �����Ͻ� �� �Է¹ٶ��ϴ�. 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;�� �Է� �� �����Ŀ��� �ݵ�� "����" ��ư�� �����ֽñ� �ٶ��ϴ�. 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff6633><B>��&nbsp;����û �ڷ�� : 
            ����û Ȩ���������� �����ϴ� ������������ �ݾ� 
            �Է�</B></FONT>
			<BR>&nbsp;&nbsp;&nbsp;&nbsp;<B>��&nbsp;�׹��� �ڷ�� : ����û���� 
            �����ϴ� �������� �̿��� �� �Է�</B> </FONT>
			<BR>&nbsp;&nbsp;&nbsp;&nbsp;<B>��&nbsp;���߰� �� ��� �ݵ�� ��������,�⺻����,�߰����� �Է� �� ���� ��ư�� ���� �����Ͻʽÿ�. <BR>
			    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� �� Ư������(�����, �Ƿ��, ������, ī��/����)�� �Է��Ͻʽÿ�.  
			<BR>&nbsp;&nbsp;&nbsp;<B>��&nbsp;�߰������� �ڳ�-�ڳ������, ���-��ꡤ�Ծ�, ���ڳ�-���ڳ��߰� ������ �ǹ��մϴ�.
			</FONT>
            <BR>&nbsp;&nbsp;&nbsp;<FONT color=#ff6633><B>��&nbsp;���� : 
            ���ؿ������� ��Ź�Ƶ��� �ξ簡���� �߰��Ǿ����ϴ�. �����Ծ��ڴ� �������ڳ�, ��Ź�Ƶ��� ��Ÿ�� ���� �˴ϴ�.
            </B></FONT>
		  </TD>

          <TD vAlign=bottom align=right colSpan=2><!-- <A 
            href="javascript:showDiv('write_guide',%20'../../images/Self/btn_guideclose.gif',%20'../../images/Self/btn_guideopen.gif');"><IMG 
            id=imgsrc src="imgs/btn_guideopen.gif" border=0></A> -->
        </TD></TR></TABLE>

      <!-- Hidden Start///////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
      <DIV id=write_guide style="DISPLAY: none">
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=12 bgColor=#ffedd2 
            rowSpan=30>��<BR><BR>��<BR><BR>��<BR><BR>��<BR><BR>��<BR><BR>��<BR><BR>��<BR><BR>��</TD>
          <TD vAlign=top>
            <TABLE cellSpacing=0 cellPadding=2 width="100%" border=0>
              
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>1. �⺻����</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) �� �� : ���踦 �����ϴ�(�ֹε�ϵ�� ���Ű���) �ٷ���(����� ����)�� 
                  ��������(�����θ� ����), �ڳ�, ���� �Ծ���, �����ڸ�, ��Ź�Ƶ�</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) ������ : �ٷ��� ������ �ֹε�ϵ�� ���������� �ݵ�� üũ�Ͽ��� 
                  <U><B>"�����ڱ� ����"</B></U>�� ��û�� �� ����. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) �����ܱ��� : ����� �� �ξ簡���� �ܱ����� ��� "�ܱ��� ��"���� üũ�� �� 
                  <U><B>"�ܱ��ε�Ϲ�ȣ �Ǵ� ���ǹ�ȣ"</B></U>�� ������. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>4) �ֹε�Ϲ�ȣ : �Է��� ����⵵�� �ξ簡�� �⺻���� ���� ���ɰ� 
                  �߰�����(�ڳ������, ��ο��) ���� ���θ� �ڵ�üũ��. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>�� �� �� �� : 
                  �������� ����. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>�� �ξ簡�� : 
                  ��60�� �̻� ����,���� �������ӡ����� - 1949.12.31 ���� 
                  ��&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  ��20�� ���� �����ӡ������ڸ� - 1989.01.01 ������ </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>�� �ڳ���� : 
                  ��6�� ���� ������ - 2003.01.01 ������ </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>�� ��ο�� : 
				  ��70�� �̻� - 
                  1939.12.31 ������ </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#ff6633>5) ���� �ҵ�ݾ� : <U><B>"�ξ簡�� 
                  ��������"</B></U>�� �����Ǵ� ���� ���� �Ѽҵ�ݾ�(��/�� + ������ + ���ڼҵ� + ����ҵ� �� 
                  �հ��)�� 
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  "100��������(�ҵ���� ���� �� �ݾ�)"�� ��� �ݵ�� üũ�Ͽ��� ����� �� �ξ簡���� �⺻������ ���� �� 
                  ����. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">�� ���� �Ѽҵ�ݾ� = ���� �����ҵ� - 
                  �ҵ����(�ʿ����� ����) </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">&nbsp;&nbsp;&nbsp;&nbsp;��) 
                  �ٷμҵ�(��/��)�� �ִ� ��� �����ҵ��� <U><B>�� 700���� ����</B></U>�� ���� ���� �����ϳ�, 
                  100���� �̻��� �������� ���Ե� ���� ���� �Ұ�����. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>2. �߰�����</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) �γ��� ���� : �ٷ��� ������ ������ ��쿡�� üũ�� �� ����. (���� �ٷ��ڴ� 
                  ���ö��� ��Ȱ��ȭ �Ǿ� üũ �Ұ�����.)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">�� ��ȥ������ ��� : �ֹε�ϵ�� �⺻������ ����޴� 
                  �ξ簡���� �ִ� �������̸� ���� ������. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">�� ��ȥ������ ��� : ȥ�νŰ� �� �γ����̸� ���� 
                  ������. (������ �ҵ����� �������.) </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) �ڳ������ : �������� ��6�� ������ ��쿡�� üũ�� �� ����. (��7�� 
                  �ʰ��ڴ� ���ö��� ��Ȱ��ȭ �Ǿ� üũ �Ұ�����.)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">�� �¹��� �κ��� ��� - �θ��� 1�θ� ���� ���� ���� 
                </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 200px">- �� �ڳ࿡ ���� ������ �⺻������ �ް� ����ڰ� 
                  �߰��� �ڳ����������� ���� �� ����. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) ����� ���� : ���������� ������, ���� �Ѽҵ�ݾ��� 100���� ������ ������� 
                  ��쿡�� �ش���� üũ�� �� ����.</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">(���� �ҵ�ݾ� 100���� ���� �� ���� üũ �� �� 
                  ��� ���ö��� ��Ȱ��ȭ�Ǿ� üũ �Ұ�����)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>3. Ư������</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#3366ff>�� ����û �ڷ� : ����û Ȩ���������� �����ϴ� 
                  �ڷ� (��ǥ�� �� - ���ݿ�����)</FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#3366ff>&nbsp;&nbsp;&nbsp;&nbsp;�׹��� 
                  �ڷ� : ����û���� �����ϴ� �������� �̿��� �� (����ó�� �� �ش� ������� ��� �����ϴ� �ڷ�) 
                </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) ����� : ���� �� ���踦 �����ϴ� ������ "�Ǻ�����"�� �Ͽ� ���� �ٷ��ڰ� ���� 
                  ������ "�ҵ���� ������ ���强 ����� ���� �հ�� " ���� </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px"><FONT color=#ff6633>�� ����� �� 
                  �ξ簡���� �⺻���� ������(���ɡ��ҵ��� ������)���� �ش���� Ȱ��ȭ�Ǿ� �Է� ������. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px">�� ��������뺸���� �Ǻ����ڰ� ���� �ҵ�ݾ� 100���� 
                  ������ ������̾�� �ϸ� �������� "����� ���� ���强 �����"��� ����Ǿ� �־�� ��.</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) �Ƿ�� : ���� �� ���踦 �����ϴ� ������ ���Ͽ� ���� �ٷ��ڰ� ���� ������ ġ�� 
                  �� �������� �Ƿ�� ���� <U><B>(�����ݾ� = �ҵ���� ����)</B></U> </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px">�� �Ȱ� �� ����Ʈ���� ���Ժ���� 1�δ� 50���� 
                  �ѵ������� �Ƿ�� ����׿� ���Ե�. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) ������ : ���� �� ���踦 �����ϴ� ������ ���Ͽ� ������ ������, ���б�, 
                  �������, ������ �Ƶ��� �п������� �� ���� </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>4) �ſ�ī�塤�п��� ���γ��Ρ����ݿ����� : ���� �� ���踦 �����ϴ� ����(�����ڸ� 
                  ����)�� ������ �ſ�ī�塤���ݿ����� ���� ���� �� �п��� ����� �� 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  ���ܱ����� ���� ������ ���� �п��� ������ ���� �ݵ�� <U><B>"����(ZERO)����"</B></U>�� 
                  �̿��Ͽ� ������ �ݾ� ����</TD></TR></TABLE></TD></TR></TABLE></DIV>
<!-- Hidden END ///////////////////////////////////////////////////////////////////////////////////////////////////////////// -->

<table width=1003>
	<tr>
		<td>&nbsp;</td>
		<td align="right"><br>
		<nobr>
			<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
			<img src="./imgs/btn_ref2.gif"	style="cursor:hand"	align=absmiddle onClick="openBasic()">
			<img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow3()">
			<img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow3()">
			<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply3();">
			<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel3()">
		</nobr>&nbsp;</td>
	</tr>					
</table>

<!-- CheckBox���·� ǥ���� Column�� Interger�� ���  Check Data�� 1, 0�� ����ϸ�, String�� ��� Check Data�� ��T��, ��F���� ����Ѵ�-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gr3  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 1003px; HEIGHT: 300px;border:1 solid #777777;display:;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds3">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<Param Name="UsingOneClick"   value="1">	
	<param name="SuppressOption"  value="1">
	<param name="Format" 		  value="  
	<G> name='��������'	
		<C> Name='����'		ID=RELAT1	HeadAlign=Center align=center   Width=87  EditStyle=Combo
		 Data='0:����,1:��������,2:�������,3:�����,4:�������ڳ�,5:�������ڳ��,6:�����ڸ�,7:��Ÿ'</C>
		<C> Name='����'		ID=FAMNM1	HeadAlign=Center align=center   Width=50	</C>
		<C> Name='�ܱ���'	ID=REF1	    HeadAlign=Center align=center   Width=40	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<G> name='�⺻����'
		<C> Name='�ֹι�ȣ'	ID=RESINO1  HeadAlign=Center align=center   Width=92   mask='XXXXXX-XXXXXXX'	</C>
		<C> Name='�⺻'	    ID=REF2	    HeadAlign=Center align=center   Width=28	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<G> name='�߰�����'		
		<C> Name='�����'	ID=REF3	    HeadAlign=Center align=center   Width=38	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='�ڳ�'		ID=REF4	    HeadAlign=Center align=center   Width=28	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='���'		ID=REF5	    HeadAlign=Center align=center   Width=28	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='�γ���'	ID=REF6	    HeadAlign=Center align=center   Width=39	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='���ڳ�'	ID=REF7	    HeadAlign=Center align=center   Width=40	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='���'	    ID=REF8	    HeadAlign=Center align=center   Width=28	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<X> name='Ư������'
		<G> name='�����'
			<C> Name='����û'	ID=REF11	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='�׿�'		ID=REF21	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='�Ƿ��'		
			<C> Name='����û'	ID=REF12	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='�׿�'		ID=REF22	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='������'
			<C> Name='����û'	ID=REF13	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='�׿�'		ID=REF23	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='ī��/����'		
			<C> Name='����û'	ID=REFc1	HeadAlign=Center align=right  Width=63	EDIT=none  Value={Number(REFc1)} Dec=0</C>
			<C> Name='�׿�'		ID=REFc2	HeadAlign=Center align=right  Width=63	EDIT=none  Value={Number(REFc2)} Dec=0</C>
		</G>			
	</X>					
	<C> Name='���'				ID=APPDT   		Width=63	show=false</C> 
	<C> Name='���'				ID=EMPNO  		Width=60	show=false</C> 
	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

<br><br><br>
  
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        <TR bgColor=#ffffff>
          <TD ><B>��. ���� ��Ÿ ���� �׸񿡴� "�ٷ��� ���� ����"�� ������ �ݾ׸� �Է¹ٶ��ϴ�.</B><BR>
		  </TD> 
		</TR>
		<TR>
		  <td align="right"><br>
			<nobr>
				<!-- <img src="./imgs/btn_submit.gif" style="cursor:hand" align=absmiddle onClick="fnSubmit()"> -->
				<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
				<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
			</nobr>&nbsp;</td>
		</TR>
      </TABLE>
            
      <TABLE cellSpacing=1 cellPadding=3 width=1003 align=center bgColor=#666666  border=2>
        
       <TR bgColor=#ffedd2>
          <TD align=CENTER rowSpan=15>Ư<BR>��<BR><BR>��<BR>��</TD>
          <TD align=CENTER width=50>�� ��</TD>
          <TD align=CENTER colSpan=2>�� �� �� ��</TD>
          <TD align=CENTER width=130>�� �� �� ��</TD>
          <TD align=CENTER width=90>�� �� �� ��</TD>
          <TD align=CENTER>�� �� �� ��</TD>
	   </TR>
      <!-- <TR> -->
         <!--  <TD align=CENTER bgColor=#fff8ee rowSpan=4>�����ڱ�</TD>  -->
          <!-- <TD align=left width=110 bgColor=#ffffff rowSpan=3>&nbsp;���ø�������</TD>
          <TD align=left width=140 bgColor=#ffffff>&nbsp;�� û������</TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=3>�ٷ��� ���� ������ <BR>�� ���Ծ� 
            <BR>(40% ���� ������ �ݾ�)</TD>
          <TD align=CENTER bgColor=#ffffff ROWSPAN=3><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff >&nbsp;* �ٷ��� ������ �������̸�, �������� <BR></FONT>
		  </TD> -->
		<!-- </TR> -->
        <!-- <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� �ٷ������ø�������</TD>
		  <TD bgColor=#ffffff rowspan=2>&nbsp;* �ٷ��� ������ �������̸�, �������ñԸ� 1ä ���� ������
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 2005.12.31 ���� ������ : �������ñԸ�
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 2006.1.1 ���� ������ : �������ñԸ�+���డ�Խ��� ���ؽð� 3������<BR></FONT>
		  </TD>
		</TR> -->
        <!-- <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� ������ø�������</TD>
		</TR> -->

        <TR>
		  <TD align=CENTER bgColor=#fff8ee rowSpan=5>�����ڱ�</TD> 
          <TD align=left  width=240 bgColor=#ffffff colSpan=2>&nbsp;�����������Ա�</TD>
          <TD align=CENTER bgColor=#ffffff>�ٷ��� ���θ�����<BR>�� �����ݻ�ȯ��<BR>(40%���� 
            ������ݾ�)</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* <B>���ø�������� ������� ������</B><BR>
		     &nbsp;* �������� �������ڷ� �������ñԸ������� ������ �����ϱ� ���� <BR>&nbsp;&nbsp;&nbsp;&nbsp;������ ��� �� �����ݻ�ȯ ���� 
		  </TD>
		</TR>
        <TR>
          <TD align=left  width=110 bgColor=#ffffff rowSpan=3>&nbsp;�������<BR>&nbsp;�������Ա� 
          </TD>
          <TD align=left  width=125 bgColor=#ffffff>&nbsp;�� ��ȯ�Ⱓ 14�� �̸� </TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=3>�ٷ��� ���θ�����<BR>&nbsp;�� 
          ���ڻ�ȯ��</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=4>&nbsp;* �ٷ��� ������ �������̸�, 
            �������ñԸ��� ����(�о�ǡ����ֱ� 3���<BR>&nbsp;&nbsp;&nbsp;&nbsp;����)�� ����ϱ� ���Ͽ� ���ÿ� 
            ������� �����ϰ� ������ ���<BR>&nbsp;&nbsp;&nbsp;&nbsp;�� ���ڻ�ȯ�� ���� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 2006�� �ű� 
            �����������������<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ���� ��� 
            �о��/���ֱ� �򰡾��� 3��� ���Ͽ��� ��.</FONT> 
		  </TD>
		</TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� ��ȯ�Ⱓ 15�� �̻� </TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� ��ȯ�Ⱓ 30�� �̻� </TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT05" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>�����ڱ� ��</TD>
          <TD align=CENTER bgColor=#fff8ee>
			<%=HDConstant.COMMENT_START%>
			<object id="HOUSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
  	    </TR>    
		
		<!-- ��α� -->
		<TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=9  onclick="openGibu();"  width="60" style="cursor:hand"><b>��α�</b>
		  <!-- <img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();"> -->
		  <img src="./imgs/btn_write2.gif" style="cursor:hand" align=absmiddle onClick="openGibu()">
		  </TD>
          
		  <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;���װ�����α�</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>����û�ڷ�</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>����.�����.������<BR>���� �� ��αݾ�<BR>��ġ�ڱ�(���θ���)</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_10A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2>&nbsp;* ������α�  <br>
		  &nbsp;* ��ġ�ڱ� : ����(�Ŀ�ȸ �� ���Ű�������ȸ ����)�� ����� �� ��ġ�ڱ� 
           <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 10���� ���� �ݾ��� ���װ��� + 10���� �ʰ� �ݾ��� �ҵ���� </FONT><BR>
		  &nbsp;* �������⿬�� : ��ȭ����������� ���� ��ȭ������� �⿬ �ݾ�
		                              
            <!-- ������ݡ������ǿ��ݡ�����/�縳�б��� �ü��� � ����� ���<BR>&nbsp;&nbsp;&nbsp;&nbsp;�� ��ξ� 
            ���� <BR><BR>&nbsp;* ����(�Ŀ�ȸ �� ���Ű�������ȸ ����)�� ����� �� ��ġ�ڱ� ���� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 10���� ���� �ݾ��� ���װ��� + 10���� �ʰ� �ݾ��� �ҵ���� </FONT><BR><BR>&nbsp;* ��������ȭ����������������ȸ���������ڼ���ü �� 
            ���ͼ���ü�� ����� ��� <BR>&nbsp;&nbsp;&nbsp;&nbsp;�� ��ξ� ���� <BR><BR>-->
		 </TD>
		</TR> 
		<TR>
          <TD align=CENTER bgColor=#fff8ee>�׹����ڷ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_10B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>
        
		<TR>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;50%�ѵ� ��α�</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>����û�ڷ�</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>����.�����.������<BR>���� �� ��αݾ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_30A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		 <TD class=tit_f10 bgColor=#ffffff rowSpan=2>&nbsp;* Ư�ʱ�α� : ������ �� ����� �����ϴ� ��α�<BR>
		 ��������,Ư���������,�����⿬�������,�ѱ�������۰���,�ѱ������������ ��ľƵ� ����ؼ� �Ǵ� ������Ƶ� ������������ ���� �񿵸�����<BR>
		 <FONT color=#ff6633>* ���͹��α�ν�Ź��α� : 3�Ⱓ �̿���������
		</TD>		
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>�׹����ڷ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_30B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>
		<TR>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;30%�ѵ� ��α�</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>����û�ڷ�</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>�ٷ��� ���θ�����<BR>�� ��αݾ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_42A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		 <TD class=tit_f10 bgColor=#ffffff rowSpan=2>&nbsp;* �츮�������ձ�α� <br>
		  �츮�������տ� �����ϴ� ��α�(�츮�������տ��� �����ϴ� ��α� ����)       
		</TD>		
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>�׹����ڷ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_42B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>
        <TR>
          <TD align=left bgColor=#ffffff 
            rowSpan=2>&nbsp;������α� </TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>����û�ڷ�</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>����.�����.������<BR>���� �� ��αݾ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_40A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		  <TD class=tit_f10 bgColor=#ffffff rowSpan=2>&nbsp;* ������ü��α�(10%�ѵ�)
		   <br>&nbsp;* ������α�(15%�ѵ�)
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>�׹����ڷ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_40B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>��α� ��</TD>
          <TD align=CENTER bgColor=#fff8ee><%=HDConstant.COMMENT_START%>
			<object id="CONSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
			 <TD class=tit_f10 bgColor=#ffffff>&nbsp;       
		    </TD>
		</TR>
<!--
		 <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=3>ȥ��<BR>���<BR>�̻���<BR>����</TD>
          <TD align=CENTER bgColor=#ffffff colSpan=2 >&nbsp;ȥ�ΰ���</TD>
		  <TD align=CENTER bgColor=#ffffff>ȥ�� �Ǵ� 100����</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
            <object id=MARCNT01 style= "position:relative;left:0px;top:2px;width:85px;" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
					<param name=CBData			value="0^0 ȸ,1^1 ȸ,2^2 ȸ,3^3 ȸ,4^4 ȸ,5^5 ȸ,6^6 ȸ,7^7 ȸ,8^8 ȸ,9^9 ȸ">
					<param name=Index           value="0">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value="NAME">
					<param name=Sort			value=True>
					<param name=ListExprFormat	value="NAME^1^60">								
					<param name=BindColumn		value="CODE">
			</object>
			<%=HDConstant.COMMENT_END%>
            </TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=3>&nbsp;* �ѱ޿��� 2,500���� ������ �ٷ���<BR>
          <FONT color=#3366ff> &nbsp;&nbsp;&nbsp;&nbsp;�� ȥ�Τ���� ���� : �⺻���������(���ɺҹ�)<BR>
		   &nbsp;&nbsp;&nbsp;&nbsp;�� �̻��� ���� : ���� �������� �ּ��̵�(������ü�̵�)</FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff colSpan=2>��ʰ���</TD>
		  <TD align=CENTER bgColor=#ffffff>��� �Ǵ� 100����</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id=MARCNT02 style= "position:relative;left:0px;top:2px;width:85px;" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
					<param name=CBData			value="0^0 ȸ,1^1 ȸ,2^2 ȸ,3^3 ȸ,4^4 ȸ,5^5 ȸ,6^6 ȸ,7^7 ȸ,8^8 ȸ,9^9 ȸ">
					<param name=Index           value="0">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value="NAME">
					<param name=Sort			value=True>
					<param name=ListExprFormat	value="NAME^1^60">								
					<param name=BindColumn		value="CODE">
			</object>
			<%=HDConstant.COMMENT_END%>
            </TD>
		</TR>
		<TR>
          <TD align=CENTER bgColor=#ffffff colSpan=2>�̻������</TD>
		  <TD align=CENTER bgColor=#ffffff>�̻� �Ǵ� 100����</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id=MARCNT03 style= "position:relative;left:0px;top:2px;width:85px;" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
					<param name=CBData			value="0^0 ȸ,1^1 ȸ,2^2 ȸ,3^3 ȸ,4^4 ȸ,5^5 ȸ,6^6 ȸ,7^7 ȸ,8^8 ȸ,9^9 ȸ">
					<param name=Index           value="0">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value="NAME">
					<param name=Sort			value=True>
					<param name=ListExprFormat	value="NAME^1^60">								
					<param name=BindColumn		value="CODE">
			</object>
			<%=HDConstant.COMMENT_END%>
            </TD>
		</TR>
-->
        <TR>
		  <TD align=CENTER bgColor=#ffedd2 rowSpan=12>��<BR>Ÿ<BR>��<BR>��<BR>��<BR>��</TD>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>���ο���</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=2>&nbsp;2000�� ���� ������ ����</TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>ȸ�� ��ü ���� ����<BR>(2000�� ���� �Ի���)</FONT></TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>ȸ���ϰ�ó��</FONT></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2><FONT color=#ff6633>&nbsp;* ȸ�翡�� ��ü ������ ���ѻ��� ���ο��� ���Ծ��� ������ ���� �Է����� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;����. <BR>&nbsp;&nbsp;&nbsp;&nbsp;�� ��ü ���� ��ǰ�� : ��������55(60)�� ����, ���̵帲 10�ⳳ, 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ����������55��</FONT> 
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff>�ٷ��� ���θ�����<BR>�� ���Ծ�</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="ETCAMT011A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		  value="0">
					<param name=Alignment 	  value=2 >
					<param name=Numeric		  value="true">
					<param name=Border	 	  value="false">		
					<param name=InheritColor  value="true">																																																				
					<param name=ReadOnly  	  value="false">
					<param name=SelectAll  	  value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
           </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>��������</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=2>&nbsp;2001�� ���� ������ ����</TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>ȸ�� ��ü ���� ����<BR>(2001�� ���� �Ի���)</FONT></TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>ȸ���ϰ�ó��</FONT></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2><FONT color=#ff6633>&nbsp;* ȸ�翡�� ��ü ������ ���ѻ��� �������� ���Ծ��� ������ ���� �Է�����<BR>&nbsp;&nbsp;&nbsp; ����. <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;�� ��ü ���� ��ǰ�� : �̷��� ������� </FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff>�ٷ��� ���θ�����<BR>�� ���Ծ�</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="ETCAMT01A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
		 </TR>

         <TR>
          <TD align=center bgColor=#ffffff rowSpan=4>&nbsp;���ø���<BR>����</TD>
          <TD align=left colspan=2 bgColor=#ffffff>&nbsp;�� û������</TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=4>�ٷ��� ���� ������ <BR>�� ���Ծ� 
            <BR>(40% ���� ������ �ݾ�)</TD>
          <TD align=CENTER bgColor=#ffffff ROWSPAN=4><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff >&nbsp;* �ٷ��� ������ �������̸�, �������� <BR></FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=left colspan=2 bgColor=#ffffff>&nbsp;�� �ٷ������ø�������</TD>
		  <TD bgColor=#ffffff rowspan=3>&nbsp;* �ٷ��� ������ �������̸�, �������ñԸ� 1ä ���� ������
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 2005.12.31 ���� ������ : �������ñԸ�
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 2006.1.1 ���� ������ : �������ñԸ�+���డ�Խ��� ���ؽð� 3������<BR></FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=left colspan=2 bgColor=#ffffff>&nbsp;�� ������ø�������</TD>
		</TR>
        <TR>
          <TD align=left colspan=2 bgColor=#ffffff>&nbsp;�� ����û����������</TD>
		</TR>

		 <TR>
          <TD align=center bgColor=#ffffff rowSpan=4>&nbsp;�ݵ�</TD>
          <TD align=left colspan=2 rowSpan=3 bgColor=#ffffff>&nbsp; ����ֽ�������ҵ����</TD>
          <TD align=left bgColor=#ffffff >&nbsp;�� ���� 1���� ���Ծ�</TD>
          <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff rowspan=3><FONT color=#ff6633>&nbsp;* 2008.10.20 ���� ����ֽ�������(�������ݵ�) ���Ծ� <BR>
		   &nbsp;*���ο�������, ��������, ������ø��������� �ҵ� ������ ����޴� <BR> &nbsp;&nbsp;��쿡�� ����ֽ������࿡ ���� �ҵ� ���� ���� �ȵ�.  
		  <BR></FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� ���� 2���� ���Ծ�</TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� ���� 3���� ���Ծ�</TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>

		<TR>
          <TD align=left bgColor=#ffffff colspan=3>&nbsp;����ֽ������� �ҵ���� �� </TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
			<TD class=tit_f10 bgColor=#ffffff>&nbsp;       
		    </TD>
		</TR>

		<TR>
		  <TD align=CENTER bgColor=#ffedd2 >��<BR>��</TD>
		  <TD align=center bgColor=#ffffff >&nbsp;���ݺ���</TD>
          <TD align=left bgColor=#ffffff colspan=3>&nbsp;�������� ��������</TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="ETCAMT05" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
			<TD class=tit_f10 bgColor=#ffffff>&nbsp;       
		    </TD>
		</TR>


        <TR>
          <TD align=CENTER bgColor=#ffedd2 rowSpan=2>��<BR>��<BR>��<BR>��</TD>
          <TD align=CENTER bgColor=#fff8ee >��ġ�ڱ�</TD>
          <TD align=left bgColor=#ffffff COLSPAN=2>&nbsp;��ġ�ڱ� ��α�</TD>
          <TD align=CENTER bgColor=#ffffff >�ٷ��� ���� ������<BR>�� ��αݾ�</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="DEDAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff><FONT 
            color=#3366ff>&nbsp;* ����(�Ŀ�ȸ �� ���Ű�������ȸ ����) ��ξ��� 10���������� 
            ���<BR>&nbsp;&nbsp;&nbsp;&nbsp;���Ͼ� ���� (�ڵ��Է�)</FONT> </TD>
		</TR>

        <TR>
          <TD align=CENTER bgColor=#fff8ee>�����ڱ�</TD>
          <TD align=left bgColor=#ffffff colSpan=2>&nbsp;�̺о�����������Ա� ��ȯ����</TD>
          <TD align=CENTER bgColor=#ffffff>�ٷ��� ���θ�����<BR>�� ���ڻ�ȯ��</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="DEDAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* �������� �ٷ��� ���� ���Ƿ� "1995.11.1~1997.12.31" �� ����� �̿��� <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;������ �������ñԸ� ������ �̺о� ������ ����ϱ� ���� �������ñ�� <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;�Ǵ� �����������κ��� 1995.11.1 ���� ������ ���Աݿ� ���� �� ���� <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;��ȯ�� ����
		  </TD>
		</TR>
	  </TABLE>
	  <BR>
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        
        <TR bgColor=#ffffff>
		  <TD width=600><FONT color=#3366ff>&nbsp;�� ���ǻ��� <BR></FONT>
		       <B>&nbsp;�������� ��ư : </B>��� �����͸� �Է��� �� �� �̻� �Է� �Ǵ� �������� ���� ��� �����Ѵ�.<BR>
		       <B><FONT color=#ff6633> ���������� �Ŀ��� �� �̻� ���� �� �� ���� ������ �����ؼ� �����Ͻñ� �ٶ��ϴ�.</FONT></B>     
		  </TD> 
          <TD vAlign=bottom align=right><img src="./imgs/btn_submit.gif" style="cursor:hand" align=absmiddle onClick="fnSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;<img src="../Sales/images/print.gif"	style="cursor:hand;position:relative;left:-7px"	align=absmiddle onClick="fnPrint()"></TD>

		</TR>

		</TR>
	  </TABLE>

	  <!--���ݺ����-->
	  <INPUT type=hidden value=1,486,800 name=pybsgm>
	  <INPUT type=hidden value=0 name=pybsto> 
	  
	  <!--�����-->
	  <INPUT type=hidden value=802,130 name=pybsbh> 
	  <INPUT type=hidden value=173,047 name=pybsgy> 
	  <INPUT type=hidden value=0 name=pybins> 
	  <INPUT type=hidden value=0 name=pybin2> 
	  <INPUT type=hidden value=0 name=pybito> 
	  
	  <!--�Ƿ��-->
	  <INPUT type=hidden value=0 name=pybmsd> 
	  <INPUT type=hidden value=0 name=pybmgd> 
	  <INPUT type=hidden value=0 name=pybmtc> 
	  <INPUT type=hidden value=0 name=pybmto> 
	  <INPUT type=hidden value=0 name=pybmtm> 
	  
	  <!--������-->
	  <INPUT type=hidden value=0 name=pybsed> 
	  <INPUT type=hidden value=0 name=pybebc> 
	  <INPUT type=hidden value=0 name=pybebt> 
	  <INPUT type=hidden value=0 name=pybecc> 
	  <INPUT type=hidden value=0 name=pybect> 
      <INPUT type=hidden value=0 name=pybedc> 
	  <INPUT type=hidden value=0 name=pybedt> 
	  <INPUT type=hidden value=0 name=pybetc> 
	  <INPUT type=hidden value=0 name=pybets> 
	  <INPUT type=hidden value=0 name=pybeto> 

      <!--ī���-->
	  <INPUT type=hidden value=0 name=pybcad> 
	  <INPUT type=hidden value=0 name=pybhnd> 
	  <INPUT type=hidden value=0 name=pybsgd> 
	  <!--<input type="hidden" name="pybmex" value="0">-->
	  <INPUT type=hidden value=0 name=pybcto> 

      <DIV id=tipbox style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BACKGROUND: infobackground; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 0px"></DIV>
	</TD>
  </TR>
</TABLE>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=EMPNO  	  	Ctrl=EMPNO  	   	Param=text</C>
		<C>Col=DEPTCD  	  	Ctrl=DEPTCD  	   	Param=text</C>
		<C>Col=PAYGRD  	  	Ctrl=PAYGRD  	   	Param=text</C>
		<C>Col=JOINDATE   	Ctrl=JOINDATE      	Param=text</C>
		<C>Col=EMPNMK  	  	Ctrl=EMPNMK  	   	Param=text</C>
		<C>Col=EMPJUNO    	Ctrl=EMPJUNO       	Param=text</C>
		<C>Col=TELNUM    	Ctrl=TELNUM       	Param=text</C>
		<C>Col=ADDRESS    	Ctrl=ADDRESS       	Param=text</C>
		<C>Col=TAX_PAY    	Ctrl=TAX_PAY       	Param=text</C>
		<C>Col=TAX_BNS    	Ctrl=TAX_BNS       	Param=text</C>
		<C>Col=TAX_SUM    	Ctrl=TAX_SUM       	Param=text</C>
		<C>Col=NTAX_SUM   	Ctrl=NTAX_SUM      	Param=text</C>
		<C>Col=DEDUCT1 	  	Ctrl=DEDUCT1 	   	Param=text</C>
		<C>Col=DEDUCT2 	  	Ctrl=DEDUCT2 	   	Param=text</C>
		<C>Col=DEDUCT3 	  	Ctrl=DEDUCT3 	   	Param=text</C>
		<C>Col=DEDUCT4 	  	Ctrl=DEDUCT4 	   	Param=text</C>
		<C>Col=DEDUCT5    	Ctrl=DEDUCT5       	Param=text</C>

		<C>Col=HOUAMT01   	Ctrl=HOUAMT01      Param=text</C>	
		<C>Col=HOUAMT02   	Ctrl=HOUAMT02      Param=text</C>
		<C>Col=HOUAMT03   	Ctrl=HOUAMT03      Param=text</C>
		<C>Col=HOUAMT04   	Ctrl=HOUAMT04      Param=text</C>
		<C>Col=HOUAMT05  	Ctrl=HOUAMT05      Param=text</C>
		<C>Col=HOUSUM 	  	Ctrl=HOUSUM 	   Param=text</C>
		<C>Col=ETCAMT011A  	Ctrl=ETCAMT011A     Param=text</C>
		<C>Col=ETCAMT01A   	Ctrl=ETCAMT01A      Param=text</C>
		<C>Col=CONSUM   	Ctrl=CONSUM        Param=text</C>
		<C>Col=DEDAMT03   	Ctrl=DEDAMT03      Param=text</C>
		<C>Col=DEDAMT04   	Ctrl=DEDAMT04      Param=text</C>	
		<C>Col=MARCNT01   	Ctrl=MARCNT01      Param=bindcolval</C>	
		<C>Col=MARCNT02   	Ctrl=MARCNT02      Param=bindcolval</C>	
		<C>Col=MARCNT03   	Ctrl=MARCNT03      Param=bindcolval</C>	

		<C>Col=FNDAMT01   	Ctrl=FNDAMT01      Param=text</C>	
		<C>Col=FNDAMT02   	Ctrl=FNDAMT02      Param=text</C>	
		<C>Col=FNDAMT03   	Ctrl=FNDAMT03      Param=text</C>	
		<C>Col=FNDSUM   	Ctrl=FNDSUM        Param=text</C>	
		<C>Col=ETCAMT05   	Ctrl=ETCAMT05        Param=text</C>	


	'>
</object>

<object id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds2>
	<param name=BindInfo  value='
		<C>Col=BF_WKNM     	  	Ctrl=BF_WKNM     	   	Param=text</C>
		<C>Col=BF_RESINO	  	Ctrl=BF_RESINO	       	Param=text</C>
		<C>Col=BF_TAX_PAY	  	Ctrl=BF_TAX_PAY	       	Param=text</C>
		<C>Col=BF_TAX_BNS	  	Ctrl=BF_TAX_BNS	       	Param=text</C>
		<C>Col=BF_TAX_SUM 	  	Ctrl=BF_TAX_SUM 	   	Param=text</C>
		<C>Col=BF_NTAX_SUM 	  	Ctrl=BF_NTAX_SUM 	   	Param=text</C>
		<C>Col=BF_DEDUCT1     	Ctrl=BF_DEDUCT1        	Param=text</C>
		<C>Col=BF_DEDUCT2	  	Ctrl=BF_DEDUCT2	       	Param=text</C>
		<C>Col=BF_DEDUCT3	  	Ctrl=BF_DEDUCT3	       	Param=text</C>
		<C>Col=BF_DEDUCT4	  	Ctrl=BF_DEDUCT4	       	Param=text</C>
		<C>Col=BF_DEDUCT5	  	Ctrl=BF_DEDUCT5	       	Param=text</C>
	'>
</object>

<object id=gcbn_data4 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds4>
	<param name=BindInfo  value='
		<C>Col=GIVAMT_10A  	Ctrl=GIVAMT_10A 	   	Param=text</C>
		<C>Col=GIVAMT_10B  	Ctrl=GIVAMT_10B       	Param=text</C>
		<C>Col=GIVAMT_30A  	Ctrl=GIVAMT_30A       	Param=text</C>
		<C>Col=GIVAMT_30B  	Ctrl=GIVAMT_30B       	Param=text</C>
		<C>Col=GIVAMT_42A  	Ctrl=GIVAMT_42A       	Param=text</C>
		<C>Col=GIVAMT_42B  	Ctrl=GIVAMT_42B       	Param=text</C>
		<C>Col=GIVAMT_40A  	Ctrl=GIVAMT_40A	  		Param=text</C>
		<C>Col=GIVAMT_40B  	Ctrl=GIVAMT_40B 	   	Param=text</C>		
	'>
</object>

<object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="ds_print">  
	<PARAM NAME="DetailDataID"			VALUE="ds_print">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="False">
    <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<param name="MargineX"              value="30">
	<param name="MargineY"              value="30">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='ds_print'

<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2787 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='(�ǰ������' ,left=911 ,top=778 ,right=1072 ,bottom=823 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(1��)' ,left=1738 ,top=124 ,right=1893 ,bottom=185 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[���� ��37ȣ ����]  (2009.04.14.����)' ,left=29 ,top=124 ,right=874 ,bottom=185 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=190 ,right=1898 ,bottom=190 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=190 ,right=29 ,bottom=2732 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1898 ,top=190 ,right=1898 ,bottom=2732 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210��x297��' ,left=1303 ,top=2737 ,right=1893 ,bottom=2779 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   1. ���ɱ���' ,left=108 ,top=2457 ,right=1877 ,bottom=2497 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   3. �����ܱ��� : ������ =1, �ܱ���=9 �� �����Ͽ� �����ϴ�.' ,left=108 ,top=2642 ,right=1877 ,bottom=2684 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   2. �����ڵ� : �ҵ��� ����=0, �ҵ����� ��������=1, ����� ��������=2, �����=3, ������ �ڳ�=4, ������ �ڳ� ��=5, �����ڸ�=6, ' ,left=108 ,top=2568 ,right=1877 ,bottom=2610 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      ��Ÿ=7�� �����ϴ�.(4��5��6��7�� ��� �ҵ��ڿ� ������� ������ ���踦 �����մϴ�).  ' ,left=108 ,top=2605 ,right=1877 ,bottom=2647 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      ��. 6�� ������ 2003.01.01. ���� ���(�ڳ��������� 100����)' ,left=108 ,top=2531 ,right=1877 ,bottom=2573 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      ��. �� �� �� 1939.12.31. ���� ���(70�� �̻�: 100���� ����)' ,left=108 ,top=2494 ,right=1877 ,bottom=2534 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������' ,left=108 ,top=2418 ,right=292 ,bottom=2457 ,align='left' ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   4. ���ڳ���� �ٷ��� ������ �⺻��������ڿ� �ش��ϴ� �ڳడ 2�� �̻��� ��쿡 �ش� �ڳ���� �����ϴ�.' ,left=108 ,top=2679 ,right=1877 ,bottom=2721 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ�����Ű�/�ٷμҵ��ڰ����Ű� (' ,left=82 ,top=214 ,right=1050 ,bottom=287 ,align='left' ,face='����' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ��� ����' ,left=50 ,top=446 ,right=371 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹε�Ϲ�ȣ' ,left=911 ,top=446 ,right=1230 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=440, top=446, right=893, bottom=477, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO', left=1237, top=446, right=1882, bottom=477 ,mask='XXXXXX-XXXXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������' ,left=440 ,top=541 ,right=561 ,bottom=572 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=566 ,top=541 ,right=595 ,bottom=572 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='' ,left=606 ,top=541 ,right=635 ,bottom=572</T>
	<T>id='�������' ,left=650 ,top=541 ,right=771 ,bottom=572 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=779 ,top=541 ,right=808 ,bottom=572 ,border=true</X>
	<T>id='�ٹ��Ⱓ' ,left=911 ,top=538 ,right=1230 ,bottom=572 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������ڵ�' ,left=911 ,top=585 ,right=1230 ,bottom=620 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='~' ,left=1559 ,top=538 ,right=1617 ,bottom=572 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڵ�Ϲ�ȣ' ,left=908 ,top=493 ,right=1227 ,bottom=527 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ�ó ��Ī' ,left=50 ,top=493 ,right=371 ,bottom=527 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ֱ���' ,left=50 ,top=541 ,right=371 ,bottom=572 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=50 ,top=591 ,right=371 ,bottom=622 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COMPANY', left=440, top=493, right=893, bottom=527, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COMRESINO', left=1237, top=493, right=1882, bottom=527 ,mask='XXX-XX-XXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1232 ,top=435 ,right=1232 ,bottom=622 </L>
	<C>id='YYYY', left=1050, top=224, right=1856, bottom=298, align='left' ,mask='XXXX�� �ҵ濡 ���� ���������  )', face='����', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='  �ٷμҵ� ���װ���� �ϰ� �ٷ��ڿ��� ��� ��õ¡���������� �����ϸ�, ȯ�޹߻��� ��õ¡���ǹ��ڰ� �ٷ��ڿ��� ȯ���մϴ�.' ,left=39 ,top=367 ,right=1888 ,bottom=422 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='* �ٷ��ڴ� �ش� ������ �ۼ��Ͽ� ��õ¡���ǹ���(�Ҽ� ȸ�� ��)���� �����ϸ�, ��õ¡���ǹ��ڴ� �ش� ���� �� ÷�μ����� Ȯ���Ͽ�' ,left=39 ,top=327 ,right=1888 ,bottom=377 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=398 ,top=791 ,right=484 ,bottom=791 </L>
	<L> left=103 ,top=709 ,right=819 ,bottom=709 </L>
	<T>id='�ſ�ī�� ��' ,left=1474 ,top=712 ,right=1664 ,bottom=780 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=1474 ,top=762 ,right=1664 ,bottom=804 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1401 ,top=809 ,right=1730 ,bottom=809 </L>
	<L> left=100 ,top=899 ,right=1893 ,bottom=899 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(REF26_S,0,,REF26_S)}', left=1730, top=973, right=1890, bottom=1028, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_S,0,,REF16_S)}', left=1730, top=907, right=1890, bottom=962, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_S,0,,REF15_S)}', left=1567, top=907, right=1727, bottom=962, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_S,0,,REF14_S)}', left=1403, top=907, right=1564, bottom=962, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_S,0,,REF24_S)}', left=1403, top=973, right=1564, bottom=1028, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_S,0,,REF23_S)}', left=1237, top=973, right=1401, bottom=1028, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_S,0,,REF13_S)}', left=1237, top=907, right=1401, bottom=962, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_S,0,,REF12_S)}', left=1074, top=907, right=1235, bottom=962, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_S,0,,REF22_S)}', left=1074, top=973, right=1235, bottom=1028, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_S,0,,REF11_S)}', left=908, top=907, right=1069, bottom=962, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=907 ,right=903 ,bottom=962 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=819 ,top=973 ,right=900 ,bottom=1028 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��)' ,left=321 ,top=978 ,right=374 ,bottom=1023 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CNT', left=242, top=978, right=321, bottom=1023, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(���ڳ�' ,left=118 ,top=978 ,right=240 ,bottom=1023 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� �׸�' ,left=103 ,top=910 ,right=395 ,bottom=954 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ϴ� �ο����� ����' ,left=103 ,top=947 ,right=392 ,bottom=983 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=100 ,top=1034 ,right=1893 ,bottom=1034 </L>
	<L> left=100 ,top=1039 ,right=1893 ,bottom=1039 </L>
	<C>id='EMPNMK', left=179, top=1047, right=390, bottom=1102, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_1', left=405, top=1047, right=479, bottom=1102, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_1', left=405, top=1113, right=479, bottom=1168, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=1047 ,right=903 ,bottom=1102 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=821 ,top=1113 ,right=903 ,bottom=1168 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=1107 ,right=1898 ,bottom=1107 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=1242 ,right=1898 ,bottom=1242 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=105 ,top=1173 ,right=1896 ,bottom=1173 </L>
	<L> left=400 ,top=968 ,right=484 ,bottom=968 </L>
	<L> left=908 ,top=965 ,right=1901 ,bottom=968 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=29 ,top=2732 ,right=1898 ,bottom=2732 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=100 ,top=628 ,right=100 ,bottom=2732 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='RELAT1_1', left=105, top=1049, right=171, bottom=1105, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_1', left=105, top=1115, right=171, bottom=1171, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_2', left=105, top=1250, right=171, bottom=1305, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_8', left=105, top=2046, right=171, bottom=2101, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO', left=179, top=1113, right=390, bottom=1168 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_2', left=179, top=1247, right=390, bottom=1303 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_2', left=105, top=1179, right=171, bottom=1234, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_3', left=103, top=1313, right=168, bottom=1368, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_4', left=105, top=1442, right=171, bottom=1498, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_5', left=105, top=1577, right=171, bottom=1632, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_6', left=103, top=1714, right=168, bottom=1769, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_6', left=105, top=1785, right=171, bottom=1840, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_7', left=105, top=1851, right=171, bottom=1906, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_8', left=105, top=1983, right=171, bottom=2038, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_9', left=105, top=2112, right=171, bottom=2167, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_10', left=105, top=2252, right=171, bottom=2307, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=103 ,top=2381 ,right=1893 ,bottom=2381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EMPNMK_2', left=179, top=1179, right=390, bottom=1234, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_1', left=487, top=1047, right=561, bottom=1168, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_2', left=569, top=1047, right=650, bottom=1168, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_S,0,,REF21_S)}', left=908, top=973, right=1069, bottom=1028, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_1,0,,REF26_1)}', left=1732, top=1113, right=1893, bottom=1168, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_1,0,,REF16_1)}', left=1732, top=1047, right=1893, bottom=1102, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_1,0,,REF15_1)}', left=1569, top=1047, right=1730, bottom=1102, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_1,0,,REF24_1)}', left=1406, top=1113, right=1567, bottom=1168, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_1,0,,REF14_1)}', left=1406, top=1047, right=1567, bottom=1102, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_1,0,,REF23_1)}', left=1240, top=1113, right=1403, bottom=1168, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_1,0,,REF13_1)}', left=1240, top=1047, right=1403, bottom=1102, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_1,0,,REF22_1)}', left=1077, top=1113, right=1237, bottom=1168, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_1,0,,REF12_1)}', left=1077, top=1047, right=1237, bottom=1102, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_1,0,,REF21_1)}', left=911, top=1113, right=1072, bottom=1168, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_1,0,,REF11_1)}', left=911, top=1047, right=1072, bottom=1102, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_2', left=742, top=1044, right=816, bottom=1165, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_2', left=405, top=1179, right=479, bottom=1234, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=1179 ,right=903 ,bottom=1234 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_2,0,,REF11_2)}', left=911, top=1179, right=1072, bottom=1234, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_2,0,,REF12_2)}', left=1077, top=1179, right=1237, bottom=1234, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_2,0,,REF13_2)}', left=1240, top=1179, right=1403, bottom=1234, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_2,0,,REF14_2)}', left=1406, top=1179, right=1567, bottom=1234, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_2,0,,REF15_2)}', left=1569, top=1179, right=1730, bottom=1234, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_2,0,,REF16_2)}', left=1732, top=1179, right=1893, bottom=1234, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=1247 ,right=903 ,bottom=1303 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_2,0,,REF21_2)}', left=911, top=1247, right=1072, bottom=1303, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_2,0,,REF22_2)}', left=1077, top=1247, right=1237, bottom=1303, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_2,0,,REF23_2)}', left=1240, top=1247, right=1403, bottom=1303, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_2,0,,REF24_2)}', left=1406, top=1247, right=1567, bottom=1303, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_2,0,,REF26_2)}', left=1732, top=1247, right=1893, bottom=1303, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_3', left=179, top=1313, right=390, bottom=1368, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=1313 ,right=903 ,bottom=1368 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_3,0,,REF11_3)}', left=911, top=1313, right=1072, bottom=1368, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_3,0,,REF12_3)}', left=1077, top=1313, right=1237, bottom=1368, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_3,0,,REF13_3)}', left=1240, top=1313, right=1403, bottom=1368, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_3,0,,REF14_3)}', left=1406, top=1313, right=1567, bottom=1368, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_3,0,,REF15_3)}', left=1569, top=1313, right=1730, bottom=1368, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_3,0,,REF16_3)}', left=1732, top=1313, right=1893, bottom=1368, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_3,0,,REF24_3)}', left=1406, top=1376, right=1567, bottom=1432, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_3,0,,REF23_3)}', left=1240, top=1376, right=1403, bottom=1432, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_3,0,,REF22_3)}', left=1077, top=1376, right=1237, bottom=1432, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_3,0,,REF21_3)}', left=911, top=1376, right=1072, bottom=1432, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=1376 ,right=903 ,bottom=1432 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPJUNO_3', left=179, top=1376, right=390, bottom=1432 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_3,0,,REF26_3)}', left=1732, top=1376, right=1893, bottom=1432, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_3', left=105, top=1376, right=171, bottom=1432, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_3', left=405, top=1313, right=479, bottom=1368, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_4', left=179, top=1442, right=390, bottom=1498, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_4', left=405, top=1442, right=479, bottom=1498, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=1442 ,right=903 ,bottom=1498 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_4,0,,REF11_4)}', left=911, top=1442, right=1072, bottom=1498, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_4,0,,REF12_4)}', left=1077, top=1442, right=1237, bottom=1498, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_4,0,,REF13_4)}', left=1240, top=1442, right=1403, bottom=1498, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_4,0,,REF14_4)}', left=1406, top=1442, right=1567, bottom=1498, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_4,0,,REF15_4)}', left=1569, top=1442, right=1730, bottom=1498, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_4,0,,REF16_4)}', left=1732, top=1442, right=1893, bottom=1498, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_4', left=179, top=1511, right=390, bottom=1566 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_4', left=105, top=1511, right=171, bottom=1566, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=1511 ,right=903 ,bottom=1566 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_4,0,,REF21_4)}', left=911, top=1511, right=1072, bottom=1566, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_4,0,,REF22_4)}', left=1077, top=1511, right=1237, bottom=1566, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_4,0,,REF23_4)}', left=1240, top=1511, right=1403, bottom=1566, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_4,0,,REF24_4)}', left=1406, top=1511, right=1567, bottom=1566, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_4,0,,REF26_4)}', left=1732, top=1511, right=1893, bottom=1566, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_5', left=179, top=1577, right=390, bottom=1632, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_5', left=405, top=1577, right=479, bottom=1632, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=1577 ,right=903 ,bottom=1632 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_5,0,,REF11_5)}', left=911, top=1577, right=1072, bottom=1632, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_5,0,,REF12_5)}', left=1077, top=1577, right=1237, bottom=1632, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_5,0,,REF13_5)}', left=1240, top=1577, right=1403, bottom=1632, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_5,0,,REF14_5)}', left=1406, top=1577, right=1567, bottom=1632, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_5,0,,REF15_5)}', left=1569, top=1577, right=1730, bottom=1632, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_5,0,,REF16_5)}', left=1732, top=1577, right=1893, bottom=1632, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_5', left=105, top=1645, right=171, bottom=1701, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_5,0,,REF26_5)}', left=1732, top=1645, right=1893, bottom=1701, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=1645 ,right=903 ,bottom=1701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_5,0,,REF21_5)}', left=911, top=1645, right=1072, bottom=1701, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_5,0,,REF22_5)}', left=1077, top=1645, right=1237, bottom=1701, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_5,0,,REF23_5)}', left=1240, top=1645, right=1403, bottom=1701, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_5,0,,REF24_5)}', left=1406, top=1645, right=1567, bottom=1701, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_5', left=179, top=1645, right=390, bottom=1701 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_6', left=179, top=1714, right=390, bottom=1769, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_6', left=405, top=1714, right=479, bottom=1769, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=1714 ,right=903 ,bottom=1769 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_6,0,,REF11_6)}', left=911, top=1714, right=1072, bottom=1769, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_6,0,,REF12_6)}', left=1079, top=1714, right=1240, bottom=1769, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_6,0,,REF13_6)}', left=1243, top=1714, right=1406, bottom=1769, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_6,0,,REF14_6)}', left=1409, top=1714, right=1569, bottom=1769, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_6,0,,REF15_6)}', left=1572, top=1714, right=1732, bottom=1769, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_6,0,,REF16_6)}', left=1735, top=1714, right=1896, bottom=1769, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_6', left=179, top=1785, right=390, bottom=1840 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=1785 ,right=903 ,bottom=1840 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_6,0,,REF21_6)}', left=911, top=1785, right=1072, bottom=1840, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_6,0,,REF22_6)}', left=1079, top=1785, right=1240, bottom=1840, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_6,0,,REF23_6)}', left=1243, top=1785, right=1406, bottom=1840, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_6,0,,REF24_6)}', left=1409, top=1785, right=1569, bottom=1840, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_6,0,,REF26_6)}', left=1735, top=1785, right=1896, bottom=1840, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_7', left=179, top=1851, right=390, bottom=1906, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_7', left=405, top=1851, right=479, bottom=1906, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=1851 ,right=903 ,bottom=1906 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_7,0,,REF11_7)}', left=911, top=1851, right=1072, bottom=1906, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_7,0,,REF12_7)}', left=1072, top=1851, right=1232, bottom=1906, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_7,0,,REF13_7)}', left=1235, top=1851, right=1398, bottom=1906, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_7,0,,REF14_7)}', left=1401, top=1851, right=1561, bottom=1906, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_7,0,,REF15_7)}', left=1564, top=1851, right=1724, bottom=1906, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_7,0,,REF16_7)}', left=1727, top=1851, right=1888, bottom=1906, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_7', left=105, top=1917, right=171, bottom=1972, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_7', left=179, top=1917, right=390, bottom=1972 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=1917 ,right=903 ,bottom=1972 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_7,0,,REF21_7)}', left=911, top=1917, right=1072, bottom=1972, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_7,0,,REF22_7)}', left=1072, top=1917, right=1232, bottom=1972, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_7,0,,REF23_7)}', left=1235, top=1917, right=1398, bottom=1972, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_7,0,,REF24_7)}', left=1401, top=1917, right=1561, bottom=1972, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_7,0,,REF26_7)}', left=1727, top=1917, right=1888, bottom=1972, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_8', left=179, top=1983, right=390, bottom=2038, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_8', left=405, top=1983, right=479, bottom=2038, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=1983 ,right=903 ,bottom=2038 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_8,0,,REF11_8)}', left=911, top=1983, right=1072, bottom=2038, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_8,0,,REF12_8)}', left=1077, top=1983, right=1237, bottom=2038, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_8,0,,REF13_8)}', left=1240, top=1983, right=1403, bottom=2038, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_8,0,,REF14_8)}', left=1406, top=1983, right=1567, bottom=2038, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_8,0,,REF15_8)}', left=1569, top=1983, right=1730, bottom=2038, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_8,0,,REF16_8)}', left=1732, top=1983, right=1893, bottom=2038, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_8', left=179, top=2046, right=390, bottom=2101 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=2046 ,right=903 ,bottom=2101 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_8,0,,REF21_8)}', left=911, top=2046, right=1072, bottom=2101, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_8,0,,REF22_8)}', left=1077, top=2046, right=1237, bottom=2101, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_8,0,,REF23_8)}', left=1240, top=2046, right=1403, bottom=2101, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_8,0,,REF24_8)}', left=1406, top=2046, right=1567, bottom=2101, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_8,0,,REF26_8)}', left=1732, top=2046, right=1893, bottom=2101, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_9', left=179, top=2112, right=390, bottom=2167, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_9', left=405, top=2112, right=479, bottom=2167, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=2112 ,right=903 ,bottom=2167 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_9,0,,REF11_9)}', left=911, top=2112, right=1072, bottom=2167, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_9,0,,REF12_9)}', left=1079, top=2112, right=1240, bottom=2167, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_9,0,,REF13_9)}', left=1243, top=2112, right=1406, bottom=2167, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_9,0,,REF14_9)}', left=1409, top=2112, right=1569, bottom=2167, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_9,0,,REF15_9)}', left=1569, top=2112, right=1730, bottom=2167, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_9,0,,REF16_9)}', left=1732, top=2112, right=1893, bottom=2167, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_9', left=179, top=2181, right=390, bottom=2236 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_9', left=105, top=2181, right=171, bottom=2236, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=2181 ,right=903 ,bottom=2236 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_9,0,,REF21_9)}', left=911, top=2181, right=1072, bottom=2236, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_9,0,,REF22_9)}', left=1079, top=2181, right=1240, bottom=2236, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_9,0,,REF23_9)}', left=1243, top=2181, right=1406, bottom=2236, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_9,0,,REF24_9)}', left=1409, top=2181, right=1569, bottom=2236, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_9,0,,REF26_9)}', left=1732, top=2181, right=1893, bottom=2236, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_10', left=184, top=2252, right=395, bottom=2307, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_10', left=405, top=2252, right=479, bottom=2307, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=821 ,top=2252 ,right=903 ,bottom=2307 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_10,0,,REF11_10)}', left=911, top=2252, right=1072, bottom=2307, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_10,0,,REF12_10)}', left=1077, top=2252, right=1237, bottom=2307, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_10,0,,REF13_10)}', left=1240, top=2252, right=1403, bottom=2307, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_10,0,,REF14_10)}', left=1406, top=2252, right=1567, bottom=2307, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_10,0,,REF15_10)}', left=1569, top=2252, right=1730, bottom=2307, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_10,0,,REF16_10)}', left=1732, top=2252, right=1893, bottom=2307, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_10', left=105, top=2320, right=171, bottom=2376, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_10', left=184, top=2320, right=395, bottom=2376 ,mask='XXXXXX-XXXXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=821 ,top=2320 ,right=903 ,bottom=2376 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_10,0,,REF21_10)}', left=911, top=2320, right=1072, bottom=2376, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_10,0,,REF22_10)}', left=1077, top=2320, right=1237, bottom=2376, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_10,0,,REF23_10)}', left=1240, top=2320, right=1403, bottom=2376, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_10,0,,REF24_10)}', left=1406, top=2320, right=1567, bottom=2376, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_10,0,,REF26_10)}', left=1732, top=2320, right=1893, bottom=2376, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_2', left=569, top=1179, right=650, bottom=1300, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_3', left=569, top=1310, right=650, bottom=1432, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_4', left=569, top=1445, right=650, bottom=1566, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_5', left=569, top=1579, right=650, bottom=1701, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_6', left=569, top=1719, right=650, bottom=1840, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_7', left=569, top=1851, right=650, bottom=1972, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_8', left=569, top=1980, right=650, bottom=2101, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_9', left=569, top=2115, right=650, bottom=2236, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_10', left=569, top=2254, right=650, bottom=2376, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_2', left=742, top=1179, right=816, bottom=1300, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_3', left=742, top=1310, right=816, bottom=1432, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_4', left=742, top=1445, right=816, bottom=1566, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_5', left=742, top=1579, right=816, bottom=1701, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_6', left=742, top=1719, right=816, bottom=1840, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_7', left=742, top=1851, right=816, bottom=1972, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_8', left=742, top=1980, right=816, bottom=2101, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_9', left=742, top=2115, right=816, bottom=2236, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_10', left=742, top=2254, right=816, bottom=2376, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_2', left=487, top=1179, right=561, bottom=1300, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_3', left=487, top=1310, right=561, bottom=1432, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_4', left=487, top=1445, right=561, bottom=1566, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_5', left=487, top=1579, right=561, bottom=1701, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_6', left=487, top=1719, right=561, bottom=1840, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_7', left=487, top=1851, right=561, bottom=1972, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_8', left=487, top=1980, right=561, bottom=2101, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_9', left=487, top=2115, right=561, bottom=2236, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_10', left=487, top=2254, right=561, bottom=2376, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=398 ,top=438 ,right=398 ,bottom=2384 </L>
	<L> left=906 ,top=438 ,right=906 ,bottom=2384 </L>
	<L> left=563 ,top=709 ,right=563 ,bottom=2384 </L>
	<L> left=484 ,top=709 ,right=484 ,bottom=2384 </L>
	<L> left=656 ,top=709 ,right=656 ,bottom=2384 </L>
	<L> left=1074 ,top=709 ,right=1074 ,bottom=2384 </L>
	<L> left=1403 ,top=709 ,right=1403 ,bottom=2384 </L>
	<L> left=1237 ,top=709 ,right=1237 ,bottom=2384 </L>
	<L> left=903 ,top=2312 ,right=1896 ,bottom=2312 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=903 ,top=2173 ,right=1896 ,bottom=2173 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=2041 ,right=1898 ,bottom=2041 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=1912 ,right=1898 ,bottom=1912 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=1777 ,right=1898 ,bottom=1777 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=903 ,top=1637 ,right=1896 ,bottom=1637 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=903 ,top=1500 ,right=1896 ,bottom=1500 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=1368 ,right=1898 ,bottom=1368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=174 ,top=1039 ,right=174 ,bottom=2381 </L>
	<L> left=174 ,top=628 ,right=174 ,bottom=896 </L>
	<L> left=29 ,top=438 ,right=1898 ,bottom=438 </L>
	<L> left=29 ,top=483 ,right=1898 ,bottom=483 </L>
	<L> left=29 ,top=533 ,right=1898 ,bottom=533 </L>
	<L> left=29 ,top=577 ,right=1898 ,bottom=577 </L>
	<L> left=29 ,top=628 ,right=1898 ,bottom=628 </L>
	<T>id='����' ,left=108 ,top=633 ,right=171 ,bottom=675 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�' ,left=108 ,top=672 ,right=171 ,bottom=707 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=182 ,top=651 ,right=392 ,bottom=693 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ҵ���� �׸�' ,left=921 ,top=651 ,right=1885 ,bottom=693 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� �׸�' ,left=437 ,top=651 ,right=803 ,bottom=693 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=103 ,top=791 ,right=174 ,bottom=836 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=103 ,top=746 ,right=174 ,bottom=794 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=184 ,top=788 ,right=395 ,bottom=836 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹε��' ,left=184 ,top=749 ,right=395 ,bottom=796 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻' ,left=405 ,top=715 ,right=479 ,bottom=754 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=405 ,top=751 ,right=479 ,bottom=791 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�γ�' ,left=405 ,top=799 ,right=479 ,bottom=838 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=405 ,top=828 ,right=479 ,bottom=867 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=405 ,top=857 ,right=479 ,bottom=896 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=487 ,top=741 ,right=561 ,bottom=780 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=487 ,top=780 ,right=561 ,bottom=820 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=487 ,top=817 ,right=561 ,bottom=857 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=569 ,top=823 ,right=650 ,bottom=862 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ծ�' ,left=569 ,top=788 ,right=650 ,bottom=828 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=569 ,top=770 ,right=650 ,bottom=788 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=569 ,top=736 ,right=650 ,bottom=775 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=569 ,top=862 ,right=650 ,bottom=896 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=661 ,top=783 ,right=735 ,bottom=823 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=661 ,top=749 ,right=735 ,bottom=788 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=737 ,top=770 ,right=819 ,bottom=809 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڳ�' ,left=742 ,top=736 ,right=811 ,bottom=775 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=661 ,top=820 ,right=735 ,bottom=860 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=821 ,top=770 ,right=903 ,bottom=809 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڷ�' ,left=827 ,top=733 ,right=900 ,bottom=773 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=911 ,top=738 ,right=1072 ,bottom=783 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ��' ,left=1077 ,top=783 ,right=1230 ,bottom=831 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1240 ,top=783 ,right=1401 ,bottom=831 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī��' ,left=1406 ,top=815 ,right=1567 ,bottom=854 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1406 ,top=852 ,right=1567 ,bottom=891 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1569 ,top=852 ,right=1730 ,bottom=891 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1569 ,top=815 ,right=1730 ,bottom=854 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1738 ,top=783 ,right=1893 ,bottom=831 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=732 ,top=709 ,right=732 ,bottom=2384 </L>
	<L> left=821 ,top=630 ,right=821 ,bottom=2381 </L>
	<C>id='REF3_1', left=661, top=1047, right=727, bottom=1168, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_2', left=661, top=1179, right=727, bottom=1300, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_3', left=661, top=1310, right=727, bottom=1432, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_4', left=661, top=1445, right=727, bottom=1566, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_5', left=661, top=1579, right=727, bottom=1701, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_6', left=661, top=1719, right=727, bottom=1840, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_7', left=661, top=1851, right=727, bottom=1972, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_8', left=661, top=1980, right=727, bottom=2101, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_9', left=661, top=2115, right=727, bottom=2236, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_10', left=661, top=2254, right=727, bottom=2376, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=100 ,top=1173 ,right=1890 ,bottom=1173 </L>
	<L> left=100 ,top=1308 ,right=1890 ,bottom=1308 </L>
	<L> left=100 ,top=1706 ,right=1890 ,bottom=1706 </L>
	<L> left=100 ,top=1843 ,right=1890 ,bottom=1843 </L>
	<L> left=100 ,top=1978 ,right=1890 ,bottom=1978 </L>
	<L> left=100 ,top=2107 ,right=1890 ,bottom=2107 </L>
	<L> left=100 ,top=2244 ,right=1890 ,bottom=2244 </L>
	<L> left=906 ,top=709 ,right=1898 ,bottom=709 </L>
	<L> left=821 ,top=2312 ,right=903 ,bottom=2312 </L>
	<L> left=821 ,top=968 ,right=903 ,bottom=968 </L>
	<L> left=821 ,top=1107 ,right=903 ,bottom=1107 </L>
	<L> left=821 ,top=1242 ,right=903 ,bottom=1242 </L>
	<L> left=821 ,top=1368 ,right=903 ,bottom=1368 </L>
	<L> left=821 ,top=1500 ,right=903 ,bottom=1500 </L>
	<L> left=821 ,top=1637 ,right=903 ,bottom=1637 </L>
	<L> left=821 ,top=1777 ,right=903 ,bottom=1777 </L>
	<L> left=821 ,top=1912 ,right=903 ,bottom=1912 </L>
	<L> left=821 ,top=2041 ,right=903 ,bottom=2041 </L>
	<L> left=821 ,top=2173 ,right=903 ,bottom=2173 </L>
	<L> left=400 ,top=1107 ,right=484 ,bottom=1107 </L>
	<L> left=400 ,top=1242 ,right=484 ,bottom=1242 </L>
	<L> left=400 ,top=1368 ,right=484 ,bottom=1368 </L>
	<L> left=400 ,top=1500 ,right=484 ,bottom=1500 </L>
	<L> left=400 ,top=1637 ,right=484 ,bottom=1637 </L>
	<L> left=400 ,top=1777 ,right=484 ,bottom=1777 </L>
	<L> left=400 ,top=1912 ,right=484 ,bottom=1912 </L>
	<L> left=400 ,top=2041 ,right=484 ,bottom=2041 </L>
	<L> left=400 ,top=2173 ,right=484 ,bottom=2173 </L>
	<L> left=400 ,top=2312 ,right=484 ,bottom=2312 </L>
	<L> left=103 ,top=2312 ,right=398 ,bottom=2312 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=100 ,top=1437 ,right=1890 ,bottom=1437 </L>
	<L> left=395 ,top=1107 ,right=100 ,bottom=1107 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=398 ,top=1242 ,right=103 ,bottom=1242 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=395 ,top=1368 ,right=100 ,bottom=1368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=392 ,top=1500 ,right=97 ,bottom=1500 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=2173 ,right=398 ,bottom=2173 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=2041 ,right=398 ,bottom=2041 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=1912 ,right=398 ,bottom=1912 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=1777 ,right=398 ,bottom=1777 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=1637 ,right=398 ,bottom=1637 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=100 ,top=1569 ,right=1890 ,bottom=1569 </L>
	<T>id='�� ����)' ,left=911 ,top=820 ,right=1072 ,bottom=865 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1730 ,top=709 ,right=1730 ,bottom=2384 </L>
	<T>id='��' ,left=34 ,top=1313 ,right=95 ,bottom=1353 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1361 ,right=95 ,bottom=1400 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1408 ,right=95 ,bottom=1448 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1455 ,right=95 ,bottom=1495 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1548 ,right=95 ,bottom=1585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1635 ,right=95 ,bottom=1677 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1685 ,right=95 ,bottom=1724 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1732 ,right=95 ,bottom=1772 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1780 ,right=95 ,bottom=1819 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1872 ,right=95 ,bottom=1912 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1920 ,right=95 ,bottom=1959 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1567 ,top=968 ,right=1730 ,bottom=1036 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT3', left=1366, top=538, right=1551, bottom=572 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=1622, top=538, right=1806, bottom=572 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1567 ,top=1107 ,right=1730 ,bottom=1173 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1242 ,right=1730 ,bottom=1308 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1368 ,right=1730 ,bottom=1437 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1500 ,right=1730 ,bottom=1569 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1637 ,right=1730 ,bottom=1706 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1777 ,right=1730 ,bottom=1843 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1912 ,right=1730 ,bottom=1978 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=2038 ,right=1730 ,bottom=2107 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=2173 ,right=1730 ,bottom=2244 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=2312 ,right=1730 ,bottom=2381 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1567 ,top=809 ,right=1567 ,bottom=2376 </L>
	<C>id='EMPNO', left=1514, top=124, right=1732, bottom=185, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=742 ,top=804 ,right=811 ,bottom=844 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>




</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'


<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2758 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=156 ,right=1898 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(2��)' ,left=1738 ,top=90 ,right=1893 ,bottom=150 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=29 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2642 ,right=1898 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1201 ,top=1830 ,right=1201 ,bottom=2571 </L>
	<C>id='{decode(C_AMT1,0,,C_AMT1)}', left=1206, top=2144, right=1398, bottom=2181, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���ݾ�' ,left=919 ,top=2144 ,right=1198 ,bottom=2181 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   �� �ſ�����Ҥ����� ����ī�� ��' ,left=316 ,top=2144 ,right=882 ,bottom=2181 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=2083 ,right=100 ,bottom=2123 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=2154 ,right=100 ,bottom=2194 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=2207 ,right=100 ,bottom=2246 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=2260 ,right=100 ,bottom=2299 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=2312 ,right=100 ,bottom=2352 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   �� ���ݿ�����' ,left=316 ,top=2188 ,right=882 ,bottom=2225 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=919 ,top=2188 ,right=1198 ,bottom=2225 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_AMT2,0,,C_AMT2)}', left=1206, top=2188, right=1398, bottom=2225, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='   �� �п��� ���γ���' ,left=316 ,top=2231 ,right=882 ,bottom=2268 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=919 ,top=2231 ,right=1198 ,bottom=2268 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_AMT3,0,,C_AMT3)}', left=1206, top=2231, right=1398, bottom=2268, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='   �� ������ú��' ,left=316 ,top=2273 ,right=882 ,bottom=2310 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_AMT4,0,,C_AMT4)}', left=1206, top=2273, right=1398, bottom=2310, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��(��+��+��-��)' ,left=316 ,top=2315 ,right=882 ,bottom=2352 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_SUM,0,,C_SUM)}', left=1206, top=2315, right=1398, bottom=2352, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT3,0,,FD_AMT3)}', left=1206, top=2489, right=1398, bottom=2526, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_SUM,0,,FD_SUM)}', left=1206, top=2531, right=1398, bottom=2568, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT2,0,,FD_AMT2)}', left=1206, top=2447, right=1398, bottom=2484, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT1,0,,FD_AMT1)}', left=1206, top=2405, right=1398, bottom=2442, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�⿬�ݾ�' ,left=919 ,top=2357 ,right=1198 ,bottom=2394 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(D_SUM,0,,D_SUM)}', left=1206, top=2357, right=1398, bottom=2394, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�츮���� �⿬�� �ҵ����' ,left=116 ,top=2357 ,right=882 ,bottom=2394 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�糳�� 1����' ,left=919 ,top=2405 ,right=1198 ,bottom=2442 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�賳�� 2����' ,left=919 ,top=2447 ,right=1198 ,bottom=2484 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�鳳�� 3����' ,left=919 ,top=2489 ,right=1198 ,bottom=2526 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����հ�' ,left=919 ,top=2531 ,right=1198 ,bottom=2568 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=121 ,top=701 ,right=292 ,bottom=744 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=214 ,right=1898 ,bottom=214 </L>
	<L> left=906 ,top=156 ,right=906 ,bottom=2642 </L>
	<L> left=29 ,top=567 ,right=1898 ,bottom=567 </L>
	<T>id='��' ,left=37 ,top=480 ,right=97 ,bottom=519 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=440 ,right=97 ,bottom=480 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=401 ,right=97 ,bottom=440 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=361 ,right=97 ,bottom=401 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=322 ,right=97 ,bottom=361 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=282 ,right=97 ,bottom=322 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=243 ,right=97 ,bottom=282 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݺ����' ,left=121 ,top=253 ,right=292 ,bottom=287 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=308 ,top=166 ,right=898 ,bottom=206 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1201 ,top=156 ,right=1201 ,bottom=2642 </L>
	<L> left=1690 ,top=156 ,right=1690 ,bottom=2642 </L>
	<T>id='���ο��ݺ����' ,left=329 ,top=221 ,right=566 ,bottom=306 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο��ݺ����' ,left=329 ,top=322 ,right=566 ,bottom=364 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=329 ,top=425 ,right=566 ,bottom=504 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���ο���,' ,left=121 ,top=319 ,right=292 ,bottom=353 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����������,' ,left=121 ,top=353 ,right=292 ,bottom=388 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο���,' ,left=121 ,top=388 ,right=292 ,bottom=422 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����������,' ,left=121 ,top=427 ,right=292 ,bottom=461 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� ��)' ,left=121 ,top=464 ,right=292 ,bottom=498 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=219 ,right=898 ,bottom=258 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ⱸ��' ,left=911 ,top=166 ,right=1195 ,bottom=206 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=1206 ,top=166 ,right=1398 ,bottom=206 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ѵ���' ,left=1414 ,top=166 ,right=1688 ,bottom=206 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1696 ,top=166 ,right=1885 ,bottom=206 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=121 ,top=169 ,right=290 ,bottom=208 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=274 ,right=898 ,bottom=314 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=322 ,right=898 ,bottom=361 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=372 ,right=898 ,bottom=411 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=422 ,right=898 ,bottom=461 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=469 ,right=898 ,bottom=509 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=219 ,right=1193 ,bottom=258 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP31000,0,,BP31000)}', left=1206, top=219, right=1398, bottom=258, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1414 ,top=219 ,right=1688 ,bottom=258 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP31000,0,,BP31000)}', left=1696, top=219, right=1885, bottom=258, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=919 ,top=274 ,right=1193 ,bottom=314 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=274 ,right=1688 ,bottom=314 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=322 ,right=1193 ,bottom=361 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=322 ,right=1688 ,bottom=361 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=372 ,right=1193 ,bottom=411 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=372 ,right=1688 ,bottom=411 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=422 ,right=1193 ,bottom=461 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1414 ,top=422 ,right=1688 ,bottom=461 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1898 ,top=156 ,right=1898 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=592 ,top=214 ,right=592 ,bottom=512 </L>
	<C>id='{decode(PENSUM,0,,PENSUM)}', left=1206, top=274, right=1398, bottom=314, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP34000,0,,BP34000)}', left=1206, top=422, right=1398, bottom=461, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(F_SUM,0,,F_SUM)}', left=1206, top=469, right=1398, bottom=509, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUM,0,,PENSUM)}', left=1696, top=274, right=1885, bottom=314, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(F_SUMS,0,,F_SUMS)}', left=1696, top=467, right=1885, bottom=506, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=592 ,top=367 ,right=1896 ,bottom=367 </L>
	<L> left=592 ,top=266 ,right=1896 ,bottom=266 </L>
	<X>left=906 ,top=512 ,right=1201 ,bottom=567 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=300 ,top=316 ,right=1898 ,bottom=316 </L>
	<T>id='���ݺ���� ��' ,left=308 ,top=517 ,right=900 ,bottom=562 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ΰǰ�����' ,left=308 ,top=575 ,right=587 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��������纸�� ����)' ,left=308 ,top=614 ,right=587 ,bottom=654 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��뺸��' ,left=308 ,top=680 ,right=587 ,bottom=775 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ��' ,left=308 ,top=899 ,right=900 ,bottom=939 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������뺸�强����' ,left=308 ,top=846 ,right=900 ,bottom=886 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ϲݺ��强����' ,left=308 ,top=786 ,right=900 ,bottom=836 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=733 ,right=898 ,bottom=775 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=680 ,right=898 ,bottom=720 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=630 ,right=898 ,bottom=670 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=600 ,top=575 ,right=898 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=592 ,top=567 ,right=592 ,bottom=780 </L>
	<L> left=592 ,top=725 ,right=1896 ,bottom=725 </L>
	<L> left=592 ,top=620 ,right=1896 ,bottom=620 </L>
	<L> left=592 ,top=461 ,right=1896 ,bottom=461 </L>
	<T>id='�����' ,left=919 ,top=472 ,right=1193 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=575 ,right=1193 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=630 ,right=1193 ,bottom=670 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=680 ,right=1193 ,bottom=720 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=733 ,right=1193 ,bottom=775 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=786 ,right=1193 ,bottom=836 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=846 ,right=1193 ,bottom=886 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1414 ,top=469 ,right=1688 ,bottom=509 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=575 ,right=1688 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=630 ,right=1688 ,bottom=670 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=680 ,right=1688 ,bottom=720 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=733 ,right=1688 ,bottom=775 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100����' ,left=1414 ,top=786 ,right=1688 ,bottom=836 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100����' ,left=1414 ,top=846 ,right=1688 ,bottom=886 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PENTOT,0,,PENTOT)}', left=1206, top=517, right=1398, bottom=562, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP32000,0,,BP32000)}', left=1206, top=575, right=1398, bottom=614, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT01,0,,INSAMT01)}', left=1206, top=630, right=1398, bottom=670, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP33000,0,,BP33000)}', left=1206, top=680, right=1398, bottom=720, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT02,0,,INSAMT02)}', left=1206, top=733, right=1398, bottom=775, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT03,0,,INSAMT03)}', left=1206, top=786, right=1398, bottom=836, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT04,0,,INSAMT04)}', left=1206, top=846, right=1398, bottom=886, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=1206, top=899, right=1398, bottom=939, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENTOT,0,,PENTOT)}', left=1696, top=517, right=1885, bottom=562, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP32000,0,,BP32000)}', left=1696, top=575, right=1885, bottom=614, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT01,0,,INSAMT01)}', left=1696, top=630, right=1885, bottom=670, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP33000,0,,BP33000)}', left=1696, top=680, right=1885, bottom=720, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT02,0,,INSAMT02)}', left=1696, top=733, right=1885, bottom=775, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT03S,0,,INSAMT03S)}', left=1696, top=786, right=1885, bottom=836, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT04S,0,,INSAMT04S)}', left=1696, top=846, right=1885, bottom=886, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSSUMS,0,,INSSUMS)}', left=1696, top=899, right=1885, bottom=939, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=906 ,top=894 ,right=1201 ,bottom=947 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=300 ,top=894 ,right=1898 ,bottom=894 </L>
	<L> left=300 ,top=841 ,right=1898 ,bottom=841 </L>
	<L> left=300 ,top=780 ,right=1898 ,bottom=780 </L>
	<L> left=300 ,top=675 ,right=1898 ,bottom=675 </L>
	<L> left=300 ,top=512 ,right=1898 ,bottom=512 </L>
	<L> left=300 ,top=414 ,right=1898 ,bottom=414 </L>
	<T>id='���Τ�65�� �̻��ڤ������ �Ƿ��' ,left=316 ,top=954 ,right=882 ,bottom=991 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ���� ��������� �Ƿ��' ,left=316 ,top=997 ,right=882 ,bottom=1034 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �Ƶ� ( ' ,left=308 ,top=1126 ,right=479 ,bottom=1165 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ʤ��ߤ�����б� ( ' ,left=308 ,top=1173 ,right=563 ,bottom=1210 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���л�(���п� ������)  ( ' ,left=308 ,top=1218 ,right=624 ,bottom=1255 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ( ' ,left=308 ,top=1260 ,right=421 ,bottom=1297 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����������Ա�' ,left=316 ,top=1347 ,right=882 ,bottom=1384 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(H_AMT2,0,,H_AMT2)}', left=1206, top=1347, right=1398, bottom=1384, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��������������Ա�' ,left=316 ,top=1392 ,right=882 ,bottom=1429 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(H_AMT3,0,,H_AMT3)}', left=1206, top=1392, right=1398, bottom=1429, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����ڱ� ������ ��' ,left=316 ,top=1437 ,right=882 ,bottom=1474 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(M_AMT1,0,,M_AMT1)}', left=1206, top=954, right=1398, bottom=991, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1414 ,top=954 ,right=1688 ,bottom=991 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(M_AMT2,0,,M_AMT2)}', left=1206, top=997, right=1398, bottom=1034, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1414 ,top=997 ,right=1688 ,bottom=1034 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(M_SUM,0,,M_SUM)}', left=1206, top=1042, right=1398, bottom=1078, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT1S,0,,E_AMT1S)}', left=1206, top=1086, right=1398, bottom=1123, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_CNT2,0,,E_CNT2)}', left=482, top=1129, right=532, bottom=1165, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') ��' ,left=532 ,top=1126 ,right=711 ,bottom=1165 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_AMT2,0,,E_AMT2)}', left=1206, top=1126, right=1398, bottom=1165, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_CNT3,0,,E_CNT3)}', left=566, top=1173, right=616, bottom=1210, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') ��' ,left=613 ,top=1173 ,right=792 ,bottom=1210 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_AMT3,0,,E_AMT3)}', left=1206, top=1173, right=1398, bottom=1210, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_CNT4,0,,E_CNT4)}', left=627, top=1216, right=677, bottom=1255, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') ��' ,left=674 ,top=1218 ,right=853 ,bottom=1255 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_AMT4,0,,E_AMT4)}', left=1206, top=1218, right=1398, bottom=1255, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_CNT5,0,,E_CNT5)}', left=424, top=1260, right=474, bottom=1297, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') ��' ,left=471 ,top=1260 ,right=650 ,bottom=1297 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_AMT5,0,,E_AMT5)}', left=1206, top=1260, right=1398, bottom=1297, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�Ƿ�� ��' ,left=316 ,top=1042 ,right=882 ,bottom=1078 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ��' ,left=316 ,top=1303 ,right=882 ,bottom=1339 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=1785 ,right=1898 ,bottom=1785 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�Ƿ��' ,left=121 ,top=957 ,right=292 ,bottom=1071 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=121 ,top=1092 ,right=292 ,bottom=1329 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڱ�' ,left=121 ,top=1347 ,right=292 ,bottom=1471 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=121 ,top=1490 ,right=292 ,bottom=1777 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_SUM,0,,E_SUM)}', left=1206, top=1303, right=1398, bottom=1339, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=906 ,top=1432 ,right=1201 ,bottom=1482 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1201 ,top=1432 ,right=1403 ,bottom=1482 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�ҵ��� ����' ,left=308 ,top=1086 ,right=882 ,bottom=1123 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=1086 ,right=1688 ,bottom=1123 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1�δ� 300����' ,left=1414 ,top=1126 ,right=1688 ,bottom=1165 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1�δ� 300����' ,left=1414 ,top=1173 ,right=1688 ,bottom=1210 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1�δ� 900����' ,left=1414 ,top=1218 ,right=1688 ,bottom=1255 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1414 ,top=1260 ,right=1688 ,bottom=1297 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1414 ,top=1347 ,right=1688 ,bottom=1384 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1414 ,top=1392 ,right=1688 ,bottom=1429 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(M_SUMS,0,,M_SUMS)}', left=1696, top=1042, right=1885, bottom=1078, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT1S,0,,E_AMT1S)}', left=1696, top=1086, right=1885, bottom=1123, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT2S,0,,E_AMT2S)}', left=1696, top=1126, right=1888, bottom=1165, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT3S,0,,E_AMT3S)}', left=1696, top=1173, right=1885, bottom=1210, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT4S,0,,E_AMT4S)}', left=1696, top=1218, right=1885, bottom=1255, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT5S,0,,E_AMT5S)}', left=1696, top=1260, right=1885, bottom=1297, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_SUMS,0,,E_SUMS)}', left=1696, top=1303, right=1885, bottom=1339, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_AMT2S,0,,H_AMT2S)}', left=1696, top=1347, right=1885, bottom=1384, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_AMT3S,0,,H_AMT3S)}', left=1696, top=1392, right=1885, bottom=1429, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_SUMS,0,,H_SUMS)}', left=1696, top=1437, right=1885, bottom=1474, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=919 ,top=954 ,right=1198 ,bottom=991 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=919 ,top=997 ,right=1198 ,bottom=1034 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(���п�����)' ,left=919 ,top=1086 ,right=1198 ,bottom=1123 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ġ������п����' ,left=919 ,top=1126 ,right=1198 ,bottom=1165 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=919 ,top=1173 ,right=1198 ,bottom=1210 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=919 ,top=1218 ,right=1198 ,bottom=1255 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư��������' ,left=919 ,top=1260 ,right=1198 ,bottom=1297 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ��ȯ��' ,left=919 ,top=1347 ,right=1198 ,bottom=1384 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ��ȯ��' ,left=919 ,top=1392 ,right=1198 ,bottom=1429 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ġ�ڱݱ�α�(���װ����� ����)' ,left=316 ,top=1487 ,right=882 ,bottom=1513 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ��� ��α�' ,left=316 ,top=1524 ,right=882 ,bottom=1558 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50%�ѵ� �����α�' ,left=316 ,top=1566 ,right=882 ,bottom=1598 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30%�ѵ� �����α�' ,left=316 ,top=1608 ,right=882 ,bottom=1643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ü �� ������α�' ,left=316 ,top=1651 ,right=882 ,bottom=1687 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ü ������α�' ,left=316 ,top=1695 ,right=882 ,bottom=1732 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݰ����� ��' ,left=316 ,top=1743 ,right=882 ,bottom=1780 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=919 ,top=1487 ,right=1198 ,bottom=1513 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=919 ,top=1524 ,right=1198 ,bottom=1558 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=919 ,top=1566 ,right=1198 ,bottom=1598 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=919 ,top=1608 ,right=1198 ,bottom=1643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=919 ,top=1651 ,right=1198 ,bottom=1687 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=919 ,top=1695 ,right=1198 ,bottom=1732 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(CONAMT02,0,,CONAMT02)}', left=1206, top=1487, right=1398, bottom=1513, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT1,0,,G_AMT1)}', left=1206, top=1524, right=1398, bottom=1558, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT2,0,,G_AMT2)}', left=1206, top=1566, right=1398, bottom=1598, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT3,0,,G_AMT3)}', left=1206, top=1608, right=1398, bottom=1643, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT06,0,,CONAMT06)}', left=1206, top=1651, right=1398, bottom=1687, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT07,0,,CONAMT07)}', left=1206, top=1695, right=1398, bottom=1732, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT02S,0,,CONAMT02S)}', left=1696, top=1487, right=1885, bottom=1513, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT1S,0,,G_AMT1S)}', left=1696, top=1524, right=1885, bottom=1558, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT2S,0,,G_AMT2S)}', left=1696, top=1566, right=1885, bottom=1598, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT3S,0,,G_AMT3S)}', left=1696, top=1608, right=1885, bottom=1643, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT06S,0,,CONAMT06S)}', left=1696, top=1651, right=1885, bottom=1687, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT07S,0,,CONAMT07S)}', left=1696, top=1695, right=1885, bottom=1732, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_SUMS,0,,G_SUMS)}', left=1696, top=1743, right=1885, bottom=1780, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1403 ,top=156 ,right=1403 ,bottom=2642 </L>
	<L> left=300 ,top=1519 ,right=1403 ,bottom=1519 </L>
	<L> left=300 ,top=1603 ,right=1403 ,bottom=1603 </L>
	<L> left=300 ,top=1645 ,right=1403 ,bottom=1645 </L>
	<L> left=300 ,top=1690 ,right=1403 ,bottom=1690 </L>
	<T>id='�ۼ��������' ,left=1409 ,top=1490 ,right=1682 ,bottom=1732 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1690 ,top=1519 ,right=1896 ,bottom=1519 </L>
	<L> left=300 ,top=1561 ,right=1403 ,bottom=1561 </L>
	<L> left=1690 ,top=1690 ,right=1896 ,bottom=1690 </L>
	<L> left=1690 ,top=1645 ,right=1896 ,bottom=1645 </L>
	<L> left=1690 ,top=1603 ,right=1896 ,bottom=1603 </L>
	<L> left=1690 ,top=1561 ,right=1896 ,bottom=1561 </L>
	<L> left=300 ,top=991 ,right=1898 ,bottom=991 </L>
	<L> left=300 ,top=1297 ,right=1898 ,bottom=1297 </L>
	<L> left=300 ,top=1255 ,right=1898 ,bottom=1255 </L>
	<L> left=300 ,top=1213 ,right=1898 ,bottom=1213 </L>
	<L> left=300 ,top=1168 ,right=1898 ,bottom=1168 </L>
	<L> left=300 ,top=1123 ,right=1898 ,bottom=1123 </L>
	<L> left=300 ,top=1034 ,right=1898 ,bottom=1034 </L>
	<L> left=300 ,top=1432 ,right=1898 ,bottom=1432 </L>
	<L> left=300 ,top=1387 ,right=1898 ,bottom=1387 </L>
	<L> left=300 ,top=1738 ,right=1898 ,bottom=1738 </L>
	<L> left=108 ,top=1482 ,right=1896 ,bottom=1482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=1339 ,right=1896 ,bottom=1339 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=1081 ,right=1896 ,bottom=1081 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=947 ,right=1896 ,bottom=947 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Ư' ,left=37 ,top=1007 ,right=97 ,bottom=1047 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=1147 ,right=97 ,bottom=1187 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=1279 ,right=97 ,bottom=1318 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=1416 ,right=97 ,bottom=1455 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2001�� ���� ������ ��������' ,left=316 ,top=1872 ,right=882 ,bottom=1912 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������������' ,left=316 ,top=1917 ,right=882 ,bottom=1956 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=919 ,top=1788 ,right=1198 ,bottom=1864 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(S_AMT1,0,,S_AMT1)}', left=1206, top=1788, right=1398, bottom=1864, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S_AMT1S,0,,S_AMT1S)}', left=1696, top=1788, right=1885, bottom=1864, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���Աݾ�' ,left=919 ,top=1872 ,right=1198 ,bottom=1912 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(S_AMT2,0,,S_AMT2)}', left=1206, top=1872, right=1398, bottom=1912, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1414 ,top=1872 ,right=1688 ,bottom=1912 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(S_AMT2S,0,,S_AMT2S)}', left=1696, top=1872, right=1885, bottom=1912, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S_SUMS,0,,S_SUMS)}', left=1696, top=1917, right=1885, bottom=1956, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=300 ,top=1785 ,right=300 ,bottom=1962 </L>
	<L> left=300 ,top=156 ,right=300 ,bottom=1782 </L>
	<L> left=300 ,top=2054 ,right=300 ,bottom=2355 </L>
	<X>left=906 ,top=1034 ,right=1201 ,bottom=1081 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�ұ�����һ���� �����α� �ҵ����' ,left=113 ,top=1967 ,right=903 ,bottom=2004 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ø������� �ҵ����' ,left=113 ,top=2014 ,right=903 ,bottom=2051 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=919 ,top=1967 ,right=1198 ,bottom=2004 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SM_AMT1,0,,SM_AMT)}', left=1206, top=1967, right=1398, bottom=2004, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SM_AMTS,0,,SM_AMTS)}', left=1696, top=1967, right=1885, bottom=2004, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���Աݾ�' ,left=919 ,top=2014 ,right=1198 ,bottom=2051 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(H_AMT1,0,,H_AMT1)}', left=1206, top=2014, right=1398, bottom=2051, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_AMT1S,0,,H_AMT1S)}', left=1696, top=2014, right=1885, bottom=2051, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=300 ,top=1912 ,right=1898 ,bottom=1912 </L>
	<L> left=300 ,top=1867 ,right=1898 ,bottom=1867 </L>
	<L> left=108 ,top=2054 ,right=1896 ,bottom=2054 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=2009 ,right=1896 ,bottom=2009 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=1962 ,right=1896 ,bottom=1962 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='2000�� ���� ������ ' ,left=316 ,top=1793 ,right=882 ,bottom=1830 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ծ�40%��' ,left=1414 ,top=1793 ,right=1688 ,bottom=1830 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='72����' ,left=1414 ,top=1822 ,right=1688 ,bottom=1859 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο�������' ,left=316 ,top=1822 ,right=882 ,bottom=1859 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �Ǵ� ����' ,left=316 ,top=2062 ,right=882 ,bottom=2136 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ڤ����ڱݾ�' ,left=919 ,top=2062 ,right=1198 ,bottom=2136 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(T_SUM,0,,T_SUM)}', left=1206, top=2062, right=1398, bottom=2136, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(T_SUMS,0,,T_SUMS)}', left=1696, top=2062, right=1885, bottom=2136, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���ڰ���' ,left=121 ,top=2099 ,right=292 ,bottom=2136 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=121 ,top=2065 ,right=292 ,bottom=2101 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī��' ,left=121 ,top=2173 ,right=292 ,bottom=2212 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����' ,left=121 ,top=2210 ,right=292 ,bottom=2249 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ����' ,left=121 ,top=2249 ,right=292 ,bottom=2289 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ֽ�������ҵ����' ,left=116 ,top=2410 ,right=882 ,bottom=2563 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1414 ,top=1967 ,right=1688 ,bottom=2004 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1414 ,top=2014 ,right=1688 ,bottom=2051 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1414 ,top=2062 ,right=1688 ,bottom=2136 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1414 ,top=2357 ,right=1688 ,bottom=2394 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_SUMS,0,,C_SUMS)}', left=1696, top=2315, right=1885, bottom=2352, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(D_SUMS,0,,D_SUMS)}', left=1696, top=2357, right=1885, bottom=2394, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT1S,0,,FD_AMT1S)}', left=1696, top=2405, right=1885, bottom=2442, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT2S,0,,FD_AMT2S)}', left=1696, top=2447, right=1885, bottom=2484, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT3S,0,,FD_AMT3S)}', left=1696, top=2489, right=1885, bottom=2526, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_SUMS,0,,FD_SUMS)}', left=1696, top=2531, right=1885, bottom=2568, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������� �߼ұ�� �ٷ��� �ҵ����' ,left=116 ,top=2587 ,right=877 ,bottom=2624 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=108 ,top=2399 ,right=1896 ,bottom=2399 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=2352 ,right=1896 ,bottom=2352 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=2136 ,right=1896 ,bottom=2136 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=300 ,top=2310 ,right=1898 ,bottom=2310 </L>
	<L> left=300 ,top=2268 ,right=1898 ,bottom=2268 </L>
	<L> left=300 ,top=2225 ,right=1898 ,bottom=2225 </L>
	<L> left=300 ,top=2183 ,right=1898 ,bottom=2183 </L>
	<X>left=1403 ,top=512 ,right=1690 ,bottom=567 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=894 ,right=1690 ,bottom=947 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1034 ,right=1690 ,bottom=1081 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=906 ,top=1740 ,right=1201 ,bottom=1785 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=906 ,top=2268 ,right=1201 ,bottom=2310 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=906 ,top=2310 ,right=1201 ,bottom=2352 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1201 ,top=1740 ,right=1403 ,bottom=1785 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1432 ,right=1690 ,bottom=1482 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1740 ,right=1690 ,bottom=1785 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=906 ,top=1912 ,right=1201 ,bottom=1962 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1201 ,top=1912 ,right=1403 ,bottom=1962 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1912 ,right=1690 ,bottom=1962 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2136 ,right=1690 ,bottom=2183 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2183 ,right=1690 ,bottom=2225 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2225 ,right=1690 ,bottom=2268 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2268 ,right=1690 ,bottom=2310 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2310 ,right=1690 ,bottom=2352 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=108 ,top=2573 ,right=1896 ,bottom=2573 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<X>left=1690 ,top=2136 ,right=1898 ,bottom=2183 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1690 ,top=2183 ,right=1898 ,bottom=2225 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1690 ,top=2225 ,right=1898 ,bottom=2268 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1690 ,top=2268 ,right=1898 ,bottom=2310 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=108 ,top=214 ,right=108 ,bottom=2639 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='���� ���ݺ����' ,left=329 ,top=359 ,right=566 ,bottom=401 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=118 ,top=1867 ,right=290 ,bottom=1904 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=118 ,top=1835 ,right=290 ,bottom=1872 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=2442 ,right=1403 ,bottom=2442 </L>
	<L> left=906 ,top=2484 ,right=1403 ,bottom=2484 </L>
	<L> left=906 ,top=2526 ,right=1403 ,bottom=2526 </L>
	<T>id='210��x297��' ,left=1206 ,top=2650 ,right=1893 ,bottom=2692 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1690 ,top=2526 ,right=1896 ,bottom=2526 </L>
	<L> left=1690 ,top=2484 ,right=1896 ,bottom=2484 </L>
	<L> left=1690 ,top=2442 ,right=1896 ,bottom=2442 </L>
	<T>id='%+��x5%)' ,left=1409 ,top=2481 ,right=1685 ,bottom=2515 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��x20%+��x10' ,left=1409 ,top=2450 ,right=1685 ,bottom=2484 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ = ' ,left=1409 ,top=2418 ,right=1685 ,bottom=2452 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=906 ,top=1297 ,right=1201 ,bottom=1339 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1297 ,right=1690 ,bottom=1339 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2526 ,right=1690 ,bottom=2573 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
</B>










</R>
</A>





<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='3��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2707 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=156 ,right=1898 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(3��)' ,left=1738 ,top=90 ,right=1893 ,bottom=150 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=29 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2642 ,right=1898 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1898 ,top=156 ,right=1898 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=906 ,top=298 ,right=1898 ,bottom=298 </L>
	<T>id='��' ,left=37 ,top=472 ,right=97 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=425 ,right=97 ,bottom=464 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=374 ,right=97 ,bottom=414 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=327 ,right=97 ,bottom=367 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=103 ,top=353 ,right=295 ,bottom=396 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=253 ,right=1898 ,bottom=253 </L>
	<L> left=906 ,top=345 ,right=1898 ,bottom=345 </L>
	<L> left=906 ,top=390 ,right=1898 ,bottom=390 </L>
	<T>id='�Ա�����' ,left=321 ,top=575 ,right=503 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ΰ� ����' ,left=737 ,top=575 ,right=921 ,bottom=614 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=700 ,top=580 ,right=724 ,bottom=606 ,border=true</X>
	<X>left=1003 ,top=580 ,right=1027 ,bottom=606 ,border=true</X>
	<X>left=1327 ,top=580 ,right=1353 ,bottom=606 ,border=true</X>
	<L> left=524 ,top=572 ,right=524 ,bottom=617 </L>
	<L> left=295 ,top=662 ,right=1898 ,bottom=662 </L>
	<T>id='�ܱ���' ,left=103 ,top=617 ,right=295 ,bottom=657 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������԰�� �Ǵ� �ٷ�������' ,left=321 ,top=622 ,right=890 ,bottom=662 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ܱ��αٷμҵ濡 ���� ' ,left=321 ,top=667 ,right=890 ,bottom=707 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ⱓ������' ,left=1201 ,top=622 ,right=1403 ,bottom=662 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������԰��' ,left=1037 ,top=575 ,right=1219 ,bottom=614 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=295 ,top=617 ,right=1893 ,bottom=617 </L>
	<L> left=103 ,top=570 ,right=1898 ,bottom=570 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��������' ,left=111 ,top=163 ,right=877 ,bottom=200 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=914 ,top=163 ,right=1398 ,bottom=200 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=103 ,top=203 ,right=1898 ,bottom=203 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�����ġ�ڱ�' ,left=321 ,top=525 ,right=890 ,bottom=562 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=295 ,top=519 ,right=1898 ,bottom=519 </L>
	<T>id='�ܱ����μ���' ,left=303 ,top=214 ,right=890 ,bottom=464 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. �� �ٹ����� ���ݺ��������ΰǰ������ �� ��뺸��� ���� �Ű����� �ۼ����� �ƴ��Ͽ��� �˴ϴ�.' ,left=39 ,top=1165 ,right=1885 ,bottom=1202 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='         �������� �����ϴ�.' ,left=39 ,top=1129 ,right=1885 ,bottom=1165 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. ��(��)�ٹ��� �ٷμҵ��� �ջ��Ͽ� �Ű����� �ƴ��ϴ� ��쿡�� ���ռҵ漼 �Ű� �Ͽ��� �ϸ�, �Ű����� �ƴ��� ��� ���꼼 �ΰ� ��' ,left=39 ,top=1089 ,right=1885 ,bottom=1129 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �� �������' ,left=39 ,top=1052 ,right=1885 ,bottom=1092 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WKNM', left=332, top=952, right=900, bottom=991, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(����ڵ�Ϲ�ȣ)' ,left=39 ,top=994 ,right=316 ,bottom=1034 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ�����' ,left=39 ,top=952 ,right=316 ,bottom=991 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       �ܱ��αٷ��� ���ϼ��������û�� ���⿩�� (O �Ǵ� X �� �����ϴ�)' ,left=39 ,top=907 ,right=1393 ,bottom=947 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��Ȯ�ϰ� �������� Ȯ���մϴ�.    ' ,left=39 ,top=799 ,right=1885 ,bottom=838 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=746 ,right=1898 ,bottom=746 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=103 ,top=156 ,right=103 ,bottom=744 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='���ܿ�õ�ҵ�' ,left=911 ,top=214 ,right=1190 ,bottom=250 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1406 ,top=163 ,right=1680 ,bottom=200 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=435 ,right=1898 ,bottom=435 </L>
	<L> left=295 ,top=203 ,right=295 ,bottom=738 </L>
	<T>id='������(��ȭ)' ,left=911 ,top=258 ,right=1190 ,bottom=295 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(��ȭ)' ,left=911 ,top=303 ,right=1190 ,bottom=340 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=911 ,top=351 ,right=1190 ,bottom=388 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û��������' ,left=911 ,top=398 ,right=1190 ,bottom=435 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ��Ⱓ' ,left=911 ,top=438 ,right=1190 ,bottom=475 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FX_DATE1', left=1688, top=351, right=1877, bottom=388, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='-' ,left=1406 ,top=301 ,right=1680 ,bottom=340 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(FX_AMT1,0,,FX_AMT1)}', left=1198, top=258, right=1390, bottom=295, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FX_AMT2,0,,FX_AMT2)}', left=1198, top=303, right=1390, bottom=340, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FX_NATION', left=1198, top=351, right=1390, bottom=388, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FX_DATE2', left=1198, top=398, right=1390, bottom=435, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FX_FRTO', left=1198, top=438, right=1390, bottom=475, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������' ,left=1406 ,top=351 ,right=1680 ,bottom=388 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ܱٹ�ó' ,left=1406 ,top=398 ,right=1680 ,bottom=435 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��å' ,left=1406 ,top=438 ,right=1680 ,bottom=475 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FX_WORK', left=1688, top=398, right=1877, bottom=435, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FX_POSITION', left=1688, top=438, right=1877, bottom=475, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=295 ,top=477 ,right=1893 ,bottom=477 </L>
	<T>id='�ٷ���' ,left=108 ,top=651 ,right=292 ,bottom=691 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڱ����Ա����ڼ��װ���' ,left=321 ,top=483 ,right=890 ,bottom=519 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ڻ�ȯ��' ,left=911 ,top=483 ,right=1190 ,bottom=519 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HX_AMT,0,,HX_AMT)}', left=1198, top=483, right=1390, bottom=519, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='30%' ,left=1406 ,top=483 ,right=1680 ,bottom=519 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HX_AMTS,0,,HX_AMTS)}', left=1688, top=483, right=1877, bottom=519, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='10���� ����' ,left=911 ,top=525 ,right=1190 ,bottom=562 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(GX_AMT,0,,GX_AMT)}', left=1198, top=525, right=1390, bottom=562, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='100/110' ,left=1406 ,top=525 ,right=1680 ,bottom=562 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(GX_AMTS,0,,GX_AMTS)}', left=1688, top=525, right=1877, bottom=562, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����û��' ,left=321 ,top=699 ,right=890 ,bottom=738 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=911 ,top=667 ,right=1190 ,bottom=738 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1409 ,top=667 ,right=1682 ,bottom=738 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=617 ,right=906 ,bottom=746 </L>
	<L> left=1195 ,top=617 ,right=1195 ,bottom=746 </L>
	<L> left=1406 ,top=617 ,right=1406 ,bottom=746 </L>
	<L> left=1685 ,top=662 ,right=1685 ,bottom=746 </L>
	<L> left=906 ,top=156 ,right=906 ,bottom=570 </L>
	<L> left=1401 ,top=156 ,right=1401 ,bottom=570 </L>
	<L> left=1685 ,top=156 ,right=1685 ,bottom=570 </L>
	<T>id='       �Ű����� ���ҵ漼���� ��140���� ���� ���� ������ �Ű��ϸ�, �� ������ ����� �����Ͽ��� �Ű����� �˰� �ִ� ��� �״�θ� ' ,left=39 ,top=759 ,right=1885 ,bottom=799 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  ���� (      )' ,left=1393 ,top=907 ,right=1867 ,bottom=947 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=947 ,right=1898 ,bottom=947 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id=')' ,left=1830 ,top=994 ,right=1856 ,bottom=1034 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=324 ,top=947 ,right=324 ,bottom=1036 </L>
	<L> left=906 ,top=947 ,right=906 ,bottom=1036 </L>
	<L> left=1406 ,top=947 ,right=1406 ,bottom=1036 </L>
	<T>id='��(��)��������' ,left=911 ,top=994 ,right=1190 ,bottom=1034 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡�������� ���� ����(' ,left=1409 ,top=994 ,right=1743 ,bottom=1034 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�޿��Ѿ�' ,left=914 ,top=952 ,right=1193 ,bottom=991 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ��� �ٷμҵ��õ' ,left=1409 ,top=952 ,right=1864 ,bottom=991 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(WK_AMT,0,,WK_AMT)}', left=1203, top=952, right=1395, bottom=991, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(WK_AMTSD,0,,WK_AMTSD)}', left=1203, top=997, right=1395, bottom=1034, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������Ư�����ѹ��� �� ���� ' ,left=1364 ,top=575 ,right=1817 ,bottom=614 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1685 ,top=203 ,right=1898 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1401 ,top=203 ,right=1685 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1685 ,top=253 ,right=1898 ,bottom=298 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1401 ,top=253 ,right=1685 ,bottom=298 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�������� �� �ҵ���� �� �ۼ����' ,left=45 ,top=1260 ,right=1890 ,bottom=1300 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=1833 ,right=1896 ,bottom=1833 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Ư�������� �ۼ����' ,left=39 ,top=1843 ,right=1885 ,bottom=1883 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. ����� �Ǵ� �ξ簡���� ���� �ҵ�ݾ��� 100������ �ʰ��ϴ� ��쿡�� �������� ��� �ش����� �ƴ��ϹǷ� ���� �ƴ��մϴ�.' ,left=42 ,top=1321 ,right=1888 ,bottom=1361 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. ����� �Ǵ� �����ڸ� ���� �θ�, �ڳ� ���� �ξ簡������ �Ű��� ��� �ξ簡�������� �ߺ��Ͽ� ���� �� �����Ƿ� ���� �ƴ��մϴ�.' ,left=42 ,top=1361 ,right=1888 ,bottom=1397 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     3. �γ��ڰ����� �ξ簡��(�ҵ�� �������� ����)�� �ִ� �������� �����ٷ��� �Ǵ� ����ڰ� �ִ� �����ٷ��ڸ� �� 50������ �����մϴ�.' ,left=42 ,top=1397 ,right=1888 ,bottom=1434 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     5. �ڳ������� �ٷμҵ����� �⺻��������ڷμ� 6�� ������ ������(�Ծ��� ����) 1��� 100������ �����մϴ�.' ,left=42 ,top=1474 ,right=1888 ,bottom=1511 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     4. ����ΰ����� ���������� ������, ����� 1��� �� 200������ �����մϴ�.' ,left=42 ,top=1434 ,right=1888 ,bottom=1474 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     6. ���, �Ծ��߰������� �ش� �����Ⱓ�� ����� �����Ӱ� �Ծ�Ű��� �Ծ��ڿ� ���Ͽ� ���,�Ծ� 1��� 200������ �����մϴ�.' ,left=42 ,top=1511 ,right=1888 ,bottom=1548 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     7. ���������׸��� �ش���� Oǥ�ø� �ϸ�, ���� �ҵ���� �׸��� ������ ���Ͽ� ���� ������ �ݾ��� �����ϴ�.' ,left=42 ,top=1545 ,right=1888 ,bottom=1585 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='         - ���� �ҵ���� �׸񿡼� ������ ���ΰǰ������, ��������纸��� �� ��뺸��Ḧ �����ϰ�, �Ǻ����ڸ� �������� �����ϴ�.' ,left=42 ,top=1585 ,right=1888 ,bottom=1622 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     8. ����û�ڷ���� ����û Ȩ���������� �����ϴ� ��������ҵ���� ���� �� �ҵ�����׸��� �ݾ��� �����ϴ�.' ,left=42 ,top=1622 ,right=1888 ,bottom=1658 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     9. �� ���� �ڷ���� ����û���� �����ϴ� �������� ���� ���� �����ϴ�.' ,left=42 ,top=1658 ,right=1888 ,bottom=1695 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. [�ٷ��������޿� �����] �Ǵ� [���б���ΰ���ȸ��]�� ���� �ٷ��ڰ� �δ��� �������� ���Ծ� ���� �����մϴ�' ,left=321 ,top=1714 ,right=1888 ,bottom=1751 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=313 ,top=1706 ,right=313 ,bottom=1835 </L>
	<T>id='�������ݼҵ����' ,left=45 ,top=1717 ,right=308 ,bottom=1827 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ( [�ҵ漼��] �� 51����3��1����3ȣ).' ,left=321 ,top=1751 ,right=1888 ,bottom=1788 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. �����ѵ��� �������������( [����Ư�����ѹ�] ��86����2)�� ���Ͽ� �� 300�����Դϴ�.' ,left=321 ,top=1788 ,right=1888 ,bottom=1825 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=42 ,top=1896 ,right=305 ,bottom=1967 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ϲݻ���' ,left=118 ,top=1983 ,right=305 ,bottom=2020 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=311 ,top=1891 ,right=311 ,bottom=2645 </L>
	<T>id='��' ,left=34 ,top=2220 ,right=82 ,bottom=2260 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2183 ,right=82 ,bottom=2223 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2254 ,right=82 ,bottom=2294 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=1978 ,right=87 ,bottom=2637 </L>
	<T>id='���ΰǰ������� ���������� [��������纸���]�� ���� ��������纸��� �δ���� �����Ͽ� �����ϴ�. �Ϲ�' ,left=321 ,top=1898 ,right=1888 ,bottom=1935 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���强���� �� ��������뺸�强������ ���������� �ڵ���,����,���غ��� �� ���强���迡 ������ �ݾ��� �����ϴ�.' ,left=321 ,top=1935 ,right=1888 ,bottom=1972 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ�����޸����� ���ޱݾ� �հ���� �����ϴ�.' ,left=321 ,top=1983 ,right=1888 ,bottom=2020 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. �÷º����� �Ȱ� �Ǵ� ����Ʈ���� ���Ժ��(1��� �� 50������ �ѵ�)' ,left=321 ,top=2413 ,right=1888 ,bottom=2450 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. ������� ���屸 �� �Ƿ����� ���� �Ǵ� �������(�Ƿ����� ��� �Ƿ��⸦ ����� �ǻ��� ó���� �ʿ�)' ,left=321 ,top=2376 ,right=1888 ,bottom=2413 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. ġ��, ����� ���� [����] �� 2���� ���� �Ǿ�ǰ(�Ѿ� ����)�� �����ϰ� ������ ���' ,left=321 ,top=2339 ,right=1888 ,bottom=2376 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. ����, ����, ���������� ���Ͽ� [�Ƿ��] ��3���� ���� �Ƿ����� ������ ���' ,left=321 ,top=2299 ,right=1888 ,bottom=2339 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     4. �Ƿ���������� ���� �� �� �ش��ϴ� ������� ���մϴ�.' ,left=321 ,top=2265 ,right=1888 ,bottom=2302 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     3. �� ���� ��������� �Ƿ��� �ѱ޿����� 3%�� �ʰ��Ͽ� ������ �ݾ��� �����ϵ�, �� 700���� �ѵ��� �����մϴ�.' ,left=321 ,top=2228 ,right=1888 ,bottom=2265 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       1��1�Ϻ��� 12�� 31�ϱ��� ������ �ݾ��Դϴ�.' ,left=321 ,top=2115 ,right=1888 ,bottom=2152 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. ��������� ���ΰ� �⺻���������(���� �� �ҵ�ݾ��� ������ ���� �ƴ��մϴ�)�� ���Ͽ� �ش翬�� ' ,left=321 ,top=2075 ,right=1888 ,bottom=2115 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. ��û�� ���Ժ��' ,left=321 ,top=2450 ,right=1888 ,bottom=2486 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. [��������纸���] ��40����1�׿� ���� ���� ������ �����Ϻκδ��' ,left=321 ,top=2486 ,right=1888 ,bottom=2523 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ��. �̿�, �������� ��� �� �ǰ������� ���� �Ǿ�ǰ ���Ժ��(2009�� 12�� 31�ϱ��� ������ �ݾ׿� ������)' ,left=321 ,top=2523 ,right=1888 ,bottom=2560 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ݾ�' ,left=92 ,top=2283 ,right=303 ,bottom=2320 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ��������' ,left=92 ,top=2246 ,right=303 ,bottom=2283 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=2022 ,right=1896 ,bottom=2025 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='     2. ����, 65���̻���, ������� �Ƿ��� �Ƿ�����޾��� �������Դϴ�. �ٸ�, �� ���� ����������� ' ,left=321 ,top=2152 ,right=1888 ,bottom=2188 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       �Ƿ�� �� �޿����� 3%�� �̴��ϴ� ��� �� �̴��ϴ� �ݾ��� ���ϴ�.' ,left=321 ,top=2188 ,right=1888 ,bottom=2228 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1195 ,top=206 ,right=1195 ,bottom=570 </L>
	<L> left=1195 ,top=947 ,right=1195 ,bottom=1036 </L>
	<L> left=29 ,top=910 ,right=1898 ,bottom=910 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1975 ,right=1898 ,bottom=1975 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1888 ,right=1898 ,bottom=1888 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1703 ,right=1898 ,bottom=1703 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1310 ,right=1898 ,bottom=1310 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1252 ,right=1898 ,bottom=1252 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1036 ,right=1898 ,bottom=1036 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1210 ,right=1898 ,bottom=1210 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=906 ,top=991 ,right=1406 ,bottom=991 </L>
	<C>id='WKRESINO', left=332, top=994, right=900, bottom=1034 ,mask='XXX-XX-XXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT2', left=627, top=833, right=1195, bottom=873 ,mask='XXXX��XX��XX��', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�Ű���' ,left=1198 ,top=862 ,right=1340 ,bottom=902 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=1340, top=862, right=1606, bottom=902, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(���� �Ǵ� ��)' ,left=1606 ,top=862 ,right=1877 ,bottom=902 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>

 ">
<%=HDConstant.COMMENT_END%>
</FORM>
</BODY>
</HTML>
