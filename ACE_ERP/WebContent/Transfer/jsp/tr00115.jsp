<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ�  OMS
+ ���α׷� ID	: TR00115.HTML
+ �� �� �� ��	: �ڱ�������û
+ �� �� �� ��	: ���̼�
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ �������� :
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


 
<!-- /******************************************************************************
	Description : DataSet ����
******************************************************************************/ --> 
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcds_dump classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>  

<OBJECT id=gcDs3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcDs5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>  

<OBJECT id=gcDs_etc0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name='SyncLoad'              value='true'>  
</OBJECT>

<OBJECT id=gcDs_etc3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_samp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc12 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc15 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc16 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_0etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_1etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_2etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_3etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDs_4etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcDsrpt1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>
 
<OBJECT id=gcds_project classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT>

<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad     value="true">  
</OBJECT>
<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ� ������-->
</OBJECT>

<OBJECT id="gcTr02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ���-->
</OBJECT>

<OBJECT id="gcTr03" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ���������-->
</OBJECT>

<OBJECT id="gcTr04" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ���������-->
</OBJECT>

<OBJECT id="gcTr05" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ� ������ �ӽ�-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>
	
	get_cookdata();
	
	var lb_boolean1 =  false ; 
	var PopWinValue = null ; 
	var strURL = null ; 
	var ls_start = false  ;  
	
	var ls_insert = true ;
	var ls_Carinsert =  true ; 
	var lf_function  = null ; 
	var pack_no =  0 ; 
	var saveing = false ; 
	var grow = 0;
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";
	
	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			window.status="�Ϸ�";

		}
	
</SCRIPT>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs_etc1) ; 
	LINE_PART.Index = 0 ; 
</script>


<script language=JavaScript for=gcDs_etc3 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc3) ; 

</script>

<script language=JavaScript for=CARGO_TYPE event=OnSelChange()>
	 var ls_type = CARGO_TYPE.ValueOfIndex("MINORCD", CARGO_TYPE.index);


	if( ls_type =="0002")	{
		LD_CAR.index = LD_CAR.IndexOfColumn("MINORCD", "KRDRS");

		LD_CAR.Enable = false;
		LDCARGONM.value = "";
		LDCARGONM.disabled = true;
		tab_car.style.display = "none";
		ln_DispGrid(strim(ls_type));

		
	} else	if( ls_type =="0003" ||  ls_type == "0004" )	{
		LD_CAR.index = LD_CAR.IndexOfColumn("MINORCD", "KRDRS");
		cargoType.style.display= ""; 
		LD_CAR.Enable = true;
		LDCARGONM.disabled = false;
		tab_car.style.display = "";
		ln_DispGrid(strim(ls_type));

		tr_att_file.style.display = "";

	} else {
		cargoType.style.display= "none"; 
		LD_CAR.Enable = true;
		LDCARGONM.disabled = false;
		tab_car.style.display = "";
		ln_DispGrid(strim(ls_type));
		
	}
</script> 

<script language=JavaScript for=LINE_PART event=OnSelChange()>

</script>



<script language=JavaScript for=gcDs_etc6 event=OnLoadCompleted(rowcnt)>

	ARTC_UNIT.Index = 0 ;
</script> 

<script language=JavaScript for=gcDs_etc7 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc7) ; 

</script>

<script language=JavaScript for=gcDs_etc8 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc8) ;  

</script>

<script language=JavaScript for=gcDs_etc9 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc9) ;  

</script>

<script language=JavaScript for=gcDs_etc10 event=OnLoadCompleted(rowcnt)>
	AddChoiceProjct(gcDs_etc10) ; 
	PROJECT.index = 0; 
</script>

<script language=JavaScript for=gcDs_etc11 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc11) ;  
	LD_CAR.index = 0; 
</script>

<script language=JavaScript for=gcDs_etc12 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc12) ;  
	OFF_CAR.index = 0; 
</script>

<script language=JavaScript for=gcDs_etc5 event=OnLoadCompleted(rowcnt)>

</script>
<script language=JavaScript for=CUST_CD event=OnKillFocus()>  
	CheckCustCd() ; //�ŷ�ó �ڵ� 
</script>

<script language=JavaScript for=gcTr01 event=OnSuccess()> 

</script>

<script language=JavaScript for=gcTr03 event=OnSuccess()> 
	show_detail('2');	
</script>

<script language=JavaScript for=gcTr05 event=OnSuccess()> 

	if (confirm("�Է��� �Ϸ�Ǿ����ϴ�.\n\n�ֹ��� ��� �Է��Ͻðڽ��ϱ� ?")) {
		gcDs4.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s2?NOH=Y&gstr1=" + gs_ordno ; 
		gcDs4.Reset();

	} else 	window.location.href="../../Transfer/jsp/tr00101.jsp";
</script>

<script language=JavaScript for=gcDs1 event=OnLoadCompleted(rowcnt)>
	if(ls_start == true ) { first_setting() ;  }
	else{ Match_master() ; } 
</script>

<script language=JavaScript for=gcds_data event=OnLoadCompleted(row)>
	if (gcds_data.namevalue(row,"PARM2")=="Y") alert(gcds_data.namevalue(row,"PARM3")+"�� ���� ������ �ֽ��ϴ�.");
	else ExceltoDataSet();
</script> 

<script language=JavaScript for=gcds_data event=OnLoadError()>
	alert("÷���Ͻ÷��� �ֹ��� ��ǰ������ ������ �ֽ��ϴ�.");
</script> 

<script language=JavaScript for=gcds_dump event=OnLoadCompleted(rowcnt)>
	PutUnitCode() ; 
</script> 

<script language=JavaScript for= LD_CAR event=OnSearchFail()>
	alert("�������� �ٽ� �����Ͻʽÿ� ") ; 
	LD_CAR.index = 0 ; 
</script>
<script language=JavaScript for= OFF_CAR event=OnSearchFail()>
	alert("�������� �ٽ� �����Ͻʽÿ� ") ; 
	OFF_CAR.index = 0 ; 
</script>

<script language=JavaScript for= OFF_CAR event=OnKillFocus()>
	if(OFF_CAR.index != 0)
	{var rtnVal = OFF_CAR.ShowSearchCol(); }  
</script>

<script language=JavaScript for= LD_CAR event=OnKillFocus()>
	if(LD_CAR.index != 0)
	{var rtnVal = LD_CAR.ShowSearchCol(); }  
</script>

<script language=JavaScript for=ARTC_CNT event=OnKillFocus()> 
		getPrice() ; 
</script>

<script language=JavaScript for=gcTr02 event=OnSuccess()>
	if (gn_ShowStep2()){
		gcds_chk.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLdCarGoods_4?gstr1="+gs_ordno+"&gstr2="+gcDs4.countrow;
		gcds_chk.Reset();
	}

	gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_sd1?NOH=Y&gstr1=" +gs_ordno;
	gcDs2.Reset();
</script>

<script language=JavaScript for= PUNIT_CNT event=OnKillFocus()>
	calPKGCnt();
</script>

<script language=JavaScript for= PUNIT_WGHT event=OnKillFocus()>
	calPKGCnt();
