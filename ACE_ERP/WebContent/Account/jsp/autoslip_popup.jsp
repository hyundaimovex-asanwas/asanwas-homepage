<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �ڵ���ǥ �˾����� 
+ ���α׷� ID:  autoslip_popup.jsp
+ �� �� �� ��	:  �ڵ���ǥ 
+ ��   ��  ��  :  �� �� ��
+ �� �� �� �� :  2011.11.29
-----------------------------------------------------------------------------
+ �� �� �� �� :	 
+ ��   ��  �� :  
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>������ǥ����</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

var objParent=window.dialogArguments;


function  ln_Start(){
	  ln_Before();
	  
	  ln_SetDataHeader_Auto();
	  
	  ln_SampleData()
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_SampleData(){
	gcds_wkgb.addrow();
	gcds_wkgb.namevalue(gcds_wkgb.rowposition,"FDCODE")="02";
	gcds_wkgb.namevalue(gcds_wkgb.rowposition,"WKGB")="K";
	gcds_wkgb.namevalue(gcds_wkgb.rowposition,"WKCNT")="1";
	
	
	gcds_mst.addrow();
	gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")="02";
	gcds_mst.namevalue(gcds_mst.rowposition,"WKNO")="201112000001";
	gcds_mst.namevalue(gcds_mst.rowposition,"TAMT")=1200000000;
	gcds_mst.namevalue(gcds_mst.rowposition,"REMARK")="�����Ϲݻ������ �������� ������(12%)";
	
	
	gcds_dtl.addrow();
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")="02";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")="1110150";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")="���뿹��";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=1200000000;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")="�����Ϲݻ������ �������� ������(12%)";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD01")="0002";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD02")="0020";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD03")="0022";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD04")="0023";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD05")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD09")="";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL01")="II00";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")="I16081";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL03")="A00003";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL04")="1589";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL05")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL09")="";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM01")="�Ǽ��������";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")="���ϵ����߰���";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM03")="��ȯ���� �赿����";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM04")="117-13-72620-8";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM05")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM09")="";
	
	
	gcds_dtl.addrow(); //2
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")="02";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")="2100910";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")="������";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=741818182;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")="�����Ϲݻ������ �������� ������(12%)";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD01")="0002";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD02")="0020";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD03")="1014";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD04")="1043";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD05")="1045";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD09")="";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL01")="II00";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")="I16081";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL03")="01";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL04")="01";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL05")="0";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL09")="";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM01")="�Ǽ��������";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")="���ϵ����߰���";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM03")="����.�뿪.��༱����";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM04")="WON";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM05")="0";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM09")="";
		
	
	gcds_dtl.addrow();//3
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")="02";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")="2100910";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")="�����ΰ���ġ��";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=74181818;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")="�����Ϲݻ������ �������� ������(12%) VAT";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD01")="0002";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD02")="0020";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD03")="1017";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD04")="0970";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD05")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD09")="";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL01")="II00";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")="I16081";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL03")="03";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL04")="20091214";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL05")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL09")="";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM01")="�Ǽ��������";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")="���ϵ����߰���";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM03")="���ݰ�꼭";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM04")="20091214";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM05")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM09")="";
	
	gcds_dtl.addrow();//4
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")="02";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")="2100510";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")="�����ޱ�";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=384000000;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")="�����Ϲݻ������ �������� ������(�����Ǽ�)";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD01")="0002";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD02")="0020";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD03")="1013";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD04")="1043";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD05")="1045";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD09")="";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL01")="II00";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")="I16081";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL03")="002";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL04")="01";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL05")="0";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL09")="";
	
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM01")="�Ǽ��������";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")="���ϵ����߰���";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM03")="����.�뿪�����ޱ�";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM04")="WON";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM05")="0";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM06")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM07")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM08")="";
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM09")="";
	
	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){



}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Before(){
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_fdcode.Reset();
}



/******************************************************************************
	Description : rdo gubun format 
******************************************************************************/
function ln_rdo_format(){


}



