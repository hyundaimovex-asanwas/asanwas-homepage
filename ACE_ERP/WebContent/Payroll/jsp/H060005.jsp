<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�������� - �������� ����
+ ���α׷� ID	: H060005.html
+ �� �� �� ��	:   
+ �� �� �� ��	: 2007.06.13 ������ - �⸻���, ����, �������� �߰� 
+ �� �� �� ��	: h060005_s1, h060005_s2, hclcode_s1, h060005_t1
-------------------------------------------------------------------------------
+ �� �� �� �� : ������ ��� ���� ( 2009.06 ���� ���� ���� ) 
+ �� �� �� �� : 
+ ��   ��  �� : �� �� �� 
-------------------------------------------------------------------------------
+ �� �� �� �� : �μ��� ���� ���� �߰� ( 2009.11 ���� ���� ���� ) 
+ �� �� �� �� : 2009.11.06
+ ��   ��  �� : �� �� �� 
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title></title>
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
//get_cookdata();
//lfn_init();
var gs_level;
var gs_treecd;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_yymm.text = gcurdate.substring(0,7); 
	ln_Luxecombo_load();

	//txt_empnoh.value = gusrid;
	//txt_empnmh.value = gusrnm;
	goga2.value = "����";
	gcra_grsref.CodeValue = 1;

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

		if (gclx_paygrd.bindcolval != "" || gclx_paygrd2.bindcolval != "") {
			var v_paygrd1 = gcds_paygrd.namevalue(gcds_paygrd.rowposition,"SEQ");
			var v_paygrd2 = gcds_paygrd2.namevalue(gcds_paygrd2.rowposition,"SEQ");
		}else{
			var v_paygrd1 = "";
			var v_paygrd2 = ""; 
		}

		if(gcem_yymm.text==""){
			alert("��������� Ȯ���Ͻʽÿ�.");
			return false;
		}

		if(gcem_yymm.text<='200811'){
			gcgd_col.ColumnProp("GOGAGB", "Show") = "true";
			gcgd_col.ColumnProp("GRADE", "Show") = "false";
			gcgd_col.ColumnProp("GRADE2", "Show") = "false";
			gcgd_col.ColumnProp("GRADE3", "Show") = "false";
		}else if(gcem_yymm.text=='200906'){
      gcgd_col.ColumnProp("GOGAGB", "Show") = "false";
			gcgd_col.ColumnProp("GRADE", "Show") = "true";
			gcgd_col.ColumnProp("GRADE2", "Show") = "false";
			gcgd_col.ColumnProp("GRADE3", "Show") = "false";
		}else if(gcem_yymm.text>'200906'){
			gcgd_col.ColumnProp("GOGAGB", "Show") = "false";
			gcgd_col.ColumnProp("GRADE", "Show") = "true";
			gcgd_col.ColumnProp("GRADE2", "Show") = "true";
			gcgd_col.ColumnProp("GRADE3", "Show") = "true";
		}

    //2008.11.11 jys ���� : ��� ( 5:5 => 6:4(2������) , 5:3:2(3������) �� ���� ==> 4:3:3
		if(gcem_yymm.text<='200807'){
			gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_s1?v_str1="+gcem_yymm.text				//�������
																												 +"&v_str2="+txt_empnoh.value				//���
																												 +"&v_str3="+gclx_deptcd.bindcolval	//�Ҽ��ڵ�
																												 +"&v_str4="+gs_level								//level
																												 +"&v_str5="+gs_treecd							//treecd
																												 +"&v_str6="+v_paygrd2							//���� from
																												 +"&v_str7="+v_paygrd1							//���� to
																												 +"&v_str8="+gclx_jobkind.bindcolval//����
																												 +"&v_str9="+goga1.value						//��������
																												 +"&v_str10="+gcra_grsref.CodeValue //����
																												 +"&v_str11=A";											//��ȸ����
      // prompt('1',gcds_data.DataID);
			 gcds_data.Reset(); 
		}else if(gcem_yymm.text>'200807'){
			 gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_s2?v_str1="+gcem_yymm.text				//�������
																												 +"&v_str2="+txt_empnoh.value				//���
																												 +"&v_str3="+gclx_deptcd.bindcolval	//�Ҽ��ڵ�
																												 +"&v_str4="+gs_level								//level
																												 +"&v_str5="+gs_treecd							//treecd
																												 +"&v_str6="+v_paygrd2							//���� from
																												 +"&v_str7="+v_paygrd1							//���� to
																												 +"&v_str8="+gclx_jobkind.bindcolval//����
																												 +"&v_str9="+goga1.value						//��������
																												 +"&v_str10="+gcra_grsref.CodeValue //����
																												 +"&v_str11=A";											//��ȸ����
		   //prompt('2',gcds_data.DataID);
			 gcds_data.Reset(); 
		}
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

  if(gcem_yymm.text!="201106"){
		alert("2011�� 06���� ���� �����մϴ�.");
		return false;
	}

	if (gcds_data.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {
		if (confirm("�����Ͻðڽ��ϱ�?")) {
			//prompt("gcds_data2",  gcds_data.text );
			gctr_data.keyvalue = "h060005_t1(I:USER=gcds_data)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_t1";
			gctr_data.post();
			//ln_Query();
		}
	}
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
	Description : ���
******************************************************************************/
function ln_Print(){
	alert("�������Դϴ�");
}

/******************************************************************************
	Description : ��ȸ2
******************************************************************************/
function ln_Query2(){
  //2008.11.11 jys ���� : ��� ( 5:5 => 6:4(2������) , 5:3:2(3������) �� ����  ==>4:3:3

  
	if(gcem_yymm.text!="201106"){
		alert("2011�� 06���� ���� �����մϴ�.");
		return false;
	}

  if(gcem_yymm.text<='200807'){
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_s1?v_str1="+gcem_yymm.text			//�������
																											 +"&v_str2="+txt_empnoh.value				//���
																											 +"&v_str3="+""											//�Ҽ��ڵ�
																											 +"&v_str4="+""											//level
																											 +"&v_str5="+""											//treecd
																											 +"&v_str6="+""											//����
																											 +"&v_str7="+""											//����
																											 +"&v_str8="+""											//��������
																											 +"&v_str9="+""											//��������
																											 +"&v_str10="+gcra_grsref.CodeValue;//����
   // prompt('1111::',gcds_data2.DataID);
		gcds_data2.Reset(); 
	}else if(gcem_yymm.text>'200807'){
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_s2?v_str1="+gcem_yymm.text			//�������
																											 +"&v_str2="+txt_empnoh.value				//���
																											 +"&v_str3="+""											//�Ҽ��ڵ�
																											 +"&v_str4="+""											//level
																											 +"&v_str5="+""											//treecd
																											 +"&v_str6="+""											//����
																											 +"&v_str7="+""											//����
																											 +"&v_str8="+""											//��������
																											 +"&v_str9="+""											//��������
																											 +"&v_str10="+gcra_grsref.CodeValue;//����
		//prompt("22",gcds_data2.DataID  );
		gcds_data2.Reset(); 
	}
}

/******************************************************************************
	Description : ����
	            : 1. ���� ��� ==> �������� ( TOTAVG ) �� UPDATE ��.
							: 2. �μ��� ������ ���� �ϴ� ���
							     ������� * 0.8 + DPTAVG ==> �������� ( TOTAVG )�� UPDATE ��
******************************************************************************/
function ln_Execute(){

	if (gcds_data.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {
    if(gcem_yymm.text==""){
			alert("��������� Ȯ���Ͻʽÿ�.");
			return false;
		}

		ln_Query2();
	}

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
	//gcgd_col.RunExcel('������������');
	gcgd_col.GridToExcel('������������','',8);
}

/******************************************************************************
	Description : ������ ��ȸ
******************************************************************************/
function ln_FindEmp(e, row){
  var result="";
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H060004_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:383px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

 	if (result != null) {
		arrResult = result.split(";");
		//eval(e).value  = arrResult[0];   
		if (e=="txt_empnmh") {
		  txt_empnmh.value = arrResult[0];
			txt_empnoh.value = arrResult[1];
		}else if(e=="EMPNMKH"){
		  gcds_data2.namevalue(row,"EMPNMKH")= arrResult[0];
      gcds_data2.namevalue(row,"EMPNOH") = arrResult[1];			
		}
	} else {
		if (e=="txt_empnmh") {
		  txt_empnmh.value="";
			txt_empnoh.value ="";
		}
	}
}

/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

	//���� from
	gcds_paygrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";//&v_str3=SEQ"; 
	gcds_paygrd.Reset();

	//���� to
	gcds_paygrd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";//&v_str3=SEQ"; 
	gcds_paygrd2.Reset();

	//����
	gcds_jobkind.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2034"; 
	gcds_jobkind.Reset();

	//�Ҽ�
	gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";  
	gcds_deptcd.Reset();
}

/******************************************************************************
	Description : ��޻��� --> ����� �׻� ���� �� totavg(��������)�� ������ �Ŀ� �����ؾ���.
******************************************************************************/
function ln_Grade(){

  if(gcem_yymm.text==""){
		alert("��������� �������� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�.");
		return;
	}

	if(gcra_grsref.CodeValue==""){
		alert("������ �������� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�.");
		return;
	}

	if(gcem_yymm.text!="201106"){
		alert("2011�� 06���� ��޻��� �����մϴ�.");
		return false;
	}

	//���޺� ��� �ο���
  gcds_grade1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_s3?v_str1="+gcem_yymm.text+"&v_str2="+gcra_grsref.CodeValue;
	//prompt('gcds_grade1',gcds_grade1.DataID);
	gcds_grade1.Reset();

	//���޺� rank  
	gcds_grade2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_s4?v_str1="+gcem_yymm.text+"&v_str2="+gcra_grsref.CodeValue;
	//prompt('gcds_grade2',gcds_grade2.DataID);
	gcds_grade2.Reset();

  if (confirm(gcem_yymm.text+" ��޻����� �Ͻðڽ��ϱ�?")) {
		ln_Grade_Update();

		gctr_data.keyvalue = "h060005_t2(I:USER=gcds_grade2)";
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_t2";
		//prompt('',gcds_grade2.text);
		gctr_data.post();
	}
}


/******************************************************************************
	Description : ��޻��� --> ����� �׻� ���� �� totavg(��������)�� ������ �Ŀ� �����ؾ���.
******************************************************************************/
function ln_Grade_Update(){

	var intCnt=0;
	var intS=0;
	var intA=0;
	var intB=0;
	var intC=0;
	var intD=0;
	var intStart=1;

	//alert("gcds_grade1::"+gcds_grade1.countrow);
	//alert("gcds_grade2::"+gcds_grade2.countrow);

	for(i=1;i<=gcds_grade1.countrow;i++){     //���޺� row 
		intCnt=0;                               //���޺� ���� �ʱ�ȭ
		intS=gcds_grade1.namevalue(i,"S");
		intA=gcds_grade1.namevalue(i,"S")+gcds_grade1.namevalue(i,"A");
		intB=gcds_grade1.namevalue(i,"S")+gcds_grade1.namevalue(i,"A")+gcds_grade1.namevalue(i,"B");
		intC=gcds_grade1.namevalue(i,"S")+gcds_grade1.namevalue(i,"A")+gcds_grade1.namevalue(i,"B")+gcds_grade1.namevalue(i,"C");
		intD=gcds_grade1.namevalue(i,"S")+gcds_grade1.namevalue(i,"A")+gcds_grade1.namevalue(i,"B")+gcds_grade1.namevalue(i,"C")+gcds_grade1.namevalue(i,"D");

    //alert(intS);
		//alert(intA);
		//alert(intB);
		//alert(intC);
		//alert(intD);

		_loop:
		for(j=intStart;j<=gcds_grade2.countrow;j++){   //��ü ���޺� rank ����..
			intCnt +=1;                           //����

      if(gcds_grade1.namevalue(i,"PAYGRD2")==gcds_grade2.namevalue(j,"PAYGRD2")){ 
			  intStart+=1; 
				 
				if(intCnt<=intS){
					gcds_grade2.namevalue(j,"GRADE")="S";
				}else if(intCnt<=intA){
          gcds_grade2.namevalue(j,"GRADE")="A"; 
				}else if(intCnt<=intB){
          gcds_grade2.namevalue(j,"GRADE")="B"; 
        }else if(intCnt<=intC){
          gcds_grade2.namevalue(j,"GRADE")="C"; 
        }else if(intCnt<=intD){
          gcds_grade2.namevalue(j,"GRADE")="D"; 
				}
			}else{
				break _loop;
			}
		}//for j
  }//for i
}

/******************************************************************************
	Description : ������ ���� ����Ÿ UPLOAD �� �� �����.
******************************************************************************/
function ln_Update(){
  	var s_temp = "TEMP:STRING";
		gcds_update.SetDataHeader(s_temp);

		gcds_update.addrow();
    gcds_update.namevalue(gcds_update.rowposition,"TEMP")="201106"; //�������

		gctr_data.keyvalue = "hupdate_t1(I:USER=gcds_update)";
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hupdate_t1";
    //prompt('',gcds_update.text);
		gctr_data.post();
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>

	<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>

</comment><script>__ws__(__NSID__);</script>

<!--�����ڵ�1-->
<comment id="__NSID__"><object id="gcds_paygrd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="SortExpr" value="+seq">
</object></comment><script>__ws__(__NSID__);</script>

<!--�����ڵ�2-->
<comment id="__NSID__"><object id="gcds_paygrd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="SortExpr" value="+seq">
</object></comment><script>__ws__(__NSID__);</script>

<!--�����ڵ�-->
<comment id="__NSID__"><object id="gcds_jobkind" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="SortExpr" value="+MINORCD">
</object></comment><script>__ws__(__NSID__);</script>

<!--�Ҽ��ڵ�-->
<comment id="__NSID__"><object id=gcds_deptcd classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
	<param name="SortExpr" value="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
  <object id=gcds_update classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
</object>

<!-- ��� : ���޺� ��� �ο���  -->
 <object id=gcds_grade1 classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
</object>

<!-- ��� : ���޺� rank  -->  
 <object id=gcds_grade2 classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_data2"	event="onLoadCompleted(row,colid)">
	if (gcds_data2.countrow<1){
	}else {
		for(var i=1;i<=row;i++) {
			//2009.11.06 �߰� 
			if(gcds_data2.namevalue(i,"DPTAVG")==0){
				gcds_data2.namevalue(i,"TOTAVG") = gcds_data2.namevalue(i,"CORAVG");
			}else{
				gcds_data2.namevalue(i,"TOTAVG") = gcds_data2.namevalue(i,"CORAVG")*0.8 + gcds_data2.namevalue(i,"DPTAVG") ;
			}
		}
		if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
			gctr_data.keyvalue = "h060005_t1(I:USER=gcds_data2)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060005_t1";
			//prompt(this,gcds_data2.text);
			gctr_data.post();
			ln_Query();
		}
	}
</script>

<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "��ü";
	gclx_deptcd.index = 0;
</script>

<script language="javascript" for="gcds_paygrd" event="onloadCompleted(row,colid)">
	gcds_paygrd.insertrow(1);
	gcds_paygrd.namevalue(1,"MINORCD") = "";
	gcds_paygrd.namevalue(1,"MINORNM") = "��ü";
	gclx_paygrd.index = 0;
</script>

<script language="javascript" for="gcds_paygrd2" event="onloadCompleted(row,colid)">
	gcds_paygrd2.insertrow(1);
	gcds_paygrd2.namevalue(1,"MINORCD") = "";
	gcds_paygrd2.namevalue(1,"MINORNM") = "��ü";
	gclx_paygrd2.index = 0;
</script>

<script language="javascript" for="gcds_jobkind" event="onloadCompleted(row,colid)">
	gcds_jobkind.insertrow(1);
	gcds_jobkind.namevalue(1,"MINORCD") = "";
	gcds_jobkind.namevalue(1,"MINORNM") = "��ü";
	gclx_jobkind.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
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

<script language=JavaScript for=gctr_data event=OnSuccess()>
    alert("�۾��� �Ϸ� �Ͽ����ϴ�");
</script>

 
<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>


<table width="876" cellpadding="0" cellspacing="0" border="0">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/h060005_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
		 <!-- �ӽø���. -->
<!-- <img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Update()">&nbsp;&nbsp; &nbsp; &nbsp;  
 -->				<img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Execute()">
        <img src="../../Common/img/btn/com_b_grade.gif" style="cursor:hand"   onclick="ln_Grade()">&nbsp;&nbsp;
				
				<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
				<img src="../../Common/img/btn/com_b_save.gif"	style="cursor:hand" onclick="ln_Save()">
				<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		<table  cellpadding="0" cellspacing="0" border="0"      
			 style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr> 
						<td class="tab11" width="10"  bgcolor="#eeeeee"><nobr>&nbsp;�������&nbsp;&nbsp;</nobr></td>
						<td class="tab19"><nobr>&nbsp
								<comment id="__NSID__"><object id=gcem_yymm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  	
										style="position:relative; left:3px;top:2px; width:50px; height:20px;" class=txtbox> 
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
							</td>
						<td class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;������&nbsp;&nbsp;&nbsp;</nobr></td>
						<td class="tab19" width="10" ><nobr>&nbsp;<input  id="txt_empnmh" name="txt_name" type="text" style="position:relative; left:0px;top:-2px; width:70px; size=20"  class="txt21" disabled>
							<img src="../../Common/img/btn/com_b_find.gif" alt="�����ڸ� �˻��մϴ�" style="position:relative;left:0px;top:2px;cursor:hand;" onclick="ln_FindEmp('txt_empnmh','')">
							<input type="hidden" width="0" id="txt_empnoh">&nbsp;</nobr>
						</td>  
						<td width="10" class="tab11" bgcolor="#eeeeee" align=center><nobr>&nbsp;��&nbsp;��&nbsp;</nobr></td>
						<td width="10" class="tab19"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=150  style="position:relative; top:2px;">
								<param name=ComboDataID           value=gcds_deptcd>
								<param name=SearchColumn          value="DEPTNM">
								<param name=Sort                  value=false>
								<param name=ListExprFormat        value="DEPTNM^0^150">       
								<param name=BindColumn            value="DEPTCD"> 
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td width="10" class="tab11" bgcolor="#eeeeee" align=center><nobr>&nbsp;��&nbsp;��&nbsp;</nobr></td>
						<td width="10" class="tab13"><nobr>&nbsp;
							<comment id="__NSID__"><object	id=gcra_grsref classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:-4px;top:2px;height:24;width:115;cursor:hand;" class="txtbox" >
								<PARAM NAME=Cols     VALUE="2">
								<PARAM NAME=Format   VALUE="1^������,2^�����">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
<!-- 						<td width="100%" class="tab13"><nobr>&nbsp;  </nobr></td>
 -->			</tr>
					<tr>
						<td width="10" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;��&nbsp;��&nbsp;</nobr></td>
						<td width="10" class="tab12"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_jobkind classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=140 style="position:relative; top:2px;">
								<param name=ComboDataID           value="gcds_jobkind">
								<param name=SearchColumn          value="MINORNM">
								<param name=Sort                  value="false">
								<param name=ListExprFormat        value="MINORNM">
								<param name=BindColumn            value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td width="10" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;��������&nbsp;</nobr></td>
						<td width="10" class="tab12"><nobr>&nbsp;
							<input type="checkbox" id=goga1 value="" style="position:relative;left:-10px;cursor:hand;width:20px" onClick="if(this,this.checked) {goga1.value = 'T'}else{goga1.value = ''}">
							<input type="text"		 id=goga2 style="position:relative;left:-10px;width:40px;border-width:0px" >&nbsp;</nobr>
						</td>
						<td width="10" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;��&nbsp;��&nbsp;</nobr></td>
						<td width="10" class="tab12"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  style="position:relative; top:2px;">
								<param name=ComboDataID           value=gcds_paygrd>
								<param name=SearchColumn          value="MINORNM">
								<param name=Sort                  value=false>
								<param name=ListExprFormat        value="MINORNM">       
								<param name=BindColumn            value="MINORCD"> 
							</object></comment><script>__ws__(__NSID__);</script>
							&nbsp;~&nbsp;
							<comment id="__NSID__"><object id=gclx_paygrd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  style="position:relative; top:2px;">
								<param name=ComboDataID           value=gcds_paygrd2>
								<param name=SearchColumn          value="MINORNM">
								<param name=Sort                  value=false>
								<param name=ListExprFormat        value="MINORNM">       
								<param name=BindColumn            value="MINORCD"> 
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td width="100%" COLSPAN=2 ><nobr>&nbsp;  </nobr></td>    
					</tr>
				</table>		
			</td>
		</tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_col  
						style="WIDTH: 876px; HEIGHT: 404px;border:1 solid #777777;display:block;" viewastext>
								<param name="DataID"						value="gcds_data">
								<param name="Editable"					value="true">
								<param name="TitleHeight"       value="17">
								<param name="BorderStyle"				value="0">  
								<param name="Fillarea"					value="true">
                <param name="Sortview"					value="left">
								<param name=ColSelect						value="true">
								<param name=ColSizing						value="true">
								<param name="Format"						VALUE="  
									<FC> Name='���'			  ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center  Edit=none BgColor='#f5f5f5' sort=true </FC> 
									<FC> Name='�Ҽ�'			  ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left		Edit=none BgColor='#f5f5f5' sort=true</FC>
									<FC> Name='����'			  ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		Edit=none BgColor='#f5f5f5' sort=true</FC>
									<FC> Name='�ǰ�����'    ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=72		align=left		Edit=none BgColor='#f5f5f5' sort=true</FC> 
									<FC> Name='��������'	  ID=GRPNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=63		align=left		Edit=none	BgColor='#f5f5f5' sort=true  show=false</FC> 
											
									<C> Name='1��\\������'  ID=EMPNMH_1 HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		Edit=none sort=true</C>
									<C> Name='����'				  ID=SCR1			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>
									<C> Name='����'				  ID=AVG1			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>

									<C> Name='2��\\������'  ID=EMPNMH_2 HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		Edit=none sort=true</C>
									<C> Name='����'				  ID=SCR2			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>
									<C> Name='����'				  ID=AVG2			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>

									<C> Name='3��\\������'  ID=EMPNMH_3 HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		Edit=none sort=true</C>
									<C> Name='����'				  ID=SCR3			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>
									<C> Name='����'				  ID=AVG3			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>

									<C> Name='��\\������'	  ID=EMPNMH_4 HeadAlign=Center HeadBgColor=#B9D4DC Width=72		align=left		Edit=none	sort=true show=false</C>
									<C> Name='����'				  ID=SCR4			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true show=false</C>
									<C> Name='����'				  ID=AVG4			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true show=false</C>

									<G> Name='���' HeadAlign=Center HeadBgColor=#B9D4DC 
									<C> Name='����'         ID=SCRAVG		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=RIGHT		Edit=none sort=true</C>
									<C> Name='����'         ID=CORAVG		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=RIGHT		Edit=none sort=true</C>
									<C> Name='�μ���'       ID=DPTAVG		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=RIGHT		Edit=none sort=true</C>
									</G>
									<C> Name='����\\����'   ID=TOTAVG		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=RIGHT		dec=2	    sort=true  bgcolor='#F5F6CE'</C>
									<C> Name='����\\����'   ID=GOGAGB		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=CENTER	Edit=none sort=true  show=true</C>
									<C> Name='����\\���'   ID=GRADE		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=CENTER	sort=true bgcolor='#F5D0A9' </C>

									<C> Name='�⸻\\���'   ID=CORAVG_SUM		HeadAlign=Center HeadBgColor=#B9D4DC Width=48		align=RIGHT		Edit=none  sort=true  show=false</C>
									<C> Name='����'		      ID=TOTAVG_SUM		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=RIGHT		Edit=none  dec=2	sort=true  show=false</C>
									<C> Name='����\\����'   ID=GOGAGB_SUM		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=CENTER	Edit=none  sort=true  show=false</C>
								  <G> Name='�����������' HeadAlign=Center HeadBgColor=#B9D4DC 
 										<C> Name='������'   ID=GRADE2		    HeadAlign=Center HeadBgColor=#B9D4DC Width=58		align=CENTER	sort=true  bgcolor='#F7BE81'</C>
									  <C> Name='��ǥ�̻�' ID=GRADE3		    HeadAlign=Center HeadBgColor=#B9D4DC Width=74		align=CENTER	sort=true  bgcolor='#FAAC58'</C>
									</G>
								
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
        </tr>
      </table>
    </td>
  </tr>


 <tr>
		<td colspan=2 height="24">��ȸ�Ǽ� : <label id="lbl_search"></label></td>
 </tr>	

 <tr>
		<td colspan=2 > <P>
		                 &nbsp;&nbsp;* ��&nbsp;&nbsp;&nbsp;&nbsp;�� : ������� ������ ���� ������ ������Ʈ��. ( �μ��� ����� �����ϸ� �������(80%) + �μ��� ��� �ջ� ������ ������ ) <BR>
										 &nbsp;&nbsp;* ��޻��� : �������� �������� ���� ��� ������.(������ �� ��ǥ�̻� ������������� ���� ������� ������)<BR> 
		                 &nbsp;&nbsp;* ���� �� ��� ���� ��ư�� ������, ����� ���� �� ���� �����ϸ� �˴ϴ�.<BR>
		                 &nbsp;&nbsp;* �������, ������ �� ��ǥ�̻� ������������� ���� ���� �Ŀ��� ���� ��ư���� �����ϸ� ���� �˴ϴ�.<BR>
										 &nbsp;&nbsp;* ��, ���� ������ ��� �ٽ� ���� �� ��޻��� ��ư�� ������ ���� ���� ����� ������ ���� �ȵ˴ϴ�.
		</td>
 </tr>	

</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>