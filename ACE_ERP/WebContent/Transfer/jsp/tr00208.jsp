<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ� �����ֹ���ȸ
+ ���α׷� ID	: TR00208.HTML
+ �� �� �� ��	: �԰�����
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


<!-- /******************************************************************************
	Description : DataSet ����
******************************************************************************/ -->    
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad 	value="true">
</OBJECT>

<OBJECT id=gcDs_etc13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

 <!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ� ������-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>
	get_cookdata();

	var	lb_boolean1 =  false ; 
	var gs_ordno = null ; 
	var gs_seq = null ; 
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			Start();//����ȸ

			window.status="�Ϸ�";

		}
	/******************************************************************************
		Description :  START ��� 
	******************************************************************************/
	function Start(){

		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //
		gcDsgetdate.Reset() ;
	
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();

		gcDs_etc13.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0008";  //���� 
		gcDs_etc13.Reset(); 

		ENTER_DATE.Text = gs_date;	
		
		ETD_DATE.Text = gcDsgetdate.NameValue(1,"APP_DT1");

		
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function INWareHouse(row){	
	
		gs_ordno = gcDs2.NameValue(row,"ORDER_NO") ; 
		gs_seq = gcDs2.NameValue(row,"ORDER_SEQ") ; 

		gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsInWRHS?NOH=Y&gstr4="+gs_ordno + "&gstr5="+gs_seq ; 
		gcDs1.Reset() ; 
		
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function AddWRHS(){
		if( strim(ENTER_DATE.Text) == "") { 
			alert("�԰����ڸ� �Է��Ͻʽÿ� !!") ; 
	    return false ;  
		}

		gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsInWRHS?NOH=N"; 
		gcDs1.Reset() ; 

		var ls_check = null ;
		var ls_row = null ; 

		for(var cnt=1 ; cnt<=gcDs2.CountRow ;cnt++) {
			ls_check = gcDs2.NameValue(cnt,"CHECK") ;
			if( ls_check == "T"){

				gcDs1.AddRow() ; 	
				ls_row = gcDs1.RowPosition ; 
				gcDs1.NameValue(ls_row,"ORDER_NO")			= gcDs2.NameValue(cnt,"ORDER_NO") ; 
				gcDs1.NameValue(ls_row,"ORDER_SEQ")			= gcDs2.NameValue(cnt,"ORDER_SEQ") ; 
				gcDs1.NameValue(ls_row,"ARTC_NM")				= gcDs2.NameValue(cnt,"ARTC_NM") ;  
				gcDs1.NameValue(ls_row,"ARTC_CNT")			= gcDs2.NameValue(cnt,"ARTC_CNT") ; 
				gcDs1.NameValue(ls_row,"PKG_LNGTH")			= gcDs2.NameValue(cnt,"PKG_LNGTH") ; 
				gcDs1.NameValue(ls_row,"PKG_HEIGHT")		= gcDs2.NameValue(cnt,"PKG_HEIGHT") ; 
				gcDs1.NameValue(ls_row,"PKG_WIDTH")			= gcDs2.NameValue(cnt,"PKG_WIDTH") ; 
				gcDs1.NameValue(ls_row,"PUNIT_WEIGHT")	= gcDs2.NameValue(cnt,"PUNIT_WGHT") ;   
				gcDs1.NameValue(ls_row,"PKG_CNT")				= gcDs2.NameValue(cnt,"PKG_CNT") ;  
				gcDs1.NameValue(ls_row,"PKG_CBM")				= gcDs2.NameValue(cnt,"PKG_CBM") ;  
				gcDs1.NameValue(ls_row,"TOTAL_CBM")			= gcDs2.NameValue(cnt,"PKG_CNT") * gcDs2.NameValue(cnt,"PKG_CBM") ;  
				gcDs1.NameValue(ls_row,"TOTAL_WEIGHT")	= gcDs2.NameValue(cnt,"PKG_CNT") * gcDs2.NameValue(cnt,"PUNIT_WGHT") ;  
				gcDs1.NameValue(ls_row,"ENTER_DATE")		= ENTER_DATE.Text ;
				 
				gcDs1.NameValue(ls_row,"ENTER_NO") ='�ڵ��ο�' ;

				if(gcDs2.NameValue(cnt,"LINE_PART") =="0001") gcDs1.NameValue(ls_row,"WAREHOUSE") ='0001' ; 
				else gcDs1.NameValue(ls_row,"WAREHOUSE") ='0002' ;
			}
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function SAVEWRHS(){
		if (!gcDs1.isUpdated) return;

		if (confirm("�Է��Ͻ� �԰������� �����Ͻðڽ��ϱ� ? ")){
			for(var cnt =1 ;cnt<=gcDs1.countRow ;cnt++){
				gcDs1.NameValue(cnt,"GOODS_SEQ") = cnt ;  
			}
			
			gcTr01.KeyValue = "trInWRHS(I:USER=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trInWRHS";
			gcTr01.Parameters = "gstr1="+ENTER_DATE.Text ; //�ֹ���ȣ 
			gcTr01.post();
		}
	}

 	/******************************************************************************
		Description :
	******************************************************************************/
	function ln_Query(){
		imgAll.style.display = "";
		imgAllCancle.style.display = "none";

		var parm = "&gstr1=" + ORDER_NO.Text
						 + "&gstr2=" + ETD_DATE.Text
						 + "&gstr3=" + LINE_PART.BindColVal
						 + "&gstr4=I"
						 + "&gstr5=" + CUST_NM.value;
	
		gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderdetail_1?NOH=Y" +parm ; 
		gcDs2.Reset() ;
	}

	/******************************************************************************
		Description : �������� ����
	******************************************************************************/
	function CheckSameAS(row){
		var ls_value = gcDs2.NameValue(row,"CHECK") ; 

		if(gcDs2.NameValue(row,"MIX_OTHERS") =="T" ){ 

				var ls_no = gcDs2.NameValue(row,"SAMEAS") ; 
				var ls_orderno= gcDs2.NameValue(row,"ORDER_NO") ; 
				var ls_orderno1 = null ; 
				var ls_no1 = null ; 

				for(i=1;i<gcDs2.CountRow ; i++){  
					ls_orderno1 = gcDs2.NameValue(i,"ORDER_NO") ; 
					ls_no1 = gcDs2.NameValue(i,"SAMEAS") ; 

					if(ls_orderno == ls_orderno1 && ls_no == ls_no1 ) { // �ֹ���ȣ�� �����ȣ�� ������ ���
						if (ls_value=="T") gcDs2.NameValue( i ,"CHECK")  = "" ; 
						else gcDs2.NameValue( i ,"CHECK")  = "T" ; 
					}
				} 

		} else {
			if (ls_value=="T") gcDs2.NameValue( row ,"CHECK")  = "" ; 
			else gcDs2.NameValue( row ,"CHECK")  = "T" ; 
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function __SelectAll(){
		for(var i=1;i<=gcDs2.CountRow ; i++){
			gcDs2.NameValue(i,"CHECK") = "T" ;   
		}
		imgAllCancle.style.display = "" ; 
		imgAll.style.display = 'none' ; 
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function __SelectCancle() {
		for(var i=1;i<=gcDs2.CountRow ; i++){
			gcDs2.NameValue(i,"CHECK") = "" ;   
		}

		imgAllCancle.style.display = "none" ; 
		imgAll.style.display = '' ; 
	}
</SCRIPT> 

<script language=JavaScript for=gcDs2 event=OnLoadCompleted(rowcnt)>
	if(gcDs2.CountRow > 0 ) INWareHouse(1);
</script>

<script language=JavaScript for=Grid1 event=OnClick(row,colid)>  
   if ( colid == "CHECK") CheckSameAS(row);
   else INWareHouse(row) ;
</script>

<script language=JavaScript for=gcDs2 event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";

</script>

<script language=JavaScript for=gcDs2  event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";

	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language=javascript for=gcTr01 event=onSuccess()>
	gcDs1.Reset();
	gcDs2.Reset();
	alert("���������� �԰������� ����Ǿ����ϴ�.");
</script>

<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>

	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:20px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=75>��������</td>
						<td class="tab12_left" >&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ETD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:1px;cursor:hand" onclick="__GetCallCalendar('ETD_DATE', 'Text');"> 
						</td>
						<td class="tab12" style="text-align:center" bgcolor="#eeeeee"  width=75>�ֹ���ȣ</td>
						<td class="tab12_left">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag			value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=75>��ü��</td>
						<td class="tab12_left" >&nbsp;<input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:150;position:relative;left:0px;top:0px;ime-mode:active' ></td> 
						<td class="tab12" style="text-align:center" bgcolor="#eeeeee" width=75>Project</td>
						<td>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:0px;top:2px;height:220;width:160px;' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc1">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					</tr>
				</table> 
			</td>
		</tr> 
		<tr><td height=5></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:300px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td height=20 bgcolor=#FFFF99 ><B>&nbsp;&nbsp;�ֹ�����</B></td>
						<td height=20 bgcolor=#FFFF99 align=right>
							<img id=imgAll src="../../../Common/img/btn/btn_all.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="__SelectAll();" alt="�ֹ������� ��ü �����մϴ�.">&nbsp;
							<img id=imgAllCancle src="../../../Common/img/btn/btn_all_cancel.gif" style="position:relative;left:-6px;top:2px;display:none;cursor:hand" onclick="__SelectCancle();"  alt="������ �ֹ������� ����մϴ�.">
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:100%;height:242px;border:0 solid #777777;border-top-width:1px;border-bottom-width:1px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs2">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="ColSizing"  value="true">  
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<F> Name='��'					ID=CHECK			HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center, edit=none, EditStyle=CheckBox, cursor=hand</F>  
									<F> Name='�ֹ���ȣ'		ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center,	edit=none</F>  
									<F> Name='��ü��'			ID=VEND_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left,		edit=none</F> 
									<C> Name='No.'				ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center edit=none</C>   
									<C> Name='ǰ��'				ID=ARTC_NM  	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left   edit=none</C>  
									<C> Name='�԰�'				ID=STN_SZNM		HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left edit=none, show=false</C>
									<C> Name='����'				ID=ARTC_UNIT	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=left edit=none, editstyle=LookUp Data='gcDs_etc13:MINORCD:MINORNM'</C>
									<C> Name='����'				ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right,edit=none </C> 
									<G> Name='��������' HeadBgColor=#eeeeee
										<C> Name='����(CM)'		ID=PKG_LNGTH	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='��(CM)'			ID=PKG_WIDTH	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='����(CM)'		ID=PKG_HEIGHT HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='����(CBM)'	ID=PKG_CBM  	HeadAlign=Center HeadBgColor=#eeeeee Width=120	align=right </C>  
										<C> Name='�߷�(KG)'		ID=PUNIT_WGHT HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none </C> 
										<C> Name='�������'		ID=PKG_CNT	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none </C> 
									</G>
									<C> Name='�������'			ID=MIX_OTHERS HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none, show=false </C> 
									<C> Name='�������'			ID=SAMEAS			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none, show=false </C> 
									<C> Name='�ѿ���(CBM)'	ID=T_CBM			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right,edit=none  value={PKG_CBM * PKG_CNT } dec =2</C>
									<C> Name='���߷�(KG)'		ID=T_WEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right,edit=none  value={PUNIT_WGHT * PKG_CNT } dec =2</C>
								  <C> Name='����'					ID=CAR_NO   	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center edit=none  </C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr>
						<td height=20  ><B>&nbsp;&nbsp;�԰����� </B></td>
						<td align=right><font style="position:relative;top:-4px;left:-2px;">(�԰����� :</font>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ENTER_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:0px;cursor:hand" onclick="__GetCallCalendar('ENTER_DATE', 'Text');"><font style="position:relative;top:-4px;left:2px;">)</font>&nbsp;
							<img src="../../../Common/img/btn/b_write.gif"  style="position:relative; left:0px;top:2px;cursor:hand" onclick="AddWRHS();" alt="�԰������� �ۼ��մϴ�.">
							<img src="../../../Common/img/btn/b_save.gif" style="position:relative; left:0px;top:2px;cursor:hand" onclick="SAVEWRHS();" alt="�Է��� �԰������� �����մϴ�.">&nbsp;
						</td>
					</tr>
					<tr> 
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid2 style="width:100%;height:302px;border:1 solid #777777;border-bottom-width:0px;border-left-width:0px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="AllShowEdit" VALUE="true">
								<PARAM NAME="ColSizing"		VALUE="true">  
								<PARAM NAME="ViewSummary"	value="1">
								<PARAM NAME="Format"			VALUE="
									<F> Name='No.',				ID=SeralNo 				HeadAlign=Center HeadBgColor=#e8e8e8 Width=25		Align=Center	Value={ToString(RowCount-CurRow+1)}	</F>
									<C> Name='�԰�����'		ID=ENTER_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=70   align=left Mask='XXXX-XX-XX'</C>  
									<C> Name='�԰��ȣ'		ID=ENTER_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=90   align=center</C>  
									<C> Name='����â��'		ID=WAREHOUSE		HeadAlign=Center HeadBgColor=#eeeeee Width=115  align=center Value={Decode(WAREHOUSE,'0001','���ֹ�������','0002','����������')}</C> 
									<C> Name='SEQ'				ID=GOODS_SEQ		HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center</C>
									<C> Name='��ǰ��'			ID=ARTC_NM			HeadAlign=Center HeadBgColor=#eeeeee Width=115	align=left</C>
									<C> Name='����'				ID=ARTC_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	edit=none SumText=@sum</C> 
									<G> Name='��������' HeadBgColor=#eeeeee
										<C> Name='����(CM)'		ID=PKG_LNGTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='��(CM)'			ID=PKG_WIDTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='����(CM)'		ID=PKG_HEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='����(CBM)'	ID=PKG_CBM  			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right </C> 
										<C> Name='�߷�(KG)'		ID=PUNIT_WEIGHT 	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	edit=none  SumText=@sum</C> 
										<C> Name='�������'		ID=PKG_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	edit=none SumText=@sum</C> 
									</G>
									<C> Name='�ѿ���(CBM)'		ID=TOTAL_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=right,	edit=none </C>
									<C> Name='���߷�(KG)'		ID=TOTAL_WEIGHT 	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=right,	edit=none </C>
									 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					</tr> 
				</table> 

			</td>
		</tr>
		<tr><td style="height:10px;"></td></tr>
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