/******************************************************************************
	Description : ����Ÿ�� ��� ����.
******************************************************************************/
function ln_SetDataHeader_Auto(){
    var s_temp="";

	if (gcds_wkgb.countrow<1){
		s_temp = "CHK:STRING,FDCODE:STRING,WKGB:STRING,WKCNT:DECIAML";
		gcds_wkgb.SetDataHeader(s_temp);
	}
	
	
	if (gcds_mst.countrow<1){
		s_temp = "CHK:STRING,FDCODE:STRING,WKNO:STRING,TAMT:DECIAML,REMARK:STRING";
		gcds_mst.SetDataHeader(s_temp);
	}
		
	if (gcds_dtl.countrow<1){
		s_temp = "FDCODE:STRING,ATCODE:STRING,ATKORNAM:STRING,"
		            + "CHAAMT:DECIAML,DAEAMT:DECIAML,DOCUMCD:STRING,DOCUVAL:STRING,FSWRKDIV:STRING,REMARK:STRING,"
		            + "FSREFCD01:STRING,FSREFVAL01:STRING,FSRVALNM01:STRING,"
		            + "FSREFCD02:STRING,FSREFVAL02:STRING,FSRVALNM02:STRING,"
		            + "FSREFCD03:STRING,FSREFVAL03:STRING,FSRVALNM03:STRING,"
		            + "FSREFCD04:STRING,FSREFVAL04:STRING,FSRVALNM04:STRING,"
		            + "FSREFCD05:STRING,FSREFVAL05:STRING,FSRVALNM05:STRING,"
		            + "FSREFCD06:STRING,FSREFVAL06:STRING,FSRVALNM06:STRING,"
		            + "FSREFCD07:STRING,FSREFVAL07:STRING,FSRVALNM07:STRING,"
		            + "FSREFCD08:STRING,FSREFVAL08:STRING,FSRVALNM08:STRING,"
		            + "FSREFCD09:STRING,FSREFVAL09:STRING,FSRVALNM09:STRING";
		gcds_dtl.SetDataHeader(s_temp);
	}
	
	
	/**
	if (gcds_wkgb.countrow<1){
		var s_temp = "CHK:STRING,FDCODE:STRING,WKGB:STRING,WKCNT:DECIAML";
		gcds_wkgb.SetDataHeader(s_temp);
	}
	
	
	if (gcds_wkgb.countrow<1){
		var s_temp = "CHK:STRING,FDCODE:STRING,WKGB:STRING,WKCNT:DECIAML";
		gcds_wkgb.SetDataHeader(s_temp);
	}**/

}

/******************************************************************************
	Description : ����Ÿ ����
******************************************************************************/
function ln_Data(){

}

/******************************************************************************
	Description : Ȯ�ι�ư
******************************************************************************/
function ln_Close(){

   //��ǥMST
   //objParent.ln_SetDataHeader("AUTOMST");
   //objParent.gcds_automst.addrow();
   /* 
   objParent.gcds_automst.namevalue(objParent.gcds_automst.rowposition,"FDCODE")=gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE") ;
   objParent.gcds_automst.namevalue(objParent.gcds_automst.rowposition,"WKNO")   =gcds_mst.namevalue(gcds_mst.rowposition,"WKNO") ;
   objParent.gcds_automst.namevalue(objParent.gcds_automst.rowposition,"TAMT")    =gcds_mst.namevalue(gcds_mst.rowposition,"TAMT") ;
   objParent.gcds_automst.namevalue(objParent.gcds_automst.rowposition,"REMARK")=gcds_mst.namevalue(gcds_mst.rowposition,"REMARK") ;
   */
   
   objParent.gcds_data01_2.namevalue(objParent.gcds_data01_2.rowposition,"FDCODE") =gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE") ;
   objParent.gcds_data01_2.namevalue(objParent.gcds_data01_2.rowposition,"FSAMT")   =gcds_mst.namevalue(gcds_mst.rowposition,"WKNO")   ;
   objParent.gcds_data01_2.namevalue(objParent.gcds_data01_2.rowposition,"DETOT")   =gcds_mst.namevalue(gcds_mst.rowposition,"TAMT")   ;
   objParent.gcds_data01_2.namevalue(objParent.gcds_data01_2.rowposition,"CRTOT")   =gcds_mst.namevalue(gcds_mst.rowposition,"TAMT")   ;
   objParent.gcds_data01_2.namevalue(objParent.gcds_data01_2.rowposition,"REMARK") =gcds_mst.namevalue(gcds_mst.rowposition,"REMARK") ;
   
   
 
   //��ǥDTL
   
   for (var i=1; i<=gcds_dtl.countrow ; i++){
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"FDCODE") =gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE") ;
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"FSDAT")   ="" ;
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"FSNBR")   ="" ;
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"FSSEQ")   ="" ;
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"ATCODE") =gcds_dtl.namevalue(i,"ATCODE") ;  
	   
	   ln_Atcode_ref(gcds_dtl.namevalue(i,"ATCODE"), gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE"));
	   
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"ATDECR") ="";
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"CHAAMT") =gcds_dtl.namevalue(i,"CHAAMT");
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"DAEAMT") =gcds_dtl.namevalue(i,"DAEAMT");
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"DOCUMCD") ="";
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"FSWRKDIV") ="";
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"REMARK") =gcds_dtl.namevalue(i,"REMARK");
	   //objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"BANJAEYN") ="";
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"DOCUVAL") ="";
	  
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"DIVCD") ="";
	   objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"BGTDIV") ="";
	   
	   if ( i>=2)  objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"FSNUM") =objParent.ln_Fsnum_Find();
	   
	   
	   //�����׸� - �ŷ�ó//�μ�   FSRVALNM01
	   
	    for(var j=1;j<=9;j++){ 
	    	objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"FSREFVAL0"+j) =gcds_dtl.namevalue(i,"FSREFVAL0"+j);
	    	objParent.gcds_dtl.namevalue(objParent.gcds_dtl.rowposition,"FSRVALNM0"+j)=gcds_dtl.namevalue(i,"FSRVALNM0"+j);
	    }
	    
	  
	   if ( i != gcds_dtl.countrow ){
	   		objParent.gcds_dtl.Addrow();
	   }
   }
   
   
   //��ǥREF
   window.close();
}

