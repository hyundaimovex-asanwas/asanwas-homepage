<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ�  �����ֹ���ȸ
+ ���α׷� ID	: TR00104.HTML
+ �� �� �� ��	: �����������
+ �� �� �� ��	: ���̼�
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="transfer.common.*"%>
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
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>



<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDs3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><!-- �������� -->

<OBJECT id=gcDs4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><!-- ���Թ��� -->

<OBJECT id=gcDs5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><!-- EDI ���� -->

<OBJECT id=gcDs6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><!-- EDI ���� -->

<OBJECT id=gcDs7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><!-- EDI ���� -->

<OBJECT id=gcDs8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><!-- EDI ���� -->

<OBJECT id=gcDs9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><!-- EDI ���� -->

<!-- EDI �ֹ����� ���� 20081010 -->
 <OBJECT id=gcDs_OrdMst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><!-- EDI �ֹ�mst -->
</OBJECT>

 <OBJECT id=gcDs_OrdDtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><!-- EDI �ֹ�dtl -->
</OBJECT>

 <OBJECT id=gcDs_CarMst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><!-- EDI ����mst -->
</OBJECT>

 <OBJECT id=gcDs_CarDtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><!-- EDI ����dtl -->
</OBJECT>

<%=HDConstant.COMMENT_END%><!-- EDI ���� -->


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ� ������-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- /******************************************************************************
	Description : Java Script 
******************************************************************************/ --> 
<SCRIPT language=JavaScript>

	var strParam = new Array();
  strParam=window.dialogArguments;

	/******************************************************************************
		Description :
	******************************************************************************/
	function ln_Start(){

		gcDs2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs2.Reset();

		gcDs3.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>com_ltcode?v_str1=0003";  //���籸�� 
		gcDs3.Reset();

		gcDs4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>com_ltcode?v_str1=0011";  //���籸�� 
		gcDs4.Reset();

		if(strParam[0]=="A") gclx_gubun.bindcolval=1; //�ֹ�����
		else if(strParam[0]=="B") gclx_gubun.bindcolval=2; //����
		else if(strParam[0]=="C") gclx_gubun.bindcolval=3; //�԰�
		else if(strParam[0]=="D") gclx_gubun.bindcolval=4; //����

		gcrd_sendgb.codevalue=1; //�ϰ�����
		ln_Enable();

		if(location.search){
			var str0=location.search.split("&")[0];
			var str1=location.search.split("&")[1];
			var str2=location.search.split("&")[2];
			var str3=location.search.split("&")[3];
		}


		if (str2=="" || str2==undefined){

			gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&v_str1=0001";  //Project 
			gcDsgetdate.Reset() ;

			if(gcDsgetdate.CountRow > 0 ) gcem_edt_dt.Text =  gcDsgetdate.NameValue(1,"APP_DT1");
		} else {

			gcem_edt_dt.Text	= str3;	
		}
		
		gclx_edi_sts.index=1;
		gclx_in_out.index=0;
		gcrd_ing_sts.codevalue="1"; //����



	}

	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query(){
		var ls_data = "?v_str0=" + gclx_line_part.bindcolval //������Ʈ
								+ "&v_str1=" + gclx_gubun.bindcolval     //EDI���� - �ֹ�����
								+ "&v_str2=" + gcem_edt_dt.Text          //��������
								+ "&v_str3=" + gclx_edi_sts.bindcolval   //���ۿ���
								+ "&v_str4=" + gclx_in_out.bindcolval;    //�����Ա���


	  if(gcrd_ing_sts.codevalue=="1"){

			gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_2" + ls_data;

			gcDs1.Reset();
		}else if(gcrd_ing_sts.codevalue=="2"){


			gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_22" + ls_data;

			gcDs1.Reset();

		}
	}

	/******************************************************************************
		Description :  ADD COMBO == "����" 
	******************************************************************************/
	function AddChoice(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "====����====" ;  
	}

	/******************************************************************************
		Description : EDI ����
	******************************************************************************/
	function ln_Trans(){

	  if(!ln_Chk_EDI()) return;

		if(gclx_gubun.bindcolval==1){ //�ֹ����� �����
			if(gcrd_ing_sts.codevalue=="1"){		
				if (confirm(" �ֹ����������� �����Ͻðڽ��ϱ�?")){
					ln_DataSet_AddData();
					gcTr01.KeyValue = "tr00104_edi_t1(I:USER1=gcDs_OrdMst,I:USER2=gcDs_OrdDtl,I:USER3=gcDs_CarMst,I:USER4=gcDs_CarDtl)";
					gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_t1";
					gcTr01.post(); 
				} 
			}else if(gcrd_ing_sts.codevalue=="2"){//�ֹ��������
				if (confirm(" �ֹ�������Ҹ� �����Ͻðڽ��ϱ�?")){
					gcTr01.KeyValue = "tr00104_edi_t11(I:USER=gcDs1)";
					gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_t11";
					gcTr01.post(); 
        }
			}


		}else{                       //��������
			if(gcrd_sendgb.codevalue==1){        //�ϰ�����
				gcDs9.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCallSpt5?v_str1="+gcem_edt_dt.text+ "&v_str2="+gclx_line_part.bindcolval;
				gcDs9.Reset();
			}else{                     //�κ����� - ��������, order_no, order_seq, car_seq_no
				if (confirm("�������������� �����Ͻðڽ��ϱ�?")){
					for(i =1 ; i<=gcDs1.CountRow ; i++ ) {
						if(gcDs1.NameValue(i,"CHK")=="T"){
							gcDs5.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCallSp4?v_str1="+gcDs1.namevalue(i,"ETD_DT")
							                                                 + "&v_str2="+gcDs1.namevalue(i,"ORDER_NO")
																															 + "&v_str3="+gcDs1.namevalue(i,"ORDER_SEQ")
																															 + "&v_str4="+gcDs1.namevalue(i,"CAR_SEQ_NO");
							gcDs5.Reset();
						}
					}
				}
			}
		}


	}

	
	/******************************************************************************
		Description : EDI ����
	******************************************************************************/
	function ln_Chk_EDI(){
	  var chk=0;
		_out:
	  for(i=1;i<=gcDs1.countrow;i++){
			if(gcDs1.namevalue(i,"CHK")==1){
				chk="T";
				break _out;
			}
		}
	
		if(chk==0){
			alert("������ ����� �����ϴ�.");
			return false;
  	}
		return true;
	}

 /******************************************************************************
		Description : EDI ���۽� ������ Set�� ���� ������.
	******************************************************************************/
	function ln_DataSet_AddData(){
   ln_SetDataHeader("1");
	 ln_SetDataHeader("2");
	 ln_SetDataHeader("3");
	 ln_SetDataHeader("4");
	  var chk=0;
		_out:
	  for(i=1;i<=gcDs1.countrow;i++){
			if(gcDs1.namevalue(i,"CHK")==1){
				 if(i==1){
					 ln_OrdMst_Addrow(i);  //�ֹ�MST
					 ln_OrdDtl_Addrow(i);  //�ֹ�DTL
					 ln_CarMst_Addrow(i);  //����MST
					 ln_CarDtl_Addrow(i);  //����DTL
				 }else{ 
 						if(gcDs1.namevalue(i,"ORDER_NO")!=gcDs1.namevalue(i-1,"ORDER_NO")){
							ln_OrdMst_Addrow(i); //�ֹ�MST
						}
						if(gcDs1.namevalue(i,"ORDER_NO")!=gcDs1.namevalue(i-1,"ORDER_NO")||gcDs1.namevalue(i,"ORDER_SEQ")!=gcDs1.namevalue(i-1,"ORDER_SEQ")){
							ln_OrdDtl_Addrow(i); //�ֹ�DTL
						}
            if(gcDs1.namevalue(i,"CAR_SEQ_NO")!=gcDs1.namevalue(i-1,"CAR_SEQ_NO")){
						  if(ln_Chk_SameData(gcDs1.namevalue(i,"CAR_SEQ_NO"))){ //���� �߰��� ������ �¿� �ش� ������ȣ�� ���� ��쿡 �߰�
								ln_CarMst_Addrow(i); //����MST
							}
						}
            if(gcDs1.namevalue(i,"ORDER_NO")!=gcDs1.namevalue(i-1,"ORDER_NO")||gcDs1.namevalue(i,"ORDER_SEQ")!=gcDs1.namevalue(i-1,"ORDER_SEQ")||gcDs1.namevalue(i,"CAR_SEQ_NO")!=gcDs1.namevalue(i-1,"CAR_SEQ_NO")){
							ln_CarDtl_Addrow(i); //����DTL
						}
				 }
			}
		}//for
	}