</script>

<script language=JavaScript for= PKG_LNGTH event=OnKillFocus()>
	get_cbm();
</script>

<script language=JavaScript for= PKG_HEIGHT event=OnKillFocus()>
	get_cbm();
</script>

<script language=JavaScript for= PKG_WIDTH event=OnKillFocus()>
	get_cbm();
</script>

<script language=JavaScript for=gcDs2 event=OnRowPosChanged(row)>
	if (gcDs2.countrow<1) return;

	if(saveing == false ){ 

		ls_insert = false ; 
	}
</script> 

<script language=JavaScript for=gcDs2 event=OnColumnChanged(row,colid)>
	
	if (colid == "PKG_LNGTH" || colid == "PKG_HEIGHT" || colid == "PKG_WIDTH" ) {
		gcDs2.NameValue(row,"PKG_CBM") = gcDs2.NameValue(row,"PKG_LNGTH") * gcDs2.NameValue(row,"PKG_HEIGHT") * gcDs2.NameValue(row,"PKG_WIDTH") / 1000000;
	}

	if (colid == "ARTC_CNT" || colid == "PUNIT_CNT") {
		if (gcDs2.NameValue(row,"ARTC_CNT")=="0") gcDs2.NameValue(row,"PKG_CNT") = 0;
		else if (gcDs2.NameValue(row,"PUNIT_CNT")=="0") gcDs2.NameValue(row,"PKG_CNT") = 0;
		else gcDs2.NameValue(row,"PKG_CNT") = gcDs2.NameValue(row,"ARTC_CNT") / gcDs2.NameValue(row,"PUNIT_CNT");
	}

	if (colid == "PKG_CNT" || colid == "PKG_CBM") {
		gcDs2.NameValue(row,"PKG_CBM_T") = gcDs2.NameValue(row,"PKG_CNT") * gcDs2.NameValue(row,"PKG_CBM");
	}

	if (colid == "PUNIT_WGHT" || colid == "PKG_CBM") {
		gcDs2.NameValue(row,"PUNIT_WGHT_T") = gcDs2.NameValue(row,"PUNIT_WGHT") * gcDs2.NameValue(row,"PKG_CNT");
	}
</script>

<script language=JavaScript for=gcDs4 event=OnRowPosChanged(row)>
	if(gcDs4.CountRow> 0 && saveing == false ){ 
		carLdCargoLoad() ;

		ls_Carinsert = false ; 
	}
</script>

<script language=javascript for=gcDs4 event=OnColumnChanged(row,colid)>
	if (colid=="LD_CARGO"){
		if (gcDs4.namevalue(row,colid)=="ZZZZZ") alert("������ ������ ���� ����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
	} if (colid=="OFF_CARGO"){
		if (gcDs4.namevalue(row,colid)=="ZZZZZ") alert("������ ������ ���� ����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
	}
</script>

<script language=JavaScript for=gcDs3 event=OnColumnPosChanged(row,colid)> 
	CalLoadCarCargo(row,colid) ; 
</script>

<script language=JavaScript for=gcGR3 event=OnExit(row,colid,olddata)> 
	CalLoadCarCargo(row,colid) ; 
</script>

<script language=JavaScript for=gcGR3 event=OnClick(row,colid)>
	if (row<1) return;
	CalLoadCarCargo(row,colid) ; 
	CheckTrueSameAs(row,colid);
</script>

<script language="javascript" for=gcGR3 event=OnHeadCheckClick(Col,Colid,bCheck)>
	if (bCheck=="1"){
		for (var i=1; i<=gcDs3.countrow; i++) {
			gcDs3.namevalue(i,"CHECK") = "";
			CheckTrueSameAs(i,"CHECK");
		}
	} else {
		for (var i=1; i<=gcDs3.countrow; i++) {
			gcDs3.namevalue(i,"CHECK") = "T";
			CheckTrueSameAs(i,"CHECK");
		}
	}
</script>

<script language=JavaScript for=gcGR3 event=OnUserColor(row,eventid)> 
	 return gcGR3ColorChange(row,eventid); 
</script>

<script language=JavaScript for=OpenFile event=OnClick()>
	FILENAME.value = OpenFile.value;
	var tmaifiles = OpenFile.FileInfo("size");
	
	if (tmaifiles >= 1048577){
			alert("÷�������� 1M Byte(1048576 Byte)���ϸ� �����մϴ�.\n\n���� ������ ������ ũ��� "+tmaifiles+" Byte�Դϴ�");
			FILENAME.value = "" ; 
		}
	else
	{ 
	}
</script>

<script language=JavaScript for=gcDsrpt1 event=OnLoadCompleted(rowcnt)>
	var goods_cnt =  null ; 
	for (i=1;i<=gcDs2.CountRow; i++){
			if( i == 1){
				goods_cnt = gcDs2.NameValue(i,"ARTC_NM") + ':' + gcDs2.NameValue(i,"ARTC_CNT") ; }
			else{
				goods_cnt = goods_cnt + ',' +  gcDs2.NameValue(i,"ARTC_NM") + ':' + gcDs2.NameValue(i,"ARTC_CNT") ; }
		}

	gcDsrpt1.NameValue(1,"GOODS")  = goods_cnt ; 
	gcRpt01.Preview(); 
</script>



<script language=JavaScript for=ETD_DT event=OnKillFocus()> 
	var va1 = strim(ETD_DT.text);
	if (va1.length<1) return;
	else EdtDateCheck() ; 
</script>

<script language=JavaScript for=PROJECT event=onkeydown(kcode,scode)>
if (kcode==13){
	gcds_project.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e1?NOH=Y&gstr1=" + PROJECT.Text  ; 
	gcds_project.Reset() ; 

	if (gcds_project.countrow>1) {
		call_project(PROJECT.Text);
	}
}
</script>

<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value) != "") {
		txt_file.value = gcip_file.value;
		var tfile = txt_file.value;
		var tfilename = ln_Divide(txt_file.value, "\\");
		gcDs1.namevalue(1,"ATT_FILE") = tfile; 
	}
</script>

<script language=javascript for=gcGR1 event=onpopup(row,colid,data)>
	var result ="";

	strURL = "hs_code.html";
	PopupOpenDialog(850,490) ;	

	if(PopWinValue != null ){

	}
</script>

<script language="javascript" for=gcGR1 event=OnRButtonDown(Row,Colid,xpos,ypos)>
	var ls_type = CARGO_TYPE.ValueOfIndex("MINORCD", CARGO_TYPE.index);
	if (ls_type=="0003"||ls_type=="0004") return;

	if (Row<2) return;
	
	gcGR1.MenuData="������ǰ�� ��������^1^1^1,������ǰ�� �������� ���^1^2^1";
	grow = Row;
	gcGR1.TrackPopupMenu(xpos, ypos);
 </script>

