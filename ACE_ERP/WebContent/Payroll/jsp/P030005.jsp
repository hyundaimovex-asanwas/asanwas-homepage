<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-----------------------------------------------------------------------------
+ �� �� �� ��	:	�����������-�������곻����ȸ
+ ���α׷� ID	: P030005.HTML
+ �� �� �� ��	: ��ȸ,���
+ �� �� �� ��	: 
+ �� �� �� ��	: p030005_s1 (P030002.HTML�� �������) 
------------------------------------------------------------------------------
+ �� �� �� ��  :	��¹� �߰�  
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2007. 1
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
	gcem_curdt.text = "2009" ;//gcurdate.substring(0,4);	//�ͼӳ⵵

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

  //2009.02.19
	
  if(gcds_manager.countrow>0){ //������ ����
	
	}else{
	  /*
	  if(txt_empno1.value !='2040046'){
			alert("�������� ��ȸ�Ⱓ�� �ƴմϴ�.");
			return false;
		}
		*/
    if (gusrid=="2100001") txt_empno1.value="3070015";
		if (gusrid=="2100002") txt_empno1.value="3040038";
		if (gusrid=="2100003") txt_empno1.value="3070034";
		if (gusrid=="2100004") txt_empno1.value="3050022";
	}
	


	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s1?v_str1=" + gcem_curdt.text+"12"
									  + "&v_str2=" + gclx_deptcd.bindcolval
									  + "&v_str3=" + fn_trim(txt_empnmk1.value)
									  + "&v_str4=" + gs_level
									  + "&v_str5=" + gs_treecd
										+ "&v_str6=" + gcem_curdt.text
										+ "&v_str7=" + txt_empno1.value;
	//prompt('',gcds_data.DataID);
	gcds_data.Reset(); 

}

function ln_Query02(p) {

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s4?v_str1=" + gcem_curdt.text+"12"
									  + "&v_str2=" + gclx_deptcd.bindcolval
									  + "&v_str3=" + fn_trim(txt_empnmk1.value)
									  + "&v_str4=" + p;

//	prompt('',gcds_data2.DataID);

	gcds_data2.Reset(); 

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

		var ls_temp = "";
		var ls_temp1 = "";
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
//3PAGE �κ��� �����ͼ� ��� ���� , �������� �κи� ��ȸ�Ͽ� ������ ������ . 
			ls_temp1 ="EMPNO:STRING,APPDT:STRING,RELAT1:STRING,FAMNM1:STRING,RESINO1:STRING,RESINO:STRING,"
				 + "REF1:STRING,REF2:STRING,REF3:STRING,REF4:STRING,REF5:STRING,REF6:STRING,REF7:STRING,REF8:STRING,JUMIN:STRING,"
				 + "REF11:DECIMAL,REF12:DECIMAL,REF13:DECIMAL,REF14:DECIMAL,REF15:DECIMAL,REF16:DECIMAL,"
				 + "REF21:DECIMAL,REF22:DECIMAL,REF23:DECIMAL,REF24:DECIMAL,REF25:DECIMAL,REF26:DECIMAL,AD0106CNT:DECIMAL,"
				 + "PCNT:DECIMAL,TCNT:DECIMAL,"
				 + "TREF11:DECIMAL,TREF12:DECIMAL,TREF13:DECIMAL,TREF14:DECIMAL,TREF15:DECIMAL,TREF16:DECIMAL,"
				 + "TREF21:DECIMAL,TREF22:DECIMAL,TREF23:DECIMAL,TREF24:DECIMAL,TREF25:DECIMAL,TREF26:DECIMAL";
			gcds_print1.SetDataHeader(ls_temp1);
      

		//20060112 ������ �߰�
		gs_date = gcem_curdt.text;
		gs_date4=Number(gcem_curdt.text)+1;
      
		 var iccnt = 0; /*2010.01.26 �̻�� ���ϳ� */
		for (j=1;j<=gcds_data.countrow;j++) {
		    iccnt = 1;
			gcds_print.Addrow();
			gcds_print.namevalue(j,"HTITLE") = "(������ �����)";
			gcds_print.namevalue(j,"CURDT")  = gcem_curdt.text+"1231" //20100126 ���ϳ��߰�, �ٹ�������
			gcds_print.namevalue(j,"CURDT2") = gs_date4; 
	

			//gcds_print1.Addrow();
			
			ln_Query02(gcds_data.namevalue(j,"EMPNO"));

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
				//alert("AD0106CNT"+gcds_data2.namevalue(aa,"AD0106CNT"));
				
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

				/*
				gcds_print1.namevalue(row,"REF1") = gcds_data2.namevalue(aa,"REF1");
				gcds_print1.namevalue(row,"REF2") = gcds_data2.namevalue(aa,"REF2");
				gcds_print1.namevalue(row,"REF3") = gcds_data2.namevalue(aa,"REF3");
				gcds_print1.namevalue(row,"REF4") = gcds_data2.namevalue(aa,"REF4");
				gcds_print1.namevalue(row,"REF5") = gcds_data2.namevalue(aa,"REF5");
				gcds_print1.namevalue(row,"REF6") = gcds_data2.namevalue(aa,"REF6");
				gcds_print1.namevalue(row,"REF7") = gcds_data2.namevalue(aa,"REF7");
				*/

				for (var d=1; d<7; d++) {             //�������� ���� �ҵ�����׸�� 
					var nm1 = "REF1"+d;
					var nm2 = "REF2"+d;
					gcds_print1.namevalue(row,nm1) = gcds_data2.namevalue(aa,nm1);
					gcds_print1.namevalue(row,nm2) = gcds_data2.namevalue(aa,nm2);
				}
			/*	gcds_print1.namevalue(row,"PCNT")  = iccnt; 2010.01.26 �̻�� ���ϳ� */

				if (aa==1) {
				var tcnt = gcds_data2.countrow+1;
					
					gcds_print1.namevalue(row,"TREF11")  = gcds_data2.sum(12,0,tcnt);
					gcds_print1.namevalue(row,"TREF12")  = gcds_data2.sum(13,0,tcnt);
					gcds_print1.namevalue(row,"TREF13")  = gcds_data2.sum(14,0,tcnt);
					gcds_print1.namevalue(row,"TREF14")  = gcds_data2.sum(15,0,tcnt);
					gcds_print1.namevalue(row,"TREF15")  = gcds_data2.sum(16,0,tcnt);
					gcds_print1.namevalue(row,"TREF16")  = gcds_data2.sum(17,0,tcnt);
					gcds_print1.namevalue(row,"TREF21")  = gcds_data2.sum(18,0,tcnt);
					gcds_print1.namevalue(row,"TREF22")  = gcds_data2.sum(19,0,tcnt);
					gcds_print1.namevalue(row,"TREF23")  = gcds_data2.sum(20,0,tcnt);
					gcds_print1.namevalue(row,"TREF24")  = gcds_data2.sum(21,0,tcnt);
					gcds_print1.namevalue(row,"TREF25")  = gcds_data2.sum(22,0,tcnt);
					gcds_print1.namevalue(row,"TREF26")  = gcds_data2.sum(23,0,tcnt);

					gcds_print1.namevalue(row,"AD0106CNT") = gcds_data2.namevalue(aa,"AD0106CNT");
				    
				}
				iccnt++;
			}//END I FOR

			var icc = 11 - gcds_data2.countrow;
			for (var s=1;s<=icc;s++) {
				gcds_print1.addrow();
			/*	var rr = gcds_print1.rowposition;
				gcds_print1.namevalue(rr,"PCNT")  = iccnt; 2010.01.26 �̻�� ���ϳ� */

	
				iccnt++;
			} 
		}//END J FOR

		//prompt('', gcds_print1.text);
    if(gcds_manager.countrow>0){ 	//������ 

		 // prompt('', gcds_print.text);
		 // prompt('', gcds_print1.text);
		  //�ӽø���.
			//////gcrp_print.preview();		//(������ �����)

			for (j=1;j<=gcds_data.countrow;j++) {
				gcds_print.namevalue(j,"HTITLE") = "(������ ������)";
			}
			gcrp_print2.preview();	//(������ ������)

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

			gcrp_print3.preview();	//(�ҵ��� ������)
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
<comment id="__NSID__"><object id="gcds_data" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="usechangeinfo" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �Ҽ� �˻�-->
<comment id="__NSID__"><object id=gcds_dept1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</object></comment><script>__ws__(__NSID__);</script>

<!-- �Ҽ� BIND-->
<comment id="__NSID__"><object id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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
								<C> Name='�⵵' ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	Mask='XXXX'</C> 
								<C> Name='�Ҽ�'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT		sort=true</C> 
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
								<comment id="__NSID__"><object id=gcem_APPDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
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
								<comment id="__NSID__"><object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt; " > 
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
								<input id="txt_deptnm" name="txt_deptnm" type="text"  class="txtbox" style="width:70px; height:18px;position:relative;left:-6px" maxlength=16 disabled></td>
							</td>
							<td class ="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;����</td>
							<td class ="tab21" style="" colspan=2>&nbsp;
								<input id="txt_paygrdnm" name="txt_paygrdnm" type="text"  class="txtbox"  style= "width:70px; height:18px; position:relative;left:-6px" value="" maxlength=16 disabled></td>
							</td>
							<td class ="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;ȣ��</td>
						  <td class ="tab21" style="" colspan=2>&nbsp;
								<input id="txt_payseqnm" name="txt_payseq" type="text"  class="txtbox"  style= "width:70px; height:18px; position:relative;left:-6px" value="" maxlength=16 disabled></td>
			
						</tr>
						<tr>
						<td class ="tab30" style="height:25px;" bgcolor="#eeeeee">&nbsp;�Ի�����</td>
						<td class ="tab21" style="" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
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
							<comment id="__NSID__"><object id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; "  >
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
							<comment id="__NSID__"><object id=gcem_pc11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px;height:20px;font-family:����;font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bc11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bc21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pbc1000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
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
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28"><nobr>
							<comment id="__NSID__"><object id=gcem_bc12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bc22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pbc2000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;������</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_bc13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bc23000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pbc3000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#DCDCDC">&nbsp;��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bc10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bc20000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
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
							<comment id="__NSID__"><object id=gcem_4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_twksum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
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
								<param name=enable				value=false>
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
								<param name=enable				value=false>
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
								<param name=enable				value=false>
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
								<param name=enable				value=false>
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�ٷμҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb20000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ٷμҵ�ݾ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb30000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
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
							<comment id="__NSID__"><object id=gcem_baamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_baamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�ξ簡��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_baamt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;��ο��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�γ���</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�ڳ������</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;���.�Ծ���</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt07 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;���ڳ��߰�����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;���ο��ݺ�������&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pensum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab24" bgcolor="#B9D4DC"><nobr>&nbsp;�������ݺ�������&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_spcsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_inssum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�Ƿ��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_medsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;������</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_edusum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�����������Ա�<br>&nbsp;�����ݻ�ȯ��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt02s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;�����������<br>&nbsp;���Ա����ڻ�ȯ��</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt34s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;���ø���<br>&nbsp;����ҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt01s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>

						<td class="tab27" bgcolor="#eeeeee">&nbsp;��α�</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_consum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;ȥ���̻����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_marsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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

						<td class="tab28" bgcolor="#eeeeee">&nbsp;ǥ�ذ���</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_stdsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;�����ҵ�ݾ�&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_offsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
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
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;��Ư�ҵ����</nobr></td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#DCDCDC">&nbsp;��Ư�ҵ������</td>
						<td class="tab14" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;���ο���<br>&nbsp;����ҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt011s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee">&nbsp;��������<br>&nbsp;�ҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt01s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;��������<br>&nbsp;���ڼҵ����</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcsum02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;�ſ�ī�� ��<br>&nbsp;�ҵ����</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt03s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;�츮����<br>&nbsp;���ռҵ����</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etdamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;����ֽ���<br>&nbsp;����ҵ����</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_fndsums classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;���ռҵ����ǥ��&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_tstdsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_stdtax classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_redsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ҵ漼��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_redamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;����Ư�����ѹ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_redamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_dedsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ٷμҵ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�������հ���</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�������Ա�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ܱ��γ���</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�����ġ�ڱ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;��������&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb40000_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_pb41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px;height:20px;font-family:����;font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_pb42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_pb40000_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;���ٹ���<br>&nbsp;�ⳳ�μ���</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb51000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28"><nobr>
							<comment id="__NSID__"><object id=gcem_pb52000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb53000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_pb50000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;���ٹ�����<br>&nbsp;���μ���</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb61000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_pb62000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb63000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_pb60000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;����¡������</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb71000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_pb72000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb73000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_pb70000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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

<!--

						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_strtdt1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_enddt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_strtdt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;" > 
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
							<comment id="__NSID__"><object id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; "  >
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
			
	<C>Col=STRTDT1		Ctrl=gcem_strtdt1   Param=Text</C>
			<C>Col=ENDDT1		Ctrl=gcem_enddt1    Param=Text</C>
			<C>Col=BP141000		Ctrl=gcem_bp141000   Param=Text</C>
			<C>Col=BP142000		Ctrl=gcem_bp142000   Param=Text</C>
			<C>Col=BP143000		Ctrl=gcem_bp143000   Param=Text</C>
			<C>Col=STRTDT2		Ctrl=gcem_strtdt2   Param=Text</C>
			<C>Col=ENDDT2		Ctrl=gcem_enddt2    Param=Text</C>
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
			<C>Col=APPDT		Ctrl=gcem_APPDT			Param=Text</C>
			<C>Col=EMPNO		Ctrl=gcem_empno     Param=Text</C>
			<C>Col=EMPNMK		Ctrl=txt_empnmk2    Param=Value</C>
			<C>Col=DEPTNM		Ctrl=txt_deptnm     Param=Value</C>
			<C>Col=PAYGRDNM		Ctrl=txt_paygrdnm   Param=Value</C>
			<C>Col=PAYSEQNM		Ctrl=txt_payseqnm   Param=Value</C>
			<C>Col=STRTDT		Ctrl=gcem_strtdt    Param=Text</C>
			<C>Col=ENDDT		Ctrl=gcem_enddt     Param=Text</C>
			<C>Col=PC11000		Ctrl=gcem_pc11000   Param=Text</C>
			<C>Col=PC12000		Ctrl=gcem_pc12000   Param=Text</C>
			<C>Col=PC13000		Ctrl=gcem_pc13000   Param=Text</C>
			<C>Col=PC10000		Ctrl=gcem_pc10000   Param=Text</C>
			<C>Col=BC11000		Ctrl=gcem_bc11000   Param=Text</C>
			<C>Col=BC12000		Ctrl=gcem_bc12000   Param=Text</C>
			<C>Col=BC13000		Ctrl=gcem_bc13000   Param=Text</C>
			<C>Col=BC10000		Ctrl=gcem_bc10000   Param=Text</C>
			<C>Col=BC21000		Ctrl=gcem_bc21000   Param=Text</C>
			<C>Col=BC22000		Ctrl=gcem_bc22000   Param=Text</C>
			<C>Col=BC23000		Ctrl=gcem_bc23000   Param=Text</C>
			<C>Col=BC20000		Ctrl=gcem_bc20000   Param=Text</C>
			<C>Col=PBC1000		Ctrl=gcem_pbc1000   Param=Text</C>
			<C>Col=PBC2000		Ctrl=gcem_pbc2000   Param=Text</C>
			<C>Col=PBC3000		Ctrl=gcem_pbc3000   Param=Text</C>
			<C>Col=TWKSUM		Ctrl=gcem_twksum    Param=Text</C>
			<C>Col=PC21000		Ctrl=gcem_pc21000   Param=Text</C>
			<C>Col=PC22000		Ctrl=gcem_pc22000   Param=Text</C>
			<C>Col=PC23000		Ctrl=gcem_pc23000   Param=Text</C>
			<C>Col=PC20000		Ctrl=gcem_pc20000   Param=Text</C>
			<C>Col=PB10000		Ctrl=gcem_pb10000   Param=Text</C>
			<C>Col=PB20000		Ctrl=gcem_pb20000   Param=Text</C>
			<C>Col=PB30000		Ctrl=gcem_pb30000   Param=Text</C>
			<C>Col=BAAMT01		Ctrl=gcem_baamt01   Param=Text</C>
			<C>Col=BAAMT02		Ctrl=gcem_baamt02   Param=Text</C>
			<C>Col=BAAMT03		Ctrl=gcem_baamt03   Param=Text</C>
			<C>Col=ADAMT01		Ctrl=gcem_adamt01   Param=Text</C>
			<C>Col=ADAMT02		Ctrl=gcem_adamt02   Param=Text</C>
			<C>Col=ADAMT03		Ctrl=gcem_adamt03   Param=Text</C>
			<C>Col=ADAMT04		Ctrl=gcem_adamt04   Param=Text</C>
			<C>Col=ADAMT05S		Ctrl=gcem_adamt05   Param=Text</C>
			<C>Col=PENSUMS		Ctrl=gcem_pensum    Param=Text</C>
			<C>Col=INSSUM		Ctrl=gcem_inssum    Param=Text</C>
			<C>Col=MEDSUM		Ctrl=gcem_medsum    Param=Text</C>
			<C>Col=EDUSUM		Ctrl=gcem_edusum    Param=Text</C>
			<C>Col=CONSUM		Ctrl=gcem_consum    Param=Text</C>
			<C>Col=MARSUM		Ctrl=gcem_marsum    Param=Text</C>
			<C>Col=SPCSUM		Ctrl=gcem_spcsum    Param=Text</C>
			<C>Col=STDSUM		Ctrl=gcem_stdsum    Param=Text</C>
			<C>Col=OFFSUM	    Ctrl=gcem_offsum    Param=Text</C>
			<C>Col=ETCAMT011S   Ctrl=gcem_etcamt011s Param=Text</C>
			<C>Col=ETCAMT01S    Ctrl=gcem_etcamt01s  Param=Text</C>
			<C>Col=ETCAMT02     Ctrl=gcem_etcsum02  Param=Text</C>
			<C>Col=ETCAMT03S    Ctrl=gcem_etcamt03s  Param=Text</C>
			<C>Col=ETCAMT04     Ctrl=gcem_etdamt04  Param=Text</C>
			<C>Col=ETCSUM       Ctrl=gcem_etcsum    Param=Text</C>
			<C>Col=TSTDSUM      Ctrl=gcem_tstdsum   Param=Text</C>
			<C>Col=STDTAX       Ctrl=gcem_stdtax    Param=Text</C>
			<C>Col=REDAMT01S    Ctrl=gcem_redamt01  Param=Text</C>
			<C>Col=REDAMT02S    Ctrl=gcem_redamt02  Param=Text</C>
			<C>Col=REDSUM       Ctrl=gcem_redsum    Param=Text</C>
			<C>Col=DEDAMT01S	Ctrl=gcem_dedamt01  Param=Text</C>
			<C>Col=DEDAMT02S	Ctrl=gcem_dedamt02  Param=Text</C>
			<C>Col=DEDAMT03S	Ctrl=gcem_dedamt03  Param=Text</C>
			<C>Col=DEDAMT04S	Ctrl=gcem_dedamt04  Param=Text</C>
			<C>Col=DEDAMT05S	Ctrl=gcem_dedamt05  Param=Text</C>
			<C>Col=DEDSUM		Ctrl=gcem_dedsum    Param=Text</C>
			<C>Col=PB40000		Ctrl=gcem_pb40000_1 Param=Text</C>
			<C>Col=PB40000		Ctrl=gcem_pb40000_2 Param=Text</C>
			<C>Col=PB41000		Ctrl=gcem_pb41000   Param=Text</C>
			<C>Col=PB42000		Ctrl=gcem_pb42000   Param=Text</C>
			<C>Col=PB43000		Ctrl=gcem_pb43000   Param=Text</C>
			<C>Col=PB51000		Ctrl=gcem_pb51000   Param=Text</C>
			<C>Col=PB52000		Ctrl=gcem_pb52000   Param=Text</C>
			<C>Col=PB53000		Ctrl=gcem_pb53000   Param=Text</C>
			<C>Col=PB50000		Ctrl=gcem_pb50000   Param=Text</C>
			<C>Col=PB61000		Ctrl=gcem_pb61000   Param=Text</C>
			<C>Col=PB62000		Ctrl=gcem_pb62000   Param=Text</C>
			<C>Col=PB63000		Ctrl=gcem_pb63000   Param=Text</C>
			<C>Col=PB60000		Ctrl=gcem_pb60000   Param=Text</C>
			<C>Col=PB71000		Ctrl=gcem_pb71000   Param=Text</C>
			<C>Col=PB72000		Ctrl=gcem_pb72000   Param=Text</C>
			<C>Col=PB73000		Ctrl=gcem_pb73000   Param=Text</C>
			<C>Col=PB70000		Ctrl=gcem_pb70000   Param=Text</C>
			<C>Col=ADAMT07		Ctrl=gcem_adamt07   Param=Text</C>
			<C>Col=HOUAMT02S	Ctrl=gcem_houamt02s  Param=Text</C>
			<C>Col=HOUAMT34S	Ctrl=gcem_houamt34s Param=Text</C>
			<C>Col=HOUAMT01S	Ctrl=gcem_houamt01s  Param=Text</C>
			<C>Col=FNDSUMS		Ctrl=gcem_fndsums   Param=Text</C>
			<C>Col=ETCAMT05		Ctrl=gcem_etcamt05   Param=Text</C>
			<C>Col=BTAXAMT101	Ctrl=gcem_btaxamt01  Param=Text</C>
	
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ� �� : �ٷμҵ��õ¡�������� REPORT
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
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
	<T>id='210��x297��(�Ϲݿ��� 60g/��)' ,left=1206 ,top=2663 ,right=1848 ,bottom=2705 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��1��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1719 ,top=319 ,right=1719 ,bottom=361 </L>
	<L> left=1293 ,top=232 ,right=1830 ,bottom=232 </L>
	<T>id='��1 / ��2' ,left=1585 ,top=279 ,right=1827 ,bottom=314 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ֱ���' ,left=1303 ,top=195 ,right=1514 ,bottom=227 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������1 / �������2' ,left=1530 ,top=195 ,right=1827 ,bottom=227 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ܱ���' ,left=1303 ,top=240 ,right=1514 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=274 ,right=1830 ,bottom=274 </L>
	<T>id='�ܱ��δ��ϼ�������' ,left=1303 ,top=279 ,right=1572 ,bottom=314 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=319 ,right=1830 ,bottom=319 </L>
	<T>id='��������' ,left=1303 ,top=324 ,right=1422 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=361 ,right=1830 ,bottom=361 </L>
	<T>id='������1 / �ܱ���9' ,left=1530 ,top=240 ,right=1827 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������ڵ�' ,left=1530 ,top=324 ,right=1709 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=187 ,right=1830 ,bottom=187 </L>
	<L> left=1293 ,top=187 ,right=1293 ,bottom=361 </L>
	<T>id='[���� ��24ȣ ����(1)]  ' ,left=29 ,top=90 ,right=1438 ,bottom=150 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=380 ,right=1851 ,bottom=380 </L>
	<C>id='HTITLE', left=629, top=298, right=1048, bottom=340, face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ٷμҵ� ���޸���' ,left=598 ,top=240 ,right=1216 ,bottom=287 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷμҵ��õ¡��������' ,left=598 ,top=187 ,right=1216 ,bottom=235 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=550 ,top=243 ,right=579 ,bottom=277 ,border=true</X>
	<X>left=550 ,top=192 ,right=579 ,bottom=227 ,border=true</X>
	<T>id='����' ,left=71 ,top=190 ,right=184 ,bottom=229 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=71 ,top=232 ,right=184 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCNT', left=303, top=190, right=390, bottom=269, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2009 -' ,left=205 ,top=190 ,right=321 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=185 ,right=192 ,bottom=274 </L>
	<T>id='(���� �Ǵ� ��)' ,left=1482 ,top=2550 ,right=1748 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2418 ,right=1851 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1522 ,top=187 ,right=1522 ,bottom=274 </L>
	<L> left=1830 ,top=190 ,right=1830 ,bottom=361 </L>
	<L> left=1577 ,top=274 ,right=1577 ,bottom=319 </L>
	<L> left=1527 ,top=319 ,right=1527 ,bottom=361 </L>
	<L> left=29 ,top=672 ,right=1851 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�켺��' ,left=221 ,top=564 ,right=508 ,bottom=609 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�Ϲ�ȣ' ,left=221 ,top=446 ,right=508 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� �� �� (�ּ�)' ,left=221 ,top=501 ,right=508 ,bottom=546 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ּ�' ,left=221 ,top=620 ,right=508 ,bottom=664 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� ǥ �� (��     ��)' ,left=1014 ,top=388 ,right=1356 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1385 ,top=388 ,right=1703 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� �� �� ȣ' ,left=1014 ,top=446 ,right=1356 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1385 ,top=446 ,right=1703 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� ��  �� ȣ' ,left=1014 ,top=564 ,right=1356 ,bottom=609 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1385, top=564, right=1819, bottom=609, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=213 ,top=496 ,right=1851 ,bottom=496 </L>
	<L> left=995 ,top=380 ,right=995 ,bottom=496 </L>
	<L> left=1364 ,top=380 ,right=1364 ,bottom=496 </L>
	<L> left=29 ,top=554 ,right=1851 ,bottom=554 </L>
	<L> left=998 ,top=554 ,right=998 ,bottom=614 </L>
	<L> left=1364 ,top=554 ,right=1364 ,bottom=614 </L>
	<T>id='��� �� �� (�� ȣ)' ,left=221 ,top=388 ,right=508 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǹ���' ,left=37 ,top=469 ,right=208 ,bottom=514 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡   ��' ,left=37 ,top=414 ,right=208 ,bottom=459 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ���' ,left=37 ,top=564 ,right=208 ,bottom=651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=595 ,top=683 ,right=819 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=982, top=915, right=1079, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=840, top=915, right=937, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=857, right=1445, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=915, right=1445, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=857, right=1585, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=915, right=1585, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC11000,0,,PC11000)}', left=595, top=976, right=819, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC12000,0,,PC12000)}', left=595, top=1031, right=819, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=857, right=1696, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=857, right=1827, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=915, right=1696, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=915, right=1827, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1095, top=915, right=1187, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1222, top=915, right=1319, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=865 ,right=87 ,bottom=904 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=912 ,right=87 ,bottom=952 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=957 ,right=87 ,bottom=997 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ó' ,left=34 ,top=999 ,right=87 ,bottom=1039 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1042 ,right=87 ,bottom=1081 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1129 ,right=87 ,bottom=1168 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1171 ,right=87 ,bottom=1210 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1216 ,right=87 ,bottom=1255 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1084 ,right=87 ,bottom=1123 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��          ��' ,left=100 ,top=2025 ,right=582 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=400 ,top=2133 ,right=400 ,bottom=2297 </L>
	<T>id='�ҵ漼' ,left=695 ,top=2025 ,right=974 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=982 ,top=2025 ,right=1261 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ư����' ,left=1272 ,top=2025 ,right=1551 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1561 ,top=2025 ,right=1840 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB41000,0,,PB41000)}', left=695, top=2083, right=974, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB42000,0,,PB42000)}', left=982, top=2083, right=1261, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB43000,0,,PB43000)}', left=1272, top=2083, right=1551, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB40000,0,,PB40000)}', left=1561, top=2083, right=1840, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='66)��(��)�ٹ���' ,left=197 ,top=2302 ,right=519 ,bottom=2347 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=503, top=2138, right=685, bottom=2183, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP141000,0,,BP141000)}', left=695, top=2138, right=974, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP142000,0,,BP142000)}', left=982, top=2138, right=1261, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP143000,0,,BP143000)}', left=1272, top=2138, right=1551, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=503, top=2191, right=685, bottom=2236, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000,0,,BP241000)}', left=695, top=2191, right=974, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP242000,0,,BP242000)}', left=982, top=2191, right=1261, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP243000,0,,BP243000)}', left=1272, top=2191, right=1551, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000+BP242000+BP243000,0,,BP241000+BP242000+BP243000)}', left=1561, top=2191, right=1840, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='' ,left=503 ,top=2246 ,right=685 ,bottom=2291 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=695, top=2246, right=974, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=982, top=2246, right=1261, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1272, top=2246, right=1551, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1561, top=2246, right=1840, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB61000,0,,PB61000)}', left=695, top=2302, right=974, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB62000,0,,PB62000)}', left=982, top=2302, right=1261, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB63000,0,,PB63000)}', left=1272, top=2302, right=1551, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB60000,0,,PB60000)}', left=1561, top=2302, right=1840, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB71000,0,,PB71000)}', left=695, top=2362, right=974, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB72000,0,,PB72000)}', left=982, top=2362, right=1261, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB73000,0,,PB73000)}', left=1272, top=2362, right=1551, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB70000,0,,PB70000)}', left=1561, top=2362, right=1840, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=1550 ,right=87 ,bottom=1590 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1603 ,right=87 ,bottom=1643 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1661 ,right=87 ,bottom=1701 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1714 ,right=87 ,bottom=1753 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1764 ,right=87 ,bottom=1804 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1814 ,right=87 ,bottom=1854 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2159 ,right=87 ,bottom=2196 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2217 ,right=87 ,bottom=2257 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2273 ,right=87 ,bottom=2310 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2328 ,right=87 ,bottom=2365 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2107 ,right=87 ,bottom=2146 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC11000,0,,BC11000)}', left=848, top=976, right=1072, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC12000,0,,BC12000)}', left=848, top=1031, right=1072, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC21000,0,,BC21000)}', left=1106, top=976, right=1330, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC22000,0,,BC22000)}', left=1106, top=1031, right=1330, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM3', left=1356, top=741, right=1580, bottom=786, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO3', left=1356, top=799, right=1580, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC31000,0,,BC31000)}', left=1356, top=976, right=1580, bottom=1020, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC32000,0,,BC32000)}', left=1356, top=1031, right=1580, bottom=1076, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC2000,0,,PBC2000)}', left=1598, top=1031, right=1838, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC1000,0,,PBC1000)}', left=1598, top=976, right=1838, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC10000,0,,PC10000)}', left=595, top=1379, right=819, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC10000,0,,BC10000)}', left=848, top=1379, right=1072, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC20000,0,,BC20000)}', left=1106, top=1379, right=1330, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC3000,0,,BC3000)}', left=1356, top=1379, right=1580, bottom=1424, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TWKSUM,0,,TWKSUM)}', left=1598, top=1379, right=1838, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1321, right=819, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1321, right=1072, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1321, right=1330, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1321, right=1580, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1321, right=1838, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1266, right=819, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1266, right=1072, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1266, right=1330, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1266, right=1580, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1266, right=1838, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1205, right=819, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1205, right=1072, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1205, right=1330, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1205, right=1580, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1205, right=1838, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1147, right=819, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1147, right=1072, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1147, right=1330, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1147, right=1580, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1147, right=1838, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC13000,0,,PC13000)}', left=595, top=1089, right=819, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC13000,0,,BC13000)}', left=848, top=1089, right=1072, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC23000,0,,BC23000)}', left=1106, top=1089, right=1330, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC33000,0,,BC33000)}', left=1356, top=1089, right=1580, bottom=1134, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC3000,0,,PBC3000)}', left=1598, top=1089, right=1838, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1427 ,top=319 ,right=1427 ,bottom=361 </L>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1440, right=819, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1440, right=1330, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1440, right=1580, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=1598, top=1440, right=1838, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT201,0,,BTAXAMT201)}', left=1106, top=1495, right=1330, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1495, right=1580, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+BTAXAMT201,0,,BTAXAMT101+BTAXAMT201)}', left=1598, top=1495, right=1838, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='O01' ,left=408 ,top=1550 ,right=577 ,bottom=1595 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1550, right=819, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1550, right=1072, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1550, right=1330, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1550, right=1580, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1550, right=1838, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Q01' ,left=408 ,top=1606 ,right=577 ,bottom=1651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1606, right=819, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1606, right=1072, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1606, right=1330, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1606, right=1580, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1606, right=1838, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1661, right=819, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=845, top=1661, right=1069, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1103, top=1661, right=1327, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1353, top=1661, right=1577, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1595, top=1661, right=1835, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1717, right=819, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1717, right=1072, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1717, right=1330, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1717, right=1580, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1717, right=1838, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1772, right=1072, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1772, right=1330, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1772, right=1580, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1772, right=1838, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1830, right=819, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1830, right=1072, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1830, right=1330, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1830, right=1580, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1830, right=1838, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1893, right=1072, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1893, right=1330, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1893, right=1580, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1893, right=1838, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1962, right=819, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1962, right=1072, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1962, right=1330, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1962, right=1580, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+PC23000,0,,BTAXAMT101+PC23000)}', left=1598, top=1962, right=1838, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=832 ,top=675 ,right=832 ,bottom=2017 </L>
	<L> left=1087 ,top=675 ,right=1087 ,bottom=2017 </L>
	<L> left=1590 ,top=675 ,right=1590 ,bottom=2017 </L>
	<L> left=192 ,top=2133 ,right=192 ,bottom=2352 </L>
	<C>id='CADDNM', left=592, top=620, right=1819, bottom=664, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='101-85-10695' ,left=592 ,top=446 ,right=885 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ���α� �赿 ������� 140-2' ,left=592 ,top=501 ,right=1727 ,bottom=546 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=592, top=564, right=885, bottom=609, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=592 ,top=388 ,right=885 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=587 ,top=380 ,right=587 ,bottom=2017 </L>
	<L> left=213 ,top=380 ,right=213 ,bottom=670 </L>
	<L> left=213 ,top=614 ,right=1851 ,bottom=614 </L>
	<C>id='CURDT2', left=1332, top=2492, right=1740, bottom=2529 ,mask='XXXX��  02��  28��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=1203 ,top=2550 ,right=1435 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=498 ,top=2133 ,right=498 ,bottom=2297 </L>
	<L> left=498 ,top=2241 ,right=1851 ,bottom=2241 </L>
	<L> left=498 ,top=2186 ,right=1851 ,bottom=2186 </L>
	<T>id='�ⳳ��' ,left=95 ,top=2191 ,right=187 ,bottom=2223 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=95 ,top=2228 ,right=184 ,bottom=2260 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1772, right=819, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
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
	<T>id='���� ��õ¡����(�ٷμҵ�)�� ����(����)�մϴ�.' ,left=29 ,top=2436 ,right=1851 ,bottom=2476 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������  ����' ,left=461 ,top=2587 ,right=740 ,bottom=2631 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��(����)�ǹ���' ,left=742 ,top=2550 ,right=1095 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)��(��)�ٹ���' ,left=197 ,top=2149 ,right=395 ,bottom=2202 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�������׶���' ,left=197 ,top=2188 ,right=398 ,bottom=2244 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����)' ,left=197 ,top=2236 ,right=395 ,bottom=2281 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP141000+BP142000+BP143000,0,,BP141000+BP142000+BP143000)}', left=1561, top=2138, right=1840, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��(��)' ,left=848 ,top=683 ,right=1072 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=1106 ,top=683 ,right=1330 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)-1��������' ,left=1356 ,top=683 ,right=1580 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1598 ,top=683 ,right=1838 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT3', left=590, top=857, right=706, bottom=902, align='left', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUTO', left=721, top=915, right=829, bottom=960, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUFR', left=590, top=915, right=706, bottom=960, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1340 ,top=675 ,right=1340 ,bottom=2017 </L>
	<C>id='BCWKNM1', left=835, top=741, right=1085, bottom=786, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM2', left=1090, top=741, right=1337, bottom=786, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=' ~' ,left=695 ,top=857 ,right=724 ,bottom=902 ,face='Arial' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=721, top=857, right=829, bottom=902, align='left', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT1', left=835, top=857, right=1085, bottom=902, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT2', left=1090, top=857, right=1337, bottom=902, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=405 ,top=2154 ,right=495 ,bottom=2199 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=405 ,top=2191 ,right=495 ,bottom=2236 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=405 ,top=2228 ,right=495 ,bottom=2273 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=835, top=799, right=1085, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1090, top=799, right=1337, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=1432 ,right=1851 ,bottom=1432 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=403 ,top=1437 ,right=403 ,bottom=1949 </L>
	<T>id='��   ��' ,left=97 ,top=683 ,right=569 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)��   ��   ó   ��' ,left=97 ,top=741 ,right=569 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10)����ڵ�Ϲ�ȣ' ,left=97 ,top=799 ,right=569 ,bottom=844 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)�ٹ��Ⱓ' ,left=97 ,top=857 ,right=569 ,bottom=902 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)����Ⱓ' ,left=97 ,top=915 ,right=569 ,bottom=960 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13)��               ��' ,left=97 ,top=976 ,right=569 ,bottom=1020 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14)��               ��' ,left=97 ,top=1031 ,right=569 ,bottom=1076 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)��   ��   ��   ��' ,left=97 ,top=1092 ,right=569 ,bottom=1136 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-1�ֽĸż����ñ� �������' ,left=97 ,top=1150 ,right=569 ,bottom=1194 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-2�츮�������������' ,left=97 ,top=1208 ,right=569 ,bottom=1252 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-3' ,left=97 ,top=1268 ,right=569 ,bottom=1313 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-4' ,left=97 ,top=1324 ,right=569 ,bottom=1368 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)��' ,left=97 ,top=1382 ,right=569 ,bottom=1426 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-1 �߰��ٷμ���' ,left=97 ,top=1553 ,right=384 ,bottom=1598 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-2 ��꺸������' ,left=97 ,top=1608 ,right=384 ,bottom=1653 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-3 �ܱ��αٷ���' ,left=97 ,top=1664 ,right=384 ,bottom=1709 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-4' ,left=97 ,top=1719 ,right=384 ,bottom=1764 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-5' ,left=97 ,top=1775 ,right=384 ,bottom=1819 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-6' ,left=97 ,top=1833 ,right=384 ,bottom=1877 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)�� ���� �����' ,left=97 ,top=1896 ,right=384 ,bottom=1941 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20)������ҵ� ��' ,left=97 ,top=1964 ,right=569 ,bottom=2009 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)��     ��     ��     ��' ,left=97 ,top=2086 ,right=579 ,bottom=2130 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='67)��  ��  ¡  ��  ��  ��' ,left=97 ,top=2365 ,right=579 ,bottom=2410 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='M01' ,left=408 ,top=1440 ,right=577 ,bottom=1484 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=848, top=1440, right=1072, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1495, right=1072, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1495, right=819, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='M02' ,left=408 ,top=1495 ,right=577 ,bottom=1540 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(150����)' ,left=97 ,top=1495 ,right=400 ,bottom=1540 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(100����)' ,left=97 ,top=1440 ,right=398 ,bottom=1484 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='X01' ,left=408 ,top=1664 ,right=577 ,bottom=1709 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=2297 ,right=1851 ,bottom=2297 </L>