/******************************************************************************
 Description : ������ ������ȣ�� ��������Ÿ�¿� �̹� �߰� �Ǿ����� Ȯ�� üũ��.

******************************************************************************/
function ln_DataSet_Clear(){
	gcDs_OrdMst.ClearAll();
  gcDs_OrdDtl.ClearAll();
	gcDs_CarMst.ClearAll();
	gcDs_CarDtl.ClearAll();
}
 /******************************************************************************
		Description : ������ ������ȣ�� ��������Ÿ�¿� �̹� �߰� �Ǿ����� Ȯ�� üũ��.
		              �ֹ���ȣ ���� sort�ؼ� ������ȣ�� ������ üũ�ؾ���.
		p-���� �߰� ������ ������ȣ 
	******************************************************************************/
function ln_Chk_SameData(p){
	for(j=1;j<=gcDs_CarMst.countrow;j++){
		if(gcDs_CarMst.namevalue(j,"CAR_SEQ_NO")==p){
			return false;
		}
	}
	return true;
}

 /******************************************************************************
		Description : EDI ���۽� �� �����ͼ����� ������ �ֱ�
		p : rowposition
	******************************************************************************/
function ln_OrdMst_Addrow(p){
	gcDs_OrdMst.Addrow();
	gcDs_OrdMst.namevalue(gcDs_OrdMst.rowposition,"ETD_DT")  =gcDs1.namevalue(p,"ETD_DT");    //��������
	gcDs_OrdMst.namevalue(gcDs_OrdMst.rowposition,"ORDER_NO")=gcDs1.namevalue(p,"ORDER_NO");  //�ֹ���ȣ
	gcDs_OrdMst.namevalue(gcDs_OrdMst.rowposition,"EDI_STS") =gcDs1.namevalue(p,"EDI_STS");   //����DB�� ���ۻ��¸� ��Ÿ��
	gcDs_OrdMst.namevalue(gcDs_OrdMst.rowposition,"ING_STS") =gcDs1.namevalue(p,"ING_STS");   //����DB�� ���ۻ��¸� ��Ÿ�� 
	gcDs_OrdMst.namevalue(gcDs_OrdMst.rowposition,"EDI_USR") =gs_userid;
}

 /******************************************************************************
		Description : EDI ���۽� �� �����ͼ����� ������ �ֱ�
	******************************************************************************/