/******************************************************************************
	Description : �� ������ �����׸� ���� ã�� 
******************************************************************************/
function ln_Atcode_ref(strAtcode, strFdcode){
	gcds_auto_atcode.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>actcode_s1f?v_str1="+strAtcode+"&v_str2='Y'&v_str3="+strFdcode;
	  //prompt("",gcds_auto_atcode.DataID);                                                   
	  gcds_auto_atcode.Reset();
	  
	  var row = gcds_auto_atcode.rowposition;
	  var strReturn = gcds_auto_atcode.namevalue(row,"ATCODE") + ";"    //0 
						   + gcds_auto_atcode.namevalue(row,"ATKORNAM")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CNT")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDCODE1")+ ";"  //�μ�
						   + gcds_auto_atcode.namevalue(row,"CDNAM1")+ ";"   
						   + gcds_auto_atcode.namevalue(row,"CDCODE2")+ ";"  //�ŷ�ó
						   + gcds_auto_atcode.namevalue(row,"CDNAM2")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDCODE3")+ ";"  //7
						   + gcds_auto_atcode.namevalue(row,"CDNAM3")+ ";"    //8
						   + gcds_auto_atcode.namevalue(row,"CDCODE4")+ ";"  //9
						   + gcds_auto_atcode.namevalue(row,"CDNAM4")+ ";"    //10 
						   + gcds_auto_atcode.namevalue(row,"CDCODE5")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDNAM5")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDCODE6")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDNAM6")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDCODE7")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDNAM7")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDCODE8")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDNAM8")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDCODE9")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"CDNAM9")+ ";"   //20 
		    			   + gcds_auto_atcode.namevalue(row,"TYPE1")+ ";"   
						   + gcds_auto_atcode.namevalue(row,"TYPE2")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"TYPE3")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"TYPE4")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"TYPE5")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"TYPE6")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"TYPE7")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"TYPE8")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"TYPE9")+ ";" 
		   				   + gcds_auto_atcode.namevalue(row,"ARBALDIV1")+ ";"  //30  
						   + gcds_auto_atcode.namevalue(row,"ARBALDIV2")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"ARBALDIV3")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"ARBALDIV4")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"ARBALDIV5")+ ";" 
					       + gcds_auto_atcode.namevalue(row,"ARBALDIV6")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"ARBALDIV7")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"ARBALDIV8")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"ARBALDIV9")+ ";" 
						   + gcds_auto_atcode.namevalue(row,"ATDEBTYN")+ ";"  //39 
						   + gcds_auto_atcode.namevalue(row,"ATDECR")+";"       //40   
						   + gcds_auto_atcode.namevalue(row,"BGTCMTYPE")+";" 
						   + gcds_auto_atcode.namevalue(row,"BGTCNT")+";" 
						   + gcds_auto_atcode.namevalue(row,"FUNDDIV")+";" 
						   + gcds_auto_atcode.namevalue(row,"BANJAEREF")+";" 
						   + gcds_auto_atcode.namevalue(row,"ATCURTYPE");
			
			//prompt('strReturn',strReturn);
			
			var arrResult	= new Array();
			arrResult = strReturn.split(";");
			
			objParent.ln_Ref_Find(arrResult);

}