<script language="javascript"  for=gcGR1 event=OnCommand(code,str)>
	if (code=="1"){
		if (gcDs2.namevalue(grow-1,"MIX_OTHERS")=="T"){
			gcDs2.namevalue(grow,"MIX_OTHERS") = "T";
			gcDs2.namevalue(grow,"SAMEAS") = gcDs2.namevalue(grow-1,"SAMEAS");
			gcDs2.namevalue(grow,"PUNIT_CNT") = 0;
			gcDs2.namevalue(grow,"PUNIT_WGHT") = 0;
			gcDs2.namevalue(grow,"PKG_LNGTH") = 0;
			gcDs2.namevalue(grow,"PKG_WIDTH") = 0;
			gcDs2.namevalue(grow,"PKG_HEIGHT") = 0;
			gcDs2.namevalue(grow,"PKG_CBM") = 0;
		} else {
			gcDs2.namevalue(grow-1,"MIX_OTHERS") = "T";
			gcDs2.namevalue(grow-1,"SAMEAS") = gcDs2.namevalue(grow-1,"ORDER_SEQ");
			gcDs2.namevalue(grow,"MIX_OTHERS") = "T";
			gcDs2.namevalue(grow,"SAMEAS") = gcDs2.namevalue(grow-1,"ORDER_SEQ");
			gcDs2.namevalue(grow,"PUNIT_CNT") = 0;
			gcDs2.namevalue(grow,"PUNIT_WGHT") = 0;
			gcDs2.namevalue(grow,"PKG_LNGTH") = 0;
			gcDs2.namevalue(grow,"PKG_WIDTH") = 0;
			gcDs2.namevalue(grow,"PKG_HEIGHT") = 0;
			gcDs2.namevalue(grow,"PKG_CBM") = 0;
		}
	} else {
		if (gcDs2.namevalue(grow,"MIX_OTHERS") == "") return;

		gcDs2.namevalue(grow,"MIX_OTHERS") = "";
		gcDs2.namevalue(grow,"SAMEAS") = "";

		var t2 = gcDs2.namevalue(grow-2,"MIX_OTHERS");
		var v2 = gcDs2.namevalue(grow-2,"SAMEAS");
		var v1 = gcDs2.namevalue(grow-1,"SAMEAS");

		if (t2=="T" && v2==v1){
		} else {
			gcDs2.namevalue(grow-1,"MIX_OTHERS") = "";
			gcDs2.namevalue(grow-1,"SAMEAS") = "";
		}
	}
</script>

<script language=javascript for=gcGR1 event=CanColumnPosChange(row,colid)>
	if (colid=="ARTC_NM"){
		if (gcDs2.sysStatus(row)=="3"){
			var prodnm = gcDs2.OrgNameValue(row,colid);

			for (var i=1; i<=gcDs4.countrow; i++){
				var cprodnm = gcDs4.NameValue(i,"CTN_STDRD");
				cprodnm = strim(cprodnm);
				cprodnm = gn_Replace(cprodnm," ");
				prodnm = gn_Replace(prodnm," ");

				if (prodnm==cprodnm) {
					alert("��ǥǰ���� �����ϽǼ� �����ϴ�.");
					gcDs2.undo(row);
					break;
				}
			}
		}
	}
</script>

<script language=javascript for=gcGR1 event=OnKillFocus()>
	var row = gcDs2.rowposition;
	var colid = "ARTC_NM";

	if (gcDs2.sysStatus(row)=="3"){
		var prodnm = gcDs2.OrgNameValue(row,colid);
		var rprodnm = gcDs2.NameValue(row,colid);

		if (prodnm != rprodnm){
			for (var i=1; i<=gcDs4.countrow; i++){
				var cprodnm = gcDs4.NameValue(i,"CTN_STDRD");
				cprodnm = strim(cprodnm);
				cprodnm = gn_Replace(cprodnm," ");
				prodnm = gn_Replace(prodnm," ");

				if (prodnm==cprodnm) {
					alert("��ǥǰ���� �����ϽǼ� �����ϴ�.");
					gcDs2.undo(row);
					break;
				}
			}
		}
	}

</script>

<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY onLoad="Start();">