function ln_OrdDtl_Addrow(p){
	gcDs_OrdDtl.Addrow();
	gcDs_OrdDtl.namevalue(gcDs_OrdDtl.rowposition,"ETD_DT")  =gcDs1.namevalue(p,"ETD_DT");    //��������
	gcDs_OrdDtl.namevalue(gcDs_OrdDtl.rowposition,"ORDER_NO")=gcDs1.namevalue(p,"ORDER_NO");  //�ֹ���ȣ
	gcDs_OrdDtl.namevalue(gcDs_OrdDtl.rowposition,"ORDER_SEQ")=gcDs1.namevalue(p,"ORDER_SEQ");//�ֹ��󼼹�ȣ
	gcDs_OrdDtl.namevalue(gcDs_OrdDtl.rowposition,"EDI_STS") =gcDs1.namevalue(p,"EDI_STS");   //����DB�� ���ۻ��¸� ��Ÿ��
	gcDs_OrdDtl.namevalue(gcDs_OrdDtl.rowposition,"ING_STS") =gcDs1.namevalue(p,"ING_STS2");   //����DB�� ���ۻ��¸� ��Ÿ�� 
	gcDs_OrdDtl.namevalue(gcDs_OrdDtl.rowposition,"EDI_USR") =gs_userid;
}

 /******************************************************************************
		Description : EDI ���۽� �� �����ͼ����� ������ �ֱ�
	******************************************************************************/