/******************************************************************************
	Description : �˾� unload�� 2010.03.16 jys �ű��߰� 
******************************************************************************/
function ln_unLoad(){

}

/******************************************************************************
	Description : ���� �ٿ�ε� 
******************************************************************************/
function ln_Excel(){

}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ������ �� -->
<comment id="__NSID__">

<object  id=gcds_wkgb classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object  id=gcds_dtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

  
 <object  id=gcds_auto_atcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
 </object>
  

</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"   value="toinb_dataid4">
	<param name="keyvalue"    value="commrepay_t1(I:USER=gcds_cancel)">   
  </object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
</script>


<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	 gclx_fdcode.bindcolval = gfdcode;
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
</script>


<script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data01 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data01 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()" onunLoad="ln_unLoad()">
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/commrepay_head_md.gif"></td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_btn_send.gif"	  style="cursor:hand" onClick="ln_Close()" >
			<img src="../../Common/img/btn/com_btn_send.gif"	  style="cursor:hand" onClick="ln_Close1()" >
			<img src="../../Common/img/btn/com_btn_send.gif"	  style="cursor:hand" onClick="ln_Close2()" >
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab15" align=center ><nobr>����</nobr></td>
		<td class="tab18" style="width:800px;height:30px" ><nobr>&nbsp;
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
				style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
					<param name=ComboDataID         value="gcds_fdcode">
					<param name=CBDataColumns	 value="FDCODE,FDNAME">
					<param name=SearchColumn	     value=FDNAME>
					<param name=Sort			             value=false>
					<param name=ListExprFormat       value="FDNAME">								
					<param name=BindColumn		     value="FDCODE">
			</object>
			</nobr>
		</td> 	
   </tr>
   <tr>
        <td style="height:6px"  colspan=2>  </td>
   </tr>
</table>

