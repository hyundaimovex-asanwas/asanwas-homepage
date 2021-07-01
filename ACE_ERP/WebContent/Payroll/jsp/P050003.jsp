<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�/�ҵ��������
+ ���α׷� ID	: p050003.HTML
+ �� �� �� ��	: ��ȸ|���|����|����|����|����|����
+ �� �� �� ��	: �ǿ���
+ �� �� �� ��	: �̼��� - 2005.08.05 - �ҽ� ����
+ �� �� �� ��	: p050003_s1, p050003_s2, p050003_t1, p050003_t2
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�ҵ��������</title>


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
var curtid = "88001";  
var key_sabun="";
get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
gs_date3 = gcurdate.substring(0,4);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_yymm_search.Text=gs_date2;          //���س��
	gcem_yymm_search2.Text=gs_date3;         //���س��
 
	//�Ҽ����� 1
	gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept.Reset();

	//�Ҽ����� 2
	gcds_dept2.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept2.Reset();

	//���豸�� 1
	gcds_select_bgubun_1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1169"; 
	gcds_select_bgubun_1.Reset();

	//���豸��2
	gcds_select_bgubun_2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1169"; 
	gcds_select_bgubun_2.Reset();

	var Obj="div_zipcode";
	var div_cm=new Array("div_zipcode","div_sendal","div_holiday","div_special");

  for(var i=0;i<=3;i++) {
		if(div_cm[i]==Obj) {
			eval("document.all."+Obj+".style.display='block';");
		} else {
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
  }
}