</B>





</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
 <R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID='gcds_print1', DetailDataID='gcds_print1', 
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=2650 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=158 ,right=29 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(��2��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=156 ,right=90 ,bottom=2647 </L>
	<L> left=140 ,top=430 ,right=140 ,bottom=2560 </L>
	<T>id='��' ,left=145 ,top=881 ,right=184 ,bottom=910 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1392 ,right=184 ,bottom=1421 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1329 ,right=134 ,bottom=1368 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1160 ,right=84 ,bottom=1200 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1274 ,right=84 ,bottom=1313 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1387 ,right=84 ,bottom=1424 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1484 ,right=84 ,bottom=1521 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1606 ,right=84 ,bottom=1643 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1392 ,right=134 ,bottom=1432 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1458 ,right=134 ,bottom=1495 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1513 ,right=134 ,bottom=1550 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1564 ,right=134 ,bottom=1603 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1614 ,right=134 ,bottom=1656 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=912 ,right=184 ,bottom=941 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=947 ,right=184 ,bottom=976 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=983 ,right=184 ,bottom=1012 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='42)�� �� �� �� �� ��' ,left=95 ,top=2573 ,right=577 ,bottom=2634 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)�� �� ��(16) �Ǵ� 16)- 18)-3)' ,left=97 ,top=169 ,right=663 ,bottom=229 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)�ٷμҵ����' ,left=97 ,top=261 ,right=663 ,bottom=322 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50)���ռҵ� ����ǥ��' ,left=979 ,top=1192 ,right=1459 ,bottom=1252 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB10000,0,,PB10000)}', left=679, top=169, right=964, bottom=229, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='43)���ο�������ҵ����' ,left=1029 ,top=169 ,right=1509 ,bottom=229 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT011S,0,,ETCAMT011S)}', left=1543, top=169, right=1825, bottom=229, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB20000,0,,PB20000)}', left=679, top=261, right=964, bottom=322, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)��������ҵ����' ,left=1029 ,top=261 ,right=1509 ,bottom=322 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT01S,0,,ETCAMT01S)}', left=1543, top=261, right=1825, bottom=322, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='23)�ٷμҵ�ݾ�' ,left=97 ,top=356 ,right=663 ,bottom=417 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB30000,0,,PB30000)}', left=679, top=356, right=964, bottom=417, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-1�ұ�����һ���� �����α� �ҵ����' ,left=1029 ,top=356 ,right=1509 ,bottom=417 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1543, top=356, right=1825, bottom=417, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='24)��         ��' ,left=205 ,top=446 ,right=490 ,bottom=506 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)��   ��   ��' ,left=205 ,top=541 ,right=500 ,bottom=601 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)�ξ簡��(' ,left=205 ,top=630 ,right=392 ,bottom=691 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)��ο��(' ,left=205 ,top=725 ,right=392 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)�� �� �� (' ,left=205 ,top=817 ,right=392 ,bottom=878 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)��   ��   ��' ,left=205 ,top=907 ,right=500 ,bottom=968 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)�ڳ������(' ,left=205 ,top=1002 ,right=421 ,bottom=1063 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=679, top=446, right=964, bottom=506, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-2���ø������� �ҵ����' ,left=1029 ,top=446 ,right=1509 ,bottom=506 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HOUAMT01S,0,,HOUAMT01S)}', left=1543, top=446, right=1825, bottom=506, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=679, top=541, right=964, bottom=601, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='45)�����������ڵ�ҵ����' ,left=1029 ,top=541 ,right=1509 ,bottom=601 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT02S,0,,ETCAMT02S)}', left=1543, top=541, right=1825, bottom=601, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BA0101CNT,0,,BA0101CNT)}', left=395, top=630, right=458, bottom=691 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=630 ,right=516 ,bottom=691 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=679, top=630, right=964, bottom=691, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='46)�ſ�ī���ҵ����' ,left=1029 ,top=630 ,right=1509 ,bottom=691 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT03S,0,,ETCAMT03S)}', left=1543, top=630, right=1825, bottom=691, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TOTCNT02,0,,TOTCNT02)}', left=395, top=725, right=455, bottom=786 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=725 ,right=516 ,bottom=786 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=679, top=725, right=964, bottom=786, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='47)�츮�������ռҵ����' ,left=1029 ,top=725 ,right=1509 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT04S,0,,ETCAMT04S)}', left=1543, top=725, right=1825, bottom=786, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0103CNT,0,,AD0103CNT)}', left=395, top=817, right=455, bottom=878 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=817 ,right=516 ,bottom=878 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=679, top=817, right=964, bottom=878, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='48)����ֽ�������ҵ����' ,left=1029 ,top=817 ,right=1509 ,bottom=878 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(FNDSUMS,0,,FNDSUMS)}', left=1543, top=817, right=1825, bottom=878, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=679, top=907, right=964, bottom=968, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0105CNT,0,,AD0105CNT)}', left=427, top=1002, right=469, bottom=1063 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=471 ,top=1002 ,right=519 ,bottom=1063 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=679, top=1002, right=964, bottom=1063, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT07,0,,ADAMT07)}', left=679, top=1094, right=964, bottom=1155, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1543, top=1094, right=1825, bottom=1155, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='49)�� ���� �ҵ���� ��' ,left=1029 ,top=1094 ,right=1509 ,bottom=1155 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TSTDSUM,0,,TSTDSUM)}', left=1543, top=1192, right=1825, bottom=1252, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='31)���ڳ��߰�����(' ,left=153 ,top=1281 ,right=445 ,bottom=1342 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0106CNT,0,,AD0106CNT)}', left=453, top=1281, right=513, bottom=1342 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=516 ,top=1281 ,right=571 ,bottom=1342 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)���ο��ݺ�������' ,left=200 ,top=1376 ,right=529 ,bottom=1437 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1��Ÿ ���ݺ�������' ,left=197 ,top=1466 ,right=577 ,bottom=1527 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)�������ݼҵ����' ,left=200 ,top=1558 ,right=524 ,bottom=1619 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)��   ��   ��' ,left=200 ,top=1648 ,right=521 ,bottom=1709 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)��   ��   ��' ,left=205 ,top=1835 ,right=527 ,bottom=1896 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)�����������Աݿ����ݻ�ȯ��' ,left=200 ,top=1930 ,right=616 ,bottom=1991 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)-1��������������Ա����ڻ�ȯ��' ,left=200 ,top=2020 ,right=666 ,bottom=2080 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)��α�' ,left=200 ,top=2115 ,right=521 ,bottom=2175 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)' ,left=197 ,top=2207 ,right=519 ,bottom=2268 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)      ��' ,left=200 ,top=2384 ,right=521 ,bottom=2444 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)ǥ �� �� ��' ,left=200 ,top=2481 ,right=521 ,bottom=2542 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT05S,0,,ADAMT05S)}', left=679, top=1281, right=964, bottom=1342, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='51)��     ��     ��     ��' ,left=979 ,top=1281 ,right=1459 ,bottom=1342 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDTAX,0,,STDTAX)}', left=1543, top=1281, right=1825, bottom=1342, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUMS,0,,PENSUMS)}', left=679, top=1376, right=964, bottom=1437, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='52)[��   ��   ��   ��]' ,left=1029 ,top=1376 ,right=1509 ,bottom=1437 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT01S,0,,REDAMT01S)}', left=1543, top=1376, right=1825, bottom=1437, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='53)[����Ư�����ѹ�]' ,left=1029 ,top=1466 ,right=1509 ,bottom=1527 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT02S,0,,REDAMT02S)}', left=1543, top=1466, right=1825, bottom=1527, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT05,0,,ETCAMT05)}', left=679, top=1558, right=964, bottom=1619, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='54)' ,left=1029 ,top=1558 ,right=1509 ,bottom=1619 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=679, top=1648, right=964, bottom=1709, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='35)��   ��   ��' ,left=203 ,top=1738 ,right=524 ,bottom=1798 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=679, top=1738, right=964, bottom=1798, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='55)���װ��� ��' ,left=1029 ,top=1738 ,right=1509 ,bottom=1798 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDSUM,0,,REDSUM)}', left=1543, top=1738, right=1825, bottom=1798, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=679, top=1466, right=961, bottom=1527, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='56)��  ��   ��  ��' ,left=1029 ,top=1835 ,right=1509 ,bottom=1896 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)�������հ���' ,left=1029 ,top=1930 ,right=1509 ,bottom=1991 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)�� �� �� �� ��' ,left=1029 ,top=2020 ,right=1509 ,bottom=2080 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)��� ��ġ�ڱ�' ,left=1029 ,top=2115 ,right=1509 ,bottom=2175 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT01S,0,,DEDAMT01S)}', left=1543, top=1835, right=1825, bottom=1896, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02S,0,,DEDAMT02S)}', left=1543, top=1930, right=1825, bottom=1991, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03S,0,,DEDAMT03S)}', left=1543, top=2020, right=1825, bottom=2080, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04S,0,,DEDAMT04S)}', left=1543, top=2115, right=1825, bottom=2175, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='60)��  ��   ��  ��' ,left=1029 ,top=2207 ,right=1509 ,bottom=2268 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT05S,0,,DEDAMT05S)}', left=1543, top=2207, right=1825, bottom=2268, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=679, top=1835, right=964, bottom=1896, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02S,0,,HOUAMT02S)}', left=679, top=1930, right=964, bottom=1991, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT34S,0,,HOUAMT34S)}', left=679, top=2020, right=964, bottom=2080, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONSUM,0,,CONSUM)}', left=679, top=2115, right=964, bottom=2175, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=679, top=2384, right=964, bottom=2444, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='62)' ,left=1029 ,top=2384 ,right=1509 ,bottom=2444 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1029 ,top=2297 ,right=1509 ,bottom=2357 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=679, top=2481, right=964, bottom=2542, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='63)�� �� �� �� ��' ,left=1029 ,top=2481 ,right=1509 ,bottom=2542 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1543, top=2481, right=1825, bottom=2542, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=679, top=2573, right=964, bottom=2634, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� �� ��[51)-55)-63)]' ,left=979 ,top=2573 ,right=1459 ,bottom=2634 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(RESSUM,0,,RESSUM)}', left=1543, top=2573, right=1825, bottom=2634, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=977 ,top=454 ,right=1016 ,bottom=493 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1421 ,right=184 ,bottom=1450 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1450 ,right=184 ,bottom=1479 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1471 ,right=184 ,bottom=1508 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1503 ,right=184 ,bottom=1535 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1532 ,right=184 ,bottom=1564 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1564 ,right=184 ,bottom=1595 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1484 ,right=1016 ,bottom=1521 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1535 ,right=1016 ,bottom=1571 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1587 ,right=1016 ,bottom=1627 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1645 ,right=1016 ,bottom=1687 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2070 ,right=1016 ,bottom=2107 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2130 ,right=1016 ,bottom=2167 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2194 ,right=1016 ,bottom=2233 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2257 ,right=1016 ,bottom=2299 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=145 ,top=1941 ,right=184 ,bottom=1999 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2030 ,right=184 ,bottom=2088 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2123 ,right=184 ,bottom=2183 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2225 ,right=184 ,bottom=2286 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=501 ,right=184 ,bottom=530 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=530 ,right=184 ,bottom=559 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=559 ,right=184 ,bottom=588 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=588 ,right=184 ,bottom=617 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=559 ,right=1016 ,bottom=599 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=614 ,right=1016 ,bottom=651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=691 ,right=1016 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=736 ,right=1016 ,bottom=773 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=783 ,right=1016 ,bottom=823 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=831 ,right=1016 ,bottom=873 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)-1��������߼ұ���ٷ��ڼҵ����' ,left=1029 ,top=907 ,right=1516 ,bottom=968 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0107CNT,0,,AD0107CNT)}', left=487, top=1094, right=532, bottom=1155 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=532 ,top=1094 ,right=574 ,bottom=1155 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)-1�����Ծ���(' ,left=205 ,top=1094 ,right=484 ,bottom=1155 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='3��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print1'
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=614 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��)' ,left=305 ,top=562 ,right=358 ,bottom=606 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='68)�ҵ���� ��(���������׸��� �ش���� O ǥ�ø� �ϸ�, ���� �ҵ���� �׸��� ������ ���Ͽ� ���� ������ �ݾ��� �����ϴ�)' ,left=71 ,top=87 ,right=1888 ,bottom=148 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=69 ,right=1901 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='������' ,left=71 ,top=324 ,right=147 ,bottom=369 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�' ,left=71 ,top=208 ,right=147 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=158 ,top=166 ,right=427 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=166 ,right=147 ,bottom=208 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=153 ,top=161 ,right=153 ,bottom=488 </L>
	<T>id='�������� �׸�' ,left=103 ,top=493 ,right=374 ,bottom=538 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���ڳ�' ,left=103 ,top=562 ,right=224 ,bottom=606 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=359 ,right=147 ,bottom=403 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��         ȣ' ,left=158 ,top=359 ,right=429 ,bottom=403 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� ��' ,left=158 ,top=324 ,right=429 ,bottom=369 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻' ,left=434 ,top=277 ,right=498 ,bottom=322 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=322 ,right=498 ,bottom=364 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�γ�' ,left=434 ,top=377 ,right=498 ,bottom=414 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=434 ,top=409 ,right=498 ,bottom=446 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=440 ,right=498 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=369 ,right=498 ,bottom=369 </L>
	<T>id='���' ,left=505 ,top=306 ,right=569 ,bottom=351 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=505 ,top=343 ,right=569 ,bottom=388 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=505 ,top=380 ,right=569 ,bottom=422 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=577 ,top=411 ,right=640 ,bottom=456 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=382 ,right=640 ,bottom=419 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ծ�' ,left=577 ,top=343 ,right=640 ,bottom=388 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=327 ,right=640 ,bottom=348 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=577 ,top=293 ,right=640 ,bottom=337 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=648 ,top=301 ,right=711 ,bottom=345 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=648 ,top=337 ,right=711 ,bottom=374 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=648 ,top=372 ,right=711 ,bottom=417 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڳ�' ,left=719 ,top=287 ,right=782 ,bottom=332 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=322 ,right=782 ,bottom=367 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=719 ,top=359 ,right=782 ,bottom=396 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=390 ,right=782 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=161 ,right=429 ,bottom=609 </L>
	<L> left=571 ,top=256 ,right=571 ,bottom=609 </L>
	<L> left=642 ,top=256 ,right=642 ,bottom=609 </L>
	<L> left=713 ,top=256 ,right=713 ,bottom=609 </L>
	<T>id='�������� �׸�' ,left=434 ,top=166 ,right=782 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=543 ,right=498 ,bottom=543 </L>
	<L> left=895 ,top=161 ,right=895 ,bottom=609 </L>
	<T>id='���� �ҵ���� �׸�' ,left=900 ,top=166 ,right=1898 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=932 ,top=290 ,right=1037 ,bottom=335 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ǰ������' ,left=898 ,top=332 ,right=1069 ,bottom=377 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����)' ,left=898 ,top=369 ,right=1069 ,bottom=414 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ��' ,left=1077 ,top=264 ,right=1232 ,bottom=480 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1243 ,top=261 ,right=1398 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1738 ,top=261 ,right=1898 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1732 ,top=256 ,right=1732 ,bottom=609 </L>
	<L> left=1403 ,top=256 ,right=1403 ,bottom=609 </L>
	<L> left=1237 ,top=256 ,right=1237 ,bottom=609 </L>
	<L> left=1072 ,top=256 ,right=1072 ,bottom=609 </L>
	<C>id='{decode(TREF25,0,,TREF25)}', left=1590, top=554, right=1706, bottom=601, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF11,0,,TREF11)}', left=898, top=498, right=1069, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=1077, top=498, right=1232, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1243, top=498, right=1398, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF14,0,,TREF14)}', left=1411, top=498, right=1567, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1577, top=498, right=1727, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1738, top=498, right=1898, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF21,0,,TREF21)}', left=898, top=554, right=1069, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=1077, top=554, right=1232, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1243, top=554, right=1398, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1411, top=554, right=1567, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1738, top=554, right=1898, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=893 ,top=256 ,right=1901 ,bottom=256 </L>
	<T>id='�ڷ�' ,left=795 ,top=293 ,right=893 ,bottom=337 ,supplevel=1 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=795 ,top=335 ,right=893 ,bottom=372 ,supplevel=1 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=795 ,top=496 ,right=893 ,bottom=543 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=554 ,right=893 ,bottom=601 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='�ſ�ī�� ��' ,left=1477 ,top=264 ,right=1667 ,bottom=332 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=1477 ,top=314 ,right=1667 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī�� ��' ,left=1409 ,top=401 ,right=1564 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ī�� ��' ,left=1409 ,top=432 ,right=1569 ,bottom=467 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1577 ,top=432 ,right=1727 ,bottom=467 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1577 ,top=401 ,right=1727 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ϴ� �ο����� ����' ,left=63 ,top=527 ,right=427 ,bottom=564 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��3��)' ,left=1622 ,top=8 ,right=1877 ,bottom=61 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AD0106CNT', left=226, top=562, right=305, bottom=606, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=105 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=105 ,right=1901 ,bottom=105 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=153 ,top=3 ,right=153 ,bottom=105 </L>
	<C>id='RESINO1', left=158, top=58, right=427, bottom=103 ,mask='XXXXXX-XXXXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=158, top=5, right=427, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=429 ,top=0 ,right=429 ,bottom=103 </L>
	<C>id='{decode(REF1,T,��,T,��,)}', left=74, top=58, right=147, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1', left=74, top=5, right=147, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2', left=434, top=5, right=498, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=434, top=58, right=498, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=500 ,top=0 ,right=500 ,bottom=103 </L>
	<C>id='REF5', left=505, top=8, right=569, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=571 ,top=0 ,right=571 ,bottom=103 </L>
	<C>id='REF8', left=577, top=8, right=640, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=642 ,top=0 ,right=642 ,bottom=103 </L>
	<C>id='REF3', left=648, top=8, right=711, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=713 ,top=0 ,right=713 ,bottom=103 </L>
	<L> left=429 ,top=53 ,right=63 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=895 ,top=0 ,right=895 ,bottom=103 </L>
	<L> left=1072 ,top=0 ,right=1072 ,bottom=103 </L>
	<L> left=1237 ,top=0 ,right=1237 ,bottom=103 </L>
	<L> left=1403 ,top=0 ,right=1403 ,bottom=103 </L>
	<L> left=1732 ,top=0 ,right=1732 ,bottom=103 </L>
	<C>id='{decode(REF21,0,,REF21)}', left=898, top=58, right=1069, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=1077, top=58, right=1232, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1243, top=58, right=1398, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1411, top=58, right=1567, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1738, top=58, right=1898, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11,0,,REF11)}', left=898, top=8, right=1069, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=1077, top=8, right=1232, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1243, top=8, right=1398, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1411, top=8, right=1567, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25,0,,REF25)}', left=1601, top=58, right=1706, bottom=103, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1738, top=8, right=1898, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1577, top=8, right=1727, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=795 ,top=8 ,right=893 ,bottom=53 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=58 ,right=893 ,bottom=103 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=898 ,top=53 ,right=1901 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=790 ,top=3 ,right=790 ,bottom=105 </L>
	<C>id='REF4', left=719, top=8, right=782, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=432 ,top=53 ,right=500 ,bottom=53 </L>
	<L> left=790 ,top=53 ,right=903 ,bottom=53 </L>
	<L> left=1572 ,top=0 ,right=1572 ,bottom=103 </L>
	<X>left=1572 ,top=55 ,right=1732 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2001 ,bottom=967 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�� �ۼ����' ,left=74 ,top=13 ,right=279 ,bottom=58 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     (* ISO�����ڵ� : ����ûȨ������->��������->������������->���������ڷ�ǿ��� ��ȸ �� �� �ֽ��ϴ�. ��) ���ѹα�: KR, �̱� : US' ,left=71 ,top=98 ,right=1888 ,bottom=137 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ���� ���޸����� �����Ͽ��� �մϴ�.' ,left=71 ,top=171 ,right=1888 ,bottom=211 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. ��õ¡���ǹ��ڴ� �������� ���ϴ� ������ ���� ���� 3�� 10��(�޾� �Ǵ� ����� ��쿡�� �޾��� �Ǵ� ������� ���ϴ� ���� ���� ���� �� ������ ���մϴ�)' ,left=71 ,top=134 ,right=1888 ,bottom=174 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=61 ,top=965 ,right=1906 ,bottom=965 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='  3. ���ٹ�ó���ҵ������ ������ҵ�(�ܱ��αٷ��� 30% ����� ����)�� ������ �ݾ��� ����, ��.������ҵ������ ���޸��� �ۼ���� ������ҵ��� ������ҵ���' ,left=71 ,top=208 ,right=1888 ,bottom=248 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. �����ٷμҵ�� �����ٷμҵ��� ���Ͽ� ���������ϴ� ������ 16)-1 �������ն��� ���� �����ٷμҵ泳�����հ� �����ٷμҵ���  ����, [�ҵ漼�� �����] ' ,left=71 ,top=279 ,right=1888 ,bottom=319 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ��150���� ���� �������հ����ݾ��� 57)�������հ������� �����ϴ�. �պ�, ������� ���� ������ �ش� ������ ���������� �ϴ� ��쿡 ���պ�����, ' ,left=71 ,top=316 ,right=1888 ,bottom=359 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ������º������� �ҵ��� �ٹ�ó���ҵ�� ��(��)���� ������ �����ϴ�.' ,left=71 ,top=353 ,right=1888 ,bottom=396 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 18-3���� �ܱ��αٷ��ڰ� [����Ư�����ѹ�] �� 18����2��1���� �����ϴ� ��쿡�� ������, 16)����� �ݾ׿� 100���� 30�� ���� �ݾ��� �����ϴ�.' ,left=71 ,top=390 ,right=1888 ,bottom=432 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 21)�ѱ޿������� 16)����� �ݾ��� ����, 18)-3���� �ݾ��� �ִ� ��쿡�� 16)����� �ݾ׿��� 18)-3���� �ݾ��� �� �ݾ��� ������, �ܱ��αٷ��ڰ� ' ,left=71 ,top=427 ,right=1888 ,bottom=469 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    [����Ư�����ѹ�] ��18����2��2�׿� ���� ���ϼ����� �����ϴ� ��쿡�� 16)���� �ݾְ� ������ҵ�ݾ��� ���� �ݾ��� ����, �ҵ漼�� ������ ����� .����.����' ,left=71 ,top=464 ,right=1888 ,bottom=506 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �� ���װ����� ���� ������ �������� �ʽ��ϴ�.' ,left=71 ,top=501 ,right=1888 ,bottom=543 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. ���ռҵ� Ư������[34) ~ 39)]���� �� ���� �ҵ����[43)~47)]���� ���� ��37ȣ������ �������� �����ϴ�.' ,left=71 ,top=541 ,right=1888 ,bottom=580 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. �� ���Ŀ� ���� �ݾ� �� �Ҽ��� ���� ���� ������, 67) ����¡�������� �Ҿ׺�¡��(1õ�� �̸��� ���մϴ�)�� �ش��ϴ� ��� ������ 0 ���� �����ϴ�.' ,left=71 ,top=577 ,right=1888 ,bottom=617 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68) �ҵ���� ������ 2006�� ���� �߻��ϴ� �ٷμҵ� ��������к��� ����մϴ�.' ,left=71 ,top=614 ,right=1888 ,bottom=654 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �����ڵ�� : �ҵ��� ����=0, �ҵ����� ��������=1, ������� ��������=2, �����=3, ������ �ڳ�=4, ������ �ڳ� �� = 5 �����ڸ�=6, ��Ÿ=7�� �����ϴ�' ,left=71 ,top=654 ,right=1888 ,bottom=693 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='           (4��5��6��7�� ��� �ҵ��ڿ� ������� ������ ���踦 �����մϴ�). ' ,left=71 ,top=691 ,right=1888 ,bottom=730 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ��.�ܱ��ζ� : �������� ��� 1 ��, �ܱ����� ��� 9 �� �����ϴ�.' ,left=71 ,top=728 ,right=1888 ,bottom=767 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���������׸�� : �������������� �ִ� ��� �ش���� O ǥ�ø� �մϴ�(�ش������ ���� ��� ����Ӵϴ�).' ,left=71 ,top=765 ,right=1888 ,bottom=804 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ����û �ڷ�� : [�ҵ漼��] ��165���� ���� ����û Ȩ���������� �����ϴ� �� �ҵ���� �׸��� �ݾ� �� �ҵ��������� �Ǵ� �ݾ���  �����ϴ�.' ,left=71 ,top=802 ,right=1888 ,bottom=841 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �� ���� �ڷ�� : ����û���� �����ϴ� �������� ���� ���� ���մϴ�.(���� ���, �п��� ���γ��ο������� �ſ�ī�� �� ����, �÷±����� �Ȱ汸�Ժ�� ' ,left=71 ,top=838 ,right=1888 ,bottom=878 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='        �Ƿ����� ���� �����ϴ�).' ,left=71 ,top=875 ,right=1888 ,bottom=915 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���� �ҵ���� �׸�� : �ҵ�����׸� �ش��ϴ� ���� ����ݾ��� �����ϴ�(�ҵ�������� �ƴ� ���� ���ݾ��� �����׸񺰷� ���е� ���� �ȿ� �����ϴ�).' ,left=71 ,top=912 ,right=1888 ,bottom=952 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �ش� �ڵ庰�� �����Ͽ� �����ϴ�. (������׸��� ���� ��� ��.����� �ҵ���� 20)������ҵ� ����� �Ѿ׸� ���� ��.����� �ҵ���� ������ �ۼ� �����մϴ�.)' ,left=71 ,top=240 ,right=1888 ,bottom=279 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. ���������� ���������ڵ�� ������ڿ� �ش��ϴ� ��쿡 ���Ͽ� ������, ����ǥ��ȭ�ⱸ(ISO)�� ���� ISO�ڵ� �� ������ �� �����ڵ带 �����ϴ�.' ,left=79 ,top=61 ,right=1896 ,bottom=100 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
	">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ� ���� : �ٷμҵ��õ¡�������� REPORT
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print"> -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='4��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2750 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=66 ,top=185 ,right=395 ,bottom=274 ,border=true</X>
	<L> left=29 ,top=2650 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=158 ,right=29 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210��x297��(�Ϲݿ��� 60g/��)' ,left=1206 ,top=2663 ,right=1848 ,bottom=2705 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��1��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1719 ,top=319 ,right=1719 ,bottom=361 </L>
	<L> left=1293 ,top=232 ,right=1830 ,bottom=232 </L>
	<T>id='��1 / ��2' ,left=1585 ,top=279 ,right=1827 ,bottom=314 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ֱ���' ,left=1303 ,top=195 ,right=1514 ,bottom=227 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������1 / �������2' ,left=1530 ,top=195 ,right=1827 ,bottom=227 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ܱ���' ,left=1303 ,top=240 ,right=1514 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=274 ,right=1830 ,bottom=274 </L>
	<T>id='�ܱ��δ��ϼ�������' ,left=1303 ,top=279 ,right=1572 ,bottom=314 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=319 ,right=1830 ,bottom=319 </L>
	<T>id='��������' ,left=1303 ,top=324 ,right=1422 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=361 ,right=1830 ,bottom=361 </L>
	<T>id='������1 / �ܱ���9' ,left=1530 ,top=240 ,right=1827 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������ڵ�' ,left=1530 ,top=324 ,right=1709 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=187 ,right=1830 ,bottom=187 </L>
	<L> left=1293 ,top=187 ,right=1293 ,bottom=361 </L>
	<T>id='[���� ��24ȣ ����(1)]  ' ,left=29 ,top=90 ,right=1438 ,bottom=150 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=380 ,right=1851 ,bottom=380 </L>
	<C>id='HTITLE', left=629, top=298, right=1048, bottom=340, face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ٷμҵ� ���޸���' ,left=598 ,top=240 ,right=1216 ,bottom=287 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷμҵ��õ¡��������' ,left=598 ,top=187 ,right=1216 ,bottom=235 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=550 ,top=243 ,right=579 ,bottom=277 ,border=true</X>
	<X>left=550 ,top=192 ,right=579 ,bottom=227 ,border=true</X>
	<T>id='����' ,left=71 ,top=190 ,right=184 ,bottom=229 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=71 ,top=232 ,right=184 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCNT', left=303, top=190, right=390, bottom=269, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2009 -' ,left=205 ,top=190 ,right=321 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=185 ,right=192 ,bottom=274 </L>
	<T>id='(���� �Ǵ� ��)' ,left=1482 ,top=2550 ,right=1748 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2418 ,right=1851 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1522 ,top=187 ,right=1522 ,bottom=274 </L>
	<L> left=1830 ,top=190 ,right=1830 ,bottom=361 </L>
	<L> left=1577 ,top=274 ,right=1577 ,bottom=319 </L>
	<L> left=1527 ,top=319 ,right=1527 ,bottom=361 </L>
	<L> left=29 ,top=672 ,right=1851 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�켺��' ,left=221 ,top=564 ,right=508 ,bottom=609 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�Ϲ�ȣ' ,left=221 ,top=446 ,right=508 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� �� �� (�ּ�)' ,left=221 ,top=501 ,right=508 ,bottom=546 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ּ�' ,left=221 ,top=620 ,right=508 ,bottom=664 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� ǥ �� (��     ��)' ,left=1014 ,top=388 ,right=1356 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1385 ,top=388 ,right=1703 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� �� �� ȣ' ,left=1014 ,top=446 ,right=1356 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1385 ,top=446 ,right=1703 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� ��  �� ȣ' ,left=1014 ,top=564 ,right=1356 ,bottom=609 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1385, top=564, right=1819, bottom=609, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=213 ,top=496 ,right=1851 ,bottom=496 </L>
	<L> left=995 ,top=380 ,right=995 ,bottom=496 </L>
	<L> left=1364 ,top=380 ,right=1364 ,bottom=496 </L>
	<L> left=29 ,top=554 ,right=1851 ,bottom=554 </L>
	<L> left=998 ,top=554 ,right=998 ,bottom=614 </L>
	<L> left=1364 ,top=554 ,right=1364 ,bottom=614 </L>
	<T>id='��� �� �� (�� ȣ)' ,left=221 ,top=388 ,right=508 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǹ���' ,left=37 ,top=469 ,right=208 ,bottom=514 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡   ��' ,left=37 ,top=414 ,right=208 ,bottom=459 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ���' ,left=37 ,top=564 ,right=208 ,bottom=651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=595 ,top=683 ,right=819 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=982, top=915, right=1079, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=840, top=915, right=937, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=857, right=1445, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=915, right=1445, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=857, right=1585, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=915, right=1585, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC11000,0,,PC11000)}', left=595, top=976, right=819, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC12000,0,,PC12000)}', left=595, top=1031, right=819, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=857, right=1696, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=857, right=1827, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=915, right=1696, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=915, right=1827, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1095, top=915, right=1187, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1222, top=915, right=1319, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=865 ,right=87 ,bottom=904 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=912 ,right=87 ,bottom=952 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=957 ,right=87 ,bottom=997 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ó' ,left=34 ,top=999 ,right=87 ,bottom=1039 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1042 ,right=87 ,bottom=1081 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1129 ,right=87 ,bottom=1168 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1171 ,right=87 ,bottom=1210 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1216 ,right=87 ,bottom=1255 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1084 ,right=87 ,bottom=1123 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��          ��' ,left=100 ,top=2025 ,right=582 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=400 ,top=2133 ,right=400 ,bottom=2297 </L>
	<T>id='�ҵ漼' ,left=695 ,top=2025 ,right=974 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=982 ,top=2025 ,right=1261 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ư����' ,left=1272 ,top=2025 ,right=1551 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1561 ,top=2025 ,right=1840 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB41000,0,,PB41000)}', left=695, top=2083, right=974, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB42000,0,,PB42000)}', left=982, top=2083, right=1261, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB43000,0,,PB43000)}', left=1272, top=2083, right=1551, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB40000,0,,PB40000)}', left=1561, top=2083, right=1840, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='66)��(��)�ٹ���' ,left=197 ,top=2302 ,right=519 ,bottom=2347 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=503, top=2138, right=685, bottom=2183, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP141000,0,,BP141000)}', left=695, top=2138, right=974, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP142000,0,,BP142000)}', left=982, top=2138, right=1261, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP143000,0,,BP143000)}', left=1272, top=2138, right=1551, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=503, top=2191, right=685, bottom=2236, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000,0,,BP241000)}', left=695, top=2191, right=974, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP242000,0,,BP242000)}', left=982, top=2191, right=1261, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP243000,0,,BP243000)}', left=1272, top=2191, right=1551, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000+BP242000+BP243000,0,,BP241000+BP242000+BP243000)}', left=1561, top=2191, right=1840, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='' ,left=503 ,top=2246 ,right=685 ,bottom=2291 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=695, top=2246, right=974, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=982, top=2246, right=1261, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1272, top=2246, right=1551, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1561, top=2246, right=1840, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB61000,0,,PB61000)}', left=695, top=2302, right=974, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB62000,0,,PB62000)}', left=982, top=2302, right=1261, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB63000,0,,PB63000)}', left=1272, top=2302, right=1551, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB60000,0,,PB60000)}', left=1561, top=2302, right=1840, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB71000,0,,PB71000)}', left=695, top=2362, right=974, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB72000,0,,PB72000)}', left=982, top=2362, right=1261, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB73000,0,,PB73000)}', left=1272, top=2362, right=1551, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB70000,0,,PB70000)}', left=1561, top=2362, right=1840, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=1550 ,right=87 ,bottom=1590 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1603 ,right=87 ,bottom=1643 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1661 ,right=87 ,bottom=1701 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1714 ,right=87 ,bottom=1753 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1764 ,right=87 ,bottom=1804 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1814 ,right=87 ,bottom=1854 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2159 ,right=87 ,bottom=2196 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2217 ,right=87 ,bottom=2257 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2273 ,right=87 ,bottom=2310 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2328 ,right=87 ,bottom=2365 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2107 ,right=87 ,bottom=2146 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC11000,0,,BC11000)}', left=848, top=976, right=1072, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC12000,0,,BC12000)}', left=848, top=1031, right=1072, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC21000,0,,BC21000)}', left=1106, top=976, right=1330, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC22000,0,,BC22000)}', left=1106, top=1031, right=1330, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM3', left=1356, top=741, right=1580, bottom=786, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO3', left=1356, top=799, right=1580, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC31000,0,,BC31000)}', left=1356, top=976, right=1580, bottom=1020, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC32000,0,,BC32000)}', left=1356, top=1031, right=1580, bottom=1076, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC2000,0,,PBC2000)}', left=1598, top=1031, right=1838, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC1000,0,,PBC1000)}', left=1598, top=976, right=1838, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC10000,0,,PC10000)}', left=595, top=1379, right=819, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC10000,0,,BC10000)}', left=848, top=1379, right=1072, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC20000,0,,BC20000)}', left=1106, top=1379, right=1330, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC3000,0,,BC3000)}', left=1356, top=1379, right=1580, bottom=1424, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TWKSUM,0,,TWKSUM)}', left=1598, top=1379, right=1838, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1321, right=819, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1321, right=1072, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1321, right=1330, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1321, right=1580, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1321, right=1838, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1266, right=819, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1266, right=1072, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1266, right=1330, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1266, right=1580, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1266, right=1838, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1205, right=819, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1205, right=1072, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1205, right=1330, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1205, right=1580, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1205, right=1838, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1147, right=819, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1147, right=1072, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1147, right=1330, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1147, right=1580, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1147, right=1838, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC13000,0,,PC13000)}', left=595, top=1089, right=819, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC13000,0,,BC13000)}', left=848, top=1089, right=1072, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC23000,0,,BC23000)}', left=1106, top=1089, right=1330, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC33000,0,,BC33000)}', left=1356, top=1089, right=1580, bottom=1134, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC3000,0,,PBC3000)}', left=1598, top=1089, right=1838, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1427 ,top=319 ,right=1427 ,bottom=361 </L>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1440, right=819, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1440, right=1330, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1440, right=1580, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=1598, top=1440, right=1838, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT201,0,,BTAXAMT201)}', left=1106, top=1495, right=1330, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1495, right=1580, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+BTAXAMT201,0,,BTAXAMT101+BTAXAMT201)}', left=1598, top=1495, right=1838, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='O01' ,left=408 ,top=1550 ,right=577 ,bottom=1595 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1550, right=819, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1550, right=1072, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1550, right=1330, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1550, right=1580, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1550, right=1838, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Q01' ,left=408 ,top=1606 ,right=577 ,bottom=1651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1606, right=819, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1606, right=1072, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1606, right=1330, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1606, right=1580, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1606, right=1838, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1661, right=819, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=845, top=1661, right=1069, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1103, top=1661, right=1327, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1353, top=1661, right=1577, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1595, top=1661, right=1835, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1717, right=819, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1717, right=1072, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1717, right=1330, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1717, right=1580, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1717, right=1838, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1772, right=1072, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1772, right=1330, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1772, right=1580, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1772, right=1838, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1830, right=819, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1830, right=1072, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1830, right=1330, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1830, right=1580, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1830, right=1838, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1893, right=1072, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1893, right=1330, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1893, right=1580, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1893, right=1838, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1962, right=819, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1962, right=1072, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1962, right=1330, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1962, right=1580, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+PC23000,0,,BTAXAMT101+PC23000)}', left=1598, top=1962, right=1838, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=832 ,top=675 ,right=832 ,bottom=2017 </L>
	<L> left=1087 ,top=675 ,right=1087 ,bottom=2017 </L>
	<L> left=1590 ,top=675 ,right=1590 ,bottom=2017 </L>
	<L> left=192 ,top=2133 ,right=192 ,bottom=2352 </L>
	<C>id='CADDNM', left=592, top=620, right=1819, bottom=664, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='101-85-10695' ,left=592 ,top=446 ,right=885 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ���α� �赿 ������� 140-2' ,left=592 ,top=501 ,right=1727 ,bottom=546 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=592, top=564, right=885, bottom=609, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=592 ,top=388 ,right=885 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=587 ,top=380 ,right=587 ,bottom=2017 </L>
	<L> left=213 ,top=380 ,right=213 ,bottom=670 </L>
	<L> left=213 ,top=614 ,right=1851 ,bottom=614 </L>
	<C>id='CURDT2', left=1332, top=2492, right=1740, bottom=2529 ,mask='XXXX��  02��  28��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=1203 ,top=2550 ,right=1435 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=498 ,top=2133 ,right=498 ,bottom=2297 </L>
	<L> left=498 ,top=2241 ,right=1851 ,bottom=2241 </L>
	<L> left=498 ,top=2186 ,right=1851 ,bottom=2186 </L>
	<T>id='�ⳳ��' ,left=95 ,top=2191 ,right=187 ,bottom=2223 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=95 ,top=2228 ,right=184 ,bottom=2260 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1772, right=819, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
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
	<T>id='���� ��õ¡����(�ٷμҵ�)�� ����(����)�մϴ�.' ,left=29 ,top=2436 ,right=1851 ,bottom=2476 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������  ����' ,left=461 ,top=2587 ,right=740 ,bottom=2631 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��(����)�ǹ���' ,left=742 ,top=2550 ,right=1095 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)��(��)�ٹ���' ,left=197 ,top=2149 ,right=395 ,bottom=2202 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�������׶���' ,left=197 ,top=2188 ,right=398 ,bottom=2244 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����)' ,left=197 ,top=2236 ,right=395 ,bottom=2281 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP141000+BP142000+BP143000,0,,BP141000+BP142000+BP143000)}', left=1561, top=2138, right=1840, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��(��)' ,left=848 ,top=683 ,right=1072 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=1106 ,top=683 ,right=1330 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)-1��������' ,left=1356 ,top=683 ,right=1580 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1598 ,top=683 ,right=1838 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT3', left=590, top=857, right=706, bottom=902, align='left', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUTO', left=721, top=915, right=829, bottom=960, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUFR', left=590, top=915, right=706, bottom=960, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1340 ,top=675 ,right=1340 ,bottom=2017 </L>
	<C>id='BCWKNM1', left=835, top=741, right=1085, bottom=786, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM2', left=1090, top=741, right=1337, bottom=786, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=' ~' ,left=695 ,top=857 ,right=724 ,bottom=902 ,face='Arial' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=721, top=857, right=829, bottom=902, align='left', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT1', left=835, top=857, right=1085, bottom=902, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT2', left=1090, top=857, right=1337, bottom=902, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=405 ,top=2154 ,right=495 ,bottom=2199 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=405 ,top=2191 ,right=495 ,bottom=2236 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=405 ,top=2228 ,right=495 ,bottom=2273 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=835, top=799, right=1085, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1090, top=799, right=1337, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=1432 ,right=1851 ,bottom=1432 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=403 ,top=1437 ,right=403 ,bottom=1949 </L>
	<T>id='��   ��' ,left=97 ,top=683 ,right=569 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)��   ��   ó   ��' ,left=97 ,top=741 ,right=569 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10)����ڵ�Ϲ�ȣ' ,left=97 ,top=799 ,right=569 ,bottom=844 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)�ٹ��Ⱓ' ,left=97 ,top=857 ,right=569 ,bottom=902 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)����Ⱓ' ,left=97 ,top=915 ,right=569 ,bottom=960 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13)��               ��' ,left=97 ,top=976 ,right=569 ,bottom=1020 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14)��               ��' ,left=97 ,top=1031 ,right=569 ,bottom=1076 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)��   ��   ��   ��' ,left=97 ,top=1092 ,right=569 ,bottom=1136 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-1�ֽĸż����ñ� �������' ,left=97 ,top=1150 ,right=569 ,bottom=1194 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-2�츮�������������' ,left=97 ,top=1208 ,right=569 ,bottom=1252 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-3' ,left=97 ,top=1268 ,right=569 ,bottom=1313 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-4' ,left=97 ,top=1324 ,right=569 ,bottom=1368 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)��' ,left=97 ,top=1382 ,right=569 ,bottom=1426 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-1 �߰��ٷμ���' ,left=97 ,top=1553 ,right=384 ,bottom=1598 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-2 ��꺸������' ,left=97 ,top=1608 ,right=384 ,bottom=1653 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-3 �ܱ��αٷ���' ,left=97 ,top=1664 ,right=384 ,bottom=1709 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-4' ,left=97 ,top=1719 ,right=384 ,bottom=1764 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-5' ,left=97 ,top=1775 ,right=384 ,bottom=1819 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-6' ,left=97 ,top=1833 ,right=384 ,bottom=1877 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)�� ���� �����' ,left=97 ,top=1896 ,right=384 ,bottom=1941 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20)������ҵ� ��' ,left=97 ,top=1964 ,right=569 ,bottom=2009 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)��     ��     ��     ��' ,left=97 ,top=2086 ,right=579 ,bottom=2130 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='67)��  ��  ¡  ��  ��  ��' ,left=97 ,top=2365 ,right=579 ,bottom=2410 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='M01' ,left=408 ,top=1440 ,right=577 ,bottom=1484 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=848, top=1440, right=1072, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1495, right=1072, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1495, right=819, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='M02' ,left=408 ,top=1495 ,right=577 ,bottom=1540 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(150����)' ,left=97 ,top=1495 ,right=400 ,bottom=1540 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(100����)' ,left=97 ,top=1440 ,right=398 ,bottom=1484 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='X01' ,left=408 ,top=1664 ,right=577 ,bottom=1709 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=2297 ,right=1851 ,bottom=2297 </L>