<table  cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;width:860px;height:80px;font-size:9pt;background-color:#ffffff;">
	<tr>
        <td style="height:20px"  colspan=2 >
        	<font size="2" color="blue"><B>*��������</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <font size="2" color="blue"><B>*��ǥ�������</B></font>
        
        </td>
   </tr>
	<tr> 
		<td class="tab32" style="width:190px;height:80px" ><nobr>&nbsp;
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gcgd_disp02  
					 style="position:relative;left:-1px;width:190px; height:80px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_wkgb">
						<PARAM NAME="IndWidth"		VALUE ='0'>
						<PARAM NAME="BorderStyle"   VALUE="0">
						<PARAM NAME="Fillarea"		    VALUE="true">
						<param name="Editable"          value="true">
						<PARAM NAME="Format"			VALUE=" 
						    <FC>Name='����'		     ID=CHK	                 HeadAlign=Center HeadBgColor=#B9D4DC Width=28	 align=center   EditStyle=CheckBox</FC> 
							<FC>Name='��������'	 ID=WKGB    	         HeadAlign=Center HeadBgColor=#B9D4DC Width=80    align=center  edit=none  EditStyle=Combo		Data='K:����,P:����'</FC> 
							<FC>Name='�Ǽ�'		     ID=WKCNT                HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center  edit=none  </FC> 
						">
			  </object>
			  </comment><script>__ws__(__NSID__);</script>   
		</td> 	
		<td class="tab32" style="width:660px;height:80px" ><nobr>&nbsp;
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gcgd_disp02  
					 style="position:relative;left:-1px;width:663px; height:80px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_mst">
						<PARAM NAME="IndWidth"		VALUE ='0'>
						<PARAM NAME="BorderStyle"   VALUE="0">
						<PARAM NAME="Fillarea"		    VALUE="true">
						<param name="Editable"          value="true">
						<PARAM NAME="Format"			VALUE=" 
						    <FC>Name='����'		     ID=CHK	                 HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center   EditStyle=CheckBox</FC> 
							<FC>Name='��ȣ'	         ID=WKNO       	         HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=center   edit=none  </FC> 
							<FC>Name='�ݾ�'		     ID=TAMT                   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	    edit=none  </FC> 
							<FC>Name='����'		     ID=REMARK              HeadAlign=Center HeadBgColor=#B9D4DC Width=412   align=left	    edit=none  </FC> 
						">
			  </object>
			  </comment><script>__ws__(__NSID__);</script>   
		</td> 	
  </tr>
   <tr>
        <td style="height:6px"  colspan=2>  </td>
   </tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr>
        <td style="height:20px" ><font size="2" color="blue"><B>*��ǥ������� ��</B></font></td>
   </tr>
	<tr> 
		<td class="tab32" style="width:800px;height:30px" ><nobr>&nbsp;
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
					 style="position:relative;left:-1px;width:860px; height:155px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_dtl">
						<PARAM NAME="IndWidth"		VALUE ='0'>
						<PARAM NAME="BorderStyle"   VALUE="0">
						<PARAM NAME="Fillarea"		    VALUE="true">
						<PARAM NAME="Sortview"		VALUE="left">
						<param name="ViewSummary" value=1>
						<param name="ColSizing"        value="true">
						<param name="Editable"          value="false">
						<param name="ColSelect"		value=false>
						<PARAM NAME="Format"			VALUE=" 
							<FC>Name='�����ڵ�'	 ID=ATCODE 	         HeadAlign=Center HeadBgColor=#B9D4DC Width=51       align=left	   edit=none  SumBgColor=#C3D0DB </FC> 
							<FC>Name='������'		 ID=ATKORNAM         HeadAlign=Center HeadBgColor=#B9D4DC Width=170	    align=left	   edit=none  SumBgColor=#C3D0DB SumText='��   ��'</FC> 
							<FC>Name='�����ݾ�'	 ID=CHAAMT 	         HeadAlign=Center HeadBgColor=#B9D4DC Width=95       align=right   edit=none  SumBgColor=#C3D0DB SumText=@sum  color =#0000FF  sumcolor =#0000FF</FC> 
							<FC>Name='�뺯�ݾ�'	 ID=DAEAMT 	         HeadAlign=Center HeadBgColor=#B9D4DC Width=95	    align=right   edit=none  SumBgColor=#C3D0DB SumText=@sum  color =#FF0000  sumcolor =#FF0000</FC> 
							<C> Name='������'	     ID=DOCUMCD 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=95	    align=left     edit=none  SumBgColor=#C3D0DB SumText='����-�뺯'  EditStyle=Combo Data='000:,101:���ݰ�꼭,102:��꼭,103:�ſ�ī��(����),104:���ݿ�����(����),201:�ſ�ī��(�Ұ�),202:���ְ���,203:���̿�����'</C> 
							<C> Name='����'			 ID=REMARK              HeadAlign=Center HeadBgColor=#B9D4DC Width=205	align=left	   edit=none  SumBgColor=#C3D0DB SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right </C> 
							<C> Name='����'		     ID=FSWRKDIV 	         HeadAlign=Center HeadBgColor=#B9D4DC Width=40	    align=center edit=none  SumBgColor=#C3D0DB EditStyle=Combo Data='01:������,02:����'</C> 
							<C> Name='�ŷ�ó'		 ID=FSRVALNM02 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left   edit=none  SumBgColor=#C3D0DB </C> 
							<C> Name='�μ�'		     ID=FSRVALNM01 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   edit=none  SumBgColor=#C3D0DB </C> 
							<C> Name='�����׸�3'   ID=FSRVALNM03 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
							<C> Name='�����׸�4'   ID=FSRVALNM04 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
							<C> Name='�����׸�5'   ID=FSRVALNM05 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
							<C> Name='�����׸�6'   ID=FSRVALNM06 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
							<C> Name='�����׸�7'   ID=FSRVALNM07 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
							<C> Name='�����׸�8'   ID=FSRVALNM08	      HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
							<C> Name='�����׸�9'   ID=FSRVALNM09 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
						">
			  </object></comment><script>__ws__(__NSID__);</script>   
		</td> 	
  </tr>
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 