function ln_CarMst_Addrow(p){
	gcDs_CarMst.Addrow();
	gcDs_CarMst.namevalue(gcDs_CarMst.rowposition,"ETD_DT")  =gcDs1.namevalue(p,"ETD_DT");        //��������
	gcDs_CarMst.namevalue(gcDs_CarMst.rowposition,"CAR_SEQ_NO")=gcDs1.namevalue(p,"CAR_SEQ_NO");  //������ȣ
	gcDs_CarMst.namevalue(gcDs_CarMst.rowposition,"EDI_STS") =gcDs1.namevalue(p,"EDI_STS");   //����DB�� ���ۻ��¸� ��Ÿ��
	gcDs_CarMst.namevalue(gcDs_CarMst.rowposition,"ING_STS") =gcDs1.namevalue(p,"ING_STS3");   //����DB�� ���ۻ��¸� ��Ÿ�� 
	gcDs_CarMst.namevalue(gcDs_CarMst.rowposition,"EDI_USR") =gs_userid;
}

 /******************************************************************************
		Description : EDI ���۽� �� �����ͼ����� ������ �ֱ�
	******************************************************************************/
function ln_CarDtl_Addrow(p){
	gcDs_CarDtl.Addrow();
	gcDs_CarDtl.namevalue(gcDs_CarDtl.rowposition,"ETD_DT")  =gcDs1.namevalue(p,"ETD_DT");      //��������
	gcDs_CarDtl.namevalue(gcDs_CarDtl.rowposition,"ORDER_NO")=gcDs1.namevalue(p,"ORDER_NO");    //�ֹ���ȣ
	gcDs_CarDtl.namevalue(gcDs_CarDtl.rowposition,"ORDER_SEQ")=gcDs1.namevalue(p,"ORDER_SEQ");  //�ֹ��󼼹�ȣ
	gcDs_CarDtl.namevalue(gcDs_CarDtl.rowposition,"CAR_SEQ_NO")=gcDs1.namevalue(p,"CAR_SEQ_NO");//������ȣ
	gcDs_CarDtl.namevalue(gcDs_CarDtl.rowposition,"EDI_STS") =gcDs1.namevalue(p,"EDI_STS");   //����DB�� ���ۻ��¸� ��Ÿ��
	gcDs_CarDtl.namevalue(gcDs_CarDtl.rowposition,"ING_STS") =gcDs1.namevalue(p,"ING_STS4");   //����DB�� ���ۻ��¸� ��Ÿ�� 
	gcDs_CarDtl.namevalue(gcDs_CarDtl.rowposition,"EDI_USR") =gs_userid;
}

 /******************************************************************************
		Description : DataSet header ����
	******************************************************************************/
 function ln_SetDataHeader(p){
    var s_temp ="";
    if(p=="1"){
			if (gcDs_OrdMst.countrow<1){
				s_temp = "ETD_DT:STRING(8),ORDER_NO:STRING(10),EDI_STS:STRING(1),ING_STS:STRING(1),EDI_USR:STRING(10)";
				gcDs_OrdMst.SetDataHeader(s_temp);
			}
		}else if(p=="2"){
      if (gcDs_OrdDtl.countrow<1){
				s_temp = "ETD_DT:STRING(8),ORDER_NO:STRING(10),ORDER_SEQ:STRING(4),EDI_STS:STRING(1),ING_STS:STRING(1),EDI_USR:STRING(10)";
				gcDs_OrdDtl.SetDataHeader(s_temp);
			}
		}else if(p=="3"){
      if (gcDs_CarMst.countrow<1){
				s_temp = "ETD_DT:STRING(8),CAR_SEQ_NO:STRING(10),EDI_STS:STRING(1),ING_STS:STRING(1),EDI_USR:STRING(10)";
				gcDs_CarMst.SetDataHeader(s_temp);
			}
		}else if(p=="4"){
      if (gcDs_CarDtl.countrow<1){
				s_temp = "ETD_DT:STRING(8),ORDER_NO:STRING(10),ORDER_SEQ:STRING(4),CAR_SEQ_NO:STRING(10),EDI_STS:STRING(1),ING_STS:STRING(1),EDI_USR:STRING(10)";
				gcDs_CarDtl.SetDataHeader(s_temp);
			}
		}
 }


	/******************************************************************************
		Description : EDI ����
	******************************************************************************/
	function ln_Enable(){
		if(gcrd_sendgb.codevalue==1){ //�ϰ�����
			gclx_in_out.index=0;
			//gclx_ing_sts.index=0;
      //gclx_ing_sts2.index=0;
			gclx_edi_sts.index=1; //������
			gclx_in_out.enable=false;
			//gclx_ing_sts.enable=false;
			//gclx_ing_sts2.enable=false;
			gclx_edi_sts.enable=false;
		}else{
			gclx_in_out.enable=true;
			//gclx_ing_sts.enable=true;
			//gclx_ing_sts2.enable=true;
			gclx_edi_sts.enable=true;
		}
	}

 /******************************************************************************
		Description : 
	******************************************************************************/
	function ln_Grid_Format(){
    
		 if(gcrd_ing_sts.codevalue=="1"){	 //�ֹ����� ����
			 gcgd_data.Format = "<C> Name='No.'	    ID=GRAYY      HeadAlign=Center  HeadBgColor=#eeeeee Width=28  align=center  Value={ToString(RowCount-CurRow+1)}</C>                                     "  
												+ "<C> Name='����'			ID=CHK  			HeadAlign=Center	HeadBgColor=#eeeeee Width=28  align=center  Editstyle='checkbox' cursor=hand</C>                                        "  
												+ "<G> Name='����'     HeadAlign=Center	HeadBgColor=#eeeeee	                                                                                                                  "  
												+ "	<C> Name='�ֹ�'	    ID=ING_STS		HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  EditStyle=Combo Data='I:�ű�,U:����,C:���' </C> 				                    "  
												+ "	<C> Name='����'	    ID=ING_STS3		HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  EditStyle=Combo Data='I:�ű�,U:����,C:���' </C> 				                    "  
												+ "</G>                                                                                                                                                                        "  
												+ "<C> Name='����'	    ID=INGGB   		HeadAlign=Center	HeadBgColor=#eeeeee Width=58  align=center  suppress=1</C>                                                              "  
												+ "<C> Name='����'	    ID=EDI_STS		HeadAlign=Center	HeadBgColor=#eeeeee Width=58  align=center  EditStyle=Combo Data='N:������,S:������,Y:���ۿϷ�,A:������' suppress=2</C> "  
												+ "<C> Name='��������'	ID=ETD_DT		  HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  MASK='XXXX-XX-XX' , suppress=3</C>                                          "  
												+ "<C> Name='�ֹ���ȣ'	ID=ORDER_NO		HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center, suppress=4</C>                                                              "  
												+ "<C> Name='������ȣ'	ID=CAR_SEQ_NO	HeadAlign=Center	HeadBgColor=#eeeeee Width=65  align=center, suppress=5</C>                                                              "  
												+ "<C> Name='��������'	ID=CARGO_TYPE	HeadAlign=Center	HeadBgColor=#eeeeee Width=95  align=left,   suppress=6  EditStyle=Lookup	Data='gcDs3:MINORCD:MINORNM'</C>              "  
												+ "<C> Name='ȭ��'			ID=SHIPPERNM  HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left,   suppress=7</C>                                                              "  
												+ "<C> Name='ǰ��'			ID=ARTC_NM  	HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left </C>                                                                           "  
												//+ "<C> Name='����DB'	  ID=HL_EDI_STS HeadAlign=Center	HeadBgColor=#eeeeee Width=58  align=center  EditStyle=Combo Data='N:������,S:������,Y:���ۿϷ�,A:������'</C>            "  
													 
		 }else if(gcrd_ing_sts.codevalue=="2"){ // ���

		   gcgd_data.Format = "<FC> Name='No.'	      ID=''            HeadAlign=Center HeadBgColor=#eeeeee Width=28  align=center   Value={ToString(RowCount-CurRow+1)}</FC>                               "  
												+ "<FC> Name='����'	      ID=CHK  		     HeadAlign=Center	HeadBgColor=#eeeeee Width=28  align=center   Editstyle='checkbox' cursor=hand</FC>                                  "  
			                  + "<FC> Name='����'	    	ID=INGGB  	     HeadAlign=Center	HeadBgColor=#eeeeee Width=28  align=center   EditStyle=Combo Data='1:�ֹ�,2:����'  </FC>                            "
												+ "<FG> Name='����'  HeadAlign=Center HeadBgColor=#eeeeee                                                                                                                       "  
												+ "	<FC> Name='�ֹ�'      ID=ING_STS	     HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center   EditStyle=Combo Data='C:���' </FC>                                    "  
												+ "	<FC> Name='����'	    ID=ING_STS2	     HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center   EditStyle=Combo Data='C:���' </FC> 				                            "  
												+ "</FG>                                                                                                                                                                        "  											
												+ "	<FC>Name='���ۻ���'     ID=EDI_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=60  align=center   EditStyle=Combo Data='N:������,S:������,Y:���ۿϷ�,A:������'</FC>      "  
												+ "	<FC>Name='������//����' ID=IN_OUT	     HeadAlign=Center	HeadBgColor=#eeeeee Width=60  align=center   EditStyle=Combo Data='O:����,I:����'</FC>                              "  
												+ " <C> Name='�ֹ���ȣ'		ID=ORDER_NO  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=center   </C>                                                                   "
												+ " <C> Name='������ȣ'		ID=CAR_SEQ_NO  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=center   </C>                                                                   "
												+ " <C> Name='��������' 	ID=CARGO_TYPE	   HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left,   EditStyle=Lookup	Data='gcDs3:MINORCD:MINORNM'</C>                      "
												+ " <C> Name='ȭ��'			  ID=SHIPPERNM     HeadAlign=Center	HeadBgColor=#eeeeee Width=150 align=left,   </C>                                                                    "
	  }

}
</SCRIPT> 