</B>





</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='5��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=2650 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=158 ,right=29 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(��2��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=156 ,right=90 ,bottom=2647 </L>
	<L> left=140 ,top=430 ,right=140 ,bottom=2560 </L>
	<T>id='��' ,left=145 ,top=881 ,right=184 ,bottom=910 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1392 ,right=184 ,bottom=1421 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1329 ,right=134 ,bottom=1368 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1160 ,right=84 ,bottom=1200 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1274 ,right=84 ,bottom=1313 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1387 ,right=84 ,bottom=1424 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1484 ,right=84 ,bottom=1521 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1606 ,right=84 ,bottom=1643 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1392 ,right=134 ,bottom=1432 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1458 ,right=134 ,bottom=1495 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1513 ,right=134 ,bottom=1550 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1564 ,right=134 ,bottom=1603 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1614 ,right=134 ,bottom=1656 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=912 ,right=184 ,bottom=941 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=947 ,right=184 ,bottom=976 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=983 ,right=184 ,bottom=1012 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='42)�� �� �� �� �� ��' ,left=95 ,top=2573 ,right=577 ,bottom=2634 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)�� �� ��(16) �Ǵ� 16)- 18)-3)' ,left=97 ,top=169 ,right=663 ,bottom=229 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)�ٷμҵ����' ,left=97 ,top=261 ,right=663 ,bottom=322 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50)���ռҵ� ����ǥ��' ,left=979 ,top=1192 ,right=1459 ,bottom=1252 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB10000,0,,PB10000)}', left=679, top=169, right=964, bottom=229, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='43)���ο�������ҵ����' ,left=1029 ,top=169 ,right=1509 ,bottom=229 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT011S,0,,ETCAMT011S)}', left=1543, top=169, right=1825, bottom=229, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB20000,0,,PB20000)}', left=679, top=261, right=964, bottom=322, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)��������ҵ����' ,left=1029 ,top=261 ,right=1509 ,bottom=322 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT01S,0,,ETCAMT01S)}', left=1543, top=261, right=1825, bottom=322, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='23)�ٷμҵ�ݾ�' ,left=97 ,top=356 ,right=663 ,bottom=417 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB30000,0,,PB30000)}', left=679, top=356, right=964, bottom=417, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-1�ұ�����һ���� �����α� �ҵ����' ,left=1029 ,top=356 ,right=1509 ,bottom=417 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1543, top=356, right=1825, bottom=417, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='24)��         ��' ,left=205 ,top=446 ,right=490 ,bottom=506 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)��   ��   ��' ,left=205 ,top=541 ,right=500 ,bottom=601 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)�ξ簡��(' ,left=205 ,top=630 ,right=392 ,bottom=691 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)��ο��(' ,left=205 ,top=725 ,right=392 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)�� �� �� (' ,left=205 ,top=817 ,right=392 ,bottom=878 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)��   ��   ��' ,left=205 ,top=907 ,right=500 ,bottom=968 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)�ڳ������(' ,left=205 ,top=1002 ,right=421 ,bottom=1063 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=679, top=446, right=964, bottom=506, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-2���ø������� �ҵ����' ,left=1029 ,top=446 ,right=1509 ,bottom=506 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HOUAMT01S,0,,HOUAMT01S)}', left=1543, top=446, right=1825, bottom=506, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=679, top=541, right=964, bottom=601, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='45)�����������ڵ�ҵ����' ,left=1029 ,top=541 ,right=1509 ,bottom=601 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT02S,0,,ETCAMT02S)}', left=1543, top=541, right=1825, bottom=601, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BA0101CNT,0,,BA0101CNT)}', left=395, top=630, right=458, bottom=691 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=630 ,right=516 ,bottom=691 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=679, top=630, right=964, bottom=691, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='46)�ſ�ī���ҵ����' ,left=1029 ,top=630 ,right=1509 ,bottom=691 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT03S,0,,ETCAMT03S)}', left=1543, top=630, right=1825, bottom=691, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TOTCNT02,0,,TOTCNT02)}', left=395, top=725, right=455, bottom=786 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=725 ,right=516 ,bottom=786 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=679, top=725, right=964, bottom=786, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='47)�츮�������ռҵ����' ,left=1029 ,top=725 ,right=1509 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT04S,0,,ETCAMT04S)}', left=1543, top=725, right=1825, bottom=786, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0103CNT,0,,AD0103CNT)}', left=395, top=817, right=455, bottom=878 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=817 ,right=516 ,bottom=878 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=679, top=817, right=964, bottom=878, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='48)����ֽ�������ҵ����' ,left=1029 ,top=817 ,right=1509 ,bottom=878 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(FNDSUMS,0,,FNDSUMS)}', left=1543, top=817, right=1825, bottom=878, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=679, top=907, right=964, bottom=968, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0105CNT,0,,AD0105CNT)}', left=427, top=1002, right=469, bottom=1063 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=471 ,top=1002 ,right=519 ,bottom=1063 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=679, top=1002, right=964, bottom=1063, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT07,0,,ADAMT07)}', left=679, top=1094, right=964, bottom=1155, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1543, top=1094, right=1825, bottom=1155, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='49)�� ���� �ҵ���� ��' ,left=1029 ,top=1094 ,right=1509 ,bottom=1155 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TSTDSUM,0,,TSTDSUM)}', left=1543, top=1192, right=1825, bottom=1252, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='31)���ڳ��߰�����(' ,left=153 ,top=1281 ,right=445 ,bottom=1342 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0106CNT,0,,AD0106CNT)}', left=453, top=1281, right=513, bottom=1342 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=516 ,top=1281 ,right=571 ,bottom=1342 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)���ο��ݺ�������' ,left=200 ,top=1376 ,right=529 ,bottom=1437 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1��Ÿ ���ݺ�������' ,left=197 ,top=1466 ,right=577 ,bottom=1527 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)�������ݼҵ����' ,left=200 ,top=1558 ,right=524 ,bottom=1619 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)��   ��   ��' ,left=200 ,top=1648 ,right=521 ,bottom=1709 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)��   ��   ��' ,left=205 ,top=1835 ,right=527 ,bottom=1896 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)�����������Աݿ����ݻ�ȯ��' ,left=200 ,top=1930 ,right=616 ,bottom=1991 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)-1��������������Ա����ڻ�ȯ��' ,left=200 ,top=2020 ,right=666 ,bottom=2080 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)��α�' ,left=200 ,top=2115 ,right=521 ,bottom=2175 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)' ,left=197 ,top=2207 ,right=519 ,bottom=2268 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)      ��' ,left=200 ,top=2384 ,right=521 ,bottom=2444 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)ǥ �� �� ��' ,left=200 ,top=2481 ,right=521 ,bottom=2542 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT05S,0,,ADAMT05S)}', left=679, top=1281, right=964, bottom=1342, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='51)��     ��     ��     ��' ,left=979 ,top=1281 ,right=1459 ,bottom=1342 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDTAX,0,,STDTAX)}', left=1543, top=1281, right=1825, bottom=1342, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUMS,0,,PENSUMS)}', left=679, top=1376, right=964, bottom=1437, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='52)[��   ��   ��   ��]' ,left=1029 ,top=1376 ,right=1509 ,bottom=1437 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT01S,0,,REDAMT01S)}', left=1543, top=1376, right=1825, bottom=1437, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='53)[����Ư�����ѹ�]' ,left=1029 ,top=1466 ,right=1509 ,bottom=1527 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT02S,0,,REDAMT02S)}', left=1543, top=1466, right=1825, bottom=1527, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT05,0,,ETCAMT05)}', left=679, top=1558, right=964, bottom=1619, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='54)' ,left=1029 ,top=1558 ,right=1509 ,bottom=1619 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=679, top=1648, right=964, bottom=1709, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='35)��   ��   ��' ,left=203 ,top=1738 ,right=524 ,bottom=1798 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=679, top=1738, right=964, bottom=1798, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='55)���װ��� ��' ,left=1029 ,top=1738 ,right=1509 ,bottom=1798 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDSUM,0,,REDSUM)}', left=1543, top=1738, right=1825, bottom=1798, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=679, top=1466, right=961, bottom=1527, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='56)��  ��   ��  ��' ,left=1029 ,top=1835 ,right=1509 ,bottom=1896 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)�������հ���' ,left=1029 ,top=1930 ,right=1509 ,bottom=1991 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)�� �� �� �� ��' ,left=1029 ,top=2020 ,right=1509 ,bottom=2080 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)��� ��ġ�ڱ�' ,left=1029 ,top=2115 ,right=1509 ,bottom=2175 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT01S,0,,DEDAMT01S)}', left=1543, top=1835, right=1825, bottom=1896, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02S,0,,DEDAMT02S)}', left=1543, top=1930, right=1825, bottom=1991, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03S,0,,DEDAMT03S)}', left=1543, top=2020, right=1825, bottom=2080, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04S,0,,DEDAMT04S)}', left=1543, top=2115, right=1825, bottom=2175, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='60)��  ��   ��  ��' ,left=1029 ,top=2207 ,right=1509 ,bottom=2268 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT05S,0,,DEDAMT05S)}', left=1543, top=2207, right=1825, bottom=2268, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=679, top=1835, right=964, bottom=1896, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02S,0,,HOUAMT02S)}', left=679, top=1930, right=964, bottom=1991, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT34S,0,,HOUAMT34S)}', left=679, top=2020, right=964, bottom=2080, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONSUM,0,,CONSUM)}', left=679, top=2115, right=964, bottom=2175, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=679, top=2384, right=964, bottom=2444, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='62)' ,left=1029 ,top=2384 ,right=1509 ,bottom=2444 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1029 ,top=2297 ,right=1509 ,bottom=2357 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=679, top=2481, right=964, bottom=2542, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='63)�� �� �� �� ��' ,left=1029 ,top=2481 ,right=1509 ,bottom=2542 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1543, top=2481, right=1825, bottom=2542, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=679, top=2573, right=964, bottom=2634, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� �� ��[51)-55)-63)]' ,left=979 ,top=2573 ,right=1459 ,bottom=2634 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(RESSUM,0,,RESSUM)}', left=1543, top=2573, right=1825, bottom=2634, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=977 ,top=454 ,right=1016 ,bottom=493 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1421 ,right=184 ,bottom=1450 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1450 ,right=184 ,bottom=1479 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1471 ,right=184 ,bottom=1508 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1503 ,right=184 ,bottom=1535 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1532 ,right=184 ,bottom=1564 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1564 ,right=184 ,bottom=1595 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1484 ,right=1016 ,bottom=1521 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1535 ,right=1016 ,bottom=1571 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1587 ,right=1016 ,bottom=1627 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1645 ,right=1016 ,bottom=1687 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2070 ,right=1016 ,bottom=2107 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2130 ,right=1016 ,bottom=2167 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2194 ,right=1016 ,bottom=2233 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2257 ,right=1016 ,bottom=2299 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=145 ,top=1941 ,right=184 ,bottom=1999 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2030 ,right=184 ,bottom=2088 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2123 ,right=184 ,bottom=2183 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2225 ,right=184 ,bottom=2286 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=501 ,right=184 ,bottom=530 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=530 ,right=184 ,bottom=559 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=559 ,right=184 ,bottom=588 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=588 ,right=184 ,bottom=617 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=559 ,right=1016 ,bottom=599 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=614 ,right=1016 ,bottom=651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=691 ,right=1016 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=736 ,right=1016 ,bottom=773 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=783 ,right=1016 ,bottom=823 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=831 ,right=1016 ,bottom=873 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)-1��������߼ұ���ٷ��ڼҵ����' ,left=1029 ,top=907 ,right=1516 ,bottom=968 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0107CNT,0,,AD0107CNT)}', left=487, top=1094, right=532, bottom=1155 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=532 ,top=1094 ,right=574 ,bottom=1155 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)-1�����Ծ���(' ,left=205 ,top=1094 ,right=484 ,bottom=1155 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>





</R>
</A>


<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='6��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print1'
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=614 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��)' ,left=305 ,top=562 ,right=358 ,bottom=606 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='68)�ҵ���� ��(���������׸��� �ش���� O ǥ�ø� �ϸ�, ���� �ҵ���� �׸��� ������ ���Ͽ� ���� ������ �ݾ��� �����ϴ�)' ,left=71 ,top=87 ,right=1888 ,bottom=148 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=69 ,right=1901 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='������' ,left=71 ,top=324 ,right=147 ,bottom=369 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�' ,left=71 ,top=208 ,right=147 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=158 ,top=166 ,right=427 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=166 ,right=147 ,bottom=208 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=153 ,top=161 ,right=153 ,bottom=488 </L>
	<T>id='�������� �׸�' ,left=103 ,top=493 ,right=374 ,bottom=538 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���ڳ�' ,left=103 ,top=562 ,right=224 ,bottom=606 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=359 ,right=147 ,bottom=403 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��         ȣ' ,left=158 ,top=359 ,right=429 ,bottom=403 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� ��' ,left=158 ,top=324 ,right=429 ,bottom=369 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻' ,left=434 ,top=277 ,right=498 ,bottom=322 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=322 ,right=498 ,bottom=364 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�γ�' ,left=434 ,top=377 ,right=498 ,bottom=414 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=434 ,top=409 ,right=498 ,bottom=446 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=440 ,right=498 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=369 ,right=498 ,bottom=369 </L>
	<T>id='���' ,left=505 ,top=306 ,right=569 ,bottom=351 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=505 ,top=343 ,right=569 ,bottom=388 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=505 ,top=380 ,right=569 ,bottom=422 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=577 ,top=411 ,right=640 ,bottom=456 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=382 ,right=640 ,bottom=419 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ծ�' ,left=577 ,top=343 ,right=640 ,bottom=388 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=327 ,right=640 ,bottom=348 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=577 ,top=293 ,right=640 ,bottom=337 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=648 ,top=301 ,right=711 ,bottom=345 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=648 ,top=337 ,right=711 ,bottom=374 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=648 ,top=372 ,right=711 ,bottom=417 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڳ�' ,left=719 ,top=287 ,right=782 ,bottom=332 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=322 ,right=782 ,bottom=367 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=719 ,top=359 ,right=782 ,bottom=396 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=390 ,right=782 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=161 ,right=429 ,bottom=609 </L>
	<L> left=571 ,top=256 ,right=571 ,bottom=609 </L>
	<L> left=642 ,top=256 ,right=642 ,bottom=609 </L>
	<L> left=713 ,top=256 ,right=713 ,bottom=609 </L>
	<T>id='�������� �׸�' ,left=434 ,top=166 ,right=782 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=543 ,right=498 ,bottom=543 </L>
	<L> left=895 ,top=161 ,right=895 ,bottom=609 </L>
	<T>id='���� �ҵ���� �׸�' ,left=900 ,top=166 ,right=1898 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=932 ,top=290 ,right=1037 ,bottom=335 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ǰ������' ,left=898 ,top=332 ,right=1069 ,bottom=377 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����)' ,left=898 ,top=369 ,right=1069 ,bottom=414 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ��' ,left=1077 ,top=264 ,right=1232 ,bottom=480 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1243 ,top=261 ,right=1398 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1738 ,top=261 ,right=1898 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1732 ,top=256 ,right=1732 ,bottom=609 </L>
	<L> left=1403 ,top=256 ,right=1403 ,bottom=609 </L>
	<L> left=1237 ,top=256 ,right=1237 ,bottom=609 </L>
	<L> left=1072 ,top=256 ,right=1072 ,bottom=609 </L>
	<C>id='{decode(TREF25,0,,TREF25)}', left=1590, top=554, right=1706, bottom=601, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF11,0,,TREF11)}', left=898, top=498, right=1069, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=1077, top=498, right=1232, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1243, top=498, right=1398, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF14,0,,TREF14)}', left=1411, top=498, right=1567, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1577, top=498, right=1727, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1738, top=498, right=1898, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF21,0,,TREF21)}', left=898, top=554, right=1069, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=1077, top=554, right=1232, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1243, top=554, right=1398, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1411, top=554, right=1567, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1738, top=554, right=1898, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=893 ,top=256 ,right=1901 ,bottom=256 </L>
	<T>id='�ڷ�' ,left=795 ,top=293 ,right=893 ,bottom=337 ,supplevel=1 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=795 ,top=335 ,right=893 ,bottom=372 ,supplevel=1 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=795 ,top=496 ,right=893 ,bottom=543 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=554 ,right=893 ,bottom=601 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='�ſ�ī�� ��' ,left=1477 ,top=264 ,right=1667 ,bottom=332 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=1477 ,top=314 ,right=1667 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī�� ��' ,left=1409 ,top=401 ,right=1564 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ī�� ��' ,left=1409 ,top=432 ,right=1569 ,bottom=467 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1577 ,top=432 ,right=1727 ,bottom=467 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1577 ,top=401 ,right=1727 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ϴ� �ο����� ����' ,left=63 ,top=527 ,right=427 ,bottom=564 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��3��)' ,left=1622 ,top=8 ,right=1877 ,bottom=61 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AD0106CNT', left=226, top=562, right=305, bottom=606, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=105 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=105 ,right=1901 ,bottom=105 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=153 ,top=3 ,right=153 ,bottom=105 </L>
	<C>id='RESINO1', left=158, top=58, right=427, bottom=103 ,mask='XXXXXX-XXXXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=158, top=5, right=427, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=429 ,top=0 ,right=429 ,bottom=103 </L>
	<C>id='REF1', left=74, top=58, right=147, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1', left=74, top=5, right=147, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2', left=434, top=5, right=498, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=434, top=58, right=498, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=500 ,top=0 ,right=500 ,bottom=103 </L>
	<C>id='REF5', left=505, top=8, right=569, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=571 ,top=0 ,right=571 ,bottom=103 </L>
	<C>id='REF8', left=577, top=8, right=640, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=642 ,top=0 ,right=642 ,bottom=103 </L>
	<C>id='REF3', left=648, top=8, right=711, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=713 ,top=0 ,right=713 ,bottom=103 </L>
	<L> left=429 ,top=53 ,right=63 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=895 ,top=0 ,right=895 ,bottom=103 </L>
	<L> left=1072 ,top=0 ,right=1072 ,bottom=103 </L>
	<L> left=1237 ,top=0 ,right=1237 ,bottom=103 </L>
	<L> left=1403 ,top=0 ,right=1403 ,bottom=103 </L>
	<L> left=1732 ,top=0 ,right=1732 ,bottom=103 </L>
	<C>id='{decode(REF21,0,,REF21)}', left=898, top=58, right=1069, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=1077, top=58, right=1232, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1243, top=58, right=1398, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1411, top=58, right=1567, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1738, top=58, right=1898, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11,0,,REF11)}', left=898, top=8, right=1069, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=1077, top=8, right=1232, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1243, top=8, right=1398, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1411, top=8, right=1567, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25,0,,REF25)}', left=1601, top=58, right=1706, bottom=103, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1738, top=8, right=1898, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1577, top=8, right=1727, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=795 ,top=8 ,right=893 ,bottom=53 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=58 ,right=893 ,bottom=103 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=898 ,top=53 ,right=1901 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=790 ,top=3 ,right=790 ,bottom=105 </L>
	<C>id='REF4', left=719, top=8, right=782, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=432 ,top=53 ,right=500 ,bottom=53 </L>
	<L> left=790 ,top=53 ,right=903 ,bottom=53 </L>
	<L> left=1572 ,top=0 ,right=1572 ,bottom=103 </L>
	<X>left=1572 ,top=55 ,right=1732 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2001 ,bottom=967 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�� �ۼ����' ,left=74 ,top=13 ,right=279 ,bottom=58 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     (* ISO�����ڵ� : ����ûȨ������->��������->������������->���������ڷ�ǿ��� ��ȸ �� �� �ֽ��ϴ�. ��) ���ѹα�: KR, �̱� : US' ,left=71 ,top=98 ,right=1888 ,bottom=137 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ���� ���޸����� �����Ͽ��� �մϴ�.' ,left=71 ,top=171 ,right=1888 ,bottom=211 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. ��õ¡���ǹ��ڴ� �������� ���ϴ� ������ ���� ���� 3�� 10��(�޾� �Ǵ� ����� ��쿡�� �޾��� �Ǵ� ������� ���ϴ� ���� ���� ���� �� ������ ���մϴ�)' ,left=71 ,top=134 ,right=1888 ,bottom=174 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=61 ,top=965 ,right=1906 ,bottom=965 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='  3. ���ٹ�ó���ҵ������ ������ҵ�(�ܱ��αٷ��� 30% ����� ����)�� ������ �ݾ��� ����, ��.������ҵ������ ���޸��� �ۼ���� ������ҵ��� ������ҵ���' ,left=71 ,top=208 ,right=1888 ,bottom=248 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. �����ٷμҵ�� �����ٷμҵ��� ���Ͽ� ���������ϴ� ������ 16)-1 �������ն��� ���� �����ٷμҵ泳�����հ� �����ٷμҵ���  ����, [�ҵ漼�� �����] ' ,left=71 ,top=279 ,right=1888 ,bottom=319 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ��150���� ���� �������հ����ݾ��� 57)�������հ������� �����ϴ�. �պ�, ������� ���� ������ �ش� ������ ���������� �ϴ� ��쿡 ���պ�����, ' ,left=71 ,top=316 ,right=1888 ,bottom=359 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ������º������� �ҵ��� �ٹ�ó���ҵ�� ��(��)���� ������ �����ϴ�.' ,left=71 ,top=353 ,right=1888 ,bottom=396 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 18-3���� �ܱ��αٷ��ڰ� [����Ư�����ѹ�] �� 18����2��1���� �����ϴ� ��쿡�� ������, 16)����� �ݾ׿� 100���� 30�� ���� �ݾ��� �����ϴ�.' ,left=71 ,top=390 ,right=1888 ,bottom=432 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 21)�ѱ޿������� 16)����� �ݾ��� ����, 18)-3���� �ݾ��� �ִ� ��쿡�� 16)����� �ݾ׿��� 18)-3���� �ݾ��� �� �ݾ��� ������, �ܱ��αٷ��ڰ� ' ,left=71 ,top=427 ,right=1888 ,bottom=469 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    [����Ư�����ѹ�] ��18����2��2�׿� ���� ���ϼ����� �����ϴ� ��쿡�� 16)���� �ݾְ� ������ҵ�ݾ��� ���� �ݾ��� ����, �ҵ漼�� ������ ����� .����.����' ,left=71 ,top=464 ,right=1888 ,bottom=506 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �� ���װ����� ���� ������ �������� �ʽ��ϴ�.' ,left=71 ,top=501 ,right=1888 ,bottom=543 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. ���ռҵ� Ư������[34) ~ 39)]���� �� ���� �ҵ����[43)~47)]���� ���� ��37ȣ������ �������� �����ϴ�.' ,left=71 ,top=541 ,right=1888 ,bottom=580 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. �� ���Ŀ� ���� �ݾ� �� �Ҽ��� ���� ���� ������, 67) ����¡�������� �Ҿ׺�¡��(1õ�� �̸��� ���մϴ�)�� �ش��ϴ� ��� ������ 0 ���� �����ϴ�.' ,left=71 ,top=577 ,right=1888 ,bottom=617 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68) �ҵ���� ������ 2006�� ���� �߻��ϴ� �ٷμҵ� ��������к��� ����մϴ�.' ,left=71 ,top=614 ,right=1888 ,bottom=654 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �����ڵ�� : �ҵ��� ����=0, �ҵ����� ��������=1, ������� ��������=2, �����=3, ������ �ڳ�=4, ������ �ڳ� �� = 5 �����ڸ�=6, ��Ÿ=7�� �����ϴ�' ,left=71 ,top=654 ,right=1888 ,bottom=693 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='           (4��5��6��7�� ��� �ҵ��ڿ� ������� ������ ���踦 �����մϴ�). ' ,left=71 ,top=691 ,right=1888 ,bottom=730 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ��.�ܱ��ζ� : �������� ��� 1 ��, �ܱ����� ��� 9 �� �����ϴ�.' ,left=71 ,top=728 ,right=1888 ,bottom=767 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���������׸�� : �������������� �ִ� ��� �ش���� O ǥ�ø� �մϴ�(�ش������ ���� ��� ����Ӵϴ�).' ,left=71 ,top=765 ,right=1888 ,bottom=804 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ����û �ڷ�� : [�ҵ漼��] ��165���� ���� ����û Ȩ���������� �����ϴ� �� �ҵ���� �׸��� �ݾ� �� �ҵ��������� �Ǵ� �ݾ���  �����ϴ�.' ,left=71 ,top=802 ,right=1888 ,bottom=841 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �� ���� �ڷ�� : ����û���� �����ϴ� �������� ���� ���� ���մϴ�.(���� ���, �п��� ���γ��ο������� �ſ�ī�� �� ����, �÷±����� �Ȱ汸�Ժ�� ' ,left=71 ,top=838 ,right=1888 ,bottom=878 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='        �Ƿ����� ���� �����ϴ�).' ,left=71 ,top=875 ,right=1888 ,bottom=915 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���� �ҵ���� �׸�� : �ҵ�����׸� �ش��ϴ� ���� ����ݾ��� �����ϴ�(�ҵ�������� �ƴ� ���� ���ݾ��� �����׸񺰷� ���е� ���� �ȿ� �����ϴ�).' ,left=71 ,top=912 ,right=1888 ,bottom=952 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �ش� �ڵ庰�� �����Ͽ� �����ϴ�. (������׸��� ���� ��� ��.����� �ҵ���� 20)������ҵ� ����� �Ѿ׸� ���� ��.����� �ҵ���� ������ �ۼ� �����մϴ�.)' ,left=71 ,top=240 ,right=1888 ,bottom=279 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. ���������� ���������ڵ�� ������ڿ� �ش��ϴ� ��쿡 ���Ͽ� ������, ����ǥ��ȭ�ⱸ(ISO)�� ���� ISO�ڵ� �� ������ �� �����ڵ带 �����ϴ�.' ,left=79 ,top=61 ,right=1896 ,bottom=100 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='210��x297��(�Ϲݿ��� 60g/��)' ,left=1206 ,top=2663 ,right=1848 ,bottom=2705 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��1��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1719 ,top=319 ,right=1719 ,bottom=361 </L>
	<L> left=1293 ,top=232 ,right=1830 ,bottom=232 </L>
	<T>id='��1 / ��2' ,left=1585 ,top=279 ,right=1827 ,bottom=314 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ֱ���' ,left=1303 ,top=195 ,right=1514 ,bottom=227 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������1 / �������2' ,left=1530 ,top=195 ,right=1827 ,bottom=227 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ܱ���' ,left=1303 ,top=240 ,right=1514 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=274 ,right=1830 ,bottom=274 </L>
	<T>id='�ܱ��δ��ϼ�������' ,left=1303 ,top=279 ,right=1572 ,bottom=314 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=319 ,right=1830 ,bottom=319 </L>
	<T>id='��������' ,left=1303 ,top=324 ,right=1422 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=361 ,right=1830 ,bottom=361 </L>
	<T>id='������1 / �ܱ���9' ,left=1530 ,top=240 ,right=1827 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������ڵ�' ,left=1530 ,top=324 ,right=1709 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1293 ,top=187 ,right=1830 ,bottom=187 </L>
	<L> left=1293 ,top=187 ,right=1293 ,bottom=361 </L>
	<T>id='[���� ��24ȣ ����(1)]  ' ,left=29 ,top=90 ,right=1438 ,bottom=150 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=380 ,right=1851 ,bottom=380 </L>
	<C>id='HTITLE', left=629, top=298, right=1048, bottom=340, face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ٷμҵ� ���޸���' ,left=598 ,top=240 ,right=1216 ,bottom=287 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷμҵ��õ¡��������' ,left=598 ,top=187 ,right=1216 ,bottom=235 ,align='left' ,face='HY�߰��' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=550 ,top=243 ,right=579 ,bottom=277 ,border=true</X>
	<X>left=550 ,top=192 ,right=579 ,bottom=227 ,border=true</X>
	<T>id='����' ,left=71 ,top=190 ,right=184 ,bottom=229 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=71 ,top=232 ,right=184 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCNT', left=303, top=190, right=390, bottom=269, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2009 -' ,left=205 ,top=190 ,right=321 ,bottom=269 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=185 ,right=192 ,bottom=274 </L>
	<T>id='(���� �Ǵ� ��)' ,left=1482 ,top=2550 ,right=1748 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2418 ,right=1851 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1522 ,top=187 ,right=1522 ,bottom=274 </L>
	<L> left=1830 ,top=190 ,right=1830 ,bottom=361 </L>
	<L> left=1577 ,top=274 ,right=1577 ,bottom=319 </L>
	<L> left=1527 ,top=319 ,right=1527 ,bottom=361 </L>
	<L> left=29 ,top=672 ,right=1851 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�켺��' ,left=221 ,top=564 ,right=508 ,bottom=609 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�Ϲ�ȣ' ,left=221 ,top=446 ,right=508 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� �� �� (�ּ�)' ,left=221 ,top=501 ,right=508 ,bottom=546 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ּ�' ,left=221 ,top=620 ,right=508 ,bottom=664 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��� ǥ �� (��     ��)' ,left=1014 ,top=388 ,right=1356 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1385 ,top=388 ,right=1703 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� �� �� ȣ' ,left=1014 ,top=446 ,right=1356 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1385 ,top=446 ,right=1703 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �� �� ��  �� ȣ' ,left=1014 ,top=564 ,right=1356 ,bottom=609 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1385, top=564, right=1819, bottom=609, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=213 ,top=496 ,right=1851 ,bottom=496 </L>
	<L> left=995 ,top=380 ,right=995 ,bottom=496 </L>
	<L> left=1364 ,top=380 ,right=1364 ,bottom=496 </L>
	<L> left=29 ,top=554 ,right=1851 ,bottom=554 </L>
	<L> left=998 ,top=554 ,right=998 ,bottom=614 </L>
	<L> left=1364 ,top=554 ,right=1364 ,bottom=614 </L>
	<T>id='��� �� �� (�� ȣ)' ,left=221 ,top=388 ,right=508 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǹ���' ,left=37 ,top=469 ,right=208 ,bottom=514 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡   ��' ,left=37 ,top=414 ,right=208 ,bottom=459 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ���' ,left=37 ,top=564 ,right=208 ,bottom=651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=595 ,top=683 ,right=819 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=982, top=915, right=1079, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=840, top=915, right=937, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=857, right=1445, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1348, top=915, right=1445, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=857, right=1585, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1488, top=915, right=1585, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC11000,0,,PC11000)}', left=595, top=976, right=819, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC12000,0,,PC12000)}', left=595, top=1031, right=819, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=857, right=1696, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=857, right=1827, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1603, top=915, right=1696, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1738, top=915, right=1827, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1095, top=915, right=1187, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1222, top=915, right=1319, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=865 ,right=87 ,bottom=904 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=912 ,right=87 ,bottom=952 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=957 ,right=87 ,bottom=997 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ó' ,left=34 ,top=999 ,right=87 ,bottom=1039 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1042 ,right=87 ,bottom=1081 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1129 ,right=87 ,bottom=1168 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1171 ,right=87 ,bottom=1210 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1216 ,right=87 ,bottom=1255 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1084 ,right=87 ,bottom=1123 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��          ��' ,left=100 ,top=2025 ,right=582 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=400 ,top=2133 ,right=400 ,bottom=2297 </L>
	<T>id='�ҵ漼' ,left=695 ,top=2025 ,right=974 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=982 ,top=2025 ,right=1261 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ư����' ,left=1272 ,top=2025 ,right=1551 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1561 ,top=2025 ,right=1840 ,bottom=2070 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB41000,0,,PB41000)}', left=695, top=2083, right=974, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB42000,0,,PB42000)}', left=982, top=2083, right=1261, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB43000,0,,PB43000)}', left=1272, top=2083, right=1551, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB40000,0,,PB40000)}', left=1561, top=2083, right=1840, bottom=2128, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='66)��(��)�ٹ���' ,left=197 ,top=2302 ,right=519 ,bottom=2347 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=503, top=2138, right=685, bottom=2183, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP141000,0,,BP141000)}', left=695, top=2138, right=974, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP142000,0,,BP142000)}', left=982, top=2138, right=1261, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP143000,0,,BP143000)}', left=1272, top=2138, right=1551, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=503, top=2191, right=685, bottom=2236, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000,0,,BP241000)}', left=695, top=2191, right=974, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP242000,0,,BP242000)}', left=982, top=2191, right=1261, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP243000,0,,BP243000)}', left=1272, top=2191, right=1551, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP241000+BP242000+BP243000,0,,BP241000+BP242000+BP243000)}', left=1561, top=2191, right=1840, bottom=2236, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='' ,left=503 ,top=2246 ,right=685 ,bottom=2291 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=695, top=2246, right=974, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=982, top=2246, right=1261, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1272, top=2246, right=1551, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1561, top=2246, right=1840, bottom=2291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB61000,0,,PB61000)}', left=695, top=2302, right=974, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB62000,0,,PB62000)}', left=982, top=2302, right=1261, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB63000,0,,PB63000)}', left=1272, top=2302, right=1551, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB60000,0,,PB60000)}', left=1561, top=2302, right=1840, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB71000,0,,PB71000)}', left=695, top=2362, right=974, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB72000,0,,PB72000)}', left=982, top=2362, right=1261, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB73000,0,,PB73000)}', left=1272, top=2362, right=1551, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB70000,0,,PB70000)}', left=1561, top=2362, right=1840, bottom=2407, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=34 ,top=1550 ,right=87 ,bottom=1590 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1603 ,right=87 ,bottom=1643 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1661 ,right=87 ,bottom=1701 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1714 ,right=87 ,bottom=1753 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1764 ,right=87 ,bottom=1804 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1814 ,right=87 ,bottom=1854 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2159 ,right=87 ,bottom=2196 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2217 ,right=87 ,bottom=2257 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2273 ,right=87 ,bottom=2310 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2328 ,right=87 ,bottom=2365 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2107 ,right=87 ,bottom=2146 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC11000,0,,BC11000)}', left=848, top=976, right=1072, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC12000,0,,BC12000)}', left=848, top=1031, right=1072, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC21000,0,,BC21000)}', left=1106, top=976, right=1330, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC22000,0,,BC22000)}', left=1106, top=1031, right=1330, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM3', left=1356, top=741, right=1580, bottom=786, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO3', left=1356, top=799, right=1580, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC31000,0,,BC31000)}', left=1356, top=976, right=1580, bottom=1020, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC32000,0,,BC32000)}', left=1356, top=1031, right=1580, bottom=1076, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC2000,0,,PBC2000)}', left=1598, top=1031, right=1838, bottom=1076, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC1000,0,,PBC1000)}', left=1598, top=976, right=1838, bottom=1020, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC10000,0,,PC10000)}', left=595, top=1379, right=819, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC10000,0,,BC10000)}', left=848, top=1379, right=1072, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC20000,0,,BC20000)}', left=1106, top=1379, right=1330, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC3000,0,,BC3000)}', left=1356, top=1379, right=1580, bottom=1424, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TWKSUM,0,,TWKSUM)}', left=1598, top=1379, right=1838, bottom=1424, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1321, right=819, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1321, right=1072, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1321, right=1330, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1321, right=1580, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1321, right=1838, bottom=1366, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1266, right=819, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1266, right=1072, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1266, right=1330, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1266, right=1580, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1266, right=1838, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1205, right=819, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1205, right=1072, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1205, right=1330, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1205, right=1580, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1205, right=1838, bottom=1250, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1147, right=819, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1147, right=1072, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1147, right=1330, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1147, right=1580, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1147, right=1838, bottom=1192, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC13000,0,,PC13000)}', left=595, top=1089, right=819, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC13000,0,,BC13000)}', left=848, top=1089, right=1072, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC23000,0,,BC23000)}', left=1106, top=1089, right=1330, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC33000,0,,BC33000)}', left=1356, top=1089, right=1580, bottom=1134, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC3000,0,,PBC3000)}', left=1598, top=1089, right=1838, bottom=1134, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1427 ,top=319 ,right=1427 ,bottom=361 </L>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1440, right=819, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1440, right=1330, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1440, right=1580, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=1598, top=1440, right=1838, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT201,0,,BTAXAMT201)}', left=1106, top=1495, right=1330, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1495, right=1580, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+BTAXAMT201,0,,BTAXAMT101+BTAXAMT201)}', left=1598, top=1495, right=1838, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='O01' ,left=408 ,top=1550 ,right=577 ,bottom=1595 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1550, right=819, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1550, right=1072, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1550, right=1330, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1550, right=1580, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1550, right=1838, bottom=1595, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Q01' ,left=408 ,top=1606 ,right=577 ,bottom=1651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1606, right=819, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1606, right=1072, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1606, right=1330, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1606, right=1580, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1606, right=1838, bottom=1651, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1661, right=819, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=845, top=1661, right=1069, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1103, top=1661, right=1327, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1353, top=1661, right=1577, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1595, top=1661, right=1835, bottom=1706, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1717, right=819, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1717, right=1072, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1717, right=1330, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1717, right=1580, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1717, right=1838, bottom=1761, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1772, right=1072, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1772, right=1330, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1772, right=1580, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1772, right=1838, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1830, right=819, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1830, right=1072, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1830, right=1330, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1830, right=1580, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1830, right=1838, bottom=1875, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=848, top=1893, right=1072, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1893, right=1330, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1893, right=1580, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1598, top=1893, right=1838, bottom=1938, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC23000,0,,PC23000)}', left=595, top=1962, right=819, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1962, right=1072, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1106, top=1962, right=1330, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1356, top=1962, right=1580, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101+PC23000,0,,BTAXAMT101+PC23000)}', left=1598, top=1962, right=1838, bottom=2007, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=832 ,top=675 ,right=832 ,bottom=2017 </L>
	<L> left=1087 ,top=675 ,right=1087 ,bottom=2017 </L>
	<L> left=1590 ,top=675 ,right=1590 ,bottom=2017 </L>
	<L> left=192 ,top=2133 ,right=192 ,bottom=2352 </L>
	<C>id='CADDNM', left=592, top=620, right=1819, bottom=664, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='101-85-10695' ,left=592 ,top=446 ,right=885 ,bottom=490 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ���α� �赿 ������� 140-2' ,left=592 ,top=501 ,right=1727 ,bottom=546 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=592, top=564, right=885, bottom=609, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=592 ,top=388 ,right=885 ,bottom=432 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=587 ,top=380 ,right=587 ,bottom=2017 </L>
	<L> left=213 ,top=380 ,right=213 ,bottom=670 </L>
	<L> left=213 ,top=614 ,right=1851 ,bottom=614 </L>
	<C>id='CURDT2', left=1332, top=2492, right=1740, bottom=2529 ,mask='XXXX��  02��  28��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��)' ,left=1203 ,top=2550 ,right=1435 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=498 ,top=2133 ,right=498 ,bottom=2297 </L>
	<L> left=498 ,top=2241 ,right=1851 ,bottom=2241 </L>
	<L> left=498 ,top=2186 ,right=1851 ,bottom=2186 </L>
	<T>id='�ⳳ��' ,left=95 ,top=2191 ,right=187 ,bottom=2223 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=95 ,top=2228 ,right=184 ,bottom=2260 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=595, top=1772, right=819, bottom=1817, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
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
	<T>id='���� ��õ¡����(�ٷμҵ�)�� ����(����)�մϴ�.' ,left=29 ,top=2436 ,right=1851 ,bottom=2476 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������  ����' ,left=461 ,top=2587 ,right=740 ,bottom=2631 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��(����)�ǹ���' ,left=742 ,top=2550 ,right=1095 ,bottom=2584 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)��(��)�ٹ���' ,left=197 ,top=2149 ,right=395 ,bottom=2202 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�������׶���' ,left=197 ,top=2188 ,right=398 ,bottom=2244 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����)' ,left=197 ,top=2236 ,right=395 ,bottom=2281 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP141000+BP142000+BP143000,0,,BP141000+BP142000+BP143000)}', left=1561, top=2138, right=1840, bottom=2183, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��(��)' ,left=848 ,top=683 ,right=1072 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=1106 ,top=683 ,right=1330 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)-1��������' ,left=1356 ,top=683 ,right=1580 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1598 ,top=683 ,right=1838 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT3', left=590, top=857, right=706, bottom=902, align='left', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUTO', left=721, top=915, right=829, bottom=960, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUFR', left=590, top=915, right=706, bottom=960, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1340 ,top=675 ,right=1340 ,bottom=2017 </L>
	<C>id='BCWKNM1', left=835, top=741, right=1085, bottom=786, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM2', left=1090, top=741, right=1337, bottom=786, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=' ~' ,left=695 ,top=857 ,right=724 ,bottom=902 ,face='Arial' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=721, top=857, right=829, bottom=902, align='left', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT1', left=835, top=857, right=1085, bottom=902, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BFSTRDT2', left=1090, top=857, right=1337, bottom=902, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=405 ,top=2154 ,right=495 ,bottom=2199 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=405 ,top=2191 ,right=495 ,bottom=2236 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=405 ,top=2228 ,right=495 ,bottom=2273 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCRESINO1', left=835, top=799, right=1085, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1090, top=799, right=1337, bottom=844, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=1432 ,right=1851 ,bottom=1432 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=403 ,top=1437 ,right=403 ,bottom=1949 </L>
	<T>id='��   ��' ,left=97 ,top=683 ,right=569 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)��   ��   ó   ��' ,left=97 ,top=741 ,right=569 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10)����ڵ�Ϲ�ȣ' ,left=97 ,top=799 ,right=569 ,bottom=844 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)�ٹ��Ⱓ' ,left=97 ,top=857 ,right=569 ,bottom=902 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)����Ⱓ' ,left=97 ,top=915 ,right=569 ,bottom=960 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13)��               ��' ,left=97 ,top=976 ,right=569 ,bottom=1020 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14)��               ��' ,left=97 ,top=1031 ,right=569 ,bottom=1076 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)��   ��   ��   ��' ,left=97 ,top=1092 ,right=569 ,bottom=1136 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-1�ֽĸż����ñ� �������' ,left=97 ,top=1150 ,right=569 ,bottom=1194 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-2�츮�������������' ,left=97 ,top=1208 ,right=569 ,bottom=1252 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-3' ,left=97 ,top=1268 ,right=569 ,bottom=1313 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-4' ,left=97 ,top=1324 ,right=569 ,bottom=1368 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)��' ,left=97 ,top=1382 ,right=569 ,bottom=1426 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-1 �߰��ٷμ���' ,left=97 ,top=1553 ,right=384 ,bottom=1598 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-2 ��꺸������' ,left=97 ,top=1608 ,right=384 ,bottom=1653 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-3 �ܱ��αٷ���' ,left=97 ,top=1664 ,right=384 ,bottom=1709 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-4' ,left=97 ,top=1719 ,right=384 ,bottom=1764 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-5' ,left=97 ,top=1775 ,right=384 ,bottom=1819 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-6' ,left=97 ,top=1833 ,right=384 ,bottom=1877 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)�� ���� �����' ,left=97 ,top=1896 ,right=384 ,bottom=1941 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20)������ҵ� ��' ,left=97 ,top=1964 ,right=569 ,bottom=2009 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)��     ��     ��     ��' ,left=97 ,top=2086 ,right=579 ,bottom=2130 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='67)��  ��  ¡  ��  ��  ��' ,left=97 ,top=2365 ,right=579 ,bottom=2410 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='M01' ,left=408 ,top=1440 ,right=577 ,bottom=1484 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=848, top=1440, right=1072, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BTAXAMT101,0,,BTAXAMT101)}', left=848, top=1495, right=1072, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=595, top=1495, right=819, bottom=1540, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='M02' ,left=408 ,top=1495 ,right=577 ,bottom=1540 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(150����)' ,left=97 ,top=1495 ,right=400 ,bottom=1540 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18) ���ܱٷ�(100����)' ,left=97 ,top=1440 ,right=398 ,bottom=1484 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='X01' ,left=408 ,top=1664 ,right=577 ,bottom=1709 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=192 ,top=2297 ,right=1851 ,bottom=2297 </L>