<div id=all style="display:block">
	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px"  > 
		<tr> 
			<td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<input id="order_no" name="order_no" type="text" class="txt11" style='width:230;position:relative;left:0px;top:-3px:' style='display:none'>
				<img id=btn_cancel src="../../../Common/img/com_b_cancle.gif" style="cursor:hand" onclick="ln_Cancel()">
				<img id=btn_regdata src="../../../Common/img/btn/btn_reg.gif" style="cursor:hand" onclick="ln_RegData()"> 
				<img src="../../../Common/img/btn/btn_cargomark.gif" style="cursor:hand" onclick="PRINT_CARGOMARK()"> 
				<img src="../../../Common/img/btn/btn_stssave.gif" id=img_sts style="cursor:hand;display:none" onclick="ln_StsSave()"> 
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				<div id=step1 style=display:block>
					<table cellpadding=0 cellspacing=0 border=0 style="width:100%">
						<tr>
							<td>
								<table cellpadding="0" cellspacing="0" border="0" style="width:874px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;">
									<tr> 
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width=100><font color="#ff0000">*</font>&nbsp;<B>Project</B></td>
										<td class="tab11_left"> 
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=LINE_PART  style='position:relative;left:8px;top:1px;width:220px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="1">
												<param name=ComboDataID			value="gcDs_etc1">  
												<param name=CBDataColumns		value="MINORCD,MINORNM">
												<param name=SearchColumn		value="MINORNM">
												<param name=SortColumn			value="MINORCD"> 
												<param name=Sort						value="True">
												<param name=ListExprFormat	value="MINORNM^1^170">
												<param name=BindColumn			value="MINORCD">
												<param name=Index						value="0">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2">
											</OBJECT>
											<%=HDConstant.COMMENT_END%> 
										</td> 
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width=100><font color="#ff0000">*</font>&nbsp;������ �δ�</td>
										<td class="tab13_left" > 
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=PROJECT  style='position:relative;left:8px;top:2px;width:320px;height:300' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="2">
												<param name=ComboDataID			value="gcDs_etc10">  
												<param name=CBDataColumns		value="CDCODE,CDNAM">
												<param name=SearchColumn		value="CDNAM">
												<param name=SortColumn			value="CDCODE"> 
												<param name=Sort						value="True">
												<param name=ListExprFormat	value="CDNAM^0^250">								
												<param name=BindColumn			value="CDCODE">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2"> 
											</OBJECT>
											<%=HDConstant.COMMENT_END%> 
											<img src="../../../Common/img/btn_find.gif" id=btn_call_project style="position:relative;left:10px;top:0px;cursor:hand" onclick="call_project(''); " tabindex="3">											
										</td> 
									</tr>
									<tr >
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;��������</td>
										 <td colspan=3 class="tab13_left"> 
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=ETD_DT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="6"
												style="position:relative;left:8px;top:5px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;">
													<param name=Alignment			value="0">
													<param name=Border	      value="false">
													<param name=Format	      value="YYYY/MM/DD">
													<param name=PromptChar	  value="_">
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
											<img id=btn_Edtdt src="../../../Common/img/btn_calendar.gif" style="position:relative;left:8px;top:1px;cursor:hand" onclick="__GetCallCalendar2('ETD_DT', 'Text','ETD_DT1','Text' );" tabindex="7">
											&nbsp;&nbsp;(
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=ETD_DT1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="8"
											style="position:relative; left:0px;top:5px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;">
												<param name=Alignment			value="0">
												<param name=Border	      value="false">
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
											</OBJECT>
											<%=HDConstant.COMMENT_END%>&nbsp;:&nbsp;
											<input id="TX1" name="TX1" type="text" class="txt11_none1" style='width:55;position:relative;left:-4px;top:1px' value="�԰�����" readonly> ) 
										</td>
										<td colspan=2 class="tab13_left">&nbsp;</td>
										
									</tr>
									<tr style="display:none">
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee">������</td>
										<td class="tab13_left" colspan=3>
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=LD_CAR  style='position:relative;left:8px;top:3px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  tabindex="9">
												<param name=ComboDataID			value=gcDs_etc11>  
												<param name=CBDataColumns		value="MINORCD,MINORNM">
												<param name=SearchColumn		value="MINORNM">
												<param name=SortColumn			value="MINORCD"> 
												<param name=Sort						value="True">
												<param name=ListExprFormat	value="MINORNM^1^100"> 
												<param name=BindColumn			value="MINORCD">
												<param name=Index						value="0">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2">
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
											<input type="text" class="txt11" id=LDCARGONM style="position:relative;left:10px;top:-3px;width:600px;" tabindex="10">
										</td>
									</tr>
									<tr style="display:none">
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee">������</td>
										<td class="tab13_left" colspan=3>
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=OFF_CAR  style='position:relative;left:8px;top:3px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100 tabindex="11" >
												<param name=ComboDataID			value=gcDs_etc12>  
												<param name=CBDataColumns		value="MINORCD,MINORNM">
												<param name=SearchColumn		value="MINORNM">
												<param name=SortColumn			value="MINORCD"> 
												<param name=Sort						value="True">
												<param name=ListExprFormat	value="MINORNM^1^100"> 
												<param name=BindColumn			value="MINORCD">
												<param name=Index						value="0">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2">
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
											<input type="text" class="txt11" id=OFFCARGONM style="position:relative;left:10px;top:-3px;width:600px;" tabindex="12">
										</td> 
									</tr>
									<tr id=tr_att_file style="display:none">
										<td style="height:25px;text-align:center;border:0 solid #777777;border-top-width:1px;border-right-width:1px" bgcolor="#eeeeee"><font id=ft_fname>÷�ξ൵</font></td> 
										<td colspan=3 style="border:0 solid #777777;border-top-width:1px;" >
											<input type="hidden" id=txt_file name="txt_file" readonly style="position:relative;left:6px;width:100px">
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
												style="position:relative;left:8px;top:0px;width:100; height:20;" tabindex="14">
													<param name="Text"		value="����÷���ϱ�">
													<param name="Enable"  value="true">
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
											<img src="../../../Common/img/btn/com_b_filedown.gif" style="position:relative;left:12px;top:2px;cursor:hand" onclick="ln_FileDown()" tabindex="15">
										</td>
									</tr>
									<tr id=tr_att_info style="display:none">
										<td class="tab12_left" style="height:25px;width:100px;text-align:center;border:0 solid #777777;border-top-width:1px;border-right-width:1px;" bgcolor="#eeeeee">������������</td>
										<td colspan=3 style="border:0 solid #777777;border-top-width:1px;">
											&nbsp;����/���� :<input type="text" id=FAC_PERSON class="txt11" style="width:100px;">
											&nbsp;&nbsp;��ȭ��ȣ/�ڵ��� :<input type="text" id=FAC_PRSTEL class="txt11" style="width:100px;">
										</td>
									</tr>
									<tr> 
										<td style="height:25px;text-align:center;border:0 solid #777777;border-top-width:0px;border-right-width:1px" bgcolor="#eeeeee">���</td> 
										<td colspan=3 style="border:0 solid #777777;border-top-width:0px;"><textarea name="REMARK" id="REMARK" style="position:relative;left:8px;width:700;height:40;border:0;font-size:9pt;overflow:auto;ime-mode:active" tabindex="13"></textarea></td>
									</tr>
								</table>
							</td> 
						</tr> 
						<tr><td colspan=2 height=10px>&nbsp;</td></tr>
						<tr>
							<td>
								<table border=0 cellpadding=0 cellspacing=0 id=tab_car>
							
									<tr><td colspan=2 height=10px>&nbsp;</td></tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table cellpadding=0 cellspacing=0 border=0 style="width:100%">
									<tr>
										<td height=30px width=70px><img src="../../../Common/img/head_10.gif" style="position:relative;left:0px;top:0px"></td> 
										<td valign="bottom">
											<table height="30" border="0" cellpadding="0" cellspacing="0" style="position:relative;top:-3px;left:0;width:798px;" background="../../../Common/img/under_bar5.gif"> 
												<tr>
													<td align=right>&nbsp;(�������� �����ԽŰ���(�����ԽŰ���) �����ۼ���û<input type="checkbox" id=pl_cl name=pl_cl class="chk1" value="N" style='position:relative;left:0px;top:2px' onclick="pl_ci_add();" tabindex="16">)</td>
												</tr>
											</table>
										</td>
									</tr>
								</table> 
							</td>
						</tr>
						<tr>
							<td align=left>
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;">
									<tr> 
										<td class="tab11_left" bgcolor="#eeeeee" style="width:100;text-align:center" rowspan=3>��û��ü</td>
										<td class="tab11_left" bgcolor="#eeeeee" style="width:100;text-align:center"><font color="#ff0000">*</font>&nbsp;����ڸ�</td>
										<td class="tab13_left" align='left' colspan=3 >
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=CUST_CD  class="txt11_right" style='position:relative;left:8px;top:2px;height:15;width:90;display:none' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="17"> 
												<param name=Alignment		value=1>  
												<param name=Numeric			value="false"> 
												<param name=border			value=false> 
												<param name=SelectAll		value=true>
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
											<input id="CUST_CDNM" name="CUST_CDNM" type="text" class="txt11" style='position:relative;left:8px;top:-2px;width:230;' onkeydown="if(event.keyCode == '13') nameCheck_cust('CUST_CDNM');" onkeyup="if (same.checked) SHIPPER_NM.value = this.value;" tabindex="18"> 
											<img src="../../../Common/img/btn_find.gif" id=btn_vender style="position:relative;left:8px;top:2px;cursor:hand" onclick="if (LINE_PART.Enable==true) call_vender('CUST_CD','Text');" tabindex="19">
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=CUST_ID  class="txt11_right" style='position:relative;left:12px;top:2px;height:15;width:90;' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F onkeyup="if (same.checked) SHIPPER_ID.text = this.text;" tabindex="20" > 
												<param name=Alignment		value=1>
												<param name=Format			value="000-00-00000"> 
												<param name=PromptChar	value="">
												<param name=border			value=false> 
												<param name=SelectAll		value=true>
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
										</td>
									</tr>
									<tr>
										<td class="tab11_left" bgcolor="#eeeeee" style="text-align:center"><font color="#ff0000">*</font>&nbsp;����ڸ�</td>
										<td class="tab13_left" colspan=3>
										<input id="CUST_PRSN" name="CUST_PRSN" type="text" class="txt11" style='width:100;position:relative;left:8px;top:1px;ime-mode:active' onkeyup="if (same.checked) SHIPPERPS.value = this.value;" tabindex="21"></td>
									</tr>
									<tr>
										<td class="tab11_left" bgcolor="#eeeeee" style="text-align:center"><font color="#ff0000">*</font>&nbsp;��ȭ��ȣ</td>
										<td class="tab11_left" style="width:300px;">
										<input id="CUST_TELNO" name="CUST_TELNO" type="text" class="txt11" style='width:120;position:relative;left:8px;top:1px' onkeyup="if (same.checked) SHIPPERHPTEL.value = this.value;" tabindex="22"></td>
										<td class="tab11_left" bgcolor="#eeeeee" style="width:100px;text-align:center">�ڵ��� ��ȣ</td>
										<td class="tab13_left">
										<input id="CUST_HPNO" name="CUST_HPNO" type="text" class="txt11" style='width:120;position:relative;left:8px;top:1px' onkeyup="if (same.checked) SHIPPERHP.value = this.value;" tabindex="23">
										</td>
									</tr>
									<tr> 
										<td class="tab12_left" bgcolor="#eeeeee" style="width:100;text-align:center" rowspan=3>&nbsp;��ȭ��<BR>&nbsp;(���� ����<input type="checkbox" id=same name=same class="chk1" value="C" style='position:relative;left:0px;top:2px' onclick="Shipper_Same();" tabindex="24">)</td>
										<td class="tab11_left" bgcolor="#eeeeee" style="width:100;text-align:center"><font color="#ff0000">*</font>&nbsp;����ڸ�</td>
										<td class="tab13_left" colspan=3 >
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=SHIPPER  class="txt11_right" style='width:90;position:relative;left:8px;top:2px;height:15;display:none' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="25"> 
												<param name=Alignment		value=1>
												<param name=Numeric			value="false"> 
												<param name=border			value=false> 
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
											<input id="SHIPPER_NM" name="SHIPPER_NM" type="text" class="txt11" style='width:230;position:relative;left:8px;top:-2px' onkeydown="if(event.keyCode == '13'){nameCheck_cust('SHIPPER_NM');}" tabindex="26"> 
											<img id=btn_vender src="../../../Common/img/btn_find.gif" style="position:relative;left:8px;top:2px;cursor:hand" onclick="if (LINE_PART.Enable==true) call_vender('SHIPPER','Text');" tabindex="27"> 
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=SHIPPER_ID  class="txt11_right" style='width:90;position:relative;left:12px;top:2px;height:15;' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="28"> 
												<param name=Alignment		value=1>
												<param name=Numeric			value="false"> 
												<param name=Format			value="000-00-00000"> 
												<param name=PromptChar	value="">
												<param name=Format			value=""> 
												<param name=border			value=false> 
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
										</td>
									</tr>
									<tr>
										<td class="tab11_left" bgcolor="#eeeeee" style="text-align:center"><font color="#ff0000">*</font>&nbsp;����ڸ�</td>
										<td class="tab13_left" align='left'  colspan=3><input id="SHIPPERPS" name="SHIPPERPS" type="text" class="txt11" style='width:100;position:relative;left:8px;top:1px;ime-mode:active' tabindex="29"></td>
									</tr>
									<tr>
										<td class="tab12_left" bgcolor="#eeeeee" style="text-align:center"><font color="#ff0000">*</font>&nbsp;��ȭ��ȣ</td>
										<td class="tab12_left">
										<input id="SHIPPERTEL" name="SHIPPERTEL" type="text" class="txt11" style='width:120;position:relative;left:8px;top:1px' tabindex="30"></td>
										<td class="tab12_left" bgcolor="#eeeeee" style="width:100;text-align:center">�ڵ��� ��ȣ</td>
										<td><input id="SHIPPERHP" name="SHIPPERHP" type="text" class="txt11" style='width:120;position:relative;left:8px;top:1px'tabindex="31" ></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr><td height=20px></td></tr> 
						<tr>
							<td style="width:100%">
								<div id=pl_ci_add_div style="display:none">
									<table cellpadding=0 cellspacing=0 border=0 style="position:relative;top:0px;">	
										<tr>
											<td height=30px align=left width=70px><img src="../../../Common/img/head_4.gif" style="position:relative;left:0px;top:0px;"></td> 
											<td valign="bottom">
												<table height="30" border="0" cellpadding="0" cellspacing="0" style="position:relative;top:-3px;width:800px;left:0" background="../img/under_bar5.gif"> 
													<tr>
														<td align=right></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan=2>
												<table  cellpadding="0" cellspacing="0" border="0" style="width:100%;font-size:9pt;background-color:#ffffff;border:1 solid #708090"  style="position:relative;left:0px;top:0px;"> 
													<tr> 
														<td class=tab11_left bgcolor="#eeeeee">&nbsp;������ 
														(&nbsp;<input id='PL_SHIPPER'  name="PL_SHIPPER" type="text"   size=16 maxlength=50  value="" style="position:relative;left:0px;top:0px;" class=txt11 tabindex="32">
																<img src="../../../Common/img/btn_find.gif" style="position:relative;left:0px;top:3px;cursor:hand" tabindex="33" id=btn_calshipper onclick="Call_SHIPPER();">&nbsp;)
														</td>
														<td class=tab13_left bgcolor="#eeeeee">&nbsp;������(&nbsp;<input id='PL_CST'  name="PL_CST" type="text"   size=16 maxlength=50  value="" style="position:relative;left:0px;top:0px;" class=txt11 tabindex="34">
																<img src="../../../Common/img/btn_find.gif" style="position:relative;left:0px;top:3px;cursor:hand" tabindex="35" id=btn_calcsi onclick="Call_PLCST();" >&nbsp;)
														</td> 
													</tr> 
													<tr>
														<td class=tab11_left width=423px > 
															<input id="PL_SHPPRNM" name="PL_SHPPRNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_SHIPADDR" name="PL_SHIPADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_SHPADDR2" name="PL_SHPADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_SHPADDR3" name="PL_SHPADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_SHIPTEL" name="PL_SHIPTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' > 
														</td>
														<td  class=tab13_left> 
															<input id="PL_CSTMNM" name="PL_CSTMNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSTADDR" name="PL_CSTADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSTADDR2" name="PL_CSTADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSTADDR3" name="PL_CSTADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSTTEL" name="PL_CSTTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' >
														</td>
													</tr>
													<tr> 
														<td class=tab11_left bgcolor="#eeeeee">&nbsp;����ó (&nbsp;<input id="PL_BRKR"  name="PL_BRKR" type="text"   size=16 maxlength=50  value="" style="position:relative;left:0px;top:0px;" class=txt11 tabindex="36">
																<img src="../../../Common/img/btn_find.gif" style="position:relative;left:0px;top:3px;cursor:hand" tabindex="37" id=btn_calbrkr onclick ="Call_BRKR();">&nbsp; )
														</td>
														<td class=tab13_left bgcolor="#eeeeee" style="width:100">&nbsp;��ǥ��ǰ</td>
													</tr>
													<tr>
														<td class=tab11_left>  
															<input id="PL_BRKRNM" name="PL_BRKRNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_BRKADDR" name="PL_BRKADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_BRKADDR2" name="PL_BRKADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_BRKADDR3" name="PL_BRKADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_BRKTEL" name="PL_BRKTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' >
														</td>
														<td class=tab13_left><textarea id="RPST_GOODS" name="RPST_GOODS" rows=10 cols=30 style='border:1;width:440;position:relative;left:0px;top:0px;height:80;font-size:9pt;overflow:auto' tabindex="38"></textarea></td>
													</tr> 
													<tr> 
														<td class=tab11_left bgcolor="#eeeeee"  >&nbsp;��Ź�� 
														(&nbsp;<input id='PL_CSN'  name="PL_CSN" type="text"  size=16 maxlength=50  value="" style="position:relative;left:0px;top:0px;" class=txt11 tabindex="39">
																<img src="../../../Common/img/btn_find.gif" style="position:relative;left:0px;top:3px;cursor:hand" tabindex="40" id=btn_calcs onclick="Call_CS();">&nbsp;)
														</td>
														<td class=tab13_left bgcolor="#eeeeee">&nbsp;</td> 
													</tr>
													<tr>
														<td class=tab12_left>
															<input id="PL_CSNNM" name="PL_CSNNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSNADDR" name="PL_CSNADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSNADDR2" name="PL_CSNADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSNADDR3" name="PL_CSNADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSNTEL" name="PL_CSNTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' >
														</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr><td height=20px></td></tr> 
									</table>
								</div>
							</td>
						</tr>
					</table>
					<tr>
			<td colspan=2>
					<table cellpadding=0 cellspacing=0 border=0>
						<tr>
							<td height=30px align=left width=70px>
								<img src="../../../Common/img/head_1.gif" style="position:relative;left:0px;top:2px;">
							</td>
							<td valign="bottom">
								<table height="30" border="0" cellpadding="1" cellspacing="0" style="position:relative;top:-3px;width:799px;left:0" background="../img/under_bar5.gif"> 
									<tr>
										<td align=right> 
											<img src="../../../Common/img/btn/b_write.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="New_Insert();" alt="��ǰ������ �ۼ��մϴ�.">
											<img src="../../../Common/img/btn/b_save.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="Detail_Save();" alt="�Է��Ͻ� ��ǰ������ �����մϴ�."> 
											<img src="../../../Common/img/btn/b_delete.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="Detail_Delete()" alt="�����Ͻ� ��ǰ������ �����մϴ�."> 
											<img src="../../../Common/img/com_b_fileupload.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ExcelLoad();" alt="���������� ���ε� �մϴ�.">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<table border=0 cellpadding=0 cellspacing=0 style="width:100%">

									<tr>
										<td colspan=2>
											<%=HDConstant.COMMENT_START%>
											<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:870;height:201px;border:1 solid #777777;display:block" viewastext>
												<PARAM NAME="DataID"			VALUE="gcDs2">
												<PARAM NAME="TitleHeight" VALUE="22">
												<PARAM NAME="RowHeight"		VALUE="20">
												<PARAM NAME="BorderStyle" VALUE="0">
												<PARAM NAME="Fillarea"		VALUE="true">
												<PARAM NAME="Editable"		VALUE="true">
												<param name="AllShowEdit" VALUE="true">
												<PARAM NAME="ViewSummary"	VALUE="1">
												<PARAM NAME="Format"			VALUE="
													<F> Name='No.'			ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center edit=none</F> 
													<F> Name='������'		ID=LDCARGO  	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center,	 editstyle=LookUp Data='gcDs_etc8:MINORCD:MINORNM'</F>
													<F> Name='������'		ID=OFFCARGO		HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center,	 editstyle=LookUp Data='gcDs_etc9:MINORCD:MINORNM'</F>
													<F> Name='������'		ID=ENG_ARTCNM	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=left, show=false</F>
													<F> Name='HS code'	ID=HSCODE  		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center, editStyle=Popup, show=false</F>
													<F> Name='HS Name'	ID=HSCODENM 	HeadAlign=Center HeadBgColor=#eeeeee Width=137  align=left, show=false </F> 
													<F> Name='ǰ��'			ID=ARTC_NM  	HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=left, sumText='�հ�'</F>
													<C> Name='�԰�'			ID=STN_SZNM		HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left</C>
													<C> Name='����'			ID=ARTC_UNIT	HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left,	 editstyle=LookUp Data='gcDs_etc6:MINORCD:MINORNM'</C>
													<C> Name='����'			ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right, sumText=@sum</C> 
													<C> Name='�ܰ�(��)'	ID=UNIT_PRICE HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=0</C>
													<C> Name='�ݾ�(��)'	ID=PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, sumText=@sum</C> 
													<C> Name='ȭ��'			ID=CUR_CODE		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center</C>
													<C> Name='�ܰ�(��ȭ)'	ID=FR_UNTRPRCE	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=0</C>
													<C> Name='�ݾ�(��ȭ)'	ID=FR_PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, sumText=@sum</C> 
													<G> Name='��������' HeadBgColor=#eeeeee
														<C> Name='����'	ID=PUNIT_CNT  	HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0, sumText=@sum</C>   
														<C> Name='�߷�(KG)'	ID=PUNIT_WGHT  	HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=right, dec=0, sumText=@sum</C>
														<C> Name='����(CM)'	ID=PKG_LNGTH		HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> 
														<C> Name='��(CM)'		ID=PKG_WIDTH		HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> 
														<C> Name='����(CM)'	ID=PKG_HEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> 
														<C> Name='����(CBM)'ID=PKG_CBM			HeadAlign=Center HeadBgColor=#eeeeee Width=120	align=right, dec=3</C> 
													</G>
													<C> Name='�Ѽ���'					ID=PKG_CNT	 			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right,	dec=2, sumText=@sum</C>   
													<C> Name='�ѿ���(CBM)'		ID=PKG_CBM_T 			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right,	dec=3, sumText=@sum</C>   
													<C> Name='���߷�(KG)'			ID=PUNIT_WGHT_T		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right,	dec=1, sumText=@sum</C>   
													<C> Name='�������߰�����' ID=LDCARGONM			HeadAlign=Center HeadBgColor=#eeeeee Width=128  align=left </C> <C> Name='�������߰�����' ID=OFFCARGONM			HeadAlign=Center HeadBgColor=#eeeeee Width=128  align=left </C> <C> Name='��������'				ID=MIX_OTHERS  		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, show=false </C>   
													<C> Name='��������;No'		ID=SAMEAS  				HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center</C> 
												">
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
										</td>
									</tr>
								</table>
					<table cellpadding=0 cellspacing=0 border=0 style="width:100%">

					</table> 
				</div>
			</td>
		</tr>
		