/******************************************************************************
	Description : ��ȸ 1
******************************************************************************/
function ln_Query_1(){
	var str1 = fn_trim(gclx_select_bgubun_1.BindColVal);        //���豸��
	var str2 = fn_trim(gcem_yymm_search.Text);									//���س��
	var str3 = fn_trim(gclx_select_ec02az.BindColVal);		      //�Ҽ�
	var str4 = fn_trim(txt_empnmk_1.value);											//����
	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4;
	gcds_grid_ec01az.Reset(); //�׸���
	gcds_grid_ec01az.rowposition=1;
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query_2(){
	var str1 = ""; // fn_trim(gclx_select_bgubun_2.BindColVal);	//���豸��
	var str2 = fn_trim(gcem_yymm_search2.Text);									//���س��
	var str3 = fn_trim(gclx_select_ec03az.BindColVal);					//�Ҽ�
	var str4 = fn_trim(txt_empnmk_2.value);											//����

	gcds_grid_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_s2?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4;
	gcds_grid_ec02az.Reset(); //�׸���
	gcds_grid_ec02az.rowposition=1;
}

/******************************************************************************
	Description : ���� 1
******************************************************************************/
function ln_Save_1(){
	if (gcds_grid_ec01az.IsUpdated) {
		if (confirm("����� ������ �����Ͻðڽ��ϱ�?")) {
			gctr_grade1.KeyValue = "p050003_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_t1";
			gctr_grade1.post();
		}
	}
}

/******************************************************************************
	Description : ���� 2
******************************************************************************/
function ln_Save_2(){
	if (gcds_grid_ec02az.IsUpdated) {
		if (confirm("����� ������ �����Ͻðڽ��ϱ�?")) {
			gctr_grade2.KeyValue = "p050003_t2(I:USER=gcds_grid_ec02az)";
			gctr_grade2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_t2";
			gctr_grade2.post();
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Exec_1(){

}

/******************************************************************************
	Description : ���� 1
******************************************************************************/
function ln_Del_1(){
	if (gcds_grid_ec01az.countrow >0) {
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
			gcds_grid_ec01az.deleterow(gcds_grid_ec01az.rowposition);
			gctr_grade1.KeyValue = "p050002_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_t1";
			gctr_grade1.post();
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Del_2(){
	if (gcds_grid_ec02az.countrow >0) {
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
			gcds_grid_ec02az.deleterow(gcds_grid_ec02az.rowposition);
			gctr_grade2.KeyValue = "p050003_t2(I:USER=gcds_grid_ec02az)";
			gctr_grade2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_t2";
			gctr_grade2.post();
		}
	}
}

/******************************************************************************
	Description : ���Ͽ���
******************************************************************************/
function ln_FileOpen_2(){
	var str1=gcem_yymm_search2.Text;
	inp_File_2.Open();

	var str2=fn_trim(inp_File_2.Value);
	var str3=str2.substr(str2.length-3,3).toLowerCase();
	if(str2=="")
		alert("������ �����ϼ���");
	else if(str3 !="csv")
	{
	  inp_File_2.Value="";
		alert("CSVȮ���� ������ �����ϼ���");
	}
	else if(str1.length != 4)
		alert("���س���� 4�ڸ��� ��Ȯ�� �Է��ϼ���");
	else
		ln_File_2();
}

/******************************************************************************
	Description : ������ ����Ʈ
******************************************************************************/
function ln_File_2(){
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";

	var THeader = "STDYM:String(6),"	
						+"GRDCD:Decimal(3),"   
						+"LOWAMT:Decimal(9),"   
						+"HIGAMT:Decimal(9),"	
						+"STDAMT:Decimal(9),"	
						+"INSSUM:Decimal(9),"	
						+"INSAMT1:Decimal(9),"	
						+"INSAMT2:Decimal(9)";	
	gcds_dump.DataID = inp_File_2.Value;
	gcds_dump.Reset();
	gcds_grid_ec02az.SyncLoad=true;
	gcds_grid_ec02az.ClearAll();
	gcds_grid_ec02az.DataID = "";
	gcds_grid_ec02az.SetDataHeader(THeader);
	var ls_pd = gcem_yymm_search2.Text;
	//ls_pd = ls_pd.substring(0,4) + "-" + ls_pd.substring(4,6) + "-" + ls_pd.substring(6,8);
	//if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd) alert("ok");
	for (var j=1; j<=gcds_dump.countrow;j++){
		if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd){
			gcds_grid_ec02az.addrow();
			var ls_pos = gcds_grid_ec02az.rowposition;
			for (var i=1; i<9; i++) {
			 gcds_txt=fn_trim(gcds_dump.ColumnValue(j,i));
			 gcds_txt=ln_Ltrim(gcds_txt,",");
			 gcds_grid_ec02az.ColumnValue(ls_pos,i) = gcds_txt;
			}
		}
	}
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "��ȸ�Ǽ� : " + gcds_grid_ec01az.countrow + " ��";
	if (gcds_grid_ec02az.countrow <1) alert("�˻��� �����Ͱ� �����ϴ�.");

	gcds_grid_ec02az.DataID = "gcds_grid_ec02az";
	gcds_grid_ec02az.SyncLoad=false;
	inp_File_2.Value="";

}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_visible_hidden(index){
	var div_cm=new Array("div_zipcode","div_sendal","div_holiday","div_special");
  for(var i=0;i<=3;i++) {
		if(i==index)	{
			eval("document.all."+div_cm[i]+".style.display='block';");
		}	else	{
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
  }
}

/*******************************************************************************
  Description : Grid �����͸� Excel�� ������� ���
******************************************************************************/
function ln_Excel_1(){
	if (gcds_grid_ec01az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	else gcgd_grid_ec01az.RunExcel('�ǰ������޳���');
}

/*******************************************************************************
  Description : Grid �����͸� Excel�� ������� ���
******************************************************************************/
function ln_Excel_2(){
	if (gcds_grid_ec02az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	else gcgd_grid_ec02az.RunExcel('�ǰ������޳���');
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_select_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
  <PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_select_bgubun_1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_select_bgubun_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- ����� -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec02az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- ���� -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec03az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- ���� -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_dump"   classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49   VIEWASTEXT> 
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_grade1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--���������ڵ� TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gctr_grade2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--���������ڵ� TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gctr_grade3" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--���������ڵ� TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
    <PARAM NAME="KeyValue" VALUE="hdasan_h060001_tr(I:USER=gcds_pyo)">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for="inp_File_1" event="OnClick()">
	txt_file_1.value=inp_File_1.Value
	ln_File_1();
</script>

<script language="javascript" for="gcds_select_bgubun_1" event="OnLoadStarted()">
  window.status="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_bgubun_1" event="onloadCompleted(row,colid)">
	gcds_select_bgubun_1.InsertRow(1);
  gcds_select_bgubun_1.NameValue(1,"MINORCD")="";
  gcds_select_bgubun_1.NameValue(1,"MINORNM")="��ü";
	gclx_select_bgubun_1.index=0; //���豸��

	//document.all.LowerFrame.style.visibility="hidden";
	window.status="����Ÿ ��ȸ�� �Ϸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_select_bgubun_2" event="OnLoadStarted()">
  window.status="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_bgubun_2" event="onloadCompleted(row,colid)">
	gcds_select_bgubun_2.InsertRow(1);
  gcds_select_bgubun_2.NameValue(1,"MINORCD")="";
  gcds_select_bgubun_2.NameValue(1,"MINORNM")="��ü";
	//gclx_select_bgubun_2.index=0; //���豸��
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="����Ÿ ��ȸ�� �Ϸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="��ü";
	gclx_select_ec02az.index=0;
	
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="����Ÿ ��ȸ�� �Ϸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_dept2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
	gcds_dept2.InsertRow(1);
	gcds_dept2.NameValue(1,"DEPTCD")="";
	gcds_dept2.NameValue(1,"DEPTNM")="��ü";
	gclx_select_ec03az.index=0;

	//document.all.LowerFrame.style.visibility="hidden";
	window.status="����Ÿ ��ȸ�� �Ϸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	gcds_row_ec01az =0;

	if(gcds_grid_ec01az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	ft_cnt2.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_grid_ec02az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language="javascript" for="gcgd_pyo" event="onclick(row)">
    /*if (row == 0) return;
    if (gcds_pyo.sysStatus(row)==0) ln_format('A');
    else ln_format('B');*/
</script>

<script language=JavaScript for=ADE_Tab_1 event=OnSelChanged(index)>
	ln_visible_hidden((index-1));
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_grade1" event="OnSuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	//ln_Query();
</script>

<script language="javascript" for="gctr_grade1" event="OnFail()">
	alert("�ߺ��� ����Ÿ �Է����� ������ �߻��߽��ϴ�.");
</script>

<script language="javascript" for="gctr_grade2" event="OnSuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	//ln_Query();
</script>

<script language="javascript" for="gctr_grade2" event="OnFail()">
	alert("�ߺ��� ����Ÿ �Է����� ������ �߻��߽��ϴ�.");
</script>


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p050003_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2 ALING=LEFT>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td width="0" align=RIGHT><NOBR>
						<comment id="__NSID__"><OBJECT id=ADE_Tab_1 classid=clsid:ED382953-E907-11D3-B694-006097AD7252   VIEWASTEXT style="width:660px;height:20px">
							<PARAM NAME="BackColor" VALUE="#cccccc">
							<PARAM NAME="titleHeight" VALUE="20px">
							<PARAM NAME="DisableBackColor" VALUE="#eeeeee">
							<PARAM NAME="Format" VALUE="
                <T>divid=div_zipcode  title=�ҵ�����</T>                          						  
								<T>divid=div_sendal		title=�����Ѿ���ȸ</T>
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
        </tr>
			</table>
    </td>
  </tr>
  <tr><td height=10></td></tr>
  <tr> 
    <td COLSPAN=2>
<div id="div_zipcode" style="display:block">
  <table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr> 
		  <td colspan=8 align=center>
        <table width="847" cellpadding="1" cellspacing="0" border="0" style='border:1 solid #708090' >
          <tr> 
			      <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
            <td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_select_bgubun_1  name="gclx_select_bgubun_1" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
							style="position:relative;left:6px;top:2px;font-size:12px;width:75px;height:200px;">
								<param name=ComboDataID			value=gcds_select_bgubun_1>
								<param name=SearchColumn		value="MINORCD^MINORNM">
								<param name=Sort            value="TRUE">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM">
								<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>	
     			  </td>
            <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;���س��&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm_search classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				        style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
				        validFeatures="ignoreStatus=yes" validExp="">
				        <param name=Text          value="">
				        <param name=Alignment	  value=1>
		        		<param name=Border	      value=True>
	        			<param name=ClipMode	  value=true>
        				<param name=Numeric	      value=false>
        				<param name=Format	      value="YYYY/MM">
        				<param name=MaxLength     value=6>
        				<param name=PromptChar	  value="_">
        				<param name=IsComma	      value=false>
        				<param name=BackColor     value="#CCCCCC">
        				<param name=InheritColor  value=false>
        			</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
						<td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;</nobr></td>
						<td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value=gcds_dept>
								<param name=SearchColumn		value="DEPTCD^DEPTNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="DEPTCD">
								<param name=ListExprFormat	value="DEPTNM^0^130">
								<param name=BindColumn			value="DEPTCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
     			    </td>
							<td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
							<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr><input id="txt_empnmk_1" name="txt_empnmk_1" type="text" style="width:70px;" class="txt21" maxlength=10 onkeydown="if(event.keyCode==13) ln_Query_1();"></nobr></td>
   				    <td width="100%">&nbsp;</td>
              <td style="padding-top:4px;"><nobr>      
								<img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Exec_1();" > 
								<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand"  onclick="ln_Del_1();">
								<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand"  onclick="ln_Save_1();">
								<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query_1();"></nobr>
							</td>
            </tr>
          </table>
        </td>
      </tr>
			<tr>
				<td ALIGN=CENTER>
          <table width="847" cellpadding="1" cellspacing="0" border="0">
            <tr> 
              <td style="width:847" ALIGN=LEFT VALIGN=TOP>
                <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_reresult  style="WIDTH: 845px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
									<PARAM NAME="DataID"          VALUE="gcds_grid_ec01az">
									<PARAM NAME="Editable"				VALUE="True">
									<PARAM NAME="ColSizing"				VALUE="True">
									<PARAM NAME="BorderStyle"			VALUE="0">
       						<PARAM NAME="Fillarea"				VALUE="true">
									<PARAM NAME="Format"          VALUE="  
										<C> Name='����'   HeadAlign=Center HeadBgColor=#B9D4DC Width=40 Value={currow} align=RIGHT EDIT=NONE </C> 
										<C> Name='���' ID=EMPNO HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=RIGHT EDIT=NONE </C>
										<C> Name='����' ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=CENTER EDIT=NONE </C>
										<C> Name='�Ҽ�' ID=DEPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=LEFT EDIT=NONE </C>
										<C> Name='��������ȣ' ID=MEDSNO HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT  EDIT=NONE  </C> 
										<G> Name='��������' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC
											<C> Name='���κ����' ID=M12300 HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=RIGHT Edit=Numeric </C>
											<C> Name='�Ⱓ����' ID=Y12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT Edit=Numeric </C>
											<C> Name='����' ID=DUTMON HeadAlign=Center HeadBgColor=#B9D4DC Width=40 align=RIGHT Edit=Numeric </C>
											<C> Name='������' ID=M12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT Edit=Numeric </C>
											<C> Name='��ǥ��' ID=S12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT Edit=Numeric </C>
											<C> Name='�����' ID=OGRDCD HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=RIGHT Edit=Numeric </C>
											<C> Name='�ŵ��' ID=NGRDCD HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=RIGHT Edit=Numeric </C>
										</G>
                    ">
                   </OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset id=ft_div1 style="width:847px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
											<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
										</fieldset>
									</td>
                </table>
              </TD>
						</tr>
					</table>
        </td>
      </tr>
    </table>
	</div>

<div id="div_sendal" style="display:block">
	<table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr> 
		  <td colspan=8 align=center>
        <table width="847" cellpadding="1" cellspacing="0" border="0"	 style='border:1 solid #708090' >
          <tr> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;���س⵵&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm_search2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				        style="position:relative; left:1px;top:2px; width:40px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
				        validFeatures="ignoreStatus=yes" validExp="">
				        <param name=Text          value="">
				        <param name=Alignment			value=1>
		        		<param name=Border	      value=True>
	        			<param name=ClipMode			value=true>
        				<param name=Numeric	      value=false>
        				<param name=Format	      value="YYYY">
        				<param name=MaxLength     value=4>
        				<param name=PromptChar	  value="_">
        				<param name=IsComma	      value=false>
        				<param name=BackColor     value="#CCCCCC">
        				<param name=InheritColor  value=false>
        			</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;</nobr></td>
            <td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>	
							<comment id="__NSID__"><object id=gclx_select_ec03az  name="gclx_select_ec03az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value=gcds_dept2>
								<param name=SearchColumn		value="DEPTCD^DEPTNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="DEPTCD">
								<param name=ListExprFormat	value="DEPTNM^0^130">
								<param name=BindColumn			value="DEPTCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>	
     			  </td>
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
						<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr><input id="txt_empnmk_2" name="txt_empnmk_2" type="text" class="txt21" style="width:70px;" maxlength=10 ></nobr></td>
						<td width="100%">&nbsp;
							<comment id="__NSID__"><object id=inp_File_2 classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
								<param name="Text"		value='ã�ƺ���'>
								<param name="Enable"	value="True">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="padding-top:4px;"><nobr>      
							<img src="../../Common/img/btn/com_b_download.gif" style="cursor:hand" onclick="ln_FileOpen_2();">   
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel_2();">  
							<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del_2();">
							<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand"  onclick="ln_Save_2();">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query_2();"></nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
			<td ALIGN=CENTER>
        <table width="847" cellpadding="1" cellspacing="0" border="0">
          <tr> 
            <td style="width:847" ALIGN=RIGHT VALIGN=TOP>
              <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec01az  style="WIDTH: 845px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
							  <PARAM NAME="DataID"          VALUE="gcds_grid_ec02az">
							  <PARAM NAME="Editable"				VALUE="True">
							  <PARAM NAME="BorderStyle"			VALUE="0">
       					<param name="Fillarea"				VALUE="true">
							  <PARAM NAME="Format"          VALUE="  
									<C> Name='����'   Value={currow}				HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=RIGHT Edit=Numeric EDIT=NONE </C> 									
									<C> Name='����'							ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=LEFT	EDIT=NONE </C>
									<C> Name='�ֹι�ȣ'					ID=RESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=104	align=RIGHT EDIT=NONE </C>
									<C> Name='��������ȣ'				ID=MEDSNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT EDIT=NONE  </C> 
									<C> Name='�ڰ������'				ID=GETDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT Mask='XXXX/XX/XX' </C>
									<C> Name='���⵵����ᳳ��' ID=MEDAMT1	HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=RIGHT </C>
									<C> Name='�ǳ��κ����'			ID=MEDAMT2	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT </C>
									<C> Name='���⵵�����Ѿ�'		ID=M12100		HeadAlign=Center HeadBgColor=#B9D4DC Width=105	align=RIGHT </C>
									<C> Name='����'							ID=DUTMON		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=RIGHT </C>
									<C> Name='�������'					ID=NGRDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=RIGHT </C>
                  ">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset id=ft_div1 style="width:847px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
							</fieldset>
							</td>
						</TR>
					</table>
					</TD>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="div_holiday" style="display:block"></div>
<div id="div_special" style="display:block"></div>
			<td>
		</tr>
  </table>

<div class=page id="out_line" style="position:absolute; left:174; top:158; width:875; height:460;z-index:-1;">&nbsp;</div>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	