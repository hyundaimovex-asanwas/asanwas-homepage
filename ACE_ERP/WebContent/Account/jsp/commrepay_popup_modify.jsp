<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �������� �˾�
+ ���α׷� ID	:  Commrepay_popup.html
+ �� �� �� ��	:  ����ó��
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2006.10.16
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
<title>��������</title>

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
get_cookdata();
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_fdcode="";
var gs_fsdat="";
var gs_fsnbr="";
var gs_seq="";
var gs_userid = gusrid;
var gs_banjaeyn = ""; //���� ����
var gs_save="N";      //����Ȯ��:�������� ���̺� ���� �ߴ��� Ȯ����. 
var gs_rechaamt=0 ;   //�׸��� 2�� �̻��϶� �������ִ� �ݾ�
var gs_redaeamt=0 ;   //�׸��� 2�� �̻��϶� �������ִ� �ݾ�
var gs_cnt=0;

var g_date_fr = gcurdate.substring(0,4)+"0101";
var g_gubun="N";   //������� ���� 
var strParam = new Array();
strParam=window.dialogArguments;

function  ln_Start(){
	  
    txt_custcd_fr.value= strParam.g_arrParam[2];
	txt_custnm_fr.value= strParam.g_arrParam[3];
	
	txt_atcode_fr.value= strParam.g_arrParam[0];
	txt_atcodenm_fr.value= strParam.g_arrParam[1];
	ln_Before();
	ln_Before2();

	gs_fdcode=strParam.g_arrParam[4];
	gs_fsdat=strParam.g_arrParam[5];
	gs_fsnbr=strParam.g_arrParam[6];
	gs_seq=strParam.g_arrParam[7];   //��ǥ���ȣ

    gclx_fsrefcd.bindcolval = strParam.g_arrParam[8]; 
	txt_fsrefcd_fr.value = strParam.g_arrParam[9]; 
	txt_fsrefnm_fr.value = strParam.g_arrParam[10]; 

    //�� ����� ������ǥ ��ȸ
	ln_Query(strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FDCODE"),
	         strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSDAT"),
			 strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSNBR"),
			 strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSSEQ"));

	//���� �Էµ� ������ǥ ��ȸ
	ln_Query2(strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FDCODE"),
	          strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSDAT"),
			  strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSNBR"),
			  strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSSEQ"));
}
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(p1,p2,p3,p4){
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s23?v_str1="+p1
																			+"&v_str2="+p2
																			+"&v_str3="+p3
																			+"&v_str4="+p4;
	//prompt("gcds_data01",gcds_data01.DataID);
	gcds_data01.Reset();
}

/******************************************************************************
	Description : �����Էµ�  ������ǥ ��ȸ
******************************************************************************/
function ln_Query2(p1,p2,p3,p4){
  var row="";
	ln_SetDataHeader2();
	//������ǥ���� �ݾװ� ����ǥ��ȣ/�ŷ�ó ������;
	for(i=1;i<=strParam.gcds_banjae.countrow;i++){
		if(p1==strParam.gcds_banjae.namevalue(i,"FDCODE")&&
		   p2==strParam.gcds_banjae.namevalue(i,"BTSDAT")&&
			 p4==strParam.gcds_banjae.namevalue(i,"BTSSEQ")
		  ){
			
			gcds_data02.addrow()
			row = gcds_data02.rowposition;
			gcds_data02.namevalue(row,"CHK")="T";
			gcds_data02.namevalue(row,"FDCODE")=strParam.gcds_banjae.namevalue(i,"FDCODE");
			gcds_data02.namevalue(row,"BTSDAT")=strParam.gcds_banjae.namevalue(i,"BTSDAT");
			gcds_data02.namevalue(row,"BTSNBR")=strParam.gcds_banjae.namevalue(i,"BTSNBR");
			gcds_data02.namevalue(row,"BTSSEQ")=strParam.gcds_banjae.namevalue(i,"BTSSEQ");
			gcds_data02.namevalue(row,"BJDEAMT")=strParam.gcds_banjae.namevalue(i,"BJDEAMT");
			gcds_data02.namevalue(row,"BJCRAMT")=strParam.gcds_banjae.namevalue(i,"BJCRAMT");
			
			for(j=1;j<=strParam.gcds_banjaemst.countrow;j++){
				if(strParam.gcds_banjaemst.namevalue(j,"FDCODE")==strParam.gcds_banjae.namevalue(i,"FDCODE")&&
					 strParam.gcds_banjaemst.namevalue(j,"TSDAT")==strParam.gcds_banjae.namevalue(i,"TSDAT")&&
					 strParam.gcds_banjaemst.namevalue(j,"TSNBR")==strParam.gcds_banjae.namevalue(i,"TSNBR")&&
					 strParam.gcds_banjaemst.namevalue(j,"TSSEQ")==strParam.gcds_banjae.namevalue(i,"TSSEQ")
					){
						gcds_data02.namevalue(row,"FDCODE")=strParam.gcds_banjaemst.namevalue(j,"FDCODE");
						gcds_data02.namevalue(row,"TSDAT")=strParam.gcds_banjaemst.namevalue(j,"TSDAT");
						gcds_data02.namevalue(row,"TSNBR")=strParam.gcds_banjaemst.namevalue(j,"TSNBR");
						gcds_data02.namevalue(row,"TSSEQ")=strParam.gcds_banjaemst.namevalue(j,"TSSEQ");
						gcds_data02.namevalue(row,"REMARK")=strParam.gcds_banjaemst.namevalue(j,"REMARK");
				}
			}//for j
		}//for i
	}
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Before(){
	//�����׸�[�˻�]
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050&v_str2=";  
	gcds_fsrefcd.Reset();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Before2(){
	gcds_code01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s0?v_str1="+txt_atcode_fr.value
	                                                                       +"&v_str2="+txt_atcodenm_fr.value
	                                                                       +"&v_str3=&v_str4=ATUSEYN"
																		   +"&v_str5=ATDEBTYN&v_str6="; 
	//prompt("",gcds_code01.DataID);
	gcds_code01.Reset();
}

/******************************************************************************
	Description : ���� ����������� �����.
******************************************************************************/
function ln_Repay_Cancel(){
  
   if(strParam.gclx_fsstat02.bindcolval=="Y"){
		alert("����Ϸ�� ��ǥ�Դϴ�.");
		return;
	}

	if(strParam.gclx_fsstat02.bindcolval=="R"){
		alert("�����û�� ��ǥ�Դϴ�.");
		return;
	}

   //2010.03.16 JYS : ��ҽ� üũ ....
   if (gcds_data01.countrow<=0) {
		alert("����� ���� �������� �ʽ��ϴ�.");
    return;
   }
	////////////////////////////////////////////


	if (confirm("���� ���������� ����Ͻðڽ��ϱ�?")){
	    ln_SetDataHeader();
        ln_Data();
		gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commrepay_t1?";
		//prompt('',gcds_cancel.text);
		gctr_data01.post();
		g_gubun="Y";
		ln_Query(strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FDCODE"),
				 strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSDAT"),
				 strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSNBR"),
				 strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSSEQ"));
	}
}

/******************************************************************************
	Description : �����Էµ� �������� �� ����������ǥ�� ����Ÿ �¿��� ������..
	              ���� �������� ���� ��ǥ�̹Ƿ� FSNBR�� �������� �ʴ´�.
******************************************************************************/
function ln_Repay_Cancel2(){

  if(strParam.gclx_fsstat02.bindcolval=="Y"){
		alert("����Ϸ�� ��ǥ�Դϴ�.");
		return;
	}

	//2010.03.16 JYS : ������ҽ� �����Ͱ� ������ ��츸 ����
  if(gcds_data02.countrow<=0){
    alert("����� ���� �������� �ʽ��ϴ�.");
    return;
  }
	/////////////////////////////////////////////////////////

	if(confirm("���� �Է��� ���������� �����Ͻðڽ��ϱ�?")){
    g_gubun="Y";
		gcds_data02.ClearAllMark();
		strParam.gcds_banjae.ClearAllMark();
		strParam.gcds_banjaemst.ClearAllMark();
		for(j=1;j<=gcds_data02.countrow;j++){
			 if(gcds_data02.namevalue(j,"CHK")=="T"){
				gcds_data02.MarkRows(j,j);
	
				//���� ���� MARK�ؼ� ������.
				//���� �������� ����Ÿ �̱� ������ BTSSEQ������ üũ ����.
			  for(k=1;k<=strParam.gcds_banjae.countrow;k++){
				  	//alert("k::"+k);
          			//alert("FDCODE:"+gcds_data02.namevalue(j,"FDCODE")+":"+strParam.gcds_banjae.namevalue(k,"FDCODE")+":");
					//alert("TSDAT"+gcds_data02.namevalue(j,"TSDAT")+":"+strParam.gcds_banjae.namevalue(k,"TSDAT")+":");
					//alert("TSNBR"+gcds_data02.namevalue(j,"TSNBR")+":"+strParam.gcds_banjae.namevalue(k,"TSNBR")+":");
					//alert("TSSEQ"+gcds_data02.namevalue(j,"TSSEQ")+":"+strParam.gcds_banjae.namevalue(k,"TSSEQ")+":");

					if(gcds_data02.namevalue(j,"FDCODE")==strParam.gcds_banjae.namevalue(k,"FDCODE")&&
					   gcds_data02.namevalue(j,"TSDAT")==strParam.gcds_banjae.namevalue(k,"TSDAT")&&
						 gcds_data02.namevalue(j,"TSNBR")==strParam.gcds_banjae.namevalue(k,"TSNBR")&&
						 gcds_data02.namevalue(j,"TSSEQ")==strParam.gcds_banjae.namevalue(k,"TSSEQ")&&
						 gcds_data02.namevalue(j,"BTSSEQ")==strParam.gcds_banjae.namevalue(k,"BTSSEQ")){
						 strParam.gcds_banjae.MarkRows(k,k);
						 //alert("k:"+k+":mark:"+strParam.gcds_banjae.RowMark(k)); 
					}
				}

				//���� MST ������.
				//gcds_banjae �� BTSSEQ �� gcds_banjaemst �� SEQ�� ������.
				for(s=1;s<=strParam.gcds_banjaemst.countrow;s++){
					if(gcds_data02.namevalue(j,"FDCODE")==strParam.gcds_banjaemst.namevalue(s,"FDCODE")&&
					   gcds_data02.namevalue(j,"TSDAT")==strParam.gcds_banjaemst.namevalue(s,"TSDAT")&&
						 gcds_data02.namevalue(j,"TSNBR")==strParam.gcds_banjaemst.namevalue(s,"TSNBR")&&
						 gcds_data02.namevalue(j,"TSSEQ")==strParam.gcds_banjaemst.namevalue(s,"TSSEQ")&&
						 gcds_data02.namevalue(j,"BTSSEQ")==strParam.gcds_banjaemst.namevalue(s,"SEQ")
					){
						strParam.gcds_banjaemst.MarkRows(s,s);
						//alert("s:"+s+":mark:"+strParam.gcds_banjaemst.RowMark(s)); 
					}
				}
			 }
	  }//for j  


    //tb_DataSet.MarkRows(j,j);
	  //prompt('gcds_data02',gcds_data02.text);
		//prompt('gcds_banjae',strParam.gcds_banjae.text);
		//prompt('gcds_banjaemst',strParam.gcds_banjaemst.text);
		gcds_data02.DeleteMarked();
		strParam.gcds_banjae.DeleteMarked();
		strParam.gcds_banjaemst.DeleteMarked();
	  //prompt('2gcds_data02',gcds_data02.text);
		//prompt('2gcds_banjae',strParam.gcds_banjae.text);
		//prompt('2gcds_banjaemst',strParam.gcds_banjaemst.text);
	}else{
		g_gubun="N";
	}
}

/******************************************************************************
	Description : ����Ÿ�� ��� ����.
******************************************************************************/
function ln_SetDataHeader(){
	
	if (gcds_cancel.countrow<1){
		var s_temp = "FDCODE:STRING,BTSDAT:STRING,BTSNBR:STRING,BTSSEQ:STRING,"
							 + "BJDEAMT:DECIAML,BJCRAMT:DECIAML,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,"
							 + "UPDT:STRING,UPID:STRING,CHK:STRING";
		gcds_cancel.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : ����Ÿ�� ��� ����.
******************************************************************************/
function ln_SetDataHeader2(){
	
	if (gcds_data02.countrow<1){
		var s_temp = "CHK:STRING,FDCODE:STRING,BTSDAT:STRING,BTSNBR:STRING,BTSSEQ:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,"
							 + "BJDEAMT:DECIAML,BJCRAMT:DECIAML,REMARK"
							 
		gcds_data02.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : ����Ÿ ����
******************************************************************************/
function ln_Data(){
  var row = 0;
	for(i=1;i<=gcds_data01.countrow;i++){
		
		
		gcds_cancel.addrow();
		row = gcds_cancel.rowposition;
		gcds_cancel.namevalue(row,"FDCODE")=gcds_data01.namevalue(i,"FDCODE");
		gcds_cancel.namevalue(row,"BTSDAT")=gcds_data01.namevalue(i,"BTSDAT");
		gcds_cancel.namevalue(row,"BTSNBR")=gcds_data01.namevalue(i,"BTSNBR");
		gcds_cancel.namevalue(row,"BTSSEQ")=gcds_data01.namevalue(i,"BTSSEQ");
		gcds_cancel.namevalue(row,"BJDEAMT")=gcds_data01.namevalue(i,"BJDEAMT");
		gcds_cancel.namevalue(row,"BJCRAMT")=gcds_data01.namevalue(i,"BJCRAMT");
		gcds_cancel.namevalue(row,"TSDAT")=gcds_data01.namevalue(i,"TSDAT");
		gcds_cancel.namevalue(row,"TSNBR")=gcds_data01.namevalue(i,"TSNBR");
		gcds_cancel.namevalue(row,"TSSEQ")=gcds_data01.namevalue(i,"TSSEQ");
		gcds_cancel.namevalue(row,"UPDT")=gs_date;
        gcds_cancel.namevalue(row,"UPID")=gs_userid; 
	
	}
}

/******************************************************************************
	Description : Ȯ�ι�ư
******************************************************************************/
function ln_Close(){
  /** 2010.03.16 ln_unload�� �ű�
  //�ŷ�ó ����Ÿ clear
	if(g_gubun=="Y"){
		strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSREFVAL02")="";
		strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSRVALNM02")="";
		strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"BANJAEMOD")="Y";
	}else{
    strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"BANJAEMOD")="N";
	}
	**/
	window.close();
}

/******************************************************************************
	Description : �˾� unload�� 2010.03.16 jys �ű��߰� 
******************************************************************************/
function ln_unLoad(){

	if(g_gubun=="Y"){
		strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSREFVAL02")="";
		strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSRVALNM02")="";
		strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"BANJAEMOD")="Y";
	}else{
    strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"BANJAEMOD")="N";
	}

}

/******************************************************************************
	Description : ���� �ٿ�ε� 
******************************************************************************/
function ln_Excel(){
		if (gcds_data01.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.GridToExcel("������� ������ǥ","",2);
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- �� ����� ������ȸ -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--���� �Է��� ������ǥ ��ȸ -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �������� -->
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������� -->
<comment id="__NSID__"><object  id=gcds_cancel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object  id=gcds_fsrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<PARAM NAME=SortExpr	value="+CDNAM">
</object></comment><script>__ws__(__NSID__);</script> <!--�����׸�-->


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="commrepay_t1(I:USER=gcds_cancel)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
	if(gcds_data01.countrow<=0){
		//alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}else{
		//2007.06.28 �߰��� ����
		if(gcds_data01.namevalue(row,"VENDCD")=="I12566"){
      gcgd_disp01.ColumnProp("REFVALNM2", "Show") = "true";
			gcgd_disp01.ColumnProp("REFVAL2", "Show") = "false";
			gcgd_disp01.ColumnProp("REFVALNM2","Name")="�ŷ�ó";
		}else{
			gcgd_disp01.ColumnProp("REFVALNM2", "Show") = "false";
			gcgd_disp01.ColumnProp("REFVAL2", "Show") = "true";
			gcgd_disp01.ColumnProp("REFVALNM2","Name")="�����׸�2";
		}		
	}

	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<!-- �����׸� -->
<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	gcds_fsrefcd.InsertRow(1);
	gcds_fsrefcd.NameValue(1,"CDCODE")="";
	gcds_fsrefcd.NameValue(1,"CDNAM")="";
	gclx_fsrefcd.index=0;
</script>

<!-- �����׸� -->
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">

 /// alert("row::"+row);
	
	if(gcds_code01.countrow>0){
		gclx_fsrefcd.bindcolval = gcds_code01.namevalue(gcds_code01.rowposition,"FSREFCD");
		gclx_fsrefcd.Enable = false;
	}else{
    gclx_fsrefcd.Enable = true;
	}
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
	g_gubun="Y";
	strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSREFVAL02")="";
	strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"FSRVALNM02")="";
	strParam.gcds_dtl.namevalue(strParam.gcds_dtl.rowposition,"BANJAEMOD")="Y";
</script>

<script language=JavaScript for=gctr_data01 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	g_gubun="N";
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
		 <!--  <img src="../../common/img/btn/com_b_close.gif"	  style="cursor:hand" onClick="ln_Close()" > -->
			<img src="../../Common/img/btn/com_btn_send.gif"	  style="cursor:hand" onClick="ln_Close()" >
			<!-- <img src="../../common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()"> -->
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;��������&nbsp;</nobr></td>
		<td class="tab18" style="width:800px;height:30px" ><nobr>&nbsp;
			<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:90px; height:20px;" maxlength="7" onBlur="bytelength(this,this.value,36);">
			<!-- <img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','fr');"> -->
			<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);">
			</nobr>
		</td> 	
		<td class="tab18" width="70px"  height="30px" style="" bgcolor="#eeeeee"  align=center ><nobr>&nbsp;&nbsp;�ŷ�ó&nbsp;</nobr></td>
		<td class="tab18" height="30px" style="width:800px;"><nobr>&nbsp;
			<input id="txt_custcd_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:90px; height:20px;" maxlength="13" onBlur="bytelength(this,this.value,36);">
			<!-- <img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�з��ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px" align=center onclick="ln_Popup('02','fr');"> -->
			<input id="txt_custnm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);">
			</nobr>
		</td> 
  </tr>

	<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;�����׸�&nbsp;</nobr></td>
			<td class="tab19" style="width:800px;height:30px">
			<nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:3px;top:6px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_fsrefcd">
						<param name=CBDataColumns	 value="CDCODE,CDNAM">
						<param name=SearchColumn	 value=CDNAM>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="CDNAM^0^180">								
						<param name=BindColumn		 value="CDCODE">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;
				<input id="txt_fsrefnm_fr" type="text" class="txtbox"  style= "position:relative;top:1px;left:-4px;width:155px; height:20px;ime-mode:active; " maxlength="36" onkeydown="ln_Blur('01','fsref_fr','txt_fsrefnm_fr')">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����׸��� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px; height:20px" align=center onclick="";"> 
				<input id="txt_fsrefcd_fr" type="text" class="txtbox"  style= "position:relative;top:2px;left:-4px;width:60px; height:20px;" maxlength="8" onkeydown="ln_Blur('01','fsref_fr','txt_fsrefcd_fr')"><!-- ~&nbsp; -->
			 <!--  <img src="../../common/img/btn/com_b_choice.gif"		style="cursor:hand;position:relative;top:6px;left:0px" onClick="ln_Popup_Choice('02')">  -->
				</nobr>
			</td> 	
			<td class="tab19" width="70px"  height="30px" style="" bgcolor="#eeeeee"  align=center ><nobr>&nbsp;&nbsp;�Ⱓ&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:250px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_actdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_actdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
	</tr>
	<tr>
		<td height=7  colspan =4> </td>
  </tr>
</table>

<fieldset id=field1 style="position:absolute;top:142px;left:4px;height:310px;width:860px;bacground-color:#708090"></fieldset>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td height="35px" style="cursor:hand;position:relative;top:-3px;">&nbsp; �� ����� ������ǥ
		  <img src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand;position:relative;left:620px;top:5px" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_btn_repay_cancel.gif"   style="cursor:hand;position:relative;left:620px;top:5px" onclick="ln_Repay_Cancel()">
		</td>
  </tr>
	<tr> 
		<td>
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:5px;width:850px; height:120px; border:1 solid #708090;display:block;" viewastext>
				<PARAM NAME="DataID"			VALUE="gcds_data01">
				<PARAM NAME="IndWidth"		VALUE ='0'>
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<PARAM NAME="Sortview"		VALUE="left">
				<param name="ColSizing"   value="true">
				<param name=MultiRowSelect	value=true>
				<param name="Editable"    value="FALSE">
				<param name="ViewSummary"	value=1>
				<PARAM NAME="Format"			VALUE="              
				<FC> Name='����'		  ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center SumBgColor=#C3D0DB editstyle=checkbox  VALUE={'T'}</FC> 
				<FC> Name='No'		    ID=Currow 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center SumBgColor=#C3D0DB edit=none Value={CurRow} </C> 
				<FC> Name='��ǥ��ȣ'	ID=SSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center SumBgColor=#C3D0DB edit=none SumText='��   ��' </FC> 
				<FC> Name='�ۼ���ȣ'	ID=SSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center SumBgColor=#C3D0DB edit=none SumText='��   ��' show=false</FC> 
				<FC> Name='����'			ID=FSNUM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=28    align=center SumBgColor=#C3D0DB edit=none </FC> 
				<C> Name='��������'		ID=BJDEAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	 SumBgColor=#C3D0DB edit=none SumText=@sum color=#0000FF </C> 
				<C> Name='�����뺯'		ID=BJCRAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right  SumBgColor=#C3D0DB edit=none SumText=@sum color=#FF0000</C> 
				<C> Name='REMARK'		  ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=195	  align=reft   SumBgColor=#C3D0DB edit=none show=false</C> 
				<C> Name='����'		    ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=195	  align=reft   SumBgColor=#C3D0DB edit=none </C> 
				<C> Name='�ŷ�ó'		  ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=reft   SumBgColor=#C3D0DB edit=none </C> 
				<C> Name='�����׸�'		ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=121	  align=reft   SumBgColor=#C3D0DB edit=none </C> 
				<C> Name='�Է�����'	  ID=REFVAL2 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=reft   SumBgColor=#C3D0DB edit=none Mask='XXXX/XX/XX' </C> 
				<C> Name='�����׸�'	  ID=REFVALNM2 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=reft   SumBgColor=#C3D0DB edit=none  </C> 
				">

			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="position:relative;left:5px;width:852px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
	</tr>
  <tr>
		<td height="35px">&nbsp; ���� �Էµ� ������ǥ 
			<img src="../../Common/img/btn/com_btn_repay_cancel.gif"   style="cursor:hand;position:relative;left:655px;top:6px" onclick="ln_Repay_Cancel2()">
		</td>
  </tr>
	<tr> 
		<td>
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			style="position:relative;left:5px;width:850px; height:120px; border:1 solid #708090;display:block;" viewastext>
				<PARAM NAME="DataID"			VALUE="gcds_data02">
				<PARAM NAME="IndWidth"		VALUE ='0'>
				<param name="Enable"      value="True">
				<param name="Editable"    value="true">
				<param name="ColSizing"   value="true">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name=ColSelect		value=false>
		    <param name=MultiRowSelect	value=true>
				<param name="ViewSummary"	value=1>
				<PARAM NAME="Format"			VALUE="              
				<C> Name='����'		  ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center SumBgColor=#C3D0DB EditStyle=CheckBox  </C> 
				<C> Name='No'		    ID=Currow 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center SumBgColor=#C3D0DB edit=none Value={CurRow} </FC> 
				<C> Name='��ǥ��ȣ'	ID=TSDAT     HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center SumBgColor=#C3D0DB edit=none SumText='��   ��' </C> 
				<C> Name='��ǥ��ȣ'	ID=TSNBR     HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center SumBgColor=#C3D0DB edit=none </C> 
				<C> Name='��������'		ID=BJDEAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	 SumBgColor=#C3D0DB edit=none SumText=@sum color=#0000FF </C> 
				<C> Name='�����뺯'		ID=BJCRAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right  SumBgColor=#C3D0DB edit=none SumText=@sum color=#FF0000</C> 
				<C> Name='REMARK'		  ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=430	  align=reft   SumBgColor=#C3D0DB edit=none </C> 
				">
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
</table>
<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 