<!-----------------------------------------------------------------------------
		G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcDs1" event="OnLoadStarted()">
	OnStatusStart(); 
</script>

<script language="javascript" for="gcDs1" event="onLoadCompleted(row,colid)">
	TheStatusEnd(row); 
	ln_DataSet_Clear();
</script>

<script language=JavaScript for=gcgd_data event=OnClick(row,colid)>
	if(row<1) {
		if(row==0&&colid=="CHK"){
		  if(gcDs1.namevalue(1,colid)==0){
				for(i=1;i<=gcDs1.countrow;i++){
					gcDs1.namevalue(i,colid) = 1;
				}
      }else{
				for(i=1;i<=gcDs1.countrow;i++){
					gcDs1.namevalue(i,colid) = 0;
				}
			}
		}
	}else{
		if (colid=="CHK"){
			if (gcDs1.namevalue(row,colid) == 1) gcDs1.namevalue(row,colid) = 0;
			else gcDs1.namevalue(row,colid) = 1;

      for(i =1 ; i<=gcDs1.CountRow ; i++ ) {
				if(gcDs1.NameValue(row,"ORDER_NO") == gcDs1.NameValue(i,"ORDER_NO" )){
					gcDs1.NameValue(i,"CHK" ) = gcDs1.NameValue(row,"CHK") ; 
				} 
			}


		}
	}