</B>





</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='8��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=2650 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=158 ,right=29 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(��2��)' ,left=1690 ,top=90 ,right=1848 ,bottom=150 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1851 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1851 ,top=156 ,right=1851 ,bottom=2650 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=156 ,right=90 ,bottom=2647 </L>
	<L> left=140 ,top=430 ,right=140 ,bottom=2560 </L>
	<T>id='��' ,left=145 ,top=881 ,right=184 ,bottom=910 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1392 ,right=184 ,bottom=1421 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1329 ,right=134 ,bottom=1368 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1160 ,right=84 ,bottom=1200 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1274 ,right=84 ,bottom=1313 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1387 ,right=84 ,bottom=1424 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1484 ,right=84 ,bottom=1521 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=39 ,top=1606 ,right=84 ,bottom=1643 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1392 ,right=134 ,bottom=1432 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1458 ,right=134 ,bottom=1495 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1513 ,right=134 ,bottom=1550 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1564 ,right=134 ,bottom=1603 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=95 ,top=1614 ,right=134 ,bottom=1656 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=912 ,right=184 ,bottom=941 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=947 ,right=184 ,bottom=976 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=983 ,right=184 ,bottom=1012 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='42)�� �� �� �� �� ��' ,left=95 ,top=2573 ,right=577 ,bottom=2634 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)�� �� ��(16) �Ǵ� 16)- 18)-3)' ,left=97 ,top=169 ,right=663 ,bottom=229 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)�ٷμҵ����' ,left=97 ,top=261 ,right=663 ,bottom=322 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50)���ռҵ� ����ǥ��' ,left=979 ,top=1192 ,right=1459 ,bottom=1252 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB10000,0,,PB10000)}', left=679, top=169, right=964, bottom=229, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='43)���ο�������ҵ����' ,left=1029 ,top=169 ,right=1509 ,bottom=229 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT011S,0,,ETCAMT011S)}', left=1543, top=169, right=1825, bottom=229, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB20000,0,,PB20000)}', left=679, top=261, right=964, bottom=322, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)��������ҵ����' ,left=1029 ,top=261 ,right=1509 ,bottom=322 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT01S,0,,ETCAMT01S)}', left=1543, top=261, right=1825, bottom=322, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='23)�ٷμҵ�ݾ�' ,left=97 ,top=356 ,right=663 ,bottom=417 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB30000,0,,PB30000)}', left=679, top=356, right=964, bottom=417, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-1�ұ�����һ���� �����α� �ҵ����' ,left=1029 ,top=356 ,right=1509 ,bottom=417 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1543, top=356, right=1825, bottom=417, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='24)��         ��' ,left=205 ,top=446 ,right=490 ,bottom=506 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)��   ��   ��' ,left=205 ,top=541 ,right=500 ,bottom=601 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)�ξ簡��(' ,left=205 ,top=630 ,right=392 ,bottom=691 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)��ο��(' ,left=205 ,top=725 ,right=392 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)�� �� �� (' ,left=205 ,top=817 ,right=392 ,bottom=878 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)��   ��   ��' ,left=205 ,top=907 ,right=500 ,bottom=968 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)�ڳ������(' ,left=205 ,top=1002 ,right=421 ,bottom=1063 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=679, top=446, right=964, bottom=506, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-2���ø������� �ҵ����' ,left=1029 ,top=446 ,right=1509 ,bottom=506 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HOUAMT01S,0,,HOUAMT01S)}', left=1543, top=446, right=1825, bottom=506, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=679, top=541, right=964, bottom=601, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='45)�����������ڵ�ҵ����' ,left=1029 ,top=541 ,right=1509 ,bottom=601 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT02S,0,,ETCAMT02S)}', left=1543, top=541, right=1825, bottom=601, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BA0101CNT,0,,BA0101CNT)}', left=395, top=630, right=458, bottom=691 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=630 ,right=516 ,bottom=691 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=679, top=630, right=964, bottom=691, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='46)�ſ�ī���ҵ����' ,left=1029 ,top=630 ,right=1509 ,bottom=691 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT03S,0,,ETCAMT03S)}', left=1543, top=630, right=1825, bottom=691, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TOTCNT02,0,,TOTCNT02)}', left=395, top=725, right=455, bottom=786 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=725 ,right=516 ,bottom=786 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=679, top=725, right=964, bottom=786, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='47)�츮�������ռҵ����' ,left=1029 ,top=725 ,right=1509 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT04S,0,,ETCAMT04S)}', left=1543, top=725, right=1825, bottom=786, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0103CNT,0,,AD0103CNT)}', left=395, top=817, right=455, bottom=878 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=461 ,top=817 ,right=516 ,bottom=878 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=679, top=817, right=964, bottom=878, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='48)����ֽ�������ҵ����' ,left=1029 ,top=817 ,right=1509 ,bottom=878 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(FNDSUMS,0,,FNDSUMS)}', left=1543, top=817, right=1825, bottom=878, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=679, top=907, right=964, bottom=968, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0105CNT,0,,AD0105CNT)}', left=427, top=1002, right=469, bottom=1063 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=471 ,top=1002 ,right=519 ,bottom=1063 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=679, top=1002, right=964, bottom=1063, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT07,0,,ADAMT07)}', left=679, top=1094, right=964, bottom=1155, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1543, top=1094, right=1825, bottom=1155, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='49)�� ���� �ҵ���� ��' ,left=1029 ,top=1094 ,right=1509 ,bottom=1155 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TSTDSUM,0,,TSTDSUM)}', left=1543, top=1192, right=1825, bottom=1252, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='31)���ڳ��߰�����(' ,left=153 ,top=1281 ,right=445 ,bottom=1342 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0106CNT,0,,AD0106CNT)}', left=453, top=1281, right=513, bottom=1342 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=516 ,top=1281 ,right=571 ,bottom=1342 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)���ο��ݺ�������' ,left=200 ,top=1376 ,right=529 ,bottom=1437 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1��Ÿ ���ݺ�������' ,left=197 ,top=1466 ,right=577 ,bottom=1527 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)�������ݼҵ����' ,left=200 ,top=1558 ,right=524 ,bottom=1619 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)��   ��   ��' ,left=200 ,top=1648 ,right=521 ,bottom=1709 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)��   ��   ��' ,left=205 ,top=1835 ,right=527 ,bottom=1896 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)�����������Աݿ����ݻ�ȯ��' ,left=200 ,top=1930 ,right=616 ,bottom=1991 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)-1��������������Ա����ڻ�ȯ��' ,left=200 ,top=2020 ,right=666 ,bottom=2080 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)��α�' ,left=200 ,top=2115 ,right=521 ,bottom=2175 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)' ,left=197 ,top=2207 ,right=519 ,bottom=2268 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)      ��' ,left=200 ,top=2384 ,right=521 ,bottom=2444 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)ǥ �� �� ��' ,left=200 ,top=2481 ,right=521 ,bottom=2542 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT05S,0,,ADAMT05S)}', left=679, top=1281, right=964, bottom=1342, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='51)��     ��     ��     ��' ,left=979 ,top=1281 ,right=1459 ,bottom=1342 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDTAX,0,,STDTAX)}', left=1543, top=1281, right=1825, bottom=1342, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUMS,0,,PENSUMS)}', left=679, top=1376, right=964, bottom=1437, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='52)[��   ��   ��   ��]' ,left=1029 ,top=1376 ,right=1509 ,bottom=1437 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT01S,0,,REDAMT01S)}', left=1543, top=1376, right=1825, bottom=1437, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='53)[����Ư�����ѹ�]' ,left=1029 ,top=1466 ,right=1509 ,bottom=1527 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT02S,0,,REDAMT02S)}', left=1543, top=1466, right=1825, bottom=1527, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT05,0,,ETCAMT05)}', left=679, top=1558, right=964, bottom=1619, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='54)' ,left=1029 ,top=1558 ,right=1509 ,bottom=1619 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=679, top=1648, right=964, bottom=1709, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='35)��   ��   ��' ,left=203 ,top=1738 ,right=524 ,bottom=1798 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=679, top=1738, right=964, bottom=1798, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='55)���װ��� ��' ,left=1029 ,top=1738 ,right=1509 ,bottom=1798 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDSUM,0,,REDSUM)}', left=1543, top=1738, right=1825, bottom=1798, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=679, top=1466, right=961, bottom=1527, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='56)��  ��   ��  ��' ,left=1029 ,top=1835 ,right=1509 ,bottom=1896 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)�������հ���' ,left=1029 ,top=1930 ,right=1509 ,bottom=1991 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)�� �� �� �� ��' ,left=1029 ,top=2020 ,right=1509 ,bottom=2080 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)��� ��ġ�ڱ�' ,left=1029 ,top=2115 ,right=1509 ,bottom=2175 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT01S,0,,DEDAMT01S)}', left=1543, top=1835, right=1825, bottom=1896, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02S,0,,DEDAMT02S)}', left=1543, top=1930, right=1825, bottom=1991, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03S,0,,DEDAMT03S)}', left=1543, top=2020, right=1825, bottom=2080, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04S,0,,DEDAMT04S)}', left=1543, top=2115, right=1825, bottom=2175, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='60)��  ��   ��  ��' ,left=1029 ,top=2207 ,right=1509 ,bottom=2268 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT05S,0,,DEDAMT05S)}', left=1543, top=2207, right=1825, bottom=2268, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=679, top=1835, right=964, bottom=1896, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02S,0,,HOUAMT02S)}', left=679, top=1930, right=964, bottom=1991, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT34S,0,,HOUAMT34S)}', left=679, top=2020, right=964, bottom=2080, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONSUM,0,,CONSUM)}', left=679, top=2115, right=964, bottom=2175, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=679, top=2384, right=964, bottom=2444, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='62)' ,left=1029 ,top=2384 ,right=1509 ,bottom=2444 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1029 ,top=2297 ,right=1509 ,bottom=2357 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=679, top=2481, right=964, bottom=2542, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='63)�� �� �� �� ��' ,left=1029 ,top=2481 ,right=1509 ,bottom=2542 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1543, top=2481, right=1825, bottom=2542, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=679, top=2573, right=964, bottom=2634, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� �� ��[51)-55)-63)]' ,left=979 ,top=2573 ,right=1459 ,bottom=2634 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(RESSUM,0,,RESSUM)}', left=1543, top=2573, right=1825, bottom=2634, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=977 ,top=454 ,right=1016 ,bottom=493 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1421 ,right=184 ,bottom=1450 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1450 ,right=184 ,bottom=1479 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1471 ,right=184 ,bottom=1508 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1503 ,right=184 ,bottom=1535 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1532 ,right=184 ,bottom=1564 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=1564 ,right=184 ,bottom=1595 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1484 ,right=1016 ,bottom=1521 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1535 ,right=1016 ,bottom=1571 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1587 ,right=1016 ,bottom=1627 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=1645 ,right=1016 ,bottom=1687 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2070 ,right=1016 ,bottom=2107 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2130 ,right=1016 ,bottom=2167 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2194 ,right=1016 ,bottom=2233 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=2257 ,right=1016 ,bottom=2299 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=145 ,top=1941 ,right=184 ,bottom=1999 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2030 ,right=184 ,bottom=2088 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2123 ,right=184 ,bottom=2183 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=2225 ,right=184 ,bottom=2286 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=501 ,right=184 ,bottom=530 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=530 ,right=184 ,bottom=559 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=559 ,right=184 ,bottom=588 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=145 ,top=588 ,right=184 ,bottom=617 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=559 ,right=1016 ,bottom=599 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=614 ,right=1016 ,bottom=651 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=691 ,right=1016 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=736 ,right=1016 ,bottom=773 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=783 ,right=1016 ,bottom=823 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=977 ,top=831 ,right=1016 ,bottom=873 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)-1��������߼ұ���ٷ��ڼҵ����' ,left=1029 ,top=907 ,right=1516 ,bottom=968 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0107CNT,0,,AD0107CNT)}', left=487, top=1094, right=532, bottom=1155 ,mask='(XX��)', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��)' ,left=532 ,top=1094 ,right=574 ,bottom=1155 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)-1�����Ծ���(' ,left=205 ,top=1094 ,right=484 ,bottom=1155 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>