<!-- ***************************************************************************************************** -->
<!-- 				Detail                                                                           -->
<!-- ***************************************************************************************************** -->
		<tr>
			<td colspan=2>
				<div id=step2 style=display:none>
					<table cellpadding=0 cellspacing=0 border=0>
						<tr>
							<td height=30px align=left width=70px>
								<img src="../img/head_1.gif" style="position:relative;left:0px;top:2px;">
							</td>
							<td valign="bottom">
								<table height="30" border="0" cellpadding="1" cellspacing="0" style="position:relative;top:-3px;width:799px;left:0" background="../img/under_bar5.gif"> 
								</table>
							</td>
						</tr>
						<tr>
							<td colspan=2> 
								<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:200px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;display:none" >
									<tr>
										<td id=tddetail2 align=left colspan=2>
											<table cellpadding="0" cellspacing="0" border="0" style=" width:100%;height:20px;font-size:9pt;background-color:#ffffff;border:0 solid #708090"> 
												<tr>
													
													<td class="tab11_left" bgcolor="#A7BDD8"   colspan=6>
														&nbsp;�������庰(������ �Է��� ǰ��� ������ ������ ��� üũ <input type="checkbox" id=MIX_OTHERS name=MIX_OTHERS class="chk1" value="C" style='position:relative;left:-1px;top:2px' onclick="enable_packinfo();" tabindex="54">)
													</td> 
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee">ǰ��</td>
													<td class="tab11_left"  colspan=3  align=left  id=kor_name>
													&nbsp;<input id="ARTC_NM" name="ARTC_NM" type="text" class="txt11" style='width:125;position:relative;left:0px;top:0px;border:1 solid #a9c9b9' tabindex="38">
													  <input id="ARTC_CD" name="ARTC_CD" type="text" class="txt11" style='width:0;position:relative;left:0px;top:0px;border:1 solid #930122' tabindex="36">
													</td>   
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>����</td>
													<td class="tab11_left" colspan=2>&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=PUNIT_CNT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="55"> 
														<param name=Alignment				value=2>
														<param name=Numeric					value=true>
														<param name=IsComma					value=true>
														<param name=MaxLength				value=10>
														<param name=MaxDecimalPlace	value=2>
														<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%> 
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='50px' colspan=1>�߷�</td>
													<td class="tab11_left" colspan=2>&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=PUNIT_WGHT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="57"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=1>
															<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%> 
													</td>
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>����ǰ��</td>
													<td id=eng_name colspan=3 class="tab11_left" >&nbsp;<input id="ARTC_ENM" name="ARTC_ENM" type="text" class="txt11" style='width:125;position:relative;left:0px;top:0px' tabindex="39"></td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px' colspan=1>����(cm)</td>
													<td class="tab11_left">&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=PKG_LNGTH  class="txt11_right" style='width:60;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="58"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=0>
															<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%>&nbsp;
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" colspan=1>����(cm)</td>
													<td class="tab11_left">&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=PKG_HEIGHT  class="txt11_right" style='width:60;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="60"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=0>
															<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%>&nbsp;
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" colspan=1>��(cm)</td>
													<td class="tab11_left">&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=PKG_WIDTH  class="txt11_right" style='width:60;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="59"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=0>
															<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%>&nbsp;
													</td>
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='80px'>�� ��</td>
													<td class="tab11_left" colspan=3>&nbsp;<input id="STN_SZNM" name="STN_SZNM" type="text" class="txt11" style='width:275;position:relative;left:0px;top:0px' tabindex="48" ></td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px' colspan=1>����</td>
													<td class="tab11_left" colspan=2 >&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=PKG_CBM  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F Height=24 width=120 tabindex="61"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=0>
															<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%>  
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>�Ѽ���</td>
													<td class="tab11_left" colspan=2>&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=PKG_CNT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="61"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%> 
													</td>
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>����</td>
													<td class="tab11_left" >&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=ARTC_CNT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="50"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%>
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>����</td>
													<td class="tab11_left" > &nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=ARTC_UNIT  style='border:0;position:relative;left:0px;top:2px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  tabindex="51">
															<param name=ComboDataID			value=gcDs_etc6>  
															<param name=CBDataColumns		value="MINORCD,MINORNM">
															<param name=SearchColumn		value=MINORNM>
															<param name=SortColumn			value="MINORCD"> 
															<param name=Sort						value=True>
															<param name=ListExprFormat	value="MINORNM^1^100"> 
															<param name=BindColumn			value="MINORCD">
															<param name=Index						value=0>
															<param name=InheritColor		value="true"> 
															<param name=ComboStyle			value=2>
														</OBJECT>
														<%=HDConstant.COMMENT_END%>
													</td>											
												  </tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='80px'>�ݾ�</td>
													<td class="tab11_left" >&nbsp;
														<%=HDConstant.COMMENT_START%>
														<OBJECT id=PRICE  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="53"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT>
														<%=HDConstant.COMMENT_END%> 
													</td>  
												</tr>  
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr> 
					</table>
				</div>
			</td>
		</tr>
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcDs1>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=ETD_DT           Ctrl=ETD_DT					Param=Text</C> 
		<C>Col=ETD_DT1          Ctrl=ETD_DT1				Param=Text</C> 
		<C>Col=LINE_PART        Ctrl=LINE_PART			Param=BindColVal</C> 
		<C>Col=PROJECT          Ctrl=PROJECT				Param=BindColVal</C>  
		<C>Col=CUST_CD          Ctrl=CUST_CD        Param=Text</C>
		<C>Col=CUST_PRSN        Ctrl=CUST_PRSN      Param=value</C> 
		<C>Col=CUST_TELNO       Ctrl=CUST_TELNO     Param=value</C> 
		<C>Col=CUST_HPNO        Ctrl=CUST_HPNO      Param=value</C> 
		<C>Col=SHIPPERHP        Ctrl=SHIPPERHP      Param=value</C>  
		<C>Col=CARGO_TYPE       Ctrl=CARGO_TYPE     Param=BindColVal</C> 
		 
		<C>Col=DIV_IO						Ctrl=DIV_IO         Param=BindColVal</C>  
		<C>Col=DLVL_DATE        Ctrl=DLVL_DATE      Param=Text</C> 
		<C>Col=SHIPPER          Ctrl=SHIPPER        Param=Text</C>
		<C>Col=SHIPPERPS        Ctrl=SHIPPERPS      Param=value</C> 
		<C>Col=SHIPPERTEL       Ctrl=SHIPPERTEL     Param=value</C> 
		<C>Col=FEE_IN           Ctrl=FEE_IN					Param=BindColVal</C> 
		<C>Col=FEE_OUT          Ctrl=FEE_OUT				Param=BindColVal</C> 
		<C>Col=GORDER_NO        Ctrl=GORDER_NO      Param=value</C> 
		<C>Col=RQST_NO          Ctrl=RQST_NO        Param=value</C> 
		<C>Col=PL_TYPE          Ctrl=PL_TYPE        Param=value</C> 
		<C>Col=PL_SHIPPER       Ctrl=PL_SHIPPER     Param=value</C> 
		<C>Col=PL_SHPPRNM       Ctrl=PL_SHPPRNM     Param=value</C> 
		<C>Col=PL_SHIPADDR      Ctrl=PL_SHIPADDR    Param=value</C> 
		<C>Col=PL_SHIPTEL       Ctrl=PL_SHIPTEL     Param=value</C> 
		<C>Col=PL_CSTM          Ctrl=PL_CSTM        Param=value</C> 
		<C>Col=PL_CSTMNM        Ctrl=PL_CSTMNM      Param=value</C> 
		<C>Col=PL_CSTADDR       Ctrl=PL_CSTADDR     Param=value</C> 
		<C>Col=PL_CSTTEL				Ctrl=PL_CSTTEL      Param=value</C> 
		<C>Col=PL_BRKR          Ctrl=PL_BRKR        Param=value</C> 
		<C>Col=PL_BRKRNM        Ctrl=PL_BRKRNM      Param=value</C>
		<C>Col=PL_BRKADDR       Ctrl=PL_BRKADDR     Param=value</C> 
		<C>Col=PL_BRKTEL        Ctrl=PL_BRKTEL      Param=value</C> 
		<C>Col=RPST_GOODS       Ctrl=RPST_GOODS     Param=value</C> 
		<C>Col=TOTAL_CNT        Ctrl=TOTAL_CNT      Param=value</C> 
		<C>Col=TOTAL_UNIT       Ctrl=TOTAL_UNIT     Param=value</C> 
		<C>Col=TOTAL_WGHT       Ctrl=TOTAL_WGHT     Param=value</C> 
		<C>Col=TOTAL_CBM        Ctrl=TOTAL_CBM      Param=value</C> 
		<C>Col=CANCLE_DATE      Ctrl=CANCLE_DATE    Param=Text</C> 
		<C>Col=REMARK           Ctrl=REMARK					Param=value</C> 
		<C>Col=PRICETYPE        Ctrl=PRICETYPE      Param=value</C> 
		<C>Col=SETTLETYPE       Ctrl=SETTLETYPE     Param=value</C> 
		<C>Col=LC_NO            Ctrl=LC_NO					Param=value</C> 
		<C>Col=LC_DATE          Ctrl=LC_DATE				Param=value</C> 
		<C>Col=LC_BANK          Ctrl=LC_BANK				Param=value</C> 
		<C>Col=EXPRT_NO         Ctrl=EXPRT_NO				Param=value</C> 
		<C>Col=EXPRT_DATE       Ctrl=EXPRT_DATE     Param=value</C> 
		<C>Col=LDCARGONM        Ctrl=LDCARGONM			Param=value</C> 
		<C>Col=OFFCARGONM       Ctrl=OFFCARGONM			Param=value</C> 
		<C>Col=CONSIGNEE        Ctrl=CONSIGNEE			Param=value</C> 
		<C>Col=LDCARGO          Ctrl=LD_CAR					Param=BindColVal</C>
		<C>Col=OFFCARGO         Ctrl=OFF_CAR				Param=BindColVal</C>
		<C>Col=PL_SHPADDR2      Ctrl=PL_SHPADDR2    Param=value</C> 
		<C>Col=PL_SHPADDR3			Ctrl=PL_SHPADDR3    Param=value</C> 
		<C>Col=PL_CSTADDR2			Ctrl=PL_CSTADDR2    Param=value</C> 
		<C>Col=PL_CSTADDR3			Ctrl=PL_CSTADDR3    Param=value</C> 
		<C>Col=PL_BRKADDR2			Ctrl=PL_BRKADDR2    Param=value</C> 
		<C>Col=PL_BRKADDR3			Ctrl=PL_BRKADDR3    Param=value</C>
		<C>Col=PL_CSN           Ctrl=PL_CSN         Param=value</C>
		<C>Col=PL_CSNNM         Ctrl=PL_CSNNM       Param=value</C>
		<C>Col=PL_CSNTEL        Ctrl=PL_CSNTEL      Param=value</C>
		<C>Col=PL_CSNADDR       Ctrl=PL_CSNADDR     Param=value</C>
		<C>Col=PL_CSNADDR2      Ctrl=PL_CSNADDR2    Param=value</C>
		<C>Col=PL_CSNADDR3      Ctrl=PL_CSNADDR3    Param=value</C>
		<C>Col=FAC_PERSON				Ctrl=FAC_PERSON			Param=value</C>
		<C>Col=FAC_PRSTEL	      Ctrl=FAC_PRSTEL			Param=value</C>
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcRpt01 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"	value="gcDsrpt1">
	<param name="DetailDataID"	value="gcDsrpt1">		
	<param name="PaperSize"			value="A4">		
	<param name="LandScape"     value="false"> 
	<param name="Format"				value="
		<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=516 ,face='Arial' ,size=10 ,penwidth=1
			<T>id='CARGO MARK' ,left=3 ,top=219 ,right=2000 ,bottom=381 ,face='Times New Roman' ,size=35 ,bold=true ,underline=true ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=1731 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=194 ,top=44 ,right=1856 ,bottom=456 ,border=true</X>
			<C>id='Project', left=222, top=75, right=1831, bottom=416, face='Arial', size=21, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REMARK', left=753, top=1444, right=1778, bottom=1691, align='left', face='Arial', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
			<T>id='��   ��   ��  : ' ,left=200 ,top=637 ,right=741 ,bottom=741 ,align='left' ,face='������' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���־�ü��   : ' ,left=197 ,top=912 ,right=738 ,bottom=1016 ,align='left' ,face='������' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='ǰ         ��  : ' ,left=197 ,top=1187 ,right=738 ,bottom=1291 ,align='left' ,face='������' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��         ��  : ' ,left=197 ,top=1325 ,right=738 ,bottom=1428 ,align='left' ,face='������' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��         ��  : ' ,left=197 ,top=1462 ,right=738 ,bottom=1566 ,align='left' ,face='������' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CONSIGNEE', left=753, top=784, right=1428, bottom=887, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ETD_DT', left=753, top=637, right=1428, bottom=741, align='left' ,mask='XXXX-XX-XX', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='��   ��   ��  : ' ,left=197 ,top=784 ,right=738 ,bottom=887 ,align='left' ,face='������' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='SHIPPER_NM', left=753, top=912, right=1428, bottom=1016, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='���޾�ü��   : ' ,left=197 ,top=1050 ,right=738 ,bottom=1153 ,align='left' ,face='������' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CUST_NM', left=753, top=1050, right=1428, bottom=1153, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ORDER_NO', left=753, top=491, right=1428, bottom=594, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='�� �� �� ȣ  : ' ,left=200 ,top=491 ,right=741 ,bottom=594 ,align='left' ,face='������' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='GOODS', left=753, top=1203, right=1775, bottom=1428, align='left', face='Arial', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true, Dec=0</C>
		</B>
		<B>id=Footer ,left=0 ,top=2395 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
			<I>id='Image' ,left=666 ,top=22 ,right=1244 ,bottom=269</I>
		</B>
	">
</OBJECT>
<%=HDConstant.COMMENT_END%>

</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>