</script>

<script language=JavaScript for="gcDs2" event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs2) ; 
	gclx_line_part.Index = 0 ; 
</script>


<script language=JavaScript for="gcDs4" event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs4) ; 
</script>


<script language=JavaScript for=gcrd_sendgb event=OnSelChange()>
	ln_Enable();
</script>

<script language=JavaScript for=gcrd_ing_sts event=OnSelChange()>
  gcDs1.ClearAll();
  ln_Grid_Format();

	if(gcrd_ing_sts.codevalue=="2"){ // ���

	}else{

	}
</script>


<!-----------------------------------------------------------------------------
		G A U C E   C O M P O N E N T' S
		Tranaction    E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcTr01 event=OnSuccess()>
  alert("�ֹ����� ������ �Ϸ��Ͽ����ϴ�.");
	ln_DataSet_Clear();
</script>

<script language=JavaScript for=gcTr01 event=OnFail()>
  alert("Error Code : " + gcTr01.ErrorCode + "\n" + "Error Message : " + gcTr01.ErrorMsg + "\n");
	ln_DataSet_Clear();
</script>


</HEAD>

<BODY onLoad="ln_Start()">
	<table width="830" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:5px;">
		<tr> 
			<td width="830" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="../../../Common/img/btn/com_b_trans.gif" style="cursor:hand" onclick="ln_Trans()">
				<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2>
				<table border=0 cellpadding=0 cellspacing=0 style="border:1 solid #708090;border-bottom-width:0px;border-right-width:0px;width:100%">
					<tr>
						
						<td class="tab11" style="width:80px;" bgcolor="#efefef">���۱���</td>
						<td class="tab21">
								<%=HDConstant.COMMENT_START%>
								<object id=gcrd_sendgb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="height:24; width:140">
								<param name=Cols	  value="2">
			          <param name=Format	value="1^�ϰ�����,2^�κ�����">
								<param name=Enable 	value="true">
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						
						<td class="tab11" style="width:80px;height:30px;" bgcolor="#efefef">������Ʈ</td>
						<td class="tab21" style="width:120px;">
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part  style='position:relative;left:8px;top:1px;width:100px;height:180' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=ComboDataID			value="gcDs2">  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^158">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
							</OBJECT><%=HDConstant.COMMENT_END%> 
						</td>

						<td class="tab11" style="width:80px;" bgcolor="#efefef">��������</td>
						<td class="tab21">
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_edt_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:6px; width:70px; height:17px; font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:8px;top:2px;cursor:hand" onclick="__GetCallCalendar('gcem_edt_dt', 'Text');">&nbsp;&nbsp;&nbsp;
						</td>

						<td class="tab11" style="width:80px;" bgcolor="#efefef">EDI����</td>
						<td class="tab21">
								<%=HDConstant.COMMENT_START%><OBJECT id=gclx_gubun  style='position:relative;left:8px;top:1px;width:100px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=CBData					value="1^�ֹ�����,2^����,3^�԰�,4^����">
								<param name=CBDataColumns		value="code,name">
								<param name=SearchColumn		value=name>
								<param name=Sort						value=false>
								<param name=Enable          value="false">
								<param name=ListExprFormat	value="name^0^100">								
								<param name=BindColumn			value="code">								
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

					</tr>
					<tr>
						<td class="tab11" style="width:80px;height:30px;" bgcolor="#efefef">�����Ա���</td>
						<td class="tab21" style="width:120px;">
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_in_out style='position:relative;left:8px;top:1px;width:100px;height:180' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=ComboDataID			value="gcDs4">  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
							</OBJECT><%=HDConstant.COMMENT_END%> 
						</td>

						<!-- <td class="tab11" style="width:80px;" bgcolor="#efefef">�ֹ�����</td>
						<td class="tab21" style="width:120px;" >
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_ing_sts  style='position:relative;left:8px;top:1px;width:100px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=CBData					value="''^��ü,I^�ű�,U^����,C^���">
								<param name=CBDataColumns		value="code,name">
								<param name=SearchColumn		value=name>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="name^0^100">								
								<param name=BindColumn			value="code">								
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

						<td class="tab11" style="width:80px;" bgcolor="#efefef">��������</td>
						<td class="tab21" style="width:120px;" >
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_ing_sts2  style='position:relative;left:8px;top:1px;width:100px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=CBData					value="''^��ü,I^�ű�,U^����,C^���">
								<param name=CBDataColumns		value="code,name">
								<param name=SearchColumn		value=name>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="name^0^100">								
								<param name=BindColumn			value="code">								
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td> -->

						<td class="tab11" style="width:80px;" bgcolor="#efefef">���ۿ���</td>
						<td class="tab21" style="width:120px;" >
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_edi_sts  style='position:relative;left:8px;top:1px;width:100px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=CBData					value="''^��ü,'N'^������,S^������,Y^���ۿϷ�,A^������">
								<param name=CBDataColumns		value="code,name">
								<param name=SearchColumn		value=name>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="name^0^50">								
								<param name=BindColumn			value="code">											
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

						<td class="tab11" style="width:80px;" bgcolor="#efefef">����</td>
						<td class="tab21" colspan=3>
								<%=HDConstant.COMMENT_START%>
								<object id=gcrd_ing_sts classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="height:24; width:140">
								<param name=Cols	  value="2">
			          <param name=Format	value="1^����,2^���,">
								<param name=Enable 	value="true">
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:300px;height:30px;font-size:9pt;background-color:#ffffff;border:0 solid #708090">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="width:830;height:321px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true"> 
								<Param Name="LineColor"   value="Green">
								<param name=ColSizing     value="true">
								<param name="ViewSummary" VALUE="true">
								<param name=DragDropEnable  value="true">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="Format"			VALUE="  
									<C> Name='No.'	    ID=GRAYY      HeadAlign=Center  HeadBgColor=#eeeeee Width=28  align=center  Value={ToString(RowCount-CurRow+1)}</C> 
									<C> Name='����'			ID=CHK  			HeadAlign=Center	HeadBgColor=#eeeeee Width=28  align=center  Editstyle='checkbox' cursor=hand</C> 
									<G> Name='����'     HeadAlign=Center	HeadBgColor=#eeeeee	
										<C> Name='�ֹ�'	  ID=ING_STS		HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  EditStyle=Combo Data='I:�ű�,U:����,C:���' </C> 				
										<C> Name='����'	  ID=ING_STS3		HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  EditStyle=Combo Data='I:�ű�,U:����,C:���' </C> 				
									</G>
									<C> Name='����'	    ID=INGGB   		HeadAlign=Center	HeadBgColor=#eeeeee Width=58  align=center  suppress=1</C>
									<C> Name='����'	    ID=EDI_STS		HeadAlign=Center	HeadBgColor=#eeeeee Width=58  align=center  EditStyle=Combo Data='N:������,S:������,Y:���ۿϷ�,A:������' suppress=2</C> 												
									<C> Name='��������'	ID=ETD_DT		  HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  MASK='XXXX-XX-XX' , suppress=3</C> 
									<C> Name='�ֹ���ȣ'	ID=ORDER_NO		HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center, suppress=4</C> 
									<C> Name='������ȣ'	ID=CAR_SEQ_NO	HeadAlign=Center	HeadBgColor=#eeeeee Width=65  align=center, suppress=5</C> 
									<C> Name='��������'	ID=CARGO_TYPE	HeadAlign=Center	HeadBgColor=#eeeeee Width=95  align=left,   suppress=6  EditStyle=Lookup	Data='gcDs3:MINORCD:MINORNM'</C> 
									<C> Name='ȭ��'			ID=SHIPPERNM  HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left,   suppress=7</C> 
									<C> Name='ǰ��'			ID=ARTC_NM  	HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left </C> 
								">
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr> 

					<tr>
						<td> <br>
							* �ϰ������� ������ �����͸� �������� �����մϴ�.<br>
							* �κ������� �˻� ���ǿ� ���� �����͸� �����մϴ�.<br>
							* �����ý����� ������ �˻��� �����Դϴ�.
						</td>
					</tr>
				</table> 

			</td>
		</tr>
	</table>
	<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

</BODY>
</HTML>