<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='9��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print1'
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=614 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��)' ,left=305 ,top=562 ,right=358 ,bottom=606 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='68)�ҵ���� ��(���������׸��� �ش���� O ǥ�ø� �ϸ�, ���� �ҵ���� �׸��� ������ ���Ͽ� ���� ������ �ݾ��� �����ϴ�)' ,left=71 ,top=87 ,right=1888 ,bottom=148 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=69 ,right=1901 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='������' ,left=71 ,top=324 ,right=147 ,bottom=369 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�' ,left=71 ,top=208 ,right=147 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=158 ,top=166 ,right=427 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=166 ,right=147 ,bottom=208 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=153 ,top=161 ,right=153 ,bottom=488 </L>
	<T>id='�������� �׸�' ,left=103 ,top=493 ,right=374 ,bottom=538 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���ڳ�' ,left=103 ,top=562 ,right=224 ,bottom=606 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=359 ,right=147 ,bottom=403 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��         ȣ' ,left=158 ,top=359 ,right=429 ,bottom=403 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� ��' ,left=158 ,top=324 ,right=429 ,bottom=369 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻' ,left=434 ,top=277 ,right=498 ,bottom=322 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=322 ,right=498 ,bottom=364 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�γ�' ,left=434 ,top=377 ,right=498 ,bottom=414 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=434 ,top=409 ,right=498 ,bottom=446 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=434 ,top=440 ,right=498 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=369 ,right=498 ,bottom=369 </L>
	<T>id='���' ,left=505 ,top=306 ,right=569 ,bottom=351 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=505 ,top=343 ,right=569 ,bottom=388 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=505 ,top=380 ,right=569 ,bottom=422 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=577 ,top=411 ,right=640 ,bottom=456 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=382 ,right=640 ,bottom=419 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ծ�' ,left=577 ,top=343 ,right=640 ,bottom=388 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=577 ,top=327 ,right=640 ,bottom=348 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=577 ,top=293 ,right=640 ,bottom=337 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=648 ,top=301 ,right=711 ,bottom=345 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=648 ,top=337 ,right=711 ,bottom=374 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=648 ,top=372 ,right=711 ,bottom=417 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڳ�' ,left=719 ,top=287 ,right=782 ,bottom=332 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=322 ,right=782 ,bottom=367 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=719 ,top=359 ,right=782 ,bottom=396 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=390 ,right=782 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=161 ,right=429 ,bottom=609 </L>
	<L> left=571 ,top=256 ,right=571 ,bottom=609 </L>
	<L> left=642 ,top=256 ,right=642 ,bottom=609 </L>
	<L> left=713 ,top=256 ,right=713 ,bottom=609 </L>
	<T>id='�������� �׸�' ,left=434 ,top=166 ,right=782 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=543 ,right=498 ,bottom=543 </L>
	<L> left=895 ,top=161 ,right=895 ,bottom=609 </L>
	<T>id='���� �ҵ���� �׸�' ,left=900 ,top=166 ,right=1898 ,bottom=253 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=932 ,top=290 ,right=1037 ,bottom=335 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ǰ������' ,left=898 ,top=332 ,right=1069 ,bottom=377 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����)' ,left=898 ,top=369 ,right=1069 ,bottom=414 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ��' ,left=1077 ,top=264 ,right=1232 ,bottom=480 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1243 ,top=261 ,right=1398 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1738 ,top=261 ,right=1898 ,bottom=477 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1732 ,top=256 ,right=1732 ,bottom=609 </L>
	<L> left=1403 ,top=256 ,right=1403 ,bottom=609 </L>
	<L> left=1237 ,top=256 ,right=1237 ,bottom=609 </L>
	<L> left=1072 ,top=256 ,right=1072 ,bottom=609 </L>
	<C>id='{decode(TREF25,0,,TREF25)}', left=1590, top=554, right=1706, bottom=601, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF11,0,,TREF11)}', left=898, top=498, right=1069, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=1077, top=498, right=1232, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1243, top=498, right=1398, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF14,0,,TREF14)}', left=1411, top=498, right=1567, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1577, top=498, right=1727, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1738, top=498, right=1898, bottom=543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF21,0,,TREF21)}', left=898, top=554, right=1069, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=1077, top=554, right=1232, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1243, top=554, right=1398, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1411, top=554, right=1567, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1738, top=554, right=1898, bottom=601, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=893 ,top=256 ,right=1901 ,bottom=256 </L>
	<T>id='�ڷ�' ,left=795 ,top=293 ,right=893 ,bottom=337 ,supplevel=1 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=795 ,top=335 ,right=893 ,bottom=372 ,supplevel=1 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=795 ,top=496 ,right=893 ,bottom=543 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=554 ,right=893 ,bottom=601 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='�ſ�ī�� ��' ,left=1477 ,top=264 ,right=1667 ,bottom=332 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=1477 ,top=314 ,right=1667 ,bottom=356 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī�� ��' ,left=1409 ,top=401 ,right=1564 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ī�� ��' ,left=1409 ,top=432 ,right=1569 ,bottom=467 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1577 ,top=432 ,right=1727 ,bottom=467 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1577 ,top=401 ,right=1727 ,bottom=435 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ϴ� �ο����� ����' ,left=63 ,top=527 ,right=427 ,bottom=564 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��3��)' ,left=1622 ,top=8 ,right=1877 ,bottom=61 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AD0106CNT', left=226, top=562, right=305, bottom=606, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=105 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=105 ,right=1901 ,bottom=105 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=105 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=153 ,top=3 ,right=153 ,bottom=105 </L>
	<C>id='RESINO1', left=158, top=58, right=427, bottom=103 ,mask='XXXXXX-XXXXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=158, top=5, right=427, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=429 ,top=0 ,right=429 ,bottom=103 </L>
	<C>id='{decode(REF1,T,��,T,��,)}', left=74, top=58, right=147, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1', left=74, top=5, right=147, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2', left=434, top=5, right=498, bottom=50, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=434, top=58, right=498, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=500 ,top=0 ,right=500 ,bottom=103 </L>
	<C>id='REF5', left=505, top=8, right=569, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=571 ,top=0 ,right=571 ,bottom=103 </L>
	<C>id='REF8', left=577, top=8, right=640, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=642 ,top=0 ,right=642 ,bottom=103 </L>
	<C>id='REF3', left=648, top=8, right=711, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=713 ,top=0 ,right=713 ,bottom=103 </L>
	<L> left=429 ,top=53 ,right=63 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=895 ,top=0 ,right=895 ,bottom=103 </L>
	<L> left=1072 ,top=0 ,right=1072 ,bottom=103 </L>
	<L> left=1237 ,top=0 ,right=1237 ,bottom=103 </L>
	<L> left=1403 ,top=0 ,right=1403 ,bottom=103 </L>
	<L> left=1732 ,top=0 ,right=1732 ,bottom=103 </L>
	<C>id='{decode(REF21,0,,REF21)}', left=898, top=58, right=1069, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=1077, top=58, right=1232, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1243, top=58, right=1398, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1411, top=58, right=1567, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1738, top=58, right=1898, bottom=103, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11,0,,REF11)}', left=898, top=8, right=1069, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=1077, top=8, right=1232, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1243, top=8, right=1398, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1411, top=8, right=1567, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25,0,,REF25)}', left=1601, top=58, right=1706, bottom=103, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1738, top=8, right=1898, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1577, top=8, right=1727, bottom=53, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����û' ,left=795 ,top=8 ,right=893 ,bottom=53 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=795 ,top=58 ,right=893 ,bottom=103 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=898 ,top=53 ,right=1901 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=790 ,top=3 ,right=790 ,bottom=105 </L>
	<C>id='REF4', left=719, top=8, right=782, bottom=103, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=432 ,top=53 ,right=500 ,bottom=53 </L>
	<L> left=790 ,top=53 ,right=903 ,bottom=53 </L>
	<L> left=1572 ,top=0 ,right=1572 ,bottom=103 </L>
	<X>left=1572 ,top=55 ,right=1732 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2001 ,bottom=967 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�� �ۼ����' ,left=74 ,top=13 ,right=279 ,bottom=58 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     (* ISO�����ڵ� : ����ûȨ������->��������->������������->���������ڷ�ǿ��� ��ȸ �� �� �ֽ��ϴ�. ��) ���ѹα�: KR, �̱� : US' ,left=71 ,top=98 ,right=1888 ,bottom=137 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ���� ���޸����� �����Ͽ��� �մϴ�.' ,left=71 ,top=171 ,right=1888 ,bottom=211 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. ��õ¡���ǹ��ڴ� �������� ���ϴ� ������ ���� ���� 3�� 10��(�޾� �Ǵ� ����� ��쿡�� �޾��� �Ǵ� ������� ���ϴ� ���� ���� ���� �� ������ ���մϴ�)' ,left=71 ,top=134 ,right=1888 ,bottom=174 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=61 ,top=965 ,right=1906 ,bottom=965 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='  3. ���ٹ�ó���ҵ������ ������ҵ�(�ܱ��αٷ��� 30% ����� ����)�� ������ �ݾ��� ����, ��.������ҵ������ ���޸��� �ۼ���� ������ҵ��� ������ҵ���' ,left=71 ,top=208 ,right=1888 ,bottom=248 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. �����ٷμҵ�� �����ٷμҵ��� ���Ͽ� ���������ϴ� ������ 16)-1 �������ն��� ���� �����ٷμҵ泳�����հ� �����ٷμҵ���  ����, [�ҵ漼�� �����] ' ,left=71 ,top=279 ,right=1888 ,bottom=319 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ��150���� ���� �������հ����ݾ��� 57)�������հ������� �����ϴ�. �պ�, ������� ���� ������ �ش� ������ ���������� �ϴ� ��쿡 ���պ�����, ' ,left=71 ,top=316 ,right=1888 ,bottom=359 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ������º������� �ҵ��� �ٹ�ó���ҵ�� ��(��)���� ������ �����ϴ�.' ,left=71 ,top=353 ,right=1888 ,bottom=396 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 18-3���� �ܱ��αٷ��ڰ� [����Ư�����ѹ�] �� 18����2��1���� �����ϴ� ��쿡�� ������, 16)����� �ݾ׿� 100���� 30�� ���� �ݾ��� �����ϴ�.' ,left=71 ,top=390 ,right=1888 ,bottom=432 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 21)�ѱ޿������� 16)����� �ݾ��� ����, 18)-3���� �ݾ��� �ִ� ��쿡�� 16)����� �ݾ׿��� 18)-3���� �ݾ��� �� �ݾ��� ������, �ܱ��αٷ��ڰ� ' ,left=71 ,top=427 ,right=1888 ,bottom=469 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    [����Ư�����ѹ�] ��18����2��2�׿� ���� ���ϼ����� �����ϴ� ��쿡�� 16)���� �ݾְ� ������ҵ�ݾ��� ���� �ݾ��� ����, �ҵ漼�� ������ ����� .����.����' ,left=71 ,top=464 ,right=1888 ,bottom=506 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �� ���װ����� ���� ������ �������� �ʽ��ϴ�.' ,left=71 ,top=501 ,right=1888 ,bottom=543 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. ���ռҵ� Ư������[34) ~ 39)]���� �� ���� �ҵ����[43)~47)]���� ���� ��37ȣ������ �������� �����ϴ�.' ,left=71 ,top=541 ,right=1888 ,bottom=580 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. �� ���Ŀ� ���� �ݾ� �� �Ҽ��� ���� ���� ������, 67) ����¡�������� �Ҿ׺�¡��(1õ�� �̸��� ���մϴ�)�� �ش��ϴ� ��� ������ 0 ���� �����ϴ�.' ,left=71 ,top=577 ,right=1888 ,bottom=617 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68) �ҵ���� ������ 2006�� ���� �߻��ϴ� �ٷμҵ� ��������к��� ����մϴ�.' ,left=71 ,top=614 ,right=1888 ,bottom=654 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �����ڵ�� : �ҵ��� ����=0, �ҵ����� ��������=1, ������� ��������=2, �����=3, ������ �ڳ�=4, ������ �ڳ� �� = 5 �����ڸ�=6, ��Ÿ=7�� �����ϴ�' ,left=71 ,top=654 ,right=1888 ,bottom=693 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='           (4��5��6��7�� ��� �ҵ��ڿ� ������� ������ ���踦 �����մϴ�). ' ,left=71 ,top=691 ,right=1888 ,bottom=730 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ��.�ܱ��ζ� : �������� ��� 1 ��, �ܱ����� ��� 9 �� �����ϴ�.' ,left=71 ,top=728 ,right=1888 ,bottom=767 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���������׸�� : �������������� �ִ� ��� �ش���� O ǥ�ø� �մϴ�(�ش������ ���� ��� ����Ӵϴ�).' ,left=71 ,top=765 ,right=1888 ,bottom=804 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ����û �ڷ�� : [�ҵ漼��] ��165���� ���� ����û Ȩ���������� �����ϴ� �� �ҵ���� �׸��� �ݾ� �� �ҵ��������� �Ǵ� �ݾ���  �����ϴ�.' ,left=71 ,top=802 ,right=1888 ,bottom=841 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. �� ���� �ڷ�� : ����û���� �����ϴ� �������� ���� ���� ���մϴ�.(���� ���, �п��� ���γ��ο������� �ſ�ī�� �� ����, �÷±����� �Ȱ汸�Ժ�� ' ,left=71 ,top=838 ,right=1888 ,bottom=878 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='        �Ƿ����� ���� �����ϴ�).' ,left=71 ,top=875 ,right=1888 ,bottom=915 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ��. ���� �ҵ���� �׸�� : �ҵ�����׸� �ش��ϴ� ���� ����ݾ��� �����ϴ�(�ҵ�������� �ƴ� ���� ���ݾ��� �����׸񺰷� ���е� ���� �ȿ� �����ϴ�).' ,left=71 ,top=912 ,right=1888 ,bottom=952 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �ش� �ڵ庰�� �����Ͽ� �����ϴ�. (������׸��� ���� ��� ��.����� �ҵ���� 20)������ҵ� ����� �Ѿ׸� ���� ��.����� �ҵ���� ������ �ۼ� �����մϴ�.)' ,left=71 ,top=240 ,right=1888 ,bottom=279 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. ���������� ���������ڵ�� ������ڿ� �ش��ϴ� ��쿡 ���Ͽ� ������, ����ǥ��ȭ�ⱸ(ISO)�� ���� ISO�ڵ� �� ������ �� �����ڵ带 �����ϴ�.' ,left=79 ,top=61 ,right=1896 ,bottom=100 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   �������� ���� ��Ȳ
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print4  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
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
	<C>id='CURDT', left=1625, top=31, right=2494, bottom=97 ,mask='�������� XXXX �� ���� ��Ȳ', face='HY�߰��', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(����:��)' ,left=3872 ,top=100 ,right=4084 ,bottom=144 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4100 ,bottom=166 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�ֹμ�' ,left=3816 ,top=119 ,right=3947 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=3956 ,top=119 ,right=4088 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����¡�� ����' ,left=3675 ,top=19 ,right=4088 ,bottom=106 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ�����' ,left=1988 ,top=19 ,right=2400 ,bottom=106 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=3253 ,top=119 ,right=3384 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ漼' ,left=3113 ,top=119 ,right=3244 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2825 ,top=9 ,right=2825 ,bottom=166 </L>
	<T>id='�ѱ޿�' ,left=2409 ,top=19 ,right=2822 ,bottom=59 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(����� ����)' ,left=2409 ,top=66 ,right=2822 ,bottom=106 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ܱٷμҵ�' ,left=1566 ,top=19 ,right=1978 ,bottom=106 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=2831 ,top=19 ,right=3103 ,bottom=106 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2403 ,top=9 ,right=2403 ,bottom=166 </L>
	<L> left=1981 ,top=9 ,right=1981 ,bottom=166 </L>
	<T>id='70~' ,left=941 ,top=119 ,right=1000 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=72 ,top=9 ,right=72 ,bottom=166 </L>
	<L> left=3 ,top=9 ,right=3 ,bottom=166 </L>
	<L> left=353 ,top=9 ,right=353 ,bottom=166 </L>
	<L> left=725 ,top=9 ,right=725 ,bottom=166 </L>
	<L> left=616 ,top=9 ,right=616 ,bottom=166 </L>
	<L> left=463 ,top=9 ,right=463 ,bottom=166 </L>
	<T>id='(����� ����)' ,left=1144 ,top=66 ,right=1556 ,bottom=106 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����޿���' ,left=1144 ,top=19 ,right=1556 ,bottom=59 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1138 ,top=9 ,right=1138 ,bottom=166 </L>
	<L> left=1559 ,top=9 ,right=1559 ,bottom=166 </L>
	<L> left=1138 ,top=112 ,right=4091 ,bottom=112 </L>
	<T>id='���ٹ���' ,left=1144 ,top=119 ,right=1275 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65~' ,left=872 ,top=119 ,right=931 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=866 ,top=112 ,right=1003 ,bottom=112 </L>
	<T>id='����' ,left=9 ,top=16 ,right=69 ,bottom=162 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=466 ,top=16 ,right=613 ,bottom=162 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڳ�' ,left=1009 ,top=72 ,right=1066 ,bottom=112 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=731 ,top=69 ,right=769 ,bottom=162 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=772 ,top=62 ,right=772 ,bottom=166 </L>
	<L> left=819 ,top=62 ,right=819 ,bottom=166 </L>
	<L> left=1003 ,top=62 ,right=1003 ,bottom=166 </L>
	<L> left=866 ,top=62 ,right=866 ,bottom=166 </L>
	<L> left=3 ,top=166 ,right=4091 ,bottom=166 </L>
	<T>id='��' ,left=872 ,top=69 ,right=1000 ,bottom=109 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=731 ,top=16 ,right=1131 ,bottom=56 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=9 ,right=4091 ,bottom=9 </L>
	<L> left=725 ,top=62 ,right=1138 ,bottom=62 </L>
	<T>id='����' ,left=1009 ,top=119 ,right=1066 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=825 ,top=69 ,right=863 ,bottom=162 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=778 ,top=69 ,right=816 ,bottom=162 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�γ�' ,left=1075 ,top=72 ,right=1131 ,bottom=112 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1075 ,top=119 ,right=1131 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=1284 ,top=119 ,right=1416 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1425 ,top=119 ,right=1556 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2269 ,top=119 ,right=2400 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=1988 ,top=119 ,right=2119 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=2128 ,top=119 ,right=2259 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1847 ,top=119 ,right=1978 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=1706 ,top=119 ,right=1838 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=1566 ,top=119 ,right=1697 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2691 ,top=119 ,right=2822 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=2550 ,top=119 ,right=2681 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ���' ,left=2409 ,top=119 ,right=2541 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=934 ,top=112 ,right=934 ,bottom=166 </L>
	<L> left=1841 ,top=112 ,right=1841 ,bottom=166 </L>
	<L> left=1700 ,top=112 ,right=1700 ,bottom=166 </L>
	<L> left=2263 ,top=112 ,right=2263 ,bottom=166 </L>
	<L> left=2122 ,top=112 ,right=2122 ,bottom=166 </L>
	<L> left=2684 ,top=112 ,right=2684 ,bottom=166 </L>
	<L> left=2544 ,top=112 ,right=2544 ,bottom=166 </L>
	<L> left=1419 ,top=112 ,right=1419 ,bottom=166 </L>
	<L> left=1278 ,top=112 ,right=1278 ,bottom=166 </L>
	<T>id='�ҵ漼' ,left=2831 ,top=119 ,right=2963 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3106 ,top=9 ,right=3106 ,bottom=166 </L>
	<T>id='�ֹμ�' ,left=2972 ,top=119 ,right=3103 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ��� ����' ,left=3113 ,top=19 ,right=3384 ,bottom=106 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3247 ,top=112 ,right=3247 ,bottom=166 </L>
	<L> left=2966 ,top=112 ,right=2966 ,bottom=166 </L>
	<L> left=1069 ,top=62 ,right=1069 ,bottom=166 </L>
	<T>id='�μ�' ,left=78 ,top=16 ,right=350 ,bottom=162 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ漼' ,left=3394 ,top=119 ,right=3525 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3669 ,top=9 ,right=3669 ,bottom=166 </L>
	<T>id='�ֹμ�' ,left=3534 ,top=119 ,right=3666 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٹ��� ����' ,left=3394 ,top=19 ,right=3666 ,bottom=106 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3528 ,top=112 ,right=3528 ,bottom=166 </L>
	<T>id='�ҵ漼' ,left=3675 ,top=119 ,right=3806 ,bottom=159 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=4091 ,top=9 ,right=4091 ,bottom=166 </L>
	<L> left=3950 ,top=112 ,right=3950 ,bottom=166 </L>
	<L> left=3809 ,top=112 ,right=3809 ,bottom=166 </L>
	<L> left=3388 ,top=9 ,right=3388 ,bottom=166 </L>
	<T>id='���' ,left=359 ,top=16 ,right=459 ,bottom=162 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=622 ,top=16 ,right=722 ,bottom=162 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<C>id='BA0101YN', left=731, top=3, right=769, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=772 ,top=0 ,right=772 ,bottom=50 </L>
	<C>id='BA0102CNT', left=778, top=3, right=816, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=819 ,top=0 ,right=819 ,bottom=50 </L>
	<C>id='AD0103CNT', left=825, top=3, right=863, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=866 ,top=0 ,right=866 ,bottom=50 </L>
	<C>id='AD0101CNT', left=872, top=3, right=931, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=934 ,top=0 ,right=934 ,bottom=50 </L>
	<C>id='AD0102CNT', left=941, top=3, right=1000, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1003 ,top=0 ,right=1003 ,bottom=50 </L>
	<C>id='AD0105CNT', left=1009, top=3, right=1066, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1069 ,top=0 ,right=1069 ,bottom=50 </L>
	<L> left=1278 ,top=0 ,right=1278 ,bottom=50 </L>
	<L> left=1419 ,top=0 ,right=1419 ,bottom=50 </L>
	<C>id='AD0104YN', left=1075, top=3, right=1131, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1138 ,top=0 ,right=1138 ,bottom=50 </L>
	<L> left=1700 ,top=0 ,right=1700 ,bottom=50 </L>
	<L> left=1841 ,top=0 ,right=1841 ,bottom=50 </L>
	<C>id={CURROW}, left=9, top=3, right=69, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=78, top=3, right=350, bottom=44, align='left', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000}, left=1141, top=3, right=1275, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1559 ,top=0 ,right=1559 ,bottom=50 </L>
	<L> left=1981 ,top=0 ,right=1981 ,bottom=50 </L>
	<L> left=2122 ,top=0 ,right=2122 ,bottom=50 </L>
	<L> left=2263 ,top=0 ,right=2263 ,bottom=50 </L>
	<L> left=2403 ,top=0 ,right=2403 ,bottom=50 </L>
	<L> left=2544 ,top=0 ,right=2544 ,bottom=50 </L>
	<L> left=2684 ,top=0 ,right=2684 ,bottom=50 </L>
	<L> left=2825 ,top=0 ,right=2825 ,bottom=50 </L>
	<C>id={PC10000+PC20000}, left=1281, top=3, right=1416, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000+PC10000+PC20000}, left=1422, top=3, right=1556, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={FRE13001+PC23000}, left=1844, top=3, right=1978, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC23000', left=1703, top=3, right=1838, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE13001', left=1563, top=3, right=1697, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={FRE13005+PC20000}, left=2266, top=3, right=2400, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC20000', left=2125, top=3, right=2259, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE13005', left=1984, top=3, right=2119, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000+PB10000}, left=2688, top=3, right=2822, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB10000', left=2547, top=3, right=2681, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000}, left=2406, top=3, right=2541, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB41000', left=2828, top=3, right=2963, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB42000', left=2969, top=3, right=3103, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3106 ,top=0 ,right=3106 ,bottom=50 </L>
	<C>id='PB51000', left=3109, top=3, right=3244, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB52000', left=3250, top=3, right=3384, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB62000', left=3531, top=3, right=3666, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB61000', left=3391, top=3, right=3525, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB71000', left=3672, top=3, right=3806, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB72000', left=3813, top=3, right=3947, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={PB71000+PB72000}, left=3953, top=3, right=4088, bottom=44, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNO', left=359, top=3, right=459, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=466, top=3, right=613, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=622, top=3, right=722, bottom=44, face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2726 ,right=4100 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=3713 ,top=3 ,right=4091 ,bottom=84</I>
	<T>id='#p/#t' ,left=1706 ,top=3 ,right=2413 ,bottom=44 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=0 ,right=4091 